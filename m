Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A620CE8304F
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 20:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pKmdjwjQV0FurQMURsi9szPJ5+6fsVkhSXDRLMusnFE=; b=Fp/qbrMPF70bBDeKXTnhz+K+3O
	cQuNxWiTdGBtqZ68o6y00AQSjKYTZQ7MsbQ1jiObDVH/r7RCr+xeKXJATRNwbHMJYJ6pJcxoA7OC0
	r2uuNSNN0tS1KfLmG2XDYvDOONbgZhJXmrn4S/rXhKgnhOHCgcMirynAzx3WuAgaDitQ/ZwCfsjDL
	9OFxm3ogoiVZENAlj71JEo+yC37hU2YjK6DNXQPoXRGXma9qY5BOPBi+GtVUr/ljCoiiYSQCh5nXo
	2ux8LxWlPMOnkX0+PnJlZCvndPzwxoMeYY6m2cw56pmabYqsG4BvYHYJ5FBGytzq69qPl/u4DmsYR
	CQSfbW8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnMZx-00000007HIV-01y5;
	Tue, 03 Feb 2026 20:00:53 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnMZv-00000007HHm-0OXu
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 20:00:52 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-12336c0a8b6so136313c88.1
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 12:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770148850; x=1770753650; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pKmdjwjQV0FurQMURsi9szPJ5+6fsVkhSXDRLMusnFE=;
        b=VJdwck6PTsV7YnJOS/Lr9eYpPNSvaYhV19crAVDLkudwpUs9J/fegd/JyPfSu75yBB
         Pg58v3DaGqLupxaK5OTODTSJaPysSebA5qjqDjnghMisowNxCSBCquCj+lPc/G9lmFHB
         zxuYzQIaS/qT4EbsPTepVFDPRzkhkC1+IcKucDmz2jsKpBi0sxqw6pHgRgnJADFBvSQL
         kfEnr1m/OzCWrhiloUQBz9Hj3dUk3RodxSzEIfFD2bKrHgs9jn/EfRmYJCcgBPNUF2I2
         SM3MMWud52El/p2yhjLDWGl3CRtCMeBs9I3NQcoDm7ABqKv1qsGKyGq9yvGh9Y7SRuLM
         2IFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770148850; x=1770753650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKmdjwjQV0FurQMURsi9szPJ5+6fsVkhSXDRLMusnFE=;
        b=D+kO4E2hxB2OiD3AzcVh7fVZtDTHPEfajPyWrh8/wuR1kgDyW9ADascQ2Anf1etr/o
         OpD/1u0s740bt5jkcI+wVuCGmbSsh+zWsQOPYuz3/orGGtoRHrUVMBSZ1vqU/c1cx22K
         dEMX1XdKEe/pL1D+t6QpytftQR23ssGT9eXiA9MqA7Pcl6CqiLMxuPoAb9XvqsDsgbqr
         m4KcbGHixhkbNvCxj51qZqXxZFmbw6Zn4COceewA1p3SYH5wL/3fxWJPgx82ObxyoipQ
         TyIzBXuoFkObwcnuJhx9g3VAmLCIiswocn0BmwmDkl+ZmnLU3jh+b/39GWnarW3nklle
         Gx6A==
X-Forwarded-Encrypted: i=1; AJvYcCUBBniuFZgnxTMJ3VDnAYEuF0c7qw/7ZvPMr0uPlY9lByOgevMo7Y4NpR68b/jMCK1tBZ3DOYzQi+O1@lists.infradead.org
X-Gm-Message-State: AOJu0YydZ5EM4ZBIoUP4tzvfjGRjusUg5WX/LAR1/lHWzohA7IY5zLbb
	tAfc8Xb+Ux+LxxguIU+zIr9Yp4xJmc5hy9/127okMLGab07n0p+eVS0OiIBscuhjjxQ=
X-Gm-Gg: AZuq6aLBXFe+NJhpTX1z0AaERJSv4QPBsh73uGKgUkY3O5HrfdbWb53q+RG/7l2YGTs
	cGKgILFkofCe0Khmr6T9BzjvaFVz0/25imIhNccm3Ch/5F+Ja9Y6SUe0/XyKrUKgaN1OwHITHYZ
	6NOAsPAqiFYFxLQDCpjKrc14xjIq3mo+rXoZWYKqyVTOo6B1PbxmEPII8BmaIvJiI/0ke6ggESV
	zZ0PKgP6O4s6ZliNojBiqzPmC4TppFwSp0jqvwjgQw33dx7TaEiuRWxUsPryfsD/JIxRud05PJW
	JyWVh6mNVvITN+kn1AED6i4n0Zh1nen06ZhIcBm+mzZ5vQ9R6HvZnoZw+rxCvgQxecbizrU5vnL
	HSo1kD2Eqn+VkTwFxP0ooFyNXDwpd1/3KBOBUoYb2jFOKkIjWXUPYjnJCIbONNfLVfO/qcodHYX
	dcfe4Bj6x9qs/rZW+5NwaOrSYVaM/Wcw0=
