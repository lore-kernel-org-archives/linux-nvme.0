Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4B6C7EE23
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 00:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oa/batTfuDbTN7EdCi4bb/OoUkOQxXXpvbeU0HCg4j8=; b=wD3TAyBSmTM+RQNMs8id49BAZV
	a6C2GJ2MCH28C210fUB+y5NIq/S8yeq4BLnQsiM0lTvxuXZRJwVu/+P6UjVO3XzKP6F0ZieFq4i+l
	3EP05lGHf85xjRF7m0JKUlj6HeDD0etJmnClNr0/xaNvw2uZS2qsL28vMcK0t8TiYr2BD1g9VLsYF
	+F1ZaV+xTA6qqUNOwFHCgVgc681jd4SFxNRwmpyhoxMLerKvBXh/1JpfQ3ekXfG39dgp72zwkD0HJ
	lMBB7gRTkd3BM9Gyboa05WwdzVtlTDSBe9td9fqyQ3Ett4V936WMY4ka0lM3BHJED8uMMJJjs9wZ1
	XcGvXxBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Kv1-00HGtP-0u;
	Tue, 06 Jun 2023 00:51:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Kuy-00HGsp-04
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 00:51:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686012682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oa/batTfuDbTN7EdCi4bb/OoUkOQxXXpvbeU0HCg4j8=;
	b=cm90zuMWvPIt6u/653u6vbb5O4HD703nyK6sZsgWZ6rGeA9arn5OsAcYsidw8iVKStBSSf
	UkkuSvkntLRtTcUPdlh5MxFppT2Jb0hXKLIOpOO8leTxAutsqsQzJLCYtS7tyCKMGw4VfG
	q3dRBGVtu9a6rIE4zsHQnfMuuNaRYjc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-T-58THFFOzKZo617ecjv5A-1; Mon, 05 Jun 2023 20:51:16 -0400
X-MC-Unique: T-58THFFOzKZo617ecjv5A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78847811E86;
	Tue,  6 Jun 2023 00:51:16 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 07150C1603B;
	Tue,  6 Jun 2023 00:51:11 +0000 (UTC)
Date: Tue, 6 Jun 2023 08:51:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 1/2] nvme: add API of nvme_delete_dead_ctrl
Message-ID: <ZH6C+yiTOa+tu87w@ovpn-8-17.pek2.redhat.com>
References: <20230530094322.258090-1-ming.lei@redhat.com>
 <20230530094322.258090-2-ming.lei@redhat.com>
 <5ac19a92-bfc8-1e1e-a37d-983f19217df7@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ac19a92-bfc8-1e1e-a37d-983f19217df7@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_175124_155621_DFE3CF8C 
X-CRM114-Status: GOOD (  39.31  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 06, 2023 at 12:48:32AM +0300, Sagi Grimberg wrote:
> 
> > When driver confirms that the controller is dead, this controller should
> > be deleted with marking as DEAD. Otherwise, upper layer may wait forever
> > in __bio_queue_enter() since the disk won't be marked as DEAD.
> > Especially, in del_gendisk(), disk won't be marked as DEAD unless bdev
> > sync & invalidate returns. If any writeback IO waits in
> > __bio_queue_enter(), IO deadlock is caused.
> > 
> > Add nvme_delete_dead_ctrl() for avoiding such kind of io deadlock.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/nvme/host/core.c | 24 +++++++++++++++++++++++-
> >   drivers/nvme/host/nvme.h |  1 +
> >   2 files changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index ccb6eb1282f8..413213cfa417 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -227,16 +227,38 @@ static void nvme_delete_ctrl_work(struct work_struct *work)
> >   	nvme_do_delete_ctrl(ctrl);
> >   }
> > -int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
> > +static int __nvme_delete_ctrl(struct nvme_ctrl *ctrl,
> > +			      enum nvme_ctrl_state state)
> >   {
> > +	if (state != NVME_CTRL_DELETING && state != NVME_CTRL_DEAD)
> > +		return -EINVAL;
> > +
> >   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
> >   		return -EBUSY;
> > +	if (state == NVME_CTRL_DEAD) {
> > +		if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DEAD))
> > +			return -EBUSY;
> > +	}
> >   	if (!queue_work(nvme_delete_wq, &ctrl->delete_work))
> >   		return -EBUSY;
> >   	return 0;
> >   }
> 
> the user can trigger a delete in exactly the same condition as
> the transport (say a nanosecond before the transport exhaust
> the max_reconnects).

Yeah, the problem can be triggered when removing any NS which request
queue is frozen.

It it too fragile to call freeze_queue and unfreeze_queue in different
contexts since both two should have been done in strict pair, and
meantime I don't think freezing queues in nvme_rdma_teardown_io_queues()
is needed cause quiescing is supposed to be enough for driver to recover
controller.

