From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 16 Jul 2015 21:47:15 -0400
Subject: [PATCH] NVMe: Reread partitions on metadata formats
In-Reply-To: <20150716091957.GA18310@infradead.org> (Christoph Hellwig's
 message of "Thu, 16 Jul 2015 02:19:57 -0700")
References: <1436896668-27373-1-git-send-email-keith.busch@intel.com>
 <55A559B5.2000303@fb.com>
 <CAA9_cmc2Kb=XRwPpOijT+T_1-qfPH-h7LeM0AGSP6ZOW72MjwQ@mail.gmail.com>
 <55A6D251.9050801@fb.com>
 <alpine.LNX.2.00.1507152142070.15930@localhost.lm.intel.com>
 <20150716091957.GA18310@infradead.org>
Message-ID: <yq1380no8rg.fsf@sermon.lab.mkp.net>

>>>>> "Christoph" == Christoph Hellwig <hch at infradead.org> writes:

Christoph> Also the way struct blk_integrity is used is a bit of a mess,
Christoph> instead of passing it and then copying into a newly allocated
Christoph> copy of it I'd rather move the kobj to struct gendisk and
Christoph> then just have a pointer to the original template in struct
Christoph> gendisk.

The flags, protection interval, tag size, etc. are per-device
properties.

-- 
Martin K. Petersen	Oracle Linux Engineering
