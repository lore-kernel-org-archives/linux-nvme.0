Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEBFEE644A
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Dec 2025 23:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iWzNss0H+aMgX+DgryBnOVYj1lJbOiTm3n0MKqsby9c=; b=HFmLb+5PHo1ytDZdomfabG/tjH
	JPdqdkEYC8jvXoV16Jd8OrD6x/X5KY3n/+EN/z0rVLaPT44Ncfw2i+y8jodKCVpwrYjtn2woga1Gu
	LkdvhjVzkCgwm2xFRo+yfA7tySbDwMBLlfBTQFLeTfW2AWMDOAqTBxnSqer//VMnBgKy65X2gaDsX
	j1OQ3SeIcX1HufluZVCn1Nl722wdm+GLiu45yZJgFTnOgnS81zwdHi8sxuUhZRqgpEJwDvdLLRaZy
	PQgjTafXAaYPyCt0T35NgZh+r0amdHK74iomEPlW24WHhnr2YwPGilFZOjBuSOq0o1aVYUCttj1qw
	xGjTTfvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb5rA-00000006QfM-0hsN;
	Wed, 31 Dec 2025 23:43:56 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb5r6-00000006Qf1-1Q6y
	for linux-nvme@lists.infradead.org;
	Wed, 31 Dec 2025 23:43:54 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-7f121c00dedso14873638b3a.0
        for <linux-nvme@lists.infradead.org>; Wed, 31 Dec 2025 15:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767224631; x=1767829431; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iWzNss0H+aMgX+DgryBnOVYj1lJbOiTm3n0MKqsby9c=;
        b=GIi5DkYw383qObjr4+FwKHl/48YmAPchfGQbpQkQk4DSCzlqY2ayrI+hN5VBW3yctC
         KXtENpELgU9SaWpSzu5KB0oJxlDZB6PaYTI6OcmcfnyWA3eQCTMbAzRhQClM0USP6Wwq
         55/1aMXNEgfV/fmslUg5G+8Sg6MYBcl7zmUGUnROS3MlmzIhlBuXpNJvHRNsYwMXh0Gr
         ADcwv+fzXmZXGzj1IwJgdDOI4mft7LLqGt4l2Xm/O0hqbR9q+XaD8gF8VqAtJkOX9GzZ
         A4yJ8I7iw/wnT5X2hW0NE0pCPkFKzoBd4x9WwfGh0GslZxGeLisBddmpK42wQvcJIVJf
         yAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767224631; x=1767829431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWzNss0H+aMgX+DgryBnOVYj1lJbOiTm3n0MKqsby9c=;
        b=diFQHsKMAZEIlnZ5tHNJzevlv72s314G9WuFwQptuH3YnnrG78PL5/s6QiXVwEYqlS
         mEo+Q0BbuB7pJPVZhvAf5thMgsxnKFXSeNeOY0DKFJKuK1bTPbyCQHLvtbNbU6Kn+9+i
         34M7QoysMijvt0tM5CyQHx2wErTChT+jzSQcK+7BKi8r/5lAGs0duJRKAX/d696ewyzk
         ljL8Kh9ymIiiE4Ftpj8DE2Twr54XM8486ei7vaGsekQVhuEho3askBg5mJgRA1IjLdgj
         HqAKt7lHusTY4lyVvMBY2XFcf5TpVw9Y0lzruShFvcHqin4vmKuUZGsCMO/EnNqG6b+J
         DgSA==
X-Forwarded-Encrypted: i=1; AJvYcCV9p2QaTC1hkFWKMNtF/OBem8jc/3sFhW2SVIobkATBEuHZjyUlS4PtW9p9bfcJ7gkb51yQragzp70M@lists.infradead.org
X-Gm-Message-State: AOJu0YzOyfaGE8IT1K4T/dG+6hjClcAeiOSP1U7F2hpSArMg1BRfQCyB
	Ms+EP+EkreinOnDuIhtWwJ2CfOc1LWQvvTgVPFXv9Dyg24yC4DA4ubKUzVplOEJqdA4=
