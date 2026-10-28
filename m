Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8CD606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 05:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PF2MWSmR;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=I601Xg6+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=5Ir5Ptx6wxJj62zqcl/rkwae7e8ti3xBH2DQczC7hUI=; b=PF2MWSmR7OzB5wu8lPyaxAY158
	N3z6wnOVT/Hl2JZUg+W+NurEtSBsAUmLNcBUu2MBk/nseTGvTYQV4HOO5RUoWqeMV5+OFr6X2bb1S
	L186+/CwJX87O/XoGONlWV7GvpoWNCH0g15ejhZNsuhL2qUdWtdygr71fbpwpTIDnBlRlNAH6jF+R
	AQjOHtOwIlhiVxwWYA123c2hJCg4J4nbQIeDx4Th2+iXxptsVvlnbXuvohVwSCtjQqVDaftCUFd8+
	VNZ4ThnOOGbAeZQpmgwvUtqG1KX7+1+A0hx0VgrP0wYZQ4I7eQw/Wg9QgSSIZrCC2VTahsx+NCwqq
	csPonv3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLvzj-00000006Mjo-0aUd;
	Wed, 28 Oct 2026 05:14:39 +0000
Received: from m16.mail.163.com ([117.135.210.2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLvzf-00000006MjS-0MIi
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 05:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5I
	r5Ptx6wxJj62zqcl/rkwae7e8ti3xBH2DQczC7hUI=; b=I601Xg6+bor4TeG2lk
	DzsD1Hrt0PyijJH9C8Y5NgiYNZ2SkTQIHCQ/nVVi+gfJ1SvqABfzQkRC261aqF1d
	OfAwSvp5DbD/wUl++A5jAD9l8VDlSH5l9v2zY7MdT9PiTRHAmdT/AB8QaMAH+n8e
	iRlCLvX6q6Y8ucetmZowjxDVQ=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3N956hOFq5V9qDQ--.31027S2;
	Wed, 28 Oct 2026 13:13:31 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Armen Baloyan <armenx.baloyan@intel.com>,
	Jay Freyensee <james.p.freyensee@intel.com>,
	Anthony Knapp <anthony.j.knapp@intel.com>,
	Ming Lin <ming.l@ssi.samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Max Gurtovoy <maxg@mellanox.com>,
	Steve Wise <larrystevenwise@gmail.com>,
	Guixin Liu <kanie@linux.alibaba.com>,
	Keith Busch <kbusch@kernel.org>,
	Israel Rukshin <israelr@nvidia.com>,
	Aurelien Aptel <aaptel@nvidia.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] nvmet: serialize port attribute updates with enable
Date: Wed, 28 Oct 2026 13:13:29 +0800
Message-Id: <20261028051329.149005-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3N956hOFq5V9qDQ--.31027S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Kw4rZFyUuFyxJr4fZw47urg_yoWktw4xpF
	sxXFy5tr9rKrWIkrnayrWqkry5Cwn7ArZ5X3yUG3sFyw1Fyry3Jws8CasIvFyDtrn2grW5
	Gr4kGFs3ZayYyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jf0eQUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xtSjGrhhHsUTwAA3F
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_221435_516637_989615F6 
X-CRM114-Status: GOOD (  18.47  )
X-Spam-Score: -1.8 (-)
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
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Port configfs stores check port->enabled before updating address and
transport parameters, but the check and update are not serialized with
nvmet_enable_port().  A concurrent enable can therefore consume a
partially updated address or validate one value and publish another.

Hold nvmet_config_sem for writing across each enabled check and update.
Parse independent input values before taking the semaphore so invalid
input does not unnecessarily block configuration users.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Fixes: 0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data")
Fixes: ca2b221d89a8 ("nvmet: introduce new max queue size configuration entry")
Fixes: 0a5a94648627 ("nvmet: introduce new mdts configuration entry")
Fixes: ea52ac1c6605 ("nvmet: add metadata/T10-PI support")
Fixes: 3f123494db72 ("nvmet: make TCP sectype settable via configfs")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/nvme/target/configfs.c | 222 ++++++++++++++++++---------------
 1 file changed, 124 insertions(+), 98 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 8aea64d279c4..8d70cb8ac796 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -83,9 +83,6 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	int i;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
 	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
 		if (sysfs_streq(page, nvmet_addr_family[i].name))
 			goto found;
@@ -95,7 +92,11 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
 	return -EINVAL;
 
 found:
-	port->disc_addr.adrfam = nvmet_addr_family[i].type;
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		port->disc_addr.adrfam = nvmet_addr_family[i].type;
+	}
 	return count;
 }
 
