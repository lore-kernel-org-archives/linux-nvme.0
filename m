Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696F3C55174
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Aug 2026 06:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eOli6oQDuvK/j5yjuVJfio8ypK3vDCmN1PA1hPchLUs=; b=uILxhr5wKpxX3TOjORyLvW6RqZ
	YLuzmBiWvGFAdhf88gB+Rk4bVtRUGm4ng2kFD1scXRsPLD4N6sNYZndu2mxWDTA6ZaCZjo7z1W8xP
	oos3845fZoa3jetbmo66chVATIfPuYFDk7Ve/41ADfi8FeRGDTDkHynACtp+SxWF43gI2YkyZLGx1
	S1mdM/kcb10yNpFPKuCxuSUCnPfcA+KszOxP0ew8b6LeIp6HK7MHAHkFdfZqZ/5E/NAfyeyICdEyr
	VLxj7/hU5HVZhR3uxLQcfXftoQfDZ6Lx14sH4v1hz2OUdyzRHCGVchzjRwfIbLzWvvmNY0VpnV78q
	wXHqNjMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsayj-00000009719-0D40;
	Sat, 08 Aug 2026 06:56:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsayh-0000000970r-3oUJ
	for linux-nvme@lists.infradead.org;
	Sat, 08 Aug 2026 06:56:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4EBFC43472;
	Sat,  8 Aug 2026 06:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2063E1F00A3A;
	Sat,  8 Aug 2026 06:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786172179;
	bh=eOli6oQDuvK/j5yjuVJfio8ypK3vDCmN1PA1hPchLUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SH5FOaiUpsypafEkbFKZt/ckxoPTspIen1L9PpnyuZ+1JGdbzIlToLyq8j5gmA+LA
	 uB0Vs/NdC2YBfvenqs+tlajOzBRwjMnrz0DT5om1zNNu4haEW0TpXmwFTnJka4SgBe
	 EBEvUQIsxMqQpjOnM4XjYJZk6kTvxgZTi/bicxiqi5tOpew1dk22k57fvaEOULQVHz
	 QdXHs/jC8f/Y3RHCogjUe2vB6kToSj5LXMH5j2gd5RYviMutF6pdjY77ePBGaE0Q6p
	 nQM0Az1BmI6/LIiiFWCbuuqvScMlMz5OL3pexZmyQcUdm1bDBpGm/frw/zGcT3PbqQ
	 vaCZeOjDPzm2Q==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH v2 3/3] nvmet-tcp: support IPv6 traffic class
Date: Sat,  8 Aug 2026 14:55:01 +0800
Message-ID: <ef1d3f9cbd321aeb0a49f37685f2fb7e01c60623.1786171863.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786171863.git.tanggeliang@kylinos.cn>
References: <cover.1786171863.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Geliang Tang <tanggeliang@kylinos.cn>

nvmet-tcp currently applies the received IPv4 TOS value when setting
up a queue socket, but does not handle the IPv6 traffic class.

Extend the queue socket setup to handle AF_INET6 sockets. Obtain the
traffic class from the IPv6 socket's rcv_flowinfo and apply it through
ip6_sock_set_tclass(). Keep the existing IPv4 TOS handling unchanged.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 75a276d73be3..1d65519ebc0f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1725,6 +1725,14 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	/* Set socket type of service */
 	if (inet->rcv_tos > 0)
 		ip_sock_set_tos(sock->sk, inet->rcv_tos);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sock->sk->sk_family == AF_INET6) {
+		u8 rcv_tclass = ip6_tclass(inet6_sk(sock->sk)->rcv_flowinfo);
+
+		if (rcv_tclass > 0)
+			ip6_sock_set_tclass(sock->sk, rcv_tclass);
+	}
+#endif
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
-- 
2.53.0


