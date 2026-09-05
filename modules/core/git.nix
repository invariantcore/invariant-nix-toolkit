{ config, lib, ... }:
with lib;
let
  cfg = config.invariant.core.git;
in {
  options.invariant.core.git = {
    enable = mkEnableOption "Git, Delta pager and Craftsmanship aliases";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;

      settings = {
        alias = {
          st = "status";
          co = "checkout";
          sw = "switch";
          br = "branch";
          ci = "commit";
          cp = "cherry-pick";
          unstage = "reset HEAD --";
          last = "log -1 HEAD";
          lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";

          # Gestion des branches distantes et des sous-modules
          clean-branch = "!f() { git fetch --prune; git branch -D $(git branch -vv | grep -E 'disparue|gone' | awk '{print $1}' | xargs); }; f";
          checkout-all = "!f() { git checkout \"$@\" && git submodule update --init --recursive; }; f";
          clone-all = "clone --recursive";
          pull-all = "!f() { git pull \"$@\" && git submodule update --init --recursive; }; f";
          push-all = "push --recurse-submodules=on-demand";
          push-master = "push origin master:master";
          push-tag = "push --tags";
        };

        init.defaultBranch = "main";
        rerere = {
          enabled = true;
          autoupdate = true;
        };
        diff.colorMoved = "default";
      };
    };

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        line-numbers = true;
        navigate = true;
        light = false;
      };
    };
  };
}
