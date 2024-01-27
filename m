Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1656AC46CD2
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DgRU4sdjUSTQE7bfLkdWcAgUKnaKzyjfd3EDcIkc6Rk=; b=V0rXXUPZ3mNiHS9fQB+tbBeVyW
	LZ58KqzMxOcBRrkVFe6y8T9kmWh0Ony3vgkwhmBmp3mSFV47V49pWDT/+zScSnMkp6pVwi/oSd7Ag
	P7qj2WKGL5FwsA2U4j8/fUVkOJVkk37l6GfL5xPGXPm3uItPoVTZJxiYQ8O2OsMX9dAdt0i1riFcy
	G8zD+BXItu7d/7vHmEkML/cS7g4R2o9KfrivNAQ/hqCq3CcVG5dmvn/7rX3Kj122dLDDOlNHqh0kT
	NITxF7tLR8uAo5HA+aIT4RyHlpmWts0hqo42BGlop7MRr22mYHXA1CRY1yYk6WUI1C0xIdX/IFvQp
	k4ZwfQRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf29-00000007Fih-17pz;
	Sat, 27 Jan 2024 09:31:29 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf1x-00000007FUp-1bON
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jan 2024 09:31:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BA015CE2B6D;
	Sat, 27 Jan 2024 09:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB51FC433F1;
	Sat, 27 Jan 2024 09:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706347875;
	bh=jJYZ1tkPwxXnuiRe900XHQ0ERIW9Wb3oJx9gUTJLME8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fBDosJgTqmU05KjV6OwJk2rdkb05Dpnj+rX43EisHPcaxYftXFu6y9TNb0K4EVUfF
	 vmD1HejkJCqXOhtbRaJOOzmeUUfj4AKmNRPW744hI5CnT4VfV6n43yQWkxeks6DXy5
	 560QH/OJmZaL7Od4X4u9vxIH1sWUxjj1dNtT7/qVN5bROMePzFc+bu4fH3Gm1r9eIL
	 NLR5cVfPXU5B5m0IfqlCwUz15zAovtACUOvWslzqJW/JoXDsvj74fpfm2tqrH7M0Zm
	 eQ9kZKMQxj3Q3pfVi2SeYZOR8RpKfLEzDrEbhVJHd9ZFHQFxi9SY678UUJ80A/rQoU
	 MTRWaaUC93IxA==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/13] nvme-tcp: check for invalidated or revoked key
Date: Sat, 27 Jan 2024 10:30:52 +0100
Message-Id: <20240127093058.15699-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240127093058.15699-1-hare@kernel.org>
References: <20240127093058.15699-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_013117_723442_C5772B3A 
X-CRM114-Status: GOOD (  13.82  )
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
index aa88606a44c4..a7da088331dc 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -635,7 +635,12 @@ static struct key *nvmf_parse_key(int key_id)
 	key = key_lookup(key_id);
 	if (!IS_ERR(key))
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
index 754e91111042..1076b5b59b35 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -617,10 +617,15 @@ static ssize_t tls_key_show(struct device *dev,
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
index c160b1a64ec0..65d9a817e752 100644
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


