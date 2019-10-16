Return-Path: <SRS0=91TP=YJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935DAECE58F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2019 00:57:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 641982067B
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2019 00:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QimNgi+d";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzyvyRsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641982067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=snUOpzaY1vJoTpH09zuj5kJASp5rZQALV75q5sHPPk8=; b=QimNgi+d0NyK+F
	YxkTNe2YgFOuoVgZFI0B2+eZrrXeUKK9/8MKdYgIIyUBAVOg08Wxgosp6FLjT+9vDGQoLmWdVapTt
	kQ3MUfIXcLiQzD8umT+yVV7jkeLUFvqWq6kquQctmNZIJecBQMiirJgncC6+bfR4mJpZv1FLylKjI
	iBYKFYuruLoMvs+VL70yOY2yAp4XgFOpScobXnpRdY610Dfy0Hk1dqM0VTGBavSIoSl+0QFqDIEVl
	4SkvWZQySNr8qnMZuAE5Sms+dA8/Ke5EBci6SDQN6f8fgDPg8CVTgV4y8VKTtt7eszvrhEXpx3r6M
	mNrKQozCMEg014CWJ3qg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iKXck-0000W8-O6; Wed, 16 Oct 2019 00:57:10 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iKXcg-0000PF-3m
 for linux-nvme@lists.infradead.org; Wed, 16 Oct 2019 00:57:08 +0000
Received: by mail-pg1-x543.google.com with SMTP id p30so13201302pgl.2
 for <linux-nvme@lists.infradead.org>; Tue, 15 Oct 2019 17:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=IpHvrthCfpNO4coTJ0vcOkgiCBkupibPbiJPZk6Ta8Q=;
 b=kzyvyRsRVKQMsgMrF/uJsvyYkk6FD6cq5pOwiEhRaq5pYb8WCyxz2HgkUNqh7huVlK
 POIQpLAxjob4UHyGG+5PuDeTYivtohFtjgfrzTM80FPI3uuLZpxPJqeLI+ipFVIurdkf
 6rI7J8IGmLD0YbQDH5ByrCubtvS2dltbdxJmug0decaK4a6rnMnWjezCYBH9jJuawTTp
 82U/ou2Vt02kxnG6hql8Nnhdu71qCKCkuP4EV1EQqPiRDDfSdjtsrE01jKaAlp/+j1Ki
 DuHZuvrTOPZt28TFBefJrpe+PiWsLvGRD1iYrYPp9Gbp76ABKgLIrXo4S2l3JOOI6UIN
 7HEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IpHvrthCfpNO4coTJ0vcOkgiCBkupibPbiJPZk6Ta8Q=;
 b=g4zQyzOwCJNzxT6LrLY29MbGw9BS/Fyi9idlTxJsb+/vYDgfdPduGRlcLqSpHmYdQK
 A3ka6V04meYf1lGNYD6oiJu5PAA67ol4qaCdLNTXBAeCpR6EERbImITDEpLaFI+8K6FC
 D9A9H8zxKjqRKb4Pq/8TOza4iJTYT2ZazmRn8F5cUm6KxhFmZMcbL/eiaGwrLyG11jDP
 JWo6QRxaG+GTL3Yj+0C2lIMiMPt+OPMvho8p/JUjpqfyymMcNZIGaHwGPiAji+wKFEZ5
 M0j1iRpJBi1AqMZ1NXVDgV0aex7Ggk8Yv966Jf6sQy7zGNGbfek0PYLnAz4cxXdYRJJ/
 Cp0A==
X-Gm-Message-State: APjAAAW5V6xPJDcuhuA9KACLNvr/ugiLHRNefsyi6MJ9lPBU4fKssSM9
 zJ5sG1svYJsyK06dky1GFio=
X-Google-Smtp-Source: APXvYqy1UhklEY+9oNntEdcy951k8hJB+k2ZVnxg2d0CFEvBoNRJ44e9GaeLWvsEE8jIBIo9PMkNHA==
X-Received: by 2002:a17:90a:a416:: with SMTP id
 y22mr1619028pjp.74.1571187420914; 
 Tue, 15 Oct 2019 17:57:00 -0700 (PDT)
Received: from localhost (220-245-223-235.tpgi.com.au. [220.245.223.235])
 by smtp.gmail.com with ESMTPSA id p17sm21414782pfn.50.2019.10.15.17.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 17:56:59 -0700 (PDT)
Date: Wed, 16 Oct 2019 11:56:57 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 5/5] nvme: Wait for reset state when required
Message-ID: <20191016005247.GA18485@balbir-desktop>
References: <20191010165736.12081-1-kbusch@kernel.org>
 <20191010165736.12081-6-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191010165736.12081-6-kbusch@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191015_175706_160857_CB4560F7 
