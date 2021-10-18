Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3604C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 15:22:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACE060EE2
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 15:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AACE060EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9DvjJh4e2era+bUXhWcTmxkHr6bI6kPrxsSQNNyB82E=; b=uBXhlEqYqTLNe2awe0YreHXBfl
	of7AiH+DpCg6qyh6iFvnoZFG3n2UbmbAyp/91Pfy6AA5vbIyrV/JGSp0BxGBv0WFgzq6eS61rD0cY
	ItfFWkNHtYQ8KvYGjBK/VjCWec0x48lBo9ufxNEyKFF9/t9sXAAaxINb4p6gIjQJGAEikxYEgTjSk
	661UPidRwMr6H1qzmWgHTFHRuIE1/1VOAMbJ85YNoLaX7DWs0TOcPpUpm9OzhMn2a1RDL9rCm1QMM
	L4DK20oXkKipLoKtHI8C806tUhOS2kwgNjW5qS33kvUCv1oBPmfhHKlqy9CmnzXJFsS8x1WYQq7UQ
	EYioyOyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcUSZ-00GHii-Qm; Mon, 18 Oct 2021 15:21:55 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcUSM-00GHeX-Hg
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 15:21:44 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6B28921966;
 Mon, 18 Oct 2021 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634570499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9DvjJh4e2era+bUXhWcTmxkHr6bI6kPrxsSQNNyB82E=;
 b=WxOaWLvh2FZm+FKqPHZedSiV8fuLXcmSK87UNpE7ep7FeCiwaQtw7zK+jIQdpmIMm2b7Ee
 IVg5ElzY6aoX3HOMIf+S8KZQCZfSh/GM89bgw4vlTD12HLMY9OfwXrhpRO3tla4cx281It
 h8de4P5kUmVGaJLqMGc4xS3QWbAeMiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634570499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9DvjJh4e2era+bUXhWcTmxkHr6bI6kPrxsSQNNyB82E=;
 b=jrbQe1eM/3xN+9k+h/nYmZCpelOcQcKfxCUaY9d+fhxLYndMjeByHf9x3Ra8cR38ZAF19T
 n5swhXrf0eg/FKDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 40B25A3B93;
 Mon, 18 Oct 2021 15:21:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 253D2518FBC1; Mon, 18 Oct 2021 17:21:39 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] nvme: add new discovery log page entry definitions
Date: Mon, 18 Oct 2021 17:21:37 +0200
Message-Id: <20211018152138.2128-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211018152138.2128-1-hare@suse.de>
References: <20211018152138.2128-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_082142_784974_9DF4E195 
X-CRM114-Status: GOOD (  11.54  )
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

TP8014 adds a new SUBTYPE value and a new field EFLAGS for the
discovery log page entry.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/nvme.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 357482dedb59..4bd1c30715f9 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -27,8 +27,9 @@
 #define NVME_NSID_ALL		0xffffffff
 
 enum nvme_subsys_type {
-	NVME_NQN_DISC	= 1,		/* Discovery type target subsystem */
+	NVME_NQN_DISC	= 1,		/* Referral to another discovery type target subsystem */
 	NVME_NQN_NVME	= 2,		/* NVME type target subsystem */
+	NVME_NQN_CURR	= 3,		/* Current discovery type target subsystem */
 };
 
 enum nvme_ctrl_type {
@@ -1312,6 +1313,12 @@ struct nvmf_common_command {
 
 #define MAX_DISC_LOGS	255
 
+/* Discovery log page entry flags (EFLAGS): */
+enum {
+	NVME_DISC_EFLAGS_EPCSD		= (1 << 1),
+	NVME_DISC_EFLAGS_DUPRETINFO	= (1 << 0),
+};
+
 /* Discovery log page entry */
 struct nvmf_disc_rsp_page_entry {
 	__u8		trtype;
@@ -1321,7 +1328,8 @@ struct nvmf_disc_rsp_page_entry {
 	__le16		portid;
 	__le16		cntlid;
 	__le16		asqsz;
-	__u8		resv8[22];
+	__le16		eflags;
+	__u8		resv10[20];
 	char		trsvcid[NVMF_TRSVCID_SIZE];
 	__u8		resv64[192];
 	char		subnqn[NVMF_NQN_FIELD_LEN];
-- 
2.29.2


