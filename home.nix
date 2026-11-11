{ ... }:

let
  # Every versioned file in dotfiles/ is managed at its matching XDG config path.
  configFiles =
    let
      collect = dir:
        let entries = builtins.readDir dir;
        in builtins.concatLists (map (name:
          if entries.${name} == "directory" then
            map (child: "${name}/${child}") (collect (dir + "/${name}"))
          else if entries.${name} == "regular" then
            [ name ]
          else
            [ ]
        ) (builtins.attrNames entries));
    in collect ./dotfiles;
in
{
  home.username = "pavelzaikin";
  home.homeDirectory = "/home/pavelzaikin";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  xdg.enable = true;
  xdg.configFile = builtins.listToAttrs (map (path: {
    name = path;
    value = {
      source = ./dotfiles + "/${path}";
      # The repository copy is authoritative; matching live files were synced
      # into dotfiles/ before enabling these links.
      force = true;
    };
  }) configFiles);
}
