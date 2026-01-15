Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFB4D41144
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jan 2026 09:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AFVx2OPknI0/5/crmPB60StwMjoaJBP8nc1bG0QCX/A=; b=L3x69mo5bFvD3fdLhHN6bri1fl
	bKt+SFvTOfurkyaYIE9arSrMPY+5KKyhOkftSCSx3snB/gT118ArChRpWYrCH1QIk4BijMtdt9FJp
	pPKFXcxXXJn9Mj9teM9keZPFjMtfKpkBLiZELr3nB4r0ipAsBSEW1qFQWQpSjm/K14g/nggOQhFI9
	JqLRz24vCXGflzTOP03FEqbMS7tCGGUh5D8uCq/YjAQ09Zg6YqdvNjjRA5rJRqUw3JPU2ibPA/rYs
	7PmbQfmh/dWCle403JhpkgxU9CwQBqyKm7NYtxc47osjHkVYJ/hBEQaXs33z7ii/6Pdw1yR4HZEu9
	BoccvFMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgJbW-0000000C407-2Wdi;
	Thu, 15 Jan 2026 09:25:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgJbR-0000000C3zB-3fM5
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jan 2026 09:25:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768469115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AFVx2OPknI0/5/crmPB60StwMjoaJBP8nc1bG0QCX/A=;
	b=MnxCewiK+rQAW3tSUjVYtXcBndLSFk7FNlBbw/iZ8OBDldXyTUYPbIXDwm2H931VVDscJ6
	rXY82Q05HuR6uO/6FakXWlcFbPaWYd005WnJbUIIDOzPPMJFFtp3Oux0ekNIWizLKBzpA0
	9G+BVsK9rc6pxgmIFULbdj2Ih26XQBU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-_ESE7JhkPYONTLGzQLfnrA-1; Thu, 15 Jan 2026 04:25:13 -0500
X-MC-Unique: _ESE7JhkPYONTLGzQLfnrA-1
X-Mimecast-MFC-AGG-ID: _ESE7JhkPYONTLGzQLfnrA_1768469112
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-38306501f14so3560761fa.1
        for <linux-nvme@lists.infradead.org>; Thu, 15 Jan 2026 01:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768469112; x=1769073912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AFVx2OPknI0/5/crmPB60StwMjoaJBP8nc1bG0QCX/A=;
        b=hQnpAPbIaATj6ondD6mHlKJ3OQe1cDH87x8tYEOHMN2x1HNlXjA0gLjgpLTGYMt6SD
         5gyUumE2vXYhSkJANxQuV9KJ/mrMfwOtgaMdbwEa7XsYoUJmxbgfw8zrjQASMLacjRHd
         oI2hXFcPUsGJIFLA5rENIkkdo8OOqJD4Ae1bohjuFqsOUbOvB6sHRYGdtK0/2eoo50iC
         4TMY7TIPP6KNVkMJiDrCdCH24qnQznb4+d81poEgmYQF+gEvlUl3JeiclSRJsFq6MTm7
         XCCB1Fsk8dsVxCqdwlFeucGYqMK/nVFDpjwjvnQSMELSg+e5V8TLR1+o3Ggx1XSG/Tad
         R8XA==
X-Forwarded-Encrypted: i=1; AJvYcCVcNNnB6ZmJbcnvPxEHQhAfjDFm6WQu1VyVmxMlToqTNDuqUSRpvWgBHTlSoCjDryq8jJ0arBeo08pd@lists.infradead.org
X-Gm-Message-State: AOJu0Yws27XCf5f1nj5q3CckpEpj7iT5dB4j6CB3zsh6jPqYYTshRf/d
	fMsDifPvhf6wQuZnXEBOJ+oKxYXqi3ZDAM+mVtt39E6NElzF5oBhAi+GW5TvRQyGL2SEQPNxiI8
	UdKai9sxLzfOl63nrO5Gp8u4F22B69a8kLMH2RPIylNDGVrc5w+XQRycnVmNqsJnKlzDJC9LkD1
	RBk1yf9IbYhvb4jUabrHLaya4Jwe2wzheo+LWRkYr57Mk=
