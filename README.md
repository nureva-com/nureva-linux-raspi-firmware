# nureva-linux-raspi-firmware

Ubuntu Noble PPA for Raspberry Pi firmware packages used by Nureva devices.

## Usage

```bash
curl -s --compressed "https://nureva-com.github.io/nureva-linux-raspi-firmware-ppa/KEY.gpg"     | gpg --dearmor     | sudo tee /usr/share/keyrings/nureva-linux-raspi-firmware-archive-keyring.gpg >/dev/null

sudo curl -s --compressed     -o /etc/apt/sources.list.d/nureva-linux-raspi-firmware.list     "https://nureva-com.github.io/nureva-linux-raspi-firmware-ppa/nureva-linux-raspi-firmware.list"

sudo apt update
```

Supported architecture: `arm64`.

## Building

Run on a Raspberry Pi:

```bash
./bin/install_deps.sh
./bin/build_dep.sh
```

## Updating Packages

Run:

```bash
./bin/generate.sh
```

Commit and push the generated files to publish the updated repository metadata.
