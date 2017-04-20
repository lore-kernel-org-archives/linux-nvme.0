From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Apr 2017 19:19:25 +0300
Subject: [PATCH 4/4] nvme/pci: switch to pci_request_irq
In-Reply-To: <20170413200255.GB22775@localhost.localdomain>
References: <20170413070643.32165-1-hch@lst.de>
 <20170413070643.32165-5-hch@lst.de>
 <20170413200255.GB22775@localhost.localdomain>
Message-ID: <e288a5fd-a30f-2b11-1051-e39feca3a652@grimberg.me>

> This is great. As an added bonus, more of struct nvme_queue's hot values
> are in the same cache line!
>
> Reviewed-by: Keith Busch <keith.busch at intel.com>

I think I can kill off for mlx5 as well.

Very useful Christoph!

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
