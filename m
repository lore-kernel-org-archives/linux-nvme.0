Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C81CEB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jun 2023 07:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YTMjYHHAGQPuyZsL7/qOC3M5jgcdnJ73CtJafqJiKF4=; b=Ade4Ems78Xpj8qVdQZlVOoi00z
	6jhGN0yivVAEVNPJNQi/He3wkoe95UDGUToKgG3eRhbIShcojc7H1xmj1FOcUe3XiupopTd9b6WhP
	lB+8vYFr+1dehsXnpiIi+DA3PFdeAA3M2T/j4Kk618DrpVcdIzqSDzxmQBawnwRvswJWJpMUMaAUw
	ox7o+hnLbc19IlI5m2G6oXxrMRord9Gk83XqemxIIBhgPB0VwLeQQnseWBiEthUZWvOBP8JTjhvtk
	oNo0YLwpI0opcU3WJDe4nr85+pHKKffzqrxPdyRQxPUzA2aQhZh7nnCAxsJbB1Z/+NRtF03FHFqch
	HPisGeyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Kxg-00Afzu-2c;
	Wed, 14 Jun 2023 07:30:36 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Jtf-00APgp-29
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jun 2023 06:22:26 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 782C81FDD8;
	Wed, 14 Jun 2023 06:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686723740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTMjYHHAGQPuyZsL7/qOC3M5jgcdnJ73CtJafqJiKF4=;
	b=uT4TuYK677rQq8HFzK9ZExZrtZzpAa+sooL94SrLe9TXvvZYhnLClCGZeHygPKyYZzKi8v
	0zQKnfe88dgoI54m+ndTQfApLDZkHCCmjcU+Rs6LnJytDcYxOjtlZFXTUeRV1VGrjna2ln
	uE8r8pMdM/3CFFR1I0q2c3wM9iDtvu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686723740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTMjYHHAGQPuyZsL7/qOC3M5jgcdnJ73CtJafqJiKF4=;
	b=uQ0TCmWiK01uBLpCx6Yhmevi+qPAEJneLt3IJf7CXVU4k9EwBR4x9l3IdidEMIGwQxa1eS
	CWUK7bVpC9s8qvAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 5D7912C141;
	Wed, 14 Jun 2023 06:22:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 4ACFE51C4DD9; Wed, 14 Jun 2023 08:22:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/4] net/tls: handle MSG_EOR for tls_sw TX flow
Date: Wed, 14 Jun 2023 08:22:09 +0200
Message-Id: <20230614062212.73288-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230614062212.73288-1-hare@suse.de>
References: <20230614062212.73288-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_232223_890517_C6CA52EF 
X-CRM114-Status: GOOD (  12.25  )
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

tls_sw_sendmsg() / tls_do_sw_sendpage() already handles
MSG_MORE / MSG_SENDPAGE_NOTLAST, but bails out on MSG_EOR.
But seeing that MSG_EOR is basically the opposite of
MSG_MORE / MSG_SENDPAGE_NOTLAST this patch adds handling
MSG_EOR by treating it as the negation of MSG_MORE.
And erroring out if MSG_EOR is specified with either
MSG_MORE or MSG_SENDPAGE_NOTLAST.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 net/tls/tls_sw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 319f61590d2c..47eeff4d7d10 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -984,6 +984,9 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	int ret = 0;
 	int pending;
 
+	if (!eor && (msg->msg_flags & MSG_EOR))
+		return -EINVAL;
+
 	if (unlikely(msg->msg_controllen)) {
 		ret = tls_process_cmsg(sk, msg, &record_type);
 		if (ret) {
@@ -1193,7 +1196,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	int ret;
 
 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
-			       MSG_CMSG_COMPAT | MSG_SPLICE_PAGES |
+			       MSG_CMSG_COMPAT | MSG_SPLICE_PAGES | MSG_EOR |
 			       MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY))
 		return -EOPNOTSUPP;
 
@@ -1287,7 +1290,7 @@ int tls_sw_sendpage_locked(struct sock *sk, struct page *page,
 	struct bio_vec bvec;
 	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES, };
 
-	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
+	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_EOR |
 		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY |
 		      MSG_NO_SHARED_FRAGS))
 		return -EOPNOTSUPP;
-- 
2.35.3


