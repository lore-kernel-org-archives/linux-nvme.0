From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 21 Jul 2015 05:01:02 -0700
Subject: [PATCH 5/5] block: Inline blk_integrity in struct gendisk
In-Reply-To: <1437458579-18706-6-git-send-email-martin.petersen@oracle.com>
References: <20150716091957.GA18310@infradead.org>
 <1437458579-18706-1-git-send-email-martin.petersen@oracle.com>
 <1437458579-18706-6-git-send-email-martin.petersen@oracle.com>
Message-ID: <20150721120102.GB1654@infradead.org>

On Tue, Jul 21, 2015@02:02:59AM -0400, Martin K. Petersen wrote:
>  - Moving the blk_integrity definitions to genhd.h.

You only need to move struct blk_integrity.  as that one only has a
pointer to struct blk_integrity_profile there is no need to move he
rest.

Otherwise this looks good, although eplace calls to
blk_integrity_register with a NULL integrity profile with direct calls
to blk_integrity_unregister.
