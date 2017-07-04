From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 4 Jul 2017 12:57:55 +0300
Subject: [PATCH] nvme-rdma: stop keep_alive before nvme_uninit_ctrl
In-Reply-To: <ccbe95fe-0711-52a6-4fec-22c2c05bc3ef@grimberg.me>
References: <1498746799-34110-1-git-send-email-dmilburn@redhat.com>
 <ccbe95fe-0711-52a6-4fec-22c2c05bc3ef@grimberg.me>
Message-ID: <4df36509-7a2c-1f6e-6e5b-0dfc0573ed62@grimberg.me>

> How about the patch below?

Ping?

> -- 
> [PATCH] nvme: split nvme_uninit_ctrl into stop and uninit
> 
> Usually before we teardown the controller we want to:
> 1. complete/cancel any ctrl inflight works
> 2. remove ctrl namespaces
> 
> but we do not want to destroy the controller device as
> we might use it for logging during the teardown stage.
> 
> This patch adds nvme_start_ctrl() which queues inflight
> controller works (aen, ns scan, and keep-alive if kato is
> set) and nvme_stop_ctrl() which cancels them and remove
> controller namespaces (also expose __nvme_stop_ctrl for
> cases where we don't want to remove namespaces i.e.
> resets and fabrics error recovery.
> 
> We replace all the transports code that does:
> 
> if (ctrl->ctrl.queue_count > 1) {
>          nvme_queue_scan(ctrl)
>          nvme_queue_async_events(ctrl)
> }
> 
> and:
>          nvme_start_keep_alive(ctrl)
> 
> to:
>          nvme_start_ctrl()
> 
> we move nvme_uninit_ctrl to ->free_ctrl handler
> which makes better sense as it was initialized in
> probe (or crete_ctrl). and replace it with
> nvme_stop_ctrl (or __nvme_stop_ctrl where appropriate).
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> - This is on top of the move of queue_count to struct nvme_ctrl
> 
>   drivers/nvme/host/core.c   | 25 ++++++++++++++++++++++++-
>   drivers/nvme/host/fc.c     | 15 ++++-----------
>   drivers/nvme/host/nvme.h   |  3 +++
>   drivers/nvme/host/pci.c    | 15 +++------------
>   drivers/nvme/host/rdma.c   | 29 +++++++++--------------------
>   drivers/nvme/target/loop.c | 21 ++++++++-------------
>   6 files changed, 51 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d70df1d0072d..58e15fcb0d01 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2591,12 +2591,35 @@ static void nvme_release_instance(struct 
> nvme_ctrl *ctrl)
>          spin_unlock(&dev_list_lock);
>   }
> 
> -void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
> +void __nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   {
> +       nvme_stop_keep_alive(ctrl);
>          flush_work(&ctrl->async_event_work);
>          flush_work(&ctrl->scan_work);
> +}
> +EXPORT_SYMBOL_GPL(__nvme_stop_ctrl);
> +
> +void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> +{
> +       __nvme_stop_ctrl(ctrl);
>          nvme_remove_namespaces(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
> +
> +void nvme_start_ctrl(struct nvme_ctrl *ctrl)
> +{
> +       if (ctrl->kato)
> +               nvme_start_keep_alive(ctrl);
> 
> +       if (ctrl->queue_count > 1) {
> +               nvme_queue_scan(ctrl);
> +               nvme_queue_async_events(ctrl);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(nvme_start_ctrl);
> +
> +void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
> +{
>          device_destroy(nvme_class, MKDEV(nvme_char_major, 
> ctrl->instance));
> 
>          spin_lock(&dev_list_lock);
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index ffe0589969bd..979cbd456350 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2231,7 +2231,6 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
>   out_delete_hw_queues:
>          nvme_fc_delete_hw_io_queues(ctrl);
>   out_cleanup_blk_queue:
> -       nvme_stop_keep_alive(&ctrl->ctrl);
>          blk_cleanup_queue(ctrl->ctrl.connect_q);
>   out_free_tag_set:
>          blk_mq_free_tag_set(&ctrl->tag_set);
> @@ -2364,8 +2363,6 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>                  goto out_disconnect_admin_queue;
>          }
> 
> -       nvme_start_keep_alive(&ctrl->ctrl);
> -
>          /* FC-NVME supports normal SGL Data Block Descriptors */
> 
>          if (opts->queue_size > ctrl->ctrl.maxcmd) {
> @@ -2399,17 +2396,14 @@ nvme_fc_create_association(struct nvme_fc_ctrl 
> *ctrl)
> 
>          ctrl->ctrl.nr_reconnects = 0;
> 
> -       if (ctrl->ctrl.queue_count > 1) {
> +       nvme_start_ctrl(&ctrl->ctrl);
> +       if (ctrl->ctrl.queue_count > 1)
>                  nvme_start_queues(&ctrl->ctrl);
> -               nvme_queue_scan(&ctrl->ctrl);
> -               nvme_queue_async_events(&ctrl->ctrl);
> -       }
> 
>          return 0;       /* Success */
> 
>   out_term_aen_ops:
>          nvme_fc_term_aen_ops(ctrl);
> -       nvme_stop_keep_alive(&ctrl->ctrl);
>   out_disconnect_admin_queue:
>          /* send a Disconnect(association) LS to fc-nvme target */
>          nvme_fc_xmt_disconnect_assoc(ctrl);
> @@ -2432,8 +2426,6 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
>   {
>          unsigned long flags;
> 
> -       nvme_stop_keep_alive(&ctrl->ctrl);
> -
>          spin_lock_irqsave(&ctrl->lock, flags);
>          ctrl->flags |= FCCTRL_TERMIO;
>          ctrl->iocnt = 0;
> @@ -2515,7 +2507,7 @@ nvme_fc_delete_ctrl_work(struct work_struct *work)
> 
>          cancel_work_sync(&ctrl->ctrl.reset_work);
>          cancel_delayed_work_sync(&ctrl->connect_work);
> -
> +       nvme_stop_ctrl(&ctrl->ctrl);
>          /*
>           * kill the association on the link side.  this will block
>           * waiting for io to terminate
> @@ -2610,6 +2602,7 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
>                  container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
>          int ret;
> 
> +       __nvme_stop_ctrl(&ctrl->ctrl);
>          /* will block will waiting for io to terminate */
>          nvme_fc_delete_association(ctrl);
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index e0b83311d5de..232929d26c7f 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -280,6 +280,9 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
>   int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>                  const struct nvme_ctrl_ops *ops, unsigned long quirks);
>   void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
> +void nvme_start_ctrl(struct nvme_ctrl *ctrl);
> +void __nvme_stop_ctrl(struct nvme_ctrl *ctrl);
> +void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
>   void nvme_put_ctrl(struct nvme_ctrl *ctrl);
>   int nvme_init_identify(struct nvme_ctrl *ctrl);
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b995bf0e0e75..762cf2d1e953 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2048,6 +2048,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl 
> *ctrl)
>   {
>          struct nvme_dev *dev = to_nvme_dev(ctrl);
> 
> +       nvme_uninit_ctrl(ctrl);
>          nvme_dbbuf_dma_free(dev);
>          put_device(dev->dev);
>          if (dev->tagset.tags)
> @@ -2129,15 +2130,6 @@ static void nvme_reset_work(struct work_struct 
> *work)
>                  goto out;
> 
>          /*
> -        * A controller that can not execute IO typically requires user
> -        * intervention to correct. For such degraded controllers, the 
> driver
> -        * should not submit commands the user did not request, so skip
> -        * registering for asynchronous event notification on this 
> condition.
> -        */
> -       if (dev->online_queues > 1)
> -               nvme_queue_async_events(&dev->ctrl);
> -
> -       /*
>           * Keep the controller around but remove all namespaces if we 
> don't have
>           * any working I/O queue.
>           */
> @@ -2157,8 +2149,7 @@ static void nvme_reset_work(struct work_struct *work)
>                  goto out;
>          }
> 
> -       if (dev->online_queues > 1)
> -               nvme_queue_scan(&dev->ctrl);
> +       nvme_start_ctrl(&dev->ctrl);
>          return;
> 
>    out:
> @@ -2335,7 +2326,7 @@ static void nvme_remove(struct pci_dev *pdev)
>          }
> 
>          flush_work(&dev->ctrl.reset_work);
> -       nvme_uninit_ctrl(&dev->ctrl);
> +       nvme_stop_ctrl(&dev->ctrl);
>          nvme_dev_disable(dev, true);
>          nvme_free_host_mem(dev);
>          nvme_dev_remove_admin(dev);
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index cfb22531fc16..6f21b27fbf05 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -664,6 +664,8 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl 
> *nctrl)
>          if (list_empty(&ctrl->list))
>                  goto free_ctrl;
> 
> +       nvme_uninit_ctrl(nctrl);
> +
>          mutex_lock(&nvme_rdma_ctrl_mutex);
>          list_del(&ctrl->list);
>          mutex_unlock(&nvme_rdma_ctrl_mutex);
> @@ -731,8 +733,6 @@ static void nvme_rdma_reconnect_ctrl_work(struct 
> work_struct *work)
>          if (ret)
>                  goto requeue;
> 
> -       nvme_start_keep_alive(&ctrl->ctrl);
> -
>          if (ctrl->ctrl.queue_count > 1) {
>                  ret = nvme_rdma_init_io_queues(ctrl);
>                  if (ret)
> @@ -750,10 +750,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct 
> work_struct *work)
>          WARN_ON_ONCE(!changed);
>          ctrl->ctrl.nr_reconnects = 0;
> 
> -       if (ctrl->ctrl.queue_count > 1) {
> -               nvme_queue_scan(&ctrl->ctrl);
> -               nvme_queue_async_events(&ctrl->ctrl);
> -       }
> +       nvme_start_ctrl(&ctrl->ctrl);
> 
>          dev_info(ctrl->ctrl.device, "Successfully reconnected\n");
> 
> @@ -771,7 +768,7 @@ static void nvme_rdma_error_recovery_work(struct 
> work_struct *work)
>                          struct nvme_rdma_ctrl, err_work);
>          int i;
> 
> -       nvme_stop_keep_alive(&ctrl->ctrl);
> +       __nvme_stop_ctrl(&ctrl->ctrl);
> 
>          for (i = 0; i < ctrl->ctrl.queue_count; i++)
>                  clear_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
> @@ -1603,8 +1600,6 @@ static int nvme_rdma_configure_admin_queue(struct 
> nvme_rdma_ctrl *ctrl)
>          if (error)
>                  goto out_cleanup_queue;
> 
> -       nvme_start_keep_alive(&ctrl->ctrl);
> -
>          return 0;
> 
>   out_cleanup_queue:
> @@ -1622,7 +1617,6 @@ static int nvme_rdma_configure_admin_queue(struct 
> nvme_rdma_ctrl *ctrl)
> 
>   static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
>   {
> -       nvme_stop_keep_alive(&ctrl->ctrl);
>          cancel_work_sync(&ctrl->err_work);
>          cancel_delayed_work_sync(&ctrl->reconnect_work);
> 
> @@ -1644,7 +1638,7 @@ static void nvme_rdma_shutdown_ctrl(struct 
> nvme_rdma_ctrl *ctrl)
> 
>   static void __nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl, bool 
> shutdown)
>   {
> -       nvme_uninit_ctrl(&ctrl->ctrl);
> +       nvme_stop_ctrl(&ctrl->ctrl);
>          if (shutdown)
>                  nvme_rdma_shutdown_ctrl(ctrl);
> 
> @@ -1709,6 +1703,7 @@ static void nvme_rdma_reset_ctrl_work(struct 
> work_struct *work)
>          int ret;
>          bool changed;
> 
> +       __nvme_stop_ctrl(&ctrl->ctrl);
>          nvme_rdma_shutdown_ctrl(ctrl);
> 
>          ret = nvme_rdma_configure_admin_queue(ctrl);
> @@ -1738,11 +1733,9 @@ static void nvme_rdma_reset_ctrl_work(struct 
> work_struct *work)
>          changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
>          WARN_ON_ONCE(!changed);
> 
> -       if (ctrl->ctrl.queue_count > 1) {
> +       nvme_start_ctrl(&ctrl->ctrl);
> +       if (ctrl->ctrl.queue_count > 1)
>                  nvme_start_queues(&ctrl->ctrl);
> -               nvme_queue_scan(&ctrl->ctrl);
> -               nvme_queue_async_events(&ctrl->ctrl);
> -       }
> 
>          return;
> 
> @@ -1930,15 +1923,11 @@ static struct nvme_ctrl 
> *nvme_rdma_create_ctrl(struct device *dev,
>          list_add_tail(&ctrl->list, &nvme_rdma_ctrl_list);
>          mutex_unlock(&nvme_rdma_ctrl_mutex);
> 
> -       if (ctrl->ctrl.queue_count > 1) {
> -               nvme_queue_scan(&ctrl->ctrl);
> -               nvme_queue_async_events(&ctrl->ctrl);
> -       }
> +       nvme_start_ctrl(&ctrl->ctrl);
> 
>          return &ctrl->ctrl;
> 
>   out_remove_admin_queue:
> -       nvme_stop_keep_alive(&ctrl->ctrl);
>          nvme_rdma_destroy_admin_queue(ctrl);
>   out_kfree_queues:
>          kfree(ctrl->queues);
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index 3d51341e62ee..b28f8504cb2a 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -287,6 +287,8 @@ static void nvme_loop_free_ctrl(struct nvme_ctrl 
> *nctrl)
>          if (list_empty(&ctrl->list))
>                  goto free_ctrl;
> 
> +       nvme_uninit_ctrl(nctrl);
> +
>          mutex_lock(&nvme_loop_ctrl_mutex);
>          list_del(&ctrl->list);
>          mutex_unlock(&nvme_loop_ctrl_mutex);
> @@ -407,8 +409,6 @@ static int nvme_loop_configure_admin_queue(struct 
> nvme_loop_ctrl *ctrl)
>          if (error)
>                  goto out_cleanup_queue;
> 
> -       nvme_start_keep_alive(&ctrl->ctrl);
> -
>          return 0;
> 
>   out_cleanup_queue:
> @@ -422,8 +422,6 @@ static int nvme_loop_configure_admin_queue(struct 
> nvme_loop_ctrl *ctrl)
> 
>   static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
>   {
> -       nvme_stop_keep_alive(&ctrl->ctrl);
> -
>          if (ctrl->ctrl.queue_count > 1) {
>                  nvme_stop_queues(&ctrl->ctrl);
>                  blk_mq_tagset_busy_iter(&ctrl->tag_set,
> @@ -445,7 +443,7 @@ static void nvme_loop_del_ctrl_work(struct 
> work_struct *work)
>          struct nvme_loop_ctrl *ctrl = container_of(work,
>                                  struct nvme_loop_ctrl, delete_work);
> 
> -       nvme_uninit_ctrl(&ctrl->ctrl);
> +       nvme_stop_ctrl(&ctrl->ctrl);
>          nvme_loop_shutdown_ctrl(ctrl);
>          nvme_put_ctrl(&ctrl->ctrl);
>   }
> @@ -494,6 +492,7 @@ static void nvme_loop_reset_ctrl_work(struct 
> work_struct *work)
>          bool changed;
>          int ret;
> 
> +       __nvme_stop_ctrl(&ctrl->ctrl);
>          nvme_loop_shutdown_ctrl(ctrl);
> 
>          ret = nvme_loop_configure_admin_queue(ctrl);
> @@ -514,10 +513,9 @@ static void nvme_loop_reset_ctrl_work(struct 
> work_struct *work)
>          changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
>          WARN_ON_ONCE(!changed);
> 
> -       nvme_queue_scan(&ctrl->ctrl);
> -       nvme_queue_async_events(&ctrl->ctrl);
> -
> -       nvme_start_queues(&ctrl->ctrl);
> +       nvme_start_ctrl(&ctrl->ctrl);
> +       if (ctrl->ctrl.queue_count > 1)
> +               nvme_start_queues(&ctrl->ctrl);
> 
>          return;
> 
> @@ -652,10 +650,7 @@ static struct nvme_ctrl 
> *nvme_loop_create_ctrl(struct device *dev,
>          list_add_tail(&ctrl->list, &nvme_loop_ctrl_list);
>          mutex_unlock(&nvme_loop_ctrl_mutex);
> 
> -       if (opts->nr_io_queues) {
> -               nvme_queue_scan(&ctrl->ctrl);
> -               nvme_queue_async_events(&ctrl->ctrl);
> -       }
> +       nvme_start_ctrl(&ctrl->ctrl);
> 
>          return &ctrl->ctrl;
> 
> -- 
