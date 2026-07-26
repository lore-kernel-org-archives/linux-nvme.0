Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD056C531CC
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2026 11:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kpThYo2099okC/dCttBWDQwlmrc8IkfHjxPNABRRgtI=; b=FmEQAePlQ/O6pn5WDZUrygNs+t
	nj9Fh6GPFHDu33btAHfr9XjcOx2i1Qy+49glgSFIHGWFifpLLbWDYKItSdYRysR+5b7jP4FHqtjIr
	nBEZIFsI6enUAoN8Vtjwa65OSApROXyl9A0tlALoccb8asVp6o6Mb/S5WOA1KvdFyIykbXFrYBXTb
	yF40oRrCR091UH869ULLK2e3RNhVA90wvBSnv4bJKz7Pnktbhi7DJkCEEXM2MAmEdmDTUZc9Mmx3A
	cJScT4ELTHwlT97aQkEDyqS2Z40smmusdCXHavgyeyV54fLd83GsBlEFDa9KXFNEHQSZ/6+CVPqGm
	KJc4GW7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx66-000000016yu-1TjH;
	Sun, 26 Jul 2026 11:32:46 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx63-000000016wT-1hQK
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jul 2026 11:32:44 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-4720f3bf164so1648976f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jul 2026 04:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065561; x=1785670361; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kpThYo2099okC/dCttBWDQwlmrc8IkfHjxPNABRRgtI=;
        b=NnnGCuY0sPRGGalUZHo5SRwwJyQACIhR5aLrBp00S12NBdhppDPy82oW2urNUujUd7
         cjHEzA9TaEen///I3/tuLmwO+YWGPtA3efnggKsURHQWG/TZx4WT+v9mVlPmzZbP6Xiu
         CQHOFjSe+wMFcAdm57IYENDW5iiCdjvdre3Cu04JAnuHSWHkWV5coDgyEWMWnqdrQhQW
         ax1n2OsOULGhBXhg0bBot8ol0TU0NulEe94dKWBSwzb4YtMFtILmoT0sy1hVCXBfl/nR
         r2VNCdHNhWWH0Wd814jL1RfW9d3Q56pDW6MkaWTEWQg9sqPF5+DfdYO72HsHGio3EleY
         qzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065561; x=1785670361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kpThYo2099okC/dCttBWDQwlmrc8IkfHjxPNABRRgtI=;
        b=ie0XSOdio9L6avcXN6okFpo7yA9ySqYWD7QX9cL1hAvN7a2P8HQY2PfVHysLLNYoFG
         pC3P6MbZHjN8RzyAbHZE3I5wgkeUGQ2DKOiwxmECPKW3Nl6IeRvwz6WOjx3qXwKAdtLz
         FE+eDYBbncIpdbidcqoj2kzANJwnDkcH8XGur8kFIdt9qQZ7oH2ZqFY2DH+F+C7UrWJR
         gAg3R0/iyIFgwW7v2ZQuqM411wOa+bIcuigI1oD8WEdI7V5vSsyLrNqtNi83SfxB4r7H
         p/XSZQKFfYd1EjXMfG+za++JR6dQN70RBFwq/RJ0Ee21Rj2a5BD0wTzu4JJP4dpYkKNQ
         qFGw==
X-Forwarded-Encrypted: i=1; AHgh+RpmfESmaU4kAlOxM3RA2Q4Vw8sOlTzZIEzYs6SsdJnv/xyRhMW6GV2Q0jIVud/uEVBPwnGvSBFHVNBL@lists.infradead.org
X-Gm-Message-State: AOJu0YwFsfr8QRt2igMBPR0WJnG4fP7PBZP4I3pIphuchCGrlqtpjeJN
	ivUXu4RZ7LHDfz2Vr7tn4pYmi/JzO7cJY0ubk1InDbEanR5jhHCP15C+GsqQ+SGd2Q==
X-Gm-Gg: AR+sD11FduTOB+BZxY3PAjCQvSa929kakNZzNM3EcE5yq0aGAXi15xxjp3uIaXMy6Fu
	UGhnzbUmscy40goM8kqntoZphppk7l6hv+Akf+z1cq93AKw9Nxo6OnfAqFBGvagvYiY5+/36QmA
	KnHOPHB12sBkcj3UMNm2lPnmLFGMV/GosrnFV94vn47wr/HQiemXp0UC23IkkW44PtHUMQsdqZk
	muvO9/CB+ft6KffPOVsYAuT9Eih1HiwswSwQyKzX/qr6Snz0s0dDIA/uALwO6WC3inyZbb4JI80
	Al8kS+2voWVruKvxPkfPbLoGBEBGjvYI/NhLX2ivJn2yp0t5BQaV04je8AhHfcHqXMS887+ASu+
	UkmczY7UaSxHu/tvROK9BCULxvzm52dkr7gzzQRoi3Kl0z7yiwqv+g211+Eoky/S8UiyZDJz8H6
	I77pgtzIt54recpRbq2jq4yY0b74ruxnAm7+TIlJsnPOyr0GmTf/U58faEGE71Np8oK5Wo9A0Rm
	4/8hTMvapZwEuK3tphKlIXLiHgDhhqycL3RTYr2AA==
X-Received: by 2002:a05:6000:2088:b0:47f:91e6:3729 with SMTP id ffacd0b85a97d-47f9cf160b0mr9458165f8f.24.1785065561564;
        Sun, 26 Jul 2026 04:32:41 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:41 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 03/12] md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
Date: Sun, 26 Jul 2026 13:32:20 +0200
Message-ID: <20260726113229.2154269-4-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260726_043243_465259_5EB2B4AA 
X-CRM114-Status: GOOD (  13.51  )
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
test misses.  remove_serial() under the same condition.

An rdev hot-added under serialize_policy gets no serial tree at all,
because mddev_create_serial_pool() skips one that is not write-behind
eligible: the old gate dereferences NULL there, this one skips
serialization instead.  Martin Wilck's fix repairs that case at the
source, after which CollisionCheck is a strict superset of
MD_SERIALIZE_POLICY.

Link: https://lore.kernel.org/linux-raid/20260723112741.1206836-1-mwilck@suse.com/
Fixes: 69df9cfc7042 ("raid1: serialize the overlap write")
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


