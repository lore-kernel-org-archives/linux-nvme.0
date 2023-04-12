Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70927C7619A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 15:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eMr2XGACXlrLS3k5c24kseDiCIsfI0ars2r0sDgLfPI=; b=DsoAt3eHcN2QiR5jBO/rRnCi1H
	e+j5gCMv3fQdSPgOeeLm0eg/2uP2g3aVIeI37qePxmgq8wnmF4x/ReujNjYmQENaCC1NpBX5wxmz+
	D90rWVXAZA1Gw7Iqc/T6YBuAzThEfbfuXRIqxSURHzn9OLcJLqnDZgs0lwpRJE0wbfUdGN7Vn+40A
	UFj8+iaRfvEkjjn/yX7UTMrPA4yiEmFOyhDrNHkjvuvMSueJu3s0b6cLgNz+kR5uuJpmsFBWYGAWn
	UQknIklmuOjWEJWthlnGmtKAlTV5YKDcoA79+gDPezI4oalqlGqk9zQeD0OFcvgxvbvRiqWGwLmAP
	Qgi9J5vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmcr6-003j9n-2Z;
	Wed, 12 Apr 2023 15:57:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmcr3-003j9F-2d
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 15:57:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681315072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMr2XGACXlrLS3k5c24kseDiCIsfI0ars2r0sDgLfPI=;
	b=PBJ6nOPsGx3RWnNm8C9esU+B0Tg1GToC2kY1xqJHKda0iRPwqQpBKpVVU8NfLr2GLdkg+n
	3n2oNzrSnfKBRm+P/jx+FuZ0pIY3dmzPkthW9qr/weFdwAlzZ1dGvd3wognWwT3Q+QeDM1
	YxeHfzeS9tAUjRBg2xyw9YsecGBUA+Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-Rkb2WjSJMOqG50yqglo_zw-1; Wed, 12 Apr 2023 11:56:02 -0400
X-MC-Unique: Rkb2WjSJMOqG50yqglo_zw-1
Received: by mail-wm1-f72.google.com with SMTP id gw11-20020a05600c850b00b003ee8db23ef9so7021478wmb.8
        for <linux-nvme@lists.infradead.org>; Wed, 12 Apr 2023 08:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681314962; x=1683906962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMr2XGACXlrLS3k5c24kseDiCIsfI0ars2r0sDgLfPI=;
        b=ad/I7A73lep/Wx6fskVZvJ0mg8aI0Vs5S4oFytsjevWHwNNXF4zC1D+8lUH/sToSLa
         IXZJ5vYpVKZdt+2N0XNEzpHXPxt5VewVaVh9MEn+PbV8MutyVZ7Z6pZJMH5wc+5BSAIM
         iAC1A53hHBMv7Ooi/P74iRT4KHHBobYPotNLBOFX52w7qOXs9AfBYdKSNvW7S8i5zusQ
         apmxFeTAhVPcXrM6nuT8kfv40ONph/duBVvoIUVMh84fpMXZg/bjUKthyrKTR/thzJq+
         4YbwcXFB5N/iD88MQFN8am2uV4GZqHmc8FkiFqXkojY4MRJmy/Hi7IuJMEaSfHV/LEiC
         78Qw==
X-Gm-Message-State: AAQBX9dGQsXS1uTTZO34c7Hgro1TuQyk2/4rXtyClB7eSZyp9vth6qJ2
	sUVuFXm6UoWGdqDCYiK8a7sD2gMeSfQNFnwfaxalNAr8ugm2uQrikzCGPoOs6f5Bj5RB62WiMOR
	X/Rn8l3aO83ZYdTfprD3mb+OVqlqfN7m89sw1VDMTNKQ=
X-Received: by 2002:adf:fe83:0:b0:2e8:b9bb:f96c with SMTP id l3-20020adffe83000000b002e8b9bbf96cmr724974wrr.0.1681314961872;
        Wed, 12 Apr 2023 08:56:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZL+84pQj/rQbV34AwC1POyuqChsSLpR61XfVN7YKNGFyeJNhTJUuM6QfqrT8OfGKFqrxi+kHzoH8slRXNrZnc=
X-Received: by 2002:adf:fe83:0:b0:2e8:b9bb:f96c with SMTP id
 l3-20020adffe83000000b002e8b9bbf96cmr724972wrr.0.1681314961473; Wed, 12 Apr
 2023 08:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230412084904.162324-1-ming.lei@redhat.com>
