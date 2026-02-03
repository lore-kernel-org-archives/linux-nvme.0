Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61206E8B362
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 21:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c11UbJd7HvCGv2K8Ygr2BKg3L56UdPQX0DIKZCeGei0=; b=sbI2p9rjJMdS74ftkt/xRvLDtO
	GRljUpSPrUOKcOyDQrtu8CWIBpP77SnSNjg8zVqM2RWU8RTUJgR+durRamYrL89ep5jVOihJEjHdK
	D0jyyNhSUosFb8sau0Ee/BipzudAzzFZWhW7RTYAe506MLZ8k+apG7z1t3O1FGMqDb8kHDAqwzr3y
	Uo0aDVH9poW+r1GJ9UAEZTFL4gnrXh34p2WbnyyALfYeWDtyO7X0+0BDz37AXQDXqmi7PI87JkNfR
	6p2RrWbscI5GTA327Lbq5DAt3+0QXBfdAR9FxC2q5oSEd47TKDasI4cMoVi/Ep0cwSsUjHuirQ549
	IvQR9QCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnNsd-00000007MyC-49lC;
	Tue, 03 Feb 2026 21:24:15 +0000
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnNsa-00000007Mxr-2dwH
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 21:24:14 +0000
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-124afd03fd1so9198822c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 13:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770153851; x=1770758651; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c11UbJd7HvCGv2K8Ygr2BKg3L56UdPQX0DIKZCeGei0=;
        b=SO1u9b/HgPjjgl+z9IgA8ncDIfy0whPxfUjdm0u2qu81nkjKsTbW0B9/Gvh03XFugT
         gJgWolS+vZ1BlQQYtC0RTDYbBYsKES9qQh/zGPeqRl2pFF933H0vRupSzEHW1qqNDQsa
         C2lseYGCW72Hd0hkI+YOcw1IURQ8jgACDrjQgp/hcgUdpDFIsUrV4lTAg6CW4MvYlwaL
         j66Ef2hCtZ7ahi5Sk5WOeUWSpebYIOYcowZ5nT5QmA92Upt2VVG/NtsDu2/iMjClZ4JD
         7zsFW75YkX0oNPRvf/PWmDgfhIcigJ7b8zPU205oPjCILLscj4L/3JPPB8XLhxw7+DiN
         rAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770153851; x=1770758651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c11UbJd7HvCGv2K8Ygr2BKg3L56UdPQX0DIKZCeGei0=;
        b=V35Y1FqtdNZNwCiFj9a51mfXkrEef6zHEOndyUVjkkhfj82aMBlRSEXy7UVLo+UiFh
         AITLuIQs/w821Ipf3EAgrLn7ZQjWSnNv82YY+th8YOc9BHGgjKEtUiGQIZfvUtDz9gbG
         GlSLwqhQWNqIcbDBZETRuhkN6GXHzrGqUl+9r2J/0vNHL7HeRKCmd1MlC1TDVO5K0wZb
         BCGKW7qXzwEtkZqNJhsEqfK0Qt8xP0FYv15nAUTII3fVkR8Cg1f2pcE/wv7Y9GUx3ki2
         a7tUpIW97zQoBpOTe3YB2WHVnueSccAOT9E9rmYiaWHHWwisu9uTxBXtBFL/8OLwik7d
         Rl2A==
X-Forwarded-Encrypted: i=1; AJvYcCVjFKsArC1/2rZgs4ViSw5Wo7yIkTTuKuvMITaxzSYf4TVN/LLT4wOOUVME6+9FASnoYid2U9GXmSgX@lists.infradead.org
X-Gm-Message-State: AOJu0YyTMSy97jzwqHgzOWWAMd2RnF+1+waQPzZYyh79si9eVKvqTdJ8
	8u2g0Z5cHFtS7c2HqUncgO/Xk40BT5zDhUjxoADuPKX2kksz7jrPfnJUXalsM3Y+ZH0=
