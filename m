Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48361FF5134
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 19:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NjiBDaNfLbZqQ4CQfzb2FfNQVqaLxJoOlYZcmUe9dL8=; b=CuN7o5gcq6va/SAOszL/Zp2g3b
	ZuoicFHp0cAhuBZ/WaQJxU7McJCBnWf9WMvdcEoMnc12dVQajZBA7H7ko10BKKqZKDm8eE6bE3kfC
	z5S+YQFqioN2AL4zOQr+ai9ZiiUcWQKiCMapkbbWfvU58B+HOheLvLC7HmUsgtLY5G41sXDorfK/U
	k3OghkibU1PzWVWfLVJuG+3rtLFKVWf5X2crV5Vu/RSPxKkzYmoKqmL4JeEdDyq7teZN6VuSClv1H
	FCSscnmA/PQnvPxFozaTQ1Vw2wsvKKa2yZCfCemJQ0ol5NjTT//4BW8LAFxfkRSxj91vdKudx5UbP
	/HsjVABg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wABo2-00000007AGV-1H3K;
	Tue, 07 Apr 2026 19:09:46 +0000
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wABnz-00000007AFu-0X76
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 19:09:45 +0000
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso157628eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 07 Apr 2026 12:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775588982; x=1776193782; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NjiBDaNfLbZqQ4CQfzb2FfNQVqaLxJoOlYZcmUe9dL8=;
        b=dwGJXq/gYYqQdlLJhq5Q/8pMC7vzzMVyVCoONNIkKGMpJcWw7s/D1i6qf4JXAFNp+3
         a+xQu2Lbi+pfykbvAheDHX/uiL+0Zp+pJ+pBloq4lS4Laym8PD3Y8IDzQqAtqt93tHxI
         zkYminRM8PqIkPRMXmMtRHf/f+43dGRvU1W2VTz/dTB2izEMNlpBoTKcAwE/cBJTO/mJ
         Tk9rrS9ZEDCilHSzvzHwR2BjZMNQ2uTabV1RUx15ED+iE/D2EzWBMFoGUJ9bylRUPVWW
         N1GWCg2J3+NJs8u1vRj7Vam8wQe8OgmumKCHYxGglhmC5XmuIQyYdDjWxejphdQf1Xbo
         pGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588982; x=1776193782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjiBDaNfLbZqQ4CQfzb2FfNQVqaLxJoOlYZcmUe9dL8=;
        b=bUVA7cS1PkWwkJ105McI27SKDAy14gbZWfFQEPRW4wSQanG3+H2tpDlB66YQUoLbH+
         E5RmjE+N+5W9us6YX2Je5JG1IWy6zx85bYp24IzFNFy37h+WXGKYfhjEgmzWVH53rXww
         gN7zwIBfMXuqlMYwz6f1Of5slUbnPUknO/cMPWmM2VDQIa/URjO3lawOKg7tR2TXpBXr
         4fGW7M05ROL/jwD8tj2mpYr4KN0mkPRyR5mF3HGipmdBP0iQe8OIa8VCB/6O9z5YceMH
         mUyyo56/ygbRutgvVfetRD8CjS8pud5KLTtTcwTv08ZeM02Lwap2YeWBH4xHkrh29voO
         3XSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3cyv2alH0657S+qXs+7jI1n+Px0uY21tE/lkfyJirul60sQ44NksMet0mL79TgRprysyq9geeJ0gs@lists.infradead.org
X-Gm-Message-State: AOJu0YyhQxpnT4kv+qFMylS9zjnfqs2CKvD3lAtn7JpUx9upPl1XXLBA
	+cTU0URAO19U4sImk8iNGC5GTxOed2jrOGpUcIYn0bF+qJ/r+Qu2t2ZRGcw0IK7tfVk=
