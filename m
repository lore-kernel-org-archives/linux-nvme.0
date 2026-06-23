Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C619CDB471
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 22:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lktyDVRtVy/viiqrhpDpy008z8LoJ6ZN5NvRhb+XjTs=; b=INqz0M/ieEg9gCkT9o3xhjj9jD
	6C+SbBJD+mNHSZUpk673Efen+Am0MA7EsGw82YXT13v7Wvfiho3jXAIT+QYli3JpV/60Z1xECQ080
	lY+hI99eZdh/f0LUiBB6oDQcsn3wk/Qh0nIUURL1PlNDoPPiqdKbEcnzfcdLQtolTLCxBHFZbrK8d
	UcAxlJ3KNb3r2+cwvNBtKJN/xx+Xjfz74zg2G6Oq0QPwuPkyr6HRm4WlfWs5yHmhCMNvxwB9iTYLb
	59m2pBjlq+jMyNsQq0Zv775CnKQ42pOM6RVPTwwX++Z4JgE12qAYX2Fv13zJylEt4KciLdrtrlfbe
	CNgILVtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc9c9-00000006woB-2c77;
	Tue, 23 Jun 2026 22:29:05 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc9c7-00000006wnn-0aLd
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 22:29:04 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-693c69b97e7so566710a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2026 15:29:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782253741; cv=none;
        d=google.com; s=arc-20240605;
        b=Gvq2PJ1H1exhctmrgiph4rOwFXujT4O8QShNDQltRBDO58pm+E02kyZF7E/b8oOOCR
         YlvC/1/4JQWCYtNszt0CrzM3CbKxUeGo5uyve4BwydBMYPfz75HafpQ382CjGMgIpbfV
         0S72VIIKi7ma+Vp0sLs4V9vnq1jmdouOZsGxdu7RNES8eHBEtfCzXjobsiL1TsuluaV2
         T7aFc3w9gEueAHlBhppWTwxnI5Epj57slkJGRQxmR7mhG7VYCWF51syQP3cg8DSJtCBJ
         Lx233GukiuXo/NNuaRCEHbcPlQ9pIziWevcgmkGt49yoCd2FfxTK7Yb22AhGRlBEgAQU
         6ZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lktyDVRtVy/viiqrhpDpy008z8LoJ6ZN5NvRhb+XjTs=;
        fh=3z/6Qej+pYASJYvEvz8KeWveHe24d+PxhHKrPAWJc/Y=;
        b=bsxQi2TXew51gwptVxLlj/usZQWS71gOu+Sz+hbVMPVpzkgGDzkRISq8Oi7Y3Zo+66
         nUj+nb4i7F67PK9Se7z5dxDIWrwqul1TsE7HtgKeRD16MkBCk0UWnkI43uyFbVHXMIf8
         MhNA1uNa5uEvb0WYa7qVfu7RgTYh/PnptslZZz81+D/eE2J9w3/QnBJp43IRV/Zg/se0
         PYJPN1U7wbLZ93XW3awEvk+RD/oteoy0r7QPkRt6JOc0qEPVOHiONtPc4/S2sgLKrBED
         uNT2DyYI5ODZGhpJV3R83uNxMf7sgHQyb7sTvyXpI13/H1B6BAiixCU2QauxjVSlJg3s
         Z6Gw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782253741; x=1782858541; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lktyDVRtVy/viiqrhpDpy008z8LoJ6ZN5NvRhb+XjTs=;
        b=XfALH7rAv93gvv7bE5di4lV6v9wivDPfxa4xj/KHgY6I8y7nwxcici94ppU0ho69aP
         OeHgHlvayeWvPigVIzk3wIk80NpClLrU+ZdNlftCKswby9IKitWzwCWHi4y+uhXSPu+e
         JxGeHeeJdNbCjUR/QkERWxMlLwK1gnMkx9IYJvUBmCWh70VNECU4fkBlTOoGA0KerYWd
         R1A64YJdFirKycEqbpF8jOtjiAhMPPaa05Yso5ltajsiSQN0nNRujT4qJfv9EHWvwdsO
         6/FIcs399DZnSx/lQfnnwkt6ij1eR7YyTZJVp9fQ1bssKWODOYbzTLljJRkpAY40LeS/
         IeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782253741; x=1782858541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lktyDVRtVy/viiqrhpDpy008z8LoJ6ZN5NvRhb+XjTs=;
        b=nuU03unU1xhLmEqgDMSh3snEt+gDdt7YtqsSx72wvtkXk1zc1WGYO2DAml6Q+wuEHj
         zcyYIIWhbE7WVG8hUuPeQm8kXkDrkjfSUOhOA6gR1h9fa6LUny+A7IdtRrynFpc+bTaX
         kHjrjNsfi5jRvvykOCtcjMZ5RagO+wITxRFohqsNVK1WhKOytrcgOLPuhrBVZ6Q6iizC
         AUqISEsZ+LerclRADka3MeUz1Bf8eQV2aQUo+Rb3T761qlhGbAxvOAXW8kGjvYwbr5aL
         Yai7TnvTv4zROvz8ANj0FLKnMmQq0SvBxiP+oc2OKFgHT0icIzNDDNDW8i+L6TLUC8lp
         oynw==
