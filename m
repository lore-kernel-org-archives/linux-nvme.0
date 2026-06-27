Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA34EC43327
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2026 06:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eDhSqgeSsmOMGL+q4n2G7rVfqWeNyMvzos/MllXGj4U=; b=qGLI8SEtkQetmypHai4uk9BmBg
	lFS6xnUoC5iimeBokbo1dEvvIViaAitREEDEgKbiroFVpJEdKdLBFdOH/hOdunhXLonu5P3Aa+LdW
	emgpTZYP1TVURybcBovpRehdqbtQPzW4vUpYgT/f65nAR+JzjIhjdXVSA37Sn5boy7oFKb1AvLoBy
	IG+7HPI8bbFY7djwNd8mcSAPS4MvxC2lgCGuwU77obHELln9ZkLyvDX3G6kIH/n7od+eRqxqz+5Hz
	g3h9SNdBp6jyXyaBAc9Ig0nQhh5mRk7AmV2S0f2Maxylt9uz0QzdcmFTD8GBOiiEXsUhQhqXc1fSw
	t+cYeuOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdMOE-0000000CC4d-45Wy;
	Sat, 27 Jun 2026 06:19:42 +0000
Received: from mail-pj1-x1061.google.com ([2607:f8b0:4864:20::1061])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdMOC-0000000CC3P-2dfL
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jun 2026 06:19:41 +0000
Received: by mail-pj1-x1061.google.com with SMTP id 98e67ed59e1d1-37e12797b6eso145274a91.3
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2026 23:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782541178; x=1783145978; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eDhSqgeSsmOMGL+q4n2G7rVfqWeNyMvzos/MllXGj4U=;
        b=VuKSNkKIygh4057H0Li3XZH3bzaY7WeUvk5ssmyMsaYHd1DAAlMPj8PtNFG5/c2Xg5
         zCmw9tGZk99mcbQIKVsMJWfnqaCu02SFfRKNL4mdRBcSyixBUQcuO7N8q4xOhrh3IjM1
         kFGU1V14WmWFoJfTjCMUl6GbtJJtUxdptDLzdqoN8KjCTTVkQ8+xfPJNHU/Eq6yge55W
         C9zzfaJghFCaVDoOxezlC0upC/PPlM0mNxWebvLs7tgAKNlcuDkS6fzYTYW0aUdyAxbx
         aWzkoaNv7RiORuZ9oLdG8my/CJfbu/Bd/JGCyhSIiV5pg6J6ZL7VgS2eSuXKvyA/1Mgz
         aM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782541178; x=1783145978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eDhSqgeSsmOMGL+q4n2G7rVfqWeNyMvzos/MllXGj4U=;
        b=HK8H23ntE5tLxFfBSa75hZvLLLyWVmC6n9AQXsB+LgnDixWHUni+LwWy7LRX6UIFff
         grExi9iRjSiwEDTpYaiM0PNlxdCaM1FnGx2Ntw5hs/RbwEdv2IE+Vl0l4jwrH94S1nX7
         ORmnSp68kEDeWF0/fGGgTvmQy08LZADGlXiT8TLM01DWrRuLtDV1gqXTpUC+fb7MXNyC
         Q2CdWVwKx0hYVAc+gCHegjoOM8NC3BEmeXYWYHla2avIh4Kz63e+DP/Cz6NNdDvcS5z5
         5+vdc0gE9F5yt8vs30cd2s6seNAfirUGXbz6P0Dx4SRx3KV7y1SlA0SlaFCgHX+ubMs0
         bJfg==
X-Forwarded-Encrypted: i=1; AHgh+RrPG7eSOlVHUG3U1LsvAYvgPMn4EKoWzVVb11DlkHQO3s/BO5z/SP6wssWZJ99i2R1lP97ORyejAr4B@lists.infradead.org
X-Gm-Message-State: AOJu0Yx1tmzoRQhEcr92u0mMAc8VlI4Mzf2uTfddUEmaOKUzc/CAlocz
	KGzFlOTqpk3oSgHDBzglwBHWKxuV7X5vKDtilCz0vtbL4MImCuQ3CrIu1ofk7C3Qf2KJOgX0x2Y
	axfbEFDZu0vQIPJTX4+pdjJRcAiPIExdjybQC
