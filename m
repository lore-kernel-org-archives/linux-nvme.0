Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A086C10F04
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 08:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+emmShTJyvnUVTi/2ARu+Yu1a3i2XcRwX4j6orpqykM=; b=boXlZTtnogyfmZXPCNogTPH18v
	vvqFpb4lJgVkj3kcbOsbcd6WdbmIIFikgr0OIB5DidTKSuXcRRWVn4zHY5y1T6naYkRbaIb2Z+U8Z
	AR3iHAxfrrybnqc+nsoTXCzUBXdVFN/Vmcr/0QAQKyAi5R3VFFsjkRyC8NGSBax9pnDCrhYWp5Uom
	GNnuP68VSGWVUqa/I7EL0gerq5NcCIOhIcBFssA0j2+dexyLygtHvott4hxPqhFpXGUJq2P5T/XrC
	aK3Z7JusVzkQys/DhOTcO13vZQLSliDGV5D3CNkLPKLYej8UGNOtfNcinEyyp/9PMSI4cBmPL5KS1
	4Y8DwD1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAn1d-009MoA-1v;
	Wed, 06 Dec 2023 08:12:57 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAn1Z-009MlV-16
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 08:12:54 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A215A1FBF9;
	Wed,  6 Dec 2023 08:12:49 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E794133DD;
	Wed,  6 Dec 2023 08:12:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NcSnIQEtcGUTHgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 06 Dec 2023 08:12:49 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 1/4] nvme: lookup ctrl from request instead from namespace
Date: Wed,  6 Dec 2023 09:12:41 +0100
Message-ID: <20231206081244.32733-2-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206081244.32733-1-dwagner@suse.de>
References: <20231206081244.32733-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [11.73 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.94)[0.980];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Rspamd-Queue-Id: A215A1FBF9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_001253_546873_9D9FC010 
X-CRM114-Status: GOOD (  15.94  )
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

In preparation to use struct nvme_ns_head pointers instead of a struct
nvme_ns pointers, get the ctrl pointer from a request. The reason is
that there is no easy and fast way to lookup the ctrl from struct
nvme_ns_head.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d699f0c8b13e..900c045fcae0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -769,6 +769,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmnd)
 {
 	unsigned short segments = blk_rq_nr_discard_segments(req), n = 0;
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 	struct nvme_dsm_range *range;
 	struct bio *bio;
 
@@ -786,10 +787,10 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		 * discard page. If that's also busy, it's safe to return
 		 * busy, as we know we can make progress once that's freed.
 		 */
-		if (test_and_set_bit_lock(0, &ns->ctrl->discard_page_busy))
+		if (test_and_set_bit_lock(0, &ctrl->discard_page_busy))
 			return BLK_STS_RESOURCE;
 
-		range = page_address(ns->ctrl->discard_page);
+		range = page_address(ctrl->discard_page);
 	}
 
 	if (queue_max_discard_segments(req->q) == 1) {
@@ -815,8 +816,8 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	}
 
 	if (WARN_ON_ONCE(n != segments)) {
-		if (virt_to_page(range) == ns->ctrl->discard_page)
-			clear_bit_unlock(0, &ns->ctrl->discard_page_busy);
+		if (virt_to_page(range) == ctrl->discard_page)
+			clear_bit_unlock(0, &ctrl->discard_page_busy);
 		else
 			kfree(range);
 		return BLK_STS_IOERR;
@@ -861,9 +862,11 @@ static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
 static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd)
 {
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
+
 	memset(cmnd, 0, sizeof(*cmnd));
 
-	if (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
+	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
 		return nvme_setup_discard(ns, req, cmnd);
 
 	cmnd->write_zeroes.opcode = nvme_cmd_write_zeroes;
-- 
2.43.0


