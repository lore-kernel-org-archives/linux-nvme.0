Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E701C5B552
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 14:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ETiLtoakR+r1CBEdSM0OTPtViZHPQEA/mJLRTMTvQZo=; b=xd9F3+zVY0zLlW9i6VYLJodbtW
	wDdqsOtoxL0vy4WDW8VbXtcRPNYWOWd0eJg0816J/lzz0R+ji1XGRSzAHbmmX29RGUbwcPWPH7J8/
	KeYDlITip+N7CYclpYL2p8CBXExNeOiRl69qQGB5rOSjqglLaC1tByGWtYoqR0Nzj8rX7u3Ig2Jz8
	iDBKrFs6V97JbSEMclNF5jOjuT/1xpywk91bkZHZKDm8D7oib4/qhH6g98ghBSOIePxGUOQzbyXkD
	WnBrQCtcP95yCtHf6waz+08QoG+IDfDOl0Wc8gKqy07WsrI/7HiGU/lBcmA6FnDQM2lVNy7C/e3Ns
	/lQqLkcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKHdL-0000000DN7O-3JWY;
	Wed, 28 May 2025 14:19:55 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKHSc-0000000DKUO-1YbK
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 14:08:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A5392A4FA40;
	Wed, 28 May 2025 14:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03326C4CEED;
	Wed, 28 May 2025 14:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748441329;
	bh=AAS6MaWK8QIw+pSCzfhhywD/L7N7Dnq2264PI4NJLn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WsXij2El5UtXFiAF/lDVowE95Ix1/zQ+5ltH6s/rHbvtHQtPMLGlPKJvGCa58K41V
	 kpyK/YqykPpG9aJpcwxqoxZabrUDZdFn0c8ALCruzNZh7Jv3MeWRm02lWcRfSHZb0N
	 kMyKCad2s77zirqWNfcrX6zwphzzzxUKjAAHoxC/7o7dA4JvWJ9TO9pDJHOGdUpdzC
	 cqPB/sopnkNCetoXgzK2C15RDhKEWm/cFAsGseFA8QDJ7jhKwg8Tcafa9uZIzeBt4A
	 0Vx9AGH1fZjMTG51GU76XxcpLyjZ62W89vVbJE3TvkmcZQ5R9hF/OzsYD3XWaMqSq9
	 ncA2pfB8sORvA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 9/9] nvmet: add configfs attribute 'dhchap_keyring'
Date: Wed, 28 May 2025 16:05:17 +0200
Message-Id: <20250528140517.3284-10-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250528140517.3284-1-hare@kernel.org>
References: <20250528140517.3284-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_070850_556563_0145B9DD 
X-CRM114-Status: GOOD (  17.14  )
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

The authentication code now fetches the key from the kernel keystore, so
we should be able to specify which keyring to use for looking up keys.
So add a configfs attribute 'dhchap_keyring' for the 'host' directory
to specify the keyring to use.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/auth.c     |  2 +-
 drivers/nvme/target/configfs.c | 60 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 036652de3489..090cc1dc0655 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -69,7 +69,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	}
 
 	len = strcspn(secret, "\n");
-	key = nvme_auth_extract_key(NULL, secret, len, &generated);
+	key = nvme_auth_extract_key(host->dhchap_keyring, secret, len, &generated);
 	if (IS_ERR(key)) {
 		pr_debug("%s: invalid key specification\n", __func__);
 		return PTR_ERR(key);
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e165905fab31..2642e3148f3f 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2217,6 +2217,60 @@ static ssize_t nvmet_host_dhchap_ctrl_key_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_host_, dhchap_ctrl_key);
 
+static ssize_t nvmet_host_dhchap_keyring_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_host *host = to_host(item);
+	struct key *keyring;
+	ssize_t ret;
+
+	down_read(&nvmet_config_sem);
+	keyring = key_get(host->dhchap_keyring);
+	if (!keyring) {
+		page[0] = '\0';
+		ret = 0;
+	} else {
+		down_read(&keyring->sem);
+		if (key_validate(keyring))
+			ret = sprintf(page, "<invalidated>\n");
+		else
+			ret = sprintf(page, "%s\n", keyring->description);
+		up_read(&keyring->sem);
+		key_put(keyring);
+	}
+	up_read(&nvmet_config_sem);
+	return ret;
+}
+
+static ssize_t nvmet_host_dhchap_keyring_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_host *host = to_host(item);
+	struct key *keyring;
+	char *desc;
+	size_t len;
+	int ret = 0;
+
+	len = strcspn(page, "\n");
+	if (!len)
+		return -EINVAL;
+	desc = kstrndup(page, len, GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+	keyring = request_key(&key_type_keyring, desc, NULL);
+	if (IS_ERR(keyring)) {
+		ret = PTR_ERR(keyring);
+	} else {
+		key_put(host->dhchap_keyring);
+		host->dhchap_keyring = keyring;
+	}
+	kfree(desc);
+
+	return ret ? -ret : count;
+}
+
+CONFIGFS_ATTR(nvmet_host_, dhchap_keyring);
+
 static ssize_t nvmet_host_dhchap_hash_show(struct config_item *item,
 		char *page)
 {
@@ -2276,6 +2330,7 @@ CONFIGFS_ATTR(nvmet_host_, dhchap_dhgroup);
 static struct configfs_attribute *nvmet_host_attrs[] = {
 	&nvmet_host_attr_dhchap_key,
 	&nvmet_host_attr_dhchap_ctrl_key,
+	&nvmet_host_attr_dhchap_keyring,
 	&nvmet_host_attr_dhchap_hash,
 	&nvmet_host_attr_dhchap_dhgroup,
 	NULL,
@@ -2317,6 +2372,11 @@ static struct config_group *nvmet_hosts_make_group(struct config_group *group,
 #ifdef CONFIG_NVME_TARGET_AUTH
 	/* Default to SHA256 */
 	host->dhchap_hash_id = NVME_AUTH_HASH_SHA256;
+	host->dhchap_keyring = key_lookup(nvme_keyring_id());
+	if (IS_ERR(host->dhchap_keyring)) {
+		kfree(host);
+		return ERR_PTR(-ENOKEY);
+	}
 #endif
 
 	config_group_init_type_name(&host->group, name, &nvmet_host_type);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 772a3fc69162..30ec38142ef3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -382,6 +382,7 @@ struct nvmet_host {
 	bool			dhchap_key_generated;
 	struct key		*dhchap_ctrl_key;
 	bool			dhchap_ctrl_key_generated;
+	struct key		*dhchap_keyring;
 	u8			dhchap_hash_id;
 	u8			dhchap_dhgroup_id;
 };
-- 
2.35.3


