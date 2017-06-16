From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 09:05:48 +0200
Subject: [PATCH 3/3] nvme-pci: open-code polling logic in nvme_poll
In-Reply-To: <1497548508-29447-4-git-send-email-sagi@grimberg.me>
References: <1497548508-29447-1-git-send-email-sagi@grimberg.me>
 <1497548508-29447-4-git-send-email-sagi@grimberg.me>
Message-ID: <20170616070548.GC7672@lst.de>

>  static int nvme_process_cq(struct nvme_queue *nvmeq)
>  {
> -	return __nvme_process_cq(nvmeq, INT_MAX, NULL);
> +	return __nvme_process_cq(nvmeq, INT_MAX);

At this point __nvme_process_cq and nvme_process_cq can be merged.

>  static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
>  {
> +	struct nvme_completion cqe;
> +	int found = 0, consumed = 0;

found should be a bool.


Otherwise this looks fine to me.
