Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D364606A326
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3SanlJdF;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aZ8vghUx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=CEJgZSOIdMAj6jpTCSnhUIhLpKEk9BtwYmYBUge0rqk=; b=3SanlJdFGykJ9kADaqK9DAc0we
	IyRF0LOQtEWreqGHExSqeHGxpnPmDROnbb5mtIWYInB2rCHpvpvyqZKwdug2sUtUEIwmTvULw1Wyx
	Y5IBTn6VlRvcPIGiTyyJU1WdpEUS45Cq0Ou4+WauM/UAU3EezAEwATqx465OQYmJ423VOhUfNCilf
	F14sMe3jPFK9G7MyANXOnv4nfeFNIuDaVPJTA0c1yXYLZjf3Alm8vZYNcgxHXuL4qhUg7lKegVaKy
	iorvZJZokNdJl7mWua+8BrcFejKjo4B/uq057y96go08Z6PyLIrE7HUhPJTyRspBI5FHwzZaXJmBs
	43R7RW5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMQzZ-00000009Vct-49BO;
	Thu, 29 Oct 2026 14:20:33 +0000
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMQzW-00000009Vbv-1tRc
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 14:20:32 +0000
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-98c7798ce74so706715241.1
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 07:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283629; x=1793888429; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CEJgZSOIdMAj6jpTCSnhUIhLpKEk9BtwYmYBUge0rqk=;
        b=aZ8vghUxxE8Cy0TsC+kv7/JKv/XIHsaieulgt2af8LVaHW7MoEtpOQ+PeyoP5+7ujU
         qdIfeJSBWYMFoFczaeYispkkIV8K+cegBlRMNTbyVTp5EV9UbnIqEfKSLFTgY++9dWbi
         nwixRxHtEgPcL5e3Zcm+YqR/clDzS9/NtiBqUY+vZMzHIjY87bBtbcB6vuCI3vbxjpXv
         flXVqxjFoJaw+9xxG6FvLm78IKvPzLDSPmQiVuDSryr71beOoYUIdzJUdRRTrIt4Hnb3
         zbP14ze8JiYYUnK4zYuWudIq0H4GcsnjYqDbOjwppQlSzY6gIDNXvc73ghOCaWW4NV1/
         8mpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283629; x=1793888429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CEJgZSOIdMAj6jpTCSnhUIhLpKEk9BtwYmYBUge0rqk=;
        b=cynMG2BEzNlOQjGyg2yeDNq+v0pYOjXRtWI1IIEeWAN6qGe9Z3Wcy4YLdEY84SwsID
         O5CZhcxTvSn7G1cvsT2ugeQSLRI+qO8Nrt6KE+rKtDo5WTkiIC93bpWuZVAykA9C1UhQ
         NwJwI1V13RfLL/bmm19/ycNAp35IPkOhUEO+uSTdVGrZvqKcyVTwWqes010vMIkrXcLB
         RE8oaN3OA2ZGpV3itWYOXcB6/kYbt3QPY7/m7+sOQuHCcshgKTylcK+RXSsOhN81K6SW
         M2Ro+oZLAE8JnfKBgFnsQf40cRVze1e8q7KSjPnpzUmP4sVichuHmxW9ie3CzmoNDg0h
         5ROw==
X-Gm-Message-State: AFq9FYKH9igFY6KAvAREtsyZWhO+HM91jdpV50lY29SclZReKMi6z4D5
	H9lXJQsY9DXM6HlIdAKRZ7H/k7mb5FZ4u0L2hSO4SVXzYV2BsfosY1tX/MsgSeEOYFE=
X-Gm-Gg: AYBFou3Yqt46JO78ntOcXtVxtr0NdEPJ5BkgNveV6SnzPinlIEalh8xi1zLnrT7SgEN
	tsKFuOnC4u6g6EpmARydHyvY2NuJJGdg8NpZ/9CDZ0zrVwbvvfeUVQ48Oe57hOeOOyO8h92bOwK
	VgWZwb0362IKcQhg2rP9G8hf52piNM9SRkoVuj7kI8+16XahmaucctOZhYh/4PL+LKPRPzjiY9K
	2dsK5sP7jDZkjYC9Yyj7Vy8lN3Bq/1EIL+VaGYEoHNmxkfziM2W5YAb8yVc1PKP1zKPk19AsG5a
	N9NcjMA1Ypb1CMaXjdrsk2KAslmJ/uVCHK4Ao+VjBeYU+1xdX30MwcvvZbQCy90M6aiXPZA/k3h
	WkoPE7P7CQ9L+f2BG3U4auTPQcmX0L6gkNEkwLVub4uGu9tm0fuXE3zHWSEuYVCW3dW+a6kBPTE
	Ty/7izOcLMedtFTvtSh1I9cikuMiGVGK/Ppmp1gsiePgkBuodFI7h6GX8kaR3sdS5U1B/AcAoMV
	dht/Rxr+iPSqk4fp7Oh4O+yC1HUF7oxYd0MA2QQxL+Ni6DR0X+ogXWITTAgOqNFLcKd7rogSe1E
	se+Xb5YavAuxe0G1RqVbnvSOHkAQQ/Y3Q/Rzixc=
