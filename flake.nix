{
  description = ''Get information on files and folders in OneDrive'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."onedrive-master".dir   = "master";
  inputs."onedrive-master".owner = "nim-nix-pkgs";
  inputs."onedrive-master".ref   = "master";
  inputs."onedrive-master".repo  = "onedrive";
  inputs."onedrive-master".type  = "github";
  inputs."onedrive-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."onedrive-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}