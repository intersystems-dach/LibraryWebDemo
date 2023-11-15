<template>
  <div>
    <v-card class="text-center pa-1">
      <v-card-title class="justify-center display-1 mb-2">Welcome</v-card-title>
      <v-card-subtitle>Sign in to your account</v-card-subtitle>

      <!-- sign in form -->
      <v-card-text>
        <v-form ref="form" v-model="isFormValid" lazy-validation>
          <v-text-field
            v-model="email"
            :rules="[rules.required]"
            :validate-on-blur="false"
            :error="error"
            :label="$t('login.email')"
            name="email"
            outlined
            @keyup.enter="submit"
            @change="resetErrors"
          ></v-text-field>

          <v-text-field
            v-model="password"
            :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
            :rules="[rules.required]"
            :type="showPassword ? 'text' : 'password'"
            :error="error"
            :error-messages="errorMessages"
            :label="$t('login.password')"
            name="password"
            outlined
            @change="resetErrors"
            @keyup.enter="submit"
            @click:append="showPassword = !showPassword"
          ></v-text-field>

          <v-btn
            :loading="isLoading"
            :disabled="isSignInDisabled"
            block
            x-large
            color="primary"
            @click="submit"
          >{{ $t('login.button') }}</v-btn>

          <div class="caption font-weight-bold text-uppercase my-3">{{ $t('login.orsign') }}</div>

          <!-- external providers list -->
          <v-btn
            v-for="provider in providers"
            :key="provider.id"
            :loading="provider.isLoading"
            :disabled="isSignInDisabled"
            class="mb-2 primary lighten-2 primary--text text--darken-3"
            block
            x-large
            to="/"
            @click="signInProvider(provider)"
          >
            <v-icon small left>mdi-{{ provider.id }}</v-icon>
            {{ provider.label }}
          </v-btn>

          <div v-if="errorProvider" class="error--text">{{ errorProviderMessages }}</div>

          <div class="mt-5">
            <router-link to="/auth/forgot-password">
              {{ $t('login.forgot') }}
            </router-link>
          </div>
        </v-form>
      </v-card-text>
    </v-card>

    <div class="text-center mt-6">
      {{ $t('login.noaccount') }}
      <router-link to="/auth/signup" class="font-weight-bold">
        {{ $t('login.create') }}
      </router-link>
    </div>
  </div>
</template>

<script>
/*
|---------------------------------------------------------------------
| Sign In Page Component
|---------------------------------------------------------------------
|
| Sign in template for user authentication into the application
|
*/
import { loginRequest } from './authConfig'
import { mapGetters, mapState } from 'vuex'
import * as msal from '@azure/msal-browser'
export default {
  data() {
    return {
      // sign in buttons
      isLoading: false,
      isSignInDisabled: false,

      // form
      isFormValid: true,
      email: '',
      password: '',

      // form error
      error: false,
      errorMessages: '',

      errorProvider: false,
      errorProviderMessages: '',

      // show password field
      showPassword: false,

      providers: [{
        id: 'microsoft',
        label: 'Microsoft',
        isLoading: false
      },{
        id: 'google',
        label: 'Google',
        isLoading: false
      }, {
        id: 'facebook',
        label: 'Facebook',
        isLoading: false
      }],

      // input rules
      rules: {
        required: (value) => (value && Boolean(value)) || 'Required'
      }
    }
  },
  methods: {
    submit() {
      if (this.$refs.form.validate()) {
        this.isLoading = true
        this.isSignInDisabled = true
        this.signIn(this.email, this.password)
      }
    },
    signIn(email, password) {
      login()
    },
    async signInProvider(provider) {
      sessionStorage.removeItem('msal.interaction.status')
     
      await this.msalObj.loginPopup(loginRequest)
        .then(resp => {
          //console.log(resp)
          this.$store.userLoggedIn = resp
          console.log( this.$store.userLoggedIn);
          const usrnm = resp.account.username
          //console.log(usrnm);
          this.$store.userName = usrnm
          console.log(this.$store.userName);
          
          
          this.toast.show = true
          this.toast.color = 'success'
          this.toast.message = 'Sign in successful'
          this.toast.timeout = 3000
          this.$router.push({ path: '/dashboard/analytics' })

        }).catch(err => {
          
          this.toast.show = true
        this.toast.color = 'error '
        this.toast.message = 'Sign in cancelled'
        this.toast.timeout = 3000

        })
        
    },
    resetErrors() {
      this.error = false
      this.errorMessages = ''

      this.errorProvider = false
      this.errorProviderMessages = ''
    }
  },
  computed: {
    ...mapState('app', ['toast', 'userLoggedIn', 'msalObj','userName']),
    
  },
    
}
</script>