@@ -120,10 +121,11 @@ static ssize_t nvmet_addr_portid_store(struct config_item *item,
 		return -EINVAL;
 	}
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
-	port->disc_addr.portid = cpu_to_le16(portid);
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		port->disc_addr.portid = cpu_to_le16(portid);
+	}
 	return count;
 }
 
@@ -141,17 +143,21 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	char traddr[NVMF_TRADDR_SIZE + 1];
 
 	if (count > NVMF_TRADDR_SIZE) {
 		pr_err("Invalid value '%s' for traddr\n", page);
 		return -EINVAL;
 	}
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
-	if (sscanf(page, "%s\n", port->disc_addr.traddr) != 1)
+	if (sscanf(page, "%s\n", traddr) != 1)
 		return -EINVAL;
+
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		strscpy(port->disc_addr.traddr, traddr);
+	}
 	return count;
 }
 
@@ -186,12 +192,8 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
-	u8 treq = nvmet_port_disc_addr_treq_mask(port);
 	int i;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
 	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
 		if (sysfs_streq(page, nvmet_addr_treq[i].name))
 			goto found;
@@ -201,22 +203,29 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 	return -EINVAL;
 
 found:
-	if (port->disc_addr.trtype == NVMF_TRTYPE_TCP &&
-	    port->disc_addr.tsas.tcp.sectype == NVMF_TCP_SECTYPE_TLS13) {
-		switch (nvmet_addr_treq[i].type) {
-		case NVMF_TREQ_NOT_SPECIFIED:
-			pr_debug("treq '%s' not allowed for TLS1.3\n",
-				 nvmet_addr_treq[i].name);
-			return -EINVAL;
-		case NVMF_TREQ_NOT_REQUIRED:
-			pr_warn("Allow non-TLS connections while TLS1.3 is enabled\n");
-			break;
-		default:
-			break;
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		u8 treq;
+
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		treq = nvmet_port_disc_addr_treq_mask(port);
+		if (port->disc_addr.trtype == NVMF_TRTYPE_TCP &&
+		    port->disc_addr.tsas.tcp.sectype == NVMF_TCP_SECTYPE_TLS13) {
+			switch (nvmet_addr_treq[i].type) {
+			case NVMF_TREQ_NOT_SPECIFIED:
+				pr_debug("treq '%s' not allowed for TLS1.3\n",
+					 nvmet_addr_treq[i].name);
+				return -EINVAL;
+			case NVMF_TREQ_NOT_REQUIRED:
+				pr_warn("Allow non-TLS connections while TLS1.3 is enabled\n");
+				break;
+			default:
+				break;
+			}
 		}
+		treq |= nvmet_addr_treq[i].type;
+		port->disc_addr.treq = treq;
 	}
-	treq |= nvmet_addr_treq[i].type;
-	port->disc_addr.treq = treq;
 	return count;
 }
 
@@ -234,16 +243,20 @@ static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	char trsvcid[NVMF_TRSVCID_SIZE + 1];
 
 	if (count > NVMF_TRSVCID_SIZE) {
 		pr_err("Invalid value '%s' for trsvcid\n", page);
 		return -EINVAL;
 	}
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
-	if (sscanf(page, "%s\n", port->disc_addr.trsvcid) != 1)
+	if (sscanf(page, "%s\n", trsvcid) != 1)
 		return -EINVAL;
+
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		strscpy(port->disc_addr.trsvcid, trsvcid);
+	}
 	return count;
 }
 
@@ -261,15 +274,18 @@ static ssize_t nvmet_param_inline_data_size_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
-	int ret;
+	int ret, inline_data_size;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-	ret = kstrtoint(page, 0, &port->inline_data_size);
+	ret = kstrtoint(page, 0, &inline_data_size);
 	if (ret) {
 		pr_err("Invalid value '%s' for inline_data_size\n", page);
 		return -EINVAL;
 	}
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		port->inline_data_size = inline_data_size;
+	}
 	return count;
 }
 
@@ -287,15 +303,18 @@ static ssize_t nvmet_param_max_queue_size_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
-	int ret;
+	int ret, max_queue_size;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-	ret = kstrtoint(page, 0, &port->max_queue_size);
+	ret = kstrtoint(page, 0, &max_queue_size);
 	if (ret) {
 		pr_err("Invalid value '%s' for max_queue_size\n", page);
 		return -EINVAL;
 	}
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		port->max_queue_size = max_queue_size;
+	}
 	return count;
 }
 
@@ -314,15 +333,17 @@ static ssize_t nvmet_param_mdts_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	int ret, mdts;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
 	ret = kstrtoint(page, 0, &mdts);
 	if (ret || mdts < 0 || mdts > NVMET_MAX_MDTS) {
 		pr_err("Invalid value '%s' for mdts, should be 0-%d\n",
 		       page, NVMET_MAX_MDTS);
 		return -EINVAL;
 	}