X-Gm-Gg: AZuq6aKgN1cRuQD9KtrN3SvUHTyrvtZNA1WcnLv+3oIAM7ZC5SQDKV5wp00T7VcbbdQ
	tHVuaoRxy0l3sgjp28+6yncSTxBNSpZoOKSynBESHMjrqwQbPamJDjW4IM3lONxTl2Y8K7jQKIF
	8Ri3G5sLd33TVGIxpBBP4mGps736ScllxLpL3R/aM+8+w0JXYgaSHxT/haYHkhvkQjDFfPSaplm
	s5/Onnzt2/tbkOnDSMgaHFtfhu9P0IK9Mny6NW1UU7aefbBEM4UF2/TatUGUjZ6H6oQVWwyIvBQ
	/thStfjmYW0CFUlj+x54ZGLqwuKPWtbSKs6I/lXsO1OGqwrE1XmHCJe+T/92dcWZDCNoIoOGAlx
	Q4m+a6P1qvUpF1NcnxvLLtDf5//8sDFezlYNKbf3slv7XmxDipTZEFVRbc0ffOPOSBgO5V2zajS
	oNO9gyWkuyElYNE2MyJW6Uw9zeG0A/QJg=
X-Received: by 2002:a05:7022:207:b0:11b:c2fd:3960 with SMTP id a92af1059eb24-126f47cbed9mr276671c88.28.1770153851214;
        Tue, 03 Feb 2026 13:24:11 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-126f503087esm421549c88.12.2026.02.03.13.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 13:24:10 -0800 (PST)
Date: Tue, 3 Feb 2026 13:24:09 -0800
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
Subject: Re: [PATCH v2 10/14] nvme-tcp: Use CCR to recover controller that
 hits an error
Message-ID: <20260203212409.GG3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-11-mkhalfella@purestorage.com>
 <48a05027-9ca2-4e84-a7ac-946391ed1e26@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48a05027-9ca2-4e84-a7ac-946391ed1e26@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_132412_830841_072CA959 
X-CRM114-Status: GOOD (  42.86  )
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

On Tue 2026-02-03 06:34:51 +0100, Hannes Reinecke wrote:
> On 1/30/26 23:34, Mohamed Khalfella wrote:
> > An alive nvme controller that hits an error now will move to FENCING
> > state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> > terminate inflight IOs. If CCR succeeds, switch to FENCED -> RESETTING
> > and continue error recovery as usual. If CCR fails, the behavior depends
> > on whether the subsystem supports CQT or not. If CQT is not supported
> > then reset the controller immediately as if CCR succeeded in order to
> > maintain the current behavior. If CQT is supported switch to time-based
> > recovery. Schedule ctrl->fenced_work resets the controller when time
> > based recovery finishes.
> > 
> > Either ctrl->err_work or ctrl->reset_work can run after a controller is
> > fenced. Flush fencing work when either work run.
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/host/tcp.c | 62 ++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 61 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 69cb04406b47..af8d3b36a4bb 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -193,6 +193,8 @@ struct nvme_tcp_ctrl {
> >   	struct sockaddr_storage src_addr;
> >   	struct nvme_ctrl	ctrl;
> >   
> > +	struct work_struct	fencing_work;
> > +	struct delayed_work	fenced_work;
> >   	struct work_struct	err_work;
> >   	struct delayed_work	connect_work;
> >   	struct nvme_tcp_request async_req;
> > @@ -611,6 +613,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
> >   
> >   static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> >   {
> > +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCING)) {
> > +		dev_warn(ctrl->device, "starting controller fencing\n");
> > +		queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->fencing_work);
> > +		return;
> > +	}
> > +
> 
> Don't you need to flush any outstanding 'fenced_work' queue items here
> before calling 'queue_work()'?

I do not think we need to flush ctr->fencing_work. It can not be running
at this time.

> 
> >   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> >   		return;
> >   
> > @@ -2470,12 +2478,59 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
> >   	nvme_tcp_reconnect_or_remove(ctrl, ret);
> >   }
> >   
> > +static void nvme_tcp_fenced_work(struct work_struct *work)
> > +{
> > +	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
> > +					struct nvme_tcp_ctrl, fenced_work);
> > +	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> > +
> > +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> > +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> > +		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
> > +}
> > +
> > +static void nvme_tcp_fencing_work(struct work_struct *work)
> > +{
> > +	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> > +			struct nvme_tcp_ctrl, fencing_work);
> > +	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> > +	unsigned long rem;
> > +
> > +	rem = nvme_fence_ctrl(ctrl);
> > +	if (!rem)
> > +		goto done;
> > +
> > +	if (!ctrl->cqt) {
> > +		dev_info(ctrl->device,
> > +			 "CCR failed, CQT not supported, skip time-based recovery\n");
> > +		goto done;
> > +	}
> > +
> 
> As mentioned, cqt handling should be part of another patchset.

Let us suppose we drop cqt from this patchset

