Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19286C531C7
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 18:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jvUC0Lia0it+LgLYsOXSPjeMnXEhLq3Hqn52LEDkVn4=; b=NLHbYCexzCM88xU6n0DvUf14It
	w9tLv/jhhhdD86SYMUDittVpMmgiqy9tepkiMfmyyyPJmgJM/IPClhwBE++095ChPZEaehrnblKYa
	vIm9ITUv/LBijaAlZ6X4O9NwEOu+W4Fxqv7Er0kY6DgmqnBE8Y1axSjFbbtHnpZZ3iAiXUqdrD1Ng
	CgT2sZBdyv4zZaoX2i8mwBxp9HsFdmP8IBy7ieA9nUB2HRbhxK4vHfANlp5Cr146L37FxTQ2n8hUW
	ZS9JRXLAJ2dj21qqPRn23cl8+AGmuQKwPxz67y0xAoIKqje9VIJlYugL1B77F5ECZvBF5Tl3XQsCP
	zuypOXGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmc9u-0000000Cajv-34FE;
	Wed, 22 Jul 2026 18:59:10 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmc9s-0000000CahP-1gKg
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 18:59:09 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso49401025e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2026 11:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746747; x=1785351547; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvUC0Lia0it+LgLYsOXSPjeMnXEhLq3Hqn52LEDkVn4=;
        b=Ff+GvQGGCgyHPQyW2ceW6+mL485dbKzD46WcB8v6DbCX6ODfCu+QvF/NCpG5/q+scZ
         EVG/b9G4DEweNGjw/CrfJVmTOnyhAOj0rfOeeBsVsBf4h3rAzAsdc+48KtDoKL2Zw6YC
         PaXBu4H/BFz/D0MhW1f33sxaQknCt6sGRx29RFIK/cy6bS8A1Ygfe5zCgg5I8fo20PeK
         tpTgnijncJqJGsZQG1qC80JDbqFCLekEX24ooQmTO2VHUWjMLHOeOQQbWD5Wt4i0Bbxf
         3pKr2PcNwJ3imyjoRgpYe8ot2l88g/dQwL2quRKqsN1h9ML+sglbxSBsvgQhzqarysCk
         2wgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746747; x=1785351547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvUC0Lia0it+LgLYsOXSPjeMnXEhLq3Hqn52LEDkVn4=;
        b=sgXu4L80547VfYBbLHDKOkoc0jt5FFuZfwAMhlseVBPip1Ai7RfCk2H6cguExZkRKZ
         bYSHEV9t5pqTa7MDsPlcoqNhN60IbTrOxX5lNCyfbNiH8fNgGFYE7j3RxEIazItV6k9e
         MPt3z3oxUUuWpykXYKadTOW2VKxiX/bPDL+E2/gj5IOqxLUUl9M7EyWBZG5BFmkWp/zv
         I49banFdRWyggZpWgEciPhKhNMb8QBfJNCS8zEiodWC/JSZMrZTsxNOsL/0mP/ugrdHn
         LpuBGo7TcGYVIA4OwkPHiCZdLNvl6qtVtW5mc0oNYGS/KJ0ySqNQGmIhrU7Yp7oli0Ai
         wOOw==
X-Forwarded-Encrypted: i=1; AHgh+RpNifkGeY2PAxDnpTH6KGKI7ShC72mKhLsYHe2jRIPskVqR5fvU0T/EGkH2rjWDVZFNg7Ia/Ac2kcow@lists.infradead.org
X-Gm-Message-State: AOJu0YytO/Y/soP9zouxNmZwiylCkiTYjTiwLuvk172J3WMsI3ZGCC4i
	zjY1LRxTcKz+m2Iv0xJZNjYXremimTaHVKk9SOLJyLLTWcPePd8xeKt2dV+iqXaxAQ==
X-Gm-Gg: AR+sD10I38CoPLL7JeFxf92HEN4uv7a8ISU4uWiRHhUbj+GJghS2u2bFa2cewYI1Apu
	dW9Ejg6uTntMCRqr6g3XjpE0z0JoiXEekH9fhTHNKW7So1YPEo//dDrE+PKFeSIqVEsg87IenkU
	lMHNku8YgGLouSG6cMBiLtxHIYIlNv4B95rZFeZfQl/mhHI62+IsdZqQRG5INAVPKl04z7dhcZq
	u/dFEph5+uABwdtE2LelRGpWm37Em2bHReUp88OVHBT/p/fx5GJ4KT+UQXKLR49EEYkXyyGgZAd
	vz6/d107iEjONugzOLt1uGiumNLJr8HV8RblYqXbAthJlhnyEAt2B7dMOySg0UF7qgINSU/W/TO
	5EKw0giJdusVpxAOhsYHtVHQNEMVPrD+0bRkWSbjpTFGgNELwFb+kcbXTrvneaxgg6V7T5pJmnB
	MSFSgdCPAOYGsOokPYmzAww1mP2svRgnR/vwq5tSuKq9SWN74=
X-Received: by 2002:a05:600c:2049:b0:495:6397:14b1 with SMTP id 5b1f17b1804b1-495639714bfmr108525535e9.34.1784746746655;
        Wed, 22 Jul 2026 11:59:06 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:59:06 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 4/9] md/raid1: don't use write-behind for P2PDMA bios
Date: Wed, 22 Jul 2026 20:58:36 +0200
Message-ID: <20260722185841.449934-5-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260722185841.449934-1-mykola@meshstor.io>
References: <20260722185841.449934-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_115908_469820_C334CD5C 
X-CRM114-Status: GOOD (  14.19  )
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

alloc_behind_master_bio() copies the bio's data with bio_copy_data(),
a CPU copy. P2PDMA pages are peer device (BAR) memory; generic code
must not assume CPU load/store access to them is safe or fast on
every architecture, and bouncing peer memory through the CPU defeats
the point of a peer-to-peer transfer.

Skip write-behind for P2PDMA bios: they are written directly to all
members, including write-mostly ones.  Ordering against write-behind
I/O in flight to overlapping sectors is preserved: the non-behind
clone path serializes on CollisionCheck rdevs (see the preceding
fix), which covers these bios like any other write that bypasses
write-behind.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 997f79c05db7..7d769b6460ca 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1523,6 +1523,7 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 	bool write_behind = false;
 	bool nowait = bio->bi_opf & REQ_NOWAIT;
 	bool is_discard = op_is_discard(bio->bi_opf);
+	bool is_p2pdma = md_bio_is_p2pdma(bio);
 	sector_t sector = bio->bi_iter.bi_sector;
 
 	if (mddev_is_clustered(mddev) &&
@@ -1575,9 +1576,12 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 		/*
 		 * The write-behind io is only attempted on drives marked as
 		 * write-mostly, which means we could allocate write behind
-		 * bio later.
+		 * bio later. P2PDMA bios are excluded: write-behind copies
+		 * the data with bio_copy_data(), a CPU copy that cannot be
+		 * assumed safe or fast on P2PDMA (device BAR) pages.
 		 */
-		if (!is_discard && rdev && test_bit(WriteMostly, &rdev->flags))
+		if (!is_discard && !is_p2pdma && rdev &&
+		    test_bit(WriteMostly, &rdev->flags))
 			write_behind = true;
 
 		r1_bio->bios[i] = NULL;
-- 
2.52.0


