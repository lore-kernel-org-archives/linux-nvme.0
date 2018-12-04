From: hch@lst.de (Christoph Hellwig)
Date: Tue, 4 Dec 2018 16:04:49 +0100
Subject: [PATCH 05/13] nvme-pci: consolidate code for polling
 non-dedicated queues
In-Reply-To: <9abd8fde-58c4-0704-1e42-d066b674bb90@grimberg.me>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-6-hch@lst.de>
 <9abd8fde-58c4-0704-1e42-d066b674bb90@grimberg.me>
Message-ID: <20181204150449.GB3630@lst.de>

On Mon, Dec 03, 2018@04:58:25PM -0800, Sagi Grimberg wrote:
>
>> +static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
>
> Do we still need to carry the tag around?

Yes, the timeout handler polls for a specific tag.
