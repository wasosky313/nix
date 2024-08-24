{...}: {
  programs.git = {
    enable = true;
    userName = "Andy Jimenez Reyes";
    userEmail = "wasosky313@gmail.com";
    signing = {
      key = "839F81F7210FA5D1";
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
