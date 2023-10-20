Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B83CDB47E
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 05:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/BEfIeijtQZBBHRtvR4VD2ZzM1g4Qoa4JhwGiyQqK4M=; b=mXWPAZ4bM9+T2K4we3k8L04mmO
	2HHNyzH8dXnR3pMOMg5TPuKd+juUvurdqVDw7XmHrjCKyw8rUBMNek5GaD/G38TCp+36uZ5+ch838
	FnvIK520hgpMuCZmekvDgC720eVf5W+ut3J7a1J/xXVvUQJHr8aAfWCx9/b61SG2he4FfgP95rpJh
	k6kVTomNcReowzDCuzU1MpfnQg12y+TNPT5SUQqh9HxYqnNPKMCoy/T0L5Tgks07M+IE7DmMMjhj8
	kX+Gcc5F+KMevgpEyamq61UCSpuyZuXvdgIcZ5kZUEGjulromcFMHdSQSOp0Hb3GtHTm3vFQgpT4l
	gW4+xmdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qthi9-001EHE-1n;
	Fri, 20 Oct 2023 05:06:13 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qthi7-001EGq-20
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 05:06:12 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 57E2E1F38C;
	Fri, 20 Oct 2023 05:06:08 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 1C7C42C754;
	Fri, 20 Oct 2023 05:06:07 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 7039C51EC15C; Fri, 20 Oct 2023 07:06:07 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Maurizio Lombardi <mlombard@redhat.com>
Subject: [PATCHv3] nvmet-tcp: always initialize tls_handshake_tmo_work
Date: Fri, 20 Oct 2023 07:06:06 +0200
Message-Id: <20231020050606.9464-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [2.61 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.20)[suse.de];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(0.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[6];
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
	 BAYES_HAM(-2.88)[99.47%]
X-Rspamd-Queue-Id: 57E2E1F38C
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_220611_829575_D30BDB35 
X-CRM114-Status: UNSURE (   9.76  )
X-CRM114-Notice: Please train this message.
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

The TLS handshake timeout work item should always be
initialized to avoid a crash when cancelling the workqueue.

Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
Suggested-by: Maurizio Lombardi <mlombard@redhat.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4336fe048e43..b3c1cc6690f6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1856,6 +1856,8 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 	}
 	return ret;
 }
+#else
+static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w) {}
 #endif
 
 static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
@@ -1913,9 +1915,9 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	list_add_tail(&queue->queue_list, &nvmet_tcp_queue_list);
 	mutex_unlock(&nvmet_tcp_queue_mutex);
 
-#ifdef CONFIG_NVME_TARGET_TCP_TLS
 	INIT_DELAYED_WORK(&queue->tls_handshake_tmo_work,
 			  nvmet_tcp_tls_handshake_timeout);
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
 	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
 		struct sock *sk = queue->sock->sk;
 
-- 
2.35.3