X-Gm-Gg: AY/fxX5MplZ5ONmWizvJocfRjKmGpgowOok+YguCzXZavF2yL7uZWYwL1lwZnyj2ejz
	c2dNF7s+iAar/5GF3NDEpuDXJNNCrOOBlJYpb3VSbkvO1YmlGTm6TqRKPlnJU8lsVFOIEfCWTmR
	DBkwMg6NQsUwPWMUhBRVGY97cHymy/0olLobjIzYq1iRtMBS6G+zBzvoU92VjsNvnWlQQYJzqdE
	RbQgtQ0ZzunPe13c0gMMGolVKCwbq3xb7HvBBtP2KTF+f8SDUTIbp4zq/TM3RjuGDvLoNj7uVKP
	xBAm3mUtFi2dZnsMt9KV5nqKd+eUPZMnHc3h7/g7o4IPKU5uOAfa+TiMgs6OlgJ/+FF4UU1AIhi
	IOXElGBdOa42Eg2kRHchIjbD0QsamY51BcQmHOBE3jReVntHVoL9D1O0l4I8CZFRQRvBr+Cl5kD
	BGV3UnriL53GIa1Sqp2VxCVLLzykt3kquG+7xnNVQB3A==
X-Google-Smtp-Source: AGHT+IEhDAb/Ue0RyM7UYkZ3r6QYW7/vqd5OJlQV+JoxkoBTN3YmJ4WA+8naLYzyFUyH/yBS1aFXlg==
X-Received: by 2002:a05:7022:68a3:b0:119:e56b:c75f with SMTP id a92af1059eb24-121722f7fd4mr41595425c88.36.1767224630797;
        Wed, 31 Dec 2025 15:43:50 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-121724cfdd0sm141683911c88.4.2025.12.31.15.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 15:43:50 -0800 (PST)
Date: Wed, 31 Dec 2025 15:43:49 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 08/14] nvme: Implement cross-controller reset recovery
Message-ID: <20251231234349.GP3864520-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-9-mkhalfella@purestorage.com>
 <c698d201-0099-47a7-b5b0-d2322da63ea0@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c698d201-0099-47a7-b5b0-d2322da63ea0@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_154352_526924_E13989C6 
X-CRM114-Status: GOOD (  49.75  )
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

