Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C236C36000
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 20:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZqACgqSPAGulvpdL72lXsG7CJBHtcdgDXf09Xg+OLKQ=; b=rQSpSy7cCBRNn0UFwM9EVEVYgV
	p1cuJUNyhN21jjAAYad6dXszOfveeFuxiO4C/xH/b7JMoKpt5c7smtt9hZ2U5nKoutIXWZ7lGfv2R
	1oyiukHnrpG5O1tZ+mboM4AWhnF+zKZCuHxY1c8ez3lsd25HlNzUeIqGNOcLWSm7zO8qWzuXtlyVl
	xD4zru9/CsVnaO4Dx/mIf+xW7A3HUHIW3p/D//+2Xo6ofqDIC7F5sM/D1QioF6/ZfoxVham2h6d0n
	nXpCSdqzt7M47QqFYoe3KhIqLxsRgmUJeSygs7db61OQv1L05lST3U2YWDV4rnM/8RAVXloCkV5m9
	y6aUqmCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvj6N-0000000GCcF-1ZT9;
	Fri, 21 Mar 2025 20:36:23 +0000
Received: from mail-io1-xd64.google.com ([2607:f8b0:4864:20::d64])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvj6K-0000000GCbr-3lzX
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 20:36:22 +0000
Received: by mail-io1-xd64.google.com with SMTP id ca18e2360f4ac-85da20b2640so8286939f.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742589380; x=1743194180; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqACgqSPAGulvpdL72lXsG7CJBHtcdgDXf09Xg+OLKQ=;
        b=XHbOsRByDhftnL/WFqmK09MkE5xAFPLNJhWZuQFkpnhShxUy1lLZ9XoC6/9zDPvXI4
         Uq4dPOpdxzd0FSPD4kRx5UH3Fuqt6+jJyfJfXOGTxp0J+nNeNag9xEN6tAULtq8Keed5
         cZtWzvxCbc1843RuC0tobsyKxu8OmgypxQvApSPSKIQrKk9UgRBE459ANMHgmKGWoDfm
         bqIyN0tC+8Yl2pJjTDSyv0tn5gY5xulKbTikb+1QtRlY7IK7z+lChNLlAW6IrQ+V9cvh
         k3o8wK3eg4YO8BwXSw92KM0FmUOoQ5mSPCYWv2vOI8kWCHLO4hV0b3ZrkHd5LTCISXmJ
         dzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589380; x=1743194180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqACgqSPAGulvpdL72lXsG7CJBHtcdgDXf09Xg+OLKQ=;
        b=bT8EvY8p7K+hEloKeCtqE6w3A6ZsepjmcOdsh2smgKhD69Ga5+LE6vy9FlhVyBpvR8
         pqnKEN2Cbw0B7qpMwC084+y3w38XnWDVs4D7grmjPQnbmKrK1ejiP+SoE6uEuvvo16+S
         IBZRFPTTSARheZGOfdQ5vLWZ7Xz6Pawu2DRwjVM3xAzSobSDQkoPx0G9UQrpoBBDwx8R
         xkaxfvrugfQ61K8dfRl/8xKI6+WxPmigFhyFN5U5U5EQdngi1sWipRJ6waCr7VK8CZqw
         IW2lwHnAEreLowumKihuKSj4zMaRWMv6/K2R2mcCJsuck/rQQzAT7oYw61Lh36x/oDxK
         HNDQ==
X-Gm-Message-State: AOJu0YxzYUfF7mILOSAZueBRS/2iJdVCfqrs0sch5VWNdX60w5Gj8elx
	w1sjRdtPFxsxU0H4B0tg+FyRvfEkzJxmjhJuB9V8pwZSCy+3Pbb14MxTWjyGiVT73kpgzB3E81Y
	8V83iH+52W96A/JxGUtZbUJ+mXVhPwrec
X-Gm-Gg: ASbGncsOjbfoyy4naQksaBuosSdTIsSWlfLLvJKR37Prehrge/9XDGaSmdCB+TVzELv
	xKZgtlvlUPOq9QGjzxH9NWV1HNwKy5zWA6ILeE/HqgmGCiB4yc9H2qDPNGp9sog+1RRhgP8oswD
	uzpG2BbS3ZVdoq2hma4BgRKsNdWwf+sYvQ62EilG2LnIZXXou5ujp4OU1H+v9GHQWBdnmtQYEwj
	qoLJdSixDfLsi5OhzPArLnn0e26274vJBpl6K54pzDxhSvxLUHzVltQBDl6pTW2j4Pz6XrU4xqv
	k9WfStfMIJt0rsNBJbY+Z4XZETo3xkaJ9+TVyk1mDIKgSZkC
X-Google-Smtp-Source: AGHT+IFz/L/baFi88SI/B6AQo8HEeKlP34YeQ9tNfbIyl5YFOUJhPLitDbGUFcuADfHCVr0v83V3ri7ENB17
X-Received: by 2002:a05:6602:2351:b0:85e:26b0:e7ac with SMTP id ca18e2360f4ac-85e2cc60442mr113217139f.3.1742589379924;
        Fri, 21 Mar 2025 13:36:19 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-85e2bb0a13csm9932339f.0.2025.03.21.13.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:36:19 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C12AA3402DC;
	Fri, 21 Mar 2025 14:36:18 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BCA23E4195E; Fri, 21 Mar 2025 14:36:18 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/3] nvme/ioctl: don't call blk_mq_free_request() in nvme_map_user_request()
Date: Fri, 21 Mar 2025 14:36:03 -0600
Message-ID: <20250321203604.3911446-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321203604.3911446-1-csander@purestorage.com>
References: <20250321203604.3911446-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_133620_978052_877BD1DE 
X-CRM114-Status: GOOD (  16.44  )
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


