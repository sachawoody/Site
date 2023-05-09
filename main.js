const games = ["mastermind", "morpion", "echec", "pong", "demineur"];

const gridBestGames = document.querySelector(".grid-best-games");
function generaGridBestGames() {
  games.forEach((game) => {
    let name = game.charAt(0).toUpperCase() + game.slice(1); // mettre première lettre en maj
    // création de la carte
    let gameCard = document.createElement("div");
    gameCard.className = `card-game-${game}`;
    // ajout du titre et son contenu
    let gameTitle = document.createElement("h1");
    gameTitle.textContent = `${name}`; // ici je récupère le nom du jeu

    let imageGame = document.createElement("img");
    imageGame.src = `../img/games/${game}.png`; // je récupère dans mon dossier img/games le fichier en fonction du jeu

    // création du bouton pour jouer
    let buttonStartGame = document.createElement("button");
    buttonStartGame.className = `btn-start-${game}`;
    buttonStartGame.textContent = `Y JOUER`;

    // ajout des éléments à la carte
    gameCard.append(gameTitle);
    gameCard.append(imageGame);
    gameCard.append(buttonStartGame);

    gridBestGames.append(gameCard);
  });
}

// appelle de la fonction pour l'initialiser au chargement de la page
generaGridBestGames();
const startMastermind = document.querySelector(".btn-start-mastermind");
const startMorpion = document.querySelector(".btn-start-morpion");

// ------------ MORPION ------------

startMorpion.addEventListener("click", () => {
  console.log("Morpion launched!");
  // pour cacher la grid de jeu au lancement
  const blockBestGames = document.querySelector(".best-games");
  blockBestGames.setAttribute("style", "display: none;");
  generateBoardMorpion();
});

function generateBoardMorpion() {
  // génération du morpion ()
  // ajouter les fonctions pour le jeu (cf. JS/Morpion Sacha)
  const pageHeader = document.querySelector("body");
  console.log(pageHeader.appendChild);
  const sectionGame = document.createElement("section");
  sectionGame.className = "modal-game";
  pageHeader.insertBefore(sectionGame, document.querySelector("footer"));

  let articleBalise = document.createElement("article");
  articleBalise.className = `morpion`;
  sectionGame.append(articleBalise);
  for (let i = 0; i < 3; i++) {
    let divAlign = document.createElement("div");
    divAlign.className = `lign-${i + 1}`;
    articleBalise.append(divAlign);
    for (let j = 0; j < 3; j++) {
      let imgBalise = document.createElement("img");
      imgBalise.className = "free";
      imgBalise.src = `../img/games/morpion/transparent.png`;
      imgBalise.setAttribute("value", i * 3 + 1 + j);
      divAlign.append(imgBalise);
    }
  }
}

// ------------ MASTERMIND ------------

// initialisation de données nécessaires
// Il est prévu plus tard de passer par le session storage voir local storage pour enregistrer une partie en cours pour que je le joueur puisse la reprendre en chemin
var dataMastermind = {
  couleurs: ["black", "white", "yellow", "green", "blue", "red"],
  tourLeft: 12,
};

startMastermind.addEventListener("click", () => {
  // if (dataMastermind.combinaison) {
  //     console.log(`Une partie est déjà en cours. La combinaison en cours est la suivante : ${dataMastermind.combinaison}`)
  //     return
  // }
  const blockBestGames = document.querySelector(".best-games");
  blockBestGames.setAttribute("style", "display: none;");
  generateBoardMastermind();
});

