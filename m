Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E78C606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=d5YEGwCb;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tDPNyhil
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=DjmaMCyxv8Ena6C7c0oF6VUANWs59PuasugELu5d8U8=; b=d5YEGwCbXQtNrhsY0MCA+JQFW6
	yd9ITDBB0YE/kxGkt/u63sWvpn//2+H5q7wv1NnvQd75KNxk3DhnoCKJaL2dnSJveHYz8T26uHftq
	Xbah9H3lEcWNMVAcEkLOHP2C7ApN9mIzHeqjkSpWp206k6j6AIpay2KcLaIM0u5Xzidj2fncSznHG
	aMomfzAzGekRH5qkunk9ZQRKGroO1h+kos16iOsjNf6+KTGkSqx1uQww2wjA4srEIS8ZPFTXTBGaQ
	VcdberjsLTaH5LXpsBGQL0ClTXZSQegdkRnyrXarw8Di5ch7A7SsS4GQMfNJ4qtB5bD7VAa9tyNol
	BKfAH7MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMpzi-0000000CBY0-1Rkb;
	Fri, 30 Oct 2026 17:02:22 +0000
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMpzg-0000000CBX2-0gYf
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 17:02:21 +0000
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-36a2551d7b5so2628222eec.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Oct 2026 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793379737; x=1793984537; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DjmaMCyxv8Ena6C7c0oF6VUANWs59PuasugELu5d8U8=;
        b=tDPNyhil/Ft6iwxV4/ijuNoTM45+yINz4amQfwfASWXnNrKcCRcCgWCsyMwKuwK2iJ
         TVpk6XAoA9097alT9CZaJO1olpQzk/rgy51R+qJjY4UFCez5ZudBuRnJmLn5fEfDoqxY
         fCLEReSknTg4nJ5thAR8WjaoMld4Elj7UyhoJOy/jfiJyftHuqI1gIqvjt0XnkbQKMtf
         EmJ6dvNd1in7rciLFGPoOyTwB/FQN8LXk5DQA4NMAiv1928DfZO+EQdi16CxtZ8EAI94
         Iu/Kd+uf0oHYEVDmXNX6EEUUd9qF4kKIuMQd63lSKP6cB9diUvgaqOm/o281IzAJskGu
         cv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379737; x=1793984537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DjmaMCyxv8Ena6C7c0oF6VUANWs59PuasugELu5d8U8=;
        b=mer2w9dTRxS1I8kPziAfCq9k2OzXKrw0x9RhWQmrxzXBIVPaBWEmk5iRAzMqrI2TQq
         VDAekkv3dKuVRHnBVFJRFcDONvt1+HpgEIYdJeXhY8Ud+/ZIowXAQebQ/kqXhrs91TBq
         +FUZNwdXiKRQgXANB5hCLqFkqHc+koeiPInKQFm5hzk9i76hNcUR19yEmyfcRWutNN+9
         LYIShmiSQWP1BxxEggS3p8GU32WBIpgWzhfIQ4AF7ndsUcatc7ggJDoO+yelZTBBBlnI
         DJ5e7PxKYlr1G2xZlrfMdP7oupU/ESuOD3MQ1NFLGKZ7SkaAcbL0aPoUm+C9Reswjdy0
         5+qQ==
X-Gm-Message-State: AFq9FYIYtL7j4I3Adc+cW5R+OY4hWfIAEnuW+pANCrOimea0tumbyWdS
	6ryX3UlxVAKMBd+0G5gB6MzEqH3hA303z76zs4z0quhyh2qHrxAT43LgZ5i+OYC7umQ=
X-Gm-Gg: AYBFou0430eKUkeRGECRRzkLuottbBf9WSg7yUeSQcisvGsDHewHj7g7hPufmdxKKSu
	i/ZU4+beOJelfpJqYcqz9R/I1bATN3EIOdeKv0hkcCDyLfkFRAhhcUaZSAu6hDCsPINHYoB1S3A
	pf9j3Ic+eX/CFqQJjwONlqJXCunc8IWKW+pLFv7vEp6qCZsrTOVEqOJVXRvUalVrxNVQO27YwUh
	w3tnVVgcEc7JXifc6VFQK6ynaE9uoJpDpD96FoJECAKEqhFmhYoieVOrL1sKP18BVg/qRNozFwr
	u7FPbpYQtrm871RH5z1gqwHSsXP4UZV2FarR+FoGZHvVxULoM/hhGK68gRwpSWZjNrA80ikqHPD
	rxYMDPDVj6TlVAxcrSibSqkmEdosPhAJK4YszvOl4t1DjHmTM6WqZZHLw3pTXs+2rGlEHuerfOZ
	0/VuYDCr6cIpEjWTkyYy1KbjEGrl22m0NqB8xWjXItGzveIKLTEWPWD6QFzwBwj1FizoCZ3Qivz
	B7TCRQa6J0o4TFfrewtdTKDrNl0wkoa6Q29JtVzQgvPftZpy445O3gaSK1WMicu0AgKO0/dJxAR
	mRbXKylzh1rCbYnn1Hf6ef+vUSpQa73Jk/9xFhpEs+M+Az9kEwXnrXUC
