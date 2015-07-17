From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 Jul 2015 09:43:58 +0200
Subject: [PATCH 1/3] block: copy multi iovec user mappings if
 QUEUE_FLAG_SG_GAPS is set
In-Reply-To: <alpine.LNX.2.00.1507161633270.15930@localhost.lm.intel.com>
References: <1436966356-8979-1-git-send-email-sagig@mellanox.com>
 <1436966356-8979-2-git-send-email-sagig@mellanox.com>
 <alpine.LNX.2.00.1507161633270.15930@localhost.lm.intel.com>
Message-ID: <20150717074358.GA19276@lst.de>

On Thu, Jul 16, 2015@04:47:12PM +0000, Keith Busch wrote:
> On Wed, 15 Jul 2015, Sagi Grimberg wrote:
>> For drivers that don't support gaps in the SG lists handed to them we must
>> not create bios from multiple iovecs as they can be (and usually are)
>> discontiguous.  This doesn't matter for any current user, but will help
>> to allow iSER which can't handle gaps to use the QUEUE_FLAG_SG_GAPS flag
>> instead of using driver-local bounce buffering.
>
> Maybe SG_GAPS is a bit of a misnomer. There are cases we can directly
> map a user iov with multiple discontiguous vectors. At least for NVMe
> it'd work if each iov's base and length are on page boundaries, we don't
> need to do the indirect copy.

Yes, right now the check is a little pessimistic.  If we really care
for this use case we can iterate over all iovecs and check if they
would introduce offsets into a page.

Note that NVMe never uses blk_rq_map_user_iov with more than a single
iov so it doesn't apply there, there concern here is iSER, but the same
rules apply there as well.
