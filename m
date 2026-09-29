Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C227BCA5FC7
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=984oS/2M5KIktVHs6exbd7VGWIOJaQY+nCN+ILc+rzw=; b=WPkS1WrDmNwraWX4+jdLy/SuML
	2kDvF18RxZwKa7gdx4Qjyo/XFWjY889xHMN7O/jS/nm2ihwrK2YwCv7c/SHWKCjEdFv6hn3VuIiHj
	OWTJGFQNPc4eMkdLlHRTSYJJj8LEK0N7RUenv2WxzfoDnr+xnzyWK6XfT/t581jNzoK4KBh7iXzkS
	tzneWzQmZNn9m61mhu0X2iiBP5yPI/sy4cbrGfzi+snW1k4VwBuMgkeyCGkUrhxg1qrbPsbFteLhN
	P+E+X+nqf7iwvJRqDkuYtheAXSXvtaMhCcXgTwq7P/GRtvlAWM8eEw6Zw8OSkBAWIDuvJB6K78jAd
	ekTk775g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7h-00000002jXN-1hXs;
	Tue, 29 Sep 2026 08:23:37 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBS6h-00000002a7p-0sxN
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 07:18:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EC6C5405EB;
	Tue, 29 Sep 2026 07:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8C91F000FF;
	Tue, 29 Sep 2026 07:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790666310;
	bh=984oS/2M5KIktVHs6exbd7VGWIOJaQY+nCN+ILc+rzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FmRxfTDPEZousgH1mjwF32qw+pB3arJrOFJKVf9mYNrECcwDd0kY5zJEDCAeOfA+h
	 8QMxbbyA3qAZGDy07ZV0BxvdAAP3J68e49cPkJt6Qqx6otSeCjZ7L53yR+diox0onh
	 0f3FLaVkDB96yhiRoQ/51IQ8Jjw9vtUtF6xRj1BTZbdWu8Sg+6hWOhiXzqXplYNXdr
	 A6ZOhgMIkCEDC5tqlKqrUVUUTFn3iZyu1kpzjEUylNVswdGDZ2IZTOmqFxGGutWa/U
	 ADZwjBHN4QGRKgik1vrs/ngbSim7hOwW5sYh9KJo12K4Dl1epBaHdQ/sTKvrSDq5Xt
	 XHscnmim4ChLA==
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
Subject: [PATCH v3 net-next 8/9] libceph: use sk_clear_nospace()
Date: Tue, 29 Sep 2026 07:17:42 +0000
Message-ID: <20260929071743.23624-9-edumazet@kernel.org>
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
 net/ceph/messenger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 212e7797f9e48edde4a4536bba6f1ff293628b5b..cc7db8c61db37a998b698566caa7c936fa83fe4a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -375,7 +375,7 @@ static void ceph_sock_write_space(struct sock *sk)
 	if (ceph_con_flag_test(con, CEPH_CON_F_WRITE_PENDING)) {
 		if (sk_stream_is_writeable(sk)) {
 			dout("%s %p queueing write work\n", __func__, con);
-			clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+			sk_clear_nospace(sk);
 			queue_con(con);
 		}
 	} else {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


