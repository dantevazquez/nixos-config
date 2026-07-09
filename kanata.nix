{ config, pkgs, ... }:

{
  services.kanata = {
    enable = true;
    keyboards.default = {
      config = ''
        (defsrc
          lmeta lalt rmeta ralt 
          c v z x t f 
          1 2 3 4 5 6 7 8 9 
          tab b ret w a s l q spc
        )

        (deffakekeys
          super lmeta
        )

        (defalias
          mac-c C-ins
          mac-v S-ins
          mac-z C-z
          mac-x C-x
          mac-t C-t
          mac-f C-f
          mac-w C-w
          mac-a C-a
          mac-s C-s
          mac-l C-l

          mac-1 C-1
          mac-2 C-2
          mac-3 C-3
          mac-4 C-4
          mac-5 C-5
          mac-6 C-6
          mac-7 C-7
          mac-8 C-8
          mac-9 C-9
          
          ;; Press and hold the virtual 'super' key, wait 15ms, then send Tab
          wm-tab (macro (on-press-fakekey super press) 15 tab)
          wm-b M-b
          wm-ret M-ret
          wm-q M-q
          wm-spc M-spc

          ;; Toggle the layer, and release the virtual 'super' key when Left Alt is released
          cmd-layer (multi (layer-toggle mac-cmd) (on-release-fakekey super release))
        )

        (deflayer default
          lalt @cmd-layer ralt @cmd-layer 
          c v z x t f 
          1 2 3 4 5 6 7 8 9 
          tab b ret w a s l q spc
        )

        (deflayer mac-cmd
          _ _ _ _ 
          @mac-c @mac-v @mac-z @mac-x @mac-t @mac-f 
          @mac-1 @mac-2 @mac-3 @mac-4 @mac-5 @mac-6 @mac-7 @mac-8 @mac-9 
          @wm-tab @wm-b @wm-ret @mac-w @mac-a @mac-s @mac-l @wm-q @wm-spc
        )
      '';
    };
  };
}
