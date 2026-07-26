Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8310AC53200
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2026 11:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=; b=1/tH9QT7YYLNmq+INUtao4Y6Mx
	AhBA2pkRcHHYaQk8kfP1zGYPL18pD8jr+wPWsR4IctGhFoAKXKWhicejM47Rp6Ccz41tKApoEC0xD
	EXDAzj5JFqneA/eWa/4HW+ubK3/4ITuDzwgxIARkj5C2o8gZ8z55I5D0+EEyHRpRrz4spH9cI8n2u
	sLBfxUsqXP37tcMx9tAKQCbbofNUSbwTmBAHCT3cpKUvAjYbZfWdidn/PjpgDSBjjyfeDh7wg66nR
	Lky5iQnpzbqEWK1OAgG146HVhz6JP8KMDTNS8JRHGgGEbgKnyvfB4Y9FLLnDaKCChmoQe6+GUjUpz
	3eGoQeiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx62-000000016wp-49e5;
	Sun, 26 Jul 2026 11:32:42 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx61-000000016vc-0jiM
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jul 2026 11:32:42 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so3370365e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jul 2026 04:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065559; x=1785670359; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=;
        b=JKU+mOBZH4GfcArjK9w0wgijKNI0jxPI7NG2roiSwWONncjwowRv6ZGyR6URtAwosi
         EfjiRBlhoRxtrn33VCit65pnukHh67BLNGy8OzzCdV+UTii7b90DA2BrOCgsYqWbx57A
         TTkApoZNlEcwKpQOx0ANdu4YjypakVcwwtRMu2uBgF9x1fYR8B/GCViHORfls4s56E0J
         Xt7s+czvkQSGfohCBWqDJysh4I12jJfX5BSxBUKI0RUTxE10su3OGejyZdhqunmuzV6Q
         bdrtd4w2KLilA3sUe7qm4AyYnEcULaAQw+a/+IatoBJPCn7BEvuIL5JLIlFYfiw5ohhZ
         STaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065559; x=1785670359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=;
        b=G4wPCA1xh/mmWYPlHY6cp/juGF2hdtiMaH1BoCoFhpLZXN0kM1DGb6yd+QIbTlKHzg
         hJSj7xQq7sZFXRq28dAUiL+Cin0fbI1QIt+MrQW9RBqkOxJGDc/QZpirq+RkKywvq6Hx
         2Dvrs+QRIGKFYU+Rky8HxDtTpgDSsx60WnDAud3Sey0udIu4iPxs414UcerHdk+cuYRi
         uP4BgAlCosBP2f/LbemMPimr7SQFctCatqgmEUGDJR05ibHI2R09MyO6oxPRjysPiOyj
         SL6rRlncNMdbQAolJx35rkwfVVn1wooxukKISxKgGFBhtUGehz225ZLycIl11PxDND1T
         FjmQ==
X-Forwarded-Encrypted: i=1; AHgh+RrsRBNB/KrpVDiqDSGBH4jCREONWC3uk+/CfYtX7l25IWpdlwgLYptz/cOgCkCKlK4F8t0GgUkqvZWn@lists.infradead.org
X-Gm-Message-State: AOJu0YzxABcb0sih+EO7ZaRFCrrtR/ljmoXhgdkDTUvKUtJ5N1p1b0vn
	1VWFkMpUBXxsjmuLXEzbl5fqTjr3SL7ZZdnJikWDUDojXJJZLcFBtlVNEHlWj92+R6SEvr0Ebq4
	zlWhXyMz2ZHk=