- How will we be able to calculate CCR time budget?
  Currently it is calculated by nvme_fence_timeout_ms()

- What should we do if CCR fails? Retry requests immediately?

> > +	dev_info(ctrl->device,
> > +		 "CCR failed, switch to time-based recovery, timeout = %ums\n",
> > +		 jiffies_to_msecs(rem));
> > +	queue_delayed_work(nvme_wq, &tcp_ctrl->fenced_work, rem);
> > +	return;
> > +
> 
> Why do you need the 'fenced' workqueue at all? All it does is queing yet 
> another workqueue item, which certainly can be done from the 'fencing' 
> workqueue directly, no?

It is possible to drop ctr->fenced_work and requeue ctrl->fencing_work
as delayed work to implement request hold time. If we do that then we
need to modify nvme_tcp_fencing_work() to tell if it is being called for
'fencing' or 'fenced'. The first version of this patch used a controller
flag RECOVERED for that and it has been suggested to use a separate work
to simplify the logic and drop the controller flag.

> 
> > +done:
> > +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> > +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> > +		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
> > +}
> > +
> > +static void nvme_tcp_flush_fencing_work(struct nvme_ctrl *ctrl)
> > +{
> > +	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
> > +	flush_delayed_work(&to_tcp_ctrl(ctrl)->fenced_work);
> > +}
> > +
> >   static void nvme_tcp_error_recovery_work(struct work_struct *work)
> >   {
> >   	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> >   				struct nvme_tcp_ctrl, err_work);
> >   	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> >   
> > +	nvme_tcp_flush_fencing_work(ctrl);
> 
> Why not 'fenced_work' ?

You mean rename nvme_tcp_flush_fencing_work() to
nvme_tcp_flush_fenced_work()?

If yes, then I can do that if you think it makes more sense.

> 
> >   	if (nvme_tcp_key_revoke_needed(ctrl))
> >   		nvme_auth_revoke_tls_key(ctrl);
> >   	nvme_stop_keep_alive(ctrl);
> > @@ -2518,6 +2573,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
> >   		container_of(work, struct nvme_ctrl, reset_work);
> >   	int ret;
> >   
> > +	nvme_tcp_flush_fencing_work(ctrl);
> 
> Same.
> 
> >   	if (nvme_tcp_key_revoke_needed(ctrl))
> >   		nvme_auth_revoke_tls_key(ctrl);
> >   	nvme_stop_ctrl(ctrl);
> > @@ -2643,13 +2699,15 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
> >   	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
> >   	struct nvme_command *cmd = &pdu->cmd;
> >   	int qid = nvme_tcp_queue_id(req->queue);
> > +	enum nvme_ctrl_state state;
> >   
> >   	dev_warn(ctrl->device,
> >   		 "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeout\n",
> >   		 rq->tag, nvme_cid(rq), pdu->hdr.type, cmd->common.opcode,
> >   		 nvme_fabrics_opcode_str(qid, cmd), qid);
> >   
> > -	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
> > +	state = nvme_ctrl_state(ctrl);
> > +	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
> 
> 'FENCED' too, presumably?

I do not think it makes a difference here. FENCED and RESETTING are
almost the same states.

> 
> >   		/*
> >   		 * If we are resetting, connecting or deleting we should
> >   		 * complete immediately because we may block controller
> > @@ -2904,6 +2962,8 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
> >   
> >   	INIT_DELAYED_WORK(&ctrl->connect_work,
> >   			nvme_tcp_reconnect_ctrl_work);
> > +	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_tcp_fenced_work);
> > +	INIT_WORK(&ctrl->fencing_work, nvme_tcp_fencing_work);
> >   	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
> >   	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
> >   
> 
> Here you are calling CCR whenever error recovery is triggered.
> This will cause CCR to be send from a command timeout, which is
> technically wrong (CCR should be send when the KATO timeout expires,
> not when a command timout expires). Both could be vastly different.

KATO is driven by the host. What does KTO expires mean?
I think KATO expiry is more applicable to target, no?

KATO timeout is a signal of an error that target is not reachable or
something is wrong with the target?

> 
> So I'd prefer to have CCR send whenever KATO timeout triggers, and
> lease to current command timeout mechanism in place.

Assuming we used CCR only when KATO request times out.
What should we do when we hit other errors?

should nvme_tcp_error_recovery() is called from many places to handle
errors and it effectively resets the controller. What should this
function do if not trigger CCR?

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

