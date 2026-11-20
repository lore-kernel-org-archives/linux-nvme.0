Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC51606A33F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VH36X5Xr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TT8ykJtp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/JMR9TFiJzwG3lAtbz5hLpz0Matvxxs056r7ELV4oUQ=; b=VH36X5Xr9Edbt2
	IgSmXdoeizihQtbIsYctaHJbNF4lm63lXwN9RkD75IUyNl5iFXsu68lYDrg9q2dznmh4erKwV4V4r
	dVXhXoh1mcaEF2EXZzgTJjyDKpYk5LZwT8cb8oEOhdsCXieM5NgdL7c7ihg/ws+DDi5hJr5jPgUF8
	wP9EzFdAHclEoqm4Q9la5qqm6EEjNTBJMpw6/350clAzamgX/bsKh1Rhq7AzlKt9YWHbHa8KUbSr0
	a2B5p+oxQ/jdAtZYqd24WXvJg53RAMPW1ACK4+9CG3QtbW15GQ4aeZSdDsYzL4H/tfDiK7+6hG+DK
	AUi+Rk/PIk4AG5huclXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMZr-0000000EkzI-08Cg;
	Fri, 20 Nov 2026 11:14:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMZn-0000000Ekse-26Zh
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:14:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EB2DF6294D;
	Fri, 20 Nov 2026 11:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90001F000E0;
	Fri, 20 Nov 2026 11:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795173282;
	bh=/JMR9TFiJzwG3lAtbz5hLpz0Matvxxs056r7ELV4oUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TT8ykJtpYV/uDoVhZoACeJUjmYQgLZV4DMbKUXn8Z/yzNUmmLlcB3mrBKVloq2E70
	 LiFsCLfVXjXQTGtPPZRi93kQyDHKe0EKJgULID2/xgtHQJDL1RNqZa+kKaoKQUCM/s
	 L4+b8iUZgXqqYw3/ArqhJUv+ytVqEo2coXQxdPkWm/5GxBMdWk9gYJVwaLlTistKH9
	 EQ+9rbl2YiTPrH4/Odyvd5gKTuLkEcAisscZdTNx5l1jCeAKwNa6Uvz56+zagW0tlW
	 7WxDIsM8zi5rHG3zNFbPigUQ34z90Ge3OegGgvqasqjTQDHDw+s+NqqpQhxdHv8kkb
	 LJjGch4JHRFhw==
From: Hannes Reinecke <hare@kernel.org>
Date: Fri, 20 Nov 2026 12:14:08 +0100
Subject: [PATCH v4 9/9] nvmet: add configfs attribute 'dhchap_keyring'
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-dhchap-keyring-v4-v4-9-5f8c7d9926ee@kernel.org>
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
In-Reply-To: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795173255; l=4262;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=AM65PWWM2z4sGGsDwGsE+4TOPK1kOwxA9hN1ksrgpJ0=;
 b=vK9iz8yHuoz/OJXdBwjJsHv9Ah2fBaGEqTamycxz8YqdELzOnrYEwbcbpX2Hl/PVEthWz5CNK
 /kKpVfAD0/+AGXJrtfq+hhPIVy4+0rYfOGUirnWJwGfaFyCBrqI08iO
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=
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

The authentication code now fetches the key from the kernel keystore, so
we should be able to specify which keyring to use for looking up keys.
So add a configfs attribute 'dhchap_keyring' for the 'host' directory
to specify the keyring to use.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/auth.c     |  2 +-
 drivers/nvme/target/configfs.c | 62 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 4f2489c5d894b24f25eea8e55e26d2afa7ea40b1..d583813ef4f274853ec2adf961f2d0c3c3544be5 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -68,7 +68,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		return 0;
 	}
 	len = strcspn(secret, "\n");
-	key = nvme_auth_extract_key(NULL, secret, len, &generated);
+	key = nvme_auth_extract_key(host->dhchap_keyring, secret, len, &generated);
 	if (IS_ERR(key)) {
 		pr_debug("%s: invalid key specification\n", __func__);
 		return PTR_ERR(key);
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 319947aa0a40f918e15e9e2130ebf3a79e2d6efe..ffe0f852e59d9d45e7e90ebf8926c8be6fbf688e 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2347,6 +2347,62 @@ static ssize_t nvmet_host_dhchap_ctrl_key_store(struct config_item *item,
 
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
+		down_write(&nvmet_config_sem);
+		key_put(host->dhchap_keyring);
+		host->dhchap_keyring = keyring;
+		up_write(&nvmet_config_sem);
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
@@ -2404,6 +2460,7 @@ CONFIGFS_ATTR(nvmet_host_, dhchap_dhgroup);
 static struct configfs_attribute *nvmet_host_attrs[] = {
 	&nvmet_host_attr_dhchap_key,
 	&nvmet_host_attr_dhchap_ctrl_key,
+	&nvmet_host_attr_dhchap_keyring,
 	&nvmet_host_attr_dhchap_hash,
 	&nvmet_host_attr_dhchap_dhgroup,
 	NULL,
@@ -2445,6 +2502,11 @@ static struct config_group *nvmet_hosts_make_group(struct config_group *group,
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
index c8757cedcd841742ff79c830335cfab6e9fc2401..0f76633c6aa65cec26516bd7f0c55dea815a57f5 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -403,6 +403,7 @@ struct nvmet_host {
 	bool			dhchap_key_generated;
 	struct key		*dhchap_ctrl_key;
 	bool			dhchap_ctrl_key_generated;
+	struct key		*dhchap_keyring;
 	u8			dhchap_hash_id;
 	u8			dhchap_dhgroup_id;
 };

-- 
2.51.0


