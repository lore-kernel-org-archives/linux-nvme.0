Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056BDC04AA5
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 06:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QC7+lTB8CYjJ8qP7QXHCezGR565iBisGsJnf8ENWV5k=; b=qV1cZoQhU40WMZbHThmY3TU7UW
	umTJAcaaqPHQZ9egqLaNX1wUMXso/YA/QvW7KujKlOBtr0UU8TDeSYPh93XPTzD++9p6UfcVkNtH8
	FjrC6h4LnKJpH8K/Ym/hCKgfWY00oS+yXuBjnv5qzufTwDPh13GReMXMxj0eXEG6nZB66DJNw5ZPr
	HVmO/dMQZK8Qzm6WfCOLqznVOiX2h4PMEk1uR0jOJqr9kBhIg4O9/kITNWLqUCNGJrDl0KQV96otw
	v1W+61mXNbapaBceDW1Nx3RAMuP8Qzb7+SNjQvAjQMt9EX7irV1Kt6W2PZvuB8NK6agkwgnjbzWJA
	2hNEEveA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR6es-0080iG-GO; Thu, 25 Aug 2022 06:48:06 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR6eg-0080aW-7I
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 06:47:57 +0000
Received: by mail-ej1-x62a.google.com with SMTP id gb36so37625605ejc.10
        for <linux-nvme@lists.infradead.org>; Wed, 24 Aug 2022 23:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QC7+lTB8CYjJ8qP7QXHCezGR565iBisGsJnf8ENWV5k=;
        b=Qnfw0DrQibQa4hawUYilpeQDYvZJuvkVWvJpHFRJSCSeL5XJ0IvnXVdiz73C8G+Am/
         akblccok2ppfkAca08ptLEqfHw3px2LqIhRen0PE28RMqRUZ10wQy0sht040oZjHMV/3
         SuVtxn+9i7LSuwlC1nNy/1iObR805oJ+MJcYKSvlSjwt7k04+lsl106k5nQKRYpDMTEz
         X8Uhlp1ofZSKEeLGWGqPAjJvBB4fmcPO3M5ytmTLPUkTUEvSM41WBam8axvHZS1a8YqY
         fEdm4KGhlArw2yzwpTYSPH1+4Y3Sr4eioD5W4rICKk6h9siP5IP7zDneDHw+YhYyGJTZ
         prXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QC7+lTB8CYjJ8qP7QXHCezGR565iBisGsJnf8ENWV5k=;
        b=4VsStzeeB2yC6f7gTN7AmhsZLQDDeaRAYveeRe63KGammf2kgJc0UyW4SO01xY/goC
         5JqtNek+6iZzTF4RETR36eaiwlPh0zViVo7ookgIBkXzGTYpSPEiOg2l5t2onsJqQn/x
         6a1XTldPlD6D/4H5Ve0jWNPyRjto0sFwjNMAFq/vZzdA+IymKCkjB2Zuznf4JhtPFx32
         u7VfiOombCo50TGaGtbRiphgssYoUnuEZBjrv56eMWbzF359r02UHVWl+I/4TPrTi94V
         7b9yh5q0A+wV49KiT721EFZgznVpmh8Chz6hF4ITlivXWcK9qxGvTq3ivUV87/1RYo8v
         Mg0w==
X-Gm-Message-State: ACgBeo0g21lGIZ5CRe35PA5r95ZRYuA8Ytp8SqPmBxusnVVpmkG47K9H
	KupYkpF7yzcMVMmh3DreKCHXgg==
X-Google-Smtp-Source: AA6agR7Lvqd8XFW8p4kZ7wnCxdcwCOj2Dlxbk7sGMmdOP77SeN/pAqxwgEb22kPrxaSK/ltW44vf2g==
X-Received: by 2002:a17:907:3e9b:b0:73d:8ccd:2bb1 with SMTP id hs27-20020a1709073e9b00b0073d8ccd2bb1mr1475204ejc.568.1661410069937;
        Wed, 24 Aug 2022 23:47:49 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id l5-20020a170906a40500b0073100dfa7b0sm2063564ejz.8.2022.08.24.23.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 23:47:49 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: hch@infradead.org,
	axboe@kernel.dk,
	linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nvme-rdma: Fix error check for ib_dma_map_sg
Date: Thu, 25 Aug 2022 08:47:46 +0200
Message-Id: <20220825064747.22521-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825064747.22521-1-jinpu.wang@ionos.com>
References: <20220825064747.22521-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220824_234754_275364_1EBF15A3 
X-CRM114-Status: GOOD (  15.23  )
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

ib_dma_map_sg return 0 on error.

Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Fixes: 711023071960 ("nvme-rdma: add a NVMe over Fabrics RDMA host driver")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/nvme/host/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3100643be299..d70bccbcba3e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1551,7 +1551,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 	*count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
 			       req->data_sgl.nents, rq_dma_dir(rq));
-	if (unlikely(*count <= 0)) {
+	if (unlikely(!*count)) {
 		ret = -EIO;
 		goto out_free_table;
 	}
@@ -1574,7 +1574,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 					  req->metadata_sgl->sg_table.sgl,
 					  req->metadata_sgl->nents,
 					  rq_dma_dir(rq));
-		if (unlikely(*pi_count <= 0)) {
+		if (unlikely(!*pi_count)) {
 			ret = -EIO;
 			goto out_free_pi_table;
 		}
-- 
2.34.1


