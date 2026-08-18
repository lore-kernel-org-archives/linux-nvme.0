Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51DFC5DF70
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 06:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B2O7HteIhiLtqRyn/DIyOgikrgWD4I8OBbeQRR73W8A=; b=yaEZjY3fqUdgHFA27oFjYgrXXw
	lgmtSuNHODKBeh8PXoROtWpd7/sqJe6tvFqWOpqMYyjqeiHLbxBZd1ygrOLvRLuetWrFcjEpJxk8X
	lxBvWH8mXocTHnHscjX8a/H/0e0DyqAg7yy4nkGLR5jDmfK7IBTYTxfKWY04oz9t/oIduu/LBfA24
	c/0vJ5T6F3nuuf8Oh5HAQoJ9VnfrRNtp6OJU8+Gc0Cwls+kCWUOjURwKEI4W16U8xirkTIDb5oXoD
	4nq3vpnEKUTv4x+VUAmR2hqH0jhVIXewcDKA4BkDWX7EpnvnZ0+dJpSlwf2/ioIowc9bu08bTzyfU
	wfs4oiog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwCvc-00000007NU1-1qL4;
	Tue, 18 Aug 2026 06:04:04 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwCva-00000007NSp-299I
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 06:04:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E0AA042E97;
	Tue, 18 Aug 2026 06:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711821F00A3A;
	Tue, 18 Aug 2026 06:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787033041;
	bh=B2O7HteIhiLtqRyn/DIyOgikrgWD4I8OBbeQRR73W8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LWHxdTg90cikKZA64HRhmzVNAddjUJL6WZIMNJ22gDFgJucfSnFcBwSM9x8B/fvWT
	 Q8CnzzRUthtyG67xBv+GsZjfvUwd4U54mjVqrlux1aJmTV2m2OtlKaKF9m0SCxMhYf
	 PIHFoWxBqG6lfRnQixUnyZGoz9WpkUM5bDqO3AU2L/+e+IxZYRhbRhYCabQC7yMah2
	 7DZq+pqCvPCZXKNDyFMBqTCNOeanYn5wSInTcNwzkgmPgQuxR8yy2yzkPj3gUJCZkO
	 0mPMe7zTe7Yb9e+zJQvSdiiaaC/FVLkjAY6+GVNxubrtVH3eGPbunFuKXlv4zcXXZs
	 ApvJwpWoEMi3g==
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
Subject: [PATCH v4 4/4] nvme-tcp: support IPv6 traffic class
Date: Tue, 18 Aug 2026 14:03:03 +0800
Message-ID: <d6095cd3809af7addc44ed162d70d6327dc237ac.1786947923.git.tanggeliang@kylinos.cn>
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

Currently, nvme-tcp host only supports setting the IPv4 TOS value when a
TOS is specified, but does not handle the IPv6 traffic class.

Extend the queue socket setup to handle AF_INET6 sockets by applying the
TOS value to both IPv4 and IPv6 sockets. For IPv6, the TOS value is set
as the IPv6 traffic class via IPV6_TCLASS using do_sock_setsockopt().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 025cade370b2..5f30be04a9dd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1815,6 +1815,17 @@ static int nvme_tcp_sock_set_tos(struct sock *sk, int tos)
 				  KERNEL_SOCKPTR(&tos), sizeof(tos));
 }
 
+static int nvme_tcp_sock_set_tclass(struct sock *sk, int tclass)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6)
+		return do_sock_setsockopt(sk->sk_socket, false, SOL_IPV6,
+					  IPV6_TCLASS, KERNEL_SOCKPTR(&tclass),
+					  sizeof(tclass));
+#endif
+	return 0;
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -1909,6 +1920,15 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				qid, ret);
 			goto err_sock;
 		}
+
+		ret = nvme_tcp_sock_set_tclass(queue->sock->sk,
+					       nctrl->opts->tos);
+		if (ret) {
+			dev_err(nctrl->device,
+				"failed to set IPV6_TCLASS on queue %d err %d\n",
+				qid, ret);
+			goto err_sock;
+		}
 	}
 
 	/* Set 10 seconds timeout for icresp recvmsg */
-- 
2.53.0