In-Reply-To: <20230412084904.162324-1-ming.lei@redhat.com>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 12 Apr 2023 11:55:50 -0400
Message-ID: <CAGtn9r=d5EBmf=8N=ZzgrqyJ3OoEgdMhK5wiMDmpA+hof6gdcA@mail.gmail.com>
Subject: Re: [PATCH] nvme-fcloop: fix "inconsistent {IN-HARDIRQ-W} ->
 {HARDIRQ-ON-W} usage"
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	James Smart <jsmart2021@gmail.com>, Minwoo Im <minwoo.im.dev@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_085753_948658_FF567FA2 
X-CRM114-Status: GOOD (  21.34  )
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

Reviewed-by: Ewan D. Milne <emilne@redhat.com>

On Wed, Apr 12, 2023 at 4:50=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> fcloop_fcp_op() could be called from flush request's ->end_io(flush_end_i=
o) in
> which the spinlock of fq->mq_flush_lock is grabbed with irq saved/disable=
d.
>
> So fcloop_fcp_op() can't call spin_unlock_irq(&tfcp_req->reqlock) simply
> which enables irq unconditionally.
>
> Fixes the warning by switching to spin_lock_irqsave()/spin_unlock_irqrest=
ore()
>
> Fixes: c38dbbfab1bc ("nvme-fcloop: fix inconsistent lock state warnings")
> Cc: James Smart <jsmart2021@gmail.com>
> Cc: Minwoo Im <minwoo.im.dev@gmail.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/nvme/target/fcloop.c | 48 ++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 5c16372f3b53..c780af36c1d4 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -614,10 +614,11 @@ fcloop_fcp_recv_work(struct work_struct *work)
>         struct fcloop_fcpreq *tfcp_req =3D
>                 container_of(work, struct fcloop_fcpreq, fcp_rcv_work);
>         struct nvmefc_fcp_req *fcpreq =3D tfcp_req->fcpreq;
> +       unsigned long flags;
>         int ret =3D 0;
>         bool aborted =3D false;
>
> -       spin_lock_irq(&tfcp_req->reqlock);
> +       spin_lock_irqsave(&tfcp_req->reqlock, flags);
>         switch (tfcp_req->inistate) {
>         case INI_IO_START:
>                 tfcp_req->inistate =3D INI_IO_ACTIVE;
> @@ -626,11 +627,11 @@ fcloop_fcp_recv_work(struct work_struct *work)
>                 aborted =3D true;
>                 break;
>         default:
> -               spin_unlock_irq(&tfcp_req->reqlock);
> +               spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>                 WARN_ON(1);
>                 return;
>         }
> -       spin_unlock_irq(&tfcp_req->reqlock);
> +       spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>
>         if (unlikely(aborted))
>                 ret =3D -ECANCELED;
> @@ -655,8 +656,9 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
>                 container_of(work, struct fcloop_fcpreq, abort_rcv_work);
>         struct nvmefc_fcp_req *fcpreq;
>         bool completed =3D false;
> +       unsigned long flags;
>
> -       spin_lock_irq(&tfcp_req->reqlock);
> +       spin_lock_irqsave(&tfcp_req->reqlock, flags);
>         fcpreq =3D tfcp_req->fcpreq;
>         switch (tfcp_req->inistate) {
>         case INI_IO_ABORTED:
> @@ -665,11 +667,11 @@ fcloop_fcp_abort_recv_work(struct work_struct *work=
)
>                 completed =3D true;
>                 break;
>         default:
> -               spin_unlock_irq(&tfcp_req->reqlock);
> +               spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>                 WARN_ON(1);
>                 return;
>         }
> -       spin_unlock_irq(&tfcp_req->reqlock);
> +       spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>
>         if (unlikely(completed)) {
>                 /* remove reference taken in original abort downcall */
> @@ -681,9 +683,9 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
>                 nvmet_fc_rcv_fcp_abort(tfcp_req->tport->targetport,
>                                         &tfcp_req->tgt_fcp_req);
>
> -       spin_lock_irq(&tfcp_req->reqlock);
> +       spin_lock_irqsave(&tfcp_req->reqlock, flags);
>         tfcp_req->fcpreq =3D NULL;
> -       spin_unlock_irq(&tfcp_req->reqlock);
> +       spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>
>         fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
>         /* call_host_done releases reference for abort downcall */
> @@ -699,11 +701,12 @@ fcloop_tgt_fcprqst_done_work(struct work_struct *wo=
rk)
>         struct fcloop_fcpreq *tfcp_req =3D
>                 container_of(work, struct fcloop_fcpreq, tio_done_work);
>         struct nvmefc_fcp_req *fcpreq;
> +       unsigned long flags;
>
> -       spin_lock_irq(&tfcp_req->reqlock);
> +       spin_lock_irqsave(&tfcp_req->reqlock, flags);
>         fcpreq =3D tfcp_req->fcpreq;
>         tfcp_req->inistate =3D INI_IO_COMPLETED;
> -       spin_unlock_irq(&tfcp_req->reqlock);
> +       spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>
>         fcloop_call_host_done(fcpreq, tfcp_req, tfcp_req->status);
>  }
> @@ -807,13 +810,14 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
>         u32 rsplen =3D 0, xfrlen =3D 0;
>         int fcp_err =3D 0, active, aborted;
>         u8 op =3D tgt_fcpreq->op;
> +       unsigned long flags;
>
> -       spin_lock_irq(&tfcp_req->reqlock);
> +       spin_lock_irqsave(&tfcp_req->reqlock, flags);
>         fcpreq =3D tfcp_req->fcpreq;
>         active =3D tfcp_req->active;
>         aborted =3D tfcp_req->aborted;
>         tfcp_req->active =3D true;
> -       spin_unlock_irq(&tfcp_req->reqlock);
> +       spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>
>         if (unlikely(active))
>                 /* illegal - call while i/o active */
> @@ -821,9 +825,9 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
>
>         if (unlikely(aborted)) {
>                 /* target transport has aborted i/o prior */
> -               spin_lock_irq(&tfcp_req->reqlock);
> +               spin_lock_irqsave(&tfcp_req->reqlock, flags);
>                 tfcp_req->active =3D false;
> -               spin_unlock_irq(&tfcp_req->reqlock);
> +               spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>                 tgt_fcpreq->transferred_length =3D 0;
>                 tgt_fcpreq->fcp_error =3D -ECANCELED;
>                 tgt_fcpreq->done(tgt_fcpreq);
> @@ -880,9 +884,9 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
>                 break;
>         }
>
> -       spin_lock_irq(&tfcp_req->reqlock);
> +       spin_lock_irqsave(&tfcp_req->reqlock, flags);
>         tfcp_req->active =3D false;
> -       spin_unlock_irq(&tfcp_req->reqlock);
> +       spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>
>         tgt_fcpreq->transferred_length =3D xfrlen;
>         tgt_fcpreq->fcp_error =3D fcp_err;
> @@ -896,15 +900,16 @@ fcloop_tgt_fcp_abort(struct nvmet_fc_target_port *t=
gtport,
>                         struct nvmefc_tgt_fcp_req *tgt_fcpreq)
>  {
>         struct fcloop_fcpreq *tfcp_req =3D tgt_fcp_req_to_fcpreq(tgt_fcpr=
eq);
> +       unsigned long flags;
>
>         /*
>          * mark aborted only in case there were 2 threads in transport
>          * (one doing io, other doing abort) and only kills ops posted
>          * after the abort request
>          */
> -       spin_lock_irq(&tfcp_req->reqlock);
> +       spin_lock_irqsave(&tfcp_req->reqlock, flags);
>         tfcp_req->aborted =3D true;
> -       spin_unlock_irq(&tfcp_req->reqlock);
> +       spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>
>         tfcp_req->status =3D NVME_SC_INTERNAL;
>
> @@ -946,6 +951,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport=
,
>         struct fcloop_ini_fcpreq *inireq =3D fcpreq->private;
>         struct fcloop_fcpreq *tfcp_req;
>         bool abortio =3D true;
> +       unsigned long flags;
>
>         spin_lock(&inireq->inilock);
>         tfcp_req =3D inireq->tfcp_req;
> @@ -958,7 +964,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport=
,
>                 return;
>
>         /* break initiator/target relationship for io */
> -       spin_lock_irq(&tfcp_req->reqlock);
> +       spin_lock_irqsave(&tfcp_req->reqlock, flags);
>         switch (tfcp_req->inistate) {
>         case INI_IO_START:
>         case INI_IO_ACTIVE:
> @@ -968,11 +974,11 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localpo=
rt,
>                 abortio =3D false;
>                 break;
>         default:
> -               spin_unlock_irq(&tfcp_req->reqlock);
> +               spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>                 WARN_ON(1);
>                 return;
>         }
> -       spin_unlock_irq(&tfcp_req->reqlock);
> +       spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>
>         if (abortio)
>                 /* leave the reference while the work item is scheduled *=
/
> --
> 2.31.1
>
>


