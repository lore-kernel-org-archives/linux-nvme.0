From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 30 May 2018 08:06:13 +0200
Subject: [PATCHv3 4/9] nvme-pci: Rate limit the nvme timeout warnings
In-Reply-To: <20180524203500.14081-5-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-5-keith.busch@intel.com>
Message-ID: <20180530060613.GA22380@infradead.org>

On Thu, May 24, 2018@02:34:55PM -0600, Keith Busch wrote:
> The block layer's timeout handling currently prevents drivers from
> completing commands outside the timeout callback once blk-mq decides
> they've expired. If a device breaks, this could potentially create many
> thousands of timed out commands. There's nothing of value to be gleaned
> from observing each of those messages, so this patch adds a rate limit
> on them.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

I've picked this for the nvme-4.18 tree.
