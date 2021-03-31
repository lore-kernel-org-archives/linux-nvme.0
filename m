Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D193C433C1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 09:14:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3212D619BB
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 09:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3212D619BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vHPc4ZUIESsKv6kbC9rf2t9LHyFehbb7yKqAiXJs8o0=; b=Lc3QCKHFhCfg5haR3SuJ5VsmN
	LL7iW1k/FZqXd+nqJVgTqFYGs443olQPDEpSyl4W+OCBF3Wijgn/r0qX56hML9V3F2cLy1fytz7I6
	IPEcZzq8fT+aXgVESt51SehgKUm/tRghqRr+kcp0FQQwwwis/9azccd70tn8b0hIsaJ7CO7I3HZrN
	vwJZYwo1DQ42tGYBq9HvR4zjbn/8UBtAup0s23Nh46BMoUGDzB/QaSg3qTvA+lnqlDumvjVH76qdK
	KGACfyBO9M0/SgHHqU/Zx6hdrFwu7UPvlfmfUKeQeX+zcWA+76UH9yMPLgevmibXGAbfGcIBBcIdh
	BHIA6zm8A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRWvk-00650r-Io; Wed, 31 Mar 2021 09:14:28 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRWv0-0064r9-6U
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 09:13:46 +0000
Received: by mail-pg1-x530.google.com with SMTP id i6so6595649pgs.1
 for <linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 02:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5BBYNTAULc4W7lNR3vurDhRnJ5F+q//jFpuy/vThcKI=;
 b=fKOFvJiJ0TW6+JFfu5aROW7jLTWEOmoPer3wkolGMABBoWb5B4mO1E8Xi7NwtzbcWp
 FdhqE8aTrCfSdc9ttQJa/rKHUZg6wFhz79ulxStyirgOXdpbaw3yDIQAILxRsnVc57MO
 MBicz1SE9hNvqv9n859hm2tIINa9qg5I3T5CQ1mqgwLtZV/XPjKEo/ypOnjaAHQpUsmi
 6/bv89hTfjp4463JN3MEXZ1jq3+Xtk+hG9qoD/aVFr7jo/5+liFlr42C4TNAk1TpJU9H
 7CF/rEGpDJkbVsV2vks8pOPuFzKo/f37ZqyFWTKLjQ+apH4/MDee82paRnyggUtxcFvT
 d8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5BBYNTAULc4W7lNR3vurDhRnJ5F+q//jFpuy/vThcKI=;
 b=gopatnI8Z+8vdA4Wif8qk8xmKXStl01eomKyFKmitGT8o+iCdVDt8walm/PyoF81br
 0u1YgLEJX/LVjR76BrK+rEHEkCP+rS9UA3h0XaKupAlmb14vhS1ivXIORGlwbpXb3NV6
 JObCeu4TQfrN6hMTEQwFIxJku5PzIYkQFCAM9iaXBy1o4bGXc51WoW2WaGH7wco7YpGN
 trCe/fIGXhXfKIBCEEzxegRSM0ai9HgbtrtEv8Zlv9/2mBZ3XkrNI/gtKmHurlBmQh3d
 BGE2uL1CDyzRncgn8h+UmnwX0jFTvSBMYC6NsOAjl1SIiluNj5MIBraFj2LaG6o112g4
 NTwQ==
X-Gm-Message-State: AOAM532yGSWuatg6Z5Xrx1pK832q/8qyleNQKhqe/UqnUc+k9hMbLZ91
 GLtbyRG0fmB8gZjbaS1Fq/UZJ+xoVBPzMMRj
X-Google-Smtp-Source: ABdhPJxdxk6FzM0I8xq4GT8fkXSxI8vBskWSMgkvO5J/j3f531blyXfcCvsgcTQaIqUYUr2GgPxlCQ==
X-Received: by 2002:a62:7c17:0:b029:1f1:9ef7:163a with SMTP id
 x23-20020a627c170000b02901f19ef7163amr2073741pfc.51.1617182013380; 
 Wed, 31 Mar 2021 02:13:33 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id s15sm2012837pgs.28.2021.03.31.02.13.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Mar 2021 02:13:33 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: houpu.main@gmail.com,
	elad.grupi@dell.com
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH v5] nvmet-tcp: fix a segmentation fault during io parsing error
Date: Wed, 31 Mar 2021 17:13:14 +0800
Message-Id: <20210331091314.48925-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210331074856.46966-1-houpu.main@gmail.com>
References: <20210331074856.46966-1-houpu.main@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_101342_588899_F586FB2C 
X-CRM114-Status: GOOD (  17.07  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Elad Grupi <elad.grupi@dell.com>

In case there is an io that contains inline data and it goes to
parsing error flow, command response will free command and iov
before clearing the data on the socket buffer.
This will delay the command response until receive flow is completed.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Signed-off-by: Elad Grupi <elad.grupi@dell.com>
Signed-off-by: Hou Pu <houpu.main@gmail.com>
---
 drivers/nvme/target/tcp.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d658c6e8263a..0759eef3f4da 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -525,11 +525,36 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	struct nvmet_tcp_cmd *cmd =
 		container_of(req, struct nvmet_tcp_cmd, req);
 	struct nvmet_tcp_queue	*queue = cmd->queue;
+	struct nvme_sgl_desc *sgl;
+	u32 len;
+
+	if (unlikely(cmd == queue->cmd)) {
+		sgl = &cmd->req.cmd->common.dptr.sgl;
+		len = le32_to_cpu(sgl->length);
+
+		/*
+		 * Wait for inline data before processing the response.
+		 * Avoid using helpers, this might happen before
+		 * nvmet_req_init is completed.
+		 */
+		if (queue->rcv_state == NVMET_TCP_RECV_PDU &&
+		    len && len < cmd->req.port->inline_data_size &&
+		    nvme_is_write(cmd->req.cmd))
+			return;
+	}
 
 	llist_add(&cmd->lentry, &queue->resp_list);
 	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
 }
 
+static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd)
+{
+	if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+		nvmet_tcp_queue_response(&cmd->req);
+	else
+		cmd->req.execute(&cmd->req);
+}
+
 static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
 {
 	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
@@ -961,7 +986,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 			le32_to_cpu(req->cmd->common.dptr.sgl.length));
 
 		nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
-		return -EAGAIN;
+		return 0;
 	}
 
 	ret = nvmet_tcp_map_data(queue->cmd);
@@ -1104,10 +1129,8 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		return 0;
 	}
 
-	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-	    cmd->rbytes_done == cmd->req.transfer_len) {
-		cmd->req.execute(&cmd->req);
-	}
+	if (cmd->rbytes_done == cmd->req.transfer_len)
+		nvmet_tcp_execute_request(cmd);
 
 	nvmet_prepare_receive_pdu(queue);
 	return 0;
@@ -1144,9 +1167,9 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 		goto out;
 	}
 
-	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-	    cmd->rbytes_done == cmd->req.transfer_len)
-		cmd->req.execute(&cmd->req);
+	if (cmd->rbytes_done == cmd->req.transfer_len)
+		nvmet_tcp_execute_request(cmd);
+
 	ret = 0;
 out:
 	nvmet_prepare_receive_pdu(queue);
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
