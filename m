Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA93EC36007
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 20:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zQ14CF88ps+y9JKHzrmpWKepjjCRvlmio15JuiIfmyA=; b=thQkda88LAYCwpO1/6eWsS9T1q
	sZueO1UTdX03UhUkBFsMV6JnkweDJvMwIm1in0S49Y0wOiyDeDBXnJMAERlhF5IZ7KjjECT742IMc
	ZtcUI93PtxTEw0rIaltTUbIik2KVV/G6n6XoCBRrqiLCWtT3ICky04qxEnidzoGECQrbHOYKGMC+R
	Z8LiezQg162sF3jKATfPLGA6r8oXyi3tAXsgbLeixQgBbzBZs8LQokHIBGEEK21JiY1VobQfMTyuL
	yNvXNTH+02f0qS+hWsuqUyjYxM1H3nDI+RT39H1Ix58lwUgGk9kVpv5trk/WoSe/cLt/mZIAcQOsc
	tohEqbrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvj6r-0000000GCow-4A7o;
	Fri, 21 Mar 2025 20:36:53 +0000
Received: from mail-pl1-x662.google.com ([2607:f8b0:4864:20::662])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvj6p-0000000GClu-09Z2
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 20:36:52 +0000
Received: by mail-pl1-x662.google.com with SMTP id d9443c01a7336-2240b4de10eso6966515ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 13:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742589410; x=1743194210; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQ14CF88ps+y9JKHzrmpWKepjjCRvlmio15JuiIfmyA=;
        b=E1vXBneUl9Fje5OPtYw3frGvAaBb5HBxgrS5jWpHZFBYvUD+kkwYhIUunMKR2pSKXP
         P5K02IEJUpWb8+ElV2JWLWqTYz2a9drwWdgtDoMKCPV/hPWB4YpyqYVfKX1pHdPl5Lw8
         XrmzQ6TxBNi2Vut2T+mixR7JjBPRFAJpIE0aAUciZnth8H26h563913uoCdmAv0YVsMS
         cLoWJPNxlWTfg9wC1f9HSso8Sd+gxuigkq665aqRk+aSwIMyZ9qRIb1pJPYXzNcz2Eb/
         TU/dWGlfXRoEfXlkdDCDpA7uvYejCYl3PSe38Nexn/WVEMRLmujrVIzaenfKNekSAhHx
         6nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589410; x=1743194210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQ14CF88ps+y9JKHzrmpWKepjjCRvlmio15JuiIfmyA=;
        b=dYtDSdrAeI/eG8A8KkOYxgWy7Gwn1i6o/3mVm6ZPQ0kRHlvTAEqkGxwcdlJjOK+3RK
         cpmT2cwNsH2S9hBNwliEESHtUFL5azRKXR60L3aDJS1D0hxZgb8Uzht9G9xsYieUUo7C
         ZRDcuHEd5eop/3HF8kKnGl+WkhRabgrqYCEaazdu7SypcHDxcJN7d63g32x8kIq2L+iV
         mzuCQe8cCd5OFrqNw0XHR20N1+PULDB/FZuyh/9Lg99OdlcQCazxqFdntRr9E/sxvJ3j
         tg/herhxlstFEWET15M4rAl+Qyxd1gfkCreAxUunvfKG+4jFyww9QCV507JanbbHPVfi
         YdvA==
X-Gm-Message-State: AOJu0Yzh9GovkTLok9K1CnrPor2a87PTRUexZ00eU1HDK5C5PismsRXe
	7krdIObLM2or/Ymf7L2QZMvFDJsmpD/MKT+XEZbuVJ6El5DTzCjjH+a9yD88Ytkat/Vc/kjMjey
	zya0It07uQ302a2FiejHTSs8mb8SpttHC
X-Gm-Gg: ASbGncs0wBY7ZQsfcHvxZs17jVoZXIkWF97kDcbIWyXqtGMedr44FyjCvN2nS/UNOeL
	fLQL8fvjIg3HDrp3SJsiIMYENwUTopjnFAktw+4A+Fb7xvZYN8b3eAGSWy8Qd0KsQ02GiTH6LLg
	Ogam67qWEA3EyLDd7YVgsCF2pLt0gyxVQNsMd+IRFBNnFRZ1oOJtv6mVrbVi86vMq5SbBMzVrcq
	0IqkXdt7PTs/7mU9wm4NbAoziSqdUqvM5zUdHvNb2KUWw5zfo9LjMFQCTQ9OqENmk2VktMo1YX1
	Vy8H5EIf3u78MH8KD7xe2jrtA+CIKGsxf1mOFR2bPrtTvDvN
X-Google-Smtp-Source: AGHT+IFIj6bIjEm/3qgI1qYI4OA5ti99/yOaPrOtq4B6Fitpx4Zxnzfv1pINOLQ0GXzj2xQjYD6Hj0SUAHD3
X-Received: by 2002:a17:902:f641:b0:224:1212:7da1 with SMTP id d9443c01a7336-22780e172a0mr29236135ad.13.1742589410068;
        Fri, 21 Mar 2025 13:36:50 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22780ef2471sm943475ad.14.2025.03.21.13.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:36:50 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 514F53400FE;
	Fri, 21 Mar 2025 14:36:49 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 457E7E4195E; Fri, 21 Mar 2025 14:36:19 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/3] nvme/ioctl: move fixed buffer lookup to nvme_uring_cmd_io()
Date: Fri, 21 Mar 2025 14:36:04 -0600
Message-ID: <20250321203604.3911446-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321203604.3911446-1-csander@purestorage.com>
References: <20250321203604.3911446-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_133651_078651_B5B2BB56 
X-CRM114-Status: GOOD (  18.92  )
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
 drivers/nvme/host/ioctl.c | 40 +++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 843371e6e1e2..feac2c2b33e1 100644
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
@@ -511,13 +500,28 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
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


