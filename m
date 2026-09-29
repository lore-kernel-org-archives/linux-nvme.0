Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E19CA5FA1
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RnWUSUoPlsuP4rnCrMGHZfdBwvKHsEHp7ONS81OIlUg=; b=i+rXQWjhyD4ApCuifsHzgBhHQH
	2faHmQUfgkQSXrmH4g00lP2EzXDt3jN4vLlnVTRX/7RT5+9gETIC73NGFUyEwOgCmC4LiuArXJA+1
	S94sn225CCnAbHC6xxSPcvSLZsQhIgLfX2NiTwSUaf7C8bdOnP+x/9aotSoBQp6JV3V7UIO48IChR
	CUJsjRRJdDf7UV4tiZEXPfhTFY3hqMX2DfC8Lr7eGeIIW8f2/VFoNKxZNr3q4aNCsst/TduCBs2iR
	HwDi2nNt0wk818u7U4hEJSzmqvbRFgdBvYcD0wBqo93WM3iYC64y3kjcWvgmv1QI1NqsguIFpDpDM
	yYg5+XEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7g-00000002jUt-2cTG;
	Tue, 29 Sep 2026 08:23:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBS6Y-00000002a63-2T3d
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 07:18:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 54E2B43441;
	Tue, 29 Sep 2026 07:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C0B1F00893;
	Tue, 29 Sep 2026 07:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790666302;
	bh=RnWUSUoPlsuP4rnCrMGHZfdBwvKHsEHp7ONS81OIlUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Utmyw0ZM96CbsgrYi7Di59lazewSJzkqgeCES4nSZti+IkvQCMxSaEX88ZKJjxOaj
	 zUWbZuXoe7uutd0a8VirVY4s6libYi8v+CFbziQeDQ6HwyA5Hr1P2B0tKrg6pDK9G9
	 6EV/14xbrkSI+W3pL6lhkD/dP2yzga6gZbzWU0pJOkwFlkK4BmSrbFCpeitPYiTNkg
	 o3atTJQsP2tS6/yI0SMxpo56E1/28mcKwHn+27jtxmmb6hW3J09MQHWkzuimU/ghVA
	 WMuho6JPxiSj2sOwc0JQkxgLh2KpNt85qfi8fzgt2G0Kddq2PFgtzuUEmSix9n/c1I
	 +Riy/PYJ/j7ew==
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
Subject: [PATCH v3 net-next 6/9] drbd: use sk_set_nospace()
Date: Tue, 29 Sep 2026 07:17:40 +0000
Message-ID: <20260929071743.23624-7-edumazet@kernel.org>
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
 drivers/block/drbd/drbd_worker.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 0697f99fed18d7e70f00b7c559a131517ee8aa42..8e50131b5a5692a8dfb99eafe706602153be94b7 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -635,8 +635,7 @@ static int make_resync_request(struct drbd_peer_device *const peer_device, int c
 			int sndbuf = sk->sk_sndbuf;
 			if (queued > sndbuf / 2) {
 				requeue = 1;
-				if (sk->sk_socket)
-					set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+				sk_set_nospace(sk);
 			}
 		} else
 			requeue = 1;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


