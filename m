From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 8 Jun 2016 06:04:32 -0700
Subject: [PATCH v2] NVMe: Add controller state for scheduling resets
In-Reply-To: <57580B88.4000904@lightbits.io>
References: <1464729484-14424-1-git-send-email-keith.busch@intel.com>
 <575808AC.2030004@lightbits.io>
 <20160608120329.GA20526@infradead.org>
 <57580B88.4000904@lightbits.io>
Message-ID: <20160608130432.GA22594@infradead.org>

On Wed, Jun 08, 2016@03:11:52PM +0300, Sagi Grimberg wrote:
> >Don't worry, I have an almost ready patch series to pull this change
> >it in, it actually helps for fabrics as well.
> 
> OK, I'll be waiting to see it then :)

The changes are fairly big and in hairy code, so my life would be a lot
simpler if the whole series could go in after the initial fabrics merge.
