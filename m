From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 2 Nov 2017 20:29:27 +0800
Subject: [PATCH] nvme-pci: avoid dereference of symbol from unloaded module
In-Reply-To: <8b9a2473-c011-6224-b69a-61194cfac030@grimberg.me>
References: <20171102093624.20333-1-ming.lei@redhat.com>
 <8b9a2473-c011-6224-b69a-61194cfac030@grimberg.me>
Message-ID: <20171102122926.GB6764@ming.t460p>

On Thu, Nov 02, 2017@02:10:16PM +0200, Sagi Grimberg wrote:
> 
> > The 'remove_work' may be scheduled to run after nvme_remove()
> > returns since we can't simply cancel it in nvme_remove() for
> > avoiding deadlock. Once nvme_remove() returns, this module(nvme)
> > can be unloaded.
> > 
> > On the other hand, nvme_put_ctrl() calls ctr->ops->free_ctrl
> > which may point to nvme_pci_free_ctrl() in unloaded module.
> > 
> > This patch avoids this issue by holding the module refcount before
> > scheduling 'remove_work'.
> 
> Why not simply flushing all scheduled works in module exit?

The nvme_wq is shared by all kinds of host(PCI, FC, ...), so
not good to flush all queued work in 'nvme_wq' just before
removing pci host module only.

Not mention 'remove_work' is actually scheduled by system wq
instead of nvme_wq.

-- 
Ming
