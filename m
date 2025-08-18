Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF592CA0ED1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pNBhdHkmqnaPWSw6bbB2soZ3Muo3TU+Dfya+FTLGI3g=; b=WvnshhJXSzpuscCBokJLUtF7HR
	tVdQmIUuC3XOxfFRN31MN2TpKksVI75QZLWEw/lEskd1XR4l6DxADX0yYRNKdOAXCPnivut6MWxrc
	MazvJX0iAPFixKjYT5HoneAl+WFJcFFsbZbuXPKnyNOi702a1Ec9Rt+JyN+eBOnlzcn8uiCK3si+v
	bE/8iE/A/A2SDda/aStNZA6aebN0E2HUwjcq4TsuWeRutGW1EJcMx/1EUdvQ3IXTJbArtP+Nq6eoc
	YUJu9Y9nVKGRcAgLdlUJx58pcCxDhs6cYpfks/Wd/L9V/HBhJwYVyOzlnl+Low7L41sDAq4kWanKU
	lo7tRIpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo06f-00000007ZYS-2MhY;
	Mon, 18 Aug 2025 13:41:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unwEW-000000074EP-1EbE
	for linux-nvme@lists.infradead.org;
	Mon, 18 Aug 2025 09:32:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 51EBD5C4832;
	Mon, 18 Aug 2025 09:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB009C4CEEB;
	Mon, 18 Aug 2025 09:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755509571;
	bh=q8Gq6LxT2N+gbWasAF5PGUeWXWlp4ymoMIZRv2DViHU=;
	h=From:To:Cc:Subject:Date:From;
	b=h0iVn88El87nIYxOq/sKF7LAZlc6GD0F6Ft7tGon0n9L1ctrXAHyRDUvRmd4Min0R
	 ldy6X8ebqUIvwN2k4Jp6TBnwK9aNSER+AmufbXAVDr8hBuZaXezimKIJphoqipgmld
	 YpLHWtfccaft1oaNHlqjxkdvj03NUFVqjkoVFcv/pHCV4hOrfxL2Lsk37/f3GQw8M0
	 Amd1WYvVfNttUOdS37nbMWSnM4ySWUV1eubzDWI+QP44wCv1DkauGdJ3RHIuC5ITDh
	 zVEYbxEnxlQIdCp7usqmhMpp0nvn4a+MtUXZg9UbMxifoBLSwoDMMqJM+xcceTOYws
	 ZPhOj/NRSlqLA==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()
Date: Mon, 18 Aug 2025 11:32:45 +0200
Message-ID: <20250818093245.41641-1-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_023252_372989_DBBFDBFA 
X-CRM114-Status: GOOD (  10.36  )
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

When the socket is closed while in TCP_LISTEN a callback is run to
flush all outstanding packets, which in turns calls
nvmet_tcp_listen_data_ready() with the sk_callback_lock held.
So we need to check if we are in TCP_LISTEN before attempting
to get the sk_callback_lock() to avoid a deadlock.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Tested-by:  Yi Zhang <yi.zhang@redhat.com>
---
 drivers/nvme/target/tcp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 470bf37e5a63..2e9a3e698b70 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1992,14 +1992,13 @@ static void nvmet_tcp_listen_data_ready(struct sock *sk)
 
 	trace_sk_data_ready(sk);
 
+	if (sk->sk_state != TCP_LISTEN)
+		return;
+
 	read_lock_bh(&sk->sk_callback_lock);
 	port = sk->sk_user_data;
-	if (!port)
-		goto out;
-
-	if (sk->sk_state == TCP_LISTEN)
+	if (port)
 		queue_work(nvmet_wq, &port->accept_work);
-out:
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
-- 
2.43.0


