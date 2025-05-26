// main.js
const { app, Menu, Tray, shell } = require('electron');
const path = require('path');

let tray = null;

// Récupère les .bat depuis le dossier resources de l'exe
const getBatPath = (filename) =>
  path.join(process.resourcesPath, filename);

const pathGamesOn  = getBatPath('GamesOn.bat');
const pathGamesOff = getBatPath('GamesOff.bat');

app.whenReady().then(() => {
  tray = new Tray(path.join(__dirname, 'icon.png'));

  const contextMenu = Menu.buildFromTemplate([
    {
      label: '🎮 Activer Mode Gaming',
      click: () => shell.openPath(pathGamesOn)
    },
    {
      label: '💤 Désactiver Mode Gaming',
      click: () => shell.openPath(pathGamesOff)
    },
    { type: 'separator' },
    {
      label: '❌ Quitter',
      click: () => app.quit()
    }
  ]);

  tray.setToolTip('GamesMod - Mode Gaming');
  tray.setContextMenu(contextMenu);
});

app.on('window-all-closed', e => e.preventDefault());
