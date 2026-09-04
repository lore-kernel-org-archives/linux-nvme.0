Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEB2C79F82
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2026 22:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l28Mnpox539s4is2ExkEzGdvcyxPfAUNIS6oNY0bXaY=; b=GODYI//En5bNkX3MyRtSwC6oyV
	yysHSOVPeRYAARtyuwZL27c7fj1eaH6MU3zU32EBiVTtQZP1E8zL57uJSsLvvVPf4yyIF3jG2oU3s
	+yLJiaUK1gMdQYeKFlDpSvwvlSPlUvpg9NOB3yBQfqHXRpsBKjKJG53lSUcJ+UtQI13JTMfzjBwL1
	mJgnsXe9RRLiuI97+76L8ZETxL4xRdo0AneUSBGrRJYjiLiDAZU3KkatwPad3TbMHi87uXKcjC/7w
	ewTOYFmNP3lOl9iSruZ3hZHff4XB6p/ZK9LDqxk+i1B/CobkBLQBLunRV+Jc4Sw8mI0F0or0WMxTV
	aCcHMQwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2cPx-00000003Opa-0RXm;
	Fri, 04 Sep 2026 22:29:53 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2cPv-00000003Op8-0GNt
	for linux-nvme@lists.infradead.org;
	Fri, 04 Sep 2026 22:29:52 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-85c9a79590aso1467354b3a.1
        for <linux-nvme@lists.infradead.org>; Fri, 04 Sep 2026 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788560990; x=1789165790; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l28Mnpox539s4is2ExkEzGdvcyxPfAUNIS6oNY0bXaY=;
        b=MLRxNXLPAWhb1xhFtXjuK/mes/RRf4Qj+OlzolVGzNoDmEG6jOVQk1ZxDvVUn6MCUQ
         x4dCJ1B6iqNfbYNhgBRMY/ewFNT9rLjkogP6FUcMtBp8heZ6uVNXs75o1J+kVB25rFNI
         6QJe7FdAtRyJEeML3/mUzFxB5KgP2IeT3itJylOzq2GtkW1OIL7nUv6NfFAIBuBDNwGu
         utNbkyyJuI7xCW2YwgI4GJpDCRZMvYvONd83/+3bT0fSVPAOo5SR3qdwWbS2RkYWgHvu
         xJl+J6ReI9d1q+g4LrrpAg6cE3JoO+pdGSKiAKO++dSIO6xTlt2X+3yP7NKzY7zqbgPQ
         ZWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788560990; x=1789165790;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l28Mnpox539s4is2ExkEzGdvcyxPfAUNIS6oNY0bXaY=;
        b=cHp/WSLVBnXsSxloF1ISZIS7e1uq/lCWwVqlRERYWcDAlsS+KsP3btGwDBRUZFyEc0
         8fO4Mvvok4WpkocrG0KljIMIBqNj1V/LnSv0W4Afs+p/MDv08hUZ0PZFtRPDp2tVE+Oo
         eoQ5Rl+kYC7t1ncXMByi2Ke4ZL5zz68uBuZKCSwCcSswaCa2mlQrtbWU2E7SbOH8OfgV
         t4FN/rVMreIhYA5+NZTeDFx3wkF8MsFh4vYJK4H3AejKrUln6swduMufrF+YVej/DrK5
         03Rq+QDcciTiFVG/lGHjljfL9H33/Nv2FjDT0nWNQ3IUgVnXhe51+pWH9aiaWUxVOOEs
         7LPw==
X-Forwarded-Encrypted: i=1; AKwUvByU1IG3zFj2mIaG3NQDHnubjZa8Y16BySOIqmr0QIJsg34SMij9VmvXKUFDoCOp/bGnn7JMdSzy8AKT@lists.infradead.org
X-Gm-Message-State: AFuF++lQfP5bgbp0LgwubdCHWGCnXqGfeQMNNoVU3W8jk1Iyct/i49rC
	nx2JTnrSX0yD6xeiezuTVidJDx+mWS84SpJ0dMGn4M32dDFGSl2WUMgLZi8bTFx4FFw=
X-Gm-Gg: AYBFou1KrGMOR1rYUFGa/nWz73VB5YusewO5k5utwvWA0BT8TsAptfiN1JB8L2ujJ94
	yiT7Et7ygHWxMZ5Ti6dFDsXc8Qxoneid2XAKrOx3JasIvFg0AEvEYHRKcdHNgj6GcVRs0EwW+Vd
	bAOUSoNOMXl7iToe4MTMGMSX+dxuEvaefqNzrXO6/GjrXI+qnSO1dtuSykeXCBKvzGMM+mpNiCY
	jYHvJdhbKEA/efVF7FfKfaGDFsdiqgvKnKG2oJZjRIu8hg/JdW8ru6Jm0PG0CAhbigvoOFmovTr
	5J3uZ4sVDEWB5cnf+06OVAYsOzmWwrizgPAbIWz23DsBKDn9j7+nXAa/k/dKsR7wE/yJAx30IyB
	XRwVr9S6egA87wdHYQQ2nd92GRY3j74feDnp3wl2SeL6JmKXr6iW3V77+D7/JBr+p5OikJ46gCm
	G9oVRYcowj9h8WlZnBBhHQKfPtl22+KVhxE2weBRAYuFqI61KNs+GGExWuevpytA46wyzJJUNHJ
	MEX5Q==