X-Received: by 2002:a05:6102:6f07:b0:7c3:1d7:f234 with SMTP id ada2fe7eead31-7d03a294a6dmr2037964137.2.1793283628442;
        Thu, 29 Oct 2026 07:20:28 -0700 (PDT)
Received: from bridge.. ([2804:14d:ba6b:8339:e751:b7f8:a4ea:bd70])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-991eaee2e66sm11457241.2.2026.10.29.07.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:20:26 -0700 (PDT)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	sgogte@purestorage.com,
	hare@kernel.org,
	nilay@linux.ibm.com,
	wagi@kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] nvme-rdma: fix NULL queue->ctrl dereference on reconnect
Date: Thu, 29 Oct 2026 11:19:57 -0300
Message-ID: <20261029141957.2068907-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_072030_495775_BA70B2F1 
X-CRM114-Status: GOOD (  16.60  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation
and startup"), a reconnect that gets more I/O queues than before grows
the tag set before the new queues are set up. queue->ctrl is only set
by nvme_rdma_setup_io_queues(), so I/O submitted in between reaches
nvme_rdma_queue_rq() on a queue that was never allocated and
dereferences a NULL queue->ctrl:

  BUG: kernel NULL pointer dereference, address: 000000000000034c
  RIP: 0010:nvme_rdma_queue_rq+0x52/0xb90

Set queue->ctrl for every queue when allocating the controller. Such
requests are then requeued like on any other queue that is not live.

Fixes: 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation and startup")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---
v2:
- Only move queue->ctrl. v1 also moved queue_lock, which needs the
  queue count in nvme_rdma_free_ctrl(), but opts can already be freed
  there when creating the controller fails (KASAN use-after-free on a
  failed connect with CONFIG_DEBUG_KOBJECT_RELEASE).
- Not carrying the Reviewed-by tags from Nilay and Christoph, as most
  of the patch changed

v1: https://lore.kernel.org/linux-nvme/20261029060521.1690223-1-christian.aurichzm@gmail.com/

Based on nvme-7.4 (89480d137bf0), also applies to mainline and v7.3.

Reproduced in QEMU with nvmet-rdma over rxe and
CONFIG_NVME_MULTIPATH=n: connect with attr_qid_max=2, keep direct reads
running on the CPUs that map to the new hw queues, then raise
attr_qid_max to 4. The window is short, so the readers run at
SCHED_FIFO with nvme-wq pinned to their CPUs. Without the patch the
host oopses within two tries in all six boots. With v2, 24 of 24 tries
go live and 30 resets under I/O pass, with and without lockdep, and
failed connects are clean under KASAN.

 drivers/nvme/host/rdma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 07216890f75c..32189fdfc0f5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -735,7 +735,6 @@ static int nvme_rdma_setup_io_queues(struct nvme_rdma_ctrl *ctrl,
 	for (i = 0; i < nr_queues; i++) {
 		struct nvme_rdma_queue *queue = &ctrl->queues[first + i];
 
-		queue->ctrl = ctrl;
 		queue->queue_size = queue_size;
 
 		ctxs[i].queue = queue;
@@ -798,7 +797,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	bool pi_capable = false;
 	int error;
 
-	ctrl->queues[0].ctrl = ctrl;
 	ctrl->queues[0].queue_size = NVME_AQ_DEPTH;
 	error = nvme_rdma_alloc_queue(&ctrl->queues[0]);
 	if (error)
@@ -2284,7 +2282,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_rdma_ctrl *ctrl;
-	int ret;
+	int ret, i;
 
 	ctrl = kzalloc_obj(*ctrl);
 	if (!ctrl)
@@ -2343,6 +2341,9 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 	if (!ctrl->queues)
 		goto out_free_ctrl;
 
+	for (i = 0; i < ctrl->ctrl.queue_count; i++)
+		ctrl->queues[i].ctrl = ctrl;
+
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
 	if (ret)

base-commit: 89480d137bf0d943a82c64f86ae2407a15276b5e
-- 
2.43.0


