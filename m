Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A799C001DE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 07:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zdnNPe9x6gIbmIISAnn80bWKgLVTtTKLyV6yho1UrN8=; b=OTaO8i10SXWbouv0h2r7q4biab
	EzpgCkBxLLqRjozoja95wANABmyzVo6/E2v0hMrRvtc76cPP+TFN1/ax7l3wLBj9N+98tVb+QJE3r
	pjTBXLl6XNvaAZCDikMv4yARle714z3BN3hcf1He2Psw4jVpA/WdWrBEkF1d0hLaR8MGFy6Yy19xG
	ew5Mv4WjHHCNdwAFnlJJj9dJAPJJl9cHPf0ARnOn/HlWkjV8z7ULnwc3/STlQ43GCBzX+DVhNBMbQ
	ImX3/bkbYsOuhPTnuxRAdNOdo+8W5+zNKuTDARtQclDw8NVuGbvqvf0n+JFT5XBR1OE2dqC/QJvHE
	aI5OB6pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSuNr-00GKZz-14;
	Mon, 07 Aug 2023 07:10:31 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSuNo-00GKZW-08
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 07:10:29 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 2A5D22189B;
	Mon,  7 Aug 2023 07:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691392225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zdnNPe9x6gIbmIISAnn80bWKgLVTtTKLyV6yho1UrN8=;
	b=gbPVndzk1qiyMm3VX8KoGMLIUAxrAmu9qaYVdL7neQWrd9SF8+3HMsHkSyiO5fqqpBgDP+
	Dpe03HBFA6L8vs9jPn9ssZqabSvsSBZ3GMdgR1zDcts+KOVdJYrBpRm45niUH4YcQuTZtd
	DwJ/Lva1PzimXsBhQbC8JrCfiJIKz+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691392225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zdnNPe9x6gIbmIISAnn80bWKgLVTtTKLyV6yho1UrN8=;
	b=eSSZ6X33K8v63XA64TqfEbTUzXPEUwm4I9h73y1FRNlnnzuzrdklU9Gq7dI2ZKxiM7tG4x
	dWocFqVVqHmCpjBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 38ABA2C142;
	Mon,  7 Aug 2023 07:10:24 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 2671151CAB59; Mon,  7 Aug 2023 09:10:24 +0200 (CEST)
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
Subject: [PATCHv2] net/tls: avoid TCP window full during ->read_sock()
Date: Mon,  7 Aug 2023 09:10:22 +0200
Message-Id: <20230807071022.10091-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_001028_736322_357CE2EA 
X-CRM114-Status: GOOD (  10.34  )
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

When flushing the backlog after decoding a record we don't really
know how much data the caller want us to evaluate, so use INT_MAX
and 0 as arguments to tls_read_flush_backlog() to ensure we flush
at 128k of data. Otherwise we might be reading too much data and
trigger a TCP window full.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 net/tls/tls_sw.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9c1f13541708..5c122d7bb784 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2240,7 +2240,6 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			tlm = tls_msg(skb);
 		} else {
 			struct tls_decrypt_arg darg;
-			int to_decrypt;
 
 			err = tls_rx_rec_wait(sk, NULL, true, released);
 			if (err <= 0)
@@ -2248,20 +2247,18 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 
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
+			released = tls_read_flush_backlog(sk, prot, INT_MAX,
+							  0, decrypted,
+							  &flushed_at);
 			skb = darg.skb;
+			rxm = strp_msg(skb);
+			tlm = tls_msg(skb);
 			decrypted += rxm->full_len;
 
 			tls_rx_rec_done(ctx);
-- 
2.35.3


