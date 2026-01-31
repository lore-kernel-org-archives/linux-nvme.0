Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2063ED79767
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Jan 2026 13:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2xQP5dk/2/EhwE9cPPLJlOMoFx7c2d6aAINy7Z5odIY=; b=K/THtNzQ3sCnnKKyv4OM/Bkw19
	ufnHmfzQO484wzJmyrLDmJz28UvZRz7b7GwDd7fgfZfmg1v+LBCnp1KEeLiCAD5YyyE4ZJNAkc/7C
	mzOflLZZL9+Xorx5feRQUAh58m4fDssj6LhVnDOU06NaTUdLWE3H+gTDnTvc+FZFWd9JDoWeNwqnG
	GmMVawRCwod+k6D7WZF3vhqz/yuTAKfz8ukNdvBjJ47zwUHPslZK4u7V1/CmX/XOuUnEDYpL4joIl
	jOtPMUaplK7rh6HqQqC9QLK88CkPxfGt/OFYFkZDJ0c2LuM3HKfmGVz3CFfMGb4Z7u3Cb5/WBOEKg
	4pBrhdaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmAap-00000002arw-3ner;
	Sat, 31 Jan 2026 13:00:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmAan-00000002ara-2HLS
	for linux-nvme@lists.infradead.org;
	Sat, 31 Jan 2026 13:00:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769864445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xQP5dk/2/EhwE9cPPLJlOMoFx7c2d6aAINy7Z5odIY=;
	b=V2OK4fYnk1CXZ5H8xjElOCHfxZCrFXHKmo9kmT64uA4tFgCruzAkoCqOVlAPrbmRCv11TL
	cKNNWUpyEZA727dDhd4aKjMOARKjWGPhI0LZWWV3gelNKvj+OpF8QsIKQeEw79ywi51GKN
	NzSglCiJ8Zn8jCg5NN/BdRfVp5klI2s=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-6IIjq5ybMEOHAusmJ9FbxQ-1; Sat, 31 Jan 2026 08:00:43 -0500
X-MC-Unique: 6IIjq5ybMEOHAusmJ9FbxQ-1
X-Mimecast-MFC-AGG-ID: 6IIjq5ybMEOHAusmJ9FbxQ_1769864442
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-382fb514fdcso22678011fa.0
        for <linux-nvme@lists.infradead.org>; Sat, 31 Jan 2026 05:00:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769864442; x=1770469242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2xQP5dk/2/EhwE9cPPLJlOMoFx7c2d6aAINy7Z5odIY=;
        b=bqejIMZaLmXkE3VJdGHAnhqzxJBh6LiERUtbpKf1Tjokxda+C/PDWT6mtDfFNTp6ME
         uK7hnpzE0W7+9QxPGbORwX2F6B8EtwHux92t1jBMC1SLXOeb0dSZByXM5wloIgNmlwWL
         KnwSN6ATcdN+TJT9/I4TPY6yc09CDG6jQr0rmExDm4k5tB/LiYYq4THXVGDdyfJg2+iV
         po2+bYFiMgwCY5jPmsjL6vSLdmF77IRU95u2n2UhqEDG7zmiZjq6UDM9269bZ2vGg0v0
         cXjoZPnPix6N1V6aR5ud8PBNEXNkeAtGaLbhM37/u/ZOGqhKxaEBDTnK2KdeiLp67Qav
         /crQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy25EYDA0bOUpo6LglKDsOPFSVPProC4soPXAYiCWSuWjK7WJdt1Y+cddj/wobHZheQTIFUGmAjYwN@lists.infradead.org
X-Gm-Message-State: AOJu0YytdcWHIU+a2mh0mPmOi8YP7+KF+VQIG7fi2OpCUC7SnuVd+nru
	Qx8xWil6QpYSCaFGlHrnzcWYGQDfgQ/dIbNFtSq65PSejETM/s7I/s38WOvns6a3VtbbhXjqzSk
	nhRhwhpHcb5B1pwEJBJPtxn+Q/ujppGHQkM9Tzsw/FBnsfqvqRxgDfSqvgJwnI7DXv5CYnofpi4
	pp+iWT1DXQQVRlzkF2VJYeGZQ44zgD2cmm3wnqbmUUWY4=
X-Gm-Gg: AZuq6aIjrG05dGigijaNTlCIIDlc2aAu5mVPe5uHR5tx6jSxyC6Zr4+k06BljOcQ+Kv
	kR9+fIMwYxy+yK/r4J/fPHYbsV2Bb12+0aqw+Nzlpyj4SqSOe2yxHmOE4KwiDJWgEMtPPR+xJlH
	bQKESFCg9a7arHwTXE2q384PUwyAdj8r6fUGfYmT6rjLVPR8gIzo2N9JZOEItzbVBuc8s=
