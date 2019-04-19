From: yuyufen@huawei.com (yuyufen)
Date: Fri, 19 Apr 2019 20:28:31 +0800
Subject: [PATCH RFC] nvme: fix race condition between remove and scan_work
In-Reply-To: <20190411133227.28435-1-yuyufen@huawei.com>
References: <20190411133227.28435-1-yuyufen@huawei.com>
Message-ID: <31b1265e-ee5f-d8e1-d69b-68209cf04d5b@huawei.com>

ping ?


On 2019/4/11 21:32, Yufen Yu wrote:
> There is a race condition between nvme_remove and nvme_scan_work, as
> following:
>
> sysfs_kr_wirte
> nvme_remove            nvme_queue_scan            timeout_worker
>                         queue scan_work
>
>                         nvme_scan_work
>
> set NVME_CTRL_DELETING
> flush_work(&ctrl->scan_work)
> wait_for_completion scan_work
>
>                         nvme_scan_ns_list
>                          nvme_validate_ns
>                           nvme_submit_sync_cmd(admin_q)
>                            IO timeout
>                                                    nvme_timeout
>                                                     nvme_dev_disable
>                                                      nvme_suspend_queue(admin_q)
>                                                       blk_mq_quiesce_queue
>
>                                                     nvme_reset_ctrl
>                                                      return -EBUSY
>                         nvme_scan_ns_sequential
>                           nvme_submit_sync_cmd(admin_q)
>                            IO cannnot issue, as admin_q suspend
>                           wait_for_completion_io_timeout
>
> nvme_remove() wait for nvme_scan_work() finish, and scan_work wait for
> io complete. When a previous IO issued in scan_work has timeout,
> nvme_timeout() will suspend admin queue and make the queue in quiesce state.
>
> Since nvme controller state is 'NVME_CTRL_DELETING', nvme_reset_ctrl()
> can not start reset work to recovery admin queue. Then, the next io request
> issued to admin_q will be stalled in blk-mq 'ctx' queue forever.
> As a result, both of remove and scan_work threads are stuck!
>
> We fix this problem by adding manual recovery admin queue after
> nvme_reset_ctrl return -EBUSY. Since ctrl.admin_q has been flags
> 'NVMEQ_ENABLED', all requests issused will return as io error.
>
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: James Smart <james.smart at broadcom.com>
> Cc: Bart Van Assche <bvanassche at acm.org>
> Signed-off-by: Yufen Yu <yuyufen at huawei.com>
> ---
>   drivers/nvme/host/pci.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a90cf5d63aac..77807515d0e3 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1272,6 +1272,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>   	struct request *abort_req;
>   	struct nvme_command cmd;
>   	u32 csts = readl(dev->bar + NVME_REG_CSTS);
> +	int error = 0;
>   
>   	/* If PCI error recovery process is happening, we cannot reset or
>   	 * the recovery mechanism will surely fail.
> @@ -1329,7 +1330,13 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>   			 "I/O %d QID %d timeout, reset controller\n",
>   			 req->tag, nvmeq->qid);
>   		nvme_dev_disable(dev, false);
> -		nvme_reset_ctrl(&dev->ctrl);
> +		/*
> +		 * If reset ctrl fail, we need to drain all requests in ctx
> +		 * and elevator, avoiding io stuck forever.
> +		 */
> +		error = nvme_reset_ctrl(&dev->ctrl);
> +		if (error)
> +			blk_mq_unquiesce_queue(dev->ctrl.admin_q);
>   
>   		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>   		return BLK_EH_DONE;
