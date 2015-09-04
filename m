From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 03 Sep 2015 23:25:09 -0400
Subject: [PATCH] block: Inline blk_integrity in struct gendisk
In-Reply-To: <alpine.LNX.2.00.1509032035360.23840@localhost.lm.intel.com>
 (Keith Busch's message of "Thu, 3 Sep 2015 20:38:09 +0000 (UTC)")
References: <B58D82457FDA0744A320A2FC5AC253B93CBE5758@fmsmsx104.amr.corp.intel.com>
 <1440635121-8765-1-git-send-email-martin.petersen@oracle.com>
 <alpine.LNX.2.00.1509032035360.23840@localhost.lm.intel.com>
Message-ID: <yq1613qamsq.fsf@sermon.lab.mkp.net>

>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:

Keith> We still ought to set the capacity to 0 if there is no block
Keith> integrity support for the disk when it has meta data
Keith> formats. This would happen with either extended metadata, or
Keith> kernel config does not include integrity extensions.

Gotcha. Will fix!

-- 
Martin K. Petersen	Oracle Linux Engineering