function createGameMastermind() {
  if (dataMastermind.combinaison) {
    if (dataMastermind.tourLeft > 0) {
      return;
    } else {
      return console.log("Vous n'avez plus de coups, reset de la partie.");
    }
  }
  dataMastermind.combinaison = [];
  // création de la combinaison secrète
  const combinaisonToFind = generateCombinaisonMastermind();
  if (combinaisonToFind) {
    // console.log(document.querySelector(".modal-game").innerHTML)
    const guessInput = document.querySelector(".input-area");
    // création des évènements de drag n drop pour le mastermind
    guessInput.addEventListener("dragover", (e) => {
      e.preventDefault();
    });
    guessInput.addEventListener("drop", (e) => {
      e.preventDefault();

      if (guessInput.children.length == 4) {
        // si il y a déjà 4 couleurs dans l'input je block l'ajout de couleurs
        const boxUndrag = document.querySelectorAll(".color-box");
        boxUndrag.forEach((box) => {
          box.setAttribute("draggable", "false");
        });
      } else if (guessInput.children.length > 4) {
        console.log("ignore");
      } else {
        var color = e.dataTransfer.getData("text");
        var boxColor = document.createElement("div");
        boxColor.classList.add("color-box-dropped");
        boxColor.style.backgroundColor = color;
        guessInput.appendChild(boxColor);
        console.log(guessInput.children.length);
      }
    });
    startGameMastermind();
  } else
    return console.log(
      `Désolé, une erreur a survenue lors de la création de la partie.`
    );
}

function generateCombinaisonMastermind() {
  let choices = dataMastermind.couleurs;

  let toAdd = [];

  for (var i = 0; i < 4; i++) {
    // à partir de mon tableau de couleurs, j'en choisi 1 aléatoirement
    toAdd.push(choices[Math.floor(Math.random() * choices.length)]);
  }

  dataMastermind.combinaison = toAdd;

  return dataMastermind.combinaison;
}

function startGameMastermind() {
  const buttonSubmit = document.querySelector(".btn-submit-combinaison");
  buttonSubmit.addEventListener("click", () => {
    const toCheck = Array.from(
      document.querySelectorAll(".color-box-dropped")
    ).map((box) => box.style.backgroundColor);
    console.log(toCheck);
    // ici je fais une condition ternaire afin de ne pas prendre en compte le clique du bouton soumettre s'il n'y a pas 4 couleurs dans l'input
    toCheck.length < 4
      ? console.log("ne pas prendre en compte")
      : sendTourMastermind(toCheck); // condition ternaire
  });
}

function sendTourMastermind(toCompare) {
  compareCombinaisonMastermind(toCompare);
}

