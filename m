From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 3 Dec 2018 16:58:25 -0800
Subject: [PATCH 05/13] nvme-pci: consolidate code for polling
 non-dedicated queues
In-Reply-To: <20181202164628.1116-6-hch@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-6-hch@lst.de>
Message-ID: <9abd8fde-58c4-0704-1e42-d066b674bb90@grimberg.me>


> +static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)

Do we still need to carry the tag around?

Other than that,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
