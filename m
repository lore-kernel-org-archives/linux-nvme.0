Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6E4E9A032
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 18:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HLWRzMtsCpelPtrD3vI1WSb7s2lpiuT1u2xkypQAkdQ=; b=0T6/adOy2EEebsHxat0afMprZo
	KG6WPsHN01lJoEGh6J/aAIGhPszuKI8nblsNqwG4wIsU61H//VivDA7gMsG0sQq7aOh1Yt9w1VXNj
	wii7L/KajY6VJ6V+OHzj3k4D2FMT/qXoNF3nGLief0vRPZjXtwGe/1eE130DThQlmhysc5tjyVmr3
	MBLaGjCzx8beetbnfM2KqFy+N4GjR9Aps8WqVXM+ouIkG3/JwCPT2SBNOjxwTSByYV8R7QnKXdTLa
	u8iVxOQ7g3sHxsGsUG1seG2jnh1z1ZG1/YfQfo4Phi145lEWhQNZ8sRteuX2tzPljaGRSAClzGKZv
	lA8oSSng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsPlt-00000008iSG-2FCq;
	Tue, 17 Feb 2026 18:26:05 +0000
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsPll-00000008iRi-3Iwx
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 18:26:01 +0000
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-2ba895adfeaso4069960eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Feb 2026 10:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771352756; x=1771957556; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HLWRzMtsCpelPtrD3vI1WSb7s2lpiuT1u2xkypQAkdQ=;
        b=YZEBxgCmLrGua65aJVgzm0z5LSr5UauoDmoUTLeMeQWt4Eyz5jhgV8UW3K8zRkDX33
         lv3Tu8zwBcfBAQBDAfwzaBb66K0gRAhLASLbne2et5I8FNCciLPyvC8Avy6wbTI0vdK4
         befZ7acT9PtTx5RGEixRyOREZC4V7b9Wks8H8Am29bIINhfSWjovxBnZbd8XrfQmLT+n
         o7cTfRlbDub4btInv2ekn+A886tS6YqBIzWp3FdwWLSh3uyZ+zmy5ervbqk4z9ho4S7s
         V/5/Rlman9ssm7pWdapNKJlA/ErkhfXJz/S9Jr+DfqbUngfbn4K9l4WOm7raRxzfXATS
         Gltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771352756; x=1771957556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLWRzMtsCpelPtrD3vI1WSb7s2lpiuT1u2xkypQAkdQ=;
        b=eU/Z2vDfx0UWkS0szIiyv44VXieJUY3bcRlqbYQ6nZBbZprZXjPo+TPFA2+3NZ8Hss
         eWhh6+aSn2X7qBPNWeKt/fUGldY2vOcJ2LxvWk5fMgj9OU/1gkRYe91DkmGdfdopi/Kc
         LX4fhyft7DrLZH7cM8S3aqkRyMZCGsSdNsI1O1Cmkzdy1q6khZvBz17cTM+EU2iq6+om
         xpNVjdJ4i5d76+X1u91XYSBVjdBBGngFRbc3E87aDYpKMACRPFxa1Kd0ot/Dqn0AqCK1
         GdDan5Tq1apYMxzPPvdyz4epTi6t/KT8flJ4DkbhMhkKip2fV93D+P9uQ7MsDWrspa7K
         ZroA==
X-Forwarded-Encrypted: i=1; AJvYcCXk92ENxrgcKr2fyQpS3ufqDgDhUQH4zx/xj9nUCaxhx2mxeEfgc+NkmcmBV+IAalw53K95UJy+Fr14@lists.infradead.org
X-Gm-Message-State: AOJu0YzgPde1gVARxiu11xoss6V0A1YJJJ9IzkoIjvjoXN0VFRBSi3KV
	naqQOoh3jneDvBJqNfNS6HIsNr/YMeRcehiHdBSwu6u7pvTl8ku5qdw5Z4WgdUOxg9E=
