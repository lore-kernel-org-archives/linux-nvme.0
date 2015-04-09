From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 09 Apr 2015 17:40:02 -0400
Subject: [RESEND PATCH] NVMe: Add translation for block limits
In-Reply-To: <alpine.LNX.2.00.1504080233400.32385@localhost.lm.intel.com>
 (Keith Busch's message of "Wed, 8 Apr 2015 02:48:34 +0000 (UTC)")
References: <1428442458-3219-1-git-send-email-keith.busch@intel.com>
 <yq1y4m3fmjj.fsf@sermon.lab.mkp.net>
 <alpine.LNX.2.00.1504080233400.32385@localhost.lm.intel.com>
Message-ID: <yq1d23df0b1.fsf@sermon.lab.mkp.net>

>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:

Keith> The 256 max descriptors is straight from the "spec" (if you can
Keith> call it that), but convienent because it fits in a 4k page.

Yep.

It doesn't really matter since we're not keying off of the SCSI
translated values for NVMe devices. So I'm perfectly happy with you
reporting 0xffffffff as max_discard_sectors to the block layer.

-- 
Martin K. Petersen	Oracle Linux Engineering
