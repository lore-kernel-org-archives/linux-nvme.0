Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6693FC6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 14:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WHkdHK/3/opbOAIS9m0NV2IXi0RcQ2m2sZLAWOe/CoM=; b=LKRlTRGstrD5RQu1ptaUkaEgGr
	VXl2BbO6tdFY9tEhYKc/j0v6RFoR/foclpM+EwtZ1btdbrFphLZ+Vo9PRW+zKZDI0E2sD84yCrzYR
	uhjFZi6HTL+DONjcUy82702RIh8ECXA6dghCPLYdqqKmmn7hM7BMhNVTBongAnWzEHq/fHEI5G2+w
	8qL4wVAnSSb8tzyKXP04VspgeIhomqtdJmMvOFasWYSvR2hMhH5K9gBLLHZn9zfCOkPOI+HJdGhtJ
	XjWQCy/TT8XGUna02iHC2HR7qjt6sch8nUFIbFkvWgK4ZfYbOEAGVuDEPmi8bvitEyNn024mATxHg
	WmBTxmxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLf-000V7w-1U;
	Wed, 29 Mar 2023 14:00:23 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLI-000Ulc-0v
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 14:00:07 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 1D0691FE02;
	Wed, 29 Mar 2023 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680098390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHkdHK/3/opbOAIS9m0NV2IXi0RcQ2m2sZLAWOe/CoM=;
	b=UQVq57t2HbKpK7PR0fg7wJ3JNdAcpZ4qviHlmFsbVpYvHJfJRXuzbDUVpaYI9HI9bOmu9k
	NjfZNgH+AF2I8VfZlOpGUp5V+3/tuYjNuq2rm75yhET0f4BV3sogipRRmh4JmemPIdV0Vx
	0wEh/P9IkarSpNp/gM+hgn6Akbte9fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680098390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHkdHK/3/opbOAIS9m0NV2IXi0RcQ2m2sZLAWOe/CoM=;
	b=XMsYJP91YMW3kKd6YJFlX3bSxymCa+KhUW7hhPs5gvGk41CcC0DsZ/y6o13oMIoqiTN+Ob
	/cr7a2q4GhdaJjBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 0A8512C18A;
	Wed, 29 Mar 2023 13:59:50 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 0850751BF396; Wed, 29 Mar 2023 15:59:50 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 18/18] nvmet-tcp: add configfs attribute 'param_keyring'
Date: Wed, 29 Mar 2023 15:59:38 +0200
Message-Id: <20230329135938.46905-19-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329135938.46905-1-hare@suse.de>
References: <20230329135938.46905-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_070000_556414_3FDAE037 
X-CRM114-Status: GOOD (  17.68  )
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

Add a configfs attribute to list and change the default keyring.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c | 68 +++++++++++++++++++++++++++++++++-
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/tcp.c      |  3 +-
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 36fbf6a22d09..0a92bc8b25e5 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -15,6 +15,10 @@
 #ifdef CONFIG_NVME_TARGET_AUTH
 #include <linux/nvme-auth.h>
 #endif
+#include <linux/key.h>
+#ifdef CONFIG_NVME_TLS
+#include <linux/nvme-keyring.h>
+#endif
 #include <crypto/hash.h>
 #include <crypto/kpp.h>
 
