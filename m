From: newhorizons009@gmail.com (Linux User)
Date: Wed, 17 May 2017 15:34:25 -0400
Subject: NVMe sluggish
Message-ID: <CA+12NBLYg47+yJp8u0+Oq=+t0qfwRLUePep9N4uaomnJ6Y6+SQ@mail.gmail.com>

Hello All,


I switched my ssd from M.2 based ahci protocol to nvme protocol, with
that, when i do chmod 777 -R /mnt/ssd it takes forever, however same
step on the ahci based ssd takes a blink of an eye.

Even doing ls at /mnt/ssd takes a long time.


I am running 3.10-ltsi. Below are my fs creation params.

mke2fs -F -t ext4 /dev/nvme0n1p1
  tune2fs -o journal_data_writeback /dev/nvme0n1p1
  tune2fs -O ^has_journal /dev/nvme0n1p1


Below are my mounting options,

mount -t ext4 -o data=ordered,noatime,nodiratime,norelatime /dev/nvme0n1p1


Any clues ?


Having said above, I did a fio random read test on both AHCI and NVMe,
and that seems to have good results.

Toshiba NVMe

bw (KB  /s): min=14320, max=21496, per=100.00%, avg=19765.54, stdev=1813.54



Samsung AHCI

bw (KB  /s): min=15687, max=19720, per=99.52%, avg=17773.93, stdev=1236.09
