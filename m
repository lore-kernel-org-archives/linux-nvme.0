Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18404C6FA82
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 17:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jf1FYXrDVaqqC4NbZ8fFAHL8bcgUOrwJH0z7ee3/534=; b=DIzLvtHhZUM/S14wGH0iTnw8i7
	F+cdLOWzbf1a/jt/EEmOMF7dI6Lji4cmHVEbxVSwMDKXLtPq7y31J+8/wT0ldG2RMS4n0onSiLVfV
	5xlVSKY7PZ/DyH6nQBhwIEdluOSrvCZZnaI4uDiPkLO1DFzhrs8VA45yKo9cUeqfEKsc1qDCGBfOT
	KXV4QM3Y799XSwwRmpi6rA6mhLrZ6Svx2sE3NmByUsC8Jbr2on2P7v6/RqORkeTBWaoK78nCK0e8X
	oQigOeGEQywE9fAnZyOeBR1k8rdMGqU6dQDQLRik8aFVKkm4RsPhY8+gG6SePcuowXg4V5yaRaCAH
	qdUnzP4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ob3X4-00CBzr-Is; Wed, 21 Sep 2022 17:29:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ob3X1-00CBzE-FL
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 17:29:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663781346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jf1FYXrDVaqqC4NbZ8fFAHL8bcgUOrwJH0z7ee3/534=;
	b=IjCbQBBJPzk2Ul5LfZOQ9gwwmG28FF5X7F+K6/miqQE4WCMq3za5ccBfsCsCssSff+J0b1
	/PC5EtDEtjorQz9uBw+1dUtUmqpA/K3ol8PoBxfSQhDyvc+eiCrT+K9yWgvLUINlaR8Af9
	KYTcMu7k9AREWYogqHRQpVxLNZZUt1E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-379-8EtVyEaPNjqpR3OLMPJTxw-1; Wed, 21 Sep 2022 13:27:34 -0400
X-MC-Unique: 8EtVyEaPNjqpR3OLMPJTxw-1
Received: by mail-qk1-f200.google.com with SMTP id bs33-20020a05620a472100b006cef8cfabe2so4700371qkb.12
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 10:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jf1FYXrDVaqqC4NbZ8fFAHL8bcgUOrwJH0z7ee3/534=;
        b=UG2lue/1SdGRbyjDcvs08o2s3DSNrNDq1Wnu0ZeFxx1pVmr6kXbH6X3srcXxFqx0kR
         W2U96QrdusE/OqUzAC6Z6XMr/I1Lv3F/4rhQWRinxK+RIW6Lw02wGgCV+NiwwaD0bBEg
         pjFb13KVKIgd5JMYKZ7OHxKGmZQxj5UASUZt9XAk7TOug1ZihAGH1wcs/y+ft6fSKEWo
         F/YgD9VLtJXvd7A7pjUzbw1YTZFhgolgcvwB0717UYupqlFAwfGl7yj3qskys4BVBSxZ
         XyX8j6JJHOYJ2iw7Ea+qO/WVTfaUOEM2Sgm6vMQn6l6v5vxJVU6/gprIw8rN6BuXF9YC
         R5lg==
X-Gm-Message-State: ACrzQf1ykHSXXpXF7IHWQOlwUghCcLZd34uPGc34E8BGT4RChNm76uOR
	ohrFk9UQqaIPNVXCvY699SLD5vVt534/H6Spa4g7xtM9xXeN4XsE6KHYtamMkJUCswvTI10LuLR
	ZcZEGioAjgBoLdayhcR07wVMEQQ==
X-Received: by 2002:a05:622a:414:b0:35c:f297:ebfc with SMTP id n20-20020a05622a041400b0035cf297ebfcmr10981928qtx.420.1663781254254;
        Wed, 21 Sep 2022 10:27:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6z1zbB3AmadTPASo43OhmHFT6jpU/kArRwI7nXi7rFyLGyH8LCRodE1M4MYgySQ0l8v7sRqg==
X-Received: by 2002:a05:622a:414:b0:35c:f297:ebfc with SMTP id n20-20020a05622a041400b0035cf297ebfcmr10981905qtx.420.1663781253957;
        Wed, 21 Sep 2022 10:27:33 -0700 (PDT)
Received: from localhost ([217.138.198.196])
        by smtp.gmail.com with ESMTPSA id w23-20020a05620a0e9700b006cbdc9f178esm2196842qkm.25.2022.09.21.10.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 10:27:33 -0700 (PDT)