function compareCombinaisonMastermind(playerTry) {
  console.log("To find", dataMastermind.combinaison);
  console.log("Guess", playerTry);
  let result = {
    green: 0,
    white: 0,
    black: 0,
  };
  // ici j'initialise la répartition des pions bien placés, mal placés
  for (let i = 0; i < playerTry.length; i++) {
    if (dataMastermind.combinaison.includes(playerTry[i])) {
      if (dataMastermind.combinaison[i] == playerTry[i]) {
        // console.log(`La couleur ${playerTry[i]} se trouve bien dans la combinaison et en plus elle est bien placée.`)
        result.green += 1;
      } else {
        // console.log(`La couleur ${playerTry[i]} se trouve bien dans la combinaison.`)
        result.white += 1;
      }
    } else {
      // console.log(`La couleur ${playerTry[i]} n'est pas dans la combinaison.`)
      result.black += 1;
    }
  }
  console.log(playerTry);
  console.log(
    `Très bien, voici le résultat de la comparaison :\nIl y a ${result.green} pion(s) de la bonne couleur et bien placé(s).\nIl y a ${result.white} pion(s) de la bonne couleur mais mal placé(s).\nIl y a ${result.black} pion(s) de la mauvaise couleur.`
  );

  // je récupère les trous pour lesquels je vais devoir changer les couleurs (pour que je le joueur ait une vue sur l'avancé de ses essais)
  const lapAreaSubmitSwapOne = document.querySelector(
    `.area-box${dataMastermind.tourLeft}-color-box-area1`
  );
  const lapAreaSubmitSwapTwo = document.querySelector(
    `.area-box${dataMastermind.tourLeft}-color-box-area2`
  );
  const lapAreaSubmitSwapThree = document.querySelector(
    `.area-box${dataMastermind.tourLeft}-color-box-area3`
  );
  const lapAreaSubmitSwapFour = document.querySelector(
    `.area-box${dataMastermind.tourLeft}-color-box-area4`
  );

  // j'attribue à chaque trou la couleur correspondante

  lapAreaSubmitSwapOne.setAttribute(
    "style",
    `width: 40px;
        height: 40px;
        border-radius: 50px;
        display: inline-block;
        background-color: ${playerTry[0]};`
  );
  lapAreaSubmitSwapTwo.setAttribute(
    "style",
    `width: 40px;
        height: 40px;
        border-radius: 50px;
        display: inline-block;
        background-color: ${playerTry[1]};`
  );
  lapAreaSubmitSwapThree.setAttribute(
    "style",
    `width: 40px;
        height: 40px;
        border-radius: 50px;
        display: inline-block;
        background-color: ${playerTry[2]};`
  );
  lapAreaSubmitSwapFour.setAttribute(
    "style",
    `width: 40px;
        height: 40px;
        border-radius: 50px;
        display: inline-block;
        background-color: ${playerTry[3]};`
  );

  // const lapAreaResultSwap = document.querySelector(`.lap-area-result-${data.tourLeft}`)
  // lapAreaResultSwap.textContent = `${result.green} ${result.white} ${result.black}`

  // je fais de même pour la répartition des pions biens / mal placés
  const lapAreaResultSwapOne = document.querySelector(
    `.area-box${dataMastermind.tourLeft}-color-box-area1-result`
  );
  const lapAreaResultSwapTwo = document.querySelector(
    `.area-box${dataMastermind.tourLeft}-color-box-area2-result`
  );
  const lapAreaResultSwapThree = document.querySelector(
    `.area-box${dataMastermind.tourLeft}-color-box-area3-result`
  );

  // je diminue le nombre de tours restants de 1
  dataMastermind.tourLeft = dataMastermind.tourLeft - 1;

  // maintenant je fais la vérification de condition de victoire
  // si les 4 pions sont verts, alors le joueur gagne la partie
  if (result.green == 4) {
    lapAreaResultSwapOne.textContent = result.green;
    lapAreaResultSwapOne.setAttribute(
      "style",
      `width: 40px;
            height: 40px;
            border-radius: 50px;
            display: inline-block;
            background-color: green;
            `
    );

    lapAreaResultSwapTwo.textContent = result.white;
    lapAreaResultSwapTwo.setAttribute(
      "style",
      `width: 40px;
            height: 40px;
            border-radius: 50px;
            display: inline-block;
            background-color: white;
            `
    );

    lapAreaResultSwapThree.textContent = result.black;
    lapAreaResultSwapThree.setAttribute(
      "style",
      `width: 40px;
            height: 40px;
            border-radius: 50px;
            display: inline-block;
            background-color: black;
            `
    );

    // Faire une alerte car le joueur vient de gagner la partie !
    // alert(`La partie est désormais terminée, vous la remportez en ${12 - (dataMastermind.tourLeft)} tours !`)
    console.log("Partie finie, le joueur gagne la partie.");
    // j'appelle cette fonction pour ajouter le score au joueur
    ajouterScore(15 + dataMastermind.tourLeft * 2);

    alert(
      `La partie est désormais terminée, vous obtenez ${
        15 + dataMastermind.tourLeft * 2
      } points!\nFermeture du jeu dans 5 secondes.`
    );

    // je fais un setTimeout() afin de fermer la modal de jeu à la fin de la partie
    setTimeout(() => {
      document.location.href = "http://localhost/Site-master/views/index.php";
    }, 5000);
    return;
  }

  // si le joueur n'a plus d'essais, alors la partie se termine
  if (dataMastermind.tourLeft == 0) {
    lapAreaResultSwapOne.textContent = result.green;
    lapAreaResultSwapOne.setAttribute(
      "style",
      `width: 40px;
            height: 40px;
            border-radius: 50px;
            display: inline-block;
            background-color: green;
            `
    );

    lapAreaResultSwapTwo.textContent = result.white;
    lapAreaResultSwapTwo.setAttribute(
      "style",
      `width: 40px;
            height: 40px;
            border-radius: 50px;
            display: inline-block;
            background-color: white;
            `
    );

    lapAreaResultSwapThree.textContent = result.black;
    lapAreaResultSwapThree.setAttribute(
      "style",
      `width: 40px;
            height: 40px;
            border-radius: 50px;
            display: inline-block;
            background-color: black;
            `
    );
    // Faire une alert car le joueur vient de perdre la partie !
    // alert(`La partie est désormais terminée, vous avez perdu..`)

    console.log("Partie finie, le joueur perd la partie.");
    ajouterScore(15);
    alert(
      `La partie est désormais terminée, vous obtenez ${15} points!\nFermeture du jeu dans 5 secondes.`
    );
    setTimeout(() => {
      document.location.href = "http://localhost/Site-master/views/index.php";
    }, 5000);
    return;
  } else {
    // Dans ce cas là, le joueur continue de jouer
    // Modifier le text area pour indiquer le nombre de tours restant (au cas ou il ne sait pas lire l'affichage)
    const guessInput = document.querySelector(".input-area");
    guessInput.innerHTML = "";

    console.log(
      `Très bien, voici le résultat de la comparaison :\nIl y a ${result.green} pion(s) de la bonne couleur et bien placé(s).\nIl y a ${result.white} pion(s) de la bonne couleur mais mal placé(s).\nIl y a ${result.black} pion(s) de la mauvaise couleur.`
    );

    lapAreaResultSwapOne.textContent = result.green;
    lapAreaResultSwapOne.setAttribute(
      "style",
      `width: 40px;
            height: 40px;
            border-radius: 50px;
            display: inline-block;
            background-color: green;
            `
    );

    lapAreaResultSwapTwo.textContent = result.white;
    lapAreaResultSwapTwo.setAttribute(
      "style",
      `width: 40px;
            height: 40px;
            border-radius: 50px;
            display: inline-block;
            background-color: white;
            `
    );

    lapAreaResultSwapThree.textContent = result.black;
    lapAreaResultSwapThree.setAttribute(
      "style",
      `width: 40px;
            height: 40px;
            border-radius: 50px;
            display: inline-block;
            background-color: black;
            `
    );

    const boxUndrag = document.querySelectorAll(".color-box");
    boxUndrag.forEach((box) => {
      box.setAttribute("draggable", "true");
    });

    const lapsLeftAreaSwap = document.querySelector(".laps-left-area");
    lapsLeftAreaSwap.textContent = `Nb de tour restant(s) : ${dataMastermind.tourLeft}`;
    console.log(
      `Il te reste ${dataMastermind.tourLeft} coup(s) pour deviner la combinaison.`
    );
    return;
  }
}

