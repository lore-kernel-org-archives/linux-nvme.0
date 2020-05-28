Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0488FC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 05:14:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B786E2084C
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 05:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YTnUIfwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B786E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RQffdivGgM4BfL9ugwE/FjVdx7TBNpFmi7w+41NkjpM=; b=YTnUIfwpDnwgsI
	vtfn//9pUP2ueVeROg/HqHHWHPccQZoZPcYKy9H5hKSrP2ffwqwA9ZNkAXJFa6Toq8QB03qN6LeeZ
	3CUEJOMQRzQG9e5KvEjE/YImclD/S9vy/PNB4Cvc6YVc++70KwB5cOHCttnbZv1fM5NeJmbA8oePc
	nMjB9qiSPhPQSvDYpu8l+p3uAoQXqGgzE0u1ROtGNtmIPnagmchEK6g/ukY0obpY8cKN0G5/ErxZ6
	x50Spj0SzIp9qxFk6Sl11A4G5sZX8c7w67fFH0WbyxE0ZPmIqiHFRSaMczdFOmNkNvqRdNfF4g8MJ
	SRiX18DGN0Nf3txNkrsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeAs2-0002oc-Tr; Thu, 28 May 2020 05:14:22 +0000
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jeAqg-0001fT-LD; Thu, 28 May 2020 05:13:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 06/28] net: add sock_enable_timestamps
Date: Thu, 28 May 2020 07:12:14 +0200
Message-Id: <20200528051236.620353-7-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528051236.620353-1-hch@lst.de>
References: <20200528051236.620353-1-hch@lst.de>
MIME-Version: 1.0
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
 cluster-devel@redhat.com, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jon Maloy <jmaloy@redhat.com>,
 linux-rdma@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, Ying Xue <ying.xue@windriver.com>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, ceph-devel@vger.kernel.org,
 linux-afs@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a helper to directly enable timestamps instead of setting the
SO_TIMESTAMP* sockopts from kernel space and going through a fake
uaccess.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/sock.h       |  1 +
 net/core/sock.c          | 47 +++++++++++++++++++++++++---------------
 net/rxrpc/local_object.c |  8 +------
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index cdec7bc055d5b..99ef43508d2b5 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2689,6 +2689,7 @@ static inline bool sk_dev_equal_l3scope(struct sock *sk, int dif)
 void sock_def_readable(struct sock *sk);
 
 int sock_bindtoindex(struct sock *sk, int ifindex);
+void sock_enable_timestamps(struct sock *sk);
 void sock_no_linger(struct sock *sk);
 void sock_set_priority(struct sock *sk, u32 priority);
 void sock_set_reuseaddr(struct sock *sk);
diff --git a/net/core/sock.c b/net/core/sock.c
index 23f80880fbb2c..e4a4dd2b3d8b3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -757,6 +757,28 @@ void sock_set_sndtimeo(struct sock *sk, s64 secs)
 }
 EXPORT_SYMBOL(sock_set_sndtimeo);
 
+static void __sock_set_timestamps(struct sock *sk, bool val, bool new, bool ns)
+{
+	if (val)  {
+		sock_valbool_flag(sk, SOCK_TSTAMP_NEW, new);
+		sock_valbool_flag(sk, SOCK_RCVTSTAMPNS, ns);
+		sock_set_flag(sk, SOCK_RCVTSTAMP);
+		sock_enable_timestamp(sk, SOCK_TIMESTAMP);
+	} else {
+		sock_reset_flag(sk, SOCK_RCVTSTAMP);
+		sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
+		sock_reset_flag(sk, SOCK_TSTAMP_NEW);
+	}
+}
+
+void sock_enable_timestamps(struct sock *sk)
+{
+	lock_sock(sk);
+	__sock_set_timestamps(sk, true, false, true);
+	release_sock(sk);
+}
+EXPORT_SYMBOL(sock_enable_timestamps);
+
 /*
  *	This is meant for all protocols to use and covers goings on
  *	at the socket level. Everything here is generic.
@@ -948,28 +970,17 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_TIMESTAMP_OLD:
+		__sock_set_timestamps(sk, valbool, false, false);
+		break;
 	case SO_TIMESTAMP_NEW:
+		__sock_set_timestamps(sk, valbool, true, false);
+		break;
 	case SO_TIMESTAMPNS_OLD:
+		__sock_set_timestamps(sk, valbool, false, true);
+		break;
 	case SO_TIMESTAMPNS_NEW:
-		if (valbool)  {
-			if (optname == SO_TIMESTAMP_NEW || optname == SO_TIMESTAMPNS_NEW)
-				sock_set_flag(sk, SOCK_TSTAMP_NEW);
-			else
-				sock_reset_flag(sk, SOCK_TSTAMP_NEW);
-
-			if (optname == SO_TIMESTAMP_OLD || optname == SO_TIMESTAMP_NEW)
-				sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
-			else
-				sock_set_flag(sk, SOCK_RCVTSTAMPNS);
-			sock_set_flag(sk, SOCK_RCVTSTAMP);
-			sock_enable_timestamp(sk, SOCK_TIMESTAMP);
-		} else {
-			sock_reset_flag(sk, SOCK_RCVTSTAMP);
-			sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
-			sock_reset_flag(sk, SOCK_TSTAMP_NEW);
-		}
+		__sock_set_timestamps(sk, valbool, true, true);
 		break;
-
 	case SO_TIMESTAMPING_NEW:
 		sock_set_flag(sk, SOCK_TSTAMP_NEW);
 		/* fall through */
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 01135e54d95d2..5ea2bd01fdd59 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -189,13 +189,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 		}
 
 		/* We want receive timestamps. */
-		opt = 1;
-		ret = kernel_setsockopt(local->socket, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
-					(char *)&opt, sizeof(opt));
-		if (ret < 0) {
-			_debug("setsockopt failed");
-			goto error;
-		}
+		sock_enable_timestamps(local->socket->sk);
 		break;
 
 	default:
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
