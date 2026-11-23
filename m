Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06117606A691
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cHFX80ud;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PsaJzDF6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=clzuwGDChSjnuYA9Nc3biU06zpgNonmQHwPRIr1/QGQ=; b=cHFX80ud93Vt47
	XpKesyRwXssndw6nRbkl1G4iwID2cr/lRPEkNQWtfNxhPBQ/6WV3KeoNLae3Ks3lYfi5fLiEJ7Nfm
	PRUdw+d9stunjVZMndA+PHtXlmKQWeSDkN7yMDcvv4cyRKg159AcmNKnYtIPO+telOEGhHGlLsn9y
	OcpNfWQMv/DCcOir2FmOjrOiBiIA3k45Se+8icxTQkW+nk5NXmnLROe0fDQrscG91Sv+C4eQTza3P
	pO1JYTMLT5rotjvTZpkRqNEVIi37Ust+CoJkzaOH4qo4xG0TeW+27dzxztYPSI5VV8lXAwDqs1WlD
	Lyjo7/DO66OzW4xVff5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXYx-00000004JA6-2po5;
	Mon, 23 Nov 2026 17:10:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXYs-00000004J3w-2p2K
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 17:10:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6C6AC456E7;
	Mon, 23 Nov 2026 17:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701DD1F01563;
	Mon, 23 Nov 2026 17:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795453838;
	bh=clzuwGDChSjnuYA9Nc3biU06zpgNonmQHwPRIr1/QGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PsaJzDF6BiVbo5ChLte9A6tyEVBXaHNddNzDmL2ZLNbnPcer1zpO/mj3fqaVq3pN2
	 hwy/Jv5raJNcB5wCP4Obc1NmG3jxdJ0ni4KnG44iie2+wubKIBsPvrQO1Iz8pkOOXf
	 HXCtU3fyHJouHzDdg0XSTfHqx3ZXMeJW4CD7JYetADrO+FF8ewCHx/ZXkJXJkkFdRZ
	 bF8UP1lJXW0idFx1EQqXOy6HvYb+yGOWiHsNg1e7lHol2Nap6+yTsZ6kayH4J6I0eA
	 j4j0nnQdzuFE8a+XJ0V26lBBO0wO3qSSZNynq2G1dIskrtuD/yhYzHOGxBIjKozksm
	 0EkpRihiMbqHw==
From: Hannes Reinecke <hare@kernel.org>
Date: Mon, 23 Nov 2026 18:10:09 +0100
Subject: [PATCH v6 9/9] nvmet: add configfs attribute 'dhchap_keyring'
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-dhchap-keyring-v4-v6-9-5082a49715ab@kernel.org>
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
In-Reply-To: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795453811; l=4650;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=2Cc2DvJN7A2cNvu7PZ1WA6a3wRTvTTqQcSgCiiCecqA=;
 b=iqaQNNSJjXdgloNKj3CEnomCUzAFYQSknrm7Y/vgsk1aBKNY7EViLd79dttdIXwhFIvpp08u4
 GuhQGwIBjCnBDPpX+9pARCf77ToJdzibGvS52gubvVhb1HkKZalO74S
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
 drivers/nvme/target/auth.c     |  4 ++-
 drivers/nvme/target/configfs.c | 65 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index c3fa4ab78fb94a34390e0ef9c0ce68df95392741..eb6c1f7598f6303b901ebab0b4674e5b7b0d43c8 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -67,7 +67,9 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		return 0;
 	}
 	len = strcspn(secret, "\n");
-	key = nvme_auth_extract_key(NULL, secret, len, &generated);
+	down_read(&nvmet_config_sem);
+	key = nvme_auth_extract_key(host->dhchap_keyring, secret, len, &generated);
+	up_read(&nvmet_config_sem);
 	if (IS_ERR(key)) {
 		pr_debug("%s: invalid key specification\n", __func__);
 		return PTR_ERR(key);
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e19af764561ec4eec504f0ce4e6f301a0dded257..179f6bef77372029d99d7aa0cae3456c7fbea1d9 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2350,6 +2350,64 @@ static ssize_t nvmet_host_dhchap_ctrl_key_store(struct config_item *item,
 
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
+			ret = scnprintf(page, PAGE_SIZE,
+					"%s\n", keyring->description);
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
+	char *desc = NULL;
+	size_t len;
+	int ret = 0;
+
+	len = strcspn(page, "\n");
+	if (len) {
+		desc = kstrndup(page, len, GFP_KERNEL);
+		if (!desc)
+			return -ENOMEM;
+		keyring = request_key(&key_type_keyring, desc, NULL);
+	} else
+		keyring = key_lookup(nvme_keyring_id());
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
+	return ret < 0 ? ret : count;
+}
+
+CONFIGFS_ATTR(nvmet_host_, dhchap_keyring);
+
 static ssize_t nvmet_host_dhchap_hash_show(struct config_item *item,
 		char *page)
 {
@@ -2407,6 +2465,7 @@ CONFIGFS_ATTR(nvmet_host_, dhchap_dhgroup);
 static struct configfs_attribute *nvmet_host_attrs[] = {
 	&nvmet_host_attr_dhchap_key,
 	&nvmet_host_attr_dhchap_ctrl_key,
+	&nvmet_host_attr_dhchap_keyring,
 	&nvmet_host_attr_dhchap_hash,
 	&nvmet_host_attr_dhchap_dhgroup,
 	NULL,
@@ -2420,6 +2479,7 @@ static void nvmet_host_release(struct config_item *item)
 #ifdef CONFIG_NVME_TARGET_AUTH
 	nvmet_auth_revoke_key(host, false);
 	nvmet_auth_revoke_key(host, true);
+	key_put(host->dhchap_keyring);
 #endif
 	kfree(host);
 }
@@ -2448,6 +2508,11 @@ static struct config_group *nvmet_hosts_make_group(struct config_group *group,
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