On Sat 2025-12-27 12:14:11 +0200, Sagi Grimberg wrote:
> 
> 
> On 26/11/2025 4:11, Mohamed Khalfella wrote:
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
> >   drivers/nvme/host/core.c      | 133 ++++++++++++++++++++++++++++++++++
> >   drivers/nvme/host/nvme.h      |  10 +++
> >   3 files changed, 144 insertions(+)
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
> > index f5b84bc327d3..f38b70ca9cee 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -554,6 +554,138 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
> >   }
> >   EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
> >   
> > +static struct nvme_ctrl *nvme_find_ccr_ctrl(struct nvme_ctrl *ictrl,
> > +					    u32 min_cntlid)
> > +{
> > +	struct nvme_subsystem *subsys = ictrl->subsys;
> > +	struct nvme_ctrl *sctrl;
> > +	unsigned long flags;
> > +
> > +	mutex_lock(&nvme_subsystems_lock);
> 
> This looks like the wrong lock to take here?

This is similar to nvme_validate_cntlid()?
What is the correct lock to use?

> 
> > +	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
> > +		if (sctrl->cntlid < min_cntlid)
> > +			continue;
> 
> The use of min_cntlid is not clear to me.
> 
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
> > +	mutex_unlock(&nvme_subsystems_lock);
> > +	return sctrl;
> > +}
> > +
> > +static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
> > +{
> > +	unsigned long flags, tmo, remain;
> > +	struct nvme_ccr_entry ccr = { };
> > +	union nvme_result res = { 0 };
> > +	struct nvme_command c = { };
> > +	u32 result;
> > +	int ret = 0;
> > +
> > +	init_completion(&ccr.complete);
> > +	ccr.ictrl = ictrl;
> > +
> > +	spin_lock_irqsave(&sctrl->lock, flags);
> > +	list_add_tail(&ccr.list, &sctrl->ccrs);
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
> > +	if (result & 0x01) /* Immediate Reset */
> > +		goto out;
> > +
> > +	tmo = msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
> > +	remain = wait_for_completion_timeout(&ccr.complete, tmo);
> > +	if (!remain)
> 
> I think remain is redundant here.

Deleted 'remain'.

> 
> > +		ret = -EAGAIN;
> > +out:
> > +	spin_lock_irqsave(&sctrl->lock, flags);
> > +	list_del(&ccr.list);
> > +	spin_unlock_irqrestore(&sctrl->lock, flags);
> > +	return ccr.ccrs == 1 ? 0 : ret;
> 
> Why would you still return 0 and not EAGAIN? you expired on timeout but 
> still
> return success if you have ccrs=1? btw you have ccrs in the ccr struct 
> and in the controller
> as a list. Lets rename to distinguish the two.

True, we did expire timeout here. However, after we removed the ccr
entry we found that it was marked as completed. We return success in
this case even though we hit timeout.

Renamed ctrl->ccrs to ctrl->ccr_list.

> 
> > +}
> > +
> > +unsigned long nvme_recover_ctrl(struct nvme_ctrl *ictrl)
> > +{
> 
> I'd call it nvme_fence_controller()

Okay. I will do that. I will also rename the controller state FENCING.

> 
> > +	unsigned long deadline, now, timeout;
> > +	struct nvme_ctrl *sctrl;
> > +	u32 min_cntlid = 0;
> > +	int ret;
> > +
> > +	timeout = nvme_recovery_timeout_ms(ictrl);
> > +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
> > +
> > +	now = jiffies;
> > +	deadline = now + msecs_to_jiffies(timeout);
> > +	while (time_before(now, deadline)) {
> > +		sctrl = nvme_find_ccr_ctrl(ictrl, min_cntlid);
> > +		if (!sctrl) {
> > +			/* CCR failed, switch to time-based recovery */
> > +			return deadline - now;
> 
> It is not clear what is the return code semantics of this function.
> How about making it success/failure and have the caller choose what to do?

The function returns 0 on success. On failure it returns the time in
jiffies to hold requests for before they are canceled. On failure the
returned time is essentially the hold time defined in TP4129 minus the
time it took to attempt CCR.

> 
> > +		}
> > +
> > +		ret = nvme_issue_wait_ccr(sctrl, ictrl);
> > +		atomic_inc(&sctrl->ccr_limit);
> 
> inc after you wait for the ccr? shouldn't this be before?

I think it should be after we wait for CCR. sctrl->ccr_limit is the
number of concurrent CCRs the controller supports. Only after we are
done with CCR on this controller we increment it.

> 
> > +
> > +		if (!ret) {
> > +			dev_info(ictrl->device, "CCR succeeded using %s\n",
> > +				 dev_name(sctrl->device));
> > +			blk_put_queue(sctrl->admin_q);
> > +			nvme_put_ctrl(sctrl);
> > +			return 0;
> > +		}
> > +
> > +		/* Try another controller */
> > +		min_cntlid = sctrl->cntlid + 1;
> 
> OK, I see why min_cntlid is used. That is very non-intuitive.
> 
> I'm wandering if it will be simpler to take one-shot at ccr and
> if it fails fallback to crt. I mean, if the sctrl is alive, and it was 
> unable
> to reset the ictrl in time, how would another ctrl do a better job here?

We need to attempt CCR from multiple controllers for reason explained in
another response. As you figured out min_cntlid is needed in order to
not loop controller list forever. Do you have a better idea?

> 
> > +		blk_put_queue(sctrl->admin_q);
> > +		nvme_put_ctrl(sctrl);
> > +		now = jiffies;
> > +	}
> > +
> > +	dev_info(ictrl->device, "CCR reached timeout, call it done\n");
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(nvme_recover_ctrl);
> > +
> > +void nvme_end_ctrl_recovery(struct nvme_ctrl *ctrl)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&ctrl->lock, flags);
> > +	WRITE_ONCE(ctrl->state, NVME_CTRL_RESETTING);
> 
> This needs to be a proper state transition.

We do not want to have proper transition from RECOVERING to RESETTING.
The reason is that we do not want the controller to be reset while it is
being recovered/fenced because requests should not be canceled. One way
to keep the transitions in nvme_change_ctrl_state() is to use two
states. Say FENCING and FENCED.

The allowed transitions are

- LIVE -> FENCING
- FENCING -> FENCED
- FENCED -> (RESETTING, DELETING)

This will also git rid of NVME_CTRL_RECOVERED

Does this sound good?

