Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7395E8FDD0
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Dec 2025 10:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sVngXyfV5VfUvnHB7imQkLJPUPEXpqDfOdOUdCSXF7M=; b=odZJS9JqtpWsxboQ+QeZE7wOtQ
	Pv0sHYi/2EEG28YwV8PIn02k1lGDjtI/kQAG3ifb3zx6rKmBzxBAhw3/GNv0P/mwJLWwCkvPjJ5ch
	BwJT52DFQL23hfzu2S3vFN24fKs5vLisYI6OIfsT/QdjViC4l32/yzOfPKHqwjABw72FcaRMvuOex
	LM+8npnr2HOefyaePH4c815FgGjp3tEFqzIpepJHVIQ5Oj19m9cwPNjstBVEXjSbAm1n/rQLmpjjB
	6jApVuQ0dK1TRcR/y+h1m1YgStrK0HcHcfyjB3wNJi0Q1nhlTHBpEVwpl+/JetLhFFjdU9+q43YZT
	upTGe0bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZRJa-00000001qxm-3Kk3;
	Sat, 27 Dec 2025 10:14:26 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZRJP-00000001qxO-15uk
	for linux-nvme@lists.infradead.org;
	Sat, 27 Dec 2025 10:14:25 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso13868565e9.2
        for <linux-nvme@lists.infradead.org>; Sat, 27 Dec 2025 02:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766830453; x=1767435253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVngXyfV5VfUvnHB7imQkLJPUPEXpqDfOdOUdCSXF7M=;
        b=isJo3GqYGbdMjv9gaMw/kc6CS6bw6PkHRyiIUBZz0rHc0QCNEnW+zq5oydbelNsUxR
         9ZQHZd/5OaB4qZPZGg843TUDzctp/rHz5VD+kv4u+IZMLHQ1cQctscDtJ6Sh8O5qCkh1
         6RvhKLjiXytetJ/Pz3FQUJKEK9Mfw2KzWDod4nJImmX54S9h5fMHnC7Em/esNEXtSuPT
         VynOfuwBn8Pu1i8spaps3rwYyaEXjvmYOac34jjsIQLi87SL/lxsvzHCTqSnbDabfj6P
         VrUMKFx1bDF27EfZA7zI7FEgn1BqSfbqFolWa5s4tdfTQLccD7AJ2yV/iDHdh2nQAddh
         fKSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYmx5KRdrRfG3OIcyiaKnc+MI5zlOpFTpl2+Nvz14i2i4dij2mT/vwIn7mtHflklIUBm/yVm2pk3B5@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3PdZQVdp7hgOlSEV7fgC0zaUBHmhJ0J1xGD1tuDf6wGwqnZa5
	bhPyPL8A5z7hySV7dAm8w4XbxorGlMIQWAzm40/zeTMe8yo5FhsKUqkV
X-Gm-Gg: AY/fxX7winDbbqt6ZBFhNUQ1VYvYfnrJ7MUmc934SJH5V7N+m0eTakIAjomFzdTGn8Z
	9+ZAbycj2CrTcpYFIjGyEBfR5dasG9H3hbDahAv6qDSpwb5Ij0lQJbSFcziv8AyIyALO5ieAr7D
	KrfqG9vjjMC91bBimhTDUO+mwOHd1A8JzUAN2deldHGTSwnCrZP9yjUgrR8ooA9FXhDaulEtT78
	Dzjl6UUCDBkG9BAwz3/JmuYZS7mM90cH1TpmVNKI+ioQBDc2TdUk8/1BsvJxjc0Zg9AHBL1s/lP
	QSiJRspn76XHFZVSforlk0ddkLsuPVe82uqLnP0gFfKr9fDiksWOOrCYD6HENIiCAw3XjVdN/ke
	Hki+bwFqPyby6sIVHh1Y0I6k7eEGIXdVS9by8Movut9sFtzWbOaCG26sc1VF+gi2s2SuTmWJN/5
	OfQQTv29Co7XIzKB+2rHA86UmcNcgiffzNqyzRaVgMBwk=
