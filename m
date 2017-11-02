From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 2 Nov 2017 14:10:16 +0200
Subject: [PATCH] nvme-pci: avoid dereference of symbol from unloaded module
In-Reply-To: <20171102093624.20333-1-ming.lei@redhat.com>
References: <20171102093624.20333-1-ming.lei@redhat.com>
Message-ID: <8b9a2473-c011-6224-b69a-61194cfac030@grimberg.me>


> The 'remove_work' may be scheduled to run after nvme_remove()
> returns since we can't simply cancel it in nvme_remove() for
> avoiding deadlock. Once nvme_remove() returns, this module(nvme)
> can be unloaded.
> 
> On the other hand, nvme_put_ctrl() calls ctr->ops->free_ctrl
> which may point to nvme_pci_free_ctrl() in unloaded module.
> 
> This patch avoids this issue by holding the module refcount before
> scheduling 'remove_work'.

Why not simply flushing all scheduled works in module exit?
