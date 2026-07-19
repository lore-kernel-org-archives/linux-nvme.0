Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD7DC4450A
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jul 2026 10:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hybfSCWaTjres2ZZlI9Lu6CV5Kqe33y6xILjvKI8G00=; b=p5ICUUVBU8ZunJuf2RrZ9IN1ZZ
	iHRslNxvY7hBEQF5CychvS20AZBA/XQrmq8mW7mjcpI1gZtkrq8vid4N5ejBSK7sZw3325AeM7ZQS
	Smzi2XgsT0svTHvl5o47YUQvAoeACg3NeFbsqibznvmKY2skiLOKIxf2M8dONq5sDyivSCbCukmuo
	D0SDsBLrkMdTS3lPLzjYyzscyoso0HHDiAHUC/qZqR2NTuRg+bu2h0BRZ4v3/9twtY83AzQaSy1AV
	Vq7rNIGLTiSZ40wId+MR1wPSG3/wFq0AcCnAPKf991pgGihVacOF908c2JuOpb+SZAhSFikTOfplB
	ZHleH+cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlP9R-00000004vY4-0ZER;
	Sun, 19 Jul 2026 10:53:41 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlP9O-00000004vWM-2GgD
	for linux-nvme@lists.infradead.org;
	Sun, 19 Jul 2026 10:53:39 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-49546c690ffso19682725e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 19 Jul 2026 03:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784458417; x=1785063217; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hybfSCWaTjres2ZZlI9Lu6CV5Kqe33y6xILjvKI8G00=;
        b=izegBZfKAIvSYPLAqghiEf7KXz6NH0aqFClCx3rlzhDx0XltVOiPy8RvLMCbPPxIHg
         FwbDsPPe3vPfph63LDPecLJoTyqkRTLse/y80ryOqT6Y9fCDWFnXHmaINdgHM/hCLx2Q
         gxJSlb/tOATZNJQndlcQ59hIg1zBTFdWMhlRzb1OutITD9Z3Z5/ICLlfa5eWoKhRo6bA
         nlB5rszTkwiz+7H4uWbFPgnlY4bzLntq5435eWfDR/evesry4cQCLfsLS9GU3yRJCzvZ
         4EngxXK9wndhdj2g7vNA90BLTgLglVV2A1tgEiEK01huQErNevXGZErkyOB76bqgWaiK
         08Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784458417; x=1785063217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hybfSCWaTjres2ZZlI9Lu6CV5Kqe33y6xILjvKI8G00=;
        b=ruP+G6dMuvnulnRz9P9RW0CNHmeAWPmrYdAowPzru/81Jw+QynFW/2lXdbzQj6zPtj
         DGfqUm9jL3mQhvQJWnn4zYR59A9lwTJ8ktZiJchtNinIPuAWg/bTB0qx9NAzEkfWyhKk
         BV3O2X38bTYb8XkqsqAeNfkkhiWh0FlgWvMHgLVXgQbWVQwkJ+WGRBWvHzB5zIuHUkzF
         kryUBdgYvUoLSND1ijaiZQYg4+wQNGxEH/VIc9uf3ZLhiomD6D9QuJtpK9wjQQHYayfO
         9Rjr21eHYkkDtSvksZOq6FccI4PhTdYCY1rCIBpc9IunnFqUMpj7XKUN56qj+rV9lfwu
         sepQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7Bn1sy4ets5LE1ULH3q77ANUxqJ8yhb9y2Gd5CFbKfaqUB3FSCMFGhvG/0U7dtRxSZWnVVBUmARyt@lists.infradead.org
X-Gm-Message-State: AOJu0Yx31OLa3FGrkrs2321qR87apgb2Hb/kV/naBSsU5GYWqAK0sif4
	sA3MmxY+IhdpgHluA7tz0idcubrgtSkgX45zkY6SMExp3DMDbvC4ak5TStZAn+pygA==
