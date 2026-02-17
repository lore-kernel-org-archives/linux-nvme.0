Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B603FE9A031
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 18:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ar3sJnUhQqfIA6ag4F/NsoNaK28/BEdZL0lU+k7vNas=; b=lN8Qa0XWwsiQlkYPS/9o60W4R8
	NKm72EdjEgL/DFffKGeep//YoPLc+caOOKSpacqgqVwIY6wRRMs2y0hriMuMsQxjqy2h/nexXHu+W
	mn2K0pVFRrIajuGxvh6TQE407treDu+EUz63xTuN1Rra8Lk+36wu1T/Vm76EeV+28Yv4yUBhtqQHb
	0svbE6ltIubBGjWTvJ6whbtxAwpv4788T+/tRqAb8zjC7M6Tx1fFNYh5m5P0GyiHOMNYGI8awf+/e
	7+jF6PiSDmD8cHVpfC4NykWyd+GzuqV/o0bPqtcrLHLZxbxtkYvkww+tH+VBfJwWAt8hX8llNI8tA
	AOX5HVLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsPvV-00000008jGl-1dsL;
	Tue, 17 Feb 2026 18:36:03 +0000
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsPvS-00000008jFw-0tbS
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 18:35:59 +0000
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-124899ee9d3so86457c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Feb 2026 10:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771353357; x=1771958157; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ar3sJnUhQqfIA6ag4F/NsoNaK28/BEdZL0lU+k7vNas=;
        b=SpiXBcdlMiHnYnonXyNzMlw4yCj2WyxGll+ujBDDA15id4tyTQjWocfxFT0FkZWOaL
         lcl1O5uAaPOVq5FBXlQHdqyTWL5Se+ffnT2bTHbN4dTHkLXvbQonuKPaQMvvSFJNXUxD
         WzvhmxfF+tlavDJlneoLY5BNURR8wwRmOo22JZ7GWiPxx51UZjjkcRPv9mJtwImbdcYQ
         DkHd5go+/Ena+G8KCZBnEa2Rz2K69Lzb5AlHhAYGZP3rBbdhzFhb1Oppm2CxPzaTRXZi
         lAURTCBlLSXD6vPgsjDLNJ2VAg47v+sBX1eRekXuCxEocEzN5yK3EqJN3GTtZxGNkimk
         D5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771353357; x=1771958157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ar3sJnUhQqfIA6ag4F/NsoNaK28/BEdZL0lU+k7vNas=;
        b=l2RugSEkwfuJuW6GPG/pBrgdpX9ktwH+1kp2d3bHXXgh/0cR9yVNoRYIx7f+IhkeK+
         +dMhH8CmXWNg6lHVszw8o8Ie39VoPt5Oe1d6UbPXFykEeqaDLNgXrhdshcz1rxwNBVwp
         OoqL16pnw+fsQiOBA908PIlb8Zt8GQy9MmfzFX6ZScjo5LtFoL3Q65E6u32TVOqF6TEb
         lMUxA9ABz18a+pKAVLYfKsFYqOzNhhgmWSLJ3EKNDZ4zuQaJabGF9mfZD+dTCyJRda20
         QZOxQR6Ypzgrz3W5V8dVRyR1bTmJhclTlOz55MHhqAWWYqT1wno+lkkQKiSSeZP5IEwd
         Z25Q==
X-Forwarded-Encrypted: i=1; AJvYcCW08Sxz2+lM4YxVl5J0ZzVlaDKIvL8svDN1o8aG1y0cqyDD8of4cVd01sJLo3prq5JrG8tl5wlNhvuE@lists.infradead.org
X-Gm-Message-State: AOJu0Yz3NXDaYSie0prdM0qpnfTdHga1jRWy/1RqsM50cfgs3lWJ5+dh
	5kMDjcWLIFXjb8ki3h+f9U7sSxu2HaDH0EZNZG4rW4WEW9yqS2i0WDwz7jI7jDpmIDw=
X-Gm-Gg: AZuq6aKpBpUv+wSxOo10ETCOKbEF4Eii1OjVIrvEhZ1CwsPEh+IsRXIXlF4J+gir3uI
	Ufvj++E7KQ90R9m2PF/HpW85e1HN+N8pbe6IfQt783JixDcGEi46Bu2y9CAm8dB/viYJ3ssOoeI
	0nhCmjZyrBC0Jt9qY2S23kMxO3qduZBcJruWDxlEcwaTigk0kQpcDJ5HdQgpjjgh8GBj5sApjHI
	/MI9RB8h4e9uOX8ivEmH87QTJ3DJaPhmoK0cneS9InTu8+5A9IHw+jth/EaGkN6IIU8+wsGAsdG
	piKmabm5UJYb0JYXQZUIJxnsX+w1unozeI5bYtphT78S+XZkiW8Gxqc5WZ4bCKUa7oTgbqRsD42
	3Q41wFWdDxqxWugCDAveDWYszvjePWevQJ5k9tz3qHUP55+lap3iHnrBwW8YiHfEjf6EskRWKok
	rCTg03pJIfwYIIZzx/KIqocENpsaYI89ZVkuo8RGdrWVU=
X-Received: by 2002:a05:7022:40f:b0:123:36f3:2d2f with SMTP id a92af1059eb24-1274103e7fdmr6005295c88.26.1771353356746;
        Tue, 17 Feb 2026 10:35:56 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-12742cbc900sm17558009c88.14.2026.02.17.10.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:35:56 -0800 (PST)
Date: Tue, 17 Feb 2026 10:35:55 -0800
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
Subject: Re: [PATCH v3 08/21] nvme: Implement cross-controller reset recovery
Message-ID: <20260217183555.GF3435530-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-9-mkhalfella@purestorage.com>
 <c5ee3fd5-2bbe-44e0-ae1b-ed77d7d87029@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ee3fd5-2bbe-44e0-ae1b-ed77d7d87029@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_103558_260999_FB533E86 
X-CRM114-Status: GOOD (  34.70  )
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

On Mon 2026-02-16 13:41:39 +0100, Hannes Reinecke wrote:
> On 2/14/26 05:25, Mohamed Khalfella wrote:
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
> >   drivers/nvme/host/core.c      | 141 ++++++++++++++++++++++++++++++++++
> >   drivers/nvme/host/nvme.h      |   9 +++
> >   3 files changed, 151 insertions(+)
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
> > index 231d402e9bfb..765b1524b3ed 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -554,6 +554,146 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
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
> > +static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
> > +{
> > +	struct nvme_ccr_entry ccr = { };
> > +	union nvme_result res = { 0 };
> > +	struct nvme_command c = { };
> > +	unsigned long flags, tmo;
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
> > +	tmo = secs_to_jiffies(ictrl->kato);
> > +	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> > +		ret = -ETIMEDOUT;
> > +		goto out;
> > +	}
> > +
> That will be tricky. The 'ccr' comand will be sent with the default
> command queue timeout which is decoupled from KATO.
> So you really should set the command timeout for the 'ccr' command
> to ctrl->kato to ensure it'll be terminated correctly.
> 

Agreed. The timeout for CCR request should be ctr->kato just like what
we do for keep alive request. The easiest way IMO to do is is to extend
__nvme_submit_sync_cmd() to take request timeout. I do not want to make
this change in this patchset.

Is it okay I make this change after this patchset gets merged?

