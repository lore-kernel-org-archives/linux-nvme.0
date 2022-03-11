Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AD7C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 03:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7P2lI5PzR5b5I0H5D0nAJEItNesJmrafgjKUAtBYhU8=; b=t4xpcJFZmhrCKNuQQyH9hVeeys
	JXF4wDvQBQUAOi68GeN52DhHeh1BD/z9IHAS6x7IGa8s5b/U69mnHltacTjO4THn7dVm39R+9l7Nx
	QCOAEd42lHhyrxxFotLDVHntqRxA7CKOSOe7WuhKVBjBNwWJTB0pSY4Zm5QVzB2CfNK9ovPwNpS59
	jtHGwsUbuDiso1cLEu1YlSQyzNnbj8MKaRHeE8sJcxdkm9zNk119PTFtppvqc7wSp8rXCBZCmMtRl
	yjacKkWVJI5Z0eZ1e8IJfahNndLtBUQDX3GQr+AotTaZiLKHjLP01xLdUug+/c87fQwNbVtyQ3r00
	U23Q9nwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSVXz-00EqIo-Lh; Fri, 11 Mar 2022 03:02:31 +0000
Received: from smtprz01.163.net ([106.3.154.234] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSVXr-00EqEj-Tn
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 03:02:25 +0000
Received: from localhost (localhost [127.0.0.1])
 by vip-app02.163.net (Postfix) with ESMTP id 0F434440168
 for <linux-nvme@lists.infradead.org>; Fri, 11 Mar 2022 11:02:22 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646967742; bh=ScMuHjAXfamD9Fmid4TX5rIBXmPUVWR9zJbXFToXGJQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CtYK0p0wjAoQBZD17mfNjHOqKcrWYTtVv89I7EsySz4YZfAC18TLTaMlZn2kJwba4
 ikH/BKGWD49vA/Hlo1jxt3aq7yU2OXO1CJHejrsPYvxIvqsROMEC9qaNoR6CgJRQAu
 Ldoe5lc3sPcCst5a7FQRwbjGDvtFj9wLpfhfHPCU=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
 by localhost (TOM SMTP Server) with SMTP ID 165104697
 for <linux-nvme@lists.infradead.org>;
 Fri, 11 Mar 2022 11:02:22 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646967742; bh=ScMuHjAXfamD9Fmid4TX5rIBXmPUVWR9zJbXFToXGJQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CtYK0p0wjAoQBZD17mfNjHOqKcrWYTtVv89I7EsySz4YZfAC18TLTaMlZn2kJwba4
 ikH/BKGWD49vA/Hlo1jxt3aq7yU2OXO1CJHejrsPYvxIvqsROMEC9qaNoR6CgJRQAu
 Ldoe5lc3sPcCst5a7FQRwbjGDvtFj9wLpfhfHPCU=
Received: from localhost.localdomain (unknown [101.93.196.13])
 by antispamvip.163.net (Postfix) with ESMTPA id 4BA691541574;
 Fri, 11 Mar 2022 11:02:18 +0800 (CST)
From: Mingbao Sun <sunmingbao@tom.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: sunmingbao@tom.com, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: [PATCH 1/3] tcp: export symbol tcp_set_congestion_control
Date: Fri, 11 Mar 2022 11:01:11 +0800
Message-Id: <20220311030113.73384-2-sunmingbao@tom.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220311030113.73384-1-sunmingbao@tom.com>
References: <20220311030113.73384-1-sunmingbao@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_190224_145845_D0481CB2 
X-CRM114-Status: GOOD (  10.98  )
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

From: Mingbao Sun <tyler.sun@dell.com>

congestion-control could have a noticeable impaction on the
performance of TCP-based communications. This is of course true
to NVMe/TCP in the kernel.

Different congestion-controls (e.g., cubic, dctcp) are suitable for
different scenarios. Proper adoption of congestion control would
benefit the performance. On the contrary, the performance could be
destroyed.

So to gain excellent performance against different network
environments, NVMe/TCP tends to support specifying the
congestion-control.

This means NVMe/TCP (a kernel user) needs to set the congestion-control
of its TCP sockets.

Since the kernel API 'kernel_setsockopt' was removed, and since the
function ‘tcp_set_congestion_control’ is just the real underlying guy
handling this job, so it makes sense to get it exported.

Signed-off-by: Mingbao Sun <tyler.sun@dell.com>
---
 net/ipv4/tcp_cong.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index db5831e6c136..5d77f3e7278e 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -383,6 +383,7 @@ int tcp_set_congestion_control(struct sock *sk, const char *name, bool load,
 	rcu_read_unlock();
 	return err;
 }
+EXPORT_SYMBOL_GPL(tcp_set_congestion_control);
 
 /* Slow start is used when congestion window is no greater than the slow start
  * threshold. We base on RFC2581 and also handle stretch ACKs properly.
-- 
2.26.2


