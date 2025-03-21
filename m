Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E06EC36007
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 20:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BAQa7curMMZokpp1idcLqQ2LV/40Bv1e439+xYRqV5Y=; b=poPUvfZQRpb7kUijHAfJQ+VIqh
	sqWAt+e8NmUCKlGH/XiwvsT8ARa2/Ej10QGjh0qQGZg1W/9e/PXu/xAm2Tvri9+KNOvFMGcCceD9H
	HvXtp5mjD/lD5O0vZx6laG0QlEX9nuBNvWJwftIehNeTDor9YpmDKK8ptTWHBQtsxNmhdfJ4GYIOe
	Yhx0/nTat8Ax0HdgMGDPuOX0jlEGpGp9DRKPB4oRQSD0uEfST6QDGT3LJxX6UyM7C+XWq1I9UdUxh
	5cFWzUIDjjZLyTLA2J7USP2FeBkyYdbwAQO6X8oT1+9Uq47ArZg43nTis2/l2PhNnD5hEM/YDpibT
	eW5nph+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvjRI-0000000GHC5-2OXs;
	Fri, 21 Mar 2025 20:58:00 +0000
Received: from mail-qk1-x763.google.com ([2607:f8b0:4864:20::763])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvjRF-0000000GH8l-1G9J
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 20:57:58 +0000
Received: by mail-qk1-x763.google.com with SMTP id af79cd13be357-7c0e36b823fso44963585a.2
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 13:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742590676; x=1743195476; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAQa7curMMZokpp1idcLqQ2LV/40Bv1e439+xYRqV5Y=;
        b=Icub9K+wX6bEDcV/bV1qp3T88LtGpotll1Huzirgs+ed9UBXbc106465xCGViG/aow
         F+zrRHCrXbIUbz5sD2I5Iy+CU7s04xYmz4oSu7S2r5sj+XX7bz0edCxBcyQutyESR3Lp
         +KLkCk3CoIyuQhRc5CuCqizfHQfRm4qD3fLIBbrn3yYd5Ap/kYxscfSrjTTIVMJHgAZo
         1Dw5amhAFSfLb/6aHLJRIM9fmtNJ5QxE+cvcm5D5Ys8IihyxJX9A29sqOmXFIQWcPHUl
         iohi+R2foYKo/szpejtdfmVNAWx/ni/rvej8pXyewiAWu+L5m8fw1BcMiMdNpBzub+Zj
         mD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742590676; x=1743195476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAQa7curMMZokpp1idcLqQ2LV/40Bv1e439+xYRqV5Y=;
        b=AO9Khe5zhrEm3YB7/dFrjU9Dtt1NGyhwRae9hJHR9pZFgORAmfUeg0Vp4f+E8ZQ1iZ
         bTbbGzUxMKRonRlnBSEINe1Tz/S5Tbiqd6EVoUxctzLV9L9ze6HnBI0gUzrm+754dStt
         UULSwhop1ouJQlGeVlrDRzh9e04ybETIvLtQzIswGH4hAZbu5JIB4W2j9rgwVTqID8RJ
         av/oO0l+Dy5sdO4j3lq7lucdw4fpDA8Fvgs/ZlaC5fKZdX1+bnYyj2KG5/jqszvppaZ6
         CYXpkXczyrN2HBFCRC9snCSwmpxusO0ttpltF6xi0/NJIcpCzKadXPeBi9MgqI/LfjWs
         CiOg==
X-Gm-Message-State: AOJu0YwTmbAhkAYA1ficXuFg279mEBxTtIym3vbdX8SpD7Pa9fETYatr
	rwJ2I7/G8lW0BBcdpA3XY0bVNRaiavRF9o410PLkt//KgeQ68XSHaRJjn3Tjx1wOqyFqF7P1AeH
	X20yMbQJLUXK+h/1qb54I/Hs0AgWmXbiP