X-Gm-Gg: AfdE7clls1SNENZdJK81Ax4GghzYh+IWjmHBQT+BO1ZG2/USF/rYVl1zXnLUt9Zvr4l
	G0LSjHOhbMCkGCRKQayqphaOXuNeH1nPyRFuKrbWA9/7pzXprbJE43L7staX+wpSyXaAB61uDdg
	KRew3zffzEwrmg4VdK+WfyHEgMGKQb9/CiJNcG1toDPs4W0rrnHQ3wKEd6W1ePW2PBSlEUgZkGo
	/JSKghiSbKzvgRAIUut2DdwSfT04pjh55ZooosmkEm0ZTwT+wKkL6/7BUSbSpt/ypq2+d7ya/LS
	n0G24Y6msShjELE1A9k5H1P1NL65er+pFeu1FjDkceUj8FoCq6hp1+X1Y4ubzXN/xgZf/5/ulli
	yDdrQVr9F5ghPg9DCncxb8lwgvRSv80SONI9LamWbRPk=
X-Received: by 2002:a17:90b:2886:b0:36d:cc9b:2f60 with SMTP id 98e67ed59e1d1-37dfa27d18amr4991337a91.4.1782541178343;
        Fri, 26 Jun 2026 23:19:38 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-37fc2abbd48sm47306a91.4.2026.06.26.23.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 23:19:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 9E1C240146;
	Sat, 27 Jun 2026 00:19:37 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 986B7E40789; Sat, 27 Jun 2026 00:19:37 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [RFC PATCH 0/2] Avoid software ref tag remapping for NVMe devices
Date: Sat, 27 Jun 2026 00:19:31 -0600
Message-ID: <20260627061933.2187447-1-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_231940_671353_7F885326 
X-CRM114-Status: GOOD (  13.54  )
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

Currently, each bio has a reference tag seed which is used to generate
the sequential ref tags in its protection information. In principle, the
ref tag seed can be any value as long as the same value is used when
blocks are written as when they are read back. However, some devices
(e.g. T10 DIF) require the ref tags to match the low bits of the
absolute integrity interval numbers. So the block integrity layer always
"remaps" ref tags to absolute integrity intervals using
blk_integrity_prepare() on writes and blk_integrity_complete() on reads.

On devices which do support an explicit "expected initial reference tag"
field in addition to the logical block address on each I/O, the software
ref tag remapping could be skipped by just passing the ref tag seed as
the expected initial ref tag.

Introduce a BLK_EXPECTED_REF_TAG_CAPABLE flag for devices to advertise
support for an expected initial ref tag. On devices that set this flag,
skip the block integrity layer ref tag remapping. Also take care not to
merge bios with non-contiguous ref tags, as the merged bio's ref tags
would no longer come from a single ref tag seed.

Set BLK_EXPECTED_REF_TAG_CAPABLE for NVMe devices and plumb the ref tag
seed (if provided) to the NVMe Read/Write (E)ILBRT field.

One potential concern would be NVMe devices which already have ref tags
written by an old kernel, which did perform the remapping (persisting
ref tags set to the low bits of the LBAs). When a new kernel that skips
the remapping reads back the ref tags, it would expect them to match the
ref tag seed, which would fail the ref tag verification.

Caleb Sander Mateos (2):
  blk-integrity: add BLK_EXPECTED_REF_TAG_CAPABLE
  nvme/core: advertise BLK_EXPECTED_REF_TAG_CAPABLE

 block/blk-integrity.c         | 18 ++++++++++++++++++
 block/t10-pi.c                |  3 ++-
 drivers/nvme/host/core.c      | 20 ++++++++++----------
 include/linux/blk-integrity.h |  2 ++
 include/linux/t10-pi.h        |  5 -----
 5 files changed, 32 insertions(+), 16 deletions(-)

-- 
2.54.0


