Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDCCC44507
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g9uaSQKgRYycyhIZh4YO2D7JgllBA2edWOd9mXDhcfM=; b=PVRjAvwrM1ON9KrXxi2Uzil2OV
	2pXOo+XVe33C2R4bhF0M3d0JHhocLznIJrhHC0WXA++Jm2oPow225fUYmTDPyLCB/wyMzN3ytIlWk
	+bdkAE/P4r7YFiJWcyHwHlwjfiGfqLHnil/W3nLe0oh6fQgOLHVsluHe51rqtbZRDO4zS65JpN1DD
	X6RMwACwuW3fK0jv18s07WzgQVNpW3DDdP+2mv1RiF4mW+gE+VaIwD5W0zjxk0EYeJWNPGvlGocGx
	YBP+WO74oa/N7F67X0tzLIjKY0aOpaD/tzcinORiSjDAXCi5byEca25GpoHoV0A6vjcx7Q61qnKUd
	Ykkk7qqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsv-000000071bf-0aG0;
	Sun, 12 Jul 2026 02:25:37 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijst-000000071Y0-15zF
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:36 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-ca12086c06eso1753166a12.0
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823134; x=1784427934; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g9uaSQKgRYycyhIZh4YO2D7JgllBA2edWOd9mXDhcfM=;
        b=P1j2/ix8w5NefLjvjh4RHNU0zbTWHOgOvr3oIgotRa6UjGtXoUJpTGA38tvQ0DfSMP
         2yGCX4LlH/pefrnlgNfdnrY1mprug9OCGuEhsTXTqBTn2HgDGo+NsJ0NUqwm+dk0HUHK
         UFGsCA6Z/uVwmUbVHt6LUSGFcr3vksrmqTCnzevuJHKKCUonj/+n1AbzcfK52W/67ojh
         jQbGCiJHnSJ3q3ffm78jj3Y3bIF9p/q4kRXfI2pYxnu4j26kUSey7ftJoRSMewcsJSHn
         1MwfvGBMeVxnGF6NPbZRgUCWiI4ctbrYxFxGW8+g0Wy4H2/YeG24F6sLPlzyVQyZBh9K
         IFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823134; x=1784427934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g9uaSQKgRYycyhIZh4YO2D7JgllBA2edWOd9mXDhcfM=;
        b=a0mWQDtDXpQ5m7q/EBcnl/poSsY67ko31cnmdWKpyw2PS+XHXDNs0WuKhrUIHgOJLv
         odEH+VTCOO76AN+pW7v5Ffev5qgrNFCR/vmmd0qxBIV9ktqJZJa1FV+q051jPJ+VklTq
         SBY62+AHr9qsNpIAAYrYQKAVrEBMD4FGI9Ot3y6QBFVab1KKnJVlYR1W5bF3BbAhbTlT
         pW9EAd93+3dLQIrrK/5qP+Eq5AUuk7g54rtw2rxWtW/3poDG/2K2Jxd4UQyQ4LXkD1fG
         KVPGj5xpImQWJalptkzjlHzD4gQy07getAIbNIYewOmX8Sno6c6KOj8aX+kuTpoyUDIw
         zC9g==
X-Forwarded-Encrypted: i=1; AHgh+RpYiWQTXSchKjpN6t/zH/mgmQm2Qf1tnZRUjqyr4ByHChylerLo+QB+mUDkV3olfEmzhcANViOJrzL0@lists.infradead.org
X-Gm-Message-State: AOJu0YzLk38smt3ultLgx1aXQYsHCJU3vxdVdr7htJaHxfodcLVosTgD
	krtp8IwAz5NiI4oVEgvT7Nj3ew0AOzy5ugUM4/PgzQBBp77RDaLR+uZKWSgvFf7gc+8=
X-Gm-Gg: AfdE7ckiUcAxZrau0spLr9PbxX2gwKYXS9vcnmix2X1xUDBFbcwBRfsbjmRQmx9YSic
	d0nD1JZPcChkTxo9PmPJghA40yzs3cCjbfmhD/zqUndaQIPPJ465FlLSk3B/SNf577OEaDpE3yd
	e22eBkQE4uKwEoXLa/Eyw9RuX5x/zQO6q/62lCzNJbp/XkEBp/6mikMH6UJBXbO1OscUgT/TK19
	whrFd4EtWtfkVhEH/xfqInJhXMbFPvLqfMEZUl/lU2Wv++hELgl3rRjF9NlJIJXe4UNekskA/6X
	rw9r8ReLSxLy/K9txf995juaMs488yJjLWSfMIecWPp17O7Knhlr2lzp5zD1mAXssPliMN2TPci
	2v91SzrhzwEatmjsu82AAVTYxGT/YMoPJ3q8MfjM4Ek6OjOGyNE31/CjiwkQ9aoAaBMXh7KumQz
	4ANjsiqSGA1/G7FHs=
X-Received: by 2002:a05:6a21:6f12:b0:3bb:21ad:40d8 with SMTP id adf61e73a8af0-3c1108c79c7mr4770482637.39.1783823134207;
        Sat, 11 Jul 2026 19:25:34 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:33 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v5 10/16] nvme-tcp: Use CCR to recover controller that hits an error
Date: Sat, 11 Jul 2026 19:23:31 -0700
Message-ID: <20260712022437.3743117-11-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712022437.3743117-1-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192535_304281_6F0A3BF1 
X-CRM114-Status: GOOD (  14.55  )
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

An alive nvme controller that hits an error now will move to FENCING
state instead of RESETTING state. ctrl->fencing_work attempts CCR to
terminate inflight IOs. Regardless of the success or failure of CCR
operation the controller is transitioned to RESETTING state to continue
error recovery process.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/tcp.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..a1711dd1d3c2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -161,6 +161,7 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
+	struct work_struct	fencing_work;
 	struct work_struct	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
@@ -605,6 +606,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 {
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCING)) {
+		dev_warn(ctrl->device, "starting controller fencing\n");
+		queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->fencing_work);
+		return;
+	}
+
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		return;
 
@@ -2494,12 +2501,29 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
+static void nvme_tcp_fencing_work(struct work_struct *work)
+{
+	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
+			struct nvme_tcp_ctrl, fencing_work);
+	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+	unsigned long rem;
+
+	rem = nvme_fence_ctrl(ctrl);
+	if (rem)
+		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
+}
+
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
 				struct nvme_tcp_ctrl, err_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
+	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
 	if (nvme_tcp_key_revoke_needed(ctrl))
 		nvme_auth_revoke_tls_key(ctrl);
 	nvme_stop_keep_alive(ctrl);
@@ -2542,6 +2566,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, reset_work);
 	int ret;
 
+	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
 	if (nvme_tcp_key_revoke_needed(ctrl))
 		nvme_auth_revoke_tls_key(ctrl);
 	nvme_stop_ctrl(ctrl);
@@ -2667,13 +2692,15 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
 	struct nvme_command *cmd = &pdu->cmd;
 	int qid = nvme_tcp_queue_id(req->queue);
+	enum nvme_ctrl_state state;
 
 	dev_warn(ctrl->device,
 		 "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeout\n",
 		 rq->tag, nvme_cid(rq), pdu->hdr.type, cmd->common.opcode,
 		 nvme_fabrics_opcode_str(qid, cmd), qid);
 
-	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
+	state = nvme_ctrl_state(ctrl);
+	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
@@ -2928,6 +2955,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->connect_work,
 			nvme_tcp_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_tcp_fencing_work);
 	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
-- 
2.54.0


