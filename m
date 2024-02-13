Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAEAC4829A
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 15:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vN5eKHGVSgawoTY3SWmxYK09q/xOBPXGRM+bDmNYIQY=; b=ao/QGanyt+TpKzvxCfHf3tEaBL
	Cl/ILQm1EF2NIUbJoEJ5BfC7VQse3ASZu1PYvp15cHa/fP4l2qs66lyXlvnBlMABrf+Co8XL9xY+V
	CTtjqhYGfiS84YpraPcuOtluZmrrJ7QqG3v1kP7is5XHCxCTJobjcwmcowa9q24Xm6ecEhb0L+dEG
	Bn0MF89/KA1RtVLP4JAwOsOR4rkCCT64xqMXkF4YPpjhNvK1/oyqdJHLI0GmM23TSWbHfsTl/mfX7
	tc4d4Hv0Ljl2JHfdojyvX3h+j/qpXyG41q4AtaRC3msBMRWXVsb0EIMVlRxLhzBUWrf0Cw6WEUrvF
	nic6+cyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZv9u-00000009qwC-1DPE;
	Tue, 13 Feb 2024 15:57:22 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZv9r-00000009qtU-27be
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 15:57:21 +0000
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so45664039f.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Feb 2024 07:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707839838; x=1708444638; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vN5eKHGVSgawoTY3SWmxYK09q/xOBPXGRM+bDmNYIQY=;
        b=c8PKTkG84vcdHyQEFu+11a2q+LbwSC3FKZcziOXspZZbbYnCkBJqmI3m7tHBJqzAzf
         yMZwz2EBrgqEHDWfbGtsboJc7tQz8/WuNbNxiy/A9FGiIyxzh52tFZJYfkaAOdJV8ZCO
         QYIXi85xVoOS021QLHeXneOgHeo9Ah3fEGT+OJHWAAICFfjbrUUeLk3LjGDiXE9I52gv
         JVrPGg8OY3AdrGQLGk58g66mzepjWJLEkMhkyiKaPXAoq17hAcFrW5qnaPso96n3/Ecb
         UZFtKueWmI4JdnedTeJWrS6kyFgItaySS9vRLEhazIibU7JUsku0+O1uQKd1fjm2sMvG
         R99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839838; x=1708444638;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vN5eKHGVSgawoTY3SWmxYK09q/xOBPXGRM+bDmNYIQY=;
        b=Z2f9HxUXnpsmho8OzNAq08vKMeckfBJXHGblQ5TWfzRVIXOhVp47pyCdTPIdBIM4Jb
         Uw0f8eMLGc6ODCVxdCkdXlvrph7x9IgwZEhFejlWsomgC0dPDp29IdJIKHtUKkac7yfT
         O7gNTe2r339FIvMmK2fcg3KjtLRgTiDsdKC60EiNN8tGSTp0D4IBjN60litjw+zRonty
         H74Xgn7Or+v107WryOQmLgRigPg4L6EjPcuTEcz23JgFlgT6jXJmGsLUmM3M3w/OHMo6
         QMdz3cpezMNngqgqXyuhFPqH1ki9BcdrjTK90ThbeSHQTUpFM6tCgrRATt+MsAQDNQdR
         jfmA==
X-Forwarded-Encrypted: i=1; AJvYcCWKZbIliSBLeKrBK7um1KcwYnZvPsM0qvVlO1G8FF+d0vKGX6H71rHT/rz3bRTBcDW0efJTy2f5emvIt7rXeDHOJXEFttUUOKaxSJKxGPI=
X-Gm-Message-State: AOJu0YwAlcz515ldAYntDwRW4iMWeTeEXVIdK3rC8/YlH23q3NqetHwy
	5Heu3cGBEasjnwnkxnbqI6O9dOERmDELXPWe1b/NWC8VIXndAvpWTBgCmUV0dEc=
