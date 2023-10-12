Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E702CDB46E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Oct 2023 13:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nCM1Y/G5QaikqXNaMngwoHTMtNqzbERXrfllyOF3v2s=; b=ffopwzqLqzNbpfoBo9sNhdRm6+
	IHsbitr4R9/1D1x4THB0veEyEeRBA6+Z7EqxISihGwsprwDanzb9ptqO8y6Al/Ig7fl331njZAa+h
	7KsWOjUpM1LE6sY96ZEXKJmUg+mSf+yUAkYdLR/WQMRS4g/hT3+m8hp32/d3tQmpXjGtrDEh7+3fx
	jRVSNRqU6h6ZKx/ca0jOqaca3L44qG/NOOyi7ir8UNQ9d8ByccrNha3kgAZ+4TvVZFgc6Ib+AYNwv
	j0RhWciJ5IwhYS2tDft8bk5JWilBDW8d1VXMu13ZjMK9JXsitYpBhIy0fwz70I6J8WXVlrfW2nHFa
	VPlGFRUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqvIH-0011cl-1G;
	Thu, 12 Oct 2023 13:00:01 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqvIF-0011cD-0o
	for linux-nvme@lists.infradead.org;
	Thu, 12 Oct 2023 13:00:00 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 2D50A1F898;
	Thu, 12 Oct 2023 12:59:57 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id ED8672C9B2;
	Thu, 12 Oct 2023 12:59:56 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 4753451EBBBB; Thu, 12 Oct 2023 14:59:56 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvmet-tcp: use 'spin_lock_bh' for state_lock()
Date: Thu, 12 Oct 2023 14:59:54 +0200
Message-Id: <20231012125954.58709-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [3.04 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.20)[suse.de];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(0.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[5];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-2.45)[97.48%]
X-Rspamd-Queue-Id: 2D50A1F898
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_055959_451873_29DB1B73 
X-CRM114-Status: GOOD (  10.35  )
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

nvmet_tcp_schedule_release_queue() is called from socket state
change callbacks, which may be called from an softirq context.
So use 'spin_lock_bh' to avoid a spin lock warning.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 493645096eca..cd5ef64f1bc9 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1379,7 +1379,7 @@ static void nvmet_tcp_release_queue(struct kref *kref)
 
 static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
 {
-	spin_lock(&queue->state_lock);
+	spin_lock_bh(&queue->state_lock);
 	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
 		/* Socket closed during handshake */
 		tls_handshake_cancel(queue->sock->sk);
@@ -1388,7 +1388,7 @@ static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
 		queue->state = NVMET_TCP_Q_DISCONNECTING;
 		kref_put(&queue->kref, nvmet_tcp_release_queue);
 	}
-	spin_unlock(&queue->state_lock);
+	spin_unlock_bh(&queue->state_lock);
 }
 
 static inline void nvmet_tcp_arm_queue_deadline(struct nvmet_tcp_queue *queue)
-- 
2.35.3


