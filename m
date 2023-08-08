Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043D8C04E69
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 16:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nOnzToVqyI+CYXuonqW/t1OzFe5ttnGt/9dF356QipI=; b=s+zW2Mxke9+sLCbLBNhQ+IuoXz
	yFffHK5O3zh9diVR0vohE3Dzzl+trkMh+QzLh+fWZJgcNIv1/zLU1RTm4b7JsqZ1iVAx8VqQ9OUsJ
	f7P6STf+yx3F2wIwTGDeanVdkVxmAHK/JIQXN/N0aBo5QkO9+pivd2aMisrJgIVefEoX0jxr4F75/
	OldPcDgFPtSNS39k9IQ++mS7DoPWTNaQ8kpJpJaO8G5csDl03bG/kvAS77eK2NnBFmUkuXJskdk0Z
	G9uAvwzLCW0yOlVvhU9d/44HIzbOC3m9zOu89x8E8TsYS0UPUE3vfzi/F5ulAbD2xlLFNijjbfBXQ
	gSTiUoLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTPya-0032D5-03;
	Tue, 08 Aug 2023 16:54:32 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTPyM-00320J-2u
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 16:54:21 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 6AF6520311;
	Tue,  8 Aug 2023 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691513648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nOnzToVqyI+CYXuonqW/t1OzFe5ttnGt/9dF356QipI=;
	b=vPdl7v9MyljoNQvu1ay/rkIFhisXamv27gip5xZ+7Yi8eWo5WgOtY/3mkPzQtUiB38ElvH
	qrvfeReR1mdh4+4ntcQmNAk3HfOgj0uhmq4R4OPrNhmIL6MU1+8VqJ0iCwv2Dh9tkavugz
	25JDXpOXHcreP+klHzLckraCmwchdoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691513648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nOnzToVqyI+CYXuonqW/t1OzFe5ttnGt/9dF356QipI=;
	b=o8pl5yb1+urlb5v7QhBkLsYikhJshIuJLdv8IPl3kqvaXl4naXrLjtvCM3QuszcKlwl7WT
	4emxDyh2rbC5dvAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 5ED522C15F;
	Tue,  8 Aug 2023 16:54:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 5B10551CAD01; Tue,  8 Aug 2023 18:54:08 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 14/16] nvmet: Allow to change 'TSAS' and 'TREQ'
Date: Tue,  8 Aug 2023 18:53:52 +0200
Message-Id: <20230808165354.123499-15-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230808165354.123499-1-hare@suse.de>
References: <20230808165354.123499-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_095419_107710_0EBDC604 
X-CRM114-Status: GOOD (  15.38  )
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

Allow to change 'TSAS' and 'TREQ' to values specified in the spec.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c | 36 +++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 7f826ac8b75c..3c2aeb763e22 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -159,10 +159,15 @@ static const struct nvmet_type_name_map nvmet_addr_treq[] = {
 	{ NVMF_TREQ_NOT_REQUIRED,	"not required" },
 };
 
+static inline u8 nvmet_port_treq(struct nvmet_port *port)
+{
+	return (port->disc_addr.treq & NVME_TREQ_SECURE_CHANNEL_MASK);
+}
+
 static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
 {
-	u8 treq = to_nvmet_port(item)->disc_addr.treq &
-		NVME_TREQ_SECURE_CHANNEL_MASK;
+	struct nvmet_port *port = to_nvmet_port(item);
+	u8 treq = nvmet_port_treq(port);
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
@@ -174,11 +179,16 @@ static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
 	return snprintf(page, PAGE_SIZE, "\n");
 }
 
+static inline u8 nvmet_port_treq_mask(struct nvmet_port *port)
+{
+	return (port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK);
+}
+
 static ssize_t nvmet_addr_treq_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
-	u8 treq = port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK;
+	u8 treq = nvmet_port_treq_mask(port);
 	int i;
 
 	if (nvmet_is_port_enabled(port, __func__))
@@ -193,6 +203,15 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 	return -EINVAL;
 
 found:
+	if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
+		if (port->disc_addr.tsas.tcp.sectype != NVMF_TCP_SECTYPE_TLS13) {
+			pr_warn("cannot change TREQ when TLS is not enabled\n");
+			return -EINVAL;
+		} else if (nvmet_addr_treq[i].type == NVMF_TREQ_NOT_SPECIFIED) {
+			pr_warn("cannot set TREQ to 'not specified' when TLS is enabled\n");
+			return -EINVAL;
+		}
+	}
 	treq |= nvmet_addr_treq[i].type;
 	port->disc_addr.treq = treq;
 	return count;
@@ -371,6 +390,7 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	u8 treq = nvmet_port_treq_mask(port);
 	int i;
 
 	if (nvmet_is_port_enabled(port, __func__))
@@ -389,6 +409,16 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 
 found:
 	nvmet_port_init_tsas_tcp(port, nvmet_addr_tsas_tcp[i].type);
+	if (nvmet_addr_tsas_tcp[i].type == NVMF_TCP_SECTYPE_TLS13) {
+		if (nvmet_port_treq(port) == NVMF_TREQ_NOT_SPECIFIED)
+			treq |= NVMF_TREQ_REQUIRED;
+		else
+			treq |= nvmet_port_treq(port);
+	} else {
+		/* Set to 'not specified' if TLS is not enabled */
+		treq |= NVMF_TREQ_NOT_SPECIFIED;
+	}
+	port->disc_addr.treq = treq;
 	return count;
 }
 
-- 
2.35.3


