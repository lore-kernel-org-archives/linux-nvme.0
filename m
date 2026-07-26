Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9FDC531CC
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2026 11:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oTKfzdoHRmbK0b3PUxeuF9crncxafNJvwFc9FNFZP5k=; b=zBj3j6Rmhm+ioz6oxuywVq66Vu
	M7v3Q8E4GBJOgGNu/dsg5UfsZiu4IWqToBPWdWHRJaZagzVkazQt2pigEN7vyG4hrb6t9Gjd32i46
	OfXo56fs6gyzd+5i14etle78npnlyfXUk1ZwiQBCKy27GvaNmsPtTRfXDROMb/0LkVSpuAaP/CEUd
	PBCKChW9XLkyV9bcaMvJgmx/81j7RBtxcLIq5U2bEVwqNqQ5CopfYHRoiK0jKLhIIeMICrg39eB0o
	3H74CIg9NzURmaijwxMEx1y5ITne3eKWSNmTZNdqPu432QsySREq1aCE6q51JwEGzcEIPrrdDeXgd
	CTF4Z2KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx6J-0000000179k-16gG;
	Sun, 26 Jul 2026 11:32:59 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx6G-0000000175g-2jE5
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jul 2026 11:32:57 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-4798bea72f9so1106692f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jul 2026 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065575; x=1785670375; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTKfzdoHRmbK0b3PUxeuF9crncxafNJvwFc9FNFZP5k=;
        b=oG+D9b6HzoyU6Sg9tTTkWNqvl8X6tBVqhm5agHQUydZI+ieGU3tC9PuLA7z2WD1kdf
         gltOcNmT+8f94Br9jN3c/kyXiL8khVxKRjnZhi5CNUAaLykjj3ObgzstEn31M62f5zRP
         S2H5qOU/7sCXYfs89Jth7CCysx8GkzNzFHZ0KrsxM7qzGhTyU6b8sgPTPANYQhQUmbWw
         g9h/t3CPwUz56cY4fJ5k/o/fkExcFsFEmfbN4RCWsnp1LGnOhafW5YnlHcHktZIrbv01
         /YBJVTI20vxNK2M5isa3NdquagLpB+/k7E1k95lSQQWv6h7zYiEzuaqAYcIRbQhlyTLd
         NdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065575; x=1785670375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oTKfzdoHRmbK0b3PUxeuF9crncxafNJvwFc9FNFZP5k=;
        b=nChCjhlQluTz8BDAOepT30cC6wlBmaaFY3p+2SZgIsvAOk+AQuR9eqgQWLadxny/ZH
         PG/bMe7DZkquQTd73TTXk5DyT5taUHEQjjAPzmApsQs0nip46kenyoULJ9Fy7Z3q7dXv
         hAP9vw0X+tcIEgDOvi1OUu7TKySI/r/p3B9TUWfROVsgowWlo54keEbCBJxYSFoJ2yxp
         4SWGg/e+NzLIT2pkvnSKMTaM6XYY8C+PchBVz6zgv+/AHCNVft+kB4VxIwhed/kPUqDP
         AwZCUXypn7zFrzvlaE66+Fc4xqlfDZMokTg/8HoZaUF12huSasTPdBhDKj0E+hGgpP6i
         PALA==
X-Forwarded-Encrypted: i=1; AHgh+RrSkZpRmidRNtwURgqJkcr7oDOeLHJYP2oycQ5isVn01Gg/0al+vLD4mUrA0jxIBQe3pz+pdon8Y4Ky@lists.infradead.org
X-Gm-Message-State: AOJu0YwgMzNIQKBDc74GVrSrk/4iOKyu6BwVRwp9vDehXztMP+rZRxRN
	D77dj+tXh1qSXcLYD0ki1+Nwx6iie13Vcv92V14VC/STC52Wn2Dya1zy8HU7P0Ddog==