X-Received: by 2002:a05:7022:220a:b0:124:9acd:31b3 with SMTP id a92af1059eb24-126f46fa3cfmr316221c88.0.1770148849819;
        Tue, 03 Feb 2026 12:00:49 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-126f4e042bfsm275954c88.4.2026.02.03.12.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 12:00:49 -0800 (PST)
Date: Tue, 3 Feb 2026 12:00:48 -0800
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
Subject: Re: [PATCH v2 08/14] nvme: Implement cross-controller reset recovery
Message-ID: <20260203200048.GE3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-9-mkhalfella@purestorage.com>
 <528a39a9-f087-461f-9f5b-c4b5821396b6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <528a39a9-f087-461f-9f5b-c4b5821396b6@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_120051_175742_5EC3E579 
X-CRM114-Status: GOOD (  44.07  )
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

On Tue 2026-02-03 06:19:51 +0100, Hannes Reinecke wrote:
> On 1/30/26 23:34, Mohamed Khalfella wrote:
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
> >   drivers/nvme/host/core.c      | 129 ++++++++++++++++++++++++++++++++++
> >   drivers/nvme/host/nvme.h      |   9 +++
> >   3 files changed, 139 insertions(+)
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
> > index 3e1e02822dd4..13e0775d56b4 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -554,6 +554,134 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
> >   }
> >   EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
> >   
> > +static struct nvme_ctrl *nvme_find_ctrl_ccr(struct nvme_ctrl *ictrl,
> > +					    u32 min_cntlid)
> > +{
> > +	struct nvme_subsystem *subsys = ictrl->subsys;
> > +	struct nvme_ctrl *sctrl;
> > +	unsigned long flags;
> > +
> > +	mutex_lock(&nvme_subsystems_lock);
> > +	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
> > +		if (sctrl->cntlid < min_cntlid)
> > +			continue;
> > +
> > +		if (atomic_dec_if_positive(&sctrl->ccr_limit) < 0)
> > +			continue;
> > +
> > +		spin_lock_irqsave(&sctrl->lock, flags);
> > +		if (sctrl->state != NVME_CTRL_LIVE) {
> > +			spin_unlock_irqrestore(&sctrl->lock, flags);
> > +			atomic_inc(&sctrl->ccr_limit);
> > +			continue;
> > +		}
> > +
> > +		/*
> > +		 * We got a good candidate source controller that is locked and
> > +		 * LIVE. However, no guarantee sctrl will not be deleted after
> > +		 * sctrl->lock is released. Get a ref of both sctrl and admin_q
> > +		 * so they do not disappear until we are done with them.
> > +		 */
> > +		WARN_ON_ONCE(!blk_get_queue(sctrl->admin_q));
> > +		nvme_get_ctrl(sctrl);
> > +		spin_unlock_irqrestore(&sctrl->lock, flags);
> > +		goto found;
> > +	}
> > +	sctrl = NULL;
> > +found:
> 
> Normally one would be using a temporary loop variable and assign 'sctrl' 
> to that one if found. Then you can just call 'break' and drop the 'goto'.

Got it. I did like you suggested. It looks cleaner this way.

