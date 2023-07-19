Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0479EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 11:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gvILd7sk13wwDq+N4D5AU+ZHek+MVfhla4H8J9D8dBw=; b=kdhC98BpFFu3p/N3Pr1cL9aZgr
	M/dPaVkDSb5N01QlO+Aj8N7q8u9mCn3DBindTojvfoPtnQTsGRtV7Bz/b4gDRvx3gkXtPejr4A1KM
	rpt99RfAcJwsORocR1D7lfUZ6/ddBbpA6uw6YiV1UFiCGiXkNrvOPSZlmbqeE46DBPlyu0vlU6ar+
	jP9aropO2IjlO0OvcLjj1IMmg5+2kYsgKF555qUMykkcJB8I6t7Ty+9htjvZFEN8P5upLnZfMm7vz
	UVVf/lgvnFH/CdkPF6XohlCVkuOOUwsy+jkxFNvlQQYc6YJeK6os1JpJL+P7OQCiRzf82j2l2e8+A
	9SwyUUCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5Dk-0076HY-0q;
	Wed, 19 Jul 2023 11:19:52 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5Dh-0076Ec-1S
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 11:19:50 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 07B6821B68;
	Wed, 19 Jul 2023 11:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689765588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvILd7sk13wwDq+N4D5AU+ZHek+MVfhla4H8J9D8dBw=;
	b=QKf4rHEgkfF363ZtObP/c36dA/nJbgHoUWelvbsc2cwpDZ/0FV9qx+DIa2du1k6T/HKdbC
	GsRqnmDkX3bWpqihnCGYzNlSeKGrbUlHF9+mdJAZTeKexlSMv8dweyay5HuJapUIIFZDP7
	NlhjNUasOx5dUXV5v3oZua5NfO/2+NA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689765588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvILd7sk13wwDq+N4D5AU+ZHek+MVfhla4H8J9D8dBw=;
	b=OyBzKnCUPiBWh9ZoyCFDOX60/PyGR9HwJd5z26W2JEZhwaSanOva5puVyh0iT/W/oFEQq7
	CF6nxZ1MVF8wO8AA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D99B02C143;
	Wed, 19 Jul 2023 11:19:47 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id CC3EE51C9EBD; Wed, 19 Jul 2023 13:19:47 +0200 (CEST)
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
Subject: [PATCH 1/6] net/tls: handle MSG_EOR for tls_sw TX flow
Date: Wed, 19 Jul 2023 13:19:39 +0200
Message-Id: <20230719111944.68544-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230719111944.68544-1-hare@suse.de>
References: <20230719111944.68544-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_041949_664642_812B1BE0 
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


