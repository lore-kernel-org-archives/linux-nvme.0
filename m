Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668C7E83060
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 20:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TcX3GqfueByV0ZsgDx+YVVsfLUh3jj4u3lErIYfPq2k=; b=wkDXA4peCAjjJEYQmO+izlqami
	fA4yv2ZZQVEDlLQ1SibxPqnLTXqRmnulrA6g9E1s5JrRnaUszdItZxvFbiQy5YYvoWCtnWYXV9UZX
	EjREplUVCmx/5IB6zujidRT0EfYQ/YFezCwborShjJONuogWHZV23SRnsk0e/CUjPCD3swBKHSKQq
	3CFsGKVMLCEmwTOwF/072BZ4vnWbj4vuDBl4SWzEqxQOaknzo13z1xbReu5K9LlnAL5AZ3FDoQFaC
	vAgREvDGIhm4d5e+MFpw2qYJLyKgREChhtI723g0Zkp+Fq/0qprbLKBAYFgUX0jFzY8TvnwWooY5w
	xDvzrbNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnMgM-00000007I4Z-3iFM;
	Tue, 03 Feb 2026 20:07:30 +0000
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnMgJ-00000007I3w-41Px
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 20:07:29 +0000
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-11f1fb91996so3513683c88.1
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 12:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770149247; x=1770754047; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TcX3GqfueByV0ZsgDx+YVVsfLUh3jj4u3lErIYfPq2k=;
        b=ahWJFXfCrNa3jXLVrw9n9A2MyaI16OfN8mxS4BuOuyCv+i4V22sYy97CBs6f4SrU80
         Mkw+rlLwjhbWkr0dmGyD969+5TA7Vd7NC7WGFn61dJiYrBDPRYptJEyYx1fllERikFmZ
         dmo6O1qS4ytBUuY2iLk3TEPk77dH+YL/US4YCkWHRabJXC/IkPSOooPgO4Ombop2qvkK
         IQ2ya6OslHdJ8I+RvnOlBCsd0xWEINk27O3cF9XGU77YkAVh76H3Yqm7AHlep1bZxXhS
         4jgL9uRcDz9A62hDBdP8MOPeno5GMN+nJJpch7FKNJZTK/RPwDjIstiOWU3I4dFAHpA6
         foew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770149247; x=1770754047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcX3GqfueByV0ZsgDx+YVVsfLUh3jj4u3lErIYfPq2k=;
        b=gihkWUc59JUJrH996c0Q5zc2ZIOi12Hl/ldfRYt4G0rAa7FRNdkc5Bpkz1WmYcLSbo
         9WLTl27rjh10GZRyzYhICq+jqO9/GlOUp8OA0+ks7c0XyQQnhBlQCfmQYoyAelWqffZW
         +gMM06nZ83/Z5r7XVqXVMkS6gM0YEQbG1LqRzsHN1Q//g8rwKnodZQ/1Tmay2Fc2D01Y
         WtOe37rZaodoE9ZqkuBVkhGqFYhWrBKvELAfs796GVtLm4KurZZTuqL/b8CZljx45ylS
         64WH6P+e8903jlIJxVJJXeiGFXgeZaRcG67BwLZF3Q5MTGqdrYGaq4NRtXRIwAdOQfNK
         yQWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjjSvzM0FWalGLYJjWMC3cfITVN5dWPNOBpyS50KvVaXN0CzS5vWKwA0FKt+Y75nVspZHnEReIC0Zh@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6OoOjU3cp1rMQh0GWXBgyxRwNVJwJ7yXrzCK3p4qk/4uHwAhx
	4y/408u5rFvyB81+K9i1K+Dgtu+69hlNhmzUzJG1cC6hg4e019X93eMkL3Nh/WO+n4A=
X-Gm-Gg: AZuq6aJpngGrPPpEf/wUfEFQOWF74+Hzmi345VvuXJW3p/74bjMAQQqgdu5gIxmyJIl
	WgbhkmaJHT0dE2QYD55+dw1a6RGhNPTd1Y+P1+mrGin9Muad5sbRRbs873qZrYGrrfIqLI54NQ5
	QJRGexF22lT7zbLk1NpVEa01gsR/AicBEA44zxRZAgOHJD2z7HY8wiRe6XV6fmD0tQV2Lg7w7cv
	aW3ZMtPXOTtc0rGE2M+fkm7xjL0LbfKiexCLpJhsOot/d8cGCL9DCESXp+BrH2muUsb3/9Oy+mx
	UQZKB6L4pUlRN/+bBsBvXLfAhgJeAEBHV7ZHTfF8a3GWv7v9jckh0tMaPNl6vCX5iITiIWc+9a+
	6hzsrsDguyAZjfC+QCOKjNN1PR7Ypefz1cS0K+7oIyVgpMoYM9VLS9IZjtPH/M5zbHblAqZiKsv
	USAzCAi3BHCKNnFaMRfh43/6s7ZAYubU0=
X-Received: by 2002:a05:7022:10d:b0:11b:9386:a3be with SMTP id a92af1059eb24-126f47ddbfamr314491c88.41.1770149246568;
        Tue, 03 Feb 2026 12:07:26 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-126f5030b01sm271249c88.11.2026.02.03.12.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 12:07:26 -0800 (PST)
