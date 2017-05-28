From: rakesh@tuxera.com (Rakesh Pandit)
Date: Sun, 28 May 2017 14:47:57 +0300
Subject: [PATCH V3] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <20170528094043.GA14199@lst.de>
References: <20170526201351.GA21847@dhcp-216.srv.tuxera.com>
 <20170528094043.GA14199@lst.de>
Message-ID: <20170528114757.GA29357@dhcp-216.srv.tuxera.com>

On Sun, May 28, 2017@11:40:43AM +0200, Christoph Hellwig wrote:
> Hi Rakesh,
> 
> this looks reasonable, but we'll need to also adopt the non-PCI
> driver to the new state machine.  I can give this a spin.
>
..

Thanks for handling non-PCI driver part.
