Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53FF10F92E0
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2026 16:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q20Cac3clgAqBT/P1Zedui6ELXRh9/Rh5lb+mmpfWzM=; b=njNvNG/CbhoqFq2myWBLDSS0sj
	NQy2wOsulNKy65ciALa8ngMM+1Ke/j77iYndXCEp1HN01J12woTEInJ9CJFQnatsyuQ/YdWMgkb40
	3I0admJ0yU3h/qFnxVc8xHozDuqo3iBaSHdEt6OPelOSns5kzQBHKyD9qhyFTE79WXWEzPztFH7gE
	Aw0QI9Bj2POgtRFBH/5JIluReCDzd/LBywgR4/kHkQXzYx/XO+N3+rP5R17azt6m/Fwq+N3PYe9Qb
	y8keFR/vjwaolVPKUoWZ3faR/OiMhaVAH2MQYriyWlDwSewdLDBV6uWULPekX6ufi4ZKzayM0YgmC
	RMKYQOsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7cN1-0000000DI1P-3ZDj;
	Tue, 31 Mar 2026 16:55:15 +0000
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7cMz-0000000DI13-1XDO
	for linux-nvme@lists.infradead.org;
	Tue, 31 Mar 2026 16:55:14 +0000
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-126ea4e9694so628187c88.1
        for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2026 09:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774976112; x=1775580912; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q20Cac3clgAqBT/P1Zedui6ELXRh9/Rh5lb+mmpfWzM=;
        b=XQDgZ8x9d6jqTzO07n4sbuAIuSKBlRAnpx1q67aJ/OM3XBzCp0x8m+Q39wRTwNMXzj
         KZmkIk+1h+1/kUsdUuJ4pRpBZwWfD8UTKr187a1hkAX9F+QDWItxQ70k10gVu3Ju3ABg
         ZDo/A/b1ld/Ltoy8LGYnlIHf7jLRZUNlMGWsedV6N9dV1yLNSAtBz16mW8HRFJdMrRNE
         wq6niHEE1Y5V98AWYXdmc78GQOWD9f2Rb+aEs0wR3Je5pGifFT5groNSRvQ3cVuEKhIO
         ED8uxJnAwWUtF8eFDT9eeT5drDgbb+pgCa8zMGgJD5kZ7HHEV2LZP54g1HH9hiL+GpBT
         rpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774976112; x=1775580912;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q20Cac3clgAqBT/P1Zedui6ELXRh9/Rh5lb+mmpfWzM=;
        b=YxG2APyR85MoSvXrccz/owTpU9q9QY+Xarc+ovqBRI2hjB0exBT8dPPkS+qra2gka0
         QFPvBGI/vRFs5ILAWnW2ZRjhSyv/imRYzE0dpdaZ5ESrrXYuXU/Ebc+L+6OmKY8KCN9g
         Q0yqnJnAoNcwX33LMv+vXOBGnD8gVM7gENa3g4b+u8lcEK55Dahcos5VEvn4bVndBJTI
         iak0Pc69m3uLs19gmdxEldMb3P+jrSHjVlDjSMZccCP365nOtHYgo3J46AYqnxJb1uu/
         6ijQoH+Sj8Osyv7VdVCeKWK1hJ3PbkXRGNlblhJ9dOM7QKCGbFmD6o14ubjppclkrOYH
         ZlBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRKh0NJTjf01rer/Vopbhyn2U9RIgfBhiI4Cq5D09BYbbUeqsZK3xK5AdaQy5MjAr6ZGbVxSwRrFrW@lists.infradead.org
X-Gm-Message-State: AOJu0YzBb+ppC755VhOyMHD8YykPxOsjjKXWUitbmOKIMn5s8WSlouxs
	aMYuX1JuuGV0VqSJs93P+MOSx0p8K3j+n/7QqAft2WidZ50oYl9Lu6VZxlsyK+bTbi4=