X-Gm-Gg: AY/fxX4A2mf/yEwtgrf6whmqheJYmo61NMTfxvTHIcfL7rx4aEVdcIsRP47a3jyeb8g
	kl7dZK/H5ibT5pbEatzp6+JSsfJXIAPk0EiOMZ7H+yUhzBVECXZ+klHi3T3plojcazTOtdIy30s
	wHs9o34UEgaQpOWlu8VUkEPSubabJZqApv/4uh/7odzNZnTo/mLCSNm43zZZf8Evsx3Gw=
X-Received: by 2002:a05:651c:1541:b0:383:5a4f:2605 with SMTP id 38308e7fff4ca-38360831ad3mr18477931fa.44.1768469111872;
        Thu, 15 Jan 2026 01:25:11 -0800 (PST)
X-Received: by 2002:a05:651c:1541:b0:383:5a4f:2605 with SMTP id
 38308e7fff4ca-38360831ad3mr18477851fa.44.1768469111410; Thu, 15 Jan 2026
 01:25:11 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com>
 <262c8ac1-e625-4e4c-8b3c-85f842aba6fe@gmail.com> <7d718bc8-64b6-4e8f-bad7-7e1615c577ca@nvidia.com>
 <CAHj4cs9gBTHLB_7JrFpZnJ-imc7jmqnhZpqkemaRVQYLn9j_rQ@mail.gmail.com>
In-Reply-To: <CAHj4cs9gBTHLB_7JrFpZnJ-imc7jmqnhZpqkemaRVQYLn9j_rQ@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 15 Jan 2026 17:24:58 +0800
X-Gm-Features: AZwV_QgMuBM7WRV2hAZveEm3FY527xhIAOt1HlaitQTZAE4l_GoB7b6WdnawdWg
Message-ID: <CAHj4cs-84wsWQKeBS2wkd-_Y4Xe7wcTPqzutisNbXtpcAdh8yw@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed during blktests nvme/fc
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, justintee8345@gmail.com
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>, 
	Daniel Wagner <dwagner@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pHhEEgDwIgBiYOqqq8l6FfVrgpm74Mw8m7mngqFbPFg_1768469112
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260115_012517_992798_8C3247D8 
X-CRM114-Status: GOOD (  22.25  )
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

Hi Justin and Chaitanya

It turns out that the kmemleak was caused by nvme-loop. It was
observed during the stress nvme loop/tcp/fc[1] test, but the kmemleak
log was reported during the nvme/fc test. That's why I didn't
reproduce it with the stress nvme/fc test before.

[1]
nvme_trtype=3Dloop ./check nvme/
nvme_trtype=3Dtcp ./check nvme/
nvme_trtype=3Dfc ./check nvme/

