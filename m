Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB194E6BF3B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hv8xHE5lbJZhtXoHww86SSFqncEUPVa+vZHz5hRSWAE=; b=pQ45XGAQTNsnuHzoII60YED2HP
	+ufGTEyHL0R6Qz5vwAELnYW8G2jZAtXDx49p7TRQJDHOq4sFhPmfXa+MJN5EJbWIa8rsvDyXtXpuE
	1W1XpIyrabkFdcDZyDXgPCZjAav70sxepntll2lKefYUvpHDjGuBJtJ28RmNQ2cLdzYXdx3ir7N0X
	UM0mouqksQ6yXOJz1ZkfAM29UoQNibIDD/hNfm1tARCpiDq43Hc4mEIGFg5q6sI9g5SWWiU5JaV2z
	wjuARiJ/we7axpSj0IkjZygrimY8bdP2qExhjx8Kx41eKyOZCoTFcZWV8oFmKLvKXben6+cLWYeMy
	AQZhSZrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlwYQ-0000000212o-3NsZ;
	Fri, 30 Jan 2026 22:01:26 +0000
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlwYN-00000002121-3JNg
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:01:25 +0000
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso4508000eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769810482; x=1770415282; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hv8xHE5lbJZhtXoHww86SSFqncEUPVa+vZHz5hRSWAE=;
        b=ZWQ+TClLDtVFTVlXuysBozs1wOc850Tom+9LZlMFifErfub+i7xQoKJ/GKP4r9deSQ
         KKDnsSeGLD1n2DJFtRDm+xPaTxV8jGB/YCH51wMNZqbWlQpc3ZrlDfGnqDTsaXAtAVu0
         xRFb+J4Yg1v4q5nvRy7MVPXczStLKz/6hi7j82o67maoZ7LVTtZO4XbcUpH1346lA5d2
         OuMLPL+A2Y6Knn4Ph2Ou74+g50sG+xwf88eRVjO56RcMM/Pj/ziwqLodKkfK2iaQcNQ/
         bTdAZ+U8EfkkvMyP3CURCAAecJW78hM9rrOculmUpX8PJDrROdbnC+Xtw2EiLqAlIoOq
         A86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810482; x=1770415282;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hv8xHE5lbJZhtXoHww86SSFqncEUPVa+vZHz5hRSWAE=;
        b=UGBU4gvbe/sUUzjHgbqhS20SR+zrajYbThU1fSy83q8XVWnSlx0q+Wrx51jq2W3ENJ
         w4h0Q84yY+h8Vfd3Qv/DAoweIuxvuVh6QjnYpJk9a0UnrnFShrHGAVptmuLA1LMxK4d/
         Ky27DdI3w3CFtsT071Z5OutbmBPDA6oTHmJNhwYYXchInsYFZpe342pVnpNwGfu+SjhC
         Ho0XOMlwcQpt1MRlIpKwvZeODdcdRGCvndhTmOINYD3MgTRuqyVQ40RFDK9moMkIT8cO
         +QhHwUvSmEzojI8+Vsvkn3ThUfrn+gmhswN+Kyvl+DnTyf5U+ZTmoTmMceP+H1xOUvqo
         XjLA==
X-Forwarded-Encrypted: i=1; AJvYcCXy1IApJQ94fk35GQq3EhZoMwr9i3AqNQtSuVK3L9ToYwev8HiejmJ0gnjXdKyKYSkN+kIV4WpxLtQP@lists.infradead.org
X-Gm-Message-State: AOJu0Yyiee3qi9o+jsdCre02I90x3/flbMvHbR7QZ9d9n3oyu1DaN0GE
	zLUdVmcXoRfMJ5U9ekKwSciscVBtbq/wqp1f8lqgfxqERbmar1LSYi2HwK+8IPetd/8=
X-Gm-Gg: AZuq6aK1IqWL2OFBOEZ/jR9SMEOtown7Lh5bUcJMAG7JWDuowOgsYaQb6FVt5+qyVbm
	R0/LKUkCnBOxaOypsbblo8XPeQwaLEde5lmuL56pMc6vUZ4qotiDF2LkDXVseXJNj5s9t2caKx9
	3Uf+2QNmJCpkPliKA1sjv3RYl+y05WJ1PkOBn2zPVww/5i12SyH8e73fNzmpK9LCeHA7lqUnSoZ
	wIH/2y4XX+UKhzAzEEJC+jwYlk78+qADVmTY1NhTquNm3fi2AkuHeBR/hxrKVGL3DZ8qo9LcSNf
	WrxnPoZJEoUKcGMyzVQk2iYsgHtdBXHMSQ6035OvFeIODrjgyfsFwumyQCuOnABLZlywIBDsL81
	tpx2adi+iiK9qQkU8y4/boH/79shI5yh9qEadkt1mB+oggQyISpofxbziYSzqLsWLkpbC7jgH5q
	gFyxHB3nRmptrnHosKXDzc+0gwpioZfq4=
