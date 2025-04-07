Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDFAC369A3
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 18:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4c5PRsn7O6BsPB6gXPg8wPIUVPeFNKSYbt0iMRi41U8=; b=w/tZdjqYQgPokhf8CPXiwQwt4Z
	i4KP6P/X6XjtGGMfBiXSrmwpYfrOI0CFgiJpuA11VpHVzIO1DuSuBSI+zK76eRl7NrzvMcGJ2RzEf
	PyxUpTCJ2+7YqsTHo0hbgMQWTeYAQM2QvzEeg/iwgEoZXqIORX8RqcjjHHkn94SRF9m3c3+4OPziy
	rMqCji669p9EqOFW8RU5qVIKvObNXDtffNK1vrupnJ/Mpt0SGGHiBrdIVOCW0n7CQetmQUA/FUl+C
	FMEIctkhGfkLP098HVGan3HPMO+RhXtI6b9DK6BBgbJwHuRbgEJGfohXcYrgP5abZ3mOZCFH1g2Fu
	nnzdRJaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1rZR-00000001etH-46Jb;
	Mon, 07 Apr 2025 18:51:45 +0000
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1q8N-00000001Lhx-1sUt
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 17:19:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744046383; x=1775582383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4c5PRsn7O6BsPB6gXPg8wPIUVPeFNKSYbt0iMRi41U8=;
  b=eaR2odb138pBvOBR3DWoQYkRxLagAPFmrheJbBPE1ct+jYCCYuv9zeQp
   2SH0G1Z7+tEvh0Wei3JTN6IC/N+4STDTlnraIN+89B0dQmLgTafGWwwnz
   UYt43/jnY3G5+rf2Erlk50yuV0Y4S4HnGZNabm9FGxRRlLJPcpobW+fL4
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,194,1739836800"; 
   d="scan'208";a="81542275"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 17:19:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:46951]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.195:2525] with esmtp (Farcaster)
 id 8729d04d-4f18-40af-b169-77f6624111b8; Mon, 7 Apr 2025 17:19:39 +0000 (UTC)
X-Farcaster-Flow-ID: 8729d04d-4f18-40af-b169-77f6624111b8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 17:19:37 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 17:19:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <hch@lst.de>
CC: <axboe@kernel.dk>, <gechangzhong@cestc.cn>, <kbusch@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<netdev@vger.kernel.org>, <sagi@grimberg.me>, <shaopeijie@cestc.cn>,
	<zhang.guanghui@cestc.cn>, <kuniyu@amazon.com>
Subject: Re: [PATCH v2] nvme-tcp: Fix netns UAF introduced by commit 1be52169c348
Date: Mon, 7 Apr 2025 10:18:18 -0700
Message-ID: <20250407171925.28802-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407143121.GA11876@lst.de>
References: <20250407143121.GA11876@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.45]
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_101943_638583_D51D12FE 
X-CRM114-Status: GOOD (  12.55  )
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

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 7 Apr 2025 16:31:21 +0200
> I had another look at this patch, and it feels wrong to me.  I don't
> think we are supposed to create sockets triggered by activity in
> a network namespace in the global namespace even if they are indirectly
> created through the nvme interface.  But maybe I'm misunderstanding
> how network namespaces work, which is entirely possible.
> 
> So to avoid the failure I'd be tempted to instead revert commit
> 1be52169c348 until the problem is fully sorted out.

The followup patch is wrong, and the correct fix is to take a reference
to the netns by sk_net_refcnt_upgrade().

---8<---
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
---8<---

