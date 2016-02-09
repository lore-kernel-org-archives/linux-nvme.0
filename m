From: hch@lst.de (Christoph Hellwig)
Date: Tue, 9 Feb 2016 13:46:02 +0100
Subject: [PATCH] nvme: return the whole CQE through the request
 passthrough interface
In-Reply-To: <56B8F0DE.5090808@bjorling.me>
References: <1454954988-32306-1-git-send-email-hch@lst.de>
 <1454954988-32306-2-git-send-email-hch@lst.de> <56B8F0DE.5090808@bjorling.me>
Message-ID: <20160209124602.GA25353@lst.de>

On Mon, Feb 08, 2016@08:47:42PM +0100, Matias Bj?rling wrote:
> When LightNVM send asynchronous data commands, it would need to allocate 
> extra memory for cqe. Would it make sense to pass cqe directly and assume 
> that it is live through the blk_mq_complete_request call?

The CQE does not survive until ->end_io is called, both in the current
PCI driver, and in the Fabrics drivers.  So we need some caller provided
storage for it.