X-Gm-Gg: AR+sD13ZbkuvmI3Uhe7J2cwlXNWs2iitrFGATTzjrQDHtKqJ5lt1yhe+NH+UgnTOHrN
	i8z8H+kKMMbK7TyBEEuj+2N/RHvEkDH0AHRSjyhHlal4SX2Ovb4Hk9Ht1FfPUqAtOK7PlQ56dgu
	nw5ePpCTr+1PV9g4wZIpYPZneqYWZwR5SPZ7FQDQFcN9xiPYbb9t29lQ6PwWM+DtzjclXyk16lU
	3Nhyem+SbqrXykyD8gn3qHU+CGSQdyTwRgB5OQJxUUC++kPs+D/EL/0yB+DFpjjeelrDTiPYO1M
	tcQrBi4WaknypvuCw9I9Vn8m31LguYZsUKl5WHzRAIzhUYHXEM2A+p5/uak2RQATQccKn/7tnwX
	j5xNPPEcNUQ5vKu5YBAQsQjWSGc3FkGzqVeOJZD0vhE+he1u1M23uCCEpWxTLifvPwlasq6FGqC
	GI1D5TOzrVyHGF4Jn4CiV9s9FTVSfjT8tc/6uJh7sas4mXGjiyQH/5YVUmQZMB5XrDjOa1gmZ+m
	ziiWdtmpcEDuJo7ajx/NiNYgWrdZOvuCcmYGE3Irg==
X-Received: by 2002:a05:600c:1d0d:b0:493:c8c6:4989 with SMTP id 5b1f17b1804b1-496b56bbc65mr64847835e9.6.1785065559344;
        Sun, 26 Jul 2026 04:32:39 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:38 -0700 (PDT)
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
Subject: [PATCH v6 02/12] md: ensure REQ_NOMERGE is set on P2PDMA bios
Date: Sun, 26 Jul 2026 13:32:19 +0200
Message-ID: <20260726113229.2154269-3-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260726_043241_248250_4CF83BF2 
X-CRM114-Status: GOOD (  15.21  )
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

md_submit_bio() strips REQ_NOMERGE from every bio.  For P2PDMA bios
the flag is what keeps requests single-provider (see
__bio_add_page()): merging a P2PDMA bio with one over a different
pgmap, or over host memory, maps the merged request with the wrong
bus address.  Set the flag on P2PDMA bios -- bios built via
bio_iov_bvec_set() arrive without it -- and keep stripping it
otherwise.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/md.c | 10 ++++++++--
 drivers/md/md.h | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d1465bcd86c8..3770bdb4d4b2 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -451,8 +451,14 @@ static void md_submit_bio(struct bio *bio)
 		return;
 	}
 
-	/* bio could be mergeable after passing to underlayer */
-	bio->bi_opf &= ~REQ_NOMERGE;
+	/*
+	 * A bio md split may merge again below md -- except P2PDMA bios,
+	 * which must stay single-provider (see __bio_add_page()).
+	 */
+	if (md_bio_is_p2pdma(bio))
+		bio->bi_opf |= REQ_NOMERGE;
+	else
+		bio->bi_opf &= ~REQ_NOMERGE;
 
 	md_handle_request(mddev, bio);
 }
diff --git a/drivers/md/md.h b/drivers/md/md.h
index d8daf0f75cbb..73df1a6eccd8 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -11,8 +11,10 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/badblocks.h>
+#include <linux/bio.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
+#include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/timer.h>
@@ -22,6 +24,19 @@
 #include <trace/events/block.h>
 
 #define MaxSector (~(sector_t)0)
+
+/*
+ * P2P and host pages never mix within a bio, so the first bvec is
+ * representative.  Read bi_io_vec directly: bio_first_bvec_all()
+ * WARNs on the split clones md handles, and data-less bios have no
+ * bi_io_vec.  Not valid after the bio's iterator is consumed.
+ */
+static inline bool md_bio_is_p2pdma(struct bio *bio)
+{
+	return bio_has_data(bio) && bio->bi_io_vec &&
+	       is_pci_p2pdma_page(bio->bi_io_vec->bv_page);
+}
+
 /*
  * Number of guaranteed raid bios in case of extreme VM load:
  */
-- 
2.52.0


