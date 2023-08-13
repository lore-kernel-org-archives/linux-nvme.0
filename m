Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9767C001B0
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 14:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tUuuKbL8ydFNPda8N4HOTsW5STdP9ERZYuHURXlNIxg=; b=k27kzpzEMAdGdWGolffiraVTXw
	IxPQuFb21Gfobv1o65/gzmGmuKmjiKBMrYnZ636sbsCoZGStuFuk2FQ3Yun/d+iYbi+JIvSMIyveM
	bpYEfqO0+p8xVFJtnom5+TbxlUdifCkMKd/Mr0rFk17UPmQnnRPv0Jhp55lAkJKVGQFatCZcKXOpz
	dlZryAUdw8MzR1gltJ9aPJBjCJD3jTonfJPpc+XCMuUDeaVkYh0Kb3TfJ+ew3xzshiEuaJeSvGfae
	6tYrWjzyqiy0xek+jqUJg/PTyhoiSjyyACmgCqTP1lqilWOlmNCFD7rpzT+d0wkQOl8eFy4+F3aO5
	Mie8451w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVCL6-00FFrp-1J;
	Sun, 13 Aug 2023 14:45:08 +0000
Received: from mail-ej1-f51.google.com ([209.85.218.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVCL2-00FFqw-2v
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 14:45:06 +0000
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-99bded9d93dso81022766b.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 07:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937903; x=1692542703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUuuKbL8ydFNPda8N4HOTsW5STdP9ERZYuHURXlNIxg=;
        b=Hn+iSMk0mbgF8q+szwfCwP7T1KqMEhBb+lSUME7uqgMM0GjI7m6rlmWdTqoxWeYeBY
         l5hd5dIP0R5DKXw2ZqN046oqZ5a1Wm6r5QrTSreGLS3hT0a2tKpN1lOlYq9+NEonwTMF
         XHfPtwCxqnhf0utVqAIt3N+dt0CNTxRfzGWMVVN4Sb+hrHnsQDTr01H9MZ+OW/KsuwWM
         nlw6sr7tNhF2wl90eSKjsQ6tO1ZWLrS0AKwD/bD3UmfFXbPyC8aW4sPudM8Rk/h606eK
         PgBSat78f29szt8U+snyDOLZEfTyJisKt2Yu45tt3O80bbzY+Z4YgaHcouhIfiliIcu1
         s6sQ==
X-Gm-Message-State: AOJu0YyUgKX8RjPkV17OvoZ0cnzDz5YGSQpigkbif0p6zDFqsG3XO9E/
	IKxKsg+c0rZumKCChYznHNtvOL4/aME=
X-Google-Smtp-Source: AGHT+IGZM1qYkBktaWviYMhvhRd2I8b2PoUwBCntgMUqmL9huiI//X6jdvuIouNEpBOQZxmtPJQx8Q==
X-Received: by 2002:a17:906:19:b0:993:d0e1:f308 with SMTP id 25-20020a170906001900b00993d0e1f308mr5254691eja.2.1691937902935;
        Sun, 13 Aug 2023 07:45:02 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906110b00b00977cad140a8sm4618761eja.218.2023.08.13.07.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:45:02 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: <stable@vger.kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 6.1.y 1/2] nvme-tcp: fix potential unbalanced freeze & unfreeze
Date: Sun, 13 Aug 2023 17:44:59 +0300
Message-ID: <20230813144500.15339-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_074504_966775_0F059F80 
X-CRM114-Status: GOOD (  12.18  )
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

From: Ming Lei <ming.lei@redhat.com>

Move start_freeze into nvme_tcp_configure_io_queues(), and there is
at least two benefits:

1) fix unbalanced freeze and unfreeze, since re-connection work may
fail or be broken by removal

2) IO during error recovery can be failfast quickly because nvme fabrics
unquiesces queues after teardown.

One side-effect is that !mpath request may timeout during connecting
because of queue topo change, but that looks not one big deal:

1) same problem exists with current code base

2) compared with !mpath, mpath use case is dominant

Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1dc7c733c7e3..8d67cdd844f5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1884,6 +1884,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		goto out_cleanup_connect_q;
 
 	if (!new) {
+		nvme_start_freeze(ctrl);
 		nvme_start_queues(ctrl);
 		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -1892,6 +1893,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
@@ -1996,7 +1998,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	if (ctrl->queue_count <= 1)
 		return;
 	nvme_stop_admin_queue(ctrl);
-	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-- 
2.41.0


