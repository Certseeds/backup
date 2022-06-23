# chrome files

F**K CHROIUM-EDGE, `edge://settings/importData` can not import anything.

## 恢复

each file is encrypted and signed,

``` bash
# encry-and-sign
gpg -er ${encry} --sign -u ${sign} ${filename}
# decrypt-and-check
gpg -dr ${encry} -v ${filename}.gpg > ${filename}
```
