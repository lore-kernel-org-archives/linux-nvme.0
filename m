Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD28C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 19:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TNgXDagmfKUDRlIb0VEHQynm6l6+nQUUXVeVADbVheU=; b=rPHFB3lRXRkKASM734gHgmU+kd
	0DbfKu7xL33kgbmO6MJ+XGz+H4Ehc2Mu+xgVdSM4Yl3Hfv7ar1Qlb8mXbzJjvLjWg9UPBdShWM8WL
	+1kOpY/L5OTMmv7EMPjkah/z2pl4u7XbmKR62NApvTjDTZ2p4bZjqtoTIoXolrSeiQ15zuzf4Subu
	e0GhSQSDHxKHaAG5qcZ8wHFkoRP+7tXu6exe3PrroukjAvg8oXtJGTbBkS9wy25Uh6MrAj4wEX36D
	1T0o3Z6NJdWC8M33N6CZn3zo+jnqnKVkkQrmQchQa7VVgbkx6cDnlI9EfWZ7Kpn0DE8dkDxHH+VlT
	CePwQecg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whu09-00000003L71-2EXi;
	Thu, 09 Jul 2026 19:01:37 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whu06-00000003L5v-2Bix
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 19:01:36 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso213758a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 09 Jul 2026 12:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783623692; cv=none;
        d=google.com; s=arc-20260327;
        b=fOe3SoNZdhclXhnpLDM8KLy0B1yaE/nwq2hyPDQZW1A0Y6b5Gn4PCFhtx0JPzok+6Y
         cvOthjgjFYLTowNcK1CXvWS6mQPgTgBiEIDkAmhiwtAyvucLqrlHsMYiNpaD/VknRn5V
         2oGKNC3+Rb+sNC0ZdH2ZrGtQsJ7UuZSm3fgnFpWqafQbTEgrWHcj8GTkFMbJVCF4qz1k
         5L1FWJfL7gFEEr8OTRr1rZYvSMZIZ8sjb22DjfE0JiG8vJZ4vyh44NGTRj/klgjZJLEm
         O646JskCCVFv9CnVaMKIXVnhlItKW4pCFnc59yHs6eQLuVtbht62nWrMwp+PmdCRiOU8
         O1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TNgXDagmfKUDRlIb0VEHQynm6l6+nQUUXVeVADbVheU=;
        fh=GK/8eDLyoJpWt5qCPUSjj96hWNboabjeH3nEJvm8ai0=;
        b=QXD3FIdrrxWPB935c00CGX/YeLzHZGef5mGFV4+U9ZD1hCrm7MITdcbBdwNTImxgkF
         65Xv6l4gvTSkVEImewnSyvLONaPIbNTn9X6aItgf1IcF+uswjFZvTgGk9eBltf15v4ks
         oRTv1I6+OHTQUI6/rQzBBUQ1wLVLug+ebs6c9Ycxa+mRQm/KABiFaRALdMDtrCLfv3Mw
         TLAvkXMFHTfjRMKBxAQSEhvKjP6fWdDiXvZYvCXmLVKHxiynLSuAIafnxx1ObtSg4HXr
         SRjCrEJLGb04whx5jbVXsfOHOZI84jCagrjzXG90v7QopY+qZSPuh8AEkF0NDzXsb4pn
         mySQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783623692; x=1784228492; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TNgXDagmfKUDRlIb0VEHQynm6l6+nQUUXVeVADbVheU=;
        b=euIcskZUE9I7g4PFlMpAUx0eAK1r8r7MwwYZmmoW4tqbax31bwPs0lMpE/dzOFxGYb
         Lg/RGVa7pMZb2OwgI4/l83mTtUgvoGmkYWTrxs2aXD0aKVT0Rg2cuuaUn0XsQqoqwtcE
         Y+HSxbpDPFUPBxs093+ittfRvjod2Wq8KxKnEDnkPU+Sz6yjuNaxRIqeP5TmlN+NsYTb
         ZBjzXjAo+jQQf8iKALPQAqln8/HAi5WW5GDUFMFT6PXXaKX8zDVppI11CFJ7i2ztqqe9
         8Us6qgOZdeXHJw5MPGSByUt/ADBW5qgsjhdloNDfWUrVDHCT0JyShwY8bWpnON7ImNL4
         WsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783623692; x=1784228492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNgXDagmfKUDRlIb0VEHQynm6l6+nQUUXVeVADbVheU=;
        b=WrlEigsc+4h8mxx1WGDs/C+ehOnL9lfmz7neN3SVGbuiXCF+3HJmTS0DIB5IPRFzPJ
         o9RPmj+ycX8vTrnHsjwdmRrKePrAelYmlKv0PrvX4Qj5pNgZk7RweOrISJks9PnvGf+Z
         BBWwWwMpoVyjflb2QV+GP7KPanNBUu7mRfcqDPqNgq1aqPalpSkpyHxaVTB37O9WoMHs
         t1l5D4kFdrs7IqWsO7u48xBL1Pzx453mdXUip74KsZ0PhqFbY3K/YufDtT38IZT+Ho+n
         YkcZM0r0ieuA/oWNtiLubMrNlor88Ks9O7+VrPFw9mhhhW1zcnywC84ayt0aPFJKJlKQ
         rTCA==