@@ -294,6 +298,48 @@ static ssize_t nvmet_param_pi_enable_store(struct config_item *item,
 CONFIGFS_ATTR(nvmet_, param_pi_enable);
 #endif
 
+#ifdef CONFIG_NVME_TLS
+static ssize_t nvmet_param_keyring_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	if (!port->keyring)
+		return sprintf(page, "\n");
+	return snprintf(page, PAGE_SIZE, "%s\n",
+			port->keyring->description);
+}
+
+static ssize_t nvmet_param_keyring_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	struct key *keyring;
+	unsigned int keyring_id;
+	int ret;
+
+	if (nvmet_is_port_enabled(port, __func__))
+		return -EACCES;
+
+	ret = kstrtou32(page, 0, &keyring_id);
+	if (ret) {
+		pr_err("Invalid keyring id '%s'\n", page);
+		return ret;
+	}
+	keyring = key_lookup(keyring_id);
+	if (IS_ERR(keyring)) {
+		pr_err("Invalid keyring '%08x'\n", keyring_id);
+		return PTR_ERR(keyring);
+	}
+	if (port->keyring)
+		key_put(port->keyring);
+	port->keyring = keyring;
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_, param_keyring);
+#endif
+
 static ssize_t nvmet_addr_trtype_show(struct config_item *item,
 		char *page)
 {
@@ -404,9 +450,12 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 	return -EINVAL;
 
 found:
-	nvmet_port_init_tsas_tcp(port, nvmet_addr_tsas_tcp[i].type);
 	if (nvmet_addr_tsas_tcp[i].type == NVMF_TCP_SECTYPE_TLS13) {
 #ifdef CONFIG_NVME_TLS
+		if (!port->keyring) {
+			pr_err("NVMe keyring not available, cannot enable TLS 1.3\n");
+			return -ENOTSUPP;
+		}
 		if (NVMET_PORT_TREQ(port) == NVMF_TREQ_NOT_SPECIFIED)
 			treq |= NVMF_TREQ_REQUIRED;
 		else
@@ -419,6 +468,8 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 		/* Set to 'not specified' if TLS is not enabled */
 		treq |= NVMF_TREQ_NOT_SPECIFIED;
 	}
+	port->disc_addr.treq = treq;
+	nvmet_port_init_tsas_tcp(port, nvmet_addr_tsas_tcp[i].type);
 	return count;
 }
 
@@ -1825,6 +1876,8 @@ static void nvmet_port_release(struct config_item *item)
 	flush_workqueue(nvmet_wq);
 	list_del(&port->global_entry);
 
+	if (port->keyring)
+		key_put(port->keyring);
 	kfree(port->ana_state);
 	kfree(port);
 }
@@ -1839,6 +1892,9 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_param_inline_data_size,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_attr_param_pi_enable,
+#endif
+#ifdef CONFIG_NVME_TLS
+	&nvmet_attr_param_keyring,
 #endif
 	NULL,
 };
@@ -1857,6 +1913,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 		const char *name)
 {
 	struct nvmet_port *port;
+	struct key *keyring = NULL;
 	u16 portid;
 	u32 i;
 
@@ -1874,6 +1931,15 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 		return ERR_PTR(-ENOMEM);
 	}
 
+#ifdef CONFIG_NVME_TLS
+	keyring = key_lookup(nvme_keyring_id());
+	if (IS_ERR(keyring)) {
+		pr_warn("NVMe keyring not available, disabling TLS\n");
+		keyring = NULL;
+	}
+#endif
+	port->keyring = keyring;
+
 	for (i = 1; i <= NVMET_MAX_ANAGRPS; i++) {
 		if (i == NVMET_DEFAULT_ANA_GRPID)
 			port->ana_state[1] = NVME_ANA_OPTIMIZED;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ed3786140965..c31e310d269a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -158,6 +158,7 @@ struct nvmet_port {
 	struct config_group		ana_groups_group;
 	struct nvmet_ana_group		ana_default_group;
 	enum nvme_ana_state		*ana_state;
+	struct key			*keyring;
 	void				*priv;
 	bool				enabled;
 	int				inline_data_size;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 75017fd5da9f..5b1069854f15 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/key.h>
 #include <linux/nvme-tcp.h>
 #include <net/sock.h>
 #include <net/tcp.h>
@@ -1763,7 +1764,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 	args.ta_sock = queue->sock;
 	args.ta_done = nvmet_tcp_tls_handshake_done;
 	args.ta_data = queue;
-	args.ta_keyring = nvme_keyring_id();
+	args.ta_keyring = key_serial(queue->port->nport->keyring);
 	args.ta_timeout_ms = tls_handshake_timeout * 2 * 1024;
 
 	ret = tls_server_hello_psk(&args, GFP_KERNEL);
-- 
2.35.3


