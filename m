Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A69D112583F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2026 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eAixbPiqiWKvxfTtqwLl1ZycNxKKR9XvSIdM8Jl9/1M=; b=nboY1S8qv20ge8jj9Tuy7mF99O
	sUPTO7N5m1i/B6veITOGzC8UaP1+ODfMVWCjd+K0qHDYuxxlw7arWpn17uIXqIp6DGNjD+kErEd8I
	Fln+g4yOY3Jzn72C2gJdmm6i7uPgvSLRQUGEhLKbODkV9T0T8B7sybkAfj0itvvCbxUq6a+G38OmH
	RwXmZA3aadeqxNK+COtgW2semZq2AX06Vc/ndjj2W8/B0Yxj3Z/bxirynmEUJ7nn23f9OQg10lHJT
	ISX7bKwHAifnVbP0Uv9tUv3hp3AZvF2GUjF3QssWvEHSIAtjNeMC91uZBfky6cTtMb5pxPKoP6l1Z
	3aZoR2EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0LBW-0000000Blbw-46b4;
	Wed, 11 Mar 2026 15:09:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0LBS-0000000BlbP-3OKc
	for linux-nvme@lists.infradead.org;
	Wed, 11 Mar 2026 15:09:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773241753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eAixbPiqiWKvxfTtqwLl1ZycNxKKR9XvSIdM8Jl9/1M=;
	b=RL5ZMe+scySmI6MzfpFmiQ/AUch0/RAQh9a0i8rQMWqLtLFeFIgLPBaXuTDNIaI70t4Ufg
	9xibD2hWALCC5foT0fcUG7nGEiXieH8+0h0/kCadEYcMLXMJBvNXtBJk97jL2zntaf7NJz
	9Qu/BjBGHDwdUlbixoHB4dymApb2qzs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-qoyIDO5rPN-mxA25voDTVw-1; Wed, 11 Mar 2026 11:09:12 -0400
X-MC-Unique: qoyIDO5rPN-mxA25voDTVw-1
X-Mimecast-MFC-AGG-ID: qoyIDO5rPN-mxA25voDTVw_1773241751
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5a118530219so28684e87.1
        for <linux-nvme@lists.infradead.org>; Wed, 11 Mar 2026 08:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773241750; x=1773846550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eAixbPiqiWKvxfTtqwLl1ZycNxKKR9XvSIdM8Jl9/1M=;
        b=Y8hrpFOM2D+GYVmFvWNpUxtOt5wS4p6XkUWxReO8aenOImXfLuL46ZNUKHc0mE8XWc
         +UuwZ7LLoPhjMBsBLyYO8SiUFUTUIOZR5+AovKIK3O8B0ogef9WG2pda95sgtSbHMXZE
         FG3B56vYjXZfdnPWBRS+q2bNBDxCRJTK3WLbOWQ4uYj5Ozeogf0BtzUy5/rNBKUUNnHh
         Xskyfp/a4e15HKDkh9PsIjuc6ejwqlrizoLJAI2R4a2J1gJ/h45Wz/Ou8V7CPkcaZos8
         9td8aVmbfcC0S6AwTomGqAwOVsVgTAmm93f2+PhUxiEQm5A3rEltmu75Nq03apGgwUMV
         6lqw==
X-Forwarded-Encrypted: i=1; AJvYcCXCWJPYzaAH6q5Gen15LcYsNbXi8L+bAUGCLwhuPaEn9uknsPgpAEQwkyTNWwCD8PuhBHUaiaEVUs8q@lists.infradead.org
X-Gm-Message-State: AOJu0YyyhO3OFJyoiQTAaD3FQD0KEFki+7FQ9LvQdHnwtmEbqDQeJGrN
	4MDTnV30gTFx3361SeNROyUOm25N4ZHgQutFKNJYSmlINt62wnPtCIUzTdl3fFycV78BHglipmK
	4UT3CSI03+vLtM2lm/igYwwofuAnngeTselidDIAvpFbQ/Cg/+9sfj3BmRw4/yT4zntEY8YlKGV
	vSlp/eQc83x2RK07LRf2BifEJlFoNZbh3BqDq+7m8pz3Y=
X-Gm-Gg: ATEYQzx1HwBL2uB2V6nsokK6MiyxmT7g1xOtxgLPNqhrQuxYB/9S1qjNsI5AOiGiDZ3
	yB4IF4BdcC3FHJqVPVTNVz+HMr59MUdWc+HDPtPfL6+tKK7VpIJmHY3lucJkA+ZC4VN5yFw2jJP
	mGYJV6Cvv8JEBVI/CytbjhYofUZQot6P3N3EnrPAFfM5kSVF7/Oi6VXxW5cQpItlamo3Ca+86ek
	TMQFgGT0IkYeJH7lsplsFT7XScshSSuw75hVTI5SsIc5p7BFik=
