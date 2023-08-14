Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C89EEB64DD
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 11:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=McCbhNhplw5DjI+5cU12FnF1bGCwYxlAug8yNRx8Xpk=; b=5A0HhurKBsYxEm5dXUqlL4QSqZ
	EI5v1aSR7zHUJMCT4svReoQBkwhXlFEsZsP6LOK3OuQfJWGGgRJsKKRpz6U51RRodTBUuELpScabq
	L9L/DLAI5ekfyHJS5fAPY4wVAqC1UuLBNN7cuBg4xvdfBMY3oUErpJfiHp8e3es1j+fjsPMGE9qng
	X443gFQEdISFjhhAzc3Qd6iJc+aA0ZfxrcbNVIzVMEXicuE+OKxGgJr4M9gOJ1mavZr2j6rAbUTPZ
	W0466mP2SdF13hGTAcGHkC8VU5rTNSCjjtzvRR+BuUF5VfRsdkKzagaeExRbZrH2s0RtkX3fTYqPv
	8BbkxdYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVVcM-00Gv0Q-07;
	Mon, 14 Aug 2023 11:20:14 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVVc7-00GulP-0g
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 11:20:01 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 3DBD11FD6A;
	Mon, 14 Aug 2023 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692011992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McCbhNhplw5DjI+5cU12FnF1bGCwYxlAug8yNRx8Xpk=;
	b=RLO8aDku3ijNdhEzEKuqDd3WjfppRD79pKG7VPDATGJvNOmEbDKlalWeure/bM5/MIRobn
	PGIVNoVoQqeTysoH7evjaa229E2se0/rJ7rHzbLxKbyRjJkGcdPe40YBu0FukTbGYbEeaO
	idU3EMIQn2iO597siEOpnC4Zah6QmAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692011992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McCbhNhplw5DjI+5cU12FnF1bGCwYxlAug8yNRx8Xpk=;
	b=zch5pC0yjE5bKH85G3fPLk1As5GIJL2i05faSHCNlbdJ98X0E+R6VHtaEJ3hGvjCuGlVlm
	ZqAgZ5pcAdxU61Dg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 2BDBF2C16E;
	Mon, 14 Aug 2023 11:19:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 287A551CB0D5; Mon, 14 Aug 2023 13:19:52 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/17] nvmet: make TCP sectype settable via configfs
Date: Mon, 14 Aug 2023 13:19:37 +0200
Message-Id: <20230814111943.68325-12-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230814111943.68325-1-hare@suse.de>
References: <20230814111943.68325-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_041959_430356_1F9903B0 
X-CRM114-Status: GOOD (  16.21  )
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

Add a new configfs attribute 'addr_tsas' to make the TCP sectype
settable via configfs.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/configfs.c | 75 +++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 907143870da5..53862f2c6cd1 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -174,11 +174,16 @@ static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
 	return snprintf(page, PAGE_SIZE, "\n");
 }
 
+static inline u8 nvmet_port_disc_addr_treq_mask(struct nvmet_port *port)
+{
+	return (port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK);
+}
+
 static ssize_t nvmet_addr_treq_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
-	u8 treq = port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK;
+	u8 treq = nvmet_port_disc_addr_treq_mask(port);
 	int i;
 
 	if (nvmet_is_port_enabled(port, __func__))
@@ -303,6 +308,11 @@ static void nvmet_port_init_tsas_rdma(struct nvmet_port *port)
 	port->disc_addr.tsas.rdma.cms = NVMF_RDMA_CMS_RDMA_CM;
 }
 
+static void nvmet_port_init_tsas_tcp(struct nvmet_port *port, int sectype)
+{
+	port->disc_addr.tsas.tcp.sectype = sectype;
+}
+
 static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 		const char *page, size_t count)
 {
@@ -325,11 +335,73 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 	port->disc_addr.trtype = nvmet_transport[i].type;
 	if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA)
 		nvmet_port_init_tsas_rdma(port);
+	else if (port->disc_addr.trtype == NVMF_TRTYPE_TCP)
+		nvmet_port_init_tsas_tcp(port, NVMF_TCP_SECTYPE_NONE);
 	return count;
 }
 
 CONFIGFS_ATTR(nvmet_, addr_trtype);
 
+static const struct nvmet_type_name_map nvmet_addr_tsas_tcp[] = {
+	{ NVMF_TCP_SECTYPE_NONE,	"none" },
+	{ NVMF_TCP_SECTYPE_TLS13,	"tls1.3" },
+};
+
+static const struct nvmet_type_name_map nvmet_addr_tsas_rdma[] = {
+	{ NVMF_RDMA_QPTYPE_CONNECTED,	"connected" },
+	{ NVMF_RDMA_QPTYPE_DATAGRAM,	"datagram"  },
+};
+
+static ssize_t nvmet_addr_tsas_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	int i;
+
+	if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
+		for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_tcp); i++) {
+			if (port->disc_addr.tsas.tcp.sectype == nvmet_addr_tsas_tcp[i].type)
+				return sprintf(page, "%s\n", nvmet_addr_tsas_tcp[i].name);
+		}
+	} else if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA) {
+		for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_rdma); i++) {
+			if (port->disc_addr.tsas.rdma.qptype == nvmet_addr_tsas_rdma[i].type)
+				return sprintf(page, "%s\n", nvmet_addr_tsas_rdma[i].name);
+		}
+	}
+	return sprintf(page, "reserved\n");
+}
+
+static ssize_t nvmet_addr_tsas_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	u8 sectype;
+	int i;
+
+	if (nvmet_is_port_enabled(port, __func__))
+		return -EACCES;
+
+	if (port->disc_addr.trtype != NVMF_TRTYPE_TCP)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_tcp); i++) {
+		if (sysfs_streq(page, nvmet_addr_tsas_tcp[i].name)) {
+			sectype = nvmet_addr_tsas_tcp[i].type;
+			goto found;
+		}
+	}
+
+	pr_err("Invalid value '%s' for tsas\n", page);
+	return -EINVAL;
+
+found:
+	nvmet_port_init_tsas_tcp(port, sectype);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_, addr_tsas);
+
 /*
  * Namespace structures & file operation functions below
  */
@@ -1741,6 +1813,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_addr_traddr,
 	&nvmet_attr_addr_trsvcid,
 	&nvmet_attr_addr_trtype,
+	&nvmet_attr_addr_tsas,
 	&nvmet_attr_param_inline_data_size,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_attr_param_pi_enable,
-- 
2.35.3


