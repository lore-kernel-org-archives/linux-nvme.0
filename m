Return-Path: <SRS0=1Q2H=NB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FB7C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 12:48:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C80460EFF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 12:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C80460EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PmoIjGTGBcLono35pkuL67zPPJG8Z6wmKRkW95pBvZc=; b=y8BimvGkA6I8uB
	j7BtAaUW6i4mKO3SLDVt50WISkkGU0BnCpDpXcY4pwIBjC6GBBetfQzjoe2tCI1Uk5gF/O7L01tSE
	/7h7ytv6kG8c8i8Aqxg2jTOzFMgsiMWGybTeHSrPuOdfch29Ja0vDf0k9M1i4ymA6pQGdrnSqWnci
	4PXjBuPcQDid9KbzlPUxiXGkayJPm0LEOnODa6GZSc3pw/HBkTiBwEMox5vod1i8fcXJRB6vFE6eB
	LbOFhD5OvKzydcqrH39EUmDs/qa5HrC1Ob/0k0owmqA8xVa9CtX5N3taftrGzCYwu2FW2GsNvvOy2
	XrU0g5qipLjUx0lfQk4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDRAT-003mdt-Kj; Tue, 10 Aug 2021 12:47:41 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDR5v-003l6E-5l
 for linux-nvme@lists.infradead.org; Tue, 10 Aug 2021 12:43:05 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 356B1200B2;
 Tue, 10 Aug 2021 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628599372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxVPhhmIEkG2QvaM+OJw+sU5fagj/1FaG8k8qmB+yhk=;
 b=PKDrajiHNK7ptsfVcnHMnWfbAmM/OdNxCsZ9Oghz60kXy42PLLdJXV5MFDzqeFQFvHcUxP
 fAorrLUXFfT0QPcpdHdinxQ3DcFBaoiEwlV6Fkaru/FF0ArePHCtvuygZO2z/RQ7eMZzjq
 GmaoIC5wllJEW7C/NVg0Xt192z0fevM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628599372;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxVPhhmIEkG2QvaM+OJw+sU5fagj/1FaG8k8qmB+yhk=;
 b=KWDew8DXXBDu1RO3QrVpLiy1DpqrQbOPWnFA4a4Yy+GAyhnKuqTzygXxGlKjXz3tuqsLIx
 LUDChVLgdtBIDhCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 2045DA3B94;
 Tue, 10 Aug 2021 12:42:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 885D2518C556; Tue, 10 Aug 2021 14:42:50 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/13] nvmet-auth: Diffie-Hellman key exchange support
Date: Tue, 10 Aug 2021 14:42:28 +0200
Message-Id: <20210810124230.12161-12-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210810124230.12161-1-hare@suse.de>
References: <20210810124230.12161-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_054259_480038_5CC699CA 
X-CRM114-Status: GOOD (  21.35  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Implement Diffie-Hellman key exchange using FFDHE groups for NVMe
In-Band Authentication.
This patch adds a new host configfs attribute 'dhchap_dhgroup' to
select the FFDHE group to use.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/auth.c             | 148 ++++++++++++++++++++++++-
 drivers/nvme/target/configfs.c         |  31 ++++++
 drivers/nvme/target/fabrics-cmd-auth.c |  30 ++++-
 drivers/nvme/target/nvmet.h            |   6 +
 4 files changed, 208 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 5b5f3cd4f914..fe44593a37f8 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -53,6 +53,71 @@ int nvmet_auth_set_host_key(struct nvmet_host *host, const char *secret)
 	return 0;
 }
 
+int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, int dhgroup_id)
+{
+	struct nvmet_host_link *p;
+	struct nvmet_host *host = NULL;
+	const char *dhgroup_kpp;
+	int ret = -ENOTSUPP;
+
+	if (dhgroup_id == NVME_AUTH_DHCHAP_DHGROUP_NULL)
+		return 0;
+
+	down_read(&nvmet_config_sem);
+	if (ctrl->subsys->type == NVME_NQN_DISC)
+		goto out_unlock;
+
+	list_for_each_entry(p, &ctrl->subsys->hosts, entry) {
+		if (strcmp(nvmet_host_name(p->host), ctrl->hostnqn))
+			continue;
+		host = p->host;
+		break;
+	}
+	if (!host) {
+		pr_debug("host %s not found\n", ctrl->hostnqn);
+		ret = -ENXIO;
+		goto out_unlock;
+	}
+
+	if (host->dhchap_dhgroup_id != dhgroup_id) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	if (ctrl->dh_tfm) {
+		if (ctrl->dh_gid == dhgroup_id) {
+			pr_debug("reuse existing DH group %d\n", dhgroup_id);
+			ret = 0;
+		} else {
+			pr_debug("DH group mismatch (selected %d, requested %d)\n",
+				 ctrl->dh_gid, dhgroup_id);
+			ret = -EINVAL;
+		}
+		goto out_unlock;
+	}
+
+	dhgroup_kpp = nvme_auth_dhgroup_kpp(dhgroup_id);
+	if (!dhgroup_kpp) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	ctrl->dh_tfm = crypto_alloc_kpp(dhgroup_kpp, 0, 0);
+	if (IS_ERR(ctrl->dh_tfm)) {
+		pr_debug("failed to setup DH group %d, err %ld\n",
+			 dhgroup_id, PTR_ERR(ctrl->dh_tfm));
+		ret = PTR_ERR(ctrl->dh_tfm);
+		ctrl->dh_tfm = NULL;
+	} else {
+		ctrl->dh_gid = dhgroup_id;
+		ctrl->dh_keysize = nvme_auth_dhgroup_pubkey_size(dhgroup_id);
+		ret = 0;
+	}
+
+out_unlock:
+	up_read(&nvmet_config_sem);
+
+	return ret;
+}
+
 int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 {
 	int ret = 0;
@@ -147,6 +212,11 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
 		ctrl->shash_tfm = NULL;
 		ctrl->shash_id = 0;
 	}