X-Gm-Gg: AfdE7cmoMng7Sr7jPTq60RoOeLD6jY/jgwVipd9Og/06p1RByFhHPHnqRRxDViREkDY
	VY+DC6jdcHHPZXsQIunr+rJfjq5oAvsOna4vWh8aSR/+Po61v1B9beD/grhpfO1iZBuG9fP2rZK
	U5wgGFT8Sew9wB08q9DCbaoQM8flMOBQAyPbsxED/Q+cEnXM/Jnkl47kfu8KLxeNT1CYzoNZWYp
	L5NuJ+fPyLs8Mp3U/JMhzYj5FJ6pMCNVfjGQL3yn5b9+iTa+7Qk+GWGnM6slSGyBI//NeX6KKGA
	Zkyfr/zpVjm+2JU74aUlzuC3Ju2RzXML7M2/+38I/dktCcV98lKfR7uY/pa+UwNWGPtH9Ixi02r
	hPT+o9x27pWGaYNgrObsKcE1zvECPsRTaiTtyaIOLZIoO4ODWBNFAexFx7rBMpw==
X-Received: by 2002:a05:600c:e54a:10b0:490:5057:f5f7 with SMTP id 5b1f17b1804b1-4954a3ed516mr73355155e9.11.1784458416521;
        Sun, 19 Jul 2026 03:53:36 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a24b6sm197679575e9.3.2026.07.19.03.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:53:35 -0700 (PDT)
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
Subject: [PATCH v2 1/7] blk-mq-dma: restore BLK_STS_TARGET for unsupported P2P transfers
Date: Sun, 19 Jul 2026 10:53:21 +0000
Message-ID: <20260719105327.864949-2-mykola@meshstor.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719105327.864949-1-mykola@meshstor.io>
References: <20260719105327.864949-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260719_035338_621395_8AF9AAE2 
X-CRM114-Status: GOOD (  15.27  )
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

Commit 91fb2b6052f7 ("nvme-pci: convert to using dma_map_sgtable()")
deliberately mapped unsupported P2PDMA transfers to BLK_STS_TARGET,
matching dma_map_sgtable()'s -EREMOTEIO: "When this happens, return
BLK_STS_TARGET so the request isn't retried." The conversion to
blk_rq_dma_map silently changed the status to BLK_STS_INVAL, which
regresses two consumers:

 - md/raid1 and raid10 ignore BLK_STS_INVAL leg failures
   (commit f7b24c7b41f2 ("md/raid1,raid10: don't fail devices for
   invalid IO errors"), where it means a request-shaped error that
   fails identically on every member).  Since commit 02666132403a
   ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
   P2PDMA bios reach md arrays: a peer-memory write to a member the
   peer cannot reach is counted as written, the master bio reports
   success, mirrors silently diverge, and on a topology where no
   member is reachable the write reports success with zero copies on
   stable storage.

 - the failure's classification flips: for direct NVMe consumers
   (nvme advertises BLK_FEAT_PCI_P2PDMA) the mapping failure has
   surfaced as EINVAL instead of the documented -EREMOTEIO since
   v6.17, and blk_path_error(BLK_STS_INVAL) is true, so a stacking
   consumer would treat it as a retryable path error (dm-mpath is
   the only in-tree blk_path_error() caller; P2P bios cannot
   currently reach it, but the classification is wrong on its face).

Restore BLK_STS_TARGET.  md then routes an unreachable leg through
its per-device error handling (badblocks, mirror
retry for reads); a later patch in this series teaches raid1/raid10
to handle mapping failures without the retry storms that machinery
was built around.

Fixes: 858299dc6160 ("block: add scatterlist-less DMA mapping helpers")
Fixes: 7ce3c1dd78fc ("nvme-pci: convert the data mapping to blk_rq_dma_map")
Cc: stable@vger.kernel.org # v6.17
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 block/blk-mq-dma.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index bfdb9ed70741..2eed06bfe791 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -190,7 +190,15 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 	case PCI_P2PDMA_MAP_NONE:
 		break;
 	default:
-		iter->status = BLK_STS_INVAL;
+		/*
+		 * P2P transfers that the mapping layer cannot support
+		 * report BLK_STS_TARGET, matching dma_map_sgtable()'s
+		 * -EREMOTEIO and the pre-blk_rq_dma_map nvme behavior:
+		 * the failure is a property of this device pairing, so
+		 * it must not be retried on another path (blk_path_error)
+		 * nor be mistaken for an invalid request.
+		 */
+		iter->status = BLK_STS_TARGET;
 		return false;
 	}
 
-- 
2.43.0