X-Forwarded-Encrypted: i=1; AFNElJ+lBsIn5O9YgC4rNwsC/JSCBoHOq3OZMKK8jyG11xvMIxNfZnIsJnO7dOOHAztdCpnmuoKh4WNlG4PB@lists.infradead.org
X-Gm-Message-State: AOJu0Ywiup7DNZRfmngEoEY+johTm8y8F5xb6Gx3+/AFm8mMtUxxnFQz
	5bVw6ErefhVpj/wlls6P6j+5Mb+NmEbdN8k04t9MV4sI5zd9gVZTRJQUX/XZHhV4C25ZeTJ5r7k
	VgcAXEPpvNHh8Bgp0h/9QhdUUjjIbZHo=
X-Gm-Gg: AfdE7cklkhL9k4h5mHgpt85y2w9rHHXYQRlDv4HPUfghI4rw/Nw5EyF9oDaNOnuirHf
	iANf6c3dHZIxkMvg/vDLavveoImlbfbhnlN8SIONKfpGtttRzHQQILAcwt6taYyqAVHpgpBQKLb
	04PwJHTpCsrfuBaCr1wgyVgy98ncxE2qK8gDbqpeDlK9prBmQx57a1gOTC0zSStUfTE9fa0u17I
	kOhBiVTL5P5Ta3Ip6w44HvUaUM7goM8D3p8qGngRQSsm2hP0cFLqsFZJfFa6Sr0M5mv9BXD
X-Received: by 2002:a05:6402:440b:b0:697:e953:d14d with SMTP id
 4fb4d7f45d1cf-697f3aa2104mr240703a12.17.1782253740745; Tue, 23 Jun 2026
 15:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260527055923.456769-1-coshi036@gmail.com> <ahcR2vy8k2FZAp9D@kbusch-mbp>
In-Reply-To: <ahcR2vy8k2FZAp9D@kbusch-mbp>
From: Chao S <coshi036@gmail.com>
Date: Tue, 23 Jun 2026 18:28:49 -0400
X-Gm-Features: AVVi8Cd8_G414Jfa45nLwZOQQmYHszzp1qOg3SGpW-z2r5OuMuUQr0k4A6KZk8E
Message-ID: <CACd_6n2vT8RiWGL6g2aasEgzpdnOFz5NnwF42vwzO0gEd=cu1g@mail.gmail.com>
Subject: Re: [PATCH] nvme: bound the freeze drain in passthrough commands
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_152903_231271_24634733 
X-CRM114-Status: GOOD (  25.15  )
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

Hi Keith, Christoph,

Both questions land on the same point, so one answer below.

Keith wrote:
> The IO timeout callbacks that nvme drivers provide are supposed to
> forcefully reclaim any IO no matter what state the device is in. Is
> that not happening for some reason?

Christoph wrote:
> Note that the blocked message itself is not a problem, but around
> this time we should have done a controller reset and fixed up the
> issue.  Does that not happen for your test case?