> 
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
> > +static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
> > +{
> > +	struct nvme_ccr_entry ccr = { };
> > +	union nvme_result res = { 0 };
> > +	struct nvme_command c = { };
> > +	unsigned long flags, tmo;
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
> > +	if (ret)
> > +		goto out;
> > +
> > +	result = le32_to_cpu(res.u32);
> > +	if (result & 0x01) /* Immediate Reset Successful */
> > +		goto out;
> > +
> > +	tmo = msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
> > +	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> > +		ret = -ETIMEDOUT;
> > +		goto out;
> > +	}
> > +
> > +	if (ccr.ccrs != NVME_CCR_STATUS_SUCCESS)
> > +		ret = -EREMOTEIO;
> > +out:
> > +	spin_lock_irqsave(&sctrl->lock, flags);
> > +	list_del(&ccr.list);
> > +	spin_unlock_irqrestore(&sctrl->lock, flags);
> > +	return ret;
> > +}
> > +
> > +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ictrl)
> > +{
> > +	unsigned long deadline, now, timeout;
> > +	struct nvme_ctrl *sctrl;
> > +	u32 min_cntlid = 0;
> > +	int ret;
> > +
> > +	timeout = nvme_fence_timeout_ms(ictrl);
> > +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
> > +
> > +	now = jiffies;
> > +	deadline = now + msecs_to_jiffies(timeout);
> > +	while (time_before(now, deadline)) {
> > +		sctrl = nvme_find_ctrl_ccr(ictrl, min_cntlid);
> > +		if (!sctrl) {
> > +			/* CCR failed, switch to time-based recovery */
> > +			return deadline - now;
> > +		}
> > +
> > +		ret = nvme_issue_wait_ccr(sctrl, ictrl);
> > +		if (!ret) {
> > +			dev_info(ictrl->device, "CCR succeeded using %s\n",
> > +				 dev_name(sctrl->device));
> > +			nvme_put_ctrl_ccr(sctrl);
> > +			return 0;
> > +		}
> > +
> > +		/* CCR failed, try another path */
> > +		min_cntlid = sctrl->cntlid + 1;
> > +		nvme_put_ctrl_ccr(sctrl);
> > +		now = jiffies;
> > +	}
> 
> That will spin until 'deadline' is reached if 'nvme_issue_wait_ccr()' 
> returns an error. _And_ if the CCR itself runs into a timeout we would
> never have tried another path (which could have succeeded).

True. We can do one thing at a time in CCR time budget. Either wait for
CCR to succeed or give up early and try another path. It is a trade off.

> 
> I'd rather rework this loop to open-code 'issue_and_wait()' in the loop,
> and only switch to the next controller if the submission of CCR failed.
> Once that is done we can 'just' wait for completion, as a failure there
> will be after KATO timeout anyway and any subsequent CCR would be pointless.

If I understood this correctly then we will stick with the first sctrl
that accepts the CCR command. We wait for CCR to complete and give up on
fencing ictrl if CCR operation fails or times out. Did I get this correctly?

If I got it correctly, why is this better that current logic?

Currently nvme_issue_wait_ccr() waits max(cqt, kato) for CCR to
complete. If we change this logic, should it wait for "deadline - now"
for CCR to complete? Or keep it as it is?

The specs does not say how much time to wait for CCR operation to complete.
My impression is that max(cqt, kato) is a reasonable amount of time to
wait. If we do not hear from sctrl then we should switch to next path.

> 
> > +
> > +	dev_info(ictrl->device, "CCR reached timeout, call it done\n");
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(nvme_fence_ctrl);
> > +
> >   bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
> >   		enum nvme_ctrl_state new_state)
> >   {
> > @@ -5119,6 +5247,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> >   
> >   	mutex_init(&ctrl->scan_lock);
> >   	INIT_LIST_HEAD(&ctrl->namespaces);
> > +	INIT_LIST_HEAD(&ctrl->ccr_list);
> >   	xa_init(&ctrl->cels);
> >   	ctrl->dev = dev;
> >   	ctrl->ops = ops;
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index 00866bbc66f3..fa18f580d76a 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -279,6 +279,13 @@ enum nvme_ctrl_flags {
> >   	NVME_CTRL_FROZEN		= 6,
> >   };
> >   
> > +struct nvme_ccr_entry {
> > +	struct list_head list;
> > +	struct completion complete;
> > +	struct nvme_ctrl *ictrl;
> > +	u8 ccrs;
> > +};
> > +
>  >   struct nvme_ctrl {>   	bool comp_seen;
> >   	bool identified;
> > @@ -296,6 +303,7 @@ struct nvme_ctrl {
> >   	struct blk_mq_tag_set *tagset;
> >   	struct blk_mq_tag_set *admin_tagset;
> >   	struct list_head namespaces;
> > +	struct list_head ccr_list;
> >   	struct mutex namespaces_lock;
> >   	struct srcu_struct srcu;
> >   	struct device ctrl_device;
> > @@ -814,6 +822,7 @@ blk_status_t nvme_host_path_error(struct request *req);
> >   bool nvme_cancel_request(struct request *req, void *data);
> >   void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
> >   void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
> > +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ctrl);
> >   bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
> >   		enum nvme_ctrl_state new_state);
> >   int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

