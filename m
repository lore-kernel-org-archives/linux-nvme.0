From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 3 Dec 2018 16:54:15 -0800
Subject: [PATCH 02/13] nvme-pci: use atomic bitops to mark a queue enabled
In-Reply-To: <20181202164628.1116-3-hch@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-3-hch@lst.de>
Message-ID: <1ad65e6d-8b42-6f8e-8eb7-0b28b04e5dd4@grimberg.me>


> @@ -2173,6 +2157,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>   
>   	if (nr_io_queues == 0)
>   		return 0;
> +	
> +	clear_bit(NVMEQ_ENABLED, &adminq->flags);
>   

This is a change of behavior, looks correct though as we can fail
nvme_setup_irqs after we freed the admin vector. Needs documentation 
though..
