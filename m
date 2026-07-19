Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDADBC44512
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jul 2026 10:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=khPWV7pl2ttOdMmwNwArwe3lfR4e9+Vyg5lRTCmC9jU=; b=pMgaaUlRSiq6YpSt7IHnfYipTC
	HbtZHtBQZgX/B1GiXGclEtXck1HeyZswVgV5x5X39vWd0Ws/oIl/hxtY34c9rN23BkA5WERdx7+Ii
	LuhC6BrCBP1Meist6Wa2V8tD2octH3RK3iLyQo8ZE43tJstFVcXZscE+9haWlyyaCOwFbpB8o/jTp
	cdBe/4g8VXTGvDy1duYcaYvGBK97oYucD9NEatxJpg7YL1GmOrbZQ4jv1K6mvucMI6lpQ4MfU4c/j
	SOMxjRh39v6YkHeehpzGmSfWxT7Q3tSLdOmF4wG9ZFfxC8NC1XDKy50JYkT+011be+AXLfTPuZXV3
	Z3NNsK0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlP9Z-00000004veA-0Xt3;
	Sun, 19 Jul 2026 10:53:49 +0000
Received: from mail-wr2-x02.google.com ([2a00:1450:4864:30::2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlP9T-00000004vYf-3A7i
	for linux-nvme@lists.infradead.org;
	Sun, 19 Jul 2026 10:53:44 +0000
Received: by mail-wr2-x02.google.com with SMTP id ffacd0b85a97d-47f6c54e841so379537f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 19 Jul 2026 03:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784458422; x=1785063222; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=khPWV7pl2ttOdMmwNwArwe3lfR4e9+Vyg5lRTCmC9jU=;
        b=FsTnWedba1k0liV2QcuLlikBe9MVrmnn1fA0UlhRyjfHmh3TzP/tXWgBx668K/wuem
         ZPqbq93scu6zTMvuFMJg9yFpSQbkYZJ0Kn6aIIzlYlv9XYs9oRHjJxu/ANDVwTlPL3VE
         U1t4aWAC0T2KnEI+AQ90vfqGJAu32pnGi4gMZnn8hW51eCFm6CzcUFc0DCdtxtbW11ym
         2IsJHg59wkKPRMOY58tCxY2LuzX4+2VEiUz66TKoB+I8fLKetIQATFWxVf0JzCpaRiEa
         /K+vlyBt+H1Vdlov9AxNVoJ+aN8pPtaPHZT4jtrADXhgj8wKYQggW1p3XdervXCduGTU
         G2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784458422; x=1785063222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=khPWV7pl2ttOdMmwNwArwe3lfR4e9+Vyg5lRTCmC9jU=;
        b=I7ymXlsjgRzy4a7iAaF0/mNWb4MORUCv7hiyYhUfoti1ysdXLGn5m3REUBAZrYeloK
         drcIO7YkBk0QGeZYjDdKYSla6bCWFsWK1UEYC2AD03y/GQS/eJOcXXBIod0S+yuLmUQu
         TiDv7kdoPl5fCIBc0742wFRS2qeWGaGQp+zJTPhSaJlgPmUF/WKr3FTK/bYkCPPCP9Y5
         0a3aFc1Pbdg4t8/o1o/Htm4BmsQNVuF1shdnmq+2un8LB8mEXTmQ09wAQuGI3oC4YgXX
         xhxMCcEqyf0PTwt14BMc3kDH4skbnRhf/uSj9NfdoejoyQ40BR54N07K/EksJarPK5av
         2lCw==
X-Forwarded-Encrypted: i=1; AHgh+RpgSSgb6+0ExRdom+PYow43uKMNGGoU85+9CDWS4YW2BveBwZ4gji9UWgKCvStod1hg394sRAqIkjZS@lists.infradead.org
X-Gm-Message-State: AOJu0YzMPt9b4MHb3poo4D4p+I8H0zCjhWAIqjbwPFj+1RrE1CkJKIzR
	7/4RIeAizEFjM+CZypS8ksSSLEk5G9/lj8pquOXY0uTt504p/yN64bc1r8ohGwXnyg==
X-Gm-Gg: AfdE7cndf7nkYk8mSQ1lI1Oj0hKgI/UpOMJel3MYrb5/M7EmBHn4osFhLaaf4aKwRmg
	uGOtODUAdwd8jXakGi7JuJsJ7xOjDGkE5sIo5gXFVKdTxA3Xqv9y9UB8FMolKdp2eiUSAMx57Q9
	9L34VolxYCPJ2FUplAfOaDAWY6MJ7jdZnT+iKTrpu5Nj7jmjIL0/xtrct8SHMJk+dv64CSdf9tO
	jzKo3WK/luPiOFPpb4vCXLbImR9r6oCzGaX9fHnodMCn5ZeEnfobWNmpQChy05qZWT+EiMGgn+F
	R/ByhDkeah9yX6XBg6yQRlhon8jP0/c+3TU3LC7F2XH67df9/38ZmlhP4hsJj6zn8d8MwDcj1ZC
	WUPZmc5HdK0wEe/yBiJqyZih2vbUzPVT4iZAv4DEjIaPhNF02eMwcTLo7tTq0EQ==
X-Received: by 2002:a05:600c:6dc9:b0:490:688b:f9f8 with SMTP id 5b1f17b1804b1-4954a5151e5mr80660155e9.27.1784458421726;
        Sun, 19 Jul 2026 03:53:41 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a24b6sm197679575e9.3.2026.07.19.03.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:53:41 -0700 (PDT)
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
Subject: [PATCH v2 4/7] md/raid1: don't use write-behind for P2PDMA bios
Date: Sun, 19 Jul 2026 10:53:24 +0000
Message-ID: <20260719105327.864949-5-mykola@meshstor.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719105327.864949-1-mykola@meshstor.io>
References: <20260719105327.864949-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260719_035343_814585_F58C4169 
X-CRM114-Status: GOOD (  13.97  )
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
---
 drivers/md/raid1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 8172df882f26..914fb86452c0 100644
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
2.43.0


