From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 17 Nov 2016 21:22:33 -0500
Subject: [PATCH v2 2/5] block: add support for REQ_OP_WRITE_ZEROES
In-Reply-To: <1479421031-6060-1-git-send-email-ckulkarnilinux@gmail.com>
 (Chaitanya Kulkarni's message of "Thu, 17 Nov 2016 14:17:11 -0800")
References: <1479421031-6060-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <yq11sy97cie.fsf@sermon.lab.mkp.net>

>>>>> "Chaitanya" == Chaitanya Kulkarni <ckulkarnilinux at gmail.com> writes:

Chaitanya> This adds a new block layer operation to zero out a range of
Chaitanya> LBAs. This allows to implement zeroing for devices that don't
Chaitanya> use either discard with a predictable zero pattern or WRITE
Chaitanya> SAME of zeroes.  The prominent example of that is NVMe with
Chaitanya> the Write Zeroes command, but in the future this should also
Chaitanya> help with improving the way zeroing discards work.

Looks good. Please also export the queue limit in blk-sysfs.c and create
a suitable entry in Documentation/ABI/testing/sysfs-block.

-- 
Martin K. Petersen	Oracle Linux Engineering