X-Forwarded-Encrypted: i=1; AHgh+RrpfalgbGCf/6XgMPS74dahy8fhD71dhC1tLhwWi2rLEO+t38e6VEr1y09lgalx9APxcUPt0g6Ilk5q@lists.infradead.org
X-Gm-Message-State: AOJu0YwSwOMaQN6PhdlUoBhI7KsjWYF4ZVVvpkXHyHvqvcjU6F86ouzr
	fdzUv8PmLlVA6CVOvYDrLSNP1Lw/N76UEaEe9Kx/Ky9wocg3k/0GD8fIAmdRksxCQJp6ZU0BwP0
	tHU4P5tGkR2iilcf6NPSXKFbW0PLsqFI=
X-Gm-Gg: AfdE7ck3D8Os/Hkzk5ZVjzFYMTpUBGJnCHHZ9kIsN9LTIg5u5pNxC+LoQhP0Lllkbkp
	qaVprKbNyGI/JZbSKEKfz9vN2h4sptyp2OByqHXhV6KVPknSW+NnXjFxTKmNMQ638d7kvP3GHBm
	biiVOLMTwnGI5SuAYQHvcQSC56hhu9YrHqayXB1hianhQbwxSmTA0VjAfB2MFE7Ahquy/G3jHlt
	xE6I9aLLC1r2CVNtILUHelxlyQSpFlPc/N1qHNs/0tlwWxggF8nVpsfBAsWan9QHU3Cctg6
X-Received: by 2002:a17:907:6096:b0:c12:7e9f:5ae3 with SMTP id
 a640c23a62f3a-c15ce0004fbmr442068766b.15.1783623692221; Thu, 09 Jul 2026
 12:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260527055923.456769-1-coshi036@gmail.com> <ahcR2vy8k2FZAp9D@kbusch-mbp>
 <CACd_6n2vT8RiWGL6g2aasEgzpdnOFz5NnwF42vwzO0gEd=cu1g@mail.gmail.com> <ak_lyGi_2n9Qeikw@kbusch-mbp>
In-Reply-To: <ak_lyGi_2n9Qeikw@kbusch-mbp>
From: Chao S <coshi036@gmail.com>
Date: Thu, 9 Jul 2026 15:01:20 -0400
X-Gm-Features: AUfX_mznr7zKJVAiJjDKA7C0U2Wy02ynZ3_EbDP5ZKMxJUMcB2ez_jKJE1iGxkQ
Message-ID: <CACd_6n2N=r+-dBdKxbQbVi0+FVgKqSPR-EmqSdt=aTO2hAQyhw@mail.gmail.com>
Subject: Re: [PATCH] nvme: bound the freeze drain in passthrough commands
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_120134_598081_7471C06A 
X-CRM114-Status: GOOD (  28.18  )
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

Get it now, thanks for the detailed suggestions.

On Thu, Jul 9, 2026 at 2:17=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Tue, Jun 23, 2026 at 06:28:49PM -0400, Chao S wrote:
> > Timeout fires, abort is accepted, reset starts, reset reaches the
> > "IO queues lost" branch (drivers/nvme/host/pci.c).  Then nvme_reset_wor=
k
> > itself blocks at
> >
> >   nvme_mark_namespaces_dead -> blk_mark_disk_dead -> blk_report_disk_de=
ad
> >     -> bdev_mark_dead(bdev, true) -> sync_blockdev -> folio_wait_writeb=
ack
> >
> > i.e. the unconditional sync_blockdev in bdev_mark_dead's bare-bdev
> > else-branch (block/bdev.c) is itself waiting on the writeback that the
> > reset was supposed to drain.
>
> But sync_blockdev is *not* unconditional. It's conditional on this not
> being a surprise removal, and blk_mark_disk_dead() is considered a
> surprise, so I am not sure you've identified the right sequence.
>
> > So in this report, the IO timeout did its job, but the reset that the
> > timeout kicks off cannot complete, and nvme_passthru_start (which is
> > already in nvme_wait_freeze at this point) has no way to back out.
>
> I guess what may have happened is that the timeout handler requeued the
> IO  on a quiesced queue so it does reach frozen state. Just move the
> unquiesce to before the call to nvme_mark_namespaces_dead(). But I still
> don't think it should be needed because nvme_mark_namespaces_dead()
> shouldn't block.
>
> > 1. The reset path has several ways to fail to drain in
> >    nvme_io_timeout: abort can be rejected, the admin tag for abort
> >    can be unavailable, the controller can be wedged before abort
> >    lands, an in-progress reset can outlast nvme_io_timeout, or (as
> >    here) reset itself can block.  Each leaves nvme_passthru_start
> >    waiting forever, holding ctrl->scan_lock + subsys->lock + every
> >    namespace's freeze ref, which then fans out on bd_disk->open_mutex
> >    via any concurrent bdev_open/release or BLKRRPART.
>
> No, that's not what happens.
>
> If abort fails, then the command times out a 2nd time, then we escalate
> to reset.
>
> If we can't get an abort tag, then that means an abort is in progress.
> If it doesn't completely timely, then we escalate to reset.
>
> > 2. The same pattern is already established in the tree.  pci shutdown
> >    (drivers/nvme/host/pci.c), nvme-tcp reset, nvme-rdma reset,
> >    nvme-apple, and Daniel Wagner's 2021 nvme-fc series
> >    (20210818120530.130501-1-dwagner@suse.de) all use
> >    nvme_wait_freeze_timeout(NVME_IO_TIMEOUT) for exactly this reason.
> >    nvme_passthru_start is the only userspace-reachable caller still
> >    on the unbounded variant.
>
> Those are for entirely different cases where we're in the last line of
> recovery and have to guarantee forward progress.

