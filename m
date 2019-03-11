From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 11 Mar 2019 16:33:26 -0700
Subject: [PATCH 2/8] nvme/pci: Don't poll polled queues in timeout
In-Reply-To: <20190308174313.5134-2-keith.busch@intel.com>
References: <20190308174313.5134-1-keith.busch@intel.com>
 <20190308174313.5134-2-keith.busch@intel.com>
Message-ID: <f22b0a17-8a18-f5b8-d4ec-2223495a010c@grimberg.me>


> Polled queues are already polled. If a timeout occurs on such a queue,
> escalate the error recovery immediately.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   drivers/nvme/host/pci.c | 20 +++++---------------
>   1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d12b2861bdcc..e72e34b0b441 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1077,20 +1077,9 @@ static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
>   	u16 start, end;
>   	int found;
>   
> -	/*
> -	 * For a poll queue we need to protect against the polling thread
> -	 * using the CQ lock.  For normal interrupt driven threads we have
> -	 * to disable the interrupt to avoid racing with it.
> -	 */
> -	if (nvmeq->cq_vector == -1) {
> -		spin_lock(&nvmeq->cq_poll_lock);
> -		found = nvme_process_cq(nvmeq, &start, &end, tag);
> -		spin_unlock(&nvmeq->cq_poll_lock);
> -	} else {
> -		disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
> -		found = nvme_process_cq(nvmeq, &start, &end, tag);
> -		enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
> -	}
> +	disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
> +	found = nvme_process_cq(nvmeq, &start, &end, tag);
> +	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));

Why do polled queues need irq disable?

>   
>   	nvme_complete_cqes(nvmeq, start, end);
>   	return found;
> @@ -1284,7 +1273,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>   	/*
>   	 * Did we miss an interrupt?
>   	 */
> -	if (nvme_poll_irqdisable(nvmeq, req->tag)) {
> +	if (!test_bit(NVMEQ_POLLED, &nvmeq->flags) &&
> +	    nvme_poll_irqdisable(nvmeq, req->tag)) {
>   		dev_warn(dev->ctrl.device,
>   			 "I/O %d QID %d timeout, completion polled\n",
>   			 req->tag, nvmeq->qid);
> 