function ajouterScore(score) {
  // création d'une requête XML afin d'envoyer des informations à mon php
  const req = new XMLHttpRequest();
  req.open("POST", "./ajouter_score.php", true);
  // méthode post ici car j'envoie des informations
  req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
  console.log("score to add :", score);
  req.send("score=" + score);
}

function generateBoardMastermind() {
  const pageHeader = document.querySelector("body");
  console.log(pageHeader.appendChild);
  const sectionGame = document.createElement("section");
  sectionGame.className = "modal-game";
  pageHeader.insertBefore(sectionGame, document.querySelector("footer"));

  const displayBoard = document.querySelector(".modal-game");
  const gameArticle = document.createElement("article");
  gameArticle.className = "mastermind";

  const gameTitle = document.createElement("p");
  gameTitle.textContent = "MASTERMIND";

  // const exitGame = document.createElement("buttton")
  // exitGame.className = "exit-game"
  // exitGame.textContent = "X"
  // exitGame.addEventListener("click", () => {
  //     console.log("exit game!")
  //     const blockBestGames = document.querySelector(".best-games")
  //     displayBoard.innerHTML = ""
  //     blockBestGames.setAttribute("style", "display: block;")
  // })

  const boardGame = document.createElement("div");
  boardGame.className = "board-game";

  for (let i = 0; i < 12; i++) {
    const lapArea = document.createElement("div");
    lapArea.className = `lap-area${i + 1}`;
    lapArea.classList.add("lap-area");

    const lapAreaSubmit = document.createElement("div");
    for (let j = 0; j < 4; j++) {
      const lapAreaSubmitTemp = document.createElement("div");
      lapAreaSubmitTemp.className = `area-box${i + 1}-color-box-area${j + 1}`;
      lapAreaSubmitTemp.classList.add("color-box-area");
      lapAreaSubmit.append(lapAreaSubmitTemp);
    }
    lapAreaSubmit.className = `lap-area-submit-${i + 1}`;

    const lapAreaResult = document.createElement("div");

    for (let j = 0; j < 3; j++) {
      const lapAreaResultTemp = document.createElement("div");
      lapAreaResultTemp.className = `area-box${i + 1}-color-box-area${
        j + 1
      }-result`;
      lapAreaResultTemp.classList.add("color-box-area");
      lapAreaResult.append(lapAreaResultTemp);
    }
    lapAreaResult.className = `lap-area-result-${i + 1}`;

    lapArea.append(lapAreaSubmit);
    lapArea.append(lapAreaResult);

    boardGame.append(lapArea);
  }

  const boardGuess = document.createElement("div");
  boardGuess.className = "board-guess";

  const pawnsBox = document.createElement("div");
  pawnsBox.className = "box-with-pawns";
  for (let color of dataMastermind.couleurs) {
    let boxColor = document.createElement("div");
    boxColor.classList.add("color-box");
    boxColor.style.backgroundColor = color;
    boxColor.setAttribute("draggable", "true");
    boxColor.addEventListener("dragstart", (e) => {
      e.dataTransfer.setData("text", color);
    });
    pawnsBox.appendChild(boxColor);
  }

  const submitCombinaison = document.createElement("div");
  submitCombinaison.className = "sumbit-combinaison";

  const submitCombinaisonTitle = document.createElement("p");
  // submitCombinaisonTitle.textContent = "Votre combinaison :"

  const inputCombinaison = document.createElement("div");
  inputCombinaison.className = "input-area";

  const fectchResultCombinaison = document.createElement("div");
  fectchResultCombinaison.className = "result-combinaison";

  const buttonSumbitCombinaison = document.createElement("button");
  buttonSumbitCombinaison.className = "btn-submit-combinaison";
  buttonSumbitCombinaison.textContent = "Soumettre la combinaison";

  const lapsLeftArea = document.createElement("p");
  lapsLeftArea.className = "laps-left-area";
  lapsLeftArea.textContent = "Nb de tour restant(s) :";

  displayBoard.append(gameArticle);

  gameArticle.append(gameTitle);
  // gameArticle.append(exitGame)
  gameArticle.append(boardGame);
  gameArticle.append(boardGuess);

  boardGuess.append(pawnsBox);
  boardGuess.append(submitCombinaison);
  boardGuess.append(fectchResultCombinaison);

  submitCombinaison.append(submitCombinaisonTitle);
  submitCombinaison.append(inputCombinaison);

  fectchResultCombinaison.append(buttonSumbitCombinaison);
  fectchResultCombinaison.append(lapsLeftArea);

  console.log("Board generated, now game can start !");
  createGameMastermind();
}