+	if (ctrl->dh_tfm) {
+		crypto_free_kpp(ctrl->dh_tfm);
+		ctrl->dh_tfm = NULL;
+		ctrl->dh_gid = 0;
+	}
 	if (ctrl->dhchap_key) {
 		kfree(ctrl->dhchap_key);
 		ctrl->dhchap_key = NULL;
@@ -182,8 +252,18 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 		return ret;
 	}
 	if (ctrl->dh_gid != NVME_AUTH_DHCHAP_DHGROUP_NULL) {
-		ret = -ENOTSUPP;
-		goto out;
+		challenge = kmalloc(shash_len, GFP_KERNEL);
+		if (!challenge) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		ret = nvme_auth_augmented_challenge(ctrl->shash_id,
+						    req->sq->dhchap_skey,
+						    req->sq->dhchap_skey_len,
+						    req->sq->dhchap_c1,
+						    challenge, shash_len);
+		if (ret)
+			goto out;
 	}
 
 	shash->tfm = ctrl->shash_tfm;
@@ -256,8 +336,18 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 		return ret;
 	}
 	if (ctrl->dh_gid != NVME_AUTH_DHCHAP_DHGROUP_NULL) {
-		ret = -ENOTSUPP;
-		goto out;
+		challenge = kmalloc(shash_len, GFP_KERNEL);
+		if (!challenge) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		ret = nvme_auth_augmented_challenge(ctrl->shash_id,
+						    req->sq->dhchap_skey,
+						    req->sq->dhchap_skey_len,
+						    req->sq->dhchap_c2,
+						    challenge, shash_len);
+		if (ret)
+			goto out;
 	}
 
 	shash->tfm = ctrl->shash_tfm;
@@ -299,3 +389,53 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 	kfree_sensitive(ctrl_response);
 	return 0;
 }
+
+int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
+				u8 *buf, int buf_size)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	int ret;
+
+	if (!ctrl->dh_tfm) {
+		pr_warn("No DH algorithm!\n");
+		return -ENOKEY;
+	}
+	ret = nvme_auth_gen_pubkey(ctrl->dh_tfm, buf, buf_size);
+	if (ret == -EOVERFLOW) {
+		pr_debug("public key buffer too small, need %d is %d\n",
+			 crypto_kpp_maxsize(ctrl->dh_tfm), buf_size);
+		ret = -ENOKEY;
+	} else if (ret) {
+		pr_debug("failed to generate public key, err %d\n", ret);
+		ret = -ENOKEY;
+	} else
+		pr_debug("%s: ctrl public key %*ph\n", __func__,
+			 (int)buf_size, buf);
+
+	return ret;
+}
+
+int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
+			    u8 *pkey, int pkey_size)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	int ret;
+
+	req->sq->dhchap_skey_len =
+		nvme_auth_dhgroup_privkey_size(ctrl->dh_gid);
+	req->sq->dhchap_skey = kzalloc(req->sq->dhchap_skey_len, GFP_KERNEL);
+	if (!req->sq->dhchap_skey)
+		return -ENOMEM;
+	ret = nvme_auth_gen_shared_secret(ctrl->dh_tfm,
+					  pkey, pkey_size,
+					  req->sq->dhchap_skey,
+					  req->sq->dhchap_skey_len);
+	if (ret)
+		pr_debug("failed to compute shared secred, err %d\n", ret);
+	else
+		pr_debug("%s: shared secret %*ph\n", __func__,
+			 (int)req->sq->dhchap_skey_len,
+			 req->sq->dhchap_skey);
+
+	return ret;
+}
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e0760911a761..e9b8884a83b0 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1712,9 +1712,40 @@ static ssize_t nvmet_host_dhchap_hash_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_host_, dhchap_hash);
 
