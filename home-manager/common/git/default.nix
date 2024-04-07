{...}: {
  programs.git = {
    enable = true;
    userName = "Andy Jimenez Reyes";
    userEmail = "andy.reyes@solfacil.com.br";
    signing = {
      key = "FD81D97B9A199BD0";
      signByDefault = true;
    };
    aliases = {
      l = "log --pretty=format:'%C(yellow)%h%Creset %ad | %Cgreen%s%Creset %Cred%d%Creset %Cblue[%an]' --date=short";
      s = "status -s";
      c = "commit -m";
      cs = "commit -S -m";
      f = "fetch";
      ai = "commit -a";
    };
  };
}
