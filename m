Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7432ACD5BD5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 21:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ygleTelCqI5oqapwk6Og8dhDrlXNgz7gDtcSwArrBbE=; b=IKlwKyj69bYZyrXwwbKo8f7tG/
	hClPd21ktmnJD5T/qv/CgWNdFHMDnBs1qupjLnVjcCLLvPk01H3Un9qkVPWX9nzzyk6oanD1vJMBC
	1nsnFz5w+C8iSFg4F1ajOWJBQPCteKEyYxCVdmriq/emumguCCfvKhNcOaNAKdJQiYhu72M2BL9sj
	VTcR3qWCjg5vDWnP/+YrHe8PvL+KOHpRsUvOzMofaEbuxJ1OUhVKn4N8j6HkF/RkVOTLQtiKP7BcZ
	htzrijmVh43Zi5+wiD/rI8DCrjtreF7icV7NvaKZON+A/6Atb1VbuSPLxi6rhX5Ftydhy0HNGLWoZ
	mmuzaYUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRzhQ-00000002zyu-3KIS;
	Tue, 26 May 2026 21:52:32 +0000
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRzhO-00000002zyG-2GUt
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 21:52:31 +0000
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-43587e63a8eso6965186fac.0
        for <linux-nvme@lists.infradead.org>; Tue, 26 May 2026 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779832349; x=1780437149; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygleTelCqI5oqapwk6Og8dhDrlXNgz7gDtcSwArrBbE=;
        b=szKrRiTcb5WJhsv23lilrnImsWytva4TbT4NMQk7jXPzWWb2eyNlmp2/32LDN3LLEi
         Vrh4MN079hAJrzNt5MkrdeeKYuHFqPKI7qA0zc84cJl7znRNoFmBO3iIPM0cw3JLSwU3
         nOMzh7OMxzIp5I1NjfvDJ/iwtG5ZJTcicUYfkNsgUQWB7zdzg4YhWQRBy/ObAMnKQrqJ
         XdHXpzs5LapqWZ/sKhOGwy+hPJfL9clNEUdPHoZAf2MD7FE+pbonku4UtlN2g2E9ao/M
         aCRxWyJa7KDDRlFRfZuLcJaQSzXQ4xzMv8HaWfczwPbkz7up3hv0Tg3tO80tyYmD7Flk
         wFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779832349; x=1780437149;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ygleTelCqI5oqapwk6Og8dhDrlXNgz7gDtcSwArrBbE=;
        b=F+Oh0PoPmuc7Kcgyo37kAwtBusIvhojh7jogj82LQ0KvosmY6zztxL+geuY84qPLxf
         6koBCe1N7d5kPXxPUlOYACU/BN8arZvELed1jsvTd6bulShLoYfYQjAH+h1r/VEeVOiU
         y1tT6xRm0R8iVEI1ELeMgKPCrMSdJJuTqtciKX7PArSrtK2UeRnrL+Nf/czjwms8tG5K
         0/oR7mHABBgciCSrvMnjYMlyLX4vosQriAtGYICfBXlM2Uxn2SzvuyCk6kDyPuJ6uWlQ
         6y2Aq2ujGmEskgkZaoQsfozr4BXnL+dP7aPfA5SN7Us9xAR690H3JQL5rhYmirtIH6Tg
         roEA==
X-Forwarded-Encrypted: i=1; AFNElJ+AXZPHNoU1mMkF9lD/7vaUVe/eJUEdjqMSyhI9g+0JgdP23AMo/I1lnneG7IQG/FECJWbBHsatHDT6@lists.infradead.org
X-Gm-Message-State: AOJu0YyqMBHtIMwtM196Z7kN/SVbJAOHx/FcwEGR1GxjlnX1MS19efRG
	tlrQAfdu/BUnmCae8Zl0QpFtYBdFHzPHuXghb2HFgoZr3UtFgeCwCHURg0xn10ylHQg=
X-Gm-Gg: Acq92OEtOt5paIEBKXSJcXe7LLTD6OFPFkR/fET4xY8YpHEIFhg3vnEsq+SrIYhQjon
	zORM5GGymKq8Nb+miVNEMnOKPymp34bxqmPRQxnnrpMh2Uh7iREvxKMBIKnUg6Z2PHCkz6vVRU+
	FbdH7S5zfG2JtzdAped8sMKCaxSu4MpRnTeaC4BaV218B1K685nbn9xsArvYLYV432lN3NG/7z2
	TRiBN9fygsln40X3ZZTpBsrcBvcGmsha212SJZgcdVycyoujnbKVuHwNU8rThcrLTHMPW0y7L9m
	DUKUfXgRgLT0XnDCyj66lz7+a7ZpjT1CVSvDj/XjVbxx8jMt1IIc8h68B9aV1uln5IZFJQPNDYn
	0W++NB1Bn+mdoufxyNe5JA1atrqOfRhL3qnVgcJqn2Ln+7UBXd2xMREGoLm6UXKV/HL5Qzom+K8
	AKH60G3hz/912Yki06cFBa+wfT9u7+ui6Q8/5YemcS5MFIeK0uy0pSxECs34EhmWcCUEthjiu63
	9+EKuJv7BvaUQ==
X-Received: by 2002:a05:6870:88a0:b0:42f:c1ea:f19d with SMTP id 586e51a60fabf-43b5aacfaefmr11826864fac.10.1779832349406;
        Tue, 26 May 2026 14:52:29 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639725a5sm14453746fac.10.2026.05.26.14.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 14:52:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: song@kernel.org, yukuai@fnnas.com, linan122@huawei.com, 
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
 linux-nvme@lists.infradead.org, kmodukuri@nvidia.com
In-Reply-To: <20260513185153.95552-1-kch@nvidia.com>
References: <20260513185153.95552-1-kch@nvidia.com>
Subject: Re: [PATCH V4 0/3] md/nvme: Enable PCI P2PDMA support for RAID0
 and NVMe Multipath
Message-Id: <177983234828.663325.17778666619930426072.b4-ty@b4>
Date: Tue, 26 May 2026 15:52:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_145230_588332_9F33A1FB 
X-CRM114-Status: GOOD (  10.26  )
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


On Wed, 13 May 2026 11:51:50 -0700, Chaitanya Kulkarni wrote:
> This patch series extends PCI peer-to-peer DMA (P2PDMA) support to enable
> direct data transfers between PCIe devices through RAID and NVMe multipath
> block layers.
> 
> Current Linux kernel P2PDMA infrastructure supports direct peer-to-peer
> transfers, but this support is not propagated through certain storage
> stacks like MD RAID and NVMe multipath. This adds two patches for
> MD RAID 0/1/10 and NVMe to propogate P2PDMA support through the
> storage stack.
> 
> [...]

Applied, thanks!

[1/3] block: clear BLK_FEAT_PCI_P2PDMA in blk_stack_limits() for non-supporting devices
      commit: 7882834048f110931275357db60dccff906dc96a
[2/3] md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device
      commit: 02666132403aec8fc5de315002894f713ef17dbc
[3/3] nvme-multipath: enable PCI P2PDMA for multipath devices
      commit: fb0eeeed91f3236133383445fee5cc8f20330e6e

Best regards,
-- 
Jens Axboe




