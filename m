Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AC1C001B3
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 09:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b6jtiezrHbpPbHdDJAQk+MY/BXvcSOqXXZBiE03yA8s=; b=k+BFQ/31Qq6u6PA+nF9Dim9Nee
	kRhaAh6WvbRcFAKlQCc5whQKlF2ExZzMMTJTIPHy8EHOG2/Xu3ZLSCnXkbiOlU1r4usKc8SY7zqdj
	kI90oXs4I5ruEFDYij00lcIc61lCaT71c57LgVhvXZBCfn/qrEXdDGNJFdRD1n9uLwaLsiCqcQ3mt
	LY0mQJuy8hgPHHnoRRt3jOxn9N5AbB90Ecj949TJVL1jn59U+9MfRSzgZO+O2HtDhTypWCmmYK6oc
	ZKkigNUjWS6acclAihVnJo7Lnp691RrG4rXeLg5Jfuq9R6ate1pjh+RHtUAjshDYV1A7Vfe3iZMVf
	meEEy8SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGFUZ-009qWv-1i;
	Mon, 03 Jul 2023 09:05:07 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGFUT-009qRu-38
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 09:05:04 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 3952C1FD70;
	Mon,  3 Jul 2023 09:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688375096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6jtiezrHbpPbHdDJAQk+MY/BXvcSOqXXZBiE03yA8s=;
	b=YsABc6F/fTY686Kaupnxi1MqwpXmRKmsRK4WleLex5ofTtnSPM+v+eVDN6Q9KRo9JP4Ibp
	KKZ/D6tJQnYnxce1VAL1kjV0Jh0VMRxopbmpJj709xImqBmYK8JsloEuDYA1TCkYlyV7L+
	fRzCBmsxxBTmvSZ3aYTSW6U+yqrjalE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688375096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6jtiezrHbpPbHdDJAQk+MY/BXvcSOqXXZBiE03yA8s=;
	b=Fy57z40UA7+eFANhXJhFblCgExfSd1EDS4sz049l/sfQdXzXqzktY6Qb4QCwVpwwqk9VDn
	9JfvAMRYZXLkehBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id E9BDE2C143;
	Mon,  3 Jul 2023 09:04:55 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id DE2FE51C5D89; Mon,  3 Jul 2023 11:04:55 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/5] net/tls: handle MSG_EOR for tls_device TX flow
Date: Mon,  3 Jul 2023 11:04:41 +0200
Message-Id: <20230703090444.38734-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230703090444.38734-1-hare@suse.de>
References: <20230703090444.38734-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_020502_241263_69FB421A 
X-CRM114-Status: GOOD (  12.36  )
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


