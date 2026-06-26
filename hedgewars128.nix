{ pkgs }:
pkgs.hedgewars.overrideAttrs (oldAttrs: {
  pname = "hedgewars128";
  # Keep the original version and src - we only apply patches
  
  patches = (oldAttrs.patches or []) ++ [
    ./patches/0001-support-128-teams.patch
  ];

  postPatch = (oldAttrs.postPatch or "") + ''
    # Replace logo with custom 128-team version
    cp ${./assets/HedgewarsTitle.png} QTfrontend/res/HedgewarsTitle.png
  '';

  meta = oldAttrs.meta // {
    description = "Hedgewars with 128 teams/players support";
    longDescription = oldAttrs.meta.longDescription + ''

      This is a patched version of Hedgewars that supports up to 128 teams
      instead of the default 8 teams, allowing for massive multiplayer battles.
    '';
  };
})
