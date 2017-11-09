From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 9 Nov 2017 12:32:14 +0200
Subject: [PATCH] nvme-pci: avoid dereference of symbol from unloaded module
In-Reply-To: <20171109011347.GA14520@ming.t460p>
References: <20171102093624.20333-1-ming.lei@redhat.com>
 <8b9a2473-c011-6224-b69a-61194cfac030@grimberg.me>
 <20171102122926.GB6764@ming.t460p> <20171108181531.GA6606@infradead.org>
 <20171109011347.GA14520@ming.t460p>
Message-ID: <8f14bbdb-b00b-7b9e-cda8-a7f02b2d901a@grimberg.me>


> If 'remove_work' can be queued via 'nvme_wq', I think it is doable to
> call flush_workqueue(nvme_wq) in nvme_exit(): drivers/nvme/host/pci.c.

Lets do that.
