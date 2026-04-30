Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70512CD3424
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 23:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jt6i0SKzx9XEcc5opcy+3szYxVI7EbWGCIce4HKBwLc=; b=KEYAKGY/WJjWaN8PXhIUM48h8P
	O8RhGCjn1/u8d/0Lx3Yn7NpyPsuqGMQgmN4jN4+eL9d3qklgAlSn8N0DzfuPUmJjsnqDTIfHOUcE7
	if/evh4ww0/4Y/exMvRTo7nE6539XJQFzTizzEBnd95igy55fXIJCPqOeQn1jHrN1fcio1liYmdGM
	xRYN+9Lk0fVcGalN+UGB9M6108nJ6OWMAhCzNxtUgCCw8CL0V3LsABQrjAsXuYHVdxMuP7akSGRdY
	py1uaw9R9pYQ26HtlLKA+6HwSM5XNKl7esj0r+D8+i2bQWpbxajd8HVGS2iisC7rnAKnWataaKNI6
	9ZXhkHNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIapR-000000066gB-2wDo;
	Thu, 30 Apr 2026 23:29:57 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIapO-000000066e4-3Aez
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 23:29:57 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso24956465e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 30 Apr 2026 16:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777591793; x=1778196593; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jt6i0SKzx9XEcc5opcy+3szYxVI7EbWGCIce4HKBwLc=;
        b=Hy6HBOY1yJGHFIMPGfS21JFsSezuZSder2FcCiG3YN8cSCf+J8AGkIiJPRSx3yw5TT
         HvU9/rycsFp6ZkbeOlBcozS/p2IRkgcLTsRN4+VVKEjwbcVkuGXrhnejV+AOJyZwuQ/+
         btVOgKju96mv70Xl/1oIFBEGwTUipycZjD6H1zj4QREcY1FFrZvBen509g2Ke+P2JG9G
         edkNU8InLnMatrEcwOOk/pViWLZ3FNcKjJftvr+BeP9ZRehRtQKyEank6pDaTJ82AwG7
         kyWz9c/vKSctsxf1Ov3xDELtrpKqVRnD0UDOq7WaXu4JNbGu1Wx8XhBbE21H2ZEHuTWO
         zhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777591793; x=1778196593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jt6i0SKzx9XEcc5opcy+3szYxVI7EbWGCIce4HKBwLc=;
        b=Ase5/gkYQyeX49BdfRL/ZXSl44rqQB7D6svdxfwvhaQeW+um7p/UoKX7wMFq3fBHhK
         8IuH2lY1iyj3jgmDdmDygwsEymc4VlOcL+Lx0fidLn24QwXP6eLZ7B2JKB0MmqQDbXa9
         WoD1CAiQKsoFEoQHVEpJreFeRmG/x+C145Vs1g/EeHFCgna0Ubf8fkd+xpd1Cnglkpbh
         Axsb4CsHWkSV9l/wk5aozjqO6a5q3Y+ePSg8UvO/VQHNsZjp3vCDTT4fCPhB+Jrz6Lwr
         e/dOBf3GefOD719qQwzjuX9R7t1glNCt4o2vLgcvyIakWplijagAyDJG2S/r3EHqsq0R
         kalA==
X-Forwarded-Encrypted: i=1; AFNElJ+Q1DbgtYa7OveuiT1CTLCjLHjd86uNWJTjtIxlasSA5Ap+43jZhNTkqySk9G02SWmwuCw2jkxzKcZj@lists.infradead.org
X-Gm-Message-State: AOJu0Yw00zKBjcpmJ8Ezdryt3dqsrjJfS9qPv8mohNsRsyjot1S8F28a
	2ALh5twgwDkt6QLFhEjyehr8KGhFvq2UMr2cG08V1iySXjY3zch/Xh1fJ0o444AHb5s=
X-Gm-Gg: AeBDietoeGXVzTyIoiXBFCJzL0K9sICm6zf/5uim1NtYTc498Pd/Ul1CklZgrP1awat
	NoNOWUBdHgBq1v9gC7aQOu4WNHgkbxLXPT89InibnR3+W6YIsAoTKgbAzXBTaR2EkWFioXITLq6
	SOJRCjffbbRA+eGp7yZWmJkAIvxj4nXa7gKIvU9XqwD5//FJ7W9G9c4jDe7tROWMfhkQqHqMwRB
	aVB4AkYX5dtW2WoT4cjXF0zxaZWDHbWDCXNvtE3Pc/mATDHkAE5MGG8E9dLYHrWzhLMcfrrHAW3
	QG2H5ndJsHZu8KmRzgquifwrhKDuaIicvgBKW9tdK2urlPbqTg4Sg5i1yLL0uy+HlXt3jqTU2Eo
	X+BlTvsS3VqHdu3Qp+B2v7/A4sOJAxr2hBlaXj3e86KqEbVJaWbLl0NjxV0CaqDxw5X29QNvOUr
	Kbq35MH4LcUo/0BEerpKUETK0rC02BQrEaqR4Wjh2XdXycVuTDqDR6+Aw2HtTCUCDPQa2xQ+sKG
	DxqSV8oTN2XDMLRFW7jKT0b6GCI9n8rCBlpihdLYYIdm1ZZ0WsJtIfqDam0ug==