X-CRM114-Status: GOOD (  23.97  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Edmund Nadolski <edmund.nadolski@intel.com>,
 Judy Brock <judy.brock@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Oct 11, 2019 at 01:57:36AM +0900, Keith Busch wrote:
> Prevent simultaneous controller disabling/enabling tasks from interfering
> with each other through a method to wait until the task successfully
> transitioned the controller to the RESETTING state. This ensures disabling
> the controller will not be interrupted by another reset path, otherwise
> a concurrent reset would leave the controller in the wrong state.
> 

Yes, I've run into this when nvme_core.io_timeout is smaller than the
time required to wait on reset (CTS.RDY) and multiple resets occur one
after the other.

> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 41 +++++++++++++++++++++++++++++++++--
>  drivers/nvme/host/nvme.h |  4 ++++
>  drivers/nvme/host/pci.c  | 46 +++++++++++++++++++++++++++-------------
>  3 files changed, 74 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0f5a82b7d3a4..7442c99a5ed7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -126,7 +126,7 @@ static void nvme_queue_scan(struct nvme_ctrl *ctrl)
>   * code paths that can't be interrupted by other reset attempts. A hot removal
>   * may prevent this from succeeding.
>   */
> -static int nvme_try_sched_reset(struct nvme_ctrl *ctrl)
> +int nvme_try_sched_reset(struct nvme_ctrl *ctrl)
>  {
>  	if (ctrl->state != NVME_CTRL_RESETTING)
>  		return -EBUSY;
> @@ -134,6 +134,7 @@ static int nvme_try_sched_reset(struct nvme_ctrl *ctrl)
>  		return -EBUSY;
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(nvme_try_sched_reset);
>  
>  int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>  {
> @@ -384,8 +385,10 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>  		break;
>  	}
>  
> -	if (changed)
> +	if (changed) {
>  		ctrl->state = new_state;
> +		wake_up_all(&ctrl->state_wq);
> +	}

Shouldn't we wake up only if the new_state is terminal or if the
new_state is NVME_CTRL_RESETTING?

>  
>  	spin_unlock_irqrestore(&ctrl->lock, flags);
>  	if (changed && ctrl->state == NVME_CTRL_LIVE)
> @@ -394,6 +397,39 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>  }
>  EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
>  
> +/*
> + * Returns true for sink states that can't ever transition back to live.
> + */
> +static bool nvme_state_terminal(struct nvme_ctrl *ctrl)
> +{
> +	switch (ctrl->state) {
> +	case NVME_CTRL_NEW:
> +	case NVME_CTRL_LIVE:
> +	case NVME_CTRL_RESETTING:
> +	case NVME_CTRL_CONNECTING:
> +		return false;
> +	case NVME_CTRL_DELETING:
> +	case NVME_CTRL_DEAD:
> +		return true;
> +	default:
> +		WARN_ONCE(1, "Unhandled ctrl state:%d", ctrl->state);
> +		return true;
> +	}
> +}
> +
> +/*
> + * Waits for the controller state to be resetting, or returns false if it is
> + * not possible to ever transition to that state.
> + */
> +bool nvme_wait_reset(struct nvme_ctrl *ctrl)
> +{
> +	wait_event(ctrl->state_wq,
> +		   nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING) ||

Would we expect this nvme_change_ctrl_state to cause a wake_up_all()
right away?

> +		   nvme_state_terminal(ctrl));
> +	return ctrl->state == NVME_CTRL_RESETTING;
> +}
> +EXPORT_SYMBOL_GPL(nvme_wait_reset);
> +
>  static void nvme_free_ns_head(struct kref *ref)
>  {
>  	struct nvme_ns_head *head =
> @@ -3999,6 +4035,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>  	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
>  	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
>  	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
> +	init_waitqueue_head(&ctrl->state_wq);
>  
>  	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
>  	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 2ba577271ada..22e8401352c2 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -15,6 +15,7 @@
>  #include <linux/sed-opal.h>
>  #include <linux/fault-inject.h>
>  #include <linux/rcupdate.h>
> +#include <linux/wait.h>
>  
>  #include <trace/events/block.h>
>  
> @@ -198,6 +199,7 @@ struct nvme_ctrl {
>  	struct cdev cdev;
>  	struct work_struct reset_work;
>  	struct work_struct delete_work;
> +	wait_queue_head_t state_wq;
>  
>  	struct nvme_subsystem *subsys;
>  	struct list_head subsys_entry;
> @@ -448,6 +450,7 @@ void nvme_complete_rq(struct request *req);
>  bool nvme_cancel_request(struct request *req, void *data, bool reserved);
>  bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>  		enum nvme_ctrl_state new_state);
> +bool nvme_wait_reset(struct nvme_ctrl *ctrl);
>  int nvme_disable_ctrl(struct nvme_ctrl *ctrl);
>  int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
>  int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
> @@ -498,6 +501,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
>  void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
>  int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
>  int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
> +int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
>  int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
>  
>  int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7d0de87d733d..4fcfd01f350d 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2463,6 +2463,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  	mutex_unlock(&dev->shutdown_lock);
>  }
>  
> +static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
> +{

This sounds like we should disable the prepare reset, but I think it
really means in nvme disable, prepare for reset. Should we call it
nvme_disable_and_prepare_reset()?

I've not checked the state machine by hand, but

Acked-by: Balbir Singh <bsingharora@gmail.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