+static ssize_t nvmet_host_dhchap_dhgroup_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_host *host = to_host(item);
+	const char *dhgroup = nvme_auth_dhgroup_name(host->dhchap_dhgroup_id);
+
+	return sprintf(page, "%s\n", dhgroup ? dhgroup : "none");
+}
+
+static ssize_t nvmet_host_dhchap_dhgroup_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_host *host = to_host(item);
+	int dhgroup_id;
+
+	dhgroup_id = nvme_auth_dhgroup_id(page);
+	if (dhgroup_id < 0)
+		return -EINVAL;
+	if (dhgroup_id != NVME_AUTH_DHCHAP_DHGROUP_NULL) {
+		const char *kpp = nvme_auth_dhgroup_kpp(dhgroup_id);
+
+		if (!crypto_has_kpp(kpp, 0, 0))
+			return -EINVAL;
+	}
+	host->dhchap_dhgroup_id = dhgroup_id;
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_host_, dhchap_dhgroup);
+
 static struct configfs_attribute *nvmet_host_attrs[] = {
 	&nvmet_host_attr_dhchap_key,
 	&nvmet_host_attr_dhchap_hash,
+	&nvmet_host_attr_dhchap_dhgroup,
 	NULL,
 };
 #endif /* CONFIG_NVME_TARGET_AUTH */
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index ab9dfc06bac0..2f1b95098917 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -64,13 +64,24 @@ static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 			null_dh = dhgid;
 			continue;
 		}
+		if (ctrl->dh_tfm && ctrl->dh_gid == dhgid) {
+			pr_debug("%s: ctrl %d qid %d: reusing existing DH group %d\n",
+				 __func__, ctrl->cntlid, req->sq->qid, dhgid);
+			break;
+		}
+		if (nvmet_setup_dhgroup(ctrl, dhgid) < 0)
+			continue;
+		if (nvme_auth_gen_privkey(ctrl->dh_tfm, dhgid) == 0)
+			break;
+		crypto_free_kpp(ctrl->dh_tfm);
+		ctrl->dh_tfm = NULL;
+		ctrl->dh_gid = 0;
 	}
-	if (null_dh < 0) {
+	if (!ctrl->dh_tfm && null_dh < 0) {
 		pr_debug("%s: ctrl %d qid %d: no DH group selected\n",
 			 __func__, ctrl->cntlid, req->sq->qid);
 		return NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
 	}
-	ctrl->dh_gid = null_dh;
 	pr_debug("%s: ctrl %d qid %d: DH group %s (%d)\n",
 		 __func__, ctrl->cntlid, req->sq->qid,
 		 nvme_auth_dhgroup_name(ctrl->dh_gid), ctrl->dh_gid);
@@ -91,7 +102,11 @@ static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
 		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 
 	if (data->dhvlen) {
-		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		if (!ctrl->dh_tfm)
+			return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		if (nvmet_auth_ctrl_sesskey(req, data->rval + 2 * data->hl,
+					    data->dhvlen) < 0)
+			return NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
 	}
 
 	response = kmalloc(data->hl, GFP_KERNEL);
@@ -232,6 +247,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		goto done_kfree;
 	}
+
 	switch (data->auth_id) {
 	case NVME_AUTH_DHCHAP_MESSAGE_REPLY:
 		status = nvmet_auth_reply(req, d);
@@ -303,6 +319,8 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
 	int hash_len = crypto_shash_digestsize(ctrl->shash_tfm);
 	int data_size = sizeof(*d) + hash_len;
 
+	if (ctrl->dh_tfm)
+		data_size += ctrl->dh_keysize;
 	if (al < data_size) {
 		pr_debug("%s: buffer too small (al %d need %d)\n", __func__,
 			 al, data_size);
@@ -321,6 +339,12 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
 		return -ENOMEM;
 	get_random_bytes(req->sq->dhchap_c1, data->hl);
 	memcpy(data->cval, req->sq->dhchap_c1, data->hl);
+	if (ctrl->dh_tfm) {
+		data->dhgid = ctrl->dh_gid;
+		data->dhvlen = ctrl->dh_keysize;
+		ret = nvmet_auth_ctrl_exponential(req, data->cval + data->hl,
+						  data->dhvlen);
+	}
 	pr_debug("%s: ctrl %d qid %d seq %d transaction %d hl %d dhvlen %d\n",
 		 __func__, ctrl->cntlid, req->sq->qid, req->sq->dhchap_s1,
 		 req->sq->dhchap_tid, data->hl, data->dhvlen);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index adcbe2523710..e9d18ca6ebbf 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -227,6 +227,7 @@ struct nvmet_ctrl {
 	size_t			dhchap_key_len;
 	struct crypto_shash	*shash_tfm;
 	u8			shash_id;
+	struct crypto_kpp	*dh_tfm;
 	u32			dh_gid;
 	u32			dh_keysize;
 #endif
@@ -693,6 +694,7 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl);
 void nvmet_init_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
+int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, int dhgroup_id);
 bool nvmet_check_auth_status(struct nvmet_req *req);
 int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int hash_len);
@@ -702,6 +704,10 @@ static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
 {
 	return ctrl->shash_tfm != NULL;
 }
+int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
+				u8 *buf, int buf_size);
+int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
+			    u8 *buf, int buf_size);
 #else
 static inline int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 {
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
