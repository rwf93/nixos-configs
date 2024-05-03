{
  lib,
  stdenv,
  pkgs
}:
let
in
stdenv.mkDerivation {
  pname = "nvchad";
  version = "1.0.0";
  
  src = pkgs.fetchFromGitHub {
    owner = "NvChad";
    repo = "starter";
    rev = "aad624221adc6ed4e14337b3b3f2b74136696b53";
    sha256 = "sha256-2HNqPdnIVkX+d5OxjsRbL3SoY8l5Ey7/Y274Pi5uZW4=";
  };

  installPhase = ''
    mkdir $out
    cp -r * "$out/"
  '';

   meta = with lib; {
    description = "NvChad";
    homepage = "https://github.com/NvChad/NvChad";
    platforms = platforms.all;
    license = licenses.gpl3;
  };

}
