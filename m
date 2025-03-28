Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0705BC36014
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0mVM8AOP/uQwd1MDpgpJ58oiDfod93l3Y9l0W6NadbQ=; b=x+nr2SXtT8Vxu5CQp18KXXOhFN
	aGkEjAIkAmLkCm6qDnG85EuoTlBYFD/ay28aFuQsD51YOF6BmjkVp+MdE/ULYlnpDBQReUQNYl5Ur
	Mb8ZatW8pMxQALesASx9jCFT6Lz1dxdQfDuB7CB0VdJh1yJ7i1KNJvgQVAVa6PBqYYWtf4Na6CRBJ
	ibJ++S1+Bg9FVIwroBYq9diXnq9BpUo0TA1Hh1LC8tVcDfYuyDZroHn/ldrSDJgNSBEgcYHO4wbuA
	hm8MXJDB8veme5bTvIo7+Rp/rE5sr2hSGHVynBseVTye1PSAHWHJLtOAHN8W/Qwuefg3Va2htJEd9
	KhO8zcmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyC2O-0000000DpHK-0Bob;
	Fri, 28 Mar 2025 15:54:28 +0000
Received: from mail-pl1-x662.google.com ([2607:f8b0:4864:20::662])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyBvS-0000000DoBl-0EBv
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 15:47:19 +0000
Received: by mail-pl1-x662.google.com with SMTP id d9443c01a7336-227c7e4d5feso6375885ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 28 Mar 2025 08:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743176837; x=1743781637; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mVM8AOP/uQwd1MDpgpJ58oiDfod93l3Y9l0W6NadbQ=;
        b=Q8qlB8ftgrwPeOUgiNMdFng7IoZQ1QZYtGtgAPg4/5YPtlpUJgt9GbMjyWY5QegTBU
         +DZpPvbM81KvW+3BGbGed+DEkZrJXDevkLnqvVy661JS/4adOxxNefzujlFPAyFOdh4u
         FyvWqda7I5fUeJeTqjCQNAP1euVGrAGs6gyh2/Gu45MSkETviZqzp4osCXtXL3H4w+G2
         POzS8HBAN3BUNgDf1ggV0prrDEbgicvgKAg/OGg44CVbCQ4M4xPuCfVvHL5MdPuPBONs
         5i+vk0KbDbNxuPUrlCnbyNF98xbS0UxXsVJyBpL6JpdWk/andIL0jJGSNasEwKoIy3+t
         XVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743176837; x=1743781637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mVM8AOP/uQwd1MDpgpJ58oiDfod93l3Y9l0W6NadbQ=;
        b=pDHLUDvNeCa6d1H708p6Nb5sVVxlvs/IeEI7i1beBl67l37eXGmZAIeCctWEcgXi04
         nar5utb+qeZUFfZ8LVxf6Spf0VPUUdt38lof9BC7US1MroFS3xx9mVpYrl2zPE5tkmVO
         FBSE8Keh3ieOpALyCzhKz1fRe9B2BK8xrVEa18wGQAUHpcIJF2fupcY9pKlhb5T0VTn2
         imX6FkNaJWt2YamuCS5ojHk0ZeEKlqCF1dSa4p9OzzUQgba45llV1SPjh/u5MSIsvoiN
         mu+Uqf/9NeiCbCOCwl4n5cFqvOpLGJ4mh0nsnp2112aqYbeYws/9rlpTYY51MRDEB+KL
         RpxA==
X-Forwarded-Encrypted: i=1; AJvYcCU07dg2qzfVSbvLhLfIW2lhOmpIOguf6QTAzC68013RO8L55C+yAriwFrapZITC8lycijKYzPehOSIb@lists.infradead.org
X-Gm-Message-State: AOJu0YwiGFH1SMA0107BXHXaR8UDxejUAk9EgXa3J3BKrKkkfXDJwwQV
	ipYZYB1+yrGdSDz6Sfzp9KZlYJqgEXoOXx5/i+G+tfelcMZlk6CIA6iQiPOHjzbSedzBqP+5aC1
	bLKeb8g25OWNZPR17CIEEtn0Ax1zGssUhLGXYUCtP7WkkkGZf
X-Gm-Gg: ASbGncveNRii2TC8SADEc02t12J8gRMj/RL5XiC3mA+RVkBU9Wwzqxc9sVQfiy5V9CL
	HYsBgKbVyhbd558fP/Q/QYF03gIPlY8fiScPIZdzsQhW90SInQNqvEhXUqI2DWU8yEmjfoYTDds
	s82/IadP7oAeuEhVL0CPmMSsMx+NJGOf0+DXY8DBJKzqk0RdBN4pJuvSFaauiNVSc1u+dgnL7Jr
	8Q/KJd+79gsySbMqGSPfQdv2mqDMJ6pN9rJrxKpMwZGsKEitaSxrzbPcYch4WjflyienCpO2GgN
	2ZPWu6kyOndB6prsTOmzmYicq2f5ZgLNSw==
X-Google-Smtp-Source: AGHT+IHcHduh5E0s2skNSV47XrUM4N9lgZTh46ndYiV2vIM8885gcd/Exi/meEMDt1hOO7Sm4si1VNwfTQYp
X-Received: by 2002:a17:903:985:b0:223:28a8:610b with SMTP id d9443c01a7336-229200f26damr22792405ad.14.1743176836796;
        Fri, 28 Mar 2025 08:47:16 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2291f1db993sm2730225ad.126.2025.03.28.08.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 08:47:16 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 31D4F34018F;
	Fri, 28 Mar 2025 09:47:16 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2FA11E40A9F; Fri, 28 Mar 2025 09:47:16 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 2/3] nvme/ioctl: move blk_mq_free_request() out of nvme_map_user_request()
Date: Fri, 28 Mar 2025 09:46:46 -0600
Message-ID: <20250328154647.2590171-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328154647.2590171-1-csander@purestorage.com>
References: <20250328154647.2590171-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_084718_093395_07461C6B 
X-CRM114-Status: GOOD (  16.03  )
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
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/ioctl.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 0634e24eac97..42dfd29ed39e 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -127,41 +127,39 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
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
 				rq_data_dir(req), &iter, ioucmd,
 				iou_issue_flags);
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
 
@@ -174,12 +172,10 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
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
@@ -200,11 +196,11 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	req->timeout = timeout;
 	if (ubuffer && bufflen) {
 		ret = nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
 				meta_len, NULL, flags, 0);
 		if (ret)
-			return ret;
+			goto out_free_req;
 	}
 
 	bio = req->bio;
 	ctrl = nvme_req(req)->ctrl;
 
@@ -216,11 +212,14 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		blk_rq_unmap_user(bio);
 	blk_mq_free_request(req);
 
 	if (effects)
 		nvme_passthru_end(ctrl, ns, effects, cmd, ret);
+	return ret;
 
+out_free_req:
+	blk_mq_free_request(req);
 	return ret;
 }
 
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
@@ -520,20 +519,24 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, ioucmd, vec, issue_flags);
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


