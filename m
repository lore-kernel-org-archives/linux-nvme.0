Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208DEC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  3 May 2022 16:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s39mE0kiqCYA7ZYSMO88r6nrLoSeKkE/K4dp3BvGwGs=; b=aiU7WsnQw+DkE1EQqzEfykHc5F
	fB85z01aPKLjxaTynjF9ZlwXnxMrweDxPVS/TYDzaYEmMMhdNIpL0+XIIyKUDyYJ0wxt3ZYOkj+MV
	k0KvdPx4RSwcvruIZS+wxsxtWsX40nRJF/3bmPIZdV9o4kbwQe15mjhdelqIuDB68g/GTVKIKB8qs
	OQyYjnlpKG0zUC1xOveIw4Zn/EbtF0Zk8SikSnMNQIekEzWm/8GzQj5oE0LYIGNT5YoDX/1GSp+0Y
	/BiHjDcDu5Gd9BR0Ajz9cWZYAappbUH1CKcETgD56iEuIVeIdgtYbFFBwnfUqwp9NtJ/eAe+NoGqd
	96eIFYzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlvYQ-006mGD-Q4; Tue, 03 May 2022 16:39:14 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlvYO-006mEt-4I
 for linux-nvme@lists.infradead.org; Tue, 03 May 2022 16:39:14 +0000
Received: by mail-pj1-x1033.google.com with SMTP id p6so15825856pjm.1
 for <linux-nvme@lists.infradead.org>; Tue, 03 May 2022 09:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:in-reply-to:references:subject:message-id:date
 :mime-version:content-transfer-encoding;
 bh=s39mE0kiqCYA7ZYSMO88r6nrLoSeKkE/K4dp3BvGwGs=;
 b=pGDpCf7sl1d7573gjTTpqwkm3SiLycRrYLR/Cpm0xghxjpDf3AYMtstNaQt6JhXwCj
 hQ35tsdAS9xUuNcQ6bjTAIO4jrWGURYFn6WniUxLx9leI8Us/ZQXxmUsx5sXqR+3SMFs
 NPtnD8cP+Vrfqw+JIy3zA370Pyvn+VSXvM3gc7wLfoXTetostms9mgjy7Euc3hVJAm4j
 a9n45bGAUG8eOYOtc2pRDLYRKouGSmmTKZVBKYAG6yGnvzNVe7ulVhqBTMV0jNCtQJ1b
 eh8fwFdSJCS0763Fc+Es4Igf8he/A1M8/7QNTfbxn1mM2JdiBuUfp0c3rzGlnMqDUeCY
 VcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
 :message-id:date:mime-version:content-transfer-encoding;
 bh=s39mE0kiqCYA7ZYSMO88r6nrLoSeKkE/K4dp3BvGwGs=;
 b=AICgbOESSQXmDjOd56a99mV8lY/2nlVEMegk1azrjqITjf41gtnqlLyXWWX0NSpKp4
 HMyx7SppVJ5zZbLztXk0s1UrHGgIAf0/btthvFaTM7Ct9qhGJwnNyzbcui4aGcYWQ0fk
 DVgHAW0yrevQduVSTY1aQcT0Xzz07eJXyEuiBxdNFif2V6W+D+K+NKx+7oR0HSAx5p9a
 Dy4Mys2Kfy5ZNyOclCGZw3CekQp13wDKWpg2Ywc5xzZweMW8gtaRjxfI3GI9GN6v3H+C
 JhqXSz9w78CHoPr77kDvvr7ivqLbNjuA5IeXto4+efkir9ngoF0kclwfWU2J5g0HpkOS
 JHvA==
X-Gm-Message-State: AOAM531R4wfL3AUhSL2LAwAi5HT1nx85lr2TdhYakEGoSiekrUIwEQN2
 wwiZBboOrl4DyfyJCOsOOQZ4GA==
X-Google-Smtp-Source: ABdhPJynf+YKk08yAhS/p4BXstboFDeyZsD4FTBMM24xr+KLv+BRsvUdLzF1UAPk9hKAVzsu2Q8whQ==
X-Received: by 2002:a17:90a:9901:b0:1cb:aa19:5eee with SMTP id
 b1-20020a17090a990100b001cbaa195eeemr5645991pjp.158.1651595950265; 
 Tue, 03 May 2022 09:39:10 -0700 (PDT)
