# unikernel-example-volume-go
➜  go build g2.go

➜  ops run -p 8080 g2
booting /Users/eyberg/.ops/images/g2.img ...
assigned: 10.0.2.15
/ 0
/dev 0
/dev/null 0
/dev/urandom 0
/etc 0
/etc/passwd 33
/etc/resolv.conf 18
/etc/ssl 0
/etc/ssl/certs 0
/etc/ssl/certs/ca-certificates.crt 207436
/g2 7533614
/lib 0
/lib/x86_64-linux-gnu 0
/lib/x86_64-linux-gnu/libnss_dns.so.2 26936
/proc 0
/proc/self 0
/proc/self/exe 0
/proc/self/maps 0
/proc/sys 0
/proc/sys/kernel 0
/proc/sys/kernel/hostname 7
/sys 0
/sys/devices 0
/sys/devices/system 0
/sys/devices/system/cpu 0
/sys/devices/system/cpu/cpu0 0
/sys/devices/system/cpu/online 0
open /mnt/bob.txt: no such file or directory
ops run -p 8080 g2
booting /Users/ahmed/.ops/images/g2.img ...
assigned: 10.0.2.15
/ 0
/dev 0
/dev/null 0
/dev/urandom 0
/etc 0
/etc/passwd 33
/etc/resolv.conf 18
/etc/ssl 0
/etc/ssl/certs 0
/etc/ssl/certs/ca-certificates.crt 207436
/g2 7533614
/lib 0
/lib/x86_64-linux-gnu 0
/lib/x86_64-linux-gnu/libnss_dns.so.2 26936
/proc 0
/proc/self 0
/proc/self/exe 0
/proc/self/maps 0
/proc/sys 0
/proc/sys/kernel 0
/proc/sys/kernel/hostname 7
/sys 0
/sys/devices 0
/sys/devices/system 0
/sys/devices/system/cpu 0
/sys/devices/system/cpu/cpu0 0
/sys/devices/system/cpu/online 0
open /mnt/bob.txt: no such file or directory
-----------------------
### Creating a Volume

mkdir mnt
echo "Hi - I'm a text file" > mnt/bob.txt
➜ ops volume create mnt -d mnt
2023/01/26 02:00:34 volume: mnt created with UUID 864422bb-b6a1-0f20-edde-ae4160d4c28d and label mnt

➜ ops volume list
+--------------------------------------+------+--------+-----------+-----------------------------------------------------------------+--------------------------------+----------+
|                 UUID                 | NAME | STATUS | SIZE (GB) |                            LOCATION                             |            CREATED             | ATTACHED |
+--------------------------------------+------+--------+-----------+-----------------------------------------------------------------+--------------------------------+----------+
| 864422bb-b6a1-0f20-edde-ae4160d4c28d | mnt  |        | 1.0 MB    | /root/.ops/volumes/mnt:864422bb-b6a1-0f20-edde-ae4160d4c28d.raw | 2023-01-26 02:00:34.807412106  |          |
|                                      |      |        |           |                                                                 | +0200 EET                      |          |
+--------------------------------------+------+--------+-----------+-----------------------------------------------------------------+--------------------------------+----------+


## Attaching a Volume

➜ ops run -p 8080 g2 --mounts mnt:/mnt

booting /Users/ahmed/.ops/images/g2.img ...
assigned: 10.0.2.15
/ 0
/dev 0
/dev/null 0
/dev/urandom 0
/etc 0
/etc/passwd 33
/etc/resolv.conf 18
/etc/ssl 0
/etc/ssl/certs 0
/etc/ssl/certs/ca-certificates.crt 207436
/g2 7533614
/lib 0
/lib/x86_64-linux-gnu 0
/lib/x86_64-linux-gnu/libnss_dns.so.2 26936
/mnt 0
/mnt/bob.txt 21
/proc 0
/proc/self 0
/proc/self/exe 0
/proc/self/maps 0
/proc/sys 0
/proc/sys/kernel 0
/proc/sys/kernel/hostname 7
/sys 0
/sys/devices 0
/sys/devices/system 0
/sys/devices/system/cpu 0
/sys/devices/system/cpu/cpu0 0
/sys/devices/system/cpu/online 0
Hi - I'm a text file
--------------
## Attache other volume
➜ echo "New text has come to light." > mnt/bob.txt
➜ ops volume create mnt2 -d mnt

➜ ops volume list
+--------------------------------------+------+--------+-----------+------------------------------------------------------------------+--------------------------------+----------+
|                 UUID                 | NAME | STATUS | SIZE (GB) |                             LOCATION                             |            CREATED             | ATTACHED |
+--------------------------------------+------+--------+-----------+------------------------------------------------------------------+--------------------------------+----------+
| 4a9a4c53-5ed7-d3b2-ff34-9c67067bf8a3 | mnt2 |        | 1.0 MB    | /root/.ops/volumes/mnt2:4a9a4c53-5ed7-d3b2-ff34-9c67067bf8a3.raw | 2023-01-26 02:04:44.901300163  |          |
|                                      |      |        |           |                                                                  | +0200 EET                      |          |
+--------------------------------------+------+--------+-----------+------------------------------------------------------------------+--------------------------------+----------+
| 864422bb-b6a1-0f20-edde-ae4160d4c28d | mnt  |        | 1.0 MB    | /root/.ops/volumes/mnt:864422bb-b6a1-0f20-edde-ae4160d4c28d.raw  | 2023-01-26 02:00:34.807412106  |          |
|                                      |      |        |           |                                                                  | +0200 EET                      |          |
+--------------------------------------+------+--------+-----------+------------------------------------------------------------------+--------------------------------+----------+