unreferenced object 0xffff8881295fd000 (size 1024):
  comm "nvme", pid 101335, jiffies 4299282670
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff e0 3c 57 af ff ff ff ff  .........<W.....
  backtrace (crc 414bcfcd):
    __kmalloc_cache_node_noprof+0x5f9/0x840
    blk_mq_alloc_hctx+0x52/0x810
    blk_mq_alloc_and_init_hctx+0x5b9/0x840
    __blk_mq_realloc_hw_ctxs+0x20a/0x610
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    nvme_loop_configure_admin_queue+0xdf/0x2d0 [nvme_loop]
    nvme_loop_create_ctrl+0x428/0xb13 [nvme_loop]
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8881c24db660 (size 8):
  comm "nvme", pid 101335, jiffies 4299282670
  hex dump (first 8 bytes):
    ff ff 00 00 00 00 00 00                          ........
  backtrace (crc b47d4cd6):
    __kmalloc_node_noprof+0x6ab/0x970
    alloc_cpumask_var_node+0x56/0xb0
    blk_mq_alloc_hctx+0x74/0x810
    blk_mq_alloc_and_init_hctx+0x5b9/0x840
    __blk_mq_realloc_hw_ctxs+0x20a/0x610
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    nvme_loop_configure_admin_queue+0xdf/0x2d0 [nvme_loop]
    nvme_loop_create_ctrl+0x428/0xb13 [nvme_loop]
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8882752cd300 (size 128):
  comm "nvme", pid 101335, jiffies 4299282670
  hex dump (first 32 bytes):
    00 bf f0 fb ff e8 ff ff 00 bf 30 fc ff e8 ff ff  ..........0.....
    00 bf 70 fc ff e8 ff ff 00 bf b0 fc ff e8 ff ff  ..p.............
  backtrace (crc caffc16d):
    __kmalloc_node_noprof+0x6ab/0x970
    blk_mq_alloc_hctx+0x43a/0x810
    blk_mq_alloc_and_init_hctx+0x5b9/0x840
    __blk_mq_realloc_hw_ctxs+0x20a/0x610
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    nvme_loop_configure_admin_queue+0xdf/0x2d0 [nvme_loop]
    nvme_loop_create_ctrl+0x428/0xb13 [nvme_loop]
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff88827d5d7800 (size 512):
  comm "nvme", pid 101335, jiffies 4299282670
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 93cf34af):
    __kvmalloc_node_noprof+0x814/0xb30
    sbitmap_init_node+0x184/0x730
    blk_mq_alloc_hctx+0x4b3/0x810
    blk_mq_alloc_and_init_hctx+0x5b9/0x840
    __blk_mq_realloc_hw_ctxs+0x20a/0x610
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    nvme_loop_configure_admin_queue+0xdf/0x2d0 [nvme_loop]
    nvme_loop_create_ctrl+0x428/0xb13 [nvme_loop]
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
On Sat, Dec 27, 2025 at 8:10=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> > > Can you try following ? FYI : - Potential fix, only compile tested.
> > >
> > > From b3c2e350ae741b18c04abe489dcf9d325537c01c Mon Sep 17 00:00:00 200=
1
> > > From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> > > Date: Sun, 14 Dec 2025 19:29:24 -0800
> > > Subject: [PATCH COMPILE TESTED ONLY] nvme-fc: release admin tagset if
> > > init fails
> > >
> > > nvme_fabrics creates an NVMe/FC controller in following path:
> > >
> > >     nvmf_dev_write()
> > >       -> nvmf_create_ctrl()
> > >         -> nvme_fc_create_ctrl()
> > >           -> nvme_fc_init_ctrl()
> > >
> > > Check ctrl->ctrl.admin_tagset in the fail_ctrl path and call
> > > nvme_remove_admin_tag_set() to release the resources.
> > >
> > > Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> > > ---
> > >  drivers/nvme/host/fc.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > > index bc455fa98246..6948de3f438a 100644
> > > --- a/drivers/nvme/host/fc.c
> > > +++ b/drivers/nvme/host/fc.c
> > > @@ -3587,6 +3587,8 @@ nvme_fc_init_ctrl(struct device *dev, struct
> > > nvmf_ctrl_options *opts,
> > >
> > >      ctrl->ctrl.opts =3D NULL;
> > >
> > > +    if (ctrl->ctrl.admin_tagset)
> > > +        nvme_remove_admin_tag_set(&ctrl->ctrl);
> > >      /* initiate nvme ctrl ref counting teardown */
> > >      nvme_uninit_ctrl(&ctrl->ctrl);
> > >
> > did you get a chance to try this ?
>
> Hi Chaitanya
>
> Sorry for the late response, I tried to reproduce this issue recently
> but with no luck to reproduce it again.
> And during the stress blktests nvme/fc test, I reproduced several panic i=
ssue.
> I will report it later after I get more info.
>
>
> >
> > -ck
> >
>
>
> --
> Best Regards,
>   Yi Zhang



--
Best Regards,
  Yi Zhang


