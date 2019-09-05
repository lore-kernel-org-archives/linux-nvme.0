Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509B8C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 15:57:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0294206B8
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 15:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CH+Yll3r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YyLqInn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0294206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tKOEnUWjMfQ86eCqsqw/QwCqD0sYd7R+0m345cL7JyY=; b=CH+Yll3rPURr9uvDgouNeJWIR
	Cr18yVzzBIb0kOFZVS4jIJMW5h27GL9Fh2XMQIL10L+fSrnBnq0CX2F4rAl7r1FFMRWK82z6Jxz+j
	+ano4W/HrEDkzeCjvIGCYyNBs7URV+GaZsrPaGeasg+ywCc1b0H9RjPLXvkIU19ZcfuKg7v+3mTDU
	Cd2M1ki6sJ9MdWYbHgfkEPS8YxFwIrTLyH3muPfeoPHuqHMyD/uX5SD2g+qg3v/Kwb6l9+tTVrwzh
	ECbmQLy0iD3ePARrfvTfZQzDNlvGkelDIQXxVFxWZqnrjGWKey1hTItZkCBddHheju5I75ICfnrfp
	4o9+GemAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5u8M-0001VA-OZ; Thu, 05 Sep 2019 15:57:18 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5u8J-0001Ul-K0
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 15:57:17 +0000
Received: by mail-pl1-x642.google.com with SMTP id gn20so1505751plb.2
 for <linux-nvme@lists.infradead.org>; Thu, 05 Sep 2019 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=7v0SNrWLAzseB085IYMD2VxQD9tqm/m9ud/S0OgttGQ=;
 b=YyLqInn0kQfVVRnrbfwTWUj6B+YmKfWOxfnjVxi1Tc1bvQQEYyX7ljBefyjYVlCSFH
 twgnpo/vZn097qCjETE52fetejrsNDtK1iJui89MKNTQYbXCIu6uCxggBs/pewqkWfn5
 BT0yz/SEX6G2XMNhf89Ww+UCBo7jHP8Co9k5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=7v0SNrWLAzseB085IYMD2VxQD9tqm/m9ud/S0OgttGQ=;
 b=UIjlSbCXjrWVG4KABlTba4Kjfdb5uVc/gxxCJiTgjP4I58ObvBE9Njx5qdct+GCR5B
 T8fIp1/y2S+wTouShzTxjGjY8/hfK5SmbbUvc/L9tY0/NbD56O7MY4oKQ/M9b85gXss3
 9sVS40vKdwe3EoaqbFq186EtES76ZtRhj8KjNpFB1UsgNW59pIWrkIo9Q7I2hs4t1yX+
 DFoFgtZa54dBFSJ5lhgO5+6r8KXWzBK5EIKq/T+cZOeB9LiAIu2YxrKBePI0xvQgz9pf
 bl+llfbbEMZG6lhxSO7OWCF3nHeYuZb/1F9HKw/UrRgFdZduiaijqcKCDPVvXss2GkQd
 sVLw==
X-Gm-Message-State: APjAAAXf/BllU4j3AdNGwmYsF5H9qkTbDaCLwQxJzd5kTSwUp1b+08vq
 kYJTqoMyFImv9hg1t2Mg/hxlKA==
X-Google-Smtp-Source: APXvYqymg2aGhwXBdS5MBwx4Q9zRBnKMlXdPN1T3SlzoEQOgL9rP+veitVg26GX0bsqHsgEh+ATxFQ==
X-Received: by 2002:a17:902:8a87:: with SMTP id
 p7mr4251029plo.240.1567699034594; 
 Thu, 05 Sep 2019 08:57:14 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a18sm2374283pgl.44.2019.09.05.08.57.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Sep 2019 08:57:13 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvme: Wait for reset state when required
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
References: <20190905142607.24897-1-kbusch@kernel.org>
 <20190905142607.24897-5-kbusch@kernel.org>