X-Received: by 2002:a05:6a20:4394:b0:3d2:2afa:d7d with SMTP id adf61e73a8af0-3da3a091e07mr13501548637.18.1788560989531;
        Fri, 04 Sep 2026 15:29:49 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2607:fb90:9c20:7a99::791d])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-143243a9388sm8934860c88.10.2026.09.04.15.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:29:48 -0700 (PDT)
Date: Fri, 4 Sep 2026 15:29:46 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/16] nvme: Implement cross-controller reset
 completion
Message-ID: <20260904222946.GA5552-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-10-mkhalfella@purestorage.com>
 <b14ee42d-95f4-42d9-8b40-58c0f045b414@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b14ee42d-95f4-42d9-8b40-58c0f045b414@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_152951_295531_D738C09E 
X-CRM114-Status: GOOD (  35.11  )
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

On Mon 2026-07-13 09:11:24 +0200, Hannes Reinecke wrote:
> On 7/12/26 4:23 AM, Mohamed Khalfella wrote:
> > An nvme source controller that issues CCR command expects to receive an
> > NVME_AER_NOTICE_CCR_COMPLETED when pending CCR succeeds or fails. Add
> > ctrl->ccr_work to read NVME_LOG_CCR logpage and wakeup threads waiting
> > on CCR completion.
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/host/core.c | 50 +++++++++++++++++++++++++++++++++++++++-
> >   drivers/nvme/host/nvme.h |  1 +
> >   2 files changed, 50 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index a1deffc3cc00..18de3805eff8 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1943,7 +1943,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
> >   
> >   #define NVME_AEN_SUPPORTED \
> >   	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
> > -	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
> > +	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
> > +	 NVME_AEN_CFG_DISC_CHANGE)
> >   
> >   static void nvme_enable_aen(struct nvme_ctrl *ctrl)
> >   {
> > @@ -4974,6 +4975,48 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
> >   	kfree(log);
> >   }
> >   
> > +static void nvme_ccr_work(struct work_struct *work)
> > +{
> > +	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ccr_work);
> > +	struct nvme_ccr_entry *ccr;
> > +	struct nvme_ccr_log_entry *entry;
> > +	struct nvme_ccr_log *log;
> > +	int num_entries, ret, i;
> > +	unsigned long flags;
> > +
> > +	log = kmalloc_obj(*log);
> > +	if (!log)
> > +		return;
> > +
> > +	ret = nvme_get_log(ctrl, 0, NVME_LOG_CCR, 0x01,
> > +			   0x00, log, sizeof(*log), 0);
> > +	if (ret)
> > +		goto out;
> > +
> > +	spin_lock_irqsave(&ctrl->lock, flags);
> > +	num_entries = min(le16_to_cpu(log->ne), NVMF_CCR_PER_PAGE);
> > +	for (i = 0; i < num_entries; i++) {
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
> 
> I _think_ we need a marker here to figure out if the completion was 
> already called. Depending on how often the log gets updated it might
> be that we're processing two AENs before the other thread in 
> nvme_issue_wait_ccr() is able to process the completion and remove the 
> element from the list, in which case we're issuing a double completion.

Yes, processing two AENs can result in double completing ccr->complete.
However, this is harmless. It causes complete->done to be incremented
twice which is not an issue.

> 
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
> > @@ -5050,6 +5093,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
> >   	case NVME_AER_NOTICE_DISC_CHANGED:
> >   		ctrl->aen_result = result;
> >   		break;
> > +	case NVME_AER_NOTICE_CCR_COMPLETED:
> > +		queue_work(nvme_wq, &ctrl->ccr_work);
> > +		break;
> >   	default:
> >   		dev_warn(ctrl->device, "async event result %08x\n", result);
> >   	}
> > @@ -5238,6 +5284,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> >   	nvme_stop_failfast_work(ctrl);
> >   	flush_work(&ctrl->async_event_work);
> >   	cancel_work_sync(&ctrl->fw_act_work);
> > +	cancel_work_sync(&ctrl->ccr_work);
> 
> Might be good to have a WARN_ON(!list_empty(&ctrl->ccr_list)) here.

I do not think we are missing a case where a CCR entry can be left in
ccr_list. The only place that adds/deletes CCRs is nvme_issue_wait_ccr()
which should be running while the controller in FENCING state.

If the statement above is wrong, then there is a bug I need to fix. I
think the code should be clear such that WARN_ON() is not needed.

> 
> >   	if (ctrl->ops->stop_ctrl)
> >   		ctrl->ops->stop_ctrl(ctrl);
> >   }
> > @@ -5363,6 +5410,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> >   	ctrl->quirks = quirks;
> >   	ctrl->numa_node = NUMA_NO_NODE;
> >   	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
> > +	INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
> >   	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
> >   	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
> >   	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index 90b989302e21..578fedda9946 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -422,6 +422,7 @@ struct nvme_ctrl {
> >   	struct nvme_effects_log *effects;
> >   	struct xarray cels;
> >   	struct work_struct scan_work;
> > +	struct work_struct ccr_work;
> >   	struct work_struct async_event_work;
> >   	struct delayed_work ka_work;
> >   	struct delayed_work failfast_work;
> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

