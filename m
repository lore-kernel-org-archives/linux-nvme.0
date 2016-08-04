From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 04 Aug 2016 10:08:28 -0700
Subject: [PATCH RFC] nvme-rdma: Queue ns scanning after a sucessful
 reconnection
In-Reply-To: <1469980540-16103-1-git-send-email-sagi@grimberg.me>
References: <1469980540-16103-1-git-send-email-sagi@grimberg.me>
Message-ID: <1470330508.19927.18.camel@linux.intel.com>

On Sun, 2016-07-31@18:55 +0300, Sagi Grimberg wrote:
> On an ordered target shutdown, the target can send a AEN on a
> namespace
> removal, this will trigger the host to queue ns-list query. The
> shutdown
> will trigger error recovery which will attepmt periodic reconnect.
> 
> We can hit a race where the ns rescanning fails (error recovery
> kicked
> in and we're not connected) causing removing all the namespaces and
> when
> we reconnect we won't see any namespaces for this controller.
> 
> So, queue a namespace rescan after we successfully reconnected to the
> target.
> 
> Note, that unlike user initiated controller reset, we don't need to
> trigger
> namespace scanning (until the point I noticed the above at least)
> because we
> reconnect to an existing controller. However due to the interaction
> with
> the aen mechanism we queue ns scan here as well.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> I'm open to other suggestions if anyone has any...

this sounds like a fix that should really go in the core target code
instead of RDMA code as this could affect any implementation layer.

If the target is shutting down I'm not sure why it would enter error
recovery which would attempt a reconnect. ?If the target is shutting
down, shut down. ?Maybe the keep-alive timer needs to stop
(nvmet_stop_keep_alive_timer()???). I could see the benefit of the
target emitting an AEN to tell the host to rescan for namespaces so it
doesn't keep a stale list of namespaces after shutdown.

My 2.5 cents...

> 
> ?drivers/nvme/host/rdma.c | 4 +++-
> ?1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index f8539dd75504..5cb069ab27ed 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -743,8 +743,10 @@ static void nvme_rdma_reconnect_ctrl_work(struct
> work_struct *work)
> ?	changed = nvme_change_ctrl_state(&ctrl->ctrl,
> NVME_CTRL_LIVE);
> ?	WARN_ON_ONCE(!changed);
> ?
> -	if (ctrl->queue_count > 1)
> +	if (ctrl->queue_count > 1) {
> ?		nvme_start_queues(&ctrl->ctrl);
> +		nvme_queue_scan(&ctrl->ctrl);
> +	}
> ?
> ?	dev_info(ctrl->ctrl.device, "Successfully reconnected\n");
> ?
