Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790ADCDB465
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 13:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YJSffSoa0BaxBczKgkCrrJHxVgWn9WTUBOwBuAsh8EY=; b=0h25c45iRyMx9KyDTC4vND3D76
	RxLiJbcn6WPdj7kRASBeRHVX+12mM9a3KYjOvTGxnTcCt/Q4oKNTfWNrYSWNUiMNYJjK0YFEc/TXP
	myH2DaoQe0GwKD8HTY3wmM3EhvrmBlQL7hE3an5hVJ9BqD/Jb6CwEfRSBXZVNzWVmevG6rkVsJPHr
	4Jg0dHBucE7INjpgzT6mLeMwmEK6PfZ44nXCNAwtWYOdYb67OnTOFMNIgrNqxi2+GQXdrc8i/Wy/Z
	ALnzhKIiy8spI3A2AJ+KCDwjCzMQGFvEJqVnabGirQ3QlJWtbtgrFMzRkav8hlJHdKsfvHXUzPkJX
	XFosfaCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtTAQ-00HX71-2t;
	Thu, 19 Oct 2023 13:34:26 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtTAN-00HX6U-1q
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 13:34:24 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 7588C1F38C;
	Thu, 19 Oct 2023 13:34:21 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 385782C55D;
	Thu, 19 Oct 2023 13:34:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 5E97851EC0FF; Thu, 19 Oct 2023 15:34:21 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Yi Zhang <yi.zhang@redhat.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Maurizio Lombardi <mlombard@redhat.com>
Subject: [PATCHv2] nvmet-tcp: do not try to cancel uninitialized tls_handshake_tmo_work
Date: Thu, 19 Oct 2023 15:34:17 +0200
Message-Id: <20231019133417.23440-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [2.62 / 50.00];
	 ARC_NA(0.00)[];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.20)[suse.de];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(0.60)[~all:c];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-2.87)[99.45%]
X-Rspamd-Queue-Id: 7588C1F38C
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_063423_757267_1AC89079 
X-CRM114-Status: UNSURE (   8.45  )
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

The TLS handshake timeout workqueue is only initialized if TLS
is configured, so we shouldn't try to de-initialize it
unconditionally.

Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
Suggested-by: Maurizio Lombardi <mlombard@redhat.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4336fe048e43..e155bcaa42fa 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1587,7 +1587,9 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	mutex_unlock(&nvmet_tcp_queue_mutex);
 
 	nvmet_tcp_restore_socket_callbacks(queue);
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
 	cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
+#endif
 	cancel_work_sync(&queue->io_work);
 	/* stop accepting incoming data */
 	queue->rcv_state = NVMET_TCP_RECV_ERR;
-- 
2.35.3