X-Google-Smtp-Source: AGHT+IGgMwma2C5QAYcywSLRlJgLRzpaImivZzVNozyBL2RlrEaVkWjg5keKGVmbB9X09MzWv2zgEA==
X-Received: by 2002:a05:6602:52:b0:7c4:79cc:c4b3 with SMTP id z18-20020a056602005200b007c479ccc4b3mr127394ioz.0.1707839837914;
        Tue, 13 Feb 2024 07:57:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfmmNxnzDR6X1L18NCRNq2bEgAFab+05bRr/w9KpA3kXL9soT+amXyQP3RtOxQFTjcpwkrsP5hxaEBcESTCxUXkgxNo+mwEDjeCINg8/IW8hzfWjxTIecrcTdIP/jWYynMzMGq4QcmTl/GD+cFORO59Btp/nkxnoIbZEJytUv28LYH/O1ETvUVankyKCLz9JepJfR72W8KOLt1nwtmlZT7Enbac4jgxo75p9MC/uZ5fUqpyjjV3dRbkZJKVGf6Cf1tBlZhzLq2E9xFowquc+SH4jqPlDsmskdivkImIm748XSEDcvafoeENngNiPqs4kY3lfUp/H5xvre2uTjwByD0yFEIKBX345RHHdL+1zOGp0iaVPNYW2hNywHjRqNTwMg8yLvhsgXEnEg59EKfpXO0pCczVOv8jRrR3ws=
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id da2-20020a0566384a4200b00472c62c7d74sm1983220jab.149.2024.02.13.07.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:57:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
In-Reply-To: <20240213073425.1621680-1-hch@lst.de>
References: <20240213073425.1621680-1-hch@lst.de>
Subject: Re: atomic queue limits updates v5
Message-Id: <170783983686.2333153.11971285922494532518.b4-ty@kernel.dk>
Date: Tue, 13 Feb 2024 08:57:16 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_075719_585255_4611A254 
X-CRM114-Status: GOOD (  10.98  )
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


On Tue, 13 Feb 2024 08:34:10 +0100, Christoph Hellwig wrote:
> currently queue limits updates are a mess in that they are updated one
> limit at a time, which makes both cross-checking them against other
> limits hard, and also makes it hard to provide atomicy.
> 
> This series tries to change this by updating the whole set of queue
> limits atomically.   This in done in two ways:
> 
> [...]

Applied, thanks!

[01/15] block: move max_{open,active}_zones to struct queue_limits
        commit: 8c4955c069ea3b77dc63b55d13afa9341e894849
[02/15] block: refactor disk_update_readahead
        commit: b9947297d00b9c75b271db88165e39c0208bec2e
[03/15] block: decouple blk_set_stacking_limits from blk_set_default_limits
        commit: c490f226a0ea22639e81ac34edc884e238ea955a
[04/15] block: add an API to atomically update queue limits
        commit: d690cb8ae14bd377d422b7905b6959c7e7a45b95
[05/15] block: use queue_limits_commit_update in queue_max_sectors_store
        commit: 0327ca9d53bfbb0918867313049bba7046900f73
[06/15] block: add a max_user_discard_sectors queue limit
        commit: 4f563a64732dabb2677c7d1232a8f714a18b41b3
[07/15] block: use queue_limits_commit_update in queue_discard_max_store
        commit: ff956a3be95b45b2a823693a8c9db740939ca35e
[08/15] block: pass a queue_limits argument to blk_alloc_queue
        commit: ad751ba1f8d5d4f4f4b429b552a154e888524a93
[09/15] block: pass a queue_limits argument to blk_mq_init_queue
        commit: 9ac4dd8c47d533eb420af6a679e66ec74771125c
[10/15] block: pass a queue_limits argument to blk_mq_alloc_disk
        commit: 27e32cd23fed1ab88098897897dcb9ec2bdba4de
[11/15] virtio_blk: split virtblk_probe
        commit: 718628adfcfdc80466eb42cd9c615d1d5514f74c
[12/15] virtio_blk: pass queue_limits to blk_mq_alloc_disk
        commit: 8b837256560c783415b42748959900befcde2d00
[13/15] loop: cleanup loop_config_discard
        commit: 65bdd16f8c72bb2178f5e4db40305bef6c96b309
[14/15] loop: pass queue_limits to blk_mq_alloc_disk
        commit: 02aed4a1f2c355e41d82a8e9831031ca9e0eb45d
[15/15] loop: use the atomic queue limits update API
        commit: 473516b361936cbc27d7728df649a5b3094b6170

Best regards,
-- 
Jens Axboe