And I guess the following approach(rdma only) should address the issue cleanly:

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0eb79696fb73..59352671aeb7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -919,6 +919,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)

        if (!new) {
                nvme_unquiesce_io_queues(&ctrl->ctrl);
+               nvme_start_freeze(&ctrl->ctrl);
                if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
                        /*
                         * If we timed out waiting for freeze we are likely to
@@ -926,6 +927,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
                         * to be safe.
                         */
                        ret = -ENODEV;
+                       nvme_unfreeze(&ctrl->ctrl);
                        goto out_wait_freeze_timed_out;
                }
                blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
@@ -975,7 +977,6 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
                bool remove)
 {
        if (ctrl->ctrl.queue_count > 1) {
-               nvme_start_freeze(&ctrl->ctrl);
                nvme_quiesce_io_queues(&ctrl->ctrl);
                nvme_sync_io_queues(&ctrl->ctrl);
                nvme_rdma_stop_io_queues(ctrl);

> 
> I think that we'd want something like
> --
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 841f155fe0b3..6c718ad46e06 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -231,6 +231,11 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
>  {
>         if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
>                 return -EBUSY;
> +
> +       if (ctrl->ops->transport_disconnected &&
> +           ctrl->ops->transport_disconnected(ctrl))
> +               nvme_change_ctrl_state(ctrl, NVME_CTRL_DEAD);
> +
>         if (!queue_work(nvme_delete_wq, &ctrl->delete_work))
>                 return -EBUSY;
>         return 0;
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 054bf2f8b1a1..657d3f79953d 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2828,6 +2828,13 @@ static bool nvme_pci_supports_pci_p2pdma(struct
> nvme_ctrl *ctrl)
>         return dma_pci_p2pdma_supported(dev->dev);
>  }
> 
> +static bool nvme_pci_disconnected(struct nvme_ctrl *nctrl)
> +{
> +       struct nvme_dev *dev = to_nvme_dev(ctrl);
> +
> +       return !pci_device_is_present(to_pci_dev(dev->dev));
> +}
> +
>  static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
>         .name                   = "pcie",
>         .module                 = THIS_MODULE,
> @@ -2841,6 +2848,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops =
> {
>         .get_address            = nvme_pci_get_address,
>         .print_device_info      = nvme_pci_print_device_info,
>         .supports_pci_p2pdma    = nvme_pci_supports_pci_p2pdma,
> +       .transport_disconnected = nvme_pci_disconnected,
>  };
> 
>  static int nvme_dev_map(struct nvme_dev *dev)
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 0eb79696fb73..2a03df693b0e 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2235,6 +2235,18 @@ static void nvme_rdma_reset_ctrl_work(struct
> work_struct *work)
>         nvme_rdma_reconnect_or_remove(ctrl);
>  }
> 
> +static bool nvme_rdma_disconnected(struct nvme_ctrl *nctrl)
> +{
> +       struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
> +       int i;
> +
> +       for (i = 0; i < ctrl->queue_count; i++) {
> +               if (test_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags))
> +                       return false;
> +       }
> +       return true;
> +}
> +
>  static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
>         .name                   = "rdma",
>         .module                 = THIS_MODULE,
> @@ -2247,6 +2259,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops =
> {
>         .delete_ctrl            = nvme_rdma_delete_ctrl,
>         .get_address            = nvmf_get_address,
>         .stop_ctrl              = nvme_rdma_stop_ctrl,
> +       .transport_disconnected = nvme_rdma_disconnected,
>  };
> 
>  /*
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index fe01ba75570d..043ce9878560 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2536,6 +2536,18 @@ static int nvme_tcp_get_address(struct nvme_ctrl
> *ctrl, char *buf, int size)
>         return len;
>  }
> 
> +static bool nvme_tcp_disconnected(struct nvme_ctrl *nctrl)
> +{
> +       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> +       int i;
> +
> +       for (i = 0; i < ctrl->queue_count; i++) {
> +               if (test_bit(NVME_TCP_Q_LIVE, &ctrl->queues[i].flags))
> +                       return false;
> +       }
> +       return true;
> +}
> +
>  static const struct blk_mq_ops nvme_tcp_mq_ops = {
>         .queue_rq       = nvme_tcp_queue_rq,
>         .commit_rqs     = nvme_tcp_commit_rqs,
> @@ -2569,6 +2581,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops =
> {
>         .delete_ctrl            = nvme_tcp_delete_ctrl,
>         .get_address            = nvme_tcp_get_address,
>         .stop_ctrl              = nvme_tcp_stop_ctrl,
> +       .transport_disconnected = nvme_tcp_disconnected,

This way is too violent. The current queue/device status does not mean
the controller/queue is really dead cause recovering is in in-progress,
and we should call blk_mark_disk_dead() in case that controller is confirmed
as DEAD.


Thanks,
Ming


