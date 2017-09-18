From: yyt168@gmail.com (Tony Yang)
Date: Mon, 18 Sep 2017 21:02:15 +0800
Subject: compile nvme 4.13 appear error
Message-ID: <CADL4p-phBMqbqzR052xHBf_0=PPuGyvR82FoS=aaM_h7w_S7SA@mail.gmail.com>

Dear All

  I at redhat 6.5 ,kernel is 2.6.32-431.el6.x86_64?I comile nvme 4.13
appear this error:

[root at cescel03 nvme-nvme-4.13]# make
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CHK     scripts/mod/devicetable-offsets.h
  CHK     include/generated/compile.h
  AR      drivers/nvme/host/built-in.o
  CC [M]  drivers/nvme/host/core.o
drivers/nvme/host/core.c: In function ?nvme_alloc_mpath_ns?:
drivers/nvme/host/core.c:3111: error: ?NVME_FAILOVER_RETRIES?
undeclared (first use in this function)
drivers/nvme/host/core.c:3111: error: (Each undeclared identifier is
reported only once
drivers/nvme/host/core.c:3111: error: for each function it appears in.)
drivers/nvme/host/core.c: In function ?nvme_trigger_failover?:
drivers/nvme/host/core.c:3277: error: ?NVME_FAILOVER_RETRIES?
undeclared (first use in this function)
make[3]: *** [drivers/nvme/host/core.o] Error 1
make[2]: *** [drivers/nvme/host] Error 2
make[1]: *** [drivers/nvme] Error 2
make: *** [drivers] Error 2
[root at cescel03 nvme-nvme-4.13]#

Could you tell me how to solve this problem?Thanks