X-Received: by 2002:a05:7300:a984:b0:2b7:befe:3755 with SMTP id 5a478bee46e88-2b7c8650361mr2530798eec.15.1769810480311;
        Fri, 30 Jan 2026 14:01:20 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2b7a16cfaa8sm12524114eec.4.2026.01.30.14.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:01:19 -0800 (PST)
Date: Fri, 30 Jan 2026 14:01:19 -0800
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
Message-ID: <20260130220119.GE1710902-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-9-mkhalfella@purestorage.com>
 <c698d201-0099-47a7-b5b0-d2322da63ea0@grimberg.me>
 <20251231234349.GP3864520-mkhalfella@purestorage.com>
 <cdd44f55-cc5a-4ebe-aaba-6201674b9326@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdd44f55-cc5a-4ebe-aaba-6201674b9326@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_140123_996505_1298165D 
X-CRM114-Status: GOOD (  64.34  )
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

On Sun 2026-01-04 23:39:35 +0200, Sagi Grimberg wrote:
> 
> 
> On 01/01/2026 1:43, Mohamed Khalfella wrote:
> > On Sat 2025-12-27 12:14:11 +0200, Sagi Grimberg wrote:
> >>
> >> On 26/11/2025 4:11, Mohamed Khalfella wrote:
> >>> A host that has more than one path connecting to an nvme subsystem
> >>> typically has an nvme controller associated with every path. This is
> >>> mostly applicable to nvmeof. If one path goes down, inflight IOs on that
> >>> path should not be retried immediately on another path because this
> >>> could lead to data corruption as described in TP4129. TP8028 defines
> >>> cross-controller reset mechanism that can be used by host to terminate
> >>> IOs on the failed path using one of the remaining healthy paths. Only
> >>> after IOs are terminated, or long enough time passes as defined by
> >>> TP4129, inflight IOs should be retried on another path. Implement core
> >>> cross-controller reset shared logic to be used by the transports.
> >>>
> >>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> >>> ---
> >>>    drivers/nvme/host/constants.c |   1 +
> >>>    drivers/nvme/host/core.c      | 133 ++++++++++++++++++++++++++++++++++
> >>>    drivers/nvme/host/nvme.h      |  10 +++
> >>>    3 files changed, 144 insertions(+)
> >>>
> >>> diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
> >>> index dc90df9e13a2..f679efd5110e 100644
> >>> --- a/drivers/nvme/host/constants.c
> >>> +++ b/drivers/nvme/host/constants.c
> >>> @@ -46,6 +46,7 @@ static const char * const nvme_admin_ops[] = {
> >>>    	[nvme_admin_virtual_mgmt] = "Virtual Management",
> >>>    	[nvme_admin_nvme_mi_send] = "NVMe Send MI",
> >>>    	[nvme_admin_nvme_mi_recv] = "NVMe Receive MI",
> >>> +	[nvme_admin_cross_ctrl_reset] = "Cross Controller Reset",
> >>>    	[nvme_admin_dbbuf] = "Doorbell Buffer Config",
> >>>    	[nvme_admin_format_nvm] = "Format NVM",
> >>>    	[nvme_admin_security_send] = "Security Send",
> >>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >>> index f5b84bc327d3..f38b70ca9cee 100644
> >>> --- a/drivers/nvme/host/core.c
> >>> +++ b/drivers/nvme/host/core.c
> >>> @@ -554,6 +554,138 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
> >>>    }
> >>>    EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
> >>>    
> >>> +static struct nvme_ctrl *nvme_find_ccr_ctrl(struct nvme_ctrl *ictrl,
> >>> +					    u32 min_cntlid)
> >>> +{
> >>> +	struct nvme_subsystem *subsys = ictrl->subsys;
> >>> +	struct nvme_ctrl *sctrl;
> >>> +	unsigned long flags;
> >>> +
> >>> +	mutex_lock(&nvme_subsystems_lock);
> >> This looks like the wrong lock to take here?
> > This is similar to nvme_validate_cntlid()?
> > What is the correct lock to use?
> 
> Not really, its only because it is called from nvme_init_subsystem which 
> spans
> subsystems.

Okay. I will use this lock for now. If this is not the right lock to use
please point me to the right one.

> 
> >
> >>> +	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
> >>> +		if (sctrl->cntlid < min_cntlid)
> >>> +			continue;
> >> The use of min_cntlid is not clear to me.
> >>
> >>> +
> >>> +		if (atomic_dec_if_positive(&sctrl->ccr_limit) < 0)
> >>> +			continue;
> >>> +
> >>> +		spin_lock_irqsave(&sctrl->lock, flags);
> >>> +		if (sctrl->state != NVME_CTRL_LIVE) {
> >>> +			spin_unlock_irqrestore(&sctrl->lock, flags);
> >>> +			atomic_inc(&sctrl->ccr_limit);
> >>> +			continue;
> >>> +		}
> >>> +
> >>> +		/*
> >>> +		 * We got a good candidate source controller that is locked and
> >>> +		 * LIVE. However, no guarantee sctrl will not be deleted after
> >>> +		 * sctrl->lock is released. Get a ref of both sctrl and admin_q
> >>> +		 * so they do not disappear until we are done with them.
> >>> +		 */
> >>> +		WARN_ON_ONCE(!blk_get_queue(sctrl->admin_q));
> >>> +		nvme_get_ctrl(sctrl);
> >>> +		spin_unlock_irqrestore(&sctrl->lock, flags);
> >>> +		goto found;
> >>> +	}
> >>> +	sctrl = NULL;
> >>> +found:
> >>> +	mutex_unlock(&nvme_subsystems_lock);
> >>> +	return sctrl;
> >>> +}
> >>> +
> >>> +static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
> >>> +{
> >>> +	unsigned long flags, tmo, remain;
> >>> +	struct nvme_ccr_entry ccr = { };
> >>> +	union nvme_result res = { 0 };
> >>> +	struct nvme_command c = { };
> >>> +	u32 result;
> >>> +	int ret = 0;
> >>> +
> >>> +	init_completion(&ccr.complete);
> >>> +	ccr.ictrl = ictrl;
> >>> +
> >>> +	spin_lock_irqsave(&sctrl->lock, flags);
> >>> +	list_add_tail(&ccr.list, &sctrl->ccrs);
> >>> +	spin_unlock_irqrestore(&sctrl->lock, flags);
> >>> +
> >>> +	c.ccr.opcode = nvme_admin_cross_ctrl_reset;
> >>> +	c.ccr.ciu = ictrl->ciu;
> >>> +	c.ccr.icid = cpu_to_le16(ictrl->cntlid);
> >>> +	c.ccr.cirn = cpu_to_le64(ictrl->cirn);
> >>> +	ret = __nvme_submit_sync_cmd(sctrl->admin_q, &c, &res,
> >>> +				     NULL, 0, NVME_QID_ANY, 0);
> >>> +	if (ret)
> >>> +		goto out;
> >>> +
> >>> +	result = le32_to_cpu(res.u32);
> >>> +	if (result & 0x01) /* Immediate Reset */
> >>> +		goto out;
> >>> +
> >>> +	tmo = msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
> >>> +	remain = wait_for_completion_timeout(&ccr.complete, tmo);
> >>> +	if (!remain)
> >> I think remain is redundant here.
> > Deleted 'remain'.
> >
> >>> +		ret = -EAGAIN;
> >>> +out:
> >>> +	spin_lock_irqsave(&sctrl->lock, flags);
> >>> +	list_del(&ccr.list);
> >>> +	spin_unlock_irqrestore(&sctrl->lock, flags);
> >>> +	return ccr.ccrs == 1 ? 0 : ret;
> >> Why would you still return 0 and not EAGAIN? you expired on timeout but
> >> still
> >> return success if you have ccrs=1? btw you have ccrs in the ccr struct
> >> and in the controller
> >> as a list. Lets rename to distinguish the two.
> > True, we did expire timeout here. However, after we removed the ccr
> > entry we found that it was marked as completed. We return success in
> > this case even though we hit timeout.
> 
> When does this happen? Why is it worth having the code non-intuitive for
> something that effectively never happens (unless I'm missing something?)

Agree. It is a very low probability. I deleted the check for this
condition.

> 
> >
> > Renamed ctrl->ccrs to ctrl->ccr_list.
> >
> >>> +}
> >>> +
> >>> +unsigned long nvme_recover_ctrl(struct nvme_ctrl *ictrl)
> >>> +{
> >> I'd call it nvme_fence_controller()
> > Okay. I will do that. I will also rename the controller state FENCING.
> >
> >>> +	unsigned long deadline, now, timeout;
> >>> +	struct nvme_ctrl *sctrl;
> >>> +	u32 min_cntlid = 0;
> >>> +	int ret;
> >>> +
> >>> +	timeout = nvme_recovery_timeout_ms(ictrl);
> >>> +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
> >>> +
> >>> +	now = jiffies;
> >>> +	deadline = now + msecs_to_jiffies(timeout);
> >>> +	while (time_before(now, deadline)) {
> >>> +		sctrl = nvme_find_ccr_ctrl(ictrl, min_cntlid);
> >>> +		if (!sctrl) {
> >>> +			/* CCR failed, switch to time-based recovery */
> >>> +			return deadline - now;
> >> It is not clear what is the return code semantics of this function.
> >> How about making it success/failure and have the caller choose what to do?
> > The function returns 0 on success. On failure it returns the time in
> > jiffies to hold requests for before they are canceled. On failure the
> > returned time is essentially the hold time defined in TP4129 minus the
> > time it took to attempt CCR.
> 
> I think it would be cleaner to simple have this function return status 
> code and
> have the caller worry about time spent.

nvme_fence_ctrl() needs to track the time. It needs to be aware of how
much time spent on attempting CCR in order to decide whether to continue
trying CCR or give up.

> 
> >
> >>> +		}
> >>> +
> >>> +		ret = nvme_issue_wait_ccr(sctrl, ictrl);
> >>> +		atomic_inc(&sctrl->ccr_limit);
> >> inc after you wait for the ccr? shouldn't this be before?
> > I think it should be after we wait for CCR. sctrl->ccr_limit is the
> > number of concurrent CCRs the controller supports. Only after we are
> > done with CCR on this controller we increment it.
> 
> Maybe it should be folded into nvme_issue_wait_ccr for symmetry?

Done.

> 
> >
> >>> +
> >>> +		if (!ret) {
> >>> +			dev_info(ictrl->device, "CCR succeeded using %s\n",
> >>> +				 dev_name(sctrl->device));
> >>> +			blk_put_queue(sctrl->admin_q);
> >>> +			nvme_put_ctrl(sctrl);
> >>> +			return 0;
> >>> +		}
> >>> +
> >>> +		/* Try another controller */
> >>> +		min_cntlid = sctrl->cntlid + 1;
> >> OK, I see why min_cntlid is used. That is very non-intuitive.
> >>
> >> I'm wandering if it will be simpler to take one-shot at ccr and
> >> if it fails fallback to crt. I mean, if the sctrl is alive, and it was
> >> unable
> >> to reset the ictrl in time, how would another ctrl do a better job here?
> > We need to attempt CCR from multiple controllers for reason explained in
> > another response. As you figured out min_cntlid is needed in order to
> > not loop controller list forever. Do you have a better idea?
> 
> No, just know that I don't like it very much :)
> 
> >
> >>> +		blk_put_queue(sctrl->admin_q);
> >>> +		nvme_put_ctrl(sctrl);
> >>> +		now = jiffies;
> >>> +	}
> >>> +
> >>> +	dev_info(ictrl->device, "CCR reached timeout, call it done\n");
> >>> +	return 0;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(nvme_recover_ctrl);
> >>> +
> >>> +void nvme_end_ctrl_recovery(struct nvme_ctrl *ctrl)
> >>> +{
> >>> +	unsigned long flags;
> >>> +
> >>> +	spin_lock_irqsave(&ctrl->lock, flags);
> >>> +	WRITE_ONCE(ctrl->state, NVME_CTRL_RESETTING);
> >> This needs to be a proper state transition.
> > We do not want to have proper transition from RECOVERING to RESETTING.
> > The reason is that we do not want the controller to be reset while it is
> > being recovered/fenced because requests should not be canceled. One way
> > to keep the transitions in nvme_change_ctrl_state() is to use two
> > states. Say FENCING and FENCED.
> >
> > The allowed transitions are
> >
> > - LIVE -> FENCING
> > - FENCING -> FENCED
> > - FENCED -> (RESETTING, DELETING)
> >
> > This will also git rid of NVME_CTRL_RECOVERED
> >
> > Does this sound good?
> 
> We could do what failfast is doing, in case we get transition FENCING -> 
> RESETTING/DELETING we flush
> the fence_work...

Yes. This is what v2 does.