X-Gm-Gg: AZuq6aLxZRWtaj/AFPo/K5m2YTUUNzzLHsbZydKtJbcgJ+XauWhRRubbH3FR/nnWmSe
	QDfTz2VckUhJaHseBzpaaTMLhnCDixPXwZMvr6307jnfcWYcoOe0Z/3PBMIUZnh3c7lXIGgUEa7
	3PjQrvUxafseq3tRqi2jhl/BZFwtvRwbLH8e42cK0n0UhuTZY8fWoooAOMaa3RzbAN28ZgQaC/e
	uqrkcGUe9nEXcLonOJqDBQNoQPb0MuPgO0z7TbtPbkSE6QGGg7QygYRZq45ZIqMUWIoN8z87HoC
	GV5cXt/rQYUly367mxtiJcVDYSKYn5k9wmSCDQqvNxqYyo7bJuK/orIK4Q6GDWXDsq6NBcY8io5
	8Vknnir8Eo25h7SOE3Gg+ZclK3P2IIEGlVZSA3fKV4xTmeiYW60UBdsUZ/XPJ0jwxHphFPAFrBp
	CIOWBvLJ+gXAl/sq3y5bwtmanx0v+ojp1AMt4+TKsBSX0=
X-Received: by 2002:a05:7301:4085:b0:2ba:6e6e:d8ef with SMTP id 5a478bee46e88-2babc53a802mr6429231eec.28.1771352756278;
        Tue, 17 Feb 2026 10:25:56 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-12742cadb25sm18674000c88.10.2026.02.17.10.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:25:55 -0800 (PST)
Date: Tue, 17 Feb 2026 10:25:54 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/21] nvme: Implement cross-controller reset
 completion
Message-ID: <20260217182554.GE3435530-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-10-mkhalfella@purestorage.com>
 <3b21ccbd-7948-436b-8faa-a5541c65946a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b21ccbd-7948-436b-8faa-a5541c65946a@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_102557_835099_6D9C2F34 
X-CRM114-Status: GOOD (  31.65  )
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

On Mon 2026-02-16 13:43:51 +0100, Hannes Reinecke wrote:
> On 2/14/26 05:25, Mohamed Khalfella wrote:
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
> > index 765b1524b3ed..a9fcde1b411b 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1916,7 +1916,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
> >   
> >   #define NVME_AEN_SUPPORTED \
> >   	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
> > -	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
> > +	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
> > +	 NVME_AEN_CFG_DISC_CHANGE)
> >   
> >   static void nvme_enable_aen(struct nvme_ctrl *ctrl)
> >   {
> > @@ -4880,6 +4881,47 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
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
> > @@ -4956,6 +4998,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
> >   	case NVME_AER_NOTICE_DISC_CHANGED:
> >   		ctrl->aen_result = result;
> >   		break;
> > +	case NVME_AER_NOTICE_CCR_COMPLETED:
> > +		queue_work(nvme_wq, &ctrl->ccr_work);
> > +		break;
> >   	default:
> >   		dev_warn(ctrl->device, "async event result %08x\n", result);
> >   	}
> > @@ -5145,6 +5190,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> >   	nvme_stop_failfast_work(ctrl);
> >   	flush_work(&ctrl->async_event_work);
> >   	cancel_work_sync(&ctrl->fw_act_work);
> > +	cancel_work_sync(&ctrl->ccr_work);
> >   	if (ctrl->ops->stop_ctrl)
> >   		ctrl->ops->stop_ctrl(ctrl);
> >   }
> > @@ -5268,6 +5314,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> >   	ctrl->quirks = quirks;
> >   	ctrl->numa_node = NUMA_NO_NODE;
> >   	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
> > +	INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
> >   	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
> >   	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
> >   	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index f3ab9411cac5..af6a4e83053e 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -365,6 +365,7 @@ struct nvme_ctrl {
> >   	struct nvme_effects_log *effects;
> >   	struct xarray cels;
> >   	struct work_struct scan_work;
> > +	struct work_struct ccr_work;
> >   	struct work_struct async_event_work;
> >   	struct delayed_work ka_work;
> >   	struct delayed_work failfast_work;
> 
> We really would need some indicator whether 'ccr' is supported at all.

Why do we need this indicator, other than exporting it via sysfs?

> Using the number of available CCR commands would be an option, if though
> that would require us to keep two counters (one for the number of
> possible outstanding CCRs, and one for the number of actual outstanding
> CCRs.).

Like mentioned above ctrl->ccr_limit gives us the number of ccrs
available now. It is not 100% indicator if CCR is supported or not, but
it is enough to implement CCR. A second counter can help us skip trying
CCR if we know impacted controller does not support it.

Do you think it is worth it?

Iterating over controllers in the subsystem is not that bad IMO. This is
similar to the point raised by James Smart [1].

1- https://lore.kernel.org/all/05875e07-b908-425a-ba6f-5e060e03241e@gmail.com/


