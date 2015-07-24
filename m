From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Fri, 24 Jul 2015 11:14:55 -0400
Subject: [PATCH 3/5] block: Reduce the size of struct blk_integrity
In-Reply-To: <20150721115347.GA1654@infradead.org> (Christoph Hellwig's
 message of "Tue, 21 Jul 2015 04:53:47 -0700")
References: <20150716091957.GA18310@infradead.org>
 <1437458579-18706-1-git-send-email-martin.petersen@oracle.com>
 <1437458579-18706-4-git-send-email-martin.petersen@oracle.com>
 <20150721115347.GA1654@infradead.org>
Message-ID: <yq1r3nxy4cw.fsf@sermon.lab.mkp.net>

>>>>> "Christoph" == Christoph Hellwig <hch at infradead.org> writes:

Christoph> Just curious: why do we event bother with storing the
Christoph> interval?  Seem like our current impplementation forces it to
Christoph> the block size anyway.

There are SCSI devices that permit the PI at different intervals than
the logical block size. I have a patch set in the pipeline.

-- 
Martin K. Petersen	Oracle Linux Engineering
