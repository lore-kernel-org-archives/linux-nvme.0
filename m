From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 30 Jul 2015 12:32:30 -0400
Subject: [PATCH] blk: add vector gaps queue parameter
In-Reply-To: <20150730161104.GA30014@infradead.org> (Christoph Hellwig's
 message of "Thu, 30 Jul 2015 09:11:04 -0700")
References: <1438189313-29722-1-git-send-email-keith.busch@intel.com>
 <55B9E893.7050509@dev.mellanox.co.il>
 <20150730161104.GA30014@infradead.org>
Message-ID: <yq13805ppwh.fsf@sermon.lab.mkp.net>

>>>>> "Christoph" == Christoph Hellwig <hch at infradead.org> writes:

Christoph> I'd say we should remove the SG_GAPS flag (which is horribly
Christoph> misnamed anyway) and just have this field.  0 means we don't
Christoph> need to check at all, and any actual value checks for that
Christoph> value.

I was just going to make the same observation. I agree completely.

-- 
Martin K. Petersen	Oracle Linux Engineering
