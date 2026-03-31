Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3151410F92E0
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2026 16:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B5AgkFEvCnT6f4BK4/qZpldsBicfsRimh7sp9Id4RbY=; b=jrAZX4qK+xWhFpQJyNvbd+QGxk
	QowUl3MGyWtOvrO3T6HadJ3d4xAm/MvJ6aSENIwXjCt1/lF6hrqEBGj/2Dof5TSJC0f0grxijuqKn
	qgbFh+f4eKnJQehwucQ7xsi0M3Mw20vgG/SzvCT9CRz8WcAVOc9ibxHpxrvQBmTCW3QGEGIRks/x6
	412iHp95GUrdI9gfd3MpKbPLYW9ARiA7mAVldnUmw22jWsNnklmQURcEr5zqh9gwvMWYjL+INtzIp
	giWs2NEcPFOtPmwzaBa1sfL9Y2yMPK8Ans3IMVSGmQVdOEOCOnKTluX6W787tXjBHPdhyBCDwRaRC
	hKQD2tgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7cFe-0000000DHCx-2m8E;
	Tue, 31 Mar 2026 16:47:38 +0000
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7cFb-0000000DHCC-3hx2
	for linux-nvme@lists.infradead.org;
	Tue, 31 Mar 2026 16:47:37 +0000
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-2b4520f6b32so6561161eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2026 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774975655; x=1775580455; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B5AgkFEvCnT6f4BK4/qZpldsBicfsRimh7sp9Id4RbY=;
        b=C5WQPcHBV+qSIVgOuqYRPpOBPNmcMemObpKk3hQ8gRoft0N9SnVwhnUkSiaSU30x8r
         UgllTBwNXZIjbbnFm/xABkxY0qNMmaNmttRlSnfK2lA0qZ+zvKkV/G9M47Ng8fw8JIGl
         EU/JEWDkneapl4Yo9qPKbFhau45yv7j+1tXgT+OQE70U3aYUASn/ZgJJeJmKMeBDAf1d
         QMQq/EI175ng4X33VIMasAA34zTywOV5+oTpqxe5Im0WunauosSq1jf/bEHKjl1PQ4z7
         m9tIbqY5Lb0kDpU6Whj97cJd/lAauy6BHa4R5itxqOX9SLxzqz6oezVX+9D9DHVwl1o8
         LOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774975655; x=1775580455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5AgkFEvCnT6f4BK4/qZpldsBicfsRimh7sp9Id4RbY=;
        b=YKsYPRqpkInm4n0z4Hsmtn5Rj1Td9JUmtEsXuDrnksLd79aJYspDF8aGBhnp+Uyqan
         /VnMdjSHgv+J3lI5Oe7XlooV7UO22ynEcy3rj6Wbpaqhcu9bwMbGHxuAkvinTeem6J45
         QncvsgKO/OoA75QFfBDwBwThXO3VKqNcBaCy+oFkkjXv02QzzZRCKomkLQyTL0wYLveC
         Mx6WgFovHk81Hf+cF06pdUWcTfDeBY0AL+K4JvharwY95VIq39YSvWMDcfBr7WlOx86z
         RsbGgt6HlHtn9t7eEMEN7cxdd8mFDNCO9wIqo8Rb4FdcdUdLwqMROLWCvvVb1OeiDnCJ
         bISw==
X-Forwarded-Encrypted: i=1; AJvYcCVn4GpyJiRUOooqmWUJG08qkwRZOI5juSdkjKB32fpdv3nyXL2AGHr0weUnAnP79S/SBYlyLbyBNmP2@lists.infradead.org
X-Gm-Message-State: AOJu0YyVzHjacyoDlBsBafKLlgRzUJfmr8V+CVAdqaGnWgA1kh8bgxu+
	rF8FPAYIo1w1LSg33EO4HZQ85GQ6UkNvVP8wj70Nh2U0hir5M9lHot/7d9HSI4jt6VY=
X-Gm-Gg: ATEYQzysfqmghPDS2aEBKj9oyYUQnlr4BKDqYrxGhd2g/bLfQ8RYCsVJTxgGBQed0vI
	KMazpAGNHATcH5M9WKYnrrkJFdMzB1WZQtfC+umdws2uegLLYWSw+yqSThGwf8kGsvVZVQhI6PP
	K8NPIAdoN9k4Ga/wtPoVUzzOD5cv0CdJYDRysQzwAMGQPpTmyJWDNGQ7gr4r7R/mjN2DHJ02O1X
	AQdGd49p8GhaaasZnZx9UYoLyLkE7zmJ79OWlu8oRMcgNxVo9tPr/G7Kv6kQqmBLBk5fP7/R/FF
	YhomwJHSW8Z/v+ktSV19szBRvTk5HTzhN3SIQO0cwbQ12XEroQ1A8zSFbdWE17eIZzNN+me/wc5
	Yy+K9d5WCJefWiw4vI5qhE1KZKkgS0bI414P4srmtolaEqB/IeifRJTbHj14u75KHYWRoXhIJaa
	BoOSRjA4a4ZTr70zmp+KfmjdnPCvM0YOrs0JSDqRVgVxLO
