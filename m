Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC1EC36010
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 22:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HeUzgINLSTNqzHLJeO36JJlCLs5/j5o0fs3XgBEV6S8=; b=IO0esDoqULGuXvHbDOPu8GKpZF
	eEL2rSzXaSloKnwdC+tRafto1V66917T1cpuhUX3oQh19E0ochEb4RMb0jPu33ivjRfk4/j8VHjYV
	+7TZLukCeGAZ01GJc7PEGkeoVWuQoGb6ZkX0up9nBTsNVT016UCAa5NeEc7wSWIsDwA6iHKD+J2+c
	NsKi5OgR4yJdw1bLbrTvIVyjuxj5LfJUqaKRuIKsyl2dbde7Q6cISpdI9Qle2SSs275IsQKLV6Ung
	m0MbIozjSufQ8Xh5/8ewQES8iIjw3ioP4nYrSTY45vMEzqjxsks4gBzn7Io15+Zx8fBEmZVBB+g+5
	4z3nC9lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2HdW-00000005byl-0wrY;
	Tue, 08 Apr 2025 22:41:42 +0000
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2HdT-00000005byR-3rWc
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 22:41:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744152099; x=1775688099;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HeUzgINLSTNqzHLJeO36JJlCLs5/j5o0fs3XgBEV6S8=;
  b=r/+ZPtL0FDyFZzjLIm9XlCAsqkeFazDKxSOjHR9yfFQ49hThEYMQvX9p
   3B7T3LoDrJlUl2/nrvJ0aKBCJUDvEn29JCMWKvyafnK2sZnAP7pvzen6B
   h7+uq23TwqQvevgQA5aA60xlJltDPCwshl2KFD2+X1rdvsC/c9hxI9xKG
   E=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="185724054"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 22:41:37 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:24873]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.159:2525] with esmtp (Farcaster)
 id 2db7eea8-f5e1-4a6b-8bde-c7eba5f29475; Tue, 8 Apr 2025 22:41:36 +0000 (UTC)
X-Farcaster-Flow-ID: 2db7eea8-f5e1-4a6b-8bde-c7eba5f29475
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 22:41:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 22:41:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Peijie Shao <shaopeijie@cestc.cn>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] nvme-tcp: Fix use-after-free of netns by kernel TCP socket.
Date: Tue, 8 Apr 2025 15:40:54 -0700
Message-ID: <20250408224105.2344-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.5]
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_154140_008681_D8E2034F 
X-CRM114-Status: GOOD (  11.95  )
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

Commit 1be52169c348 ("nvme-tcp: fix selinux denied when calling
sock_sendmsg") converted sock_create() in nvme_tcp_alloc_queue()
to sock_create_kern().

sock_create_kern() creates a kernel socket, which does not hold
a reference to netns.  If the code does not manage the netns
lifetime properly, use-after-free could happen.

Also, TCP kernel socket with sk_net_refcnt 0 has a socket leak
problem: it remains FIN_WAIT_1 if it misses FIN after close()
because tcp_close() stops all timers.

To fix such problems, let's hold netns ref by sk_net_refcnt_upgrade().

We had the same issue in CIFS, SMC, etc, and applied the same
solution, see commit ef7134c7fc48 ("smb: client: Fix use-after-free
of network namespace.") and commit 9744d2bf1976 ("smc: Fix
use-after-free in tcp_write_timer_handler().").

Fixes: 1be52169c348 ("nvme-tcp: fix selinux denied when calling sock_sendmsg")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/nvme/host/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 26c459f0198d..72d260201d8c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1803,6 +1803,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		ret = PTR_ERR(sock_file);
 		goto err_destroy_mutex;
 	}
+
+	sk_net_refcnt_upgrade(queue->sock->sk);
 	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
-- 
2.49.0


