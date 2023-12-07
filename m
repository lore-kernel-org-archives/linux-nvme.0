Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4818C10F04
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 12:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hBvs7TZQ+nucLVLXIxUZxqkZhSIgkTWTSN7462TSV+g=; b=4lpXcpBAsvLhyIcBxeOqzdhvrn
	+Tto5WKy3cVAfwztrPdmTS2CUthEza+rQO6jswZ+eltOLaP4IQsIb6gs5KjXqcUVIyygSElZJ9Z5k
	R7bVxJLX5uJEYZ5oNq/44XSF+uXutDBgtPKl0yEU6tfMmw5ygGwReRE6k16UloO81hDeOAYIJs4Kz
	dkU8atus3fvHHekdyZ2yyEhVD2Kra+v7Q5zp5nLNCcN9PTkjwY7HQoP/J8cfPoBgmiyQSo8OfD+kV
	Skm3CnD2MRnYP4GMCrtXhSJRZ6VVczuE2JCQEs+ahMzdRxaYmRBGL7Rn5HlG9efG2d3UpkRaT4gxD
	FnIlzt6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBDcM-00Cnup-2O;
	Thu, 07 Dec 2023 12:36:38 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBDcH-00Cnri-1l
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 12:36:35 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45C3D1FB5B;
	Thu,  7 Dec 2023 12:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701952592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hBvs7TZQ+nucLVLXIxUZxqkZhSIgkTWTSN7462TSV+g=;
	b=ZeIt+FIYVMYMeo9YLHrBBg8tRzTNUSlIdantCyfK4oKtSlPBeDXiiJg+PcWaEMhxtElUgU
	wSGC9Iv1diomTgpfvqbhLb1ZtZN1hGsfPip3UrGyHVdmXTqDYXOtTYVarqAvaTP+0E0rPX
	DGysDIWIv2U7n2I73b9Q5XpxWQD+reU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701952592;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hBvs7TZQ+nucLVLXIxUZxqkZhSIgkTWTSN7462TSV+g=;
	b=aTbjMKu3D5F9l5snV5BTh+MbARCzE61MCHmi4JqZcndJDHOGPSbA+bJdBV+2rowcx1Swy5
	Ixj8mQCoufa9fdCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 33386139E3;
	Thu,  7 Dec 2023 12:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id XvwOC1C8cWUCAwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 07 Dec 2023 12:36:32 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 4/4] nvme: repack struct nvme_ns_head
Date: Thu,  7 Dec 2023 13:36:24 +0100
Message-ID: <20231207123624.29959-5-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207123624.29959-1-dwagner@suse.de>
References: <20231207123624.29959-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[12.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_043633_740979_53A03EB2 
X-CRM114-Status: GOOD (  10.58  )
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

ns_id, lba_shift and ms are always accessed for every read/write I/O in
nvme_setup_rw. By grouping these variables into one cacheline we can
safe some cycles.

4k sequential reads:

           baseline   patched
Bandwidth: 1620       1634
IOPs       66345579   66910939

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/nvme.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2b31641a97b9..4a4beaecc832 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -445,21 +445,21 @@ struct nvme_ns_head {
 	struct list_head	list;
 	struct srcu_struct      srcu;
 	struct nvme_subsystem	*subsys;
-	unsigned		ns_id;
 	struct nvme_ns_ids	ids;
 	struct list_head	entry;
 	struct kref		ref;
 	bool			shared;
 	int			instance;
 	struct nvme_effects_log *effects;
+	u64			nuse;
+	unsigned		ns_id;
 	int			lba_shift;
 	u16			ms;
 	u16			pi_size;
-	u16			sgs;
-	u32			sws;
-	u64			nuse;
 	u8			pi_type;
 	u8			guard_type;
+	u16			sgs;
+	u32			sws;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u64			zsze;
 #endif
-- 
2.43.0


