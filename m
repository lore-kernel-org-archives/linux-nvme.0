From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Mon, 23 Oct 2017 15:43:36 +0000
Subject: NVMe-CLI intel-nvme.c RHEL 6.9 Compile Errors
Message-ID: <MWHPR04MB102554E84EE6D1CC8ADBF47EEA460@MWHPR04MB1025.namprd04.prod.outlook.com>

Keith, 
We noticed these compile errors when trying to build the latest version of the NVME CLI on RHEL 6.9 and SLES 11.4:
[ddtest at gfox3-rh69 nvme-cli-kb]$ make
NVME_VERSION = 1.4
cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 -DNVME_VERSION='"1.4"' -c argconfig.c
cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 -DNVME_VERSION='"1.4"' -c suffix.c
cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 -DNVME_VERSION='"1.4"' -c parser.c
cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 -DNVME_VERSION='"1.4"' -c nvme-print.c
cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 -DNVME_VERSION='"1.4"' -c nvme-ioctl.c
cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 -DNVME_VERSION='"1.4"' -c nvme-lightnvm.c
cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 -DNVME_VERSION='"1.4"' -c fabrics.c
cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 -DNVME_VERSION='"1.4"' -c json.c
cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 -DNVME_VERSION='"1.4"' -c plugin.c
cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 -DNVME_VERSION='"1.4"' -c intel-nvme.c
cc1: warnings being treated as errors
intel-nvme.c: In function \u2018get_internal_log\u2019:
intel-nvme.c:782: error: dereferencing pointer \u2018ehdr\u2019 does break strict-aliasing rules
intel-nvme.c:785: error: dereferencing pointer \u2018ehdr\u2019 does break strict-aliasing rules
intel-nvme.c:741: note: initialized from here
intel-nvme.c:643: error: \u2018ad\u2019 may be used uninitialized in this function
intel-nvme.c:645: error: \u2018ehdr\u2019 may be used uninitialized in this function
make: *** [intel-nvme.o] Error 1

If I checkout the v1.3 tag, it builds fine, but then our latest wdc plugin changes aren't included.  Could  you (or whoever the intel plugin maintainer is) look into fixing these errors?   Thanks


Jeff Lien
Linux Device Driver Development
Device Host Apps and Drivers
jeff.lien at wdc.com
o: 507-322-2416 (ext. 23-2416)
m: 507-273-9124
