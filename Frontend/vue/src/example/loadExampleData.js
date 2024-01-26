const exampleBooks = [
  { book: "Death of a Salesman", author: "Arthur Miller", genre: 2 },
  { book: "The Importance of Being Earnest", author: "Oscar Wilde", genre: 1 },
  { book: "Catch-22", author: "Joseph Heller", genre: 1 },
  { book: "The Fault in Our Stars", author: "John Green", genre: 2 },
  { book: "Good Omens", author: "Neil Gaiman, Terry Pratchett", genre: 1 },
  { book: "A Confederacy of Dunces", author: "John Kennedy Toole", genre: 1 },
  { book: "Macbeth", author: "William Shakespeare", genre: 2 },
  { book: "Three Men in a Boat", author: "Jerome K. Jerome", genre: 1 },
  { book: "Romeo and Juliet", author: "William Shakespeare", genre: 2 },
  { book: "Othello", author: "William Shakespeare", genre: 2 },
];

const examplePersons = [
  { friendName: "John Doe", friendNumber: "555-1234" },
  { friendName: "Jane Smith", friendNumber: "555-5678" },
  { friendName: "Bob Johnson", friendNumber: "555-9876" },
  { friendName: "Alice Williams", friendNumber: "555-4321" },
  { friendName: "Charlie Brown", friendNumber: "555-8765" },
  { friendName: "Eva Davis", friendNumber: "555-2109" },
  { friendName: "Frank Miller", friendNumber: "555-6543" },
  { friendName: "Grace Taylor", friendNumber: "555-1098" },
  { friendName: "Harry Wilson", friendNumber: "555-3456" },
  { friendName: "Ivy Anderson", friendNumber: "555-7890" },
];

export const loadExampleBooks = () => {
  const baseUrl = `${process.env.VUE_APP_IRIS_API_URL}/LibraryApi/addbook`;
  exampleBooks.forEach((book) => {
    fetch(
      baseUrl + `?title=${book.book}&author=${book.author}&genre=${book.genre}`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
      }
    )
      .then((response) => response.json())
      .then((data) => {
        console.log("Success:", data);
      })
      .catch((err) => {
        console.error("Error:", err);
      });
  });
};

export const loadExamplePersons = () => {
  const baseUrl = `${process.env.VUE_APP_IRIS_API_URL}/LibraryApi/addfriend`;
  examplePersons.forEach((person) => {
    fetch(baseUrl, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(person),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log("Success:", data);
      })
      .catch((err) => {
        console.error("Error:", err);
      });
  });
};
