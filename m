Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19556C531BC
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 18:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GLcS/ETJPdW48ntvSy2VqAomcBgiATmYTCUKJMNlgIw=; b=h8rA4hPlBwo7QyvpEOcqezTI3Q
	3hLLkQWDylzmtVEBaiKOJpEkWRAZjB7wXsKPZ1UMqE2CLQ6DZ/ZQH1mMB/Tzw+tqZu/VFU/Nve/qp
	RNktVyB72okhnOPcS2hrHMlhfSGM7Nb8Uxx72JAEpukROL3JGE8B1nyvn4NYBxlrKUidUO49vRkLq
	26HWxZ4c7VbikMKgsPEuA6/cbyWV7zRFRDE6B5hhYYrFoOPit1T9mRvwKhqAMStDf7bRynWsjd0Gs
	Nj9p76MYyoJWSDuo4SvbW3afVHgIWE1qVHS8g3jGIcBaDRBivQ8HbZQsObjl/ShvC8wqydFa9tuIl
	eXX9DidA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmc9s-0000000CaiX-2QF1;
	Wed, 22 Jul 2026 18:59:08 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmc9q-0000000Cafg-1D6f
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 18:59:07 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-493f75f7172so100317235e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2026 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746744; x=1785351544; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GLcS/ETJPdW48ntvSy2VqAomcBgiATmYTCUKJMNlgIw=;
        b=rsmXnDjEgMTsFDXSsQJTgpdWRIe29OabJQ6XE2bZ7lDRz5N8Rw4JlV2xetfvQSHtKP
         UR0NpshxaqrCoJsftOsL3s0BflqQP2S4WkSRM1WW9NKcxf7txI4nVbXGq/T8SyxDRbXT
         ebkulyQShS8dykzsL7ADJvJLidqB6Tl65YbBPM+USKRxG2ttuhquQJSSTZpNTuuq2MPH
         UdhMImvcHGPFIsoiVHlKr0QrTYYi/7lJ49MfOK65S2WG0Os0GtjBfkIZXoYJfhU9kXx4
         S0/KkFENttCRLMqCZcS0fhRFEuLYUqF+HHqve31SCSZ8G5RO27aGCsEIgB1aTkkr84QE
         ou9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746744; x=1785351544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GLcS/ETJPdW48ntvSy2VqAomcBgiATmYTCUKJMNlgIw=;
        b=P9tkXQX/cEZOux0z73ML2qWb7dl13Oy/W48TN5eJN5yK8ayK8scj7dpOhSrw2TKym+
         QxFUII1AxWNFctvWqCX1f9OhGq6tpouTFkHwBk3aq67UNnTwiBvbnk/gpn4lXZ21fdZr
         OzisZ2ALAiWGVkzve7cusE70ebcd1iUP3cu6V1ThdZzzumLqJJE1FLtVJNJG3X6/htxv
         J26REgb7zF/uVu/l91vC7GJOLcCQ/z0DphD3ODJg2Jfxct4CvwDzWT5F4+3BvFLv72Al
         tUO8rxskmIVJrZptDlX9gKw4xZm5MAKnKqbBMqzWpVPH6YxtBoxRyW37Wm9KDmEBQ008
         XDzg==
X-Forwarded-Encrypted: i=1; AHgh+Rr8VqXRWV1x4jPUZxnTbXZWtORyLPHJpbAvMSvXwgcvFZN5weu3u53mtyFKbmtgOCkXNgaJlb8OJCwV@lists.infradead.org
X-Gm-Message-State: AOJu0YyZFmr9N5hW/OGc8X1gqxtsoYcPU1zblVmqgpKu6hYL3oGSauaZ
	YeD1u7O9aE/hz35PcrxQuWPOTjZYOQx7ZwfK08n2ZWiYVt5e+Yy9fliQnifoGdxhrQ==
X-Gm-Gg: AR+sD13OBL3bfnsPhRJpXIyM6msSIUQfNRg1ToKSFBalLOYNoga5KG2Wnx3a9C1xDgQ
	AAIfWLjGCE5+qihrca+gIoaCgLBPIZ/hFH4NMPvXKXYoscnsWRBEN9zGUgqCf73+6WqAiSMIJ3G
	CvWauHejEyhaT3cdhuKTv9QjJVhLAyfqW9gn5zooznkzbLwfNLpf81UDmQ8fiEMsXs3JE/GbQSn
	rzUmDEk/EX/Eoa5CnwqLSYX2d+cKnwMSwJhNxvNPi/7a0axWGhXJGbxJQuLuildYEAHLV1ajWM3
	7g0Nf6lDmhsP1/x46i1p66+t/Puf1qzPjZkOd/tHpc/kXvxBth9KicgFV9YbUgafQKaQICDrw/c
	T2mpri10ocMwWrbt23nZFr76hjEWLbZK6j2WAZiLKU9shscmyYw12VcNiSTsFdvj5r6Smn4DBwD
	fxkhbNptJbvRS3/0OpuVoBLPIUkhkc8s/n+uSTN690Cq7wNb8=
X-Received: by 2002:a05:600c:c84:b0:495:4811:d71c with SMTP id 5b1f17b1804b1-4954a3ed4bamr271393965e9.13.1784746744468;
        Wed, 22 Jul 2026 11:59:04 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:59:03 -0700 (PDT)
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
Subject: [PATCH v4 3/9] md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
Date: Wed, 22 Jul 2026 20:58:35 +0200
Message-ID: <20260722185841.449934-4-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260722185841.449934-1-mykola@meshstor.io>
References: <20260722185841.449934-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_115906_341099_2DDB4120 
X-CRM114-Status: GOOD (  13.20  )
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

A write that skips write-behind (full behind queue, a waiting
reader, failed behind-bio allocation) races the in-flight behind
write it overlaps: nothing orders the two on the write-mostly
member, and if the older behind data lands last the member keeps
stale data for sectors already acknowledged as rewritten.

Serialize on CollisionCheck, which marks exactly the rdevs owning a
serial tree: serialize_policy rdevs plus write-mostly members when
write-behind arms serialization -- the case the MD_SERIALIZE_POLICY
test misses.  remove_serial() under the same condition.  This also
avoids the old gate's latent NULL deref for rdevs hot-added under
serialize_policy (they never get a serial tree).

Fixes: d0d2d8ba0494 ("md/raid1: introduce wait_for_serialization")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index afe2ca96ad8c..997f79c05db7 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -564,7 +564,7 @@ static void raid1_end_write_request(struct bio *bio)
 				call_bio_endio(r1_bio);
 			}
 		}
-	} else if (test_bit(MD_SERIALIZE_POLICY, &rdev->mddev->flags))
+	} else if (test_bit(CollisionCheck, &rdev->flags))
 		remove_serial(rdev, lo, hi);
 	if (r1_bio->bios[mirror] == NULL)
 		rdev_dec_pending(rdev, conf->mddev);
@@ -1677,7 +1677,11 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 			mbio = bio_alloc_clone(rdev->bdev, bio, GFP_NOIO,
 					       &mddev->bio_set);
 
-			if (test_bit(MD_SERIALIZE_POLICY, &mddev->flags))
+			/*
+			 * CollisionCheck marks every rdev with a serial
+			 * tree; order against in-flight write-behind I/O.
+			 */
+			if (test_bit(CollisionCheck, &rdev->flags))
 				wait_for_serialization(rdev, r1_bio);
 		}
 
-- 
2.52.0


