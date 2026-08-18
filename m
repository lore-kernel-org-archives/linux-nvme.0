Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE50C5DF67
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 06:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nis9dfnj0IQkbN06JcjcoUd3EWxyn7iXPcVuP3vmsVY=; b=hUybpo8mQZ5UzFpUQqWLBo65P/
	HNFCHy9vjEnrWLsJfSyShzFW5yiuA4YpdUqyfGH3xbdy1+yo/GOQpRIWbbCVn6dfsvvVVgui+00NY
	MuFvkgMNFyowO60/Vd6OYd+tNReTMmtJ+huyKHIf6isP2OOk27i9DdqE/0/asaNZpYyugaU8U3+Kg
	GVn+7dxmFImMAhQB0iZHtNoRxif49w3Lxt7EzEMoW8/SOwRmJ8G5LpV+P5PSrc8q7kH8nvCdhotex
	69iWnQSD414T+ivXLVUpBHyOAjBxrx03KtL0hgmiq+licnZCoS94lult37j/s4oDVI7bVARE3u8Nv
	9gQWI3YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwCvT-00000007NOb-1JJE;
	Tue, 18 Aug 2026 06:03:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwCvS-00000007NNo-0gus
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 06:03:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E637940F83;
	Tue, 18 Aug 2026 06:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A441F000E9;
	Tue, 18 Aug 2026 06:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787033033;
	bh=Nis9dfnj0IQkbN06JcjcoUd3EWxyn7iXPcVuP3vmsVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A2UdzNx5HptTFp1gQu4gHG08W2f7E9uDmm+H84rYpZ/MMKbb035eG6R2U3tweQxiz
	 bYwDEhkzx7I6kqFz+0t3tH2Xs74YWxY+uz00woRJt4BQTEtcfhzEfrncajoy6IN4/E
	 1YxfoCTxEQVL0CDJeDaX/GRBHZL/xcpZK3RHLhkFuALkNJchkNObRyl6Ld0qj/Ip/A
	 9tKkD2jh+sLGuWieQCxKqoZW2mbsOXDHEhvAFMPbD9zf4Y3m7efbMH1Bhma2GmlmI2
	 4IH618bfievO8blR167r2NuPqm9yfl30vTAb7nA/F3YUjnARjMGOhjsURM7/ysvvB8
	 IfiT8d1iQc6lg==
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
Subject: [PATCH v4 3/4] nvmet-tcp: support IPv6 traffic class
Date: Tue, 18 Aug 2026 14:03:02 +0800
Message-ID: <bb4e028580bd0198f1dfd63dbd5608c5656cbe26.1786947923.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786947923.git.tanggeliang@kylinos.cn>
References: <cover.1786947923.git.tanggeliang@kylinos.cn>
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
 drivers/nvme/target/tcp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 38b0c446ae89..ed413aa5601c 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1737,6 +1737,22 @@ static int nvmet_tcp_sock_set_tos(struct sock *sk)
 	return 0;
 }
 
+static int nvmet_tcp_sock_set_tclass(struct sock *sk)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6) {
+		int tclass = ip6_tclass(inet6_sk(sk)->rcv_flowinfo);
+
+		if (tclass > 0)
+			return do_sock_setsockopt(sk->sk_socket, false,
+						  SOL_IPV6, IPV6_TCLASS,
+						  KERNEL_SOCKPTR(&tclass),
+						  sizeof(tclass));
+	}
+#endif
+	return 0;
+}
+
 static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
@@ -1772,6 +1788,10 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	if (ret)
 		return ret;
 
+	ret = nvmet_tcp_sock_set_tclass(sock->sk);
+	if (ret)
+		return ret;
+
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
 	if (sock->sk->sk_state != TCP_ESTABLISHED) {
-- 
2.53.0


