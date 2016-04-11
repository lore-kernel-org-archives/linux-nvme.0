From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Mon, 11 Apr 2016 16:27:45 -0400
Subject: [PATCH] nvme/host: Add missing blk_integrity tag_size + flags
 assignments
In-Reply-To: <1460171082-7212-1-git-send-email-nab@daterainc.com> (Nicholas
 A. Bellinger's message of "Sat, 9 Apr 2016 03:04:42 +0000")
References: <1460171082-7212-1-git-send-email-nab@daterainc.com>
Message-ID: <yq1h9f73n7i.fsf@sermon.lab.mkp.net>

>>>>> "Nicholas" == Nicholas A Bellinger <nab at daterainc.com> writes:

Nicholas> While doing recent bring-up of nvme/host with target-core
Nicholas> T10-PI, I noticed
Nicholas> /sys/block/nvme*/integrity/device_is_integrity_capable was
Nicholas> false, and /sys/block/nvme*/integrity/tag_size contained a
Nicholas> bogus value.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
