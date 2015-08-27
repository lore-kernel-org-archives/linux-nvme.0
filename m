From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 26 Aug 2015 20:25:11 -0400
Subject: [PATCH 5/5] block: Inline blk_integrity in struct gendisk
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93CBE5758@fmsmsx104.amr.corp.intel.com>
 (Keith Busch's message of "Fri, 21 Aug 2015 23:47:31 +0000")
References: <20150721120102.GB1654@infradead.org>
 <1440103314-31610-1-git-send-email-martin.petersen@oracle.com>
 <1440103314-31610-6-git-send-email-martin.petersen@oracle.com>
 <B58D82457FDA0744A320A2FC5AC253B93CBE5758@fmsmsx104.amr.corp.intel.com>
Message-ID: <yq1bndt37dk.fsf@sermon.lab.mkp.net>

>>>>> "Keith" == Busch, Keith <keith.busch at intel.com> writes:

Keith> The blk_get_integrity check is necessary to prevent a kernel
Keith> crash. Without it, this function will return a template disk
Keith> without integrity and later attempt to register a NULL
Keith> disk->integrity.

Fixed that up.

Keith> Otherwise, looks good! I will post the nvme driver patch removing
Keith> the two pass disk revalidation since that's no longer necessary
Keith> with this good stuff.

I tweaked that while I was at it. Updated patch 5 coming...

-- 
Martin K. Petersen	Oracle Linux Engineering
