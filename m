From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 26 Sep 2016 17:13:45 -0500
Subject: nvme-cli won't build
Message-ID: <026701d21843$3f68bd70$be3a3850$@opengridcomputing.com>

Anybody know what's up here?  I've got linux-4.8-rc8 kernel built/installed and
the latest nvme-cli pulled, but nvme-cli fails to build.


[root at stevo1 nvme-cli]# make
cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ -std=gnu99 -O2 -g -Wall -Werror
-DLIBUDEV_EXISTS -DNVME_VERSION='"0.9.35.gf051"' -c nvme-print.c
In file included from nvme.h:22,
                 from nvme-print.h:4,
                 from nvme-print.c:6:
linux/nvme.h:19:24: error: linux/uuid.h: No such file or directory
In file included from nvme.h:22,
                 from nvme-print.h:4,
                 from nvme-print.c:6:
linux/nvme.h:806: error: expected specifier-qualifier-list before ?uuid_be?
make: *** [nvme-print.o] Error 1
[root at stevo1 nvme-cli]#