Date: Wed, 21 Sep 2022 13:27:32 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: damien.lemoal@opensource.wdc.com, Pankaj Raghav <p.raghav@samsung.com>
Cc: agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk, hch@lst.de,
	bvanassche@acm.org, pankydev8@gmail.com, gost.dev@samsung.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Johannes.Thumshirn@wdc.com, jaegeuk@kernel.org,
	matias.bjorling@wdc.com
Subject: Please further explain Linux's "zoned storage" roadmap [was: Re:
 [PATCH v14 00/13] support zoned block devices with  non-power-of-2 zone
 sizes]
Message-ID: <YytJhEywBhqcr7MX@redhat.com>
References: <CGME20220920091120eucas1p2c82c18f552d6298d24547cba2f70b7fc@eucas1p2.samsung.com>
 <20220920091119.115879-1-p.raghav@samsung.com>
MIME-Version: 1.0
In-Reply-To: <20220920091119.115879-1-p.raghav@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_102907_610112_B73C878E 
X-CRM114-Status: GOOD (  31.69  )
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

On Tue, Sep 20 2022 at  5:11P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> - Background and Motivation:
> 
> The zone storage implementation in Linux, introduced since v4.10, first
> targetted SMR drives which have a power of 2 (po2) zone size alignment
> requirement. The po2 zone size was further imposed implicitly by the
> block layer's blk_queue_chunk_sectors(), used to prevent IO merging
> across chunks beyond the specified size, since v3.16 through commit
> 762380ad9322 ("block: add notion of a chunk size for request merging").
> But this same general block layer po2 requirement for blk_queue_chunk_sectors()
> was removed on v5.10 through commit 07d098e6bbad ("block: allow 'chunk_sectors'
> to be non-power-of-2").
> 
> NAND, which is the media used in newer zoned storage devices, does not
> naturally align to po2. In these devices, zone capacity(cap) is not the
> same as the po2 zone size. When the zone cap != zone size, then unmapped
> LBAs are introduced to cover the space between the zone cap and zone size.
> po2 requirement does not make sense for these type of zone storage devices.
> This patch series aims to remove these unmapped LBAs for zoned devices when
> zone cap is npo2. This is done by relaxing the po2 zone size constraint
> in the kernel and allowing zoned device with npo2 zone sizes if zone cap
> == zone size.
> 
> Removing the po2 requirement from zone storage should be possible
> now provided that no userspace regression and no performance regressions are
> introduced. Stop-gap patches have been already merged into f2fs-tools to
> proactively not allow npo2 zone sizes until proper support is added [1].
> 
> There were two efforts previously to add support to npo2 devices: 1) via
> device level emulation [2] but that was rejected with a final conclusion
> to add support for non po2 zoned device in the complete stack[3] 2)
> adding support to the complete stack by removing the constraint in the
> block layer and NVMe layer with support to btrfs, zonefs, etc which was
> rejected with a conclusion to add a dm target for FS support [0]
> to reduce the regression impact.
> 
> This series adds support to npo2 zoned devices in the block and nvme
> layer and a new **dm target** is added: dm-po2zoned-target. This new
> target will be initially used for filesystems such as btrfs and
> f2fs until native npo2 zone support is added.

As this patchset nears the point of being "ready for merge" and DM's
"zoned" oriented targets are multiplying, I need to understand: where
are we collectively going?  How long are we expecting to support the
"stop-gap zoned storage" layers we've constructed?

I know https://zonedstorage.io/docs/introduction exists... but it
_seems_ stale given the emergence of ZNS and new permutations of zoned
hardware. Maybe that isn't quite fair (it does cover A LOT!) but I'm
still left wanting (e.g. "bring it all home for me!")...

Damien, as the most "zoned storage" oriented engineer I know, can you
please kick things off by shedding light on where Linux is now, and
where it's going, for "zoned storage"?

To give some additional context to help me when you answer: I'm left
wondering what, if any, role dm-zoned has to play moving forward given
ZNS is "the future" (and yeah "the future" is now but...)?  E.g.: Does
it make sense to stack dm-zoned ontop of dm-po2zoned!?

Yet more context: When I'm asked to add full-blown support for
dm-zoned to RHEL my gut is "please no, why!?".  And if we really
should add dm-zoned is dm-po2zoned now also a requirement (to support
non-power-of-2 ZNS devices in our never-ending engineering of "zoned
storage" compatibility stop-gaps)?

In addition, it was my understanding that WDC had yet another zoned DM
target called "dm-zap" that is for ZNS based devices... It's all a bit
messy in my head (that's on me for not keeping up, but I think we need
a recap!)

So please help me, and others, become more informed as quickly as
possible! ;)

Thanks,
Mike

ps. I'm asking all this in the open on various Linux mailing lists
because it doesn't seem right to request a concall to inform only
me... I think others may need similar "zoned storage" help.


