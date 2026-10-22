# PS/2 Keyboard Fix (CF-SZ6 / Let'snote)

> **Bàn phím PS/2 (CF-SZ6):** bản EFI này không có driver PS/2, nên bàn phím tích hợp không hoạt động.
> Xem hướng dẫn bên dưới.

## Symptom

After installation the **built-in keyboard produces no input at all**. An external USB keyboard works fine,
which makes it easy to miss that the driver is simply missing.

## Cause

This EFI ships **VoodooI2C + VoodooI2CHID** for the touchpad, but **no PS/2 keyboard driver**.

On Let'snote **CF-SZ6** (and its predecessor CF-SZ5) the internal keyboard is wired to the **PS/2**
controller, so macOS has nothing to talk to it.

Verify with:

```bash
ioreg -l | grep -i -E 'VoodooPS2|ApplePS2'
```

No output means no PS/2 stack is loaded.

## Fix

### 1. Add the kext

Copy `VoodooPS2Controller.kext` **2.3.7** (Ventura compatible) into `EFI/OC/Kexts/`.
The bundle contains four plugins:

```
VoodooPS2Controller.kext/
└── Contents/PlugIns/
    ├── VoodooPS2Keyboard.kext
    ├── VoodooPS2Mouse.kext
    ├── VoodooPS2Trackpad.kext
    └── VoodooInput.kext
```

### 2. Reference it in `config.plist` → `Kernel` → `Add`

| # | BundlePath | ExecutablePath | PlistPath | Enabled |
|---|---|---|---|---|
| 1 | `VoodooPS2Controller.kext` | `Contents/MacOS/VoodooPS2Controller` | `Contents/Info.plist` | ✅ |
| 2 | `VoodooPS2Controller.kext/Contents/PlugIns/VoodooPS2Keyboard.kext` | `Contents/MacOS/VoodooPS2Keyboard` | `Contents/Info.plist` | ✅ |
| 3 | `VoodooPS2Controller.kext/Contents/PlugIns/VoodooPS2Mouse.kext` | `Contents/MacOS/VoodooPS2Mouse` | `Contents/Info.plist` | ❌ |
| 4 | `VoodooPS2Controller.kext/Contents/PlugIns/VoodooPS2Trackpad.kext` | `Contents/MacOS/VoodooPS2Trackpad` | `Contents/Info.plist` | ❌ |
| 5 | `VoodooPS2Controller.kext/Contents/PlugIns/VoodooInput.kext` | `Contents/MacOS/VoodooInput` | `Contents/Info.plist` | ❌ |

Do **not** use the `VoodooPS2Controller.kext` bundle entry with `PlugIn` loading shortcuts; list each plugin
explicitly, otherwise OpenCore loads all of them.

### 3. Why only two entries are enabled

- The touchpad in this EFI is **I2C** (`VoodooI2C` + `VoodooI2CHID`), and `VoodooI2C` already bundles its own
  `VoodooInput`. Loading the PS/2 `VoodooInput` as well gives two producers for the same input stack and the
  touchpad stops working (or behaves erratically).
- `VoodooPS2Keyboard` depends only on `VoodooPS2Controller` — it does **not** need `VoodooInput`. Disabling the
  latter does not affect the keyboard.
- `VoodooPS2Mouse` / `VoodooPS2Trackpad` are for PS/2 pointing devices only; keep them off on I2C-touchpad models.

### 4. Reboot

Reset NVRAM once (OpenCore picker → `Reset NVRAM`) if the kext does not load after a plain reboot.

## Verification

```bash
ioreg -l | grep -i VoodooPS2        # VoodooPS2Controller + VoodooPS2Keyboard should appear
```

Then the internal keyboard should type, with no regression on the touchpad.

## Notes

- Verified on **CF-SZ6** (i5-7300U, HD 620), macOS **Ventura 13.7.8** — internal keyboard works,
  I2C touchpad unaffected.
- The change is purely **additive**: no existing kext, boot-arg, or device property is modified.
- On CF-XZ6 the keyboard may be I2C instead; check `ioreg` before enabling these entries.
