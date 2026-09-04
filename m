Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8416C624D3
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2026 22:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9yzepECPMNjg/OdUAVeUwMwVkBXuiCtJbev3HxuW5js=; b=FejoITE8c4d83eHS8ehS97OD6y
	MO26ksUxAEatSnt7vWcLZWBK21O7cJDbPPREtuEsXYP3EpKAEwWrCptwj4JB/OliXi4oXoBTnzEHE
	hFpxqlvQoXrG740Pg8TKT3BNhaPMEhc9K4hEikvl5VfIQX+L0m+ZdQnkNRjM362y9giLp8fJgwe7h
	bUjTCEfhskT+0cRKiftY3lnY8CtlRpExxmw7XGKWQDSgvQilZcUfWlbOG1t6ET3YcQyBa4Q4dWXfE
	1GxtywXUnxUfX0YgmKoweX19+4j9cqOEXTXydXGPYoK0+MzbD7fcSaHovi4rpoCJWRLoACqmlUhOg
	q46K/Jrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2cm2-00000003RHq-1Nvm;
	Fri, 04 Sep 2026 22:52:42 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2clz-00000003RHT-3AY7
	for linux-nvme@lists.infradead.org;
	Fri, 04 Sep 2026 22:52:40 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-cc149372c14so858846a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 04 Sep 2026 15:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788562359; x=1789167159; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9yzepECPMNjg/OdUAVeUwMwVkBXuiCtJbev3HxuW5js=;
        b=Np8qpWrPSKFhMeVx2kUdrKjSZ8ycGww49/cTloqux+UMgeVVp7CdMDjvGcPrCjZLEC
         X5I6sUTLqWl0o2MJhsLmMgiahUXnMkgb7SK7s+NV5MSvIx3XfygBDa63IB1YqK1mkqlo
         jVgGR2rrs74T4Uh21RpU+F7hROHFT9DNp0+kCXbJF2K5aX+lL80mhWemGm6nuwYCDkUD
         2iknJOia9Tj5GTRZzcZkLwx+23tbA5Zy51fxJgnhuJG694JHhlc+jznOxyoIPXgDTu4V
         8GGTHwxsaDTn3rpyFDCSknR4Dr2Gqw6xw1E6MzTZI1bwuIfc27s+ZYidKPUOkg7sbm2I
         fvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788562359; x=1789167159;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9yzepECPMNjg/OdUAVeUwMwVkBXuiCtJbev3HxuW5js=;
        b=ayJZD4X+sp0QuTquSAswP+fh0Q+dQkt4UuPNCx/Q6s3cALhVEqERJ+TcBl7Z8OsTz7
         d9rphqcPDou8XqmxOpU0m1OzerjdS3njMRrzr3ZR3A2GDXKLoptaMPRPB0qBXLYnYSRY
         2tMoHI0DCZ+GsN4IZXHNPEC9hryOknkLADD2JyPGRG/atTz65aWsFGuZG0oNXe85eJiL
         vqebGQG0wU9+ZZmP7mTov6Cdu7xmAnIRMxUjP2olERoiQ+sLDqgW5LPqI6pFqQtAmEmQ
         VgdxQhP9pYiusvoKGm22XAGLO4WvJ9D4CGivYZ9qjfBW0OQszlSdgP+KqPYi/31FO1Mn
         m2Eg==
X-Forwarded-Encrypted: i=1; AKwUvByh6R1+wJz94Rpq74z4fP2ZE/OFN9Wt0NQ+Kivk2q+n+VbtiQyv7YjjD1ViBcMqHVD4a5m95dXn180I@lists.infradead.org
X-Gm-Message-State: AFuF++kibg9oD7HYlL//n/FEtUcUBOe8UY9v+xce5cXAgMxraY2BItOQ
	ZI/hDazBrHe33f63W+vUgllzN45zZzZmWMLp9TvlkDsyTMBZ2rNN9eAffoFoGeN1qO0=
