From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 21 Jul 2015 04:53:47 -0700
Subject: [PATCH 3/5] block: Reduce the size of struct blk_integrity
In-Reply-To: <1437458579-18706-4-git-send-email-martin.petersen@oracle.com>
References: <20150716091957.GA18310@infradead.org>
 <1437458579-18706-1-git-send-email-martin.petersen@oracle.com>
 <1437458579-18706-4-git-send-email-martin.petersen@oracle.com>
Message-ID: <20150721115347.GA1654@infradead.org>

On Tue, Jul 21, 2015@02:02:57AM -0400, Martin K. Petersen wrote:
> The per-device properties in the blk_integrity structure were previously
> unsigned short. However, most of the values fit inside a char. The only
> exception is the data interval size and we can work around that by
> storing it as a power of two.

Just curious: why do we event bother with storing the interval?  Seem
like our current impplementation forces it to the block size anyway.
