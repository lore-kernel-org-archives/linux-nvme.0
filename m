Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3633C53200
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2026 11:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mfmb4tl9yoRcxmAXx5l+qVXFh2lTgHh23cZW0hK9N7Y=; b=MjNmwrgz3QabAb7+kR70g558tR
	NBY7Etj88JZbXtC2HouRu8uI2fXviP6vR0LLPBIshYXD6nNTnW9IGCIF2W1dl+gsuwcyUiE2vd7vb
	8vHYI0aUhb5YSbHvhS2ABjXqvF9N8p2PQrJKcu14DhpO8ZPqaZSXI+ro9l7gooW7rjB0/SuwzVOK2
	Ummm6JR3YaL45kUBq5mclVZxTFIGSB7jwceudWjmIwX3zUhULX87j8MJBpN3NQjcMs87vMQAJ5UVh
	0YXVW5bytCSLFC4KyoEZhoz/A7zuu/vvz4/euPP5xar25PHyXLNP0o0mLgIvTuNtNsPbSUPU3Nhcg
	xoZemPAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx6L-000000017Ck-1aHP;
	Sun, 26 Jul 2026 11:33:01 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx6I-0000000177q-45JM
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jul 2026 11:33:00 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-493f75f7172so16093405e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jul 2026 04:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065577; x=1785670377; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mfmb4tl9yoRcxmAXx5l+qVXFh2lTgHh23cZW0hK9N7Y=;
        b=SpfaKW8Mmm008zJAdeXeFaLnv/Jyaj2xEhLFwv87f4oh06vc4R+5pnT/YpJAi+DnK8
         H//CnUN2hcFkAOrNZpz3Vlvu6DKT19qF3Jcqg/4W3UAuLVHSqMvUq9qF/c6eZDGAYEjE
         n4pbZYvCKG4iANW68Ocw7uSpAwO0uDoR8WNDh0geifrqw14uASTiW6gKTxfxJatPK1HY
         q3g5SyxMCyMYeTMyurkyYmIonCFZpGyr+ufXc9vlwS41+hJZOR/nf6yLFxSfe+KsFANi
         SDUJDPngSoLCL5KRTwRD21Pc7KigoXuCYf5Ofemkb/CG68KBaMJGlXRjmHqqGhl7Ogys
         iYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065577; x=1785670377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mfmb4tl9yoRcxmAXx5l+qVXFh2lTgHh23cZW0hK9N7Y=;
        b=rVglj7KLU3nulUrsO56eOe808nhkR3i7ffVEnePxftEAEU4PJD/mHB98JX+iQkPlFy
         ydqPmX1bBKoLrKdP30zRLmnTqdFdHdLlOlt2UVEdlVdyo8RLdHbMEvpUoFYDn8b3vZcW
         I35swnoSXcXlqSQnWndNYjGzSo18uSXORLyNHhmsdadkjMo/Ui07yVg+nnGMpXJ1V0az
         tRAp1QO8a6ha0keVK5lUXLne8+APK5YcZYM79cJQmpF5LHxV4UtX5dDxwTKcgsP/GiLj
         4CgHG+Pu5I9wQ7AOD8xJ+VlOzXs8Mq1bB1VHslNC0ltFji1i0shiexEb195RMgrsariy
         nhfQ==
X-Forwarded-Encrypted: i=1; AHgh+RoB/qmMJpS3Jm8rsiQF7/rhLPlM/jqNcckcXbgNVv0q55BYI9mpHHL92FsMl72el+onuVn3Iv0p3HXQ@lists.infradead.org
X-Gm-Message-State: AOJu0YwhisTIi0AHSY63Lzbmr/TV0F+9jkAeftXGW9zoi+Gm1TNyNWqo
	55Flt4cvgjnRI5FneBSe3ZjRJI7v/1YmoATuFmU56UccG9bebpasB1gCGzrqCSsHxQ==
