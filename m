Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CDFC001DF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Aug 2023 10:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=23Ay3hsrYo2VYj+VfNj7TJtj73oCBJt38UDK+duMnBI=; b=Kuwfs+YywaOFA9Fu/I1nCD75/u
	kHs6cnd3MRNleW/+LvcKL9cwROARPRDZDd5MXy7Tt3odgVM6UfBBQo34QWUua59ij/OEoYFYoKncQ
	VZYkLxYVZFQt0ferm2B4hmfztTNsEuCh4k19c6mq2NIdso2vvb8iWzIPSU7OhEgdNdLgcke571aRx
	WGDhVMa1ngZtOjOF6CCom34eYMP89tfJGKJoX7clowcYkYz1Rzpd61yqzD/yek3Dq/f/YIg6bz6Wm
	8BftaTXn/lAZ9zhx5ObQq4LU96iQsMIf+PYrttuM0Y805JbL/u7PTyUn7S7W0Shbdrs8Joxbm6V3G
	B+uxB4OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRVFw-007IlM-1q;
	Thu, 03 Aug 2023 10:08:32 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRVFr-007Iin-0N
	for linux-nvme@lists.infradead.org;
	Thu, 03 Aug 2023 10:08:28 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 9BA081F889;
	Thu,  3 Aug 2023 10:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691057293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=23Ay3hsrYo2VYj+VfNj7TJtj73oCBJt38UDK+duMnBI=;
	b=QYaxrtm1kJI+1Ksg+y71AKI90h/WzSfRJk7Y0Zc93S/bbq5ya45TLSpNVYVJG5uBocklDk
	Gv3JC1JbK/ytDqYNmnsmNC4l6KN6cRsz4wKaEcQYVBvITDl4MCFVeTb9cZIV6tixOXWWfh
	kCEivq4YfZiTID90mWlK7FzxtHg0JYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691057293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=23Ay3hsrYo2VYj+VfNj7TJtj73oCBJt38UDK+duMnBI=;
	b=kG3/8PQBqpXoSNZD8Qr1v3lspQ3PtvivUfQ8hrH7fMLdq9QzCyIh+NJMALAvhcxTuwwBz5
	i9r9yq8Ir79k+NDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 789502C145;
	Thu,  3 Aug 2023 10:08:13 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 65C5D51CA7B9; Thu,  3 Aug 2023 12:08:13 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] net/tls: avoid TCP window full during ->read_sock()
Date: Thu,  3 Aug 2023 12:08:09 +0200
Message-Id: <20230803100809.29864-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_030827_323937_E75CE084 
X-CRM114-Status: GOOD (  12.92  )
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

When flushing the backlog after decoding each record in ->read_sock()
we may end up with really long records, causing a TCP window full as
the TCP window would only be increased again after we process the
record. So we should rather process the record first to allow the
TCP window to be increased again before flushing the backlog.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 net/tls/tls_sw.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9c1f13541708..57db189b29b0 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2240,7 +2240,6 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			tlm = tls_msg(skb);
 		} else {
 			struct tls_decrypt_arg darg;
-			int to_decrypt;
 
 			err = tls_rx_rec_wait(sk, NULL, true, released);
 			if (err <= 0)
@@ -2248,20 +2247,16 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 
 			memset(&darg.inargs, 0, sizeof(darg.inargs));
 
-			rxm = strp_msg(tls_strp_msg(ctx));
-			tlm = tls_msg(tls_strp_msg(ctx));
-
-			to_decrypt = rxm->full_len - prot->overhead_size;
-
 			err = tls_rx_one_record(sk, NULL, &darg);
 			if (err < 0) {
 				tls_err_abort(sk, -EBADMSG);
 				goto read_sock_end;
 			}
 
-			released = tls_read_flush_backlog(sk, prot, rxm->full_len, to_decrypt,
-							  decrypted, &flushed_at);
 			skb = darg.skb;
+			/* TLS 1.3 may have updated the length by more than overhead */
+			rxm = strp_msg(skb);
+			tlm = tls_msg(skb);
 			decrypted += rxm->full_len;
 
 			tls_rx_rec_done(ctx);
@@ -2280,6 +2275,12 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			goto read_sock_requeue;
 		}
 		copied += used;
+		/*
+		 * flush backlog after processing the TLS record, otherwise we might
+		 * end up with really large records and triggering a TCP window full.
+		 */
+		released = tls_read_flush_backlog(sk, prot, decrypted - copied, decrypted,
+						  copied, &flushed_at);
 		if (used < rxm->full_len) {
 			rxm->offset += used;
 			rxm->full_len -= used;
-- 
2.35.3


