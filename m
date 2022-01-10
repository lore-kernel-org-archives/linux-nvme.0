Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7458C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jan 2022 14:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KGMeDXEtPdbSYXair6U41YpFOsB9MZBLlLOv7IyZi+8=; b=b6iwbNIDFDuzgzPogvGsSz5aCj
	ieCXVDK7zKdW9mBi6rJckWfsS5cgJdjoLh9KU/UN0unCIrYuznsqtpTXSUZBSq9jGXfxgz0/hCDfe
	dvZQoczWHKbvkgX/t5BAMooUTg1HPhyojlR+f3fUbMBFxqwnCgwKp1SAYMiUK2Se2ZPJQL+i6ZWNy
	nmjuuizX7jYUcGvhQzxJf9yiuAAdgawFftSDkKo/tZ4mizfJ+vw/Jyjf3DszTp/rzYOQB342h2oIX
	ZnyHWn8my9nfZP1KTaiidV8sJ6oq8XHZvOS2Ko7CCz1tTL7GRrGU/PB+6uE7hb8E//8gMy3Uf7+Gd
	FmwJnFow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n6vJ2-00BkBs-8g; Mon, 10 Jan 2022 14:05:52 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n6vIu-00BkAh-Qg
 for linux-nvme@lists.infradead.org; Mon, 10 Jan 2022 14:05:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8E51E21135;
 Mon, 10 Jan 2022 14:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1641823541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KGMeDXEtPdbSYXair6U41YpFOsB9MZBLlLOv7IyZi+8=;
 b=YzkSjMHmfB2HockMCQlSOaH4kCpFEZsMWI1NbbjXzjXLpy9BnIg5DcSeP5ezvRqCtHpeOs
 bvEJ2G2KyOlfgE6hoOfztM0Vesj1NpRwwnCmbggrfBtS0sNr+eIzlZxrsJImiFG0UnNWBk
 6hOin6AP5K1naFRuQIws12bnQqxqh+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1641823541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KGMeDXEtPdbSYXair6U41YpFOsB9MZBLlLOv7IyZi+8=;
 b=srpUM61Qqcjzrgw+ecdvG33uXYAEOoTHaT3LijssQXq3cxVGAWgV8kjLAfTBSRLH/pxCbj
 Su3g10bVEtMN15BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81A5813D88;
 Mon, 10 Jan 2022 14:05:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xpSbHzU93GFqTQAAMHmgww
 (envelope-from <dwagner@suse.de>); Mon, 10 Jan 2022 14:05:41 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2] nvmet: add support reading with offset from ANA log
Date: Mon, 10 Jan 2022 15:05:39 +0100
Message-Id: <20220110140539.25521-1-dwagner@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220110_060545_081652_BCC445F2 
X-CRM114-Status: GOOD (  16.12  )
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

Add support to read with offsets from ANA log buffer.

The controller claims to support extended data for the Get Log Page
command (including extended Number of Dwords and Log Page Offset 2
fields):

lpa     : 0x7
  [2:2] : 0x1   Extended data for Get Log Page Supported
  [1:1] : 0x1   Command Effects Log Page Supported
  [0:0] : 0x1   SMART/Health Log Page per NS Supported

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
v2:
 - fixed lenght calculation and limit response lenght
 - some more testing with KASAN enabled
v1:
 - https://lore.kernel.org/linux-nvme/20211229155302.16789-1-dwagner@suse.de/

 drivers/nvme/target/admin-cmd.c | 41 +++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6fb24746de06..c4f1bbb9fb8a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -263,35 +263,42 @@ static u32 nvmet_format_ana_group(struct nvmet_req *req, u32 grpid,
 	desc->nnsids = cpu_to_le32(count);
 	desc->chgcnt = cpu_to_le64(nvmet_ana_chgcnt);
 	desc->state = req->port->ana_state[grpid];
-	memset(desc->rsvd17, 0, sizeof(desc->rsvd17));
 	return struct_size(desc, nsids, count);
 }
 
 static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 {
-	struct nvme_ana_rsp_hdr hdr = { 0, };
+	struct nvme_ana_rsp_hdr *hdr;
 	struct nvme_ana_group_desc *desc;
-	size_t offset = sizeof(struct nvme_ana_rsp_hdr); /* start beyond hdr */
-	size_t len;
+	u64 offset = nvmet_get_log_page_offset(req->cmd);
+	u32 len;
+	void *buffer;
 	u32 grpid;
 	u16 ngrps = 0;
 	u16 status;
 
+	if (offset & 0x3) {
+		req->error_loc =
+			offsetof(struct nvme_get_log_page_command, lpo);
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto out;
+	}
+
 	status = NVME_SC_INTERNAL;
-	desc = kmalloc(struct_size(desc, nsids, NVMET_MAX_NAMESPACES),
-		       GFP_KERNEL);
-	if (!desc)
+	len = sizeof(*hdr) + struct_size(desc, nsids, NVMET_MAX_NAMESPACES);
+	buffer = kzalloc(len, GFP_KERNEL);
+	if (!buffer)
 		goto out;
 
+	len = sizeof(*hdr);
+	hdr = buffer;
+	desc = buffer + sizeof(*hdr);
+
 	down_read(&nvmet_ana_sem);
 	for (grpid = 1; grpid <= NVMET_MAX_ANAGRPS; grpid++) {
 		if (!nvmet_ana_group_enabled[grpid])
 			continue;
-		len = nvmet_format_ana_group(req, grpid, desc);
-		status = nvmet_copy_to_sgl(req, offset, desc, len);
-		if (status)
-			break;
-		offset += len;
+		len += nvmet_format_ana_group(req, grpid, desc);
 		ngrps++;
 	}
 	for ( ; grpid <= NVMET_MAX_ANAGRPS; grpid++) {
@@ -299,15 +306,15 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 			ngrps++;
 	}
 
-	hdr.chgcnt = cpu_to_le64(nvmet_ana_chgcnt);
-	hdr.ngrps = cpu_to_le16(ngrps);
+	hdr->chgcnt = cpu_to_le64(nvmet_ana_chgcnt);
+	hdr->ngrps = cpu_to_le16(ngrps);
 	nvmet_clear_aen_bit(req, NVME_AEN_BIT_ANA_CHANGE);
 	up_read(&nvmet_ana_sem);
 
-	kfree(desc);
+	status = nvmet_copy_to_sgl(req, 0, buffer + offset,
+				   min(len, nvmet_get_log_page_len(req->cmd)));
 
-	/* copy the header last once we know the number of groups */
-	status = nvmet_copy_to_sgl(req, 0, &hdr, sizeof(hdr));
+	kfree(buffer);
 out:
 	nvmet_req_complete(req, status);
 }
-- 
2.34.1


