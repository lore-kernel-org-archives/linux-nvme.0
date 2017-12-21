From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 21 Dec 2017 09:36:49 +0100
Subject: [PATCH V2 6/6] nvme-pci: remove .init_request callback
In-Reply-To: <0fcf3176-7864-8631-e293-2bfa7aacea38@grimberg.me>
References: <20171214023103.18272-1-ming.lei@redhat.com>
 <20171214023103.18272-7-ming.lei@redhat.com>
 <0fcf3176-7864-8631-e293-2bfa7aacea38@grimberg.me>
Message-ID: <20171221083648.fuk3rvmisllwviph@linux-x5ow.site>

On Thu, Dec 21, 2017@10:20:45AM +0200, Sagi Grimberg wrote:
> @@ -2470,8 +2465,9 @@ static int nvme_probe(struct pci_dev *pdev, const
> struct pci_device_id *id)
>         dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
>         if (!dev)
>                 return -ENOMEM;
> -       dev->queues = kzalloc_node((num_possible_cpus() + 1) * sizeof(void
> *),
> -                                                       GFP_KERNEL, node);
> +
> +       alloc_size = (num_possible_cpus() + 1) * sizeof(struct nvme_queue
> *);
> +       dev->queues = kzalloc_node(alloc_size, GFP_KERNEL, node);

Nit:
	  dev->queues = kcalloc_node(num_possible_cpus() + 1,
				     sizeof(struct nvme_queue *),
				     node);
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
