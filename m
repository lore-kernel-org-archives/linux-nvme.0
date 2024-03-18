Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21E6C54E6A
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ESLQfwqbIQpBuRsUm79Uv/QgTzX8Ugdd5tWbZF62818=; b=NuZCTg1vUN9Rb6EUYlxQlZd9yf
	O+XaSKPxj/6WxgSy78JLYzLA3TAy9or5zpr4sNpknuWbAAi6rBdwU3abHITTz506W9K7KYnz1vh6t
	RoH8NXGtY/m0YG1cZEMHQO67Ls1k1wtdM96qYQvmWegjWJpmcP/++Q5+KwbQ+O08gxBdEVyo3oSJQ
	oKFsocbBxtyETR7woPjyB3Ni0X4JRRr7SPOR7SbpbKZzGfgFYEm6eCh1OxnYMkkyCbwQePsR3DR+i
	NfyUqBuxKCXeH/SXKR+q2KTu5ltiMdILqyRWh4dATXUa/WLHiZi6WypUCtMxapHBdBT2i+q2ujjim
	YGc3pQzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWc-00000008uIB-455B;
	Mon, 18 Mar 2024 15:03:43 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWX-00000008uEW-2wHX
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 15:03:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 09E0ECE0A29;
	Mon, 18 Mar 2024 15:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0604DC433F1;
	Mon, 18 Mar 2024 15:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774213;
	bh=iFuRsmzzbtAtQToko9U/QSPCVNm334E5Bse0iMPyq+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CsLw3fO/c+2yuMUrwvgqTZpl8p/zGzNz9aU3Au5h+KDi5yU3JiXZmGcWOGWh+WSek
	 UXVxevOPi5C6YD1/cWQD+5OFbfAYmcakBFdGiC29Ko12MbwX7sDwQW0zkYMAaik0at
	 08XLYFL6iBNLWoErqTmnNcnh4cs65Vw8T4ce0j7tvyA4rD1SHZMr8TUcVE44t6W+ww
	 acOXYKqHC7t4F5fdihQYIgONmUF2VZ2sdOQD69JH3LNHp0pp4+/T1ZDB/c/wg5hy8a
	 AuBhV6l0WzYG8mg5zJ4wv77C1u2cUgvyny5CQ+6wpGUFFowV0hTt2NJi2sSi4+fjF/
	 Ml1Chi6MFkm9Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 02/17] nvme-tcp: check for invalidated or revoked key
Date: Mon, 18 Mar 2024 16:03:01 +0100
Message-Id: <20240318150316.138501-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240318150316.138501-1-hare@kernel.org>
References: <20240318150316.138501-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_080338_060221_7C385134 
X-CRM114-Status: GOOD (  14.01  )
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

From: Hannes Reinecke <hare@suse.de>

key_lookup() will always return a key, even if that key is revoked
or invalidated. So check for invalid keys before continuing.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fabrics.c | 7 ++++++-
 drivers/nvme/host/sysfs.c   | 9 +++++++--
 drivers/nvme/host/tcp.c     | 8 +++++++-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 0141c0a6942f..75aa69457353 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -639,7 +639,12 @@ static struct key *nvmf_parse_key(int key_id)
 	key = key_lookup(key_id);
 	if (IS_ERR(key))
 		pr_err("key id %08x not found\n", key_id);
-	else
+	else if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
+		 test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
+		pr_err("key id %08x invalid\n", key_id);
+		key_put(key);
+		key = ERR_PTR(-EKEYREVOKED);
+	} else
 		pr_debug("Using key id %08x\n", key_id);
 	return key;
 }
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 6c7f1d5c056f..ec581608f16c 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -671,10 +671,15 @@ static ssize_t tls_key_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct key *key = ctrl->tls_key;
 
-	if (!ctrl->tls_key)
+	if (!key)
 		return 0;
-	return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
+	if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
+	    test_bit(KEY_FLAG_INVALIDATED, &key->flags))
+		return -EKEYREVOKED;
+
+	return sysfs_emit(buf, "%08x", key_serial(key));
 }
 static DEVICE_ATTR_RO(tls_key);
 #endif
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a6d596e05602..4a58886e1354 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1571,9 +1571,15 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 
 	tls_key = key_lookup(pskid);
 	if (IS_ERR(tls_key)) {
-		dev_warn(ctrl->ctrl.device, "queue %d: Invalid key %x\n",
+		dev_warn(ctrl->ctrl.device, "queue %d: key %08x not found\n",
 			 qid, pskid);
 		queue->tls_err = -ENOKEY;
+	} else if (test_bit(KEY_FLAG_REVOKED, &tls_key->flags) ||
+		   test_bit(KEY_FLAG_INVALIDATED, &tls_key->flags)) {
+		dev_warn(ctrl->ctrl.device, "queue %d: key %08x invalid\n",
+			 qid, pskid);
+		key_put(tls_key);
+		queue->tls_err = -EKEYREVOKED;
 	} else {
 		ctrl->ctrl.tls_key = tls_key;
 		queue->tls_err = 0;
-- 
2.35.3


