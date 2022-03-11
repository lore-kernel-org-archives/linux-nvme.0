Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA6EC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 10:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SEKI2PhkodDRFAXWlUOkX5Z0g6mXKSzC4yPCVkXzMRo=; b=ic0w07M2AAB8ZOk24ERrUrBIRz
	LTGJ1o5IJJK/a/uxhyXWjc8ZLO+L3bSXnAMh6AYUMVcgtF2J5ZFx6QpYcdLOw3hc3cgJ0VHBrCoMI
	DrnR9JS0igdz4IUm4nrObI6Q3qVYdvKQrH0ls5cbqJT7D4swPWtAhyrAelpR/qlmcH+W6LZVuU7yQ
	4pLFFTvD2oN5oofqeyM0Sz+YuHeziEg5WbPXRblDCU+kPoOe5LpvXbqDheZcpza+FPse7w5MfsQbB
	3C0olFIoOqI3cMlMdHLwLb9BDYHUh33vHrgJNU82TuH9Zn/vhMdKu8vRWNLVKvxho11Py+h2mQxQ3
	yQTpm5Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSccU-00G1jh-OP; Fri, 11 Mar 2022 10:35:38 +0000
Received: from smtprz01.163.net ([106.3.154.234] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSccQ-00G1fm-Iv
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 10:35:37 +0000
Received: from localhost (localhost [127.0.0.1])
 by vip-app02.163.net (Postfix) with ESMTP id 07C5F440174
 for <linux-nvme@lists.infradead.org>; Fri, 11 Mar 2022 18:35:32 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646994932; bh=R3j49KALSMnjuQeiVsymhqxJED/9xKOwSzuBBzckNSQ=;
 h=From:To:Cc:Subject:Date:From;
 b=QO0EVADPJ5mFvA8UeB0V34xyUlisp93dZm+qOTIt7hokBK7A+9fqnHsZlziYK/Wp0
 W5RbrCyqhzjPdLb+eLGQFOD/Z4d1qeoXasmSgTvXwvdjUtqA7zeEWWk9X9DSiO8HKY
 DPg7L1k8fnXslzoNHbhaQLQsVRxGaeGxl3q/xc98=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
 by localhost (TOM SMTP Server) with SMTP ID 1306936709
 for <linux-nvme@lists.infradead.org>;
 Fri, 11 Mar 2022 18:35:32 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646994932; bh=R3j49KALSMnjuQeiVsymhqxJED/9xKOwSzuBBzckNSQ=;
 h=From:To:Cc:Subject:Date:From;
 b=QO0EVADPJ5mFvA8UeB0V34xyUlisp93dZm+qOTIt7hokBK7A+9fqnHsZlziYK/Wp0
 W5RbrCyqhzjPdLb+eLGQFOD/Z4d1qeoXasmSgTvXwvdjUtqA7zeEWWk9X9DSiO8HKY
 DPg7L1k8fnXslzoNHbhaQLQsVRxGaeGxl3q/xc98=
Received: from localhost.localdomain (unknown [101.93.196.13])
 by antispamvip.163.net (Postfix) with ESMTPA id 1DF371541564;
 Fri, 11 Mar 2022 18:35:23 +0800 (CST)
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
Subject: [PATCH v2 1/3] tcp: export symbol tcp_set_congestion_control
Date: Fri, 11 Mar 2022 18:34:12 +0800
Message-Id: <20220311103414.8255-1-sunmingbao@tom.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220311_023535_015035_F5E6139B 
X-CRM114-Status: GOOD (  13.41  )
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
 net/ipv4/tcp_cong.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index db5831e6c136..1d6a23e42f7d 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -344,10 +344,20 @@ int tcp_set_allowed_congestion_control(char *val)
 	return ret;
 }
 
-/* Change congestion control for socket. If load is false, then it is the
- * responsibility of the caller to call tcp_init_congestion_control or
- * tcp_reinit_congestion_control (if the current congestion control was
- * already initialized.
+/**
+ * tcp_set_congestion_control - set a sock's congestion control
+ * @sk:            the sock.
+ * @name:          the desired congestion control.
+ * @load:          whether to load the required module in case not loaded.
+ * @cap_net_admin: indicating if the caller have the CAP_NET_ADMIN.
+ *
+ * Returns 0 or an error.
+ *
+ * Must be called on a locked sock.
+ *
+ * If load is false, then it is the responsibility of the caller to call
+ * tcp_init_congestion_control or tcp_reinit_congestion_control (if the
+ * current congestion control was already initialized).
  */
 int tcp_set_congestion_control(struct sock *sk, const char *name, bool load,
 			       bool cap_net_admin)
@@ -383,6 +393,7 @@ int tcp_set_congestion_control(struct sock *sk, const char *name, bool load,
 	rcu_read_unlock();
 	return err;
 }
+EXPORT_SYMBOL_GPL(tcp_set_congestion_control);
 
 /* Slow start is used when congestion window is no greater than the slow start
  * threshold. We base on RFC2581 and also handle stretch ACKs properly.
-- 
2.26.2