X-Received: by 2002:a05:693c:3005:b0:2c1:23d:c728 with SMTP id 5a478bee46e88-2c185f95f4fmr9120915eec.31.1774975654492;
        Tue, 31 Mar 2026 09:47:34 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2c3c46a0a84sm10278042eec.9.2026.03.31.09.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:47:34 -0700 (PDT)
Date: Tue, 31 Mar 2026 09:47:33 -0700
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
Subject: Re: [PATCH v4 08/15] nvme: Implement cross-controller reset recovery
Message-ID: <20260331164733.GC2861-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
 <20260328004518.1729186-9-mkhalfella@purestorage.com>
 <ee086ee1-a48f-41fb-a7fe-afc6b738cf21@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee086ee1-a48f-41fb-a7fe-afc6b738cf21@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_094735_956077_D9191772 
X-CRM114-Status: GOOD (  35.96  )
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

On Mon 2026-03-30 12:50:24 +0200, Hannes Reinecke wrote:
> On 3/28/26 01:43, Mohamed Khalfella wrote:
> > A host that has more than one path connecting to an nvme subsystem
> > typically has an nvme controller associated with every path. This is
> > mostly applicable to nvmeof. If one path goes down, inflight IOs on that
> > path should not be retried immediately on another path because this
> > could lead to data corruption as described in TP4129. TP8028 defines
> > cross-controller reset mechanism that can be used by host to terminate
> > IOs on the failed path using one of the remaining healthy paths. Only
> > after IOs are terminated, or long enough time passes as defined by
> > TP4129, inflight IOs should be retried on another path. Implement core
> > cross-controller reset shared logic to be used by the transports.
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/host/constants.c |   1 +
> >   drivers/nvme/host/core.c      | 145 ++++++++++++++++++++++++++++++++++
> >   drivers/nvme/host/nvme.h      |   9 +++
> >   3 files changed, 155 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
> > index dc90df9e13a2..f679efd5110e 100644
> > --- a/drivers/nvme/host/constants.c
> > +++ b/drivers/nvme/host/constants.c
> > @@ -46,6 +46,7 @@ static const char * const nvme_admin_ops[] = {
> >   	[nvme_admin_virtual_mgmt] = "Virtual Management",
> >   	[nvme_admin_nvme_mi_send] = "NVMe Send MI",
> >   	[nvme_admin_nvme_mi_recv] = "NVMe Receive MI",
> > +	[nvme_admin_cross_ctrl_reset] = "Cross Controller Reset",
> >   	[nvme_admin_dbbuf] = "Doorbell Buffer Config",
> >   	[nvme_admin_format_nvm] = "Format NVM",
> >   	[nvme_admin_security_send] = "Security Send",
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 824a1193bec8..5603ae36444f 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -554,6 +554,150 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
> >   }
> >   EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
> >   
> > +static struct nvme_ctrl *nvme_find_ctrl_ccr(struct nvme_ctrl *ictrl,
> > +					    u32 min_cntlid)
> > +{
> > +	struct nvme_subsystem *subsys = ictrl->subsys;
> > +	struct nvme_ctrl *ctrl, *sctrl = NULL;
> > +	unsigned long flags;
> > +
> > +	mutex_lock(&nvme_subsystems_lock);
> > +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> > +		if (ctrl->cntlid < min_cntlid)
> > +			continue;
> > +
> > +		if (atomic_dec_if_positive(&ctrl->ccr_limit) < 0)
> > +			continue;
> > +
> > +		spin_lock_irqsave(&ctrl->lock, flags);
> > +		if (ctrl->state != NVME_CTRL_LIVE) {
> > +			spin_unlock_irqrestore(&ctrl->lock, flags);
> > +			atomic_inc(&ctrl->ccr_limit);
> > +			continue;
> > +		}
> > +
> > +		/*
> > +		 * We got a good candidate source controller that is locked and
> > +		 * LIVE. However, no guarantee ctrl will not be deleted after
> > +		 * ctrl->lock is released. Get a ref of both ctrl and admin_q
> > +		 * so they do not disappear until we are done with them.
> > +		 */
> > +		WARN_ON_ONCE(!blk_get_queue(ctrl->admin_q));
> > +		nvme_get_ctrl(ctrl);
> > +		spin_unlock_irqrestore(&ctrl->lock, flags);
> > +		sctrl = ctrl;
> > +		break;
> > +	}
> > +	mutex_unlock(&nvme_subsystems_lock);
> > +	return sctrl;
> > +}
> > +
> > +static void nvme_put_ctrl_ccr(struct nvme_ctrl *sctrl)
> > +{
> > +	atomic_inc(&sctrl->ccr_limit);
> > +	blk_put_queue(sctrl->admin_q);
> > +	nvme_put_ctrl(sctrl);
> > +}
> > +
> > +static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl,
> > +			       unsigned long deadline)
> > +{
> > +	struct nvme_ccr_entry ccr = { };
> > +	union nvme_result res = { 0 };
> > +	struct nvme_command c = { };
> > +	unsigned long flags, now, tmo = 0;
> > +	bool completed = false;
> > +	int ret = 0;
> > +	u32 result;
> > +
> > +	init_completion(&ccr.complete);
> > +	ccr.ictrl = ictrl;
> > +
> > +	spin_lock_irqsave(&sctrl->lock, flags);
> > +	list_add_tail(&ccr.list, &sctrl->ccr_list);
> > +	spin_unlock_irqrestore(&sctrl->lock, flags);
> > +
> > +	c.ccr.opcode = nvme_admin_cross_ctrl_reset;
> > +	c.ccr.ciu = ictrl->ciu;
> > +	c.ccr.icid = cpu_to_le16(ictrl->cntlid);
> > +	c.ccr.cirn = cpu_to_le64(ictrl->cirn);
> > +	ret = __nvme_submit_sync_cmd(sctrl->admin_q, &c, &res,
> > +				     NULL, 0, NVME_QID_ANY, 0);
> > +	if (ret) {
> > +		ret = -EIO;
> > +		goto out;
> > +	}
> > +
> > +	result = le32_to_cpu(res.u32);
> > +	if (result & 0x01) /* Immediate Reset Successful */
> > +		goto out;
> > +
> > +	now = jiffies;
> > +	if (time_before(now, deadline))
> > +		tmo = min_t(unsigned long,
> > +			    secs_to_jiffies(ictrl->kato), deadline - now);
> > +
> > +	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> > +		ret = -ETIMEDOUT;
> > +		goto out;
> > +	}
> > +
> > +	completed = true;
> > +
> > +out:
> > +	spin_lock_irqsave(&sctrl->lock, flags);
> > +	list_del(&ccr.list);
> > +	spin_unlock_irqrestore(&sctrl->lock, flags);
> > +	if (completed) {
> > +		if (ccr.ccrs == NVME_CCR_STATUS_SUCCESS)
> > +			return 0;
> > +		return -EREMOTEIO;
> > +	}
> > +	return ret;
> > +}
> > +
> > +int nvme_fence_ctrl(struct nvme_ctrl *ictrl)
> > +{
> > +	unsigned long deadline, timeout;
> > +	struct nvme_ctrl *sctrl;
> > +	u32 min_cntlid = 0;
> > +	int ret;
> > +
> > +	timeout = nvme_fence_timeout_ms(ictrl);
> > +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
> > +
> > +	deadline = jiffies + msecs_to_jiffies(timeout);
> > +	while (time_is_after_jiffies(deadline)) {
> > +		sctrl = nvme_find_ctrl_ccr(ictrl, min_cntlid);
> > +		if (!sctrl) {
> > +			dev_dbg(ictrl->device,
> > +				"failed to find source controller\n");
> > +			return -EIO;
> > +		}
> > +
> > +		ret = nvme_issue_wait_ccr(sctrl, ictrl, deadline);
> > +		if (!ret) {
> > +			dev_info(ictrl->device, "CCR succeeded using %s\n",
> > +				 dev_name(sctrl->device));
> > +			nvme_put_ctrl_ccr(sctrl);
> > +			return 0;
> > +		}
> > +
> > +		min_cntlid = sctrl->cntlid + 1;
> > +		nvme_put_ctrl_ccr(sctrl);
> > +
> > +		if (ret == -EIO) /* CCR command failed */
> > +			continue;
> > +
> > +		/* CCR operation failed or timed out */
> > +		return ret;
> > +	}
> > +
> > +	dev_info(ictrl->device, "CCR operation timeout\n");
> > +	return -ETIMEDOUT;
> > +}
> 
> Please restructure the loop.
> Having a comment 'CCR operation failed or timed out',
> returning a status, and then have a comment
> 'CCR operation timeout' _after_ the return is confusing.

I can change /* CCR operation failed or timed out */ to something like

/*
 * Source controller accepted CCR command but CCR operation
 * timed out or failed. Retrying another path is not likely
 * to succeed, return an error.
 */

And change the log line "CCR operation timeout\n" outside the while
loop to "fencing timedout\n".

Will this help?

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

