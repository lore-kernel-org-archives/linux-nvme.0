Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34E2C5DF67
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Aug 2026 01:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M6/oWTjVc32MSJeTmKKP99yPQCYD/FPPYy/T9OozK4A=; b=d5QbtE6Y13qu6YmSFJP1QeldEk
	97qFv2yiNMMZ1JT53uXsO2RbMjV2NG5LZ2xAsdjQ6XAfJsYmol36i6Wh36kJMOt0gLOfkR1bhw5Gp
	ImDvJFDlZhz76ROzLpRF/6ryJpAld4rF1G9+t+OgkvZ1uvHZCbctjQUvzXBiCxLHi40nfxdIOQed0
	rzzuPaWPzO3d2v2Z0xYVhZX6TPbAbw+ixS5zkIFZnxu02qr4I1vMWTA+HlaY64+XJICOM2du7EY0r
	7OYgbwV5DDrVodu+d9/Yat7czR1FlLy9afxjCjeLOqsyLvb2y0YAJb+sdrj65DLl6b/gYxr0dXbnG
	JaNJ30sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvPFh-00000004MXz-1dbE;
	Sun, 16 Aug 2026 01:01:29 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvPFg-00000004MX5-0NSq
	for linux-nvme@lists.infradead.org;
	Sun, 16 Aug 2026 01:01:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3B84C408A6;
	Sun, 16 Aug 2026 01:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3381F000E9;
	Sun, 16 Aug 2026 01:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786842087;
	bh=M6/oWTjVc32MSJeTmKKP99yPQCYD/FPPYy/T9OozK4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=czfC8R9yOs75jdwhylZECirPrZ5LlFYiOGNl7SyrCzDk/hQEp49PzzjdZsoRTGwyK
	 sxYe6s5mAAvklYBDo5JbOr2JWgxcQBd4Dp+v9Ysdq9Mf/ukqIvSROiEaH2eBoIHLQ8
	 uTbXbz/AO9VNVvCYqxlyy9i4zsrMP83e4ddibTA6P3dp8u5kGNH4n75ZCD2vMn1+7x
	 dlrvIVmOXecnsyxGFX3OhRpNGy4i/oRa27+fanm0ZItA9lg+9zvn2EMcBUlSEF7QCd
	 ja5wozZpXe67dMf7onmYXMRCTur+1KrmXKiSV809R/jUAEBR2On4VqOZ/fMGohj1We
	 EVcPy66PeLaPA==
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
Subject: [PATCH v3 4/4] nvme-tcp: support IPv6 traffic class
Date: Sun, 16 Aug 2026 09:00:00 +0800
Message-ID: <52c4840e36ee6016d18806c2d205f4f9fdc1e830.1786841319.git.tanggeliang@kylinos.cn>
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

Currently, nvme-tcp host only supports setting the IPv4 TOS value when a
TOS is specified, but does not handle the IPv6 traffic class.

Extend the queue socket setup to handle AF_INET6 sockets by applying the
TOS value to both IPv4 and IPv6 sockets. For IPv6, the TOS value is set
as the IPv6 traffic class via IPV6_TCLASS using do_sock_setsockopt().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 89a82e8248d2..657acae9e4a4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1815,6 +1815,15 @@ static void nvme_tcp_sock_set_tos(struct sock *sk, int tos)
 			   KERNEL_SOCKPTR(&tos), sizeof(tos));
 }
 
+static void nvme_tcp_sock_set_tclass(struct sock *sk, int tclass)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6)
+		do_sock_setsockopt(sk->sk_socket, false, SOL_IPV6, IPV6_TCLASS,
+				   KERNEL_SOCKPTR(&tclass), sizeof(tclass));
+#endif
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -1876,8 +1885,10 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		nvme_tcp_sock_set_priority(queue->sock->sk, so_priority);
 
 	/* Set socket type of service */
-	if (nctrl->opts->tos >= 0)
+	if (nctrl->opts->tos >= 0) {
 		nvme_tcp_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
+		nvme_tcp_sock_set_tclass(queue->sock->sk, nctrl->opts->tos);
+	}
 
 	/* Set 10 seconds timeout for icresp recvmsg */
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
-- 
2.53.0


