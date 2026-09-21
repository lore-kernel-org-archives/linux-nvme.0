Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EA4C982ED
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EHTjFNHsfPkUevAeFTZNd93AhuEIP81I0y/DmV6dihY=; b=NwxRFZqEJmlA8PdaHMufQLaQH7
	anBkwZ3Fzfj6uuTyRIff/HEz297goFvUY1MQU+CmA0DrVP3dY6IojekWruEIxbX7G/Lauv2vpP+Xr
	zzH21fIl+FKzEXmO5nAwcSaCS78vxQPdY9GBxnxvfBJvOYWbQveTlq0fC07zskG8smpWNcPZVQv/P
	TyAc5QE/6gvz7Sd1WMwaa3Hh5m3F4lyn6JfAzWvVtBCB9Nn16hDsRw2+i7Ro89pnbnSu3/6bJJNGH
	S6kcJfSX63UUVI6pSnP5hmj1BBP4QMceT8nmmjOTEMby2zTT4DltuiOTljyjVJOY84lvyDiK4+4w1
	CybrLfVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fWG-00000002Vic-1DXC;
	Mon, 21 Sep 2026 15:01:24 +0000
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eFF-00000002GXN-2vEc
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 13:39:47 +0000
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49e620fa473so17788225e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 06:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997984; x=1790602784; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EHTjFNHsfPkUevAeFTZNd93AhuEIP81I0y/DmV6dihY=;
        b=KLU6qLitLwKK2LH9CVjPgOUv4CJuKWZSFv7q6UUC4IaVgckTsRVXD8nGWa3ghz9ikm
         zytsiaz8r0ERdN25U6LQRzRBqKP1ScvptTYn3sMpHUYe1tegnOzzEPY5V5bYZa4bTXIG
         9oXD3+PwHmfo326GRnPKIzek0uCXpvJ2ivv1tOH7MIzGTJsu1FIND673CnlbN2HClZMu
         uGHdvGxxGWitLCrLb8WuganOmktEH0pOlAw5GU64w3HnG6e7TEcbHFfiQR3k+xvvYpAq
         AkB2v4JVpiOuGkHLsxD7myl+EGXc3AI3hMwwUry2Mr/1Pd1RBAwWfKToMyNeFUDxCx2q
         4apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997984; x=1790602784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EHTjFNHsfPkUevAeFTZNd93AhuEIP81I0y/DmV6dihY=;
        b=XNOUUn20u815p3qzk2FtQ4F7BfiME+lezhPx9XbbjWYA0G1LJqFSrObti4apUrYhn1
         v2Q91lTJGXoOMwBHW1MjekNVQsaT2CPXCBtx8GjNw+9rT9V8LmRBliZw7Toj71fA26bI
         5IoO5KLxg+UFEQUwTRDe64m34MtBC1Eo58PnGI5jKHibX5Qu83IpTNGlaE631tlenZtu
         BPoeIneSS8F3ZrUAPVHAWCJnhSOaNO635O1lr27VFl3oJw0iHyyzjweMr9Ey8jAtWayZ
         ImZgCK8pQ4iuWiClftXPvC3ggiawS8gUG0riRYERiFwlARMsMV9grX464wCIJKF7BPgI
         RiNQ==
X-Forwarded-Encrypted: i=1; AKwUvByOWenxzapqbHiKKbcPjK8BsUFe8BQ6JwPsCutEgRS+9Q+ZQWka4BIqopVMgZHtyueVZWA//nnipnPP@lists.infradead.org
X-Gm-Message-State: AFuF++mIqXmYTW+agN9vKTLH+n+Ne5OchEd/1y4+Tc3MjWycvPzwB6QO
	18hMHVNneYNmnsF89+I4+wJH2KJa8ktiu63le8ycubeDD7G5E2rv9E3F
X-Gm-Gg: AYBFou1insUuleBpRkVAip5+ZvY6nOpGwV5h8OEy7a2qn3dNY+TzYnyI923aso6gA+s
	dhRXS80sJRmRSrUf4kdUr899iwMKyAnMtJKGt4gtMCIII3e74mY8XbxaR1CHdj6Y8H003WjQ/nt
	9/dRaiHqw9qJKW7pbmMECxXSeogbNiANiv4F1L79ejKoUAkZG1rU5NdcDb+RvBNRH5mMAwLV5Pi
	LM9MVqOkaok/+YN5LDfPsuSi2JaHNe3rFX8+VHVgMHNeW6TzG9FW9TevYC/JTSngrDdSsHcUXzG
	zvyQx4XCZqkr519fMjxTy7T7BpFRwGnAGl5ubPr4Kcfjrj1CXf55B41Q6A23dloDM0E8zwxwKpu
	d+TAfT7O7Yoct1I67DdyPdiSvxGaDFb2AilV/9X5EpRht8P3272TzR/6rUF02Pvcuau/YWChLPc
	ioCnH4ZF9RVEELiwqELEiHpbxCG0lqXIfXO9HYRFPab/Cwfhp+S9D4pl9owBSVvA/EZW7EM+kip
	k/P4d936V1YkHSVbxHG9XXbLakPBDyXbsKxMwLaH8PRTtTcTKe7FlJ0OBJZYGpjkjiPsc4y/po2
	j7oq62a2f4hptH2XCnDekgcmMc+bZQ==
X-Received: by 2002:a05:600c:4505:b0:49a:a101:4157 with SMTP id 5b1f17b1804b1-49fc56db92fmr154368075e9.7.1789997983642;
        Mon, 21 Sep 2026 06:39:43 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:39:43 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v6 07/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
Date: Mon, 21 Sep 2026 14:38:51 +0100
Message-ID: <114bc2087c7811c849fafbf1392abd7edfb24471.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_063946_334158_EFF16E0F 
X-CRM114-Status: GOOD (  13.46  )
X-Mailman-Approved-At: Mon, 21 Sep 2026 08:01:20 -0700
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

From: Anuj Gupta <anuj20.g@samsung.com>

Rename the blk_dma_iter based nvme_pci_sgl_set_data() to
nvme_pci_dma_iter_set_sgl().

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3d645324f04e..8dc4002fa696 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1297,7 +1297,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
-static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
 	sge->addr = cpu_to_le64(iter->addr);
@@ -1327,7 +1327,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
 	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
-		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, iter);
+		nvme_pci_dma_iter_set_sgl(&iod->cmd.common.dptr.sgl, iter);
 		iod->total_len += iter->len;
 		return BLK_STS_OK;
 	}
@@ -1349,7 +1349,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 			iter->status = BLK_STS_IOERR;
 			break;
 		}
-		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
 	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
 
@@ -1512,13 +1512,13 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
 	iod->cmd.common.metadata = cpu_to_le64(sgl_dma);
 	if (entries == 1) {
 		iod->meta_total_len = iter.len;
-		nvme_pci_sgl_set_data(sg_list, &iter);
+		nvme_pci_dma_iter_set_sgl(sg_list, &iter);
 		return BLK_STS_OK;
 	}
 
 	sgl_dma += sizeof(*sg_list);
 	do {
-		nvme_pci_sgl_set_data(&sg_list[++i], &iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[++i], &iter);
 		iod->meta_total_len += iter.len;
 	} while (blk_rq_integrity_dma_map_iter_next(req, dev->dev, &iter));
 
-- 
2.54.0