X-Gm-Gg: ATEYQzzLXYlKDsuOzWz18AlkvAhFmz8uO3CWvNETnsXOJSKUruZzk0DB5azWlRWW+dG
	A1xbYaiJsSynlmvRSI9Cx+gvJZPmcUwlEm3TQ64wOzebPu3fKeJx+kZ6dGwNB08K4qLhRY2HA4x
	/eKxH6oysRJTMxQtUJTOMVnkDGtLFa5KK4OkHxyTeFQ6qy1FFx3XtYnFafgrSmNy+V7k2JXLaQ5
	DBxO6lZapGKs497jxjnyMnXN65kqUMMJ0B6REJ/spALqLiyEIo+msESeLRsYMYhHr/N+/Bjbczr
	DJU8bbpCCBDW41WC41YbamPNOtwkO/PEgG8x9lw8apO+8jo2VRnFx/VTT1oSCPRp1JYTBJk3kFF
	gsh9a8OB9/6a+rgknp2MFDM3wEwzSWJy1ka1rwUabrPvfbEyy73uvo9m4uz1gTq8rc+UO1bX85M
	jIXw9/HjhwPtTOBpq30BTFoA3P/UkiIHxocthiJpMojXy5
X-Received: by 2002:a05:7022:618a:b0:11b:7970:ea3f with SMTP id a92af1059eb24-12be6578552mr136255c88.25.1774976112230;
        Tue, 31 Mar 2026 09:55:12 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-12aba581027sm16280630c88.4.2026.03.31.09.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:55:11 -0700 (PDT)
Date: Tue, 31 Mar 2026 09:55:10 -0700
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
Message-ID: <20260331165510.GD2861-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
 <20260328004518.1729186-10-mkhalfella@purestorage.com>
 <73a9c0e2-ecd0-4170-8723-259529617ec0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73a9c0e2-ecd0-4170-8723-259529617ec0@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_095513_430857_EFCA0A65 
X-CRM114-Status: GOOD (  30.87  )
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

On Mon 2026-03-30 12:53:07 +0200, Hannes Reinecke wrote:
> On 3/28/26 01:43, Mohamed Khalfella wrote:
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
> > index 5603ae36444f..793f203bfc38 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1920,7 +1920,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
> >   
> >   #define NVME_AEN_SUPPORTED \
> >   	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
> > -	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
> > +	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
> > +	 NVME_AEN_CFG_DISC_CHANGE)
> >   
> >   static void nvme_enable_aen(struct nvme_ctrl *ctrl)
> >   {
> > @@ -4873,6 +4874,47 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
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
> > @@ -4949,6 +4991,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
> >   	case NVME_AER_NOTICE_DISC_CHANGED:
> >   		ctrl->aen_result = result;
> >   		break;
> > +	case NVME_AER_NOTICE_CCR_COMPLETED:
> > +		queue_work(nvme_wq, &ctrl->ccr_work);
> > +		break;
> >   	default:
> >   		dev_warn(ctrl->device, "async event result %08x\n", result);
> >   	}
> > @@ -5144,6 +5189,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> >   	nvme_stop_failfast_work(ctrl);
> >   	flush_work(&ctrl->async_event_work);
> >   	cancel_work_sync(&ctrl->fw_act_work);
> > +	cancel_work_sync(&ctrl->ccr_work);
> >   	if (ctrl->ops->stop_ctrl)
> >   		ctrl->ops->stop_ctrl(ctrl);
> >   }
> > @@ -5267,6 +5313,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> >   	ctrl->quirks = quirks;
> >   	ctrl->numa_node = NUMA_NO_NODE;
> >   	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
> > +	INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
> >   	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
> >   	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
> >   	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index f2bcff9ccd25..776ee8aa5a93 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -419,6 +419,7 @@ struct nvme_ctrl {
> >   	struct nvme_effects_log *effects;
> >   	struct xarray cels;
> >   	struct work_struct scan_work;
> > +	struct work_struct ccr_work;
> >   	struct work_struct async_event_work;
> >   	struct delayed_work ka_work;
> >   	struct delayed_work failfast_work;
> 
> Hmm. The 'nvme_fence_ctrl' operation introduced in the previous patch
> is synchronous, yet in this patch we're looking a a log page to figure
> out if the cross-controller reset is complete.
> Which is slightly irritating.
> Wouldn't it be better to make the 'nvme_fence_ctrl' operation 
> asynchronous, and then have a separate function to wait for the fence
> operation to complete (which then could look at log pages etc)?

True nvme_fence_ctrl() is synchronous, but it runs in from ctrl->fencing_work.
What is it that you find irritating about nvme_fence_ctrl()?

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

