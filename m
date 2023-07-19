Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEB0C001DE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b6jtiezrHbpPbHdDJAQk+MY/BXvcSOqXXZBiE03yA8s=; b=kkrBazk57FiVbNH/ptfRz7ozPw
	PoSPmonuuxmPT1EjaV7w01K3Q1rAYygibxqjwauFs8hUDg3mlim9O3SYfXtHfCyQIjIYCO8eG7Zu/
	yH0eX1lh8UtnnVrZo6FYWAmhBjWM11opkaYsOyrh6O83BcptbO1kji4+C9TILBh+F3kSVyt9C5zfC
	9GAc/WxnhRdtql4xXYsqxFh1NmxRqJeLMVdYVLWUtyqlKpIwEvT8i++y7I+OYbIfFsseMDVFMEsZf
	v+ZyeFPfqDOr0O7g/QjnslXycDYYGtdWUaBA95spIlXYu7RhhD7kUSXGQP9bVp74pQJkn/Otp/dLq
	QMjfsr/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5Dn-0076KZ-0M;
	Wed, 19 Jul 2023 11:19:55 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5Dj-0076Eb-0A
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 11:19:52 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 07BE51FE95;
	Wed, 19 Jul 2023 11:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689765588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6jtiezrHbpPbHdDJAQk+MY/BXvcSOqXXZBiE03yA8s=;
	b=uuqdpwV9FeWALcVNAde3L7eXYdrXvqJhl1rz3sVG1piYXhEYTQQ8SWtvoX+uz/1pzwyhdn
	rJz4s+Fp9IoEhuLpLays2e7UWpQPxqzS2EP3Zd90CDaWMuBlymciwvu9/707LmXNFbHte0
	BrAv4DdILfZ2O8dDpmBFEf9Om3d8kbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689765588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6jtiezrHbpPbHdDJAQk+MY/BXvcSOqXXZBiE03yA8s=;
	b=ecHyuYuDUoPtqAfBIBLmYi2tbF7Tm5wQdtQudGAwIxmW8nyodyKQx2rAJU3t4zEbdvp6Ga
	8WZuDgV12PBkrdBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id DDD8F2C145;
	Wed, 19 Jul 2023 11:19:47 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id D485551C9EBF; Wed, 19 Jul 2023 13:19:47 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	netdev@vger.kernel.org
Subject: [PATCH 2/6] net/tls: handle MSG_EOR for tls_device TX flow
Date: Wed, 19 Jul 2023 13:19:40 +0200
Message-Id: <20230719111944.68544-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230719111944.68544-1-hare@suse.de>
References: <20230719111944.68544-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_041951_506768_F5E782BF 
X-CRM114-Status: GOOD (  12.70  )
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

tls_push_data() MSG_MORE, but bails out on MSG_EOR.
Seeing that MSG_EOR is basically the opposite of MSG_MORE
this patch adds handling MSG_EOR by treating it as the
absence of MSG_MORE.
Consequently we should return an error when both are set.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 net/tls/tls_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 2021fe557e50..5df18f696d7f 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -441,9 +441,13 @@ static int tls_push_data(struct sock *sk,
 	long timeo;
 
 	if (flags &
-	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SPLICE_PAGES))
+	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
+	      MSG_SPLICE_PAGES | MSG_EOR))
 		return -EOPNOTSUPP;
 
+	if ((flags & (MSG_MORE | MSG_EOR)) == (MSG_MORE | MSG_EOR))
+		return -EINVAL;
+
 	if (unlikely(sk->sk_err))
 		return -sk->sk_err;
 
-- 
2.35.3