X-Gm-Gg: AR+sD116yLkNFPcptTVlZwTPa9HkWncyiHxFP24FXqoLWnilLFVaNhSod/5w5+qttPR
	59265YEbDQ65MYm+P3LT4GWffBH9ueNLsh/kbHFW0Lb9jwH1EIpAKaBKnhVaU+cZyehrr4PzdjL
	65pwWE5dA5S5j6AGD52UAyC3wpTJ4/0czrd00ir0MyuF6iSLpVu51WNV/WKLxXrUVeo9bhH46tP
	57t1IcZTw1rSZd3XbL3M4TVwxtNcKJAtf0s6Ixo7QuWI5Hlpj4MdSGctXgV3AD4+w0YKXtbh2vj
	KjVtbz9zyuOCGMokqpjJHUr5d5E0faXLlglqyHPPg5+7e+Vnx51j8ire+9XcyO57M5lpA078bJ+
	HLZFLmpOi3uC2MJsXcyofHtPvW5KUcxK/SnfAYCnhTnagwaEHrBfKK8Kthf0CenQQWLaoZhQr8o
	TFd+oTRKZfJO/5YMbvpH0BPmpxgRXwT7UVzm3n/jLE7O4MUzge0w40U1GKI7Gj2nCO8kS6Tbb23
	SKnZd/Jnv52fHPDURFKKZzEOzp64Aeu5TpMNnpzEA==
X-Received: by 2002:a05:6000:4b15:b0:47f:81c6:5a38 with SMTP id ffacd0b85a97d-47f9fc995a0mr6140837f8f.18.1785065574895;
        Sun, 26 Jul 2026 04:32:54 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:54 -0700 (PDT)
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
Subject: [PATCH v6 09/12] nvme-rdma: use ib_dma_map_sgtable_attrs()
Date: Sun, 26 Jul 2026 13:32:26 +0200
Message-ID: <20260726113229.2154269-10-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260726_043256_710807_9AFF0FFC 
X-CRM114-Status: GOOD (  13.10  )
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

ib_dma_map_sg() folds every mapping error into a zero return, losing
the DMA layer's error code.  Switch both scatterlist mappings to
ib_dma_map_sgtable_attrs(), which preserves it for the next patch to
act on.  No behavior change: failures are still reported as -EIO.

A local sg_table is needed: dma_map_sgtable() maps orig_nents
entries, and the embedded table's orig_nents is the allocated count,
not the count blk_rq_map_sg() produced.  rdma_rw_ctx_init() does the
same.

Assisted-by: Claude:claude-fable-5
Cc: stable@vger.kernel.org # v7.1
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/rdma.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..63830334c73e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1469,6 +1469,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 		int *count, int *pi_count)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct sg_table sgt;
 	int ret;
 
 	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
@@ -1480,12 +1481,16 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 	req->data_sgl.nents = blk_rq_map_sg(rq, req->data_sgl.sg_table.sgl);
 
-	*count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
-			       req->data_sgl.nents, rq_dma_dir(rq));
-	if (unlikely(*count <= 0)) {
+	sgt = (struct sg_table) {
+		.sgl		= req->data_sgl.sg_table.sgl,
+		.orig_nents	= req->data_sgl.nents,
+	};
+	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+	if (unlikely(ret)) {
 		ret = -EIO;
 		goto out_free_table;
 	}
+	*count = sgt.nents;
 
 	if (blk_integrity_rq(rq)) {
 		req->metadata_sgl->sg_table.sgl =
@@ -1501,14 +1506,16 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 		req->metadata_sgl->nents = blk_rq_map_integrity_sg(rq,
 				req->metadata_sgl->sg_table.sgl);
-		*pi_count = ib_dma_map_sg(ibdev,
-					  req->metadata_sgl->sg_table.sgl,
-					  req->metadata_sgl->nents,
-					  rq_dma_dir(rq));
-		if (unlikely(*pi_count <= 0)) {
+		sgt = (struct sg_table) {
+			.sgl		= req->metadata_sgl->sg_table.sgl,
+			.orig_nents	= req->metadata_sgl->nents,
+		};
+		ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+		if (unlikely(ret)) {
 			ret = -EIO;
 			goto out_free_pi_table;
 		}
+		*pi_count = sgt.nents;
 	}
 
 	return 0;
-- 
2.52.0