X-Google-Smtp-Source: AGHT+IF31VXZ02ouV2pFs7wuJGjWl7+KmyqLynCQ8WaZ6amVtrTAsId+rcBj89A56zkgJ8KJLbFeUQ==
X-Received: by 2002:a05:600c:4f42:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-47d19556d02mr323782185e9.14.1766830453381;
        Sat, 27 Dec 2025 02:14:13 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193d5372sm454436375e9.14.2025.12.27.02.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 02:14:12 -0800 (PST)
Message-ID: <c698d201-0099-47a7-b5b0-d2322da63ea0@grimberg.me>
Date: Sat, 27 Dec 2025 12:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/14] nvme: Implement cross-controller reset recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, John Meneghini
 <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-9-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251126021250.2583630-9-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_021415_339985_1D47C966 
X-CRM114-Status: GOOD (  36.25  )
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



On 26/11/2025 4:11, Mohamed Khalfella wrote:
> A host that has more than one path connecting to an nvme subsystem
> typically has an nvme controller associated with every path. This is
> mostly applicable to nvmeof. If one path goes down, inflight IOs on that
> path should not be retried immediately on another path because this
> could lead to data corruption as described in TP4129. TP8028 defines
> cross-controller reset mechanism that can be used by host to terminate
> IOs on the failed path using one of the remaining healthy paths. Only
> after IOs are terminated, or long enough time passes as defined by
> TP4129, inflight IOs should be retried on another path. Implement core
> cross-controller reset shared logic to be used by the transports.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/constants.c |   1 +
>   drivers/nvme/host/core.c      | 133 ++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h      |  10 +++
>   3 files changed, 144 insertions(+)
>
> diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
> index dc90df9e13a2..f679efd5110e 100644
> --- a/drivers/nvme/host/constants.c
> +++ b/drivers/nvme/host/constants.c
> @@ -46,6 +46,7 @@ static const char * const nvme_admin_ops[] = {
>   	[nvme_admin_virtual_mgmt] = "Virtual Management",
>   	[nvme_admin_nvme_mi_send] = "NVMe Send MI",
>   	[nvme_admin_nvme_mi_recv] = "NVMe Receive MI",
> +	[nvme_admin_cross_ctrl_reset] = "Cross Controller Reset",
>   	[nvme_admin_dbbuf] = "Doorbell Buffer Config",
>   	[nvme_admin_format_nvm] = "Format NVM",
>   	[nvme_admin_security_send] = "Security Send",
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f5b84bc327d3..f38b70ca9cee 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -554,6 +554,138 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
>   
> +static struct nvme_ctrl *nvme_find_ccr_ctrl(struct nvme_ctrl *ictrl,
> +					    u32 min_cntlid)
> +{
> +	struct nvme_subsystem *subsys = ictrl->subsys;
> +	struct nvme_ctrl *sctrl;
> +	unsigned long flags;
> +
> +	mutex_lock(&nvme_subsystems_lock);

This looks like the wrong lock to take here?

> +	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
> +		if (sctrl->cntlid < min_cntlid)
> +			continue;

The use of min_cntlid is not clear to me.

> +
> +		if (atomic_dec_if_positive(&sctrl->ccr_limit) < 0)
> +			continue;
> +
> +		spin_lock_irqsave(&sctrl->lock, flags);
> +		if (sctrl->state != NVME_CTRL_LIVE) {
> +			spin_unlock_irqrestore(&sctrl->lock, flags);
> +			atomic_inc(&sctrl->ccr_limit);
> +			continue;
> +		}
> +
> +		/*
> +		 * We got a good candidate source controller that is locked and
> +		 * LIVE. However, no guarantee sctrl will not be deleted after
> +		 * sctrl->lock is released. Get a ref of both sctrl and admin_q
> +		 * so they do not disappear until we are done with them.
> +		 */
> +		WARN_ON_ONCE(!blk_get_queue(sctrl->admin_q));
> +		nvme_get_ctrl(sctrl);
> +		spin_unlock_irqrestore(&sctrl->lock, flags);
> +		goto found;
> +	}
> +	sctrl = NULL;
> +found:
> +	mutex_unlock(&nvme_subsystems_lock);
> +	return sctrl;
> +}
> +
> +static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
> +{
> +	unsigned long flags, tmo, remain;
> +	struct nvme_ccr_entry ccr = { };
> +	union nvme_result res = { 0 };
> +	struct nvme_command c = { };
> +	u32 result;
> +	int ret = 0;
> +
> +	init_completion(&ccr.complete);
> +	ccr.ictrl = ictrl;
> +
> +	spin_lock_irqsave(&sctrl->lock, flags);
> +	list_add_tail(&ccr.list, &sctrl->ccrs);
> +	spin_unlock_irqrestore(&sctrl->lock, flags);
> +
> +	c.ccr.opcode = nvme_admin_cross_ctrl_reset;
> +	c.ccr.ciu = ictrl->ciu;
> +	c.ccr.icid = cpu_to_le16(ictrl->cntlid);
> +	c.ccr.cirn = cpu_to_le64(ictrl->cirn);
> +	ret = __nvme_submit_sync_cmd(sctrl->admin_q, &c, &res,
> +				     NULL, 0, NVME_QID_ANY, 0);
> +	if (ret)
> +		goto out;
> +
> +	result = le32_to_cpu(res.u32);
> +	if (result & 0x01) /* Immediate Reset */
> +		goto out;
> +
> +	tmo = msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
> +	remain = wait_for_completion_timeout(&ccr.complete, tmo);
> +	if (!remain)

I think remain is redundant here.

> +		ret = -EAGAIN;
> +out:
> +	spin_lock_irqsave(&sctrl->lock, flags);
> +	list_del(&ccr.list);
> +	spin_unlock_irqrestore(&sctrl->lock, flags);
> +	return ccr.ccrs == 1 ? 0 : ret;

Why would you still return 0 and not EAGAIN? you expired on timeout but 
still
return success if you have ccrs=1? btw you have ccrs in the ccr struct 
and in the controller
as a list. Lets rename to distinguish the two.

> +}
> +
> +unsigned long nvme_recover_ctrl(struct nvme_ctrl *ictrl)
> +{

I'd call it nvme_fence_controller()

> +	unsigned long deadline, now, timeout;
> +	struct nvme_ctrl *sctrl;
> +	u32 min_cntlid = 0;
> +	int ret;
> +
> +	timeout = nvme_recovery_timeout_ms(ictrl);
> +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
> +
> +	now = jiffies;
> +	deadline = now + msecs_to_jiffies(timeout);
> +	while (time_before(now, deadline)) {
> +		sctrl = nvme_find_ccr_ctrl(ictrl, min_cntlid);
> +		if (!sctrl) {
> +			/* CCR failed, switch to time-based recovery */
> +			return deadline - now;

It is not clear what is the return code semantics of this function.
How about making it success/failure and have the caller choose what to do?

> +		}
> +
> +		ret = nvme_issue_wait_ccr(sctrl, ictrl);
> +		atomic_inc(&sctrl->ccr_limit);

inc after you wait for the ccr? shouldn't this be before?

> +
> +		if (!ret) {
> +			dev_info(ictrl->device, "CCR succeeded using %s\n",
> +				 dev_name(sctrl->device));
> +			blk_put_queue(sctrl->admin_q);
> +			nvme_put_ctrl(sctrl);
> +			return 0;
> +		}
> +
> +		/* Try another controller */
> +		min_cntlid = sctrl->cntlid + 1;

OK, I see why min_cntlid is used. That is very non-intuitive.

I'm wandering if it will be simpler to take one-shot at ccr and
if it fails fallback to crt. I mean, if the sctrl is alive, and it was 
unable
to reset the ictrl in time, how would another ctrl do a better job here?

> +		blk_put_queue(sctrl->admin_q);
> +		nvme_put_ctrl(sctrl);
> +		now = jiffies;
> +	}
> +
> +	dev_info(ictrl->device, "CCR reached timeout, call it done\n");
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvme_recover_ctrl);
> +
> +void nvme_end_ctrl_recovery(struct nvme_ctrl *ctrl)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ctrl->lock, flags);
> +	WRITE_ONCE(ctrl->state, NVME_CTRL_RESETTING);

This needs to be a proper state transition.

