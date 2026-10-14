Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E8BCC6B34
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=; b=VnunKotlEzz6vjeEoFen2wtLyh
	7i8ZiOWjIr1GIWD3B7anvnE/GLNTF0lALPRO2/Dd9dIglUyaTh7uQ7pvZDfYMZyAKd8ueMD2cAV76
	k3oiNdXuLcXnBCMhRb/koBKom4iSdgwaxJGAYyYKzP9qeODX2HRSF6gBPXEh14ESYAhzFN9c7MqGv
	mwaC11RbImg/RNnBp+6ay6pq8v49E0kEGwUjW3KQmC3/0q4hl/HxPxOPjxkQZS3EQaAYVjgLfF8tg
	ztHZOpL7x5UTDMspS3GK20xn2sT2vioz2npGFqw0LOtKPU2loLCAPgy7tb7qYhlq9lt5y6NW4sHyQ
	0WG2NGcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMyk-00000000ULC-3vqY;
	Thu, 15 Oct 2026 15:02:46 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwkh-0000000FH42-3TZt
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 11:02:34 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso7255535e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 04:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975750; x=1792580550; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
        b=lpoPLVzgvbIokDQaBYP7luYsiaJ8dI/9wzy1rPurpcBsl+O8AHQP0b7cYPm7QwSYNG
         lSJIcTvVkkdaYe8VRYlYNk7OnvWjo/c2iwhSKWrIrPX0myri2YH2wDww61TCJL74MWhc
         +4vt7JLl/IVfGoa8m2PKkjUPCt0ytk/QCZI3WssX9gzNrNocBy0Y14jYC7s0CXXh5YIj
         tKTd8slOpPfW4F0p+LmrabH34otIchWbmLA33cCwb3bEiLVBjV0D1NV7GuzF/NVb4b5l
         o17rFnsBIbo74waKTPvLxMINQiUMu88+t0omspWld5eAxHWARFcuEXLQVVBg/Or5Qu6E
         /mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975750; x=1792580550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
        b=JChgsdduqlJCIGkOMJWZrCAvGXkDGjueqoUdFaYFja9Ep+wlJtRknredQj4ky6wLgF
         aswuFDzwHztLh+cnlfcYJcyQNVQDeC8VVodaR04balWQF8Ur9BDxBwjiFJk8NGtFXv1X
         qb5z/Yq/HjgIVrqcGk7qma/qsm6UwLHBXzlcKKGjB9SSwTIy54IHPLSybB2fafe3bvQk
         CTfh65U4b/MBUG2hVHeqEx0Msar52XLvX/YLKBCT4emIxpR0jEUr79G3dzVhnkR/bWW5
         6DIR5XtNGAJ7+1im3tuN627cDtKFCcEFJoGQsZIS1wg9d/JqR9Wrq44SAW6jSTwwzSMA
         Wxtg==
X-Forwarded-Encrypted: i=1; AKwUvBynxgEJiMZ4SH2czcbG8qWjEyKqtLjyqaSHGk9H8FkIJm1Sv73EUza2PEJrj9y2Uiz808MBUA0zKSuB@lists.infradead.org
X-Gm-Message-State: AFq9FYKHX86VAnh7xbhSscN1YcNirlKfy0geoa3IFZwcdxd1WKhe2P3k
	ReT+ZMHT5cN6nGuKMLAdbMkfgKr9qm8oC1AOVS2eeaXDWfGPXxFpAmra
X-Gm-Gg: AYBFou17W0LqXFQw4xil7+C5H6j0QfszPn4s3Dm5/s/k5JSO0zGGUMpR98looYuOHKy
	rW8Sn8O+9NUHBbw9HzxdsWbPsVUrh9O6y1IVS12lEaQn01ZTzMbTAK3g6sKS80Xd+rja4tZKPe+
	FMnHCYlOHVjLzViaok4CQAzBr5m+a+wB5g2q3k1+19e8aNM+Cuq37aXC4f//nz6ltQOI/nFamYq
	bJ502wMCDWPsW/6Wlmgu1a2nl1m+azbFo/sU+aVEs4rVD6wDmxYh7chpdj6AVDNol+vZFmpcn6j
	rZkA3jcKlMd3ovYnjZ0DEb9fL7nDygoQW73dGhpes/192UYFMm0+9w5o9KT9ttsVtXbbbf/rNv5
	nutrjmHl+Ly5F18uBK9AdOmwmKRurBMmwbEQzyegNMpnPJFrIel+NT2SMMou82yp+uxp0l62sQ6
	qu3R7J1tQtuorc92FD6x53yIdysPoBR/2eKFB+jUkHQWFVJ2q+CRrR2M+zcJYTcGYbl+aqcPyN3
	9hHv2vLm2/dq43R0xGWM1J78OHP3sr/AVLjTr45SSWcAXINqXGM7DBToD/0a+Oc8uZLalI6LjhB
X-Received: by 2002:a05:600c:3e87:b0:4a0:a34:6e7d with SMTP id 5b1f17b1804b1-4a18e4bacbfmr282470095e9.18.1791975749999;
        Wed, 14 Oct 2026 04:02:29 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:02:29 -0700 (PDT)
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
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v11 06/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
Date: Wed, 14 Oct 2026 12:02:04 +0100
Message-ID: <42788b01948b58b891476006cb7ee9f9f5e917db.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_040232_939320_68697C88 
X-CRM114-Status: GOOD (  13.59  )
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:01:28 -0700
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
index 77317e5d00f9..a65b77726e4b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1147,7 +1147,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
-static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
 	sge->addr = cpu_to_le64(iter->addr);
@@ -1177,7 +1177,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
 	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
-		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, iter);
+		nvme_pci_dma_iter_set_sgl(&iod->cmd.common.dptr.sgl, iter);
 		iod->total_len += iter->len;
 		return BLK_STS_OK;
 	}
@@ -1199,7 +1199,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 			iter->status = BLK_STS_IOERR;
 			break;
 		}
-		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
 	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
 
@@ -1359,13 +1359,13 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
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


