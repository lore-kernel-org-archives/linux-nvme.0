From: yyt168@gmail.com (Tony Yang)
Date: Mon, 18 Sep 2017 21:47:15 +0800
Subject: compile nvme not find bi_disk
Message-ID: <CADL4p-rjo2DisDwRP5YFDDMZS-GrP3fKijGSmp26Uqa+BACB6A@mail.gmail.com>

Dear All

  I'm compiling nvme, but encountered the following error, how can I
solve it? Thanks

 CHK     include/generated/compile.h
  CC [M]  drivers/nvme/host/core.o
drivers/nvme/host/core.c: In function ?__nvme_submit_user_cmd?:
drivers/nvme/host/core.c:631: error: ?struct bio? has no member named ?bi_disk?
make[3]: *** [drivers/nvme/host/core.o] Error 1
make[2]: *** [drivers/nvme/host] Error 2
make[1]: *** [drivers/nvme] Error 2
make: *** [drivers] Error 2
[root at cescel03 nvme-nvme-4.13]# bi_disk