X-Gm-Gg: ASbGnctqQ5HqlAM6JuPKOOmE3lPFd6R5D34ZQ6iFWuxgTFOzDDibblmz3/Xd54vwoLB
	s5/ztZABjPOU2k+Ad2yvMYc5VjfYnTB7OgQ28EkIAsuGWNszMuuDL1N9zvEx5u+XAS1YJ9V3K7R
	MZDrOq10D0G1IIKt2XXATSozg/iu1wLvM9msMjjRv1zG2w1E6m6QzYIfLjnguqbXsZiHx0liMoS
	JRjQ48upkPfLxv7UzzTOIlPpqLnnslVogK07eg7ss0OdxsXAdn+xLeHtL5TmtcPgIKOr3PjmshF
	YFU+3x62ve04kNEcA5IJYGDdIhh7EnAsif5mG5VAyknSlQlO
X-Google-Smtp-Source: AGHT+IEoEcywwdrdpsNfxd22W+vQnKfycVeMvEhHj3rSWretVHw8fIWoxN23kfgkBMom47MHPGnXOf15e669
X-Received: by 2002:a05:620a:29c8:b0:7c5:6fee:1634 with SMTP id af79cd13be357-7c5ba12f397mr223670085a.3.1742590676104;
        Fri, 21 Mar 2025 13:57:56 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-7c5b931cf93sm13698785a.4.2025.03.21.13.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:57:56 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8F72C3400FE;
	Fri, 21 Mar 2025 14:57:54 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 867A8E4195E; Fri, 21 Mar 2025 14:57:24 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 3/3] nvme/ioctl: move fixed buffer lookup to nvme_uring_cmd_io()
Date: Fri, 21 Mar 2025 14:57:22 -0600
Message-ID: <20250321205722.3947901-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321205722.3947901-1-csander@purestorage.com>
References: <20250321205722.3947901-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_135757_336490_D0B4C9F9 
X-CRM114-Status: GOOD (  18.94  )
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

nvme_map_user_request() is called from both nvme_submit_user_cmd() and
nvme_uring_cmd_io(). But the ioucmd branch is only applicable to
nvme_uring_cmd_io(). Move it to nvme_uring_cmd_io() and just pass the
resulting iov_iter to nvme_map_user_request().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c | 42 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 843371e6e1e2..98489161e029 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -112,11 +112,11 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 	return req;
 }
 
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		struct io_uring_cmd *ioucmd, unsigned int flags)
+		struct iov_iter *iter, unsigned int flags)
 {
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
 	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
@@ -134,27 +134,16 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		if (!nvme_ctrl_meta_sgl_supported(ctrl))
 			dev_warn_once(ctrl->device,
 				      "using unchecked metadata buffer\n");
 	}
 
-	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
-		struct iov_iter iter;
-
-		/* fixedbufs is only for non-vectored io */
-		if (flags & NVME_IOCTL_VEC)
-			return -EINVAL;
-
-		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
-				rq_data_dir(req), &iter, ioucmd);
-		if (ret < 0)
-			return ret;
-		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
-	} else {
+	if (iter)
+		ret = blk_rq_map_user_iov(q, req, NULL, iter, GFP_KERNEL);
+	else
 		ret = blk_rq_map_user_io(req, NULL, nvme_to_user_ptr(ubuffer),
 				bufflen, GFP_KERNEL, flags & NVME_IOCTL_VEC, 0,
 				0, rq_data_dir(req));
-	}
 
 	if (ret)
 		return ret;
 
 	bio = req->bio;
@@ -511,13 +500,30 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
 
 	if (d.addr && d.data_len) {
-		ret = nvme_map_user_request(req, d.addr,
-			d.data_len, nvme_to_user_ptr(d.metadata),
-			d.metadata_len, ioucmd, vec);
+		struct iov_iter iter;
+		struct iov_iter *map_iter = NULL;
+
+		if (ioucmd->flags & IORING_URING_CMD_FIXED) {
+			/* fixedbufs is only for non-vectored io */
+			if (vec) {
+				ret = -EINVAL;
+				goto out_free_req;
+			}
+
+			ret = io_uring_cmd_import_fixed(d.addr, d.data_len,
+					rq_data_dir(req), &iter, ioucmd);
+			if (ret < 0)
+				goto out_free_req;
+
+			map_iter = &iter;
+		}
+		ret = nvme_map_user_request(req, d.addr, d.data_len,
+			nvme_to_user_ptr(d.metadata), d.metadata_len,
+			map_iter, vec);
 		if (ret)
 			goto out_free_req;
 	}
 
 	/* to free bio on completion, as req->bio will be null at that time */
-- 
2.45.2


