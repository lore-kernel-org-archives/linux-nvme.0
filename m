Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0503C36008
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 20:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZqACgqSPAGulvpdL72lXsG7CJBHtcdgDXf09Xg+OLKQ=; b=iTvSiDvHOZnMIBicR39fIR5D50
	oGAwk7ONLjeW8yu3PYViQyO0g5Po/7uyK0QrNJgJR61qxYkv3Qh+WCePt7dKmph2+NBulvqhEFXev
	NFeoNq5gK86UQ6timD91aDA691eVW0UFtksPXCZz+ztQrHpWCxX4ietdVh7jaFezg+osI85sG9/qF
	uYFv6PSFinkYUGz87hJwwY+QiBJVjGtF5/qKykKi9TYwiEuJFMTt/+AvWkKweIbqKGsyIMuI3Oh3T
	z/uTHgxrxuTzoIrDF+L7+shwJWi0pIvhOgGiJtvqYkoL1ON5MmTu6fzH2nQDhz69KZSlh8H0pF6yT
	rvcYthgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvjRH-0000000GHAt-0EHJ;
	Fri, 21 Mar 2025 20:57:59 +0000
Received: from mail-pl1-x662.google.com ([2607:f8b0:4864:20::662])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvjRD-0000000GH82-2ElJ
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 20:57:56 +0000
Received: by mail-pl1-x662.google.com with SMTP id d9443c01a7336-2241c95619eso6378355ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742590675; x=1743195475; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqACgqSPAGulvpdL72lXsG7CJBHtcdgDXf09Xg+OLKQ=;
        b=b1JGokwaH1zmgdCUYCUzuCajlNwT4HZxmsXci3ZSAFDc/RRMkrviITZznQ4voXynuZ
         IrfBRG4x67bj95Pbua2N4A0EAB7nkIIhVybceNynm9I/x3rhncceWj9Pkbg/DU+Wh5c3
         PBOazv60ouU+4wF2j4F/nqXE0IpYyYunb+2t8E5eInaHi8GPPpa4FdwWd6YjJAmCUZub
         J1og1ockZZxmOCyWkjZxyzWn+60n5D2W7tG0M5etYc5YiuP5Rcmbp7vXPchkHJjTUcKr
         VigWOoulf140ytfpdWzkBP51TBh025uuFtZvZW/Px3BMXLLUht+9+ri6lXXTaicGOHYN
         7znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742590675; x=1743195475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqACgqSPAGulvpdL72lXsG7CJBHtcdgDXf09Xg+OLKQ=;
        b=BY2J0zci+ZWlR7EuGIOx8PV53TUkC8pXvgyaMcOvDwafLGz9TxQkgcoNAjAsJN/CL0
         Cb4EIc25k+s4DMzLQJK5FstZDKv3s6HGkRBEcfXiC3YABjVsxuQPouLIcBbN/ILNJ6j+
         74XI2cQZUVKrRPnzVs9NvjIO1CvA597gIFGdA+qpdV0uA5Y2/HLMScGDpMKHnZRdWKKN
         I6q9DaPxNX0IyQFVgaxux1DdPJY60DtYM3m7C7BDsU6eele15o/hQC67G0M+fzXRK7Qw
         R6KY67RYxSuHDVzoBNqaCf43xm65Qo+KkL1eUN3+WQErTgp9auIU08KCrhGlrFhik9oe
         +pZA==
X-Gm-Message-State: AOJu0YwX0pTl/Yljb5JfwLFAdEEei7jtw3ASOwsa/waSdmdkSNK2Ld/6
	f+XaCTwl7yJ9bqQ9RI7YJGOzohhVOijb4huY8HXfH7TgeningDEjf2fBnYPhGmbPMGrB9n4WuBi
	CQxUjsZSkojF1haMobZMzquBL6v752Ih0XtpGPJWWMxH6mpZn
X-Gm-Gg: ASbGncu7JgI+kwKCrFnjxaCm+T9k0YIQ89tXfIsvYJXt/nixH+pbH6aDCsaRo6+DcKQ
	sRckMbfJ4plTWG3bYKnUwrSZJlUfHqjXhnQxu1ngmWLw2O+PAnWRO5fOGTDP/tIjcsL6gVPu3ps
	xx1YvTYaE3Ui7OvAY5/q5UGR7oEMf1SHfxOjCwd9zhcwpOQSc81HO2do2YgZXGkfWbmNNx3JOJ9
	ihsoQ9uXhJ798fpCz/FlsIrN27UfqyO9iIJH+4fSjMsbgo19Y/7Ujt1KYc0L651t67/MEnXJi3B
	nugmPc0VANl+6zfnxpeP6P2+CUiVxSUL6g==
