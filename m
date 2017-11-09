From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 9 Nov 2017 09:13:54 +0800
Subject: [PATCH] nvme-pci: avoid dereference of symbol from unloaded module
In-Reply-To: <20171108181531.GA6606@infradead.org>
References: <20171102093624.20333-1-ming.lei@redhat.com>
 <8b9a2473-c011-6224-b69a-61194cfac030@grimberg.me>
 <20171102122926.GB6764@ming.t460p>
 <20171108181531.GA6606@infradead.org>
Message-ID: <20171109011347.GA14520@ming.t460p>

On Wed, Nov 08, 2017@10:15:31AM -0800, Christoph Hellwig wrote:
> On Thu, Nov 02, 2017@08:29:27PM +0800, Ming Lei wrote:
> > On Thu, Nov 02, 2017@02:10:16PM +0200, Sagi Grimberg wrote:
> > > 
> > > > The 'remove_work' may be scheduled to run after nvme_remove()
> > > > returns since we can't simply cancel it in nvme_remove() for
> > > > avoiding deadlock. Once nvme_remove() returns, this module(nvme)
> > > > can be unloaded.
> > > > 
> > > > On the other hand, nvme_put_ctrl() calls ctr->ops->free_ctrl
> > > > which may point to nvme_pci_free_ctrl() in unloaded module.
> > > > 
> > > > This patch avoids this issue by holding the module refcount before
> > > > scheduling 'remove_work'.
> > > 
> > > Why not simply flushing all scheduled works in module exit?
> > 
> > The nvme_wq is shared by all kinds of host(PCI, FC, ...), so
> > not good to flush all queued work in 'nvme_wq' just before
> > removing pci host module only.
> > 
> > Not mention 'remove_work' is actually scheduled by system wq
> > instead of nvme_wq.
> 
> Still seems better than messing with module reference counts.

If 'remove_work' can be queued via 'nvme_wq', I think it is doable to
call flush_workqueue(nvme_wq) in nvme_exit(): drivers/nvme/host/pci.c.

Otherwise, it may not be a good idea to flush the global wq, please
see comment of 'flush_scheduled_work()'.

-- 
Ming
