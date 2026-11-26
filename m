Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294F606A321
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Xb7RGBc9;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkfMnCQJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=PkWXMv0KRHZXsgF0tyS+OJURDpyQmj9kIRrfzSjVPTc=; b=Xb7RGBc9ngukeHZhPIoqMW1t0N
	YnCh8GTvvjiSbR01qHZU14SWoIRwjYK9Tz2N7mq6vAU/mApAioe5q2ckqQ+r+HO1IZD/o3f9bBzBR
	0gdebuSoYlDlzTJEQq/cpS+3hG6MmbH9izR9dGe4rqe+F6VnqF4/hhhAGLOaE+kcBHKQFvriBFOXS
	3jMjUGXFCD5lOEMMlIWZRh2Pc7wXjdu1ajGXRz9WryWJGSv4/1O+CSi3P1ugpD8AiOStUJqgV9GeI
	watWvpeTExxAkJiCNj/bCewoAf62VDu6i2IDlBUIK8LkPRQjxIFmoHW+2kpxz80Y0OJ/PD5nt+kjg
	dka3rIQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWY1C-0000000D4iJ-2gVt;
	Thu, 26 Nov 2026 11:52:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWY0f-0000000D4Zv-164B
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 11:51:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B25A7405D6;
	Thu, 26 Nov 2026 11:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8511F000D2;
	Thu, 26 Nov 2026 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693888;
	bh=PkWXMv0KRHZXsgF0tyS+OJURDpyQmj9kIRrfzSjVPTc=;
	h=From:To:Cc:Subject:Date;
	b=SkfMnCQJwmH+Q3TIA9inwAyC7p/Ry36BCcUsIvHuUWwrwfU8Z4oeUB8XU0tyYyH+R
	 Pbm0Y5Xg62Dk0O+GLDWHCunnSdoxjnNH835w/99PA/fTZxPlETv/6kOJC6FaBU6lN7
	 rPVOeYhFfEnItaQlnL6wQ1ZMj+5QAys5Ue+G9ghNCdQEWG45k2UGULNYkAbAdRCwcJ
	 pf4ru0UjhmBx2DZwAN63pB/m6q3RqB9y5lacfsDq91bcERag8fakWwbJ476gaS9BlJ
	 ZkgfKa3u1sdorP/VJVcfaFROewWetTzkAz7HhauFP4keQPCv51SOlIW49aVKgWjUb8
	 QGKCpLhmUIapQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv2] nvme-tcp: use correct network namespace to resolve addresses
Date: Thu, 26 Nov 2026 12:51:21 +0100
Message-ID: <20261126115121.6032-1-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Resolving network addresses should use the current network namespace;
the passed-in addresses might not exist in the default network namespace.
And while at use dev_get_by_name_rcu() with proper rcu locks to avoid
a possible crash on network namespace changes.
 
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c3149a9151f5..34a8bc2c5af0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -3308,6 +3308,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	ctrl->ctrl.queue_count = NVME_TCP_OPT_NR_QUEUES(opts);
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
+	ctrl->net = get_net(current->nsproxy->net_ns);
 
 	INIT_DELAYED_WORK(&ctrl->connect_work,
 			nvme_tcp_reconnect_ctrl_work);
@@ -3324,7 +3325,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		opts->mask |= NVMF_OPT_TRSVCID;
 	}
 
-	ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
+	ret = inet_pton_with_scope(ctrl->net, AF_UNSPEC,
 			opts->traddr, opts->trsvcid, &ctrl->addr);
 	if (ret) {
 		pr_err("malformed address passed: %s:%s\n",
@@ -3333,7 +3334,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	}
 
 	if (opts->mask & NVMF_OPT_HOST_TRADDR) {
-		ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
+		ret = inet_pton_with_scope(ctrl->net, AF_UNSPEC,
 			opts->host_traddr, NULL, &ctrl->src_addr);
 		if (ret) {
 			pr_err("malformed src address passed: %s\n",
@@ -3343,8 +3344,13 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	}
 
 	if (opts->mask & NVMF_OPT_HOST_IFACE) {
-		if (!__dev_get_by_name(current->nsproxy->net_ns,
-				       opts->host_iface)) {
+		struct net_device *found;
+
+		rcu_read_lock();
+		found = dev_get_by_name_rcu(ctrl->net,
+					    opts->host_iface);
+		rcu_read_unlock();
+		if (!found) {
 			pr_err("invalid interface passed: %s\n",
 			       opts->host_iface);
 			ret = -ENODEV;
@@ -3367,16 +3373,15 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	for (i = 0; i < ctrl->nr_allocated_queues; i++)
 		nvme_tcp_init_queue(ctrl, i);
 
-	ctrl->net = get_net(current->nsproxy->net_ns);
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);
 	if (ret)
 		goto out_kfree_queues;
 
 	return ctrl;
 out_kfree_queues:
-	put_net(ctrl->net);
 	kfree(ctrl->queues);
 out_free_ctrl:
+	put_net(ctrl->net);
 	kfree(ctrl);
 	return ERR_PTR(ret);
 }
-- 
2.51.0


