const banner =
  "\n\
  ______ __  __  _____  _____ _____  _____ _____ _______ ______ _   _     \n\
 |  ____|  \\/  |/ ____|/ ____|  __ \\|_   _|  __ \\__   __|  ____| \\ | |\n\
 | |__  | \\  / | (___ | |    | |__) | | | | |__) | | |  | |__  |  \\| |  \n\
 |  __| | |\\/| |\\___ \\| |    |  _  /  | | |  ___/  | |  |  __| | . ` | \n\
 | |____| |  | |____) | |____| | \\ \\ _| |_| |      | |  | |____| |\\  | \n\
 |______|_|  |_|_____/_\\_____|_|_ \\_\\_____|_|___   |_|  |______|_| \\_|\n\
              |  ____/ __ \\|  __ \\ / ____|  ____|                       \n\
              | |__ | |  | | |__) | |  __| |__                            \n\
              |  __|| |  | |  _  /| | |_ |  __|                           \n\
              | |   | |__| | | \\ \\| |__| | |____                        \n\
              |_|    \\____/|_|  \\_\\\\_____|______|                     \n\
";
console.log("This page is powered by:\n", banner);

async function makePyJS(print, error) {
  const pyjs = await createModule({ print: print, error: print });

  await pyjs.bootstrap_from_empack_packed_environment(
    `./empack_env_meta.json` /* packages_json_url */,
    "." /* package_tarballs_root_url */,
    false /* verbose */
  );

  return pyjs;
}

const Module = {};

window.onload = async function(){
  const statusText = document.getElementById("load-status-text");
  statusText.textContent = "Downloading data";

  console.log("Download data ...");
  const pyjs = await makePyJS(print, print);

  statusText.textContent = "Initialising pyjs";
  try {
    await pyjs.init();
    statusText.textContent = "Done!";
  } catch (error) {
    console.error(error);
    statusText.textContent = "Failed to init pyjs: " + error;
  }
  console.log("...done");
};

