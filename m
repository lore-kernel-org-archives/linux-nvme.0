Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E7FC27C75
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jun 2024 10:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TFX99lDPRisPtUCO7OAARY33fq8ztYug5D2Lvu+qiqA=; b=Mi3a9rXJn2nDhMhYj36iMFxvkJ
	h/k8d2w4S3Vb19hdOtIrPUZosKwagQMQoUbPiL1xCexOFBEvN9OiACwhZC9hYJuXg3Y6c/W6rtc69
	OS7hRNIGvxNQ6PibwE6UiESCRTdnYMziCewkX/mmW17MwpqDm0r32BfVOw5a8YJQ27QtApYKOGV2O
	fWealSiJSkXdG3+/CWHsFIgnkmtQoTDB5j1EgmQLbB+D1kvy31IQnUPG2TLF4NFiOVj+VUCoqvjvY
	hYy6LzebG9ENTU1oOxapWs/k5UjJfLbyYmaXOPwCpFevdsPSUzH2Eubag1pYabirXbLnQ22ohedMq
	q7HjHfqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI4QR-00000002V9f-0lvy;
	Fri, 14 Jun 2024 10:44:55 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI4QO-00000002V7w-0aij
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jun 2024 10:44:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3CDB8CE2AFC;
	Fri, 14 Jun 2024 10:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8C1C2BD10;
	Fri, 14 Jun 2024 10:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718361889;
	bh=BmmWD4mlqwLX059UdmHxUGBVSsUKH1vygmFp56564QI=;
	h=From:To:Cc:Subject:Date:From;
	b=WWrRx9/fPpqGSWcj1RwGk7ytk4P0UZfari/Iw32FcfxRwer0pQEeiG79S6CPWLL9n
	 FB9C81CU/vstjvvqphhNauLQ4bI/w67oFRPT6Kl8ynIe4mDMqNKV1PXAqCGFhlFMK9
	 spHD9REQ9hsmDbr9Dma+YOEu8ZYBVoEgdNvt5g9NdGK412OkSKt922dtYKjXasb5qf
	 A593+EjHNuPDYOpJa3ukBaU4Z++h3LpKNt60SapKW40dVOhz1RaKpLkPHOC/Sc4qSB
	 OVM6GLsXc/EvOsXqOJF8Zhc6/ooIzmWnt1NqVEy1XZxCGKicKIwyqcsd2UGkj9GGzo
	 ZXsjttF7EUphw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvmet: make 'tsas' attribute idempotent for RDMA
Date: Fri, 14 Jun 2024 12:44:45 +0200
Message-Id: <20240614104445.105041-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_034452_422464_18664B89 
X-CRM114-Status: GOOD (  11.16  )
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

The RDMA transport defines values for TSAS, but it cannot be changed.
To avoid errors during reconfiguration allow to write the current
value.

Fixes: 3f123494db72 ("nvmet: make TCP sectype settable via configfs")

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/configfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e60224356048..7dce276464a6 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -424,6 +424,17 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
 
+	if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA) {
+		for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_rdma); i++) {
+			u8 qptype;
+
+			if (sysfs_streq(page, nvmet_addr_tsas_rdma[i].name)) {
+				qptype = nvmet_addr_tsas_rdma[i].type;
+				if (qptype == port->disc_addr.tsas.rdma.qptype)
+					return count;
+			}
+		}
+	}
 	if (port->disc_addr.trtype != NVMF_TRTYPE_TCP)
 		return -EINVAL;
 
-- 
2.35.3


