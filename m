Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EECC83003
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Aug 2023 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CUNSXIhjiSKp2ogissRH1lWVegNQ9weINYXrmPdcKjc=; b=Or9yYA8UodgHQDN3uBafedV/BA
	x/NTcliT1uiTtiRCRWuVPI/KNwwkfASxxwhnFuaBg1tCMta6ZwQ3pROclwe40i4ficzxt+Hu0sI1y
	iCu/DAeyChrQwEoTmXfLFoEA5UiVux04mJTAbZsP3NPcZkajBdTp3g3OarWCMaKZO9Y8CH/5oabvz
	WYY3Zo1ArMwSuZrjvEzo3k34we+y9fer5yuMw7wV3kTcznQiqJv/ERgzM/c9MmWXkhtx1eEQf3rHS
	yLEUhpjIoTIXsZnxWJ/t8pBzkkZCkJ22KKAJl3agBexP9FfBnm5M0gfBV7k0heNeA3W/CL4TotQG0
	/RjgWvJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZBV1-003FW4-36;
	Thu, 24 Aug 2023 14:39:51 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZBUl-003FGX-1q
	for linux-nvme@lists.infradead.org;
	Thu, 24 Aug 2023 14:39:38 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id F2CCB20A86;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692887966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUNSXIhjiSKp2ogissRH1lWVegNQ9weINYXrmPdcKjc=;
	b=jfBbYKGFcvY0pHUBqIpRkVRKkGZrhlfadnrpFdN5X0wLQm/Gqo0gMRMkbuXLSrmr7Rt3YL
	rE9kcSegQyccvUlradWaqoATmtaWxfAkFtA9396/fk4o6YW8frYEyMHP6KMAgKJh1md69j
	DdW2NPdsnra12xgL8atvyjXQjBkn0cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692887966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUNSXIhjiSKp2ogissRH1lWVegNQ9weINYXrmPdcKjc=;
	b=F0CSkwbMOHLSWiCM0XQtR7wRxv5CfbLocnfNuVdE7FydWov7vQFtBvV5Dbyo4NSqizURj1
	+RJ3La0QVv1MBIAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id EC36C2C162;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id EA10C51CB8D5; Thu, 24 Aug 2023 16:39:26 +0200 (CEST)
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
Subject: [PATCH 15/18] nvmet: Set 'TREQ' to 'required' when TLS is enabled
Date: Thu, 24 Aug 2023 16:39:22 +0200
Message-Id: <20230824143925.9098-16-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230824143925.9098-1-hare@suse.de>
References: <20230824143925.9098-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_073935_777606_8E05B110 
X-CRM114-Status: GOOD (  15.49  )
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

The current implementation does not support secure concatenation,
so 'TREQ' is always set to 'required' when TLS is enabled.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/configfs.c | 15 +++++++++++++--
 drivers/nvme/target/nvmet.h    |  5 +++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 27a0f9c768e8..483569c3f622 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -166,8 +166,7 @@ static inline u8 nvmet_port_disc_addr_treq_mask(struct nvmet_port *port)
 
 static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
 {
-	u8 treq = to_nvmet_port(item)->disc_addr.treq &
-		NVME_TREQ_SECURE_CHANNEL_MASK;
+	u8 treq = nvmet_port_disc_addr_treq_secure_channel(to_nvmet_port(item));
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
@@ -376,6 +375,7 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	u8 treq = nvmet_port_disc_addr_treq_mask(port);
 	u8 sectype;
 	int i;
 
@@ -397,6 +397,17 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 
 found:
 	nvmet_port_init_tsas_tcp(port, sectype);
+	/*
+	 * The TLS implementation currently does not support
+	 * secure concatenation, so TREQ is always set to 'required'
+	 * if TLS is enabled.
+	 */
+	if (sectype == NVMF_TCP_SECTYPE_TLS13) {
+		treq |= NVMF_TREQ_REQUIRED;
+	} else {
+		treq |= NVMF_TREQ_NOT_SPECIFIED;
+	}
+	port->disc_addr.treq = treq;
 	return count;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8cfd60f3b564..87da62e4b743 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -178,6 +178,11 @@ static inline struct nvmet_port *ana_groups_to_port(
 			ana_groups_group);
 }
 
+static inline u8 nvmet_port_disc_addr_treq_secure_channel(struct nvmet_port *port)
+{
+	return (port->disc_addr.treq & NVME_TREQ_SECURE_CHANNEL_MASK);
+}
+
 struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
 	struct nvmet_sq		**sqs;
-- 
2.35.3


