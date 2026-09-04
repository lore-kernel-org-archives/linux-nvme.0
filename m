Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264CCC624D3
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2026 23:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DWqZGlZlOXVkVFEw7jqJALzgTnRow1syDq0/rhbvtyU=; b=GSq0C8p5idxJyO8wSxOhGj3jX4
	2sLlxAGwhj/tny6yI/DYdxXMvSEW4OjaNFAb/RiQhwqGvJUBQDxjbemgzjkf4qSYvNOlReW2o5zZK
	v2c8SU/2QPx5D54Pxe333zeuMvUVV1wVqcM1lOdW3fzFBPcHUeCIu97Ou7MmB3UxzTR9TjNVnFhRB
	QiR8tlyEZL/Z3eXLPuNz6ecUP3hw+SCu3MHctYcVIqMwJWZt87umWjR7Q0uQyUAhTHxTGRQV5Mje6
	/GO46ZNNtDUmh4goGh8UxGCmDW/Hjf0Yp4sk423lOguOcOvEU3VBp4h/tSkY/wajhAb+ZimE3U8W6
	XvetbwSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2cuK-00000003Ryu-1tgJ;
	Fri, 04 Sep 2026 23:01:16 +0000
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2cuI-00000003RyU-1Jax
	for linux-nvme@lists.infradead.org;
	Fri, 04 Sep 2026 23:01:15 +0000
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-6b1b1cb72d0so873847eaf.1
        for <linux-nvme@lists.infradead.org>; Fri, 04 Sep 2026 16:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788562873; x=1789167673; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DWqZGlZlOXVkVFEw7jqJALzgTnRow1syDq0/rhbvtyU=;
        b=EfZltwHfIqAQWwG5glchIZY5jT36Dn8ORebAUSLMOZknIulVmeQGUdwAh7CMIusZmk
         7raGv88FtN/ZNCx9bzAeA6/wcR9XNQcsL6sBmNn5KWGoB6YbEVQdzD8X3XfntU4HN+/k
         r6tVl9JNGw8edevxoysm6EfH1x9ZtCV+opOPFFIGHh+BcIkXUXIK9p5V93dLAhDApLeV
         6I8JlNYJS1s54mw5aKVIuJ6NSqppqDewQbVd/xei+uhD9mh5tajrLB04VSwyd68i07Ae
         N3HXe5jWvhx1N/IuoAkXunlamo4eDUWQY1hzhNwyP9qqZEKD4GGlKCOF4PICjMXabp0t
         fWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788562873; x=1789167673;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DWqZGlZlOXVkVFEw7jqJALzgTnRow1syDq0/rhbvtyU=;
        b=PM/w0Rm1e58s4m8rTfu2Rm7RUwsM77pnAbaRyfdgBomb7dXbaCiLCDINAYZgxQhSRw
         y+/gfdfcZEMGnMavrh2tGzK0zv2GOeGj0uBiaHMB8RgkwVXqaeGwaEKMHAuoMVwYC2/3
         y9xXZ+rM2yAdzgMgOAIruSb2vHOfDRKB84rNtbLUPKSNHUchZKr0V1D34gu2OFkyhFPv
         XzN9rkSaSSPgS43ZvjWkMZOvdFUDnrvlVQGAaDDQBFaqeBvHEV/4sjrzt5qZxHBmPIL/
         jG3ccP18bBEBPhApjQXsnpfQruHH06pgAYAyeNGOjz1nLpPQc7lgeHyj7l05wsvIM/py
         6opQ==
X-Forwarded-Encrypted: i=1; AKwUvBzq9DR22nj1A2klGJH6lBRPz0FCNLQuFD2rqYPzBUJAAqYm6HJXZ44aWh3aWYcNQwQ5OoUZMjAbhAoD@lists.infradead.org
X-Gm-Message-State: AFuF++lRqRhhuULdnTXxHcASTq/GYF2ivuH9wOo0O6Uuvw0h1qkCvexr
	ShYwOGvL2lCBzNs6UBqlsAGPRdtwXcvQKK0KBkTjzkTwl0ql8JRDzP2ElMUqqLtS4LM=
