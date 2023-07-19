Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB0FC001DC
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 11:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gvILd7sk13wwDq+N4D5AU+ZHek+MVfhla4H8J9D8dBw=; b=g2bnhoridH/IoyfNl57a2U/yDY
	aO11UidZZcbyfkWQmbp0HfoAGWVG5kzcNEiLa4YIYcGKz085nJTT5ojkxh/jYtdV7Wh160trx0Zu8
	/VkqdHgOg6vxgCbBBfAmdQnWBeVioVRn0jOOEdaLgfGVa40db3gegZu2SkoqH9/NnNyGA8bOQqk7r
	KVxpkktEb7jV8zUMqzgUeUns/MdUFtnma7sQCF7+GRFYviFdk/BW8PAxUrUV74HHqyFoumtyWqLmu
	1tqKZFZJ7Ou20CXKQjOsOwrTggAi60UVKaJ+BHsJY3Wl3FxBtOdvxdN94/bnXXtj6BlG/6+G6Uiwh
	MTvw7vZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5W5-007H7W-13;
	Wed, 19 Jul 2023 11:38:49 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5Vy-007H1v-2H
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 11:38:45 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id BBB7A1FEAE;
	Wed, 19 Jul 2023 11:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689766720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvILd7sk13wwDq+N4D5AU+ZHek+MVfhla4H8J9D8dBw=;
	b=Scx4WTPtEFnCnjs7Bf8HH8z2UJrQpAMhRLhiTHFfzq2yaGff2MJxyFLu61XwaaSVH7d+xI
	DIqOayvZ007trApA2733LRMH7aDq3L2AAaYEXcMfXREyLzqfMKClSUjRq1vwjRFVBcF8LK
	c25yWjtRlhsbq42tN1f6FssfrDnM/XM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689766720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvILd7sk13wwDq+N4D5AU+ZHek+MVfhla4H8J9D8dBw=;
	b=Gk2bqXwFNOqlXwihHiVG3cpKzgXVb7YJfP4iOREdfTUM7fqis3JqxYancLHZpFC04N63uf
	cX8WSnBTBqN+ReCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id A2DD92C143;
	Wed, 19 Jul 2023 11:38:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 9605B51C9ECD; Wed, 19 Jul 2023 13:38:40 +0200 (CEST)
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
Subject: [PATCH 1/6] net/tls: handle MSG_EOR for tls_sw TX flow
Date: Wed, 19 Jul 2023 13:38:31 +0200
Message-Id: <20230719113836.68859-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230719113836.68859-1-hare@suse.de>
References: <20230719113836.68859-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_043842_903902_799E3698 
X-CRM114-Status: GOOD (  13.39  )
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

tls_sw_sendmsg() already handles MSG_MORE, but bails
out on MSG_EOR.
Seeing that MSG_EOR is basically the opposite of
MSG_MORE this patch adds handling MSG_EOR by treating
it as the negation of MSG_MORE.
And erroring out if MSG_EOR is specified with MSG_MORE.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 net/tls/tls_sw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 53f944e6d8ef..9aef45e870a5 100644
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
 			       MSG_SENDPAGE_NOPOLICY))
 		return -EOPNOTSUPP;
 
-- 
2.35.3


