From: hch@lst.de (Christoph Hellwig)
Date: Fri, 9 Oct 2015 16:39:34 +0200
Subject: [PATCH 8/8] nvme: properly handle partially initialized queues
 in nvme_create_io_queues
In-Reply-To: <alpine.LNX.2.00.1510091419100.27742@localhost.lm.intel.com>
References: <1443879587-23553-1-git-send-email-hch@lst.de>
 <1443879587-23553-9-git-send-email-hch@lst.de>
 <56169138.90804@dev.mellanox.co.il> <20151009061506.GA28370@lst.de>
 <alpine.LNX.2.00.1510091419100.27742@localhost.lm.intel.com>
Message-ID: <20151009143934.GA4437@lst.de>

On Fri, Oct 09, 2015@02:20:38PM +0000, Keith Busch wrote:
>> He did reply with a reviewed-by tag to the previous posting of the series,
>> I think that qualifies.
>
> I think Sagi was just making a light of using the wrong name (your's)
> in the "Reviewed-by". :)

Oh, ok.  Jens, do you want a resend, or can you fix it up on the fly?
