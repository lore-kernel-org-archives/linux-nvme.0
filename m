Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11057CA5FB1
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OPajyF9FpTj0kdlawINv7kUV6GbsYhAG/0HAkx7dZ6s=; b=xlLIbDWARSwklQOblyxZP06liw
	mxdtL8WaHJYOs90M+U6UBP26l+YLvAKTeHJnEfooggSY3Gb7M60rehu0sQDxF1ogGsodpyBsGqrdK
	UPSkglwILjnwYGq/rc2ET7D9OGr/G7+YHrME7CRUIUvygHGOp61LPl/b7Co0m3asHgmmiAV7vw/w1
	iRjVDGHmV2E/S5F3lpPeBVGmDk3sgFqvOnTvY7UEFoZD8WEwwQtQBFm9pyvYjOsMhYqzVj+rtJfi0
	o17ThGHjLa8nYFeRU8BaSLsDW3QtlCbCjK2GPGefm14XQcPpCWJ3RmQlvXCXhoncT9lIAGjk61kAZ
	0+6UuDvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7f-00000002jU5-392u;
	Tue, 29 Sep 2026 08:23:35 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBS6Q-00000002a4R-1N5w
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 07:18:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7997A602CA;
	Tue, 29 Sep 2026 07:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31591F00899;
	Tue, 29 Sep 2026 07:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790666293;
	bh=OPajyF9FpTj0kdlawINv7kUV6GbsYhAG/0HAkx7dZ6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BbuCT+m8zPy06hZWnuow0+uWftZurI4ASu5Wb63Dvh7l0cVGZT3j4uvj9VIqpVzz8
	 dMLqI2peRMPS/ii2Z0wjkWcoKZDuZCJhsnRRIatPEHFC4OAC2cByCn8Qk22HbiBX8o
	 XHkBrJrYZo/RlzzdRCZXV3LNVc/lGpoqSQH4fZj1ZXRbCEUJ5EsptZTAa2qHzhzs8J
	 xtlomL4J5ccBDKN5WiHp+gxQjTIdpSIKMrnJQFpqdgtTNQr8E9H1HolnlIlE+uQwTX
	 5WkZgPd4ZmXn946h7vjskb/VzO9IfS7PrORPEZGFQrCqmMhUwhA66q3I66s7QaJSdu
	 wVNJ2CU1FzAdw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	edumazet@google.com,
	netdev@vger.kernel.org,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	gfs2@lists.linux.dev,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	mptcp@lists.linux.dev,
	Wen Gu <guwen@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Allison Henderson <achender@kernel.org>,
	rds-devel@oss.oracle.com,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH v3 net-next 4/9] rds: use sk_set_nospace()
Date: Tue, 29 Sep 2026 07:17:38 +0000
Message-ID: <20260929071743.23624-5-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260929071743.23624-1-edumazet@kernel.org>
References: <20260929071743.23624-1-edumazet@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 01:23:30 -0700
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

Use the new helpers instead of open coding the SOCK_NOSPACE
manipulation, so that TCP can later maintain a cheaper private
copy of this bit.

No functional change intended.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/rds/tcp_send.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/rds/tcp_send.c b/net/rds/tcp_send.c
index 7c52acc749cf4d4003c749a2646c2b4f87f207fe..824222c475119d91e333123c5afc9291005a8696 100644
--- a/net/rds/tcp_send.c
+++ b/net/rds/tcp_send.c
@@ -100,7 +100,7 @@ int rds_tcp_xmit(struct rds_connection *conn, struct rds_message *rm,
 
 	if (hdr_off < sizeof(struct rds_header)) {
 		/* see rds_tcp_write_space() */
-		set_bit(SOCK_NOSPACE, &tc->t_sock->sk->sk_socket->flags);
+		sk_set_nospace(tc->t_sock->sk);
 
 		ret = rds_tcp_sendmsg(tc->t_sock,
 				      (void *)&rm->m_inc.i_hdr + hdr_off,
@@ -221,6 +221,5 @@ void rds_tcp_write_space(struct sock *sk)
 	 */
 	write_space(sk);
 
-	if (sk->sk_socket)
-		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+	sk_set_nospace(sk);
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