X-Received: by 2002:a05:600c:4e8e:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48a860758c7mr69341685e9.10.1777591792783;
        Thu, 30 Apr 2026 16:29:52 -0700 (PDT)
Received: from dev-randyj3.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a8eba865fsm11942715e9.10.2026.04.30.16.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 16:29:52 -0700 (PDT)
From: Randy Jennings <randyj@purestorage.com>
To: lsf-pc@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org
Cc: cleech@redhat.com,
	mkhalfella@purestorage.com
Subject: [PATCH 2/7] nvmet: put all nvmet_req.execute calls behind a function name
Date: Thu, 30 Apr 2026 17:29:08 -0600
Message-ID: <20260430232913.129271-3-randyj@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430232913.129271-1-randyj@purestorage.com>
References: <20260430232913.129271-1-randyj@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_162954_809277_C8DE5D4B 
X-CRM114-Status: GOOD (  14.95  )
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

From: Chris Leech <cleech@redhat.com>

This is setup for being able to manipluate the outstanding requests.

Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/nvme/target/fc.c    | 4 ++--
 drivers/nvme/target/loop.c  | 2 +-
 drivers/nvme/target/nvmet.h | 1 +
 drivers/nvme/target/rdma.c  | 4 ++--
 drivers/nvme/target/tcp.c   | 4 ++--
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 0d9784004c9b..93b904864390 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2391,7 +2391,7 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
 		}
 
 		/* data transfer complete, resume with nvmet layer */
-		fod->req.execute(&fod->req);
+		nvmet_execute_request(&fod->req);
 		break;
 
 	case NVMET_FCOP_READDATA:
@@ -2600,7 +2600,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 	 * can invoke the nvmet_layer now. If read data, cmd completion will
 	 * push the data
 	 */
-	fod->req.execute(&fod->req);
+	nvmet_execute_request(&fod->req);
 	return;
 
 transport_error:
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index fc8e7c9ad858..678d619083a6 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -127,7 +127,7 @@ static void nvme_loop_execute_work(struct work_struct *work)
 	struct nvme_loop_iod *iod =
 		container_of(work, struct nvme_loop_iod, work);
 
-	iod->req.execute(&iod->req);
+	nvmet_execute_request(&iod->req);
 }
 
 static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5319765eaf5c..acb2f0f3cdc8 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -994,4 +994,5 @@ struct nvmet_feat_arbitration {
 	u8		ab;
 };
 
+static inline void nvmet_execute_request(struct nvmet_req *req) { req->execute(req); }
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 9c12b2361a6d..5beb33629500 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -773,7 +773,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (unlikely(status))
 		nvmet_req_complete(&rsp->req, status);
 	else
-		rsp->req.execute(&rsp->req);
+		nvmet_execute_request(&rsp->req);
 }
 
 static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc)
@@ -958,7 +958,7 @@ static bool nvmet_rdma_execute_command(struct nvmet_rdma_rsp *rsp)
 				queue->cm_id->port_num, &rsp->read_cqe, NULL))
 			nvmet_req_complete(&rsp->req, NVME_SC_DATA_XFER_ERROR);
 	} else {
-		rsp->req.execute(&rsp->req);
+		nvmet_execute_request(&rsp->req);
 	}
 
 	return true;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 15416ff0eac4..fe811b55e0f8 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -606,7 +606,7 @@ static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd)
 	if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
 		nvmet_tcp_queue_response(&cmd->req);
 	else
-		cmd->req.execute(&cmd->req);
+		nvmet_execute_request(&cmd->req);
 }
 
 static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
@@ -1072,7 +1072,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 		goto out;
 	}
 
-	queue->cmd->req.execute(&queue->cmd->req);
+	nvmet_execute_request(&queue->cmd->req);
 out:
 	nvmet_prepare_receive_pdu(queue);
 	return ret;
-- 
2.54.0