It did happen.  nvme_io_timeout was the default 30, and the relevant
dmesg from the campaign that produced the hung-task report:

  [ 44.220408] nvme nvme0: I/O tag 451 opcode 0x2 (Read) QID 1 timeout, abo=
rting
  [ 44.220798] nvme nvme0: I/O tag 819 opcode 0x1 (Write) QID 1
timeout, aborting
  [ 44.220820] nvme nvme0: Abort status: 0x0
  [ 44.221286] nvme nvme0: Abort status: 0x0
  [ 45.591197] nvme nvme0: resetting controller
  [ 46.307151] nvme nvme0: IO queues lost
  [...100s of silence...]
  [144.561596] INFO: task systemd-udevd:134 blocked for more than 123 secon=
ds.

Timeout fires, abort is accepted, reset starts, reset reaches the
"IO queues lost" branch (drivers/nvme/host/pci.c).  Then nvme_reset_work
itself blocks at

  nvme_mark_namespaces_dead -> blk_mark_disk_dead -> blk_report_disk_dead
    -> bdev_mark_dead(bdev, true) -> sync_blockdev -> folio_wait_writeback

i.e. the unconditional sync_blockdev in bdev_mark_dead's bare-bdev
else-branch (block/bdev.c) is itself waiting on the writeback that the
reset was supposed to drain.  The reset_work kworker doesn't show in
this dmesg because it crosses the 123s threshold ~25s after the
snapshot console was cut.

So in this report, the IO timeout did its job, but the reset that the
timeout kicks off cannot complete, and nvme_passthru_start (which is
already in nvme_wait_freeze at this point) has no way to back out.

Two reasons I still think the bound in passthru_start is worth applying
on its own merit:

1. The reset path has several ways to fail to drain in
   nvme_io_timeout: abort can be rejected, the admin tag for abort
   can be unavailable, the controller can be wedged before abort
   lands, an in-progress reset can outlast nvme_io_timeout, or (as
   here) reset itself can block.  Each leaves nvme_passthru_start
   waiting forever, holding ctrl->scan_lock + subsys->lock + every
   namespace's freeze ref, which then fans out on bd_disk->open_mutex
   via any concurrent bdev_open/release or BLKRRPART.

2. The same pattern is already established in the tree.  pci shutdown
   (drivers/nvme/host/pci.c), nvme-tcp reset, nvme-rdma reset,
   nvme-apple, and Daniel Wagner's 2021 nvme-fc series
   (20210818120530.130501-1-dwagner@suse.de) all use
   nvme_wait_freeze_timeout(NVME_IO_TIMEOUT) for exactly this reason.
   nvme_passthru_start is the only userspace-reachable caller still
   on the unbounded variant.

Christoph also wrote:
> So not blocking forever sounds useful, but this might break existing
> uses.  I guess we could do it based on the O_NONBLOCK flag if people
> really cared.

NVME_IO_TIMEOUT is already the bound any submitted I/O can be
synchronously waited on; a freeze drain that legitimately exceeds it
implies the controller isn't doing useful I/O anyway, and
nvme_core.io_timeout=3DN scales both knobs coherently.  Drain on a
healthy system is sub-second.

Gating on O_NONBLOCK is a reasonable fallback if you'd rather keep
the old default, but the nvme ioctl path doesn't currently consult
fd flags, so it would be a new userspace contract.  My concern with
the current default is that any of the scenarios above lets a
userspace ioctl wedge a kthread with two ctrl-wide mutexes held; the
+9-line bound prevents that without changing the success path.

If the maintainer preference is the O_NONBLOCK gate instead, I'll
respin.

Thanks,
Chao

On Wed, May 27, 2026 at 11:46=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Wed, May 27, 2026 at 01:59:23AM -0400, Chao Shi wrote:
> > If a completion is silently dropped or the device hangs, the calling
> > task wedges with ctrl->scan_lock and ctrl->subsys->lock held, fanning
> > out into hung-task reports on any concurrent open/close/passthru on
> > the same controller:
>
> The IO timeout callbacks that nvme drivers provide are supposed to
> forcefully reclaim any IO no matter what state the device is in. Is that
> not happening for some reason?