➜  ops run -p 8080 g2 --mounts mnt2:/mnt

booting /Users/ahmed/.ops/images/g2.img ...
assigned: 10.0.2.15
/ 0
/dev 0
/dev/null 0
/dev/urandom 0
/etc 0
/etc/passwd 33
/etc/resolv.conf 18
/etc/ssl 0
/etc/ssl/certs 0
/etc/ssl/certs/ca-certificates.crt 207436
/g2 7533614
/lib 0
/lib/x86_64-linux-gnu 0
/lib/x86_64-linux-gnu/libnss_dns.so.2 26936
/mnt 0
/mnt/bob.txt 28
/proc 0
/proc/self 0
/proc/self/exe 0
/proc/self/maps 0
/proc/sys 0
/proc/sys/kernel 0
/proc/sys/kernel/hostname 7
/sys 0
/sys/devices 0
/sys/devices/system 0
/sys/devices/system/cpu 0
/sys/devices/system/cpu/cpu0 0
/sys/devices/system/cpu/online 0
New text has come to light.
-----------------
## List of images
➜ ops image list
+------+------------------------+----------+----------------+
| NAME |          PATH          |   SIZE   |   CREATEDAT    |
+------+------------------------+----------+----------------+
| g2   | /ahmed/.ops/images/g2   | 23.4 MB  | 1 minute ago   |
+------+------------------------+----------+----------------+
| node | /ahmed/.ops/images/node | 100.1 MB | 47 minutes ago |
+------+------------------------+----------+----------------+

## list of file system in each image
➜ ops image  ls  g2
proc mnt lib64 lib etc g2

## tree of file system in each image
➜ ops image  tree  g2
/
|   etc
|   |   ssl
|   |   |   certs
|   |   |   |   ca-certificates.crt
|   |   resolv.conf
|   |   passwd
|   g2
|   proc
|   |   sys
|   |   |   kernel
|   |   |   |   hostname
|   |   self
|   |   |   exe -> /g2
|   mnt
|   lib64
|   |   ld-linux-x86-64.so.2
|   lib
|   |   x86_64-linux-gnu
|   |   |   libnss_dns.so.2
|   |   |   libpthread.so.0
|   |   |   libc.so.6
---------------------------------
## Delete image
➜ ops volume list
+--------------------------------------+------+--------+-----------+------------------------------------------------------------------+--------------------------------+----------+
|                 UUID                 | NAME | STATUS | SIZE (GB) |                             LOCATION                             |            CREATED             | ATTACHED |
+--------------------------------------+------+--------+-----------+------------------------------------------------------------------+--------------------------------+----------+
| 4a9a4c53-5ed7-d3b2-ff34-9c67067bf8a3 | mnt2 |        | 1.0 MB    | /ahmed/.ops/volumes/mnt2:4a9a4c53-5ed7-d3b2-ff34-9c67067bf8a3.raw | 2023-01-26 02:04:44.901300163  |          |
|                                      |      |        |           |                                                                  | +0200 EET                      |          |
+--------------------------------------+------+--------+-----------+------------------------------------------------------------------+--------------------------------+----------+
| 864422bb-b6a1-0f20-edde-ae4160d4c28d | mnt  |        | 1.0 MB    | /ahmed/.ops/volumes/mnt:864422bb-b6a1-0f20-edde-ae4160d4c28d.raw  | 2023-01-26 02:00:34.807412106  |          |
|                                      |      |        |           |                                                                  | +0200 EET                      |          |
+--------------------------------------+------+--------+-----------+------------------------------------------------------------------+--------------------------------+----------+
➜ ops volume delete 4a9a4c53-5ed7-d3b2-ff34-9c67067bf8a3
➜ ops volume list
+--------------------------------------+------+--------+-----------+-----------------------------------------------------------------+--------------------------------+----------+
|                 UUID                 | NAME | STATUS | SIZE (GB) |                            LOCATION                             |            CREATED             | ATTACHED |
+--------------------------------------+------+--------+-----------+-----------------------------------------------------------------+--------------------------------+----------+
| 864422bb-b6a1-0f20-edde-ae4160d4c28d | mnt  |        | 1.0 MB    | /ahmed/.ops/volumes/mnt:864422bb-b6a1-0f20-edde-ae4160d4c28d.raw | 2023-01-26 02:00:34.807412106  |          |
|                                      |      |        |           |                                                                 | +0200 EET                      |          |
+--------------------------------------+------+--------+-----------+-----------------------------------------------------------------+--------------------------------+----------+
➜ ops volume delete 864422bb-b6a1-0f20-edde-ae4160d4c28d
➜ ops volume list
+------+------+--------+-----------+----------+---------+----------+
| UUID | NAME | STATUS | SIZE (GB) | LOCATION | CREATED | ATTACHED |
+------+------+--------+-----------+----------+---------+----------+
