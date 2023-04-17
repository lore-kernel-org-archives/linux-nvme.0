Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75E1C77B77
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 13:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KtSpNgKrPfslxHev0vwTjRy2goQY36AKDkfQfPR7cik=; b=KzoPKsPZr0qK2sE4VrkkvUsd0U
	lpXAPLi1WBFb7xn2CcbHtTWizPpE9O3gPwjWdIQ33WvAetStNMTs1z12AqQaPKfOUk9z5zy7Yh4Lp
	JucI/jny+Lu3zioZdJpLKeJtmQ0XTxi4heElG2t3wtXxNr2APfd/Mx/wJhkFaXfwe0Kp5/I0A8k62
	vYmk0q38ValbO97WuF1EmfZsuG3//6SPiFYBbi4qZN/jCxIK17JfvZswkno10TGCQYgiv3NKC0Ose
	q2XXNbR4Xy8H5kr+zYA1JIGig1KL7Pm5+c14MvZUR9moa8NOYGO+En48wXIuXeAuYKPAZsCUzEWfj
	dxGokE/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poOW1-00GI8R-24;
	Mon, 17 Apr 2023 13:03:29 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poOVj-00GHrJ-25
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 13:03:20 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 617FB21A79;
	Mon, 17 Apr 2023 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681736584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtSpNgKrPfslxHev0vwTjRy2goQY36AKDkfQfPR7cik=;
	b=e3n9P6odrb3kktN7vW3tnRPjVQ88fd2PvVwHJxh+hS7jGRGVyRxFtPXQrMLZCy//N8hSPf
	CZdTsoXxdzcU7r8hiN99jJ5Fppoc7KYT9H5UNekBItD0pqJ2tdGK/zqdPpVcKgKHuVqWgT
	VCrRdY5L63Vj4wfnrv7v/qHHecwF89Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681736584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtSpNgKrPfslxHev0vwTjRy2goQY36AKDkfQfPR7cik=;
	b=+v21ZnZ5pdnQ1QLI+2eUA9Y4I5NcTXpHMVCCwD6Dcj3p8NM/uelTlkrCuPSVAMpsy/Hfs+
	qnxseBUn6jWnFwBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 514BC2C15F;
	Mon, 17 Apr 2023 13:03:04 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 4DAE551C25B6; Mon, 17 Apr 2023 15:03:04 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 14/18] nvmet: make TCP sectype settable via configfs
Date: Mon, 17 Apr 2023 15:02:58 +0200
Message-Id: <20230417130302.86274-15-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230417130302.86274-1-hare@suse.de>
References: <20230417130302.86274-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_060311_846963_8D8CB87B 
X-CRM114-Status: GOOD (  15.56  )
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
---
 drivers/nvme/target/configfs.c | 65 ++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 907143870da5..7f826ac8b75c 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -303,6 +303,11 @@ static void nvmet_port_init_tsas_rdma(struct nvmet_port *port)
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
@@ -325,11 +330,70 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
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
+	int i;
+
+	if (nvmet_is_port_enabled(port, __func__))
+		return -EACCES;
+
+	if (port->disc_addr.trtype != NVMF_TRTYPE_TCP)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_tcp); i++) {
+		if (sysfs_streq(page, nvmet_addr_tsas_tcp[i].name))
+			goto found;
+	}
+
+	pr_err("Invalid value '%s' for tsas\n", page);
+	return -EINVAL;
+
+found:
+	nvmet_port_init_tsas_tcp(port, nvmet_addr_tsas_tcp[i].type);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_, addr_tsas);
+
 /*
  * Namespace structures & file operation functions below
  */
@@ -1741,6 +1805,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_addr_traddr,
 	&nvmet_attr_addr_trsvcid,
 	&nvmet_attr_addr_trtype,
+	&nvmet_attr_addr_tsas,
 	&nvmet_attr_param_inline_data_size,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_attr_param_pi_enable,
-- 
2.35.3


