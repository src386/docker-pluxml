## 2022-09-01

### Removed

- PluXml 5.7

## 2021-05-23

### Added

- Github actions (CI)
- `arm64` build

### Changed

- Update to PluXml 5.8.6
- Fix `install.php` file auto remove

### Removed

- Travis CI
- PluXml `5.6` support

## 2020-11-08

### Changed

- Update to PluXml 5.8.4

## (March 06, 2020)

FEATURES:

- Added support for PluXml `5.8`.

## (October 12, 2019)

BUGFIXES:

- build: Package `ssmtp` has no installation candidate. ([#10](https://github.com/src386/docker-pluxml/issues/10)). Switched to `msmtpd`.

CLEANING:

- entrypoint: Removed data version checking since `install.php` is not necessary.
