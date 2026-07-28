Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC51C53219
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 02:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3L2paztWhQuVkOkPSkB4LVS1c8WWkooOhtLcip+4H4Q=; b=FPq7eZyLx7qJFe8BF7S7trg1Gn
	zlm1gRyTV3m1xu2+NvMgjV5fw7GsozgTuiZiCIdP0rF7l+u8fa+VpYYk6Q5cCBDXFrVmEaXW4HtPa
	04mt7+vOVbAVAtbAah8hraRLPEB1s2/toN7t53N1NU3f0PVQIR4si/m+xK16cRAgINPNRtbot8BOJ
	VWa41xL2Yos9vEsdQT6ZaM2OQHQA6IwPEs/7zrkiK7zqdb+Ffy9Uhwhehfyn4e1Z2hj/GeD1dnDo0
	SFPUT++n9y7GVa3UxJEF4fhAKAYK/4UpxFiOJU5otGEG/FDQcEfG19anSD7/Fxi9m28M/lu8LF2gH
	/w/CV8lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wotqF-00000006fQn-2r5Q;
	Wed, 29 Jul 2026 02:16:19 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wopN3-00000006KKG-3Lzi
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 21:29:54 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-47f703a9d05so213542f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2026 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274192; x=1785878992; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3L2paztWhQuVkOkPSkB4LVS1c8WWkooOhtLcip+4H4Q=;
        b=TKPPW8XNPMcembE4Vvsp56KCobCpHgFU80HNCcw8TYeBWHl4W8RqxfCXqRo9v4sbA7
         OjXXbKrkfgdSqiWj/Q0o3Yu81Z8acwXGljj2LGnxI52Yr3gZadW9tWqR5JG4I0lbhRTi
         Io+0M7XCoWCHg08/HMKclF/3/AnEBXV9B+odAw3Opvr3BOQgploDMZF3yJmw213HBbKR
         DAYmtT/Vm4gpM9CnVY5w7Oogt4Lynxurkkh7vKSgcFL6yiFNkwEGtybOch93eDGqKP1J
         9D8HdNNr7yg53PmLcWjZZq/i31GORXsnD+C9uhZqnRa5UuHjwXtpOOPlZU2ggAcUFjL1
         dO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274192; x=1785878992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3L2paztWhQuVkOkPSkB4LVS1c8WWkooOhtLcip+4H4Q=;
        b=rTfNTJd/23ugzGHzHmigffzjO2hLGUF/zWvqwiqZez4RBfa5HtVZgEuMpAzBZm2Bo1
         wqCLqKniYdsvvJ4Uuaa5RpYfLK599VsoOB+yZ1u8vVFFVd5wlkPh/10DrQJFwnZU0KVC
         Mlanok0wEvZGpPDoOIUiiyd9SlaCEM0DJQ5P0ccwaDsZwc0l/GjU/cBbFXSVg4roAuHb
         aNCraOfTpovbo0bMb16+VsblaY2DhOE5SOeZdEHE0G6QbqxGchgAQ7tmucST5b2SA7Kg
         tP3YqPzNAJs9d4tcoO/iDfiVIWaM7RrBe5W3pCSE013pgL9r4Etgx3R9pWcCJsZZtC1t
         TP7A==
X-Forwarded-Encrypted: i=1; AHgh+RqJnJXC/4Xw69SIWFwuLegt0GL1BsJmniMJg3BwZ7NAC0kY2KH5vy2Oez+3K85BVdVuuNJwquJnehxl@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+MbTB3PoDwBJ2tWg4KbHKlb4VTdrfLyXU9ql7baVFXKAhLZTq
	9ysB0uBolR3IdGeZX88VRsutOG84lurv0hifJkTnHdGOozzULRthjQPj
X-Gm-Gg: AR+sD13KeJ1WV75n5JgogJLI3T8bEk1dCO3OPgQB2L/PvQDKUeAu2XmuKLfuxzg0Pg5
	qdAcWp5Lqkdyiw7oxeoQbuJG0WB9e4gvGgzozOl+hpGnFA+6WQ0K2cX+H6HFZmH2CIB2bFSqVTe
	o69NA32OHkWPpXLZQ4Unk4TEjefcuzq0mEcW6Wg1vpK1Wp4TK7OHKgsG+10FYCh1Jc/zHsZ3MUC
	OLgLM5nY1bVhjSnH+HtfMXo5LMgsy6yxDhZ91YXt3qNw/XiR7muxtlEhLqfJIQPFwCRNRJwDzh6
	xVDOTUus3cbZZP8vuORtz6uzrAjh6T8n2lbZNgK0byb/5kFXO5U8Dd9bmw91z1KsBkLPNMt5SV1
	Xt2xTpYkKakCsJaLpBNafFBXElwhWCzrIp4yBpak8ZDvkKmwwbT8SbDofuL/2YF2/FcSA9guYBX
	0CuWGoynXDVhApUn1jnDWpoK/1VGw9Etk9C2yQ0e79ISLvu3wAuVh7u4WXU4tzA5VdyQL7KwKsm
	dXiAqTO
X-Received: by 2002:a5d:5d06:0:b0:47f:947a:9dba with SMTP id ffacd0b85a97d-47fb1e5ce09mr5390953f8f.6.1785274191852;
        Tue, 28 Jul 2026 14:29:51 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:29:50 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v4 05/14] block: move bvec init into __bio_clone
Date: Tue, 28 Jul 2026 22:29:17 +0100
Message-ID: <7423d294c6184c683d7b2ccddf060b4a308e0316.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_142953_854945_E2DBAB67 
X-CRM114-Status: GOOD (  13.04  )
X-Mailman-Approved-At: Tue, 28 Jul 2026 19:16:17 -0700
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

Consolidate bi_io_vec assignment for cloning in __bio_clone to keep any
further changes in one place.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index bfaede30a54f..57c127aee116 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -860,6 +860,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_write_stream = bio_src->bi_write_stream;
 	bio->bi_iter = bio_src->bi_iter;
+	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	if (bio->bi_bdev) {
 		if (bio->bi_bdev == bio_src->bi_bdev &&
@@ -902,8 +903,6 @@ struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
 		bio_put(bio);
 		return NULL;
 	}
-	bio->bi_io_vec = bio_src->bi_io_vec;
-
 	return bio;
 }
 EXPORT_SYMBOL(bio_alloc_clone);
@@ -923,7 +922,7 @@ int bio_init_clone(struct block_device *bdev, struct bio *bio,
 {
 	int ret;
 
-	bio_init(bio, bdev, bio_src->bi_io_vec, 0, bio_src->bi_opf);
+	bio_init(bio, bdev, NULL, 0, bio_src->bi_opf);
 	ret = __bio_clone(bio, bio_src, gfp);
 	if (ret)
 		bio_uninit(bio);
-- 
2.54.0


