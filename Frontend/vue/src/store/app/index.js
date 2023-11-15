import configs from '../../configs'
import actions from './actions'
import mutations from './mutations'

import { msalConfig } from '@/pages/auth/authConfig'
import * as msal from '@azure/msal-browser'
const { product, time, theme, currencies } = configs

const { globalTheme, menuTheme, toolbarTheme, isToolbarDetached, isContentBoxed, isRTL } = theme
const { currency, availableCurrencies } = currencies

// state initial values
const state = {
  product,

  time,

  // currency
  currency,
  availableCurrencies,

  // themes and layout configurations
  globalTheme,
  menuTheme,
  toolbarTheme,
  isToolbarDetached,
  isContentBoxed,
  isRTL,

  // App.vue main toast
  toast: {
    show: false,
    color: 'black',
    message: '',
    timeout: 3000
  },
  msalObj: new msal.PublicClientApplication(msalConfig),
  userLoggedIn: {},
  userName: ''
}

export default {
  namespaced: true,
  state,
  actions,
  mutations
}
