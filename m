From: hch@lst.de (Christoph Hellwig)
Date: Fri, 7 Jul 2017 15:50:17 +0200
Subject: [PATCH] nvme-pci: add module parameter for io queue depth
In-Reply-To: <20170707090547.GA2420@localhost.didichuxing.com>
References: <20170707090547.GA2420@localhost.didichuxing.com>
Message-ID: <20170707135017.GB8782@lst.de>

On Fri, Jul 07, 2017@05:05:47PM +0800, weiping zhang wrote:
> Adjust io queue depth more easily.
> 
> Signed-off-by: weiping zhang <zhangweiping at didichuxing.com>

Sounds useful in general, the only thin I'm worried about is that
this will affect all drives in the system, which might have
very different characteristics.  But I can't really think of
a better approach.
