Return-Path: <SRS0=9hiF=NZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C41C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Sep 2021 12:18:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDFA3610FD
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Sep 2021 12:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EDFA3610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=neY9+/HFCEkuclEcSzN5GFghuplH85hWdJAuJpgzjLU=; b=JHUlxz8z59LiQE
	IYouTta3wFwYqTFt+qi/m6TTOdtWzPu+Z99sC7f8ONyoMDTRBvvJ3JUhh/OFcPdUqp0ia9aV8WurA
	dvavS/xqPGUg45AOWSJBEAvNUUoWYPVv7gWRv0bKflViEkKhX9a3sRn/+4sS883stB+UBxw/dbDlz
	7KvqXgNR2WSHPncYxhsmUEjhXKLQYvX/has0cbi7xfAiwODhgIJotSCZ+xQ4Hzv+TvxhH7PfpSEc9
	qH0yTs9sZp08UgUQtxdMRHgcb8HZHBfXPDNP9nkepzY4CVk7c5YGA7VV9iWdaTXnfPqD7SkBjCN3A
	9SVw3E/6JjecaD/Ajuvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mM891-00BswX-M3; Fri, 03 Sep 2021 12:18:07 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mM88w-00Bsvc-Q3
 for linux-nvme@lists.infradead.org; Fri, 03 Sep 2021 12:18:04 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 88E6F203B7;
 Fri,  3 Sep 2021 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630671479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/XvyiQWkqGmCCmHBNihZZxMuMR1mKh/8eRaYXMw6HHg=;
 b=1hll4FFBlSWbgMAcIA1+QOVtnIhERwPUObk4cNNsjV6V3jW3abm7yKfzIRylr0iDStAcrX
 aRdyoGEgvll/J2/fQxN7vG4upM0ENINXZgGg5jU6BqP5IZ4bL7j6H+0X6Pbq8cpM38Ridk
 a2EsiNEH3VYZajeWi6YXN8y4SF9Nq8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630671479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/XvyiQWkqGmCCmHBNihZZxMuMR1mKh/8eRaYXMw6HHg=;
 b=Qxr6DfJnRJBPvmYpR3oLROZ/vmaFbfn6R/I6xHJlA2/Yx6hZf5yvuq++BQu9d2OcuQ9YOo
 7mergQcDzMLu4PBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 83567A3B97;
 Fri,  3 Sep 2021 12:17:59 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 79124518DFA9; Fri,  3 Sep 2021 14:17:59 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC v1] nvme-tcp: enable linger socket option on shutdown
Date: Fri,  3 Sep 2021 14:17:57 +0200
Message-Id: <20210903121757.140357-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210903_051803_033961_F9107D55 
X-CRM114-Status: GOOD (  11.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When the no linger is set, the networking stack sends FIN followed by
RST immediately when shutting down the socket. By enabling linger when
shutting down we have a proper shutdown sequence on the wire.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
The current shutdown sequence on the wire is a bit harsh and
doesn't let the remote host to react. I suppose we should
introduce a short (how long?) linger pause when shutting down
the connection. Thoughs?

 drivers/nvme/host/tcp.c | 1 +
 include/net/sock.h      | 1 +
 net/core/sock.c         | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e2ab12f3f51c..6c6dc465147a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1558,6 +1558,7 @@ static void nvme_tcp_restore_sock_calls(struct nvme_tcp_queue *queue)
 
 static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 {
+	sock_reset_linger(queue->sock->sk);
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_calls(queue);
 	cancel_work_sync(&queue->io_work);
diff --git a/include/net/sock.h b/include/net/sock.h
index 66a9a90f9558..313a6c8ba51c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2777,6 +2777,7 @@ int sock_set_timestamping(struct sock *sk, int optname,
 
 void sock_enable_timestamps(struct sock *sk);
 void sock_no_linger(struct sock *sk);
+void sock_reset_linger(struct sock *sk);
 void sock_set_keepalive(struct sock *sk);
 void sock_set_priority(struct sock *sk, u32 priority);
 void sock_set_rcvbuf(struct sock *sk, int val);
diff --git a/net/core/sock.c b/net/core/sock.c
index 62627e868e03..23090a01e412 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -755,6 +755,14 @@ void sock_no_linger(struct sock *sk)
 }
 EXPORT_SYMBOL(sock_no_linger);
 
+void sock_reset_linger(struct sock *sk)
+{
+	lock_sock(sk);
+	sock_reset_flag(sk, SOCK_LINGER);
+	release_sock(sk);
+}
+EXPORT_SYMBOL_GPL(sock_reset_linger);
+
 void sock_set_priority(struct sock *sk, u32 priority)
 {
 	lock_sock(sk);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