X-Received: by 2002:a05:651c:551:b0:389:ee7b:4d4b with SMTP id 38308e7fff4ca-38a67dd60d3mr11561831fa.12.1773241750316;
        Wed, 11 Mar 2026 08:09:10 -0700 (PDT)
X-Received: by 2002:a05:651c:551:b0:389:ee7b:4d4b with SMTP id
 38308e7fff4ca-38a67dd60d3mr11561701fa.12.1773241749845; Wed, 11 Mar 2026
 08:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <aZ_-cH8euZLySxdD@shinmob> <CAHj4cs8mzSZez+n2qLu5931YAuQ4=RxNt6D6YJCsMEwGrm4UtA@mail.gmail.com>
 <DGZRYXTKC049.1I6QFQSMSD88H@arkamax.eu> <DGZTXRKSHBPC.2B318HF53ZRSN@arkamax.eu>
In-Reply-To: <DGZTXRKSHBPC.2B318HF53ZRSN@arkamax.eu>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 11 Mar 2026 23:08:41 +0800
X-Gm-Features: AaiRm52s-EH5ucY3yGw_WaFk4XtbskkABtsWUN8MID31uF9eSwnbqLdAEQHevQY
Message-ID: <CAHj4cs_nQEbeyvqvos7pwek8k0rLLXCghdoY9EsL4bCgZrxqtA@mail.gmail.com>
Subject: Re: blktests failures with v7.0-rc1 kernel
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u_cem87iMEpxvobkhWshogfIIz_Cw_NkUxeEFjLDTXc_1773241751
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_080914_941710_95A95764 
X-CRM114-Status: GOOD (  12.96  )
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

On Wed, Mar 11, 2026 at 5:02=E2=80=AFPM Maurizio Lombardi <mlombard@arkamax=
.eu> wrote:
>
> On Wed Mar 11, 2026 at 8:29 AM CET, Maurizio Lombardi wrote:
> > On Wed Mar 11, 2026 at 1:35 AM CET, Yi Zhang wrote:
> >
> > If nvmet_rdma_rw_ctx_init() fails, shouldn't it call
> > nvmet_req_free_sgls() before returning an error?
>
> Possible fix, not tested:
>
Hi Maurizio
The kmemleak still can be reproduced with this patch:

unreferenced object 0xffff88811db23d80 (size 32):
  comm "kworker/16:1H", pid 1360, jiffies 4296118279
  hex dump (first 32 bytes):
    82 3b 85 04 00 ea ff ff 00 00 00 00 00 10 00 00  .;..............
    00 e0 4e 21 81 88 ff ff 00 10 00 00 00 00 00 00  ..N!............
  backtrace (crc 4bb38867):
    __kmalloc_noprof+0x6f1/0xa10
    sgl_alloc_order+0x9e/0x370
    nvmet_req_alloc_sgls+0x294/0x4f0 [nvmet]
    nvmet_rdma_map_sgl_keyed+0x25d/0x9a0 [nvmet_rdma]
    nvmet_rdma_handle_command+0x1ed/0x4e0 [nvmet_rdma]
    __ib_process_cq+0x139/0x4b0 [ib_core]
    ib_cq_poll_work+0x4d/0x160 [ib_core]
    process_one_work+0x8b1/0x15e0
    worker_thread+0x5e9/0xfc0
    kthread+0x36b/0x470
    ret_from_fork+0x5bf/0x910
    ret_from_fork_asm+0x1a/0x30


> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 2d6eb89f98af..79ae743bb405 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -892,7 +892,7 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma=
_rsp *rsp,
>
>         ret =3D nvmet_rdma_rw_ctx_init(rsp, addr, key, &sig_attrs);
>         if (unlikely(ret < 0))
> -               goto error_out;
> +               goto error_free_sgl;
>         rsp->n_rdma +=3D ret;
>
>         if (invalidate)
> @@ -900,6 +900,8 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma=
_rsp *rsp,
>
>         return 0;
>
> +error_free_sgl:
> +       nvmet_req_free_sgls(&rsp->req);
>  error_out:
>         rsp->req.transfer_len =3D 0;
>         return NVME_SC_INTERNAL;
>
> Maurizio
>


--=20
Best Regards,
  Yi Zhang