X-Google-Smtp-Source: AGHT+IEaGairhpn8t9yDvUk8suCFhpcyk6iBi2A9vV17xzcU4/YSuUiQ14iekBObKOIJ+plm9Q03wWYMW1RU
X-Received: by 2002:a05:6a20:431b:b0:1ee:e167:1f36 with SMTP id adf61e73a8af0-1fe42f55affmr3471813637.5.1742590674800;
        Fri, 21 Mar 2025 13:57:54 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7390602a27csm136934b3a.15.2025.03.21.13.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:57:54 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3402C3402DC;
	Fri, 21 Mar 2025 14:57:54 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 28A2DE4195A; Fri, 21 Mar 2025 14:57:24 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 2/3] nvme/ioctl: don't call blk_mq_free_request() in nvme_map_user_request()
Date: Fri, 21 Mar 2025 14:57:21 -0600
Message-ID: <20250321205722.3947901-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321205722.3947901-1-csander@purestorage.com>
References: <20250321205722.3947901-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_135755_562912_FA93EAF4 
X-CRM114-Status: GOOD (  16.46  )
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

The callers of nvme_map_user_request() (nvme_submit_user_cmd() and
nvme_uring_cmd_io()) allocate the request, so have them free it if
nvme_map_user_request() fails.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 6c27d72e8cee..843371e6e1e2 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -126,40 +126,38 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	int ret;
 
 	if (!nvme_ctrl_sgl_supported(ctrl))
 		dev_warn_once(ctrl->device, "using unchecked data buffer\n");
 	if (has_metadata) {
-		if (!supports_metadata) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (!supports_metadata)
+			return -EINVAL;
+
 		if (!nvme_ctrl_meta_sgl_supported(ctrl))
 			dev_warn_once(ctrl->device,
 				      "using unchecked metadata buffer\n");
 	}
 
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
 		/* fixedbufs is only for non-vectored io */
-		if (flags & NVME_IOCTL_VEC) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (flags & NVME_IOCTL_VEC)
+			return -EINVAL;
+
 		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
 				rq_data_dir(req), &iter, ioucmd);
 		if (ret < 0)
-			goto out;
+			return ret;
 		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
 	} else {
 		ret = blk_rq_map_user_io(req, NULL, nvme_to_user_ptr(ubuffer),
 				bufflen, GFP_KERNEL, flags & NVME_IOCTL_VEC, 0,
 				0, rq_data_dir(req));
 	}
 
 	if (ret)
-		goto out;
+		return ret;
 
 	bio = req->bio;
 	if (bdev)
 		bio_set_dev(bio, bdev);
 
@@ -172,12 +170,10 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	return ret;
 
 out_unmap:
 	if (bio)
 		blk_rq_unmap_user(bio);
-out:
-	blk_mq_free_request(req);
 	return ret;
 }
 
 static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, u64 ubuffer, unsigned bufflen,
@@ -198,11 +194,11 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	req->timeout = timeout;
 	if (ubuffer && bufflen) {
 		ret = nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
 				meta_len, NULL, flags);
 		if (ret)
-			return ret;
+			goto out_free_req;
 	}
 
 	bio = req->bio;
 	ctrl = nvme_req(req)->ctrl;
 
@@ -210,15 +206,16 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	ret = nvme_execute_rq(req, false);
 	if (result)
 		*result = le64_to_cpu(nvme_req(req)->result.u64);
 	if (bio)
 		blk_rq_unmap_user(bio);
-	blk_mq_free_request(req);
 
 	if (effects)
 		nvme_passthru_end(ctrl, ns, effects, cmd, ret);
 
+out_free_req:
+	blk_mq_free_request(req);
 	return ret;
 }
 
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
@@ -518,20 +515,24 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (d.addr && d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, ioucmd, vec);
 		if (ret)
-			return ret;
+			goto out_free_req;
 	}
 
 	/* to free bio on completion, as req->bio will be null at that time */
 	pdu->bio = req->bio;
 	pdu->req = req;
 	req->end_io_data = ioucmd;
 	req->end_io = nvme_uring_cmd_end_io;
 	blk_execute_rq_nowait(req, false);
 	return -EIOCBQUEUED;
+
+out_free_req:
+	blk_mq_free_request(req);
+	return ret;
 }
 
 static bool is_ctrl_ioctl(unsigned int cmd)
 {
 	if (cmd == NVME_IOCTL_ADMIN_CMD || cmd == NVME_IOCTL_ADMIN64_CMD)
-- 
2.45.2