X-Gm-Gg: AeBDietX4oSO/OT3iSbby1eApo7WvhAMH62CjNS/8L2r5QpAS4u8EZlnwQgvaHl5a6P
	VkSt8ip3XFHP2zBZNirHMbGAzvR64CICuFbasZVhXBuXdztBWz8R5RzZsHOfBOOPhN5vnCePnEg
	rNeEebDillyBKwvYiTJuFy3wDkEEg6K7HkGcpzgJcvYblRM3/4KJbYH5l7njMPIprx3zTIM5c9s
	OAC44Wuuq4i5W/MYmZrCFVu2eKQ26xa/7ZnPDWY/ntthyCQ9Vyd8j44K2J37wVtkRWlfumaVmkq
	hLIOdfcOSavS0g+3HY27Ii+vt8Yu8+K001MW3KTUrdRXzEOYnpXM3sgdj3f33HdMl89igo0Nj6/
	cyFwvvMwSTPI4gUezSFFKxTH96+ZVS92+AaoyPNI2KRXdg75/EZYRV9v4XIXN6HEa4h4N1NHgJ+
	ic2LDS16/EdBK3snYFcCvdTECNF/1nKUHji5FGne041VJW
X-Received: by 2002:a05:7300:ce95:b0:2d1:45d7:53ec with SMTP id 5a478bee46e88-2d145d791afmr1672067eec.19.1775588981443;
        Tue, 07 Apr 2026 12:09:41 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2d2cb4a7cdbsm573197eec.19.2026.04.07.12.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 12:09:41 -0700 (PDT)
Date: Tue, 7 Apr 2026 12:09:40 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/15] nvme: Implement cross-controller reset
 completion
Message-ID: <20260407190940.GF2861-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
 <20260328004518.1729186-10-mkhalfella@purestorage.com>
 <73a9c0e2-ecd0-4170-8723-259529617ec0@suse.de>
 <20260331165510.GD2861-mkhalfella@purestorage.com>
 <019cf04f-8988-46fd-aecd-0f77ac5f8b8a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <019cf04f-8988-46fd-aecd-0f77ac5f8b8a@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_120943_213951_DFF4344F 
X-CRM114-Status: GOOD (  35.52  )
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

