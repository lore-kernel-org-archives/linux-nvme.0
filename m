Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C85C27C7B
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jun 2024 07:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XErsHjvldYtRsFMpcGK0Vm13G25DGg4ajn+zdCo08iE=; b=4+95EkDaNYJKeOENJbwuNnfpCx
	+ZxsNuMk5Hm6xn84+TmUDSzzSBtoTNoGhDuZvJzHyEoxkSCAxjah4jifM5s9Dv/zihdGEDHDOaQnH
	v6JD3uCl38EthqpQgQCqds+B/kgB0o467XXtXlGEs3DqQ2Em8f8KeQQZVhGl5aF4rpb4W6R8Tsr5W
	zRgV1VU8kig3sWd6wg/zMQyAFwJyFY0bKImYl6qYz1q/AY50FJnOhK6fLPzbt7SqVsC6dYeyX90u1
	RWYqPPASz0qyAQhqlUe6ixRmhlfCnEmKgic7l1eOaiCdxdovZYEG1Vdzpgnyi1UMsrqxNR8cAFdoG
	3lppu0Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ6mN-00000009e5G-19LF;
	Mon, 17 Jun 2024 07:27:51 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ6mJ-00000009e2k-0N9B
	for linux-nvme@lists.infradead.org;
	Mon, 17 Jun 2024 07:27:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 52C8ECE0FC4;
	Mon, 17 Jun 2024 07:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D07C3277B;
	Mon, 17 Jun 2024 07:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718609264;
	bh=i8fo/oLDZknd+XqbZvFyV++8is9pp5nLyXHplntCrks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nqpxOSSMIi3p/8wzRlzCx4LPjs3zaXwaM5KQ5z5iep7OwvKrEsOpEDN6VFVs7Oez0
	 6dxVEPyhuAfyTX0LCkICwf/P7Z3LB915calVDYrjx69jjZeQzVfMkhGGEFXOiD5qRz
	 gUVJj5mrl3Bq+4znwU5HXgTbMMbQ/4gXFt+8pCgcOCvvvVbw7Q1dAUGKGgK4z1lCxU
	 ziAauskElwl85nacnmjiOJkZEXISjXDep2SxKRlGQmFssxx6J8WUHBG3fbEPGdYbUD
	 fe7/88JXnzBBjn0kdb0enQXpVkBXFnyl/ouwAnlLxRfkeB5nvCY3A6Rf21i0aVV7SX
	 J/J+XxXEauo8w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/3] nvmet: make 'tsas' attribute idempotent for RDMA
Date: Mon, 17 Jun 2024 09:27:28 +0200
Message-Id: <20240617072728.134728-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617072728.134728-1-hare@kernel.org>
References: <20240617072728.134728-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_002747_687278_95A84E0B 
X-CRM114-Status: GOOD (  14.47  )
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

The RDMA transport defines values for TSAS, but it cannot be changed as
we only support the 'connected' mode.
So to avoid errors during reconfiguration we should allow to write the
current value.

Fixes: 3f123494db72 ("nvmet: make TCP sectype settable via configfs")
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/configfs.c | 39 ++++++++++++++++++++++++++--------
 include/linux/nvme.h           |  2 ++
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e60224356048..685e89b35d33 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -413,25 +413,46 @@ static ssize_t nvmet_addr_tsas_show(struct config_item *item,
 	return sprintf(page, "\n");
 }
 
+static u8 nvmet_addr_tsas_rdma_store(const char *page)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_rdma); i++) {
+		if (sysfs_streq(page, nvmet_addr_tsas_rdma[i].name))
+			return nvmet_addr_tsas_rdma[i].type;
+	}
+	return NVMF_RDMA_QPTYPE_INVALID;
+}
+
+static u8 nvmet_addr_tsas_tcp_store(const char *page)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_tcp); i++) {
+		if (sysfs_streq(page, nvmet_addr_tsas_tcp[i].name))
+			return nvmet_addr_tsas_tcp[i].type;
+	}
+	return NVMF_TCP_SECTYPE_INVALID;
+}
+
 static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
 	u8 treq = nvmet_port_disc_addr_treq_mask(port);
-	u8 sectype;
-	int i;
+	u8 sectype, qptype;
 
 	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
 
-	if (port->disc_addr.trtype != NVMF_TRTYPE_TCP)
-		return -EINVAL;
-
-	for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_tcp); i++) {
-		if (sysfs_streq(page, nvmet_addr_tsas_tcp[i].name)) {
-			sectype = nvmet_addr_tsas_tcp[i].type;
+	if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA) {
+		qptype = nvmet_addr_tsas_rdma_store(page);
+		if (qptype == port->disc_addr.tsas.rdma.qptype)
+			return count;
+	} else if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
+		sectype = nvmet_addr_tsas_tcp_store(page);
+		if (sectype != NVMF_TCP_SECTYPE_INVALID)
 			goto found;
-		}
 	}
 
 	pr_err("Invalid value '%s' for tsas\n", page);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 0993703f6617..efda407622c1 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -85,6 +85,7 @@ enum {
 enum {
 	NVMF_RDMA_QPTYPE_CONNECTED	= 1, /* Reliable Connected */
 	NVMF_RDMA_QPTYPE_DATAGRAM	= 2, /* Reliable Datagram */
+	NVMF_RDMA_QPTYPE_INVALID	= 0xff,
 };
 
 /* RDMA Provider Type codes for Discovery Log Page entry TSAS
@@ -110,6 +111,7 @@ enum {
 	NVMF_TCP_SECTYPE_NONE = 0, /* No Security */
 	NVMF_TCP_SECTYPE_TLS12 = 1, /* TLSv1.2, NVMe-oF 1.1 and NVMe-TCP 3.6.1.1 */
 	NVMF_TCP_SECTYPE_TLS13 = 2, /* TLSv1.3, NVMe-oF 1.1 and NVMe-TCP 3.6.1.1 */
+	NVMF_TCP_SECTYPE_INVALID = 0xff,
 };
 
 #define NVME_AQ_DEPTH		32
-- 
2.35.3