X-Gm-Gg: AYBFou1F+ZPDHT+uvLsK0yqgk1bmXFTPsrfe4Qx7qYmKv7K/1n4dKKLYXVfNA+LCmtp
	RzKhwu6GWGeEdmmakkSxuRym60mDHyayofrXq8vAWu4V1cFLhyNpGTIYyDnw2WOLbo4PtChsObl
	qUWNMTEAEvn0BrW106xr/pSIakhR98bZZAhImk/yk0Rcz3nFBF5KfvkImtpkiusZGz61+DwdGKI
	4K6A5z9y7jEdwMCynIEQ2fTzidlKTBLhwaqntVKyCgSNN5dJo/I8tEfRetkuEBFKojHaZVQ2X2X
	4PjpQnifcr/8njuZjv7D9VIX4ZxYLxUNK1+BYUIIPdPspXQQU9X2jdhzODghPaUEIleaN+053LS
	XmvDyAbEnNncZmilQOsjiY8PMqmkI6JE6jzPACx0pZMXyrcCY7uxSdsKunu7wrLXa9ULniBfkdA
	g8AWjsiPoYUXMJMrSbL/fEiPi+IWZv5tBihXkP9100Y4hsJnPiI2W0xFucESrpICddDNM=
X-Received: by 2002:a05:6820:810a:b0:6b7:46e9:96ff with SMTP id 006d021491bc7-6b746e9a376mr4834977eaf.47.1788562872859;
        Fri, 04 Sep 2026 16:01:12 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2607:fb90:9c20:7a99::791d])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3339bbf1feesm9376783eec.26.2026.09.04.16.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 16:01:11 -0700 (PDT)
Date: Fri, 4 Sep 2026 16:01:10 -0700
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
Subject: Re: [PATCH v5 10/16] nvme-tcp: Use CCR to recover controller that
 hits an error
Message-ID: <20260904230110.GC5552-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-11-mkhalfella@purestorage.com>
 <f27fdc8d-9aea-42d1-8f55-04d8355a50c4@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f27fdc8d-9aea-42d1-8f55-04d8355a50c4@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_160114_371942_39D52FD3 
X-CRM114-Status: GOOD (  31.35  )
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

On Mon 2026-07-13 09:17:33 +0200, Hannes Reinecke wrote:
> On 7/12/26 4:23 AM, Mohamed Khalfella wrote:
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
> 
> This needs to be before nvme_fence_ctrl(). Otherwise the state is 
> meaningless are we're moving to RESETTING directly afterwards.

The transition to FENCED signals that we are done with the fencing
process. Only then FENCED -> RESETTING can happen. Yes, we are switching
directly to RESETTING after that because we want to run error recovery
to teardown and bring the controller back.

The only reason FENCED exist is to prevent a controller in FENCING state
from being reset or deleted.
> 
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
> Not so happy with this one here.
> _If_ fencing is still running we really should not be entering here.
> And If fencing is not running we won't need to call it.
> I'd prefer some sort of WARN_ON() here if fencing is still running.

fencing_work should not be running. It should be exiting after it queued
err_work. However, it does that asynchronously. It means it could still
be running. flush_work() just makes sure it is 100% done because we are
not expecting it in the middle doing any useful work at this time.

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
> Same here.

This is needed in case nvme_tcp_fencing_work() loses the race as. Now
reset_work needs to flush fencing_work because it took over instead of
err_work.

> 
> >   	if (nvme_tcp_key_revoke_needed(ctrl))
> >   		nvme_auth_revoke_tls_key(ctrl);
> >   	nvme_stop_ctrl(ctrl);
> > @@ -2667,13 +2692,15 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
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
> >   		/*
> >   		 * If we are resetting, connecting or deleting we should
> >   		 * complete immediately because we may block controller
> > @@ -2928,6 +2955,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
> >   
> >   	INIT_DELAYED_WORK(&ctrl->connect_work,
> >   			nvme_tcp_reconnect_ctrl_work);
> > +	INIT_WORK(&ctrl->fencing_work, nvme_tcp_fencing_work);
> >   	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
> >   	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
> >   
> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

