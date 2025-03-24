Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4D7C3600D
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 20:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PBv3iNMxv4+elhFyGCYrja1iq4HKQSGLUCy5fijhOxs=; b=S+Bup6pyaITpt7DiSwC7SIrozG
	tfP4gpgKKoKBU0kt9woYkpMqXk/0+TSH9NdN2lQIOf9hZZIjehgpfHIDc4FogH+1A3Wg6hUwroRTk
	GEjqz5yafHmi7W7q32FNlO9PjuHcxg1ZgTKQs31lRc3NxV/uTYrW+0hFlhenVEg7ZaPhACSEabC0P
	nq7Cy40VOk9G0jAmzhQTLhDvnEMrfyKkfI7LU6E4qZiEPKz09FXIXmen1gvdNdUBTxPosSM79qria
	6EKfIKI1cGSaiTCiA1BV0Sr5jQte0MAcjpoBbgOJt4xdKkLK8WtLJyPSf6OxmTrq09XUaApYAh2p9
	I38OFcjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1two45-000000048tm-2bPe;
	Mon, 24 Mar 2025 20:06:29 +0000
Received: from mail-il1-x163.google.com ([2607:f8b0:4864:20::163])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1two40-000000048s2-2HJE
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 20:06:25 +0000
Received: by mail-il1-x163.google.com with SMTP id e9e14a558f8ab-3d434931f3eso1407555ab.2
        for <linux-nvme@lists.infradead.org>; Mon, 24 Mar 2025 13:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742846783; x=1743451583; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBv3iNMxv4+elhFyGCYrja1iq4HKQSGLUCy5fijhOxs=;
        b=dFzlFamtTFoBk8O9vaBAa3uOJw97NYyPXQFvSVKY0/93vViwsQ08y4skJ6y39oohfx
         05+Htp9iDXC7XFW3rpz7vUN6480RS25MM31hPcfv0oxMqO4EqN7vMRh36OwT/EVCeJqQ
         9Q0KZm+INSDjtHK4ESXJrzvzUy6hrBuGiPAq3zQD/lrLKIkqDN0ffRnRRVM47aJcotat
         vPxRcd0m3xdbsN3zKtLNXQczHw+VN7ipkx4+yXUzcmBgRyqlvf/CMr+NeODeGSf3i1kM
         NgVJw71eyDMRose2kDqnox6v1av7T2CC/7NLf+UQ89IDEcTQLYWJYR/tfJOu850NE+e9
         4QTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742846783; x=1743451583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBv3iNMxv4+elhFyGCYrja1iq4HKQSGLUCy5fijhOxs=;
        b=i4LjlxMXYMKt6FnuW8VIRmqcN93qP7BTJwp5YfLAvza+rMwSK3liJ9Eao9zoxWdyHz
         jqAlyPHUJOefVX4Trk7uL/R1t5/uY2JD7GbPE3Nn6yV+AOvSKxDMBtw3c/lfOIdh2a14
         smLmOhj4NtexnKZshomfiSlp+cQ8ppL6KyBVlaGgzqWSyoJlAQhuv7v139WNUWkaxYc9
         z4PslWKgy8j4r7My3+eZFIVQgn3MB0b/WXNb6zH7SQOtaJ4n5sqwUwdbdkCr1NkWmCX/
         L0hxVlQcmn2Iq73PrYpbVjMPNNAQrOxIEeBg8wIhiAKGAZxT4/W/rFTR2cqFHUdmP8hs
         mHHg==
X-Forwarded-Encrypted: i=1; AJvYcCVyCYst6BTK1auIpq9KWu6QvZzPu+PnIch8eLNcC/kbwFiuLuRurY5T7Yz8Lx9AnnGyhQfLfi/p9zDz@lists.infradead.org
X-Gm-Message-State: AOJu0YyK0sRsWcieyxB+WXYmwNeWTsFCK3pO4yAeQwPlPwc/1o9012Y0
	ZFqKJzRCj7XvHbLx2jMfCZSDmiHC0Fz61BunGx/LdggWAlhHVrlhbaX69Y8voUVDaY+0YN7BPIL
	Ix9BNNrqlbRywZfF7ZZh9Iu+mj8W9LwXh
X-Gm-Gg: ASbGncsQ+9ml3Nb686luXqjie/HRTbcJ6Y68620os8vHfW5bLHt5UNNKe6sBVQ8TNPQ
	CtcLKNp+iqMPOFF9TRx2FddJ/x4A4skknsJGtOqtYClxQNg3qJQSHIKVnN/+e+cHZzgPKqqPXNA
	lZSgqn5LUTUGm1/7+kxuxLsSiIAL63zygHzDWVPJQnlik2CUMeiPdjiH4h6iifDBjp8c/7ljn/y
	cW/MwrhmdrQFI72KL4jzweX5pWxzntHswcDRqBr9Dx07BaxZZ1eyVZim7jG5qNrxldjZ7xmFMWq
	JE2y+cOUYd5tKTqIVtAw2Eops7reDqGj4O/y0WeyM9Af6QSr
X-Google-Smtp-Source: AGHT+IEV+lCwII9GhQtPHGVDcjw8YXVvBkkja75sRJDPkHKdd3G9TROtFMPaXK5/0cUjj2j8hg6M5JXiMBNm
X-Received: by 2002:a05:6e02:1c2e:b0:3d3:fd18:4360 with SMTP id e9e14a558f8ab-3d5961854a9mr39970815ab.6.1742846783185;
        Mon, 24 Mar 2025 13:06:23 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d596095834sm3865285ab.40.2025.03.24.13.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:06:23 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 29F58340363;
	Mon, 24 Mar 2025 14:06:22 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2180EE40ADF; Mon, 24 Mar 2025 14:05:52 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Xinyu Zhang <xizhang@purestorage.com>,
	linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 2/3] nvme/ioctl: move blk_mq_free_request() out of nvme_map_user_request()
Date: Mon, 24 Mar 2025 14:05:39 -0600
Message-ID: <20250324200540.910962-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250324200540.910962-1-csander@purestorage.com>
References: <20250324200540.910962-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_130624_581136_8AC93FC8 
X-CRM114-Status: GOOD (  16.14  )
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
index 0634e24eac97..f6576e7201c5 100644
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
 
@@ -212,15 +208,16 @@ static int nvme_submit_user_cmd(struct request_queue *q,
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
@@ -520,20 +517,24 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
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