X-Gm-Gg: AYBFou1mSFy+N+BxTrLN/saVjWsEmSr36thNQjIuWTe4nVSHweLBhTkpTq7kfWowaCm
	mXOAWWZrClsjUIckIS9laLGlP/6OFCL8FrNHMmgWGYjS7urPNimKfae8KfuDsPfR0i4wKHZ2ILh
	x4u4JLm1vBm/Fqj2gRbsbWlerTHrDHOPWuXW5NqyKE5Bef7BG3a+edKeElMIB9WKoRmJQNugRPf
	lNGMxnQ78S0Q/mD4nvwK1vYP0VzlcZaQUtrUx68P8Uc1C8YP2fao0qzbDMOUQ5ntwtS5IuKtGXe
	g+luBk7Sk4CDJ/oeKQ0NsgbE6e/PjD4hxvkoqdklxJvl/1EezPCktFhG56tSilOkdUnqHw+XAIn
	hxStWZn/lmcYDBwZB1B8HuT8yr5I50pjnuvRQ0+RXCa/XcEAMfa30gMZ6eGpUsjn4cvNXPWEhvB
	PzQS0rSNpliheoKAEKfXDVzjAbVEThO7OmY/3J+Eea3SpO5XlORNZ7uHZRZqMClwm3aGo=
X-Received: by 2002:a05:6a20:7f8c:b0:3bf:6d96:ac40 with SMTP id adf61e73a8af0-3da39e44fdemr12661784637.12.1788562358777;
        Fri, 04 Sep 2026 15:52:38 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2607:fb90:9c20:7a99::791d])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm14641633eec.15.2026.09.04.15.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:52:38 -0700 (PDT)
Date: Fri, 4 Sep 2026 15:52:36 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/16] nvme-tcp: Use CCR to recover controller that
 hits an error
Message-ID: <20260904225236.GB5552-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-11-mkhalfella@purestorage.com>
 <3bc07e43-750d-4e8d-a209-e1d45acbb230@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bc07e43-750d-4e8d-a209-e1d45acbb230@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_155239_802139_2C1E9696 
X-CRM114-Status: GOOD (  25.65  )
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

On Sun 2026-08-23 04:03:18 +0300, Sagi Grimberg wrote:
> 
> 
> On 12/07/2026 5:23, Mohamed Khalfella wrote:
> > An alive nvme controller that hits an error now will move to FENCING
> > state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> > terminate inflight IOs. Regardless of the success or failure of CCR
> > operation the controller is transitioned to RESETTING state to continue
> > error recovery process.
> >
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/host/tcp.c | 30 +++++++++++++++++++++++++++++-
> >   1 file changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index ba5c7b3e2a7c..a1711dd1d3c2 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -161,6 +161,7 @@ struct nvme_tcp_ctrl {
> >   	struct sockaddr_storage src_addr;
> >   	struct nvme_ctrl	ctrl;
> >   
> > +	struct work_struct	fencing_work;
> >   	struct work_struct	err_work;
> >   	struct delayed_work	connect_work;
> >   	struct nvme_tcp_request async_req;
> > @@ -605,6 +606,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
> >   
> >   static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> >   {
> > +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCING)) {
> > +		dev_warn(ctrl->device, "starting controller fencing\n");
> > +		queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->fencing_work);
> > +		return;
> > +	}
> > +
> >   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> >   		return;
> >   
> > @@ -2494,12 +2501,29 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
> >   	nvme_tcp_reconnect_or_remove(ctrl, ret);
> >   }
> >   
> > +static void nvme_tcp_fencing_work(struct work_struct *work)
> > +{
> > +	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> > +			struct nvme_tcp_ctrl, fencing_work);
> > +	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> > +	unsigned long rem;
> > +
> > +	rem = nvme_fence_ctrl(ctrl);
> > +	if (rem)
> > +		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
> > +
> > +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> > +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> > +		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
> > +}
> > +
> >   static void nvme_tcp_error_recovery_work(struct work_struct *work)
> >   {
> >   	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> >   				struct nvme_tcp_ctrl, err_work);
> >   	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> >   
> > +	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
> 
> Agree we shouldn't be here with fencing work running.

Right, nvme_tcp_fencing_work() above queus tcp_ctrl->err_work. This
flush makes aure that fencing is 100% done before we proceed with
resetting.

> 
> >   	if (nvme_tcp_key_revoke_needed(ctrl))
> >   		nvme_auth_revoke_tls_key(ctrl);
> >   	nvme_stop_keep_alive(ctrl);
> > @@ -2542,6 +2566,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
> >   		container_of(work, struct nvme_ctrl, reset_work);
> >   	int ret;
> >   
> > +	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
> 
> Isn't it being called in nvme_stop_ctrl? - perhaps it should be called 
> in ->stop_ctrl() callback.
> 
> Other than that, this looks reasonable to me.

This flush_work() is needed in case nvme_tcp_fencing_work() loses the
race of transitioning the controller from FENCED to RESETTING. The
moment we move to FENCED anything can reset the controller. For example,
userspace can do that. If we lose the race then tcp_ctrl->err_work will
not be queued. That means reset work needs to flush fencing_work.

