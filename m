Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181CACA5FC5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hThQis9jrIYHM2qp/AUyAye12+rzpdk99d0bmSnxuAo=; b=1h+ulgaSMX/AL2pzl+cNtC875d
	5KTx9AZpNZH51juw02SetelKFdK8h/qfu1gAnK4s29PIT0y9LgOItt7hvOaUwTw20JcyQrXBnNGPa
	3p7g0dB9RNvwjKZy2WNKu5yL7IBA+zccofe5iuB53tRQJgWbe+/WIidQsqZLMC1Qv/Yu3FmW1/Y2a
	d9C1ZhVpjsSeD5G3cSSmjoUkTxDLSpvVsvqs5cWc+DAhsBLa5bV7xIaFSJ5iu82ruBfORPBUbnADH
	Y7Ip+jmK3pM3F5CIAVagpB8ol/GGtFh+INEvYrcudUtf8zSzq7pdvNB5BAXMrrkyXKWEoSz7qKXVV
	l+G39LLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7f-00000002jUS-3k3S;
	Tue, 29 Sep 2026 08:23:35 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBS6U-00000002a5B-15wH
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 07:18:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AFD6340050;
	Tue, 29 Sep 2026 07:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318A41F000FF;
	Tue, 29 Sep 2026 07:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790666297;
	bh=hThQis9jrIYHM2qp/AUyAye12+rzpdk99d0bmSnxuAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VwivzD3a6Tfbg1hAmWgU/0lvAsOcO/D2hXgF4I0INZapunQeWFiA/vY9+Pj8um46k
	 ooyPMj18vfhDBUXjxz3dhKxrC+XN2JW9+9CM6Kpr4craL9R0MJ26TlUwOoQk0DosJu
	 gTHOTAGt2AbJdtEAc/Se1u3UgBdqRffpKtTmiwlVip3IaR4H8tSqGTpPXp7sS/0lT7
	 RuQ5LJQxjPDDmef9IVOvE7Ymzh2NTA1DTF+GbYrPFmTDsuyfVORv6qnKeLEbwRO0gn
	 iTkQMEQ0zTsXm9q0ymW/E/4EZGn948lnU6kHmrmasVInSPxWwImDhDQUPdijALzpug
	 1/z5MjigjDm7g==
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
Subject: [PATCH v3 net-next 5/9] dlm: use sk_set_nospace() and sk_clear_nospace()
Date: Tue, 29 Sep 2026 07:17:39 +0000
Message-ID: <20260929071743.23624-6-edumazet@kernel.org>
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
 fs/dlm/lowcomms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index abe9ae4c643fae061d2e168c03219a4f4e1bc007..6aa68a24acab574429664acc3f5ecc25ddd1553d 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -519,7 +519,7 @@ static void lowcomms_write_space(struct sock *sk)
 {
 	struct connection *con = sock2con(sk);
 
-	clear_bit(SOCK_NOSPACE, &con->sock->flags);
+	sk_clear_nospace(sk);
 
 	spin_lock_bh(&con->writequeue_lock);
 	if (test_and_clear_bit(CF_APP_LIMITED, &con->flags))
@@ -1394,7 +1394,7 @@ static int send_to_sock(struct connection *con)
 			/* Notify TCP that we're limited by the
 			 * application window size.
 			 */
-			set_bit(SOCK_NOSPACE, &con->sock->sk->sk_socket->flags);
+			sk_set_nospace(con->sock->sk);
 			con->sock->sk->sk_write_pending++;
 
 			clear_bit(CF_SEND_PENDING, &con->flags);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


