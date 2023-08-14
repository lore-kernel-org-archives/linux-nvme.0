Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9A8C001B0
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 11:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gHLSrazHAERG/p1kG7eIVU0W7U8ljX+ejdLZ56VMxkQ=; b=tzdi+SNjPFrhCDBiQ86nLPa509
	juo01fBpIDz6YMjS4AoohDQXotqPl9Elmh4Eg1iNfnYGfoj39I0mjYpZ+enC1hObEftTLJv3l8ffv
	djX7zac4h0RFZ/HIw2zchGTdyOCD734wJtK7cqkO/7GFOmcCIKds84UKu1KNOYia0yyLhWbOv8+VF
	jU3tQpKZb0lLp/IMY0qq58bl+IxPNQkNEuenl1sEGTF8z/36bMd5OPl2PKEwSsl5TiwQPQTezqeG6
	bkdPIx4qO3Z0mzUeEbvZsINmD42HgW8i8sW9kF7R9pSxRgfvUvNkhyKMn5o/tSD1lZmIDleXChjTd
	9JqZA23g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVVcO-00Gv2u-07;
	Mon, 14 Aug 2023 11:20:16 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVVc8-00Gun7-2V
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 11:20:02 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 562381FD6C;
	Mon, 14 Aug 2023 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692011992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHLSrazHAERG/p1kG7eIVU0W7U8ljX+ejdLZ56VMxkQ=;
	b=AnBb7NXapDUlPCTgJvNA8KWsakKeJ3Pdi1ET1v01MZxPpr4G1MT7du6CFeyxUswgbKoxNN
	g9t6PccbEShOhf4gab1eeV1YLNkkmPgU0oebu0T4SzBDnfmdq1l363Ni4eyR8HUXJpWh75
	N8LXVgehL/F/ubmhPDE3M/PLNIeISj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692011992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHLSrazHAERG/p1kG7eIVU0W7U8ljX+ejdLZ56VMxkQ=;
	b=dbjVBoytG4GxENh0xxAmWyhAnhVqUwR8yIG1JEBIOStVrWbQuO7JnhqOLRLzm0culWKnhm
	CtPlbusudwdCqeBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 439422C166;
	Mon, 14 Aug 2023 11:19:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 3FE2F51CB0DB; Mon, 14 Aug 2023 13:19:52 +0200 (CEST)
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
Subject: [PATCH 14/17] nvmet: Set 'TREQ' to 'required' when TLS is enabled
Date: Mon, 14 Aug 2023 13:19:40 +0200
Message-Id: <20230814111943.68325-15-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230814111943.68325-1-hare@suse.de>
References: <20230814111943.68325-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_042000_964076_5517C8C1 
X-CRM114-Status: GOOD (  12.38  )
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
 drivers/nvme/target/configfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 53862f2c6cd1..efbfed310370 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -376,6 +376,7 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	u8 treq = nvmet_port_disc_addr_treq_mask(port);
 	u8 sectype;
 	int i;
 
@@ -397,6 +398,17 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 
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
 
-- 
2.35.3


