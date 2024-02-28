Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8B3C54E41
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 09:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nwNxh5KU/TPJqtrokiiKhDFcHYcJeUw5wnGYXiE+YAY=; b=g+TyRwkE3mr08QBD3i1slRep73
	DDckNUEfdipcN8RMGrMWZXt8ii3XTcURGpVAR7TxMK5wie2FWsML/9ajiWWVJK3cE7Ddf7pYeNerX
	aN7JIU1oytFtQ4UdC+DpSFUv6/JTYp6WtBpiF1kQdeVe742zERP/3ggcz1i4Qec0hgHQfVMpeLyXt
	rcxuaANwhwWR2IPvzOgu8I/rnf9JqRKyWcGNhCOjz19aWlPIpW66Te21flkB58CY2rx2FPzS/BE7t
	jukv1CFSCoBXtFEm0saOXRXgFCLmcCw4TR8/bjw7drr9LCK7d9CdNG42+98JBgBqhx1a/SgXyppA8
	M4RHPDyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfG19-00000008dBH-14ND;
	Wed, 28 Feb 2024 09:14:23 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfG16-00000008dAm-02zP
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 09:14:21 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6e4c359e48aso3368232b3a.1
        for <linux-nvme@lists.infradead.org>; Wed, 28 Feb 2024 01:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709111658; x=1709716458; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwNxh5KU/TPJqtrokiiKhDFcHYcJeUw5wnGYXiE+YAY=;
        b=jjHauNUK58K5u3gKFdMyVvFf+TCLpz7rIjzHjL0oZa1lDISjNCUiAjlM6+1tTpsDqg
         iEN7nvbJlpp2Je9hN7Gi7OMszNtkp+GisBX/CVnbwXoMm5R/C6CJG5BWi4Rb+rxlLRAc
         wFv5FEnXjxnFPmMlFbVtlQYq39dvWmuEOSf+fT36/jIzgMLNAJqISlUXnPgEKY0teE31
         skjeylNpS0KthtPwlajubBTKt9EXFmo1aEOPiT0s6CFPtOKFmQpf6txg8WXvlyEhBNaB
         5gsdULvr8i8832qgOMGgt3IX/vILs2UETi504nnmEij9qUMxkYGJuH4scZR95lKqqZfN
         R5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709111658; x=1709716458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwNxh5KU/TPJqtrokiiKhDFcHYcJeUw5wnGYXiE+YAY=;
        b=SOP0nk3Som/mRfXhPn2Pk4EnMJU139MsNEER1+bwswnnVh/4NHeQPPsgHBOFL2LX+G
         B40SYpzzSFqs7LwR3OAyoitp2VwZmrZRalOeuDOAsyfWp5Bovnz1VErkABFIaL0w5hZ8
         jYHM4GAYXuO7CY7govfrD1D+zB8AI2Y4u9y2pcTSgR+/Sx6ME1RuhCKn+CeFTYjWB+Ay
         eqV5ZM33ZKRWh5ND7Cw5iJOI5HNTtPKzQv3EMkK8CuNJXuVRvn6Y2BS2xeCmDxZmGD5j
         w81jWBlu3sYyZdNOZfBJAL4Je/AyxvDAKDk2zR8fKd2/ZPpowqn9mtbQd1Tk6qvo8WYT
         yZmQ==
X-Gm-Message-State: AOJu0YwUZY774YO+ccpsW3Q8U6E0LIMFeGQt/H4qy4mTUCbTYzVjtXrv
	DaEkdomBisWEN+OZ4rlOr5l20YCEHNI0wmcbbcvul9wpJ1paexue
X-Google-Smtp-Source: AGHT+IH5NAXcMbuhJpH/Xq9dDpHTumyiizBHH977vYfxaCnejpVQkk9t9d+6zFC8dMykJv5VnZD7OA==
X-Received: by 2002:a05:6a20:c887:b0:1a0:f0a4:8206 with SMTP id hb7-20020a056a20c88700b001a0f0a48206mr5002676pzb.29.1709111658541;
        Wed, 28 Feb 2024 01:14:18 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id sx16-20020a17090b2cd000b00299b31de43esm1058722pjb.45.2024.02.28.01.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:14:17 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: fix reconnection fail due to reserved tag allocation
Date: Wed, 28 Feb 2024 17:14:17 +0800
Message-Id: <20240228091417.40110-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_011420_074680_4D28A8DA 
X-CRM114-Status: GOOD (  14.17  )
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

From: Chunguang Xu <chunguang.xu@shopee.com>

We found a issue on production environment while using NVMe
over RDMA, admin_q reconnect failed forever while remote
target and network is ok. After dig into it, we found it
may caused by a ABBA deadlock due to tag allocation. In my
case, the tag was hold by a keep alive request waiting
inside admin_q, as we quiesced admin_q while reset ctrl,
so the request maked as idle and will not process before
reset success. As fabric_q shares tagset with admin_q,
while reconnect remote target, we need a tag for connect
command, but the only one reserved tag was held by keep
alive command which waiting inside admin_q. As a result,
we failed to reconnect admin_q forever.

In order to workaround this issue, I think we should not
retry keep alive request while controller reconnecting,
as we have stopped keep alive while resetting controller,
and will start it again while init finish, so it maybe ok
to drop it.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0a96362912ce..07ed2b6a75fb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -371,6 +371,8 @@ enum nvme_disposition {
 
 static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 {
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
+
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
@@ -382,6 +384,12 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
 
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
+		if (nvme_req(req)->cmd->common.opcode ==
+		    nvme_admin_keep_alive)
+			return COMPLETE;
+	}
+
 	if (req->cmd_flags & REQ_NVME_MPATH) {
 		if (nvme_is_path_error(nvme_req(req)->status) ||
 		    blk_queue_dying(req->q))
@@ -1296,8 +1304,7 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 	ctrl->ka_last_check_time = jiffies;
 	ctrl->comp_seen = false;
 	spin_lock_irqsave(&ctrl->lock, flags);
-	if (ctrl->state == NVME_CTRL_LIVE ||
-	    ctrl->state == NVME_CTRL_CONNECTING)
+	if (ctrl->state == NVME_CTRL_LIVE)
 		startka = true;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
-- 
2.25.1