-	port->mdts = mdts;
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		port->mdts = mdts;
+	}
 	return count;
 }
 
@@ -346,10 +367,11 @@ static ssize_t nvmet_param_pi_enable_store(struct config_item *item,
 	if (kstrtobool(page, &val))
 		return -EINVAL;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
-	port->pi_enable = val;
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		port->pi_enable = val;
+	}
 	return count;
 }
 
@@ -389,9 +411,6 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	int i;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
 	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
 		if (sysfs_streq(page, nvmet_transport[i].name))
 			goto found;
@@ -401,12 +420,16 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 	return -EINVAL;
 
 found:
-	memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
-	port->disc_addr.trtype = nvmet_transport[i].type;
-	if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA)
-		nvmet_port_init_tsas_rdma(port);
-	else if (port->disc_addr.trtype == NVMF_TRTYPE_TCP)
-		nvmet_port_init_tsas_tcp(port, NVMF_TCP_SECTYPE_NONE);
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
+		port->disc_addr.trtype = nvmet_transport[i].type;
+		if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA)
+			nvmet_port_init_tsas_rdma(port);
+		else if (port->disc_addr.trtype == NVMF_TRTYPE_TCP)
+			nvmet_port_init_tsas_tcp(port, NVMF_TCP_SECTYPE_NONE);
+	}
 	return count;
 }
 
@@ -468,52 +491,55 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
-	u8 treq = nvmet_port_disc_addr_treq_mask(port);
-	u8 sectype, qptype;
-
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
-	if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA) {
-		qptype = nvmet_addr_tsas_rdma_store(page);
-		if (qptype == port->disc_addr.tsas.rdma.qptype)
-			return count;
-	} else if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
-		sectype = nvmet_addr_tsas_tcp_store(page);
-		if (sectype != NVMF_TCP_SECTYPE_INVALID)
-			goto found;
-	}
 
-	pr_err("Invalid value '%s' for tsas\n", page);
-	return -EINVAL;
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		u8 treq = nvmet_port_disc_addr_treq_mask(port);
+		u8 sectype, qptype;
+
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+
+		if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA) {
+			qptype = nvmet_addr_tsas_rdma_store(page);
+			if (qptype == port->disc_addr.tsas.rdma.qptype)
+				return count;
+		} else if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
+			sectype = nvmet_addr_tsas_tcp_store(page);
+			if (sectype != NVMF_TCP_SECTYPE_INVALID)
+				goto found;
+		}
+
+		pr_err("Invalid value '%s' for tsas\n", page);
+		return -EINVAL;
 
 found:
-	if (sectype == NVMF_TCP_SECTYPE_TLS13) {
-		if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS)) {
-			pr_err("TLS is not supported\n");
-			return -EINVAL;
-		}
-		if (!port->keyring) {
-			pr_err("TLS keyring not configured\n");
-			return -EINVAL;
+		if (sectype == NVMF_TCP_SECTYPE_TLS13) {
+			if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS)) {
+				pr_err("TLS is not supported\n");
+				return -EINVAL;
+			}
+			if (!port->keyring) {
+				pr_err("TLS keyring not configured\n");
+				return -EINVAL;
+			}
 		}
-	}
 
-	nvmet_port_init_tsas_tcp(port, sectype);
-	/*
-	 * If TLS is enabled TREQ should be set to 'required' per default
-	 */
-	if (sectype == NVMF_TCP_SECTYPE_TLS13) {
-		u8 sc = nvmet_port_disc_addr_treq_secure_channel(port);
-
-		if (sc == NVMF_TREQ_NOT_SPECIFIED)
-			treq |= NVMF_TREQ_REQUIRED;
-		else
-			treq |= sc;
-	} else {
-		treq |= NVMF_TREQ_NOT_SPECIFIED;
+		nvmet_port_init_tsas_tcp(port, sectype);
+		/*
+		 * If TLS is enabled TREQ should be set to 'required' per default
+		 */
+		if (sectype == NVMF_TCP_SECTYPE_TLS13) {
+			u8 sc = nvmet_port_disc_addr_treq_secure_channel(port);
+
+			if (sc == NVMF_TREQ_NOT_SPECIFIED)
+				treq |= NVMF_TREQ_REQUIRED;
+			else
+				treq |= sc;
+		} else {
+			treq |= NVMF_TREQ_NOT_SPECIFIED;
+		}
+		port->disc_addr.treq = treq;
 	}
-	port->disc_addr.treq = treq;
 	return count;
 }
 
-- 
2.34.1