X-Received: by 2002:a05:651c:a0a:b0:37e:6031:4e5 with SMTP id 38308e7fff4ca-38646629907mr19928361fa.22.1769864441628;
        Sat, 31 Jan 2026 05:00:41 -0800 (PST)
X-Received: by 2002:a05:651c:a0a:b0:37e:6031:4e5 with SMTP id
 38308e7fff4ca-38646629907mr19928251fa.22.1769864441191; Sat, 31 Jan 2026
 05:00:41 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com>
 <262c8ac1-e625-4e4c-8b3c-85f842aba6fe@gmail.com> <7d718bc8-64b6-4e8f-bad7-7e1615c577ca@nvidia.com>
 <CAHj4cs9gBTHLB_7JrFpZnJ-imc7jmqnhZpqkemaRVQYLn9j_rQ@mail.gmail.com>
 <CAHj4cs-84wsWQKeBS2wkd-_Y4Xe7wcTPqzutisNbXtpcAdh8yw@mail.gmail.com> <aXxhkUXXOlrRw1sG@fedora>
In-Reply-To: <aXxhkUXXOlrRw1sG@fedora>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 31 Jan 2026 21:00:27 +0800
X-Gm-Features: AZwV_Qh-D_qOZQCdgkztGDIsNY17wMdEuIadZQMyNY1-SiMwy1BW9r5UsDTXd9s
Message-ID: <CAHj4cs8ONasnaHgdNPFq_JWaMkGtW714tU-9hYXYmhBEXsib5w@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed during blktests nvme/fc
To: Ming Lei <ming.lei@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, justintee8345@gmail.com, 
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>, 
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VyaKDElshKUyWDrsKfqq27X3ai_xA5YsIMnQmFORTxI_1769864442
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260131_050049_670093_8166E9DE 
X-CRM114-Status: GOOD (  20.24  )
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

On Fri, Jan 30, 2026 at 3:45=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Jan 15, 2026 at 05:24:58PM +0800, Yi Zhang wrote:
> > Hi Justin and Chaitanya
> >
> > It turns out that the kmemleak was caused by nvme-loop. It was
> > observed during the stress nvme loop/tcp/fc[1] test, but the kmemleak
> > log was reported during the nvme/fc test. That's why I didn't
> > reproduce it with the stress nvme/fc test before.
> >
> > [1]
> > nvme_trtype=3Dloop ./check nvme/
> > nvme_trtype=3Dtcp ./check nvme/
> > nvme_trtype=3Dfc ./check nvme/
> >
> > unreferenced object 0xffff8881295fd000 (size 1024):
> >   comm "nvme", pid 101335, jiffies 4299282670
> >   hex dump (first 32 bytes):
> >     00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
> >     ff ff ff ff ff ff ff ff e0 3c 57 af ff ff ff ff  .........<W.....
> >   backtrace (crc 414bcfcd):
> >     __kmalloc_cache_node_noprof+0x5f9/0x840
> >     blk_mq_alloc_hctx+0x52/0x810
> >     blk_mq_alloc_and_init_hctx+0x5b9/0x840
> >     __blk_mq_realloc_hw_ctxs+0x20a/0x610
> >     blk_mq_init_allocated_queue+0x2e9/0x1210
> >     blk_mq_alloc_queue+0x17f/0x230
> >     nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
> >     nvme_loop_configure_admin_queue+0xdf/0x2d0 [nvme_loop]
> >     nvme_loop_create_ctrl+0x428/0xb13 [nvme_loop]
> >     nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
> >     nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
> >     vfs_write+0x1d0/0xfd0
> >     ksys_write+0xf9/0x1d0
> >     do_syscall_64+0x95/0x520
> >     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> It seems regression from 03b3bcd319b3 ("nvme: fix admin request_queue
> lifetime"), can you try the following fix?
>

I've verified the issue cannot be reproduced now. Thanks.


>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 19b67cf5d550..64db8e3d8fd8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4848,6 +4848,15 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctr=
l, struct blk_mq_tag_set *set,
>         struct queue_limits lim =3D {};
>         int ret;
>
> +       /*
> +        * If a previous admin queue exists (e.g., from before a reset),
> +        * put it now before allocating a new one to avoid orphaning it.
> +        */
> +       if (ctrl->admin_q) {
> +               blk_put_queue(ctrl->admin_q);
> +               ctrl->admin_q =3D NULL;
> +       }
> +
>         memset(set, 0, sizeof(*set));
>         set->ops =3D ops;
>         set->queue_depth =3D NVME_AQ_MQ_TAG_DEPTH;
>
>
>
>
> Thanks,
> Ming
>


--=20
Best Regards,
  Yi Zhang


