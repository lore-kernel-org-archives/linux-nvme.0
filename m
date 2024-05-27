Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725E9C25B7C
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 05:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ub2/rUBFSVFLzWHC7ZM2xsVnyhsU9LiXP8FsIw9Cg6A=; b=t9kAv+nzXMk0RqTtKMvKyfw3K9
	OH2R4NPrPPjTIq28xDT0rFevD1d2uvIwQTwGlxwChgrNZzWs03KBHGW39s6ISkrga59x9cExNed8S
	NfnNaVfuMJIY1o5EmCQ+4Lc0ruOy3+e0xHMHtOh8ZoCB6J8kNJbdRuP0/4ZXtY/YOj7flROd4UrXK
	j3vW80HObGJykDYLlKLjhuVf2J+z13I/Xht7NtNg29p9iw0XdhJH72V3ekbvwpycKkwkitJJkmVny
	OH7nkjjMXW+kREXTimIf2G6XmGcgbzZX9kdXXS96UVLrctIVr7MSIMzFezeXqyV3liV6jZT50ZTaJ
	FH875LdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSiM-0000000DocA-3WLq;
	Mon, 27 May 2024 05:16:06 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSi8-0000000DoUv-2wEW
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 05:16:01 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E4CE1F8D7;
	Mon, 27 May 2024 05:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716786943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ub2/rUBFSVFLzWHC7ZM2xsVnyhsU9LiXP8FsIw9Cg6A=;
	b=uvZ2xXXg0NFzP0yonO+Y3Z7cptDijbikyk/pTgDw9aZS5UMQNg/i4/duMAM1YptWx2zkM7
	zEcYpEG9AVAorTk3a7YKWy+/31M/pqH7Up++g5O9cXx93dgAQA0U6XIrBgUeZg4kOBpnAK
	OgwGEFkrNOElwsWCE3Tgy6g3VGIl6fA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716786943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ub2/rUBFSVFLzWHC7ZM2xsVnyhsU9LiXP8FsIw9Cg6A=;
	b=oYGuKcwLcQg89emuU4pOvz2GyAtFoSmStmcdAaqptpjv0CjBJcnHZ0dx2DaGaKzPtI48yn
	wMQ8X5Ji3/Q6xXAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716786943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ub2/rUBFSVFLzWHC7ZM2xsVnyhsU9LiXP8FsIw9Cg6A=;
	b=uvZ2xXXg0NFzP0yonO+Y3Z7cptDijbikyk/pTgDw9aZS5UMQNg/i4/duMAM1YptWx2zkM7
	zEcYpEG9AVAorTk3a7YKWy+/31M/pqH7Up++g5O9cXx93dgAQA0U6XIrBgUeZg4kOBpnAK
	OgwGEFkrNOElwsWCE3Tgy6g3VGIl6fA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716786943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ub2/rUBFSVFLzWHC7ZM2xsVnyhsU9LiXP8FsIw9Cg6A=;
	b=oYGuKcwLcQg89emuU4pOvz2GyAtFoSmStmcdAaqptpjv0CjBJcnHZ0dx2DaGaKzPtI48yn
	wMQ8X5Ji3/Q6xXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C4F213A6B;
	Mon, 27 May 2024 05:15:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pQZoBf8WVGYTYgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 May 2024 05:15:43 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 3/7] nvmet-tcp: implement host_traddr()
Date: Mon, 27 May 2024 07:15:21 +0200
Message-ID: <20240527051525.762-4-dwagner@suse.de>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527051525.762-1-dwagner@suse.de>
References: <20240527051525.762-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_221552_923126_36FF36AC 
X-CRM114-Status: GOOD (  12.01  )
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

From: Hannes Reinecke <hare@kernel.org>

Implement callback to display the host transport address.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/tcp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a5422e2c979a..9c3c1456af52 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2170,6 +2170,19 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_req *req,
 	}
 }
 
+static ssize_t nvmet_tcp_host_port_addr(struct nvmet_ctrl *ctrl,
+			char *traddr, size_t traddr_len)
+{
+	struct nvmet_sq *sq = ctrl->sqs[0];
+	struct nvmet_tcp_queue *queue =
+		container_of(sq, struct nvmet_tcp_queue, nvme_sq);
+
+	if (queue->sockaddr_peer.ss_family == AF_UNSPEC)
+		return -EINVAL;
+	return snprintf(traddr, traddr_len, "%pISc",
+			(struct sockaddr *)&queue->sockaddr_peer);
+}
+
 static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_TCP,
@@ -2180,6 +2193,7 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.delete_ctrl		= nvmet_tcp_delete_ctrl,
 	.install_queue		= nvmet_tcp_install_queue,
 	.disc_traddr		= nvmet_tcp_disc_port_addr,
+	.host_traddr		= nvmet_tcp_host_port_addr,
 };
 
 static int __init nvmet_tcp_init(void)
-- 
2.45.1