Received: from [127.0.1.1] ([8.34.116.185]) by smtp.gmail.com with ESMTPSA id
 m9-20020a17090a858900b001d9b7fa9562sm1559200pjn.28.2022.05.03.09.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 May 2022 09:39:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: mst@redhat.com, linux-s390@vger.kernel.org, sth@linux.ibm.com,
 martin.petersen@oracle.com, dm-devel@redhat.com, hoeppner@linux.ibm.com,
 linux-nvme@lists.infradead.org, richard@nod.at, josef@toxicpanda.com,
 virtualization@lists.linux-foundation.org, snitzer@kernel.org,
 roger.pau@citrix.com, linux-um@lists.infradead.org,
 linux-block@vger.kernel.org, song@kernel.org, nbd@other.debian.org,
 linux-raid@vger.kernel.org, johannes@sipsolutions.net, haris.iqbal@ionos.com,
 xen-devel@lists.xenproject.org, jasowang@redhat.com, jinpu.wang@ionos.com
In-Reply-To: <20220418045314.360785-1-hch@lst.de>
References: <20220418045314.360785-1-hch@lst.de>
Subject: Re: fix and cleanup discard_alignment handling
Message-Id: <165159594780.2557.1712299203175316151.b4-ty@kernel.dk>
Date: Tue, 03 May 2022 10:39:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220503_093912_448704_573AB309 
X-CRM114-Status: GOOD (  12.98  )
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

On Mon, 18 Apr 2022 06:53:03 +0200, Christoph Hellwig wrote:
> the somewhat confusing name of the discard_alignment queue limit, that
> really is an offset for the discard granularity mislead a lot of driver
> authors to set it to an incorrect value.  This series tries to fix up
> all these cases.
> 
> Diffstat:
>  arch/um/drivers/ubd_kern.c         |    1 -
>  drivers/block/loop.c               |    1 -
>  drivers/block/nbd.c                |    3 ---
>  drivers/block/null_blk/main.c      |    1 -
>  drivers/block/rnbd/rnbd-srv-dev.h  |    2 +-
>  drivers/block/virtio_blk.c         |    7 ++++---
>  drivers/block/xen-blkback/xenbus.c |    4 ++--
>  drivers/md/dm-zoned-target.c       |    2 +-
>  drivers/md/raid5.c                 |    1 -
>  drivers/nvme/host/core.c           |    1 -
>  drivers/s390/block/dasd_fba.c      |    1 -
>  11 files changed, 8 insertions(+), 16 deletions(-)
> 
> [...]

Applied, thanks!

[01/11] ubd: don't set the discard_alignment queue limit
        commit: 07c6e92a8478770a7302f7dde72f03a5465901bd
[02/11] nbd: don't set the discard_alignment queue limit
        commit: 4a04d517c56e0616c6f69afc226ee2691e543712
[03/11] null_blk: don't set the discard_alignment queue limit
        commit: fb749a87f4536d2fa86ea135ae4eff1072903438
[04/11] virtio_blk: fix the discard_granularity and discard_alignment queue limits
        commit: 62952cc5bccd89b76d710de1d0b43244af0f2903
[05/11] dm-zoned: don't set the discard_alignment queue limit
        commit: 44d583702f4429763c558624fac763650a1f05bf
[06/11] raid5: don't set the discard_alignment queue limit
        commit: 3d50d368c92ade2f98a3d0d28b842a57c35284e9
[07/11] dasd: don't set the discard_alignment queue limit
        commit: c3f765299632727fa5ea5a0acf118665227a4f1a
[08/11] loop: remove a spurious clear of discard_alignment
        commit: 4418bfd8fb9602d9cd8747c3ad52fdbaa02e2ffd
[09/11] nvme: remove a spurious clear of discard_alignment
        commit: 4e7f0ece41e1be8f876f320a0972a715daec0a50
[10/11] rnbd-srv: use bdev_discard_alignment
        commit: 18292faa89d2bff3bdd33ab9c065f45fb6710e47
[11/11] xen-blkback: use bdev_discard_alignment
        commit: c899b23533866910c90ef4386b501af50270d320

Best regards,
-- 
Jens Axboe