On Tue 2026-04-07 07:48:50 +0200, Hannes Reinecke wrote:
> On 3/31/26 18:55, Mohamed Khalfella wrote:
> > On Mon 2026-03-30 12:53:07 +0200, Hannes Reinecke wrote:
> >> On 3/28/26 01:43, Mohamed Khalfella wrote:
> >>> An nvme source controller that issues CCR command expects to receive an
> >>> NVME_AER_NOTICE_CCR_COMPLETED when pending CCR succeeds or fails. Add
> >>> sctrl->ccr_work to read NVME_LOG_CCR logpage and wakeup any thread
> >>> waiting on CCR completion.
> >>>
> >>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> >>> ---
> >>>    drivers/nvme/host/core.c | 49 +++++++++++++++++++++++++++++++++++++++-
> >>>    drivers/nvme/host/nvme.h |  1 +
> >>>    2 files changed, 49 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >>> index 5603ae36444f..793f203bfc38 100644
> >>> --- a/drivers/nvme/host/core.c
> >>> +++ b/drivers/nvme/host/core.c
> >>> @@ -1920,7 +1920,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
> >>>    
> >>>    #define NVME_AEN_SUPPORTED \
> >>>    	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
> >>> -	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
> >>> +	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
> >>> +	 NVME_AEN_CFG_DISC_CHANGE)
> >>>    
> >>>    static void nvme_enable_aen(struct nvme_ctrl *ctrl)
> >>>    {
> >>> @@ -4873,6 +4874,47 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
> >>>    	kfree(log);
> >>>    }
> >>>    
> >>> +static void nvme_ccr_work(struct work_struct *work)
> >>> +{
> >>> +	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ccr_work);
> >>> +	struct nvme_ccr_entry *ccr;
> >>> +	struct nvme_ccr_log_entry *entry;
> >>> +	struct nvme_ccr_log *log;
> >>> +	unsigned long flags;
> >>> +	int ret, i;
> >>> +
> >>> +	log = kmalloc(sizeof(*log), GFP_KERNEL);
> >>> +	if (!log)
> >>> +		return;
> >>> +
> >>> +	ret = nvme_get_log(ctrl, 0, NVME_LOG_CCR, 0x01,
> >>> +			   0x00, log, sizeof(*log), 0);
> >>> +	if (ret)
> >>> +		goto out;
> >>> +
> >>> +	spin_lock_irqsave(&ctrl->lock, flags);
> >>> +	for (i = 0; i < le16_to_cpu(log->ne); i++) {
> >>> +		entry = &log->entries[i];
> >>> +		if (entry->ccrs == NVME_CCR_STATUS_IN_PROGRESS)
> >>> +			continue;
> >>> +
> >>> +		list_for_each_entry(ccr, &ctrl->ccr_list, list) {
> >>> +			struct nvme_ctrl *ictrl = ccr->ictrl;
> >>> +
> >>> +			if (ictrl->cntlid != le16_to_cpu(entry->icid) ||
> >>> +			    ictrl->ciu != entry->ciu)
> >>> +				continue;
> >>> +
> >>> +			/* Complete matching entry */
> >>> +			ccr->ccrs = entry->ccrs;
> >>> +			complete(&ccr->complete);
> >>> +		}
> >>> +	}
> >>> +	spin_unlock_irqrestore(&ctrl->lock, flags);
> >>> +out:
> >>> +	kfree(log);
> >>> +}
> >>> +
> >>>    static void nvme_fw_act_work(struct work_struct *work)
> >>>    {
> >>>    	struct nvme_ctrl *ctrl = container_of(work,
> >>> @@ -4949,6 +4991,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
> >>>    	case NVME_AER_NOTICE_DISC_CHANGED:
> >>>    		ctrl->aen_result = result;
> >>>    		break;
> >>> +	case NVME_AER_NOTICE_CCR_COMPLETED:
> >>> +		queue_work(nvme_wq, &ctrl->ccr_work);
> >>> +		break;
> >>>    	default:
> >>>    		dev_warn(ctrl->device, "async event result %08x\n", result);
> >>>    	}
> >>> @@ -5144,6 +5189,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> >>>    	nvme_stop_failfast_work(ctrl);
> >>>    	flush_work(&ctrl->async_event_work);
> >>>    	cancel_work_sync(&ctrl->fw_act_work);
> >>> +	cancel_work_sync(&ctrl->ccr_work);
> >>>    	if (ctrl->ops->stop_ctrl)
> >>>    		ctrl->ops->stop_ctrl(ctrl);
> >>>    }
> >>> @@ -5267,6 +5313,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> >>>    	ctrl->quirks = quirks;
> >>>    	ctrl->numa_node = NUMA_NO_NODE;
> >>>    	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
> >>> +	INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
> >>>    	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
> >>>    	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
> >>>    	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
> >>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> >>> index f2bcff9ccd25..776ee8aa5a93 100644
> >>> --- a/drivers/nvme/host/nvme.h
> >>> +++ b/drivers/nvme/host/nvme.h
> >>> @@ -419,6 +419,7 @@ struct nvme_ctrl {
> >>>    	struct nvme_effects_log *effects;
> >>>    	struct xarray cels;
> >>>    	struct work_struct scan_work;
> >>> +	struct work_struct ccr_work;
> >>>    	struct work_struct async_event_work;
> >>>    	struct delayed_work ka_work;
> >>>    	struct delayed_work failfast_work;
> >>
> >> Hmm. The 'nvme_fence_ctrl' operation introduced in the previous patch
> >> is synchronous, yet in this patch we're looking a a log page to figure
> >> out if the cross-controller reset is complete.
> >> Which is slightly irritating.
> >> Wouldn't it be better to make the 'nvme_fence_ctrl' operation
> >> asynchronous, and then have a separate function to wait for the fence
> >> operation to complete (which then could look at log pages etc)?
> > 
> > True nvme_fence_ctrl() is synchronous, but it runs in from ctrl->fencing_work.
> > What is it that you find irritating about nvme_fence_ctrl()?
> > 
> 
> Thins is, in order to make nvme_fence_ctrl() synchronous we have to
> wait for the operation itself (which is asynchronous) to complete.
> And that wait in itself is implemented by a wait queue.
> So we're having a wait queue calling nvme_fence_ctrl(), which calls
> another wait queue waiting for a completion.
> And then (if the IRS bit is not set) calling another waitqueue for
> checking the log page.

There is no point of checking the CCR logpage before getting AEN. Sure
we can implement some sort of polling, but I do not think this is the
right approach.

> 
> I think we could simplify this by simply making nvme_fence_ctrl() 
> asynchronous, which could do away with all the workqueue handling.

I am not sure I understand exactly how nvme_fence_ctrl() can be make
asynchronous. Can you provide example code?