From: James Smart <james.smart@broadcom.com>
Message-ID: <9590fc84-e414-b4b4-97c3-e5b6fe48374e@broadcom.com>
Date: Thu, 5 Sep 2019 08:57:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905142607.24897-5-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_085715_664181_6F29B8F5 
X-CRM114-Status: GOOD (  27.89  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/5/2019 7:26 AM, Keith Busch wrote:
> Disabling a controller in a path that resets it in a different
> context needs to fence off other resets from occuring between these
> actions. Provide a method to block until we've successfully entered a
> reset state prior to disabling so that we can perform the controller
> disabling without racing with another reset. Otherwise, that other reset
> may either undo our teardown, or our teardown may undo the in-progress
> reset's bringup.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 36 +++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/nvme.h |  3 +++
>   drivers/nvme/host/pci.c  | 43 ++++++++++++++++++++++++++++++++-----------
>   3 files changed, 70 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d3920c1e54b9..995daa20a410 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -367,8 +367,10 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		break;
>   	}
>   
> -	if (changed)
> +	if (changed) {
>   		ctrl->state = new_state;
> +		wake_up_all(&ctrl->state_wq);
> +	}
>   
>   	spin_unlock_irqrestore(&ctrl->lock, flags);
>   	if (changed && ctrl->state == NVME_CTRL_LIVE)
> @@ -377,6 +379,37 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   }
>   EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
>   
> +/*
> + * Returns false for sink states that can't ever transition back to live
> + */
> +static bool nvme_state_transient(struct nvme_ctrl *ctrl)
> +{
> +	switch (ctrl->state) {
> +	case NVME_CTRL_NEW:
> +	case NVME_CTRL_LIVE:
> +	case NVME_CTRL_RESETTING:
> +	case NVME_CTRL_CONNECTING:
> +		return true;;
> +	case NVME_CTRL_DELETING:
> +	case NVME_CTRL_DEAD:
> +	default:
> +		return false;
> +	}
> +}
> +
> +/*
> + * Waits for the controller state to be reset, or returns false if it is not
> + * possible to ever transition to reset.
> + */
> +bool nvme_wait_reset(struct nvme_ctrl *ctrl)
> +{
> +	wait_event(ctrl->state_wq,
> +		   nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING) ||
> +		   !nvme_state_transient(ctrl));
> +	return ctrl->state == NVME_CTRL_RESETTING;
> +}
> +EXPORT_SYMBOL_GPL(nvme_wait_reset);
> +
>   static void nvme_free_ns_head(struct kref *ref)
>   {
>   	struct nvme_ns_head *head =
> @@ -3841,6 +3874,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
>   	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
>   	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
> +	init_waitqueue_head(&ctrl->state_wq);
>   
>   	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
>   	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a9fc25c3b64d..dc1c95008748 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -15,6 +15,7 @@
>   #include <linux/sed-opal.h>
>   #include <linux/fault-inject.h>
>   #include <linux/rcupdate.h>
> +#include <linux/wait.h>
>   
>   #include <trace/events/block.h>
>   
> @@ -193,6 +194,7 @@ struct nvme_ctrl {
>   	struct cdev cdev;
>   	struct work_struct reset_work;
>   	struct work_struct delete_work;
> +	wait_queue_head_t state_wq;
>   
>   	struct nvme_subsystem *subsys;
>   	struct list_head subsys_entry;
> @@ -443,6 +445,7 @@ void nvme_complete_rq(struct request *req);
>   bool nvme_cancel_request(struct request *req, void *data, bool reserved);
>   bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		enum nvme_ctrl_state new_state);
> +bool nvme_wait_reset(struct nvme_ctrl *ctrl);
>   int nvme_disable_ctrl(struct nvme_ctrl *ctrl);
>   int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
>   int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 95411f53f159..b3a89ca37ead 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2462,6 +2462,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>   	mutex_unlock(&dev->shutdown_lock);
>   }
>   
> +static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
> +{
> +	if (!nvme_wait_reset(&dev->ctrl))
> +		return -EBUSY;
> +	nvme_dev_disable(dev, shutdown);
> +	return 0;
> +}
> +
>   static int nvme_setup_prp_pools(struct nvme_dev *dev)
>   {
>   	dev->prp_page_pool = dma_pool_create("prp list page", dev->dev,
> @@ -2509,6 +2517,11 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
>   
>   static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
>   {
> +	/*
> +	 * Set state to deleting now to avoid blocking nvme_wait_reset(), which
> +	 * may be holding this pci_dev's device lock.
> +	 */
> +	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
>   	nvme_get_ctrl(&dev->ctrl);
>   	nvme_dev_disable(dev, false);
>   	nvme_kill_queues(&dev->ctrl);
> @@ -2833,19 +2846,27 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   static void nvme_reset_prepare(struct pci_dev *pdev)
>   {
>   	struct nvme_dev *dev = pci_get_drvdata(pdev);
> -	nvme_dev_disable(dev, false);
> +
> +	/*
> +	 * We don't need to check the return value from waiting for the reset
> +	 * state as pci_dev device lock is held, making it impossible to race
> +	 * with ->remove().
> +	 */
> +	nvme_disable_prepare_reset(dev, false);
> +	nvme_sync_queues(&dev->ctrl);
>   }
>   
>   static void nvme_reset_done(struct pci_dev *pdev)
>   {
>   	struct nvme_dev *dev = pci_get_drvdata(pdev);
> +	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE);
>   	nvme_reset_ctrl_sync(&dev->ctrl);
>   }
>   
>   static void nvme_shutdown(struct pci_dev *pdev)
>   {
>   	struct nvme_dev *dev = pci_get_drvdata(pdev);
> -	nvme_dev_disable(dev, true);
> +	nvme_disable_prepare_reset(dev, true);
>   }
>   
>   /*
> @@ -2897,8 +2918,10 @@ static int nvme_resume(struct device *dev)
>   	struct nvme_ctrl *ctrl = &ndev->ctrl;
>   
>   	if (pm_resume_via_firmware() || !ctrl->npss ||
> -	    nvme_set_power_state(ctrl, ndev->last_ps) != 0)
> -		nvme_reset_ctrl(ctrl);
> +	    nvme_set_power_state(ctrl, ndev->last_ps) != 0) {
> +		if (nvme_change_ctrl_state(&ndev->ctrl, NVME_CTRL_LIVE))
> +			nvme_reset_ctrl(ctrl);
> +	}
>   	return 0;
>   }
>   
> @@ -2917,10 +2940,8 @@ static int nvme_suspend(struct device *dev)
>   	 * device does not support any non-default power states, shut down the
>   	 * device fully.
>   	 */
> -	if (pm_suspend_via_firmware() || !ctrl->npss) {
> -		nvme_dev_disable(ndev, true);
> -		return 0;
> -	}
> +	if (pm_suspend_via_firmware() || !ctrl->npss)
> +		return nvme_disable_prepare_reset(ndev, true);
>   
>   	nvme_start_freeze(ctrl);
>   	nvme_wait_freeze(ctrl);
> @@ -2943,9 +2964,8 @@ static int nvme_suspend(struct device *dev)
>   		 * Clearing npss forces a controller reset on resume. The
>   		 * correct value will be resdicovered then.
>   		 */
> -		nvme_dev_disable(ndev, true);
> +		ret = nvme_disable_prepare_reset(ndev, true);
>   		ctrl->npss = 0;
> -		ret = 0;
>   		goto unfreeze;
>   	}
>   	/*
> @@ -2963,7 +2983,7 @@ static int nvme_simple_suspend(struct device *dev)
>   {
>   	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
>   
> -	nvme_dev_disable(ndev, true);
> +	nvme_disable_prepare_reset(ndev, true);
>   	return 0;
>   }
>   
> @@ -2972,6 +2992,7 @@ static int nvme_simple_resume(struct device *dev)
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   	struct nvme_dev *ndev = pci_get_drvdata(pdev);
>   
> +	nvme_change_ctrl_state(&ndev->ctrl, NVME_CTRL_LIVE);
>   	nvme_reset_ctrl(&ndev->ctrl);
>   	return 0;
>   }

patches 1-4 look fine, and excluding fc on patch 1 was valid.

This patch overall looks fine too. I do get nervous that the new state 
transitions in some of these functions may make new state dependencies 
that show up in the common layers, especially around reset. Based on the 
pci vs core division and no actual change to the state transitions, it 
doesn't look like it bleeds out.

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