X-Gm-Gg: AR+sD134m4ZQJbTgjtSXvNbOH65qlqiblnVPPWS6BKKRWVwgJBtj8gEaMeHzf+H+voN
	9nMzjqZ39YKVHAuas7gqYmroNS7uH1qYMn5EMugww5yMRAu4iLCshBpw3grf4ZHpQwA0+96xTqP
	/jQckcYoMi9eI84Ta5W6fslBmXalOYdpSTBjrhZy628ESZn1VYSWBvl3gHwIY0JHnev6MyhjfDt
	uXZEpeF8ZVvD7dEOisN8KZuY3mkl0AXhjYYOEUzwIpj7zclkkCaDE/NjvDIo5ZYpG4YXclLKY8k
	2ntbtXW9DsJY/XGMmKm41MRn2hxksT5kUEkNViOeESPrPHVrw0Y+fvS6v5/o6N6qFr2R7a/fP/S
	SNacdRLbXELDss//wp/mBe5Pjf3rFWeKbLPuc3HOI6oVgkQsR6lv5H+wOpuRDP1D1UFwbJQ1iJ0
	fQQJ1853fMYkcj5qSu5OzjosUFWVS8wDWAWuzH0gQVt4eau+38PszNEZI7JI9Nny83FAYGxbsU6
	N30pPLqHpIBeNXYzWfOw7CVUxW9OWZ2u7pAAfcqqA==
X-Received: by 2002:a05:600c:1906:b0:495:3a52:cd7e with SMTP id 5b1f17b1804b1-496b5700144mr69628875e9.25.1785065577098;
        Sun, 26 Jul 2026 04:32:57 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:56 -0700 (PDT)
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
Subject: [PATCH v6 10/12] nvme-rdma: return BLK_STS_P2PDMA for unsupported P2P transfers
Date: Sun, 26 Jul 2026 13:32:27 +0200
Message-ID: <20260726113229.2154269-11-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260726_043259_029711_1BB5E21B 
X-CRM114-Status: GOOD (  13.48  )
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

A P2P transfer the PCIe topology cannot route fails DMA mapping
with -EREMOTEIO.  nvme-rdma folds every mapping error into -EIO, a
retryable host-path error: multipath requeues the I/O forever, a
single path burns its whole retry budget.

Propagate the real error code and return the unroutable case as the
non-retryable BLK_STS_P2PDMA.  As in nvme-pci, -ENOMEM now requeues
(BLK_STS_RESOURCE) and -EINVAL fails (BLK_STS_IOERR); -EIO stays a
retryable host-path error.

Start the request only after the mapping succeeds, as nvme-pci and
nvme-tcp do.  A hard status from ->queue_rq is completed by blk-mq
itself, skipping nvme_mpath_end_request(), so the multipath I/O
accounting leaks -- today for -EINVAL, and now for BLK_STS_P2PDMA.

Fixes: 23528aa3320a ("nvme: enable PCI P2PDMA support for RDMA transport")
Cc: stable@vger.kernel.org # v7.1: requires BLK_STS_P2PDMA and the ib_dma_map_sgtable_attrs() conversion
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/rdma.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 63830334c73e..c38d949502b7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1486,10 +1486,8 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 		.orig_nents	= req->data_sgl.nents,
 	};
 	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
-	if (unlikely(ret)) {
-		ret = -EIO;
+	if (unlikely(ret))
 		goto out_free_table;
-	}
 	*count = sgt.nents;
 
 	if (blk_integrity_rq(rq)) {
@@ -1511,10 +1509,8 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 			.orig_nents	= req->metadata_sgl->nents,
 		};
 		ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
-		if (unlikely(ret)) {
-			ret = -EIO;
+		if (unlikely(ret))
 			goto out_free_pi_table;
-		}
 		*pi_count = sgt.nents;
 	}
 
@@ -2033,8 +2029,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		goto unmap_qe;
 
-	nvme_start_request(rq);
-
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 	    queue->pi_support &&
 	    (c->common.opcode == nvme_cmd_write ||
@@ -2051,6 +2045,8 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 		goto err;
 	}
 
+	nvme_start_request(rq);
+
 	sqe->cqe.done = nvme_rdma_send_done;
 
 	ib_dma_sync_single_for_device(dev, sqe->dma,
@@ -2070,6 +2066,9 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 		ret = nvme_host_path_error(rq);
 	else if (err == -ENOMEM || err == -EAGAIN)
 		ret = BLK_STS_RESOURCE;
+	/* Peer memory unreachable from this device: don't retry. */
+	else if (err == -EREMOTEIO)
+		ret = BLK_STS_P2PDMA;
 	else
 		ret = BLK_STS_IOERR;
 	nvme_cleanup_cmd(rq);
-- 
2.52.0


