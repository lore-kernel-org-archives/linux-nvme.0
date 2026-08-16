Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132D4C5DF67
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Aug 2026 01:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RFXP0uhwAIzZtIngeZhsEQVAe4WY8w8ld85w5SPVvnQ=; b=O6d4Sj3JMfO+PbFszEzp5WHxJg
	yeT1h1FFj8usTU1lMsn1J21jnWclmXaDcPCILWefXvpiLJSZB66zNuviPpAhKrUolRfYzwSKYH8J9
	D1qn7V3P7SmlJ2uk4Z+xFy13xBiEtqyJaAZsKBUc2dK9i/i461+aqTAdL5BplnjihS0c9T/WhRrBp
	HcY9ZaV24BT9eE/oQwl6rg5mhcq0dWeHKyY1qkxkR+FFyVw9mOSsT3d2dFSRgBMdOfhYOpD/xwv6I
	tf+QIyXdV/QBkMsnZX+MqVObfdhZS4IvXlVd8bYs8RHiIm7+e2b14WBTjOPZHlLAOzt8J3AkOwMtr
	BVHLXhFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvPFX-00000004MU1-16Ix;
	Sun, 16 Aug 2026 01:01:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvPFV-00000004MTL-3Fip
	for linux-nvme@lists.infradead.org;
	Sun, 16 Aug 2026 01:01:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2CE17408A6;
	Sun, 16 Aug 2026 01:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B81B1F00A3A;
	Sun, 16 Aug 2026 01:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786842077;
	bh=RFXP0uhwAIzZtIngeZhsEQVAe4WY8w8ld85w5SPVvnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IZzfWCN26y/4FFAh3KmtR6wnGQfgSI7qLm8tekTQKMrp7pDLOYLGQieGL8fw+Kxoh
	 f3rHL49Hzgg/XOzJGn1ETRU6I0MLipzLtLXr+qXiXw+pVkBBR6Shb16LtA8hV7tUAO
	 BIlnCYcxdZNf1mYbxY0purE4aq8+NH3x8P19XFuCA+XFzDpXAv4o3zn1xur14snJ1+
	 TpLvLW8FL1kPptbwPJDOLBcZo3E777b02b4CUJtAi4y+5fmc+nvPMZJNXaMXuNBPby
	 TsR7JUjLFd3TGu0lXS7fF9IVcJjV2nBrLTpMQ1TM+eZGekNLmBBOAYPb20bFCpxC35
	 asA0IsblR8RaA==
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
	Hannes Reinecke <hare@suse.de>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH v3 3/4] nvmet-tcp: support IPv6 traffic class
Date: Sun, 16 Aug 2026 08:59:59 +0800
Message-ID: <7d09c3211dfa76d536c7a30505cea6da626ee5e6.1786841319.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786841319.git.tanggeliang@kylinos.cn>
References: <cover.1786841319.git.tanggeliang@kylinos.cn>
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

Currently, nvmet-tcp only applies the received IPv4 TOS value when setting
up a queue socket, but does not handle the IPv6 traffic class.

Extend the queue socket setup to handle AF_INET6 sockets. Obtain the
traffic class from the IPv6 socket's rcv_flowinfo and apply it through
IPV6_TCLASS using do_sock_setsockopt().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e64592b79257..d34249cf3756 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1735,6 +1735,20 @@ static void nvmet_tcp_sock_set_tos(struct sock *sk)
 				   KERNEL_SOCKPTR(&tos), sizeof(tos));
 }
 
+static void nvmet_tcp_sock_set_tclass(struct sock *sk)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6) {
+		u8 tclass = ip6_tclass(inet6_sk(sk)->rcv_flowinfo);
+
+		if (tclass > 0)
+			do_sock_setsockopt(sk->sk_socket, false, SOL_IPV6,
+					   IPV6_TCLASS, KERNEL_SOCKPTR(&tclass),
+					   sizeof(tclass));
+	}
+#endif
+}
+
 static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
@@ -1762,6 +1776,7 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 
 	/* Set socket type of service */
 	nvmet_tcp_sock_set_tos(sock->sk);
+	nvmet_tcp_sock_set_tclass(sock->sk);
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
-- 
2.53.0