X-Received: by 2002:a05:7022:f90d:b0:151:7831:e403 with SMTP id a92af1059eb24-1ac5b027fbfmr3148575c88.13.1793379737104;
        Fri, 30 Oct 2026 10:02:17 -0700 (PDT)
Received: from bridge.. (deps54-26.deps.ufsc.br. [150.162.54.26])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4a04esm8113659c88.15.2026.10.30.10.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:02:16 -0700 (PDT)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@kernel.org,
	nilay@linux.ibm.com,
	wagi@kernel.org,
	kanie@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-tcp: fix use-after-free in nvme_tcp_free_ctrl()
Date: Fri, 30 Oct 2026 14:01:51 -0300
Message-ID: <20261030170151.49844-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_100220_227846_157DC9E3 
X-CRM114-Status: GOOD (  17.14  )
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

nvme_tcp_free_ctrl() reads ctrl->ctrl.opts to know how many queue
mutexes to destroy. When creating the controller fails,
nvmf_create_ctrl() frees opts as soon as nvme_tcp_create_ctrl()
returns, but a concurrent open of the character device can hold the
last reference to the controller. With CONFIG_DEBUG_KOBJECT_RELEASE,
which delays the release, every failed connect reads freed memory:

  BUG: KASAN: slab-use-after-free in nvme_tcp_free_ctrl+0x38b/0x430
  Read of size 4 at addr ffff888005b93740 by task kworker/2:1/51

Keep the size of the queue array in the controller and use it instead.

Fixes: 2eeeaa9c1ff0 ("nvme-tcp: Validate the queue state under the queue lock in the address attribute")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---
Based on nvme-7.4. Nilay pointed this out on the nvme-rdma thread and
suggested the same fix:
https://lore.kernel.org/linux-nvme/1408da28-a55e-448b-b493-d60fd5d20524@linux.ibm.com/

Reproduced in QEMU with KASAN and CONFIG_DEBUG_KOBJECT_RELEASE by
connecting to a port with no listener. Each failed connect reports
three use-after-free reads without the patch and none with it. Growing
attr_qid_max from 2 to 4 and 30 resets, both under I/O, still pass with
and without lockdep.

 drivers/nvme/host/tcp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a8e94e4866db..d11fb52ce1a2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -204,6 +204,7 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+	unsigned int		nr_allocated_queues;
 	struct net		*net;
 };
 
@@ -2861,8 +2862,6 @@ static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
-	/* the same count used to size and initialize the queue array */
-	unsigned int nr_queues = NVME_TCP_OPT_NR_QUEUES(nctrl->opts);
 	unsigned int i;
 
 	if (list_empty_careful(&ctrl->list))
@@ -2875,7 +2874,7 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
 	put_net(ctrl->net);
-	for (i = 0; i < nr_queues; i++)
+	for (i = 0; i < ctrl->nr_allocated_queues; i++)
 		nvme_tcp_exit_queue(ctrl, i);
 	kfree(ctrl->queues);
 	kfree(ctrl);
@@ -3269,13 +3268,14 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	ctrl->queues = kzalloc_objs(*ctrl->queues, ctrl->ctrl.queue_count);
+	ctrl->nr_allocated_queues = ctrl->ctrl.queue_count;
+	ctrl->queues = kzalloc_objs(*ctrl->queues, ctrl->nr_allocated_queues);
 	if (!ctrl->queues) {
 		ret = -ENOMEM;
 		goto out_free_ctrl;
 	}
 
-	for (i = 0; i < ctrl->ctrl.queue_count; i++)
+	for (i = 0; i < ctrl->nr_allocated_queues; i++)
 		nvme_tcp_init_queue(ctrl, i);
 
 	ctrl->net = get_net(current->nsproxy->net_ns);

base-commit: 89480d137bf0d943a82c64f86ae2407a15276b5e
-- 
2.43.0


