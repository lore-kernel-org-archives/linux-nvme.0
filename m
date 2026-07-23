Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982F8C531F7
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 20:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jvUC0Lia0it+LgLYsOXSPjeMnXEhLq3Hqn52LEDkVn4=; b=naY3Fadoiwr9ouHhY8F92y5c7J
	5MsWfhV4o1ATIIh0VTjjttNs3826V7mNpalmj4YWXYrrt2TjvxKg2z+9VNqc+3W0Q2dSNMq9XP822
	7jugojmjff9fo6yJpF6zHAefBIJwBBQi1krx1SNRwPEcSqdoBYngzxb/D5pc7W0vrWVdO0O2XYF10
	cfrDRDzaDhyC8Fpz5qz2RIpZ8pfpyOYTbn0dpzTmhhxCE+wveUfH3y/cOCvc+JTsG7dxCKmV251H8
	IuBBa9VUTwUKpzDYbxEjBX9DjawHsdazldGqc9TOChLaZe+YMSq9AOs3hsr4Nl4wYGF6u0JZKTkZ4
	2PBn87QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0G2-0000000F3bg-0rkB;
	Thu, 23 Jul 2026 20:43:06 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0Fz-0000000F3ZH-2v1x
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 20:43:04 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-4728c12ba97so667140f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2026 13:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839382; x=1785444182; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvUC0Lia0it+LgLYsOXSPjeMnXEhLq3Hqn52LEDkVn4=;
        b=ksCJdpaeREKIYF2w3BN0HloUrQLBVkva3fwIcM8YtSG9Rv2H+GMOfxJrebI+H2Mhsi
         8CJ6XTxgNU/tFCEiCXBs6FEipnwU/Q4BR2KxPqi4cu7CXw9D2dT2TCtMxLFJ2kE5gsM5
         CZ6fKXqGl8dvAdyW5cUm333hl+b7uUo3bqjFfrRLgGbkNKG2q3VCWQY6LlAfG1zFpiKJ
         c4NlWextSGD8kDuGjKNELA6ARzRYfjplK1gOHoiA5tmTYfnsDjkqWhiE5tGJqoCWPin/
         KNLqPePvNDwyK7W48TiBWo23aQ2RLLmEjZQl3genwC29xLG39gL1yLCuaGKjfqnklHN6
         510w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839382; x=1785444182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvUC0Lia0it+LgLYsOXSPjeMnXEhLq3Hqn52LEDkVn4=;
        b=Vp3pneaAGCxtRYwJ0fuwN4dMOOD7WxSExOKcN7kIPtlPLGOrnuHcVup5T/Z1Sm+AFP
         bSAHa18vcQAMw4jOfNa6y9DkCaq3dBDZ7GwgRhiSdKSwq/ccdacUGOPvypUOBm7/rqev
         fgUYMh4F5RBpiQn4g1Oxgdl4SrF8Py9aATGeJFQl6GOG3GAjAQd5a8Nokz7CsmmJh0Yd
         YjnWp/6J1K88+Bpo+Nhx17yeN/m6ALEVwqtxjwV+/XAmCVecohFWpp6l5BWEJuoenSgh
         UA/D3ryhOOz1R8xeU/G91h2MZWINNnyj8Oaa6s+5tM7j8IpnLgkxyXEif7knfXwLtugM
         i/Hg==
X-Forwarded-Encrypted: i=1; AHgh+RrOM6UPi4ozXPXAptS7Uwg+lZ/wasPWfNNe+v2/+8Gdc3UTlgcmNaOAexN7TNQywoTWu7Gt2h3w4xcM@lists.infradead.org
X-Gm-Message-State: AOJu0YziVo+xJfUIrzeeavHiOXAk9Z28WpojEYfUE6AqwaQLVA7AHbpD
	AL3/5pt54CL1hkjkYRC0rplfBmNWadoMNo3oJniuP8ByWEomghtZ7+v4lQ8XRqvNkw==
X-Gm-Gg: AR+sD12dwikvOhMS5R1dcu3XyTonRchB2M8PIySfs5ubtl1+sqBppgyr9/SfYuapyAa
	WtyzXS1IYlbaeaYJCd8ksdSed/3vLK7btefJmjaYdk/rXAKCKh6d8cNQFOPw4wLDkqO9A/bajEz
	t5B+f/+8q/i0wuOtaabNOanIJunC3h7lLUdUwGmGQLmEaJhSkvVFmcFpEx577UYNSeKHL8I615/
	FvRrtDanWUrz4uFq+N8RNmvpC8JkLn/HOIJZGEudLedMtoCFPM9dAdjMK+6fqlLY+S3t5IQSp+V
	35NvpvgoHqMpzDDckAM8V4HDQdhVnE2UxHGxDLb+EAOYD9nPPL6NCMsDAHC3KZxuPaCgxp373jV
	ZL74iNXAOBOvXDhCpDc9K3Z9Bzx7RDm8h2AZkTGvILNm4OL+SM1y2JfLNXry0uC7jt8xX0Dhdwd
	tBVQQljyRt/18qvOBrKuO5ufaahOcn9mRkD11SAPqjoBIxH6RM3/13JFrafAHy7WIrzE/IT48W2
	oNZa4YBoxeNvIuvoNhqUNt14/+BC4TDKaa8uYmbC55QPxHBCR0M
X-Received: by 2002:a05:6000:4301:b0:47f:943a:a7f4 with SMTP id ffacd0b85a97d-47f943aa945mr2275162f8f.61.1784839381805;
        Thu, 23 Jul 2026 13:43:01 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:01 -0700 (PDT)
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
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 04/10] md/raid1: don't use write-behind for P2PDMA bios
Date: Thu, 23 Jul 2026 22:42:00 +0200
Message-ID: <20260723204206.76930-5-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723204206.76930-1-mykola@meshstor.io>
References: <20260723204206.76930-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_134303_752488_5A500E2D 
X-CRM114-Status: GOOD (  13.72  )
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