Date: Tue, 3 Feb 2026 12:07:25 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/14] nvme: Implement cross-controller reset
 completion
Message-ID: <20260203200725.GF3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-10-mkhalfella@purestorage.com>
 <431d225b-266f-431c-b3a5-03e033a2f63d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <431d225b-266f-431c-b3a5-03e033a2f63d@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_120728_024442_4C05DFE1 
X-CRM114-Status: GOOD (  30.53  )
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

On Tue 2026-02-03 06:22:38 +0100, Hannes Reinecke wrote:
> On 1/30/26 23:34, Mohamed Khalfella wrote:
> > An nvme source controller that issues CCR command expects to receive an
> > NVME_AER_NOTICE_CCR_COMPLETED when pending CCR succeeds or fails. Add
> > sctrl->ccr_work to read NVME_LOG_CCR logpage and wakeup any thread
> > waiting on CCR completion.
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/host/core.c | 49 +++++++++++++++++++++++++++++++++++++++-
> >   drivers/nvme/host/nvme.h |  1 +
> >   2 files changed, 49 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 13e0775d56b4..0f90feb46369 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1901,7 +1901,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
> >   
> >   #define NVME_AEN_SUPPORTED \
> >   	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
> > -	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
> > +	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
> > +	 NVME_AEN_CFG_DISC_CHANGE)
> >   
> >   static void nvme_enable_aen(struct nvme_ctrl *ctrl)
> >   {
> > @@ -4866,6 +4867,47 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
> >   	kfree(log);
> >   }
> >   
> > +static void nvme_ccr_work(struct work_struct *work)
> > +{
> > +	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ccr_work);
> > +	struct nvme_ccr_entry *ccr;
> > +	struct nvme_ccr_log_entry *entry;
> > +	struct nvme_ccr_log *log;
> > +	unsigned long flags;
> > +	int ret, i;
> > +
> > +	log = kmalloc(sizeof(*log), GFP_KERNEL);
> > +	if (!log)
> > +		return;
> > +
> > +	ret = nvme_get_log(ctrl, 0, NVME_LOG_CCR, 0x01,
> > +			   0x00, log, sizeof(*log), 0);
> > +	if (ret)
> > +		goto out;
> > +
> > +	spin_lock_irqsave(&ctrl->lock, flags);
> > +	for (i = 0; i < le16_to_cpu(log->ne); i++) {
> > +		entry = &log->entries[i];
> > +		if (entry->ccrs == NVME_CCR_STATUS_IN_PROGRESS)
> > +			continue;
> > +
> > +		list_for_each_entry(ccr, &ctrl->ccr_list, list) {
> > +			struct nvme_ctrl *ictrl = ccr->ictrl;
> > +
> > +			if (ictrl->cntlid != le16_to_cpu(entry->icid) ||
> > +			    ictrl->ciu != entry->ciu)
> > +				continue;
> > +
> > +			/* Complete matching entry */
> > +			ccr->ccrs = entry->ccrs;
> > +			complete(&ccr->complete);
> > +		}
> > +	}
> > +	spin_unlock_irqrestore(&ctrl->lock, flags);
> > +out:
> > +	kfree(log);
> > +}
> > +
> >   static void nvme_fw_act_work(struct work_struct *work)
> >   {
> >   	struct nvme_ctrl *ctrl = container_of(work,
> > @@ -4942,6 +4984,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
> >   	case NVME_AER_NOTICE_DISC_CHANGED:
> >   		ctrl->aen_result = result;
> >   		break;
> > +	case NVME_AER_NOTICE_CCR_COMPLETED:
> > +		queue_work(nvme_wq, &ctrl->ccr_work);
> > +		break;
> >   	default:
> >   		dev_warn(ctrl->device, "async event result %08x\n", result);
> >   	}
> > @@ -5131,6 +5176,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> >   	nvme_stop_failfast_work(ctrl);
> >   	flush_work(&ctrl->async_event_work);
> >   	cancel_work_sync(&ctrl->fw_act_work);
> > +	cancel_work_sync(&ctrl->ccr_work);
> >   	if (ctrl->ops->stop_ctrl)
> >   		ctrl->ops->stop_ctrl(ctrl);
> >   }
> > @@ -5254,6 +5300,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> >   	ctrl->quirks = quirks;
> >   	ctrl->numa_node = NUMA_NO_NODE;
> >   	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
> > +	INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
> >   	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
> >   	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
> >   	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index fa18f580d76a..a7f382e35821 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -366,6 +366,7 @@ struct nvme_ctrl {
> >   	struct nvme_effects_log *effects;
> >   	struct xarray cels;
> >   	struct work_struct scan_work;
> > +	struct work_struct ccr_work;
> >   	struct work_struct async_event_work;
> >   	struct delayed_work ka_work;
> >   	struct delayed_work failfast_work;
> 
> This confuses me. Why do we call 'complete()' but do not have a 
> corresponding 'wait_for_completion()' call?

I think because the two commits were developed separately.

> 
> Please merge with the next patch to allow reviewers to have the full
> picture.

I thought it is easier to review this way because this change includes
ctrl->ccr_work. If you feel strongly about it I will merge it into the
previous patch "[PATCH v2 08/14] nvme: Implement cross-controller reset
recovery"?

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

