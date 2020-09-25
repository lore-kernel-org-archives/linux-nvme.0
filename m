Return-Path: <SRS0=ggB5=DC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F10BC47426
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 15:01:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01EF222B2D
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 15:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EGz6mCIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EF222B2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/RHSOmp9yqMWs7k8fI7V10faQlgC/gjJh8xLBXef+Hk=; b=EGz6mCIKJsxPop27K7+zsl2o9
	NJgwGcH8goOcczTAQ8dHWL566h9EfLP/1bTR8wBZy5gqHnjb+g/bDUjZTJQW9ed7brRlT8iDyPV2Y
	fBshrudfZeGapCYIVsgcXJd/n+6URCNhXUjpfGtpKAeNUeckjHufw/ISMKNMhSCPHuQFKZrALd+OO
	KzdBtVUAvqXy8HrOEU8cwEe7UEp1ZgGoSnEeWMk9pW9BJo2D4dAhvdV4EPMsze960iyhOtAHrCFPV
	zBPH5tGlZ1hzzmAdR25/eVk1zc5AjcnaA2OXqX89Rrpff7sFq9u9JBBSlCG0xnx5/ExmzLSo+VqZg
	cnT5X8s1A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLpEQ-0002N0-Pv; Fri, 25 Sep 2020 15:01:54 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLpEO-0002MC-7C
 for linux-nvme@lists.infradead.org; Fri, 25 Sep 2020 15:01:53 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 45629AD72;
 Fri, 25 Sep 2020 15:01:51 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, open-iscsi@googlegroups.com,
 linux-scsi@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: [PATCH v8 2/7] net: add WARN_ONCE in kernel_sendpage() for improper
 zero-copy send
Date: Fri, 25 Sep 2020 23:01:14 +0800
Message-Id: <20200925150119.112016-3-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200925150119.112016-1-colyli@suse.de>
References: <20200925150119.112016-1-colyli@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200925_110152_389942_BDC03C72 
X-CRM114-Status: GOOD (  17.57  )
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
Cc: Cong Wang <amwang@redhat.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>,
 "David S . Miller" <davem@davemloft.net>, Sridhar Samudrala <sri@us.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If a page sent into kernel_sendpage() is a slab page or it doesn't have
ref_count, this page is improper to send by the zero copy sendpage()
method. Otherwise such page might be unexpected released in network code
path and causes impredictable panic due to kernel memory management data
structure corruption.

This path adds a WARN_ON() on the sending page before sends it into the
concrete zero-copy sendpage() method, if the page is improper for the
zero-copy sendpage() method, a warning message can be observed before
the consequential unpredictable kernel panic.

This patch does not change existing kernel_sendpage() behavior for the
improper page zero-copy send, it just provides hint warning message for
following potential panic due the kernel memory heap corruption.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Cong Wang <amwang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Sridhar Samudrala <sri@us.ibm.com>
---
 net/socket.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 0c0144604f81..771456a1d947 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3638,9 +3638,11 @@ EXPORT_SYMBOL(kernel_getpeername);
 int kernel_sendpage(struct socket *sock, struct page *page, int offset,
 		    size_t size, int flags)
 {
-	if (sock->ops->sendpage)
+	if (sock->ops->sendpage) {
+		/* Warn in case the improper page to zero-copy send */
+		WARN_ONCE(!sendpage_ok(page));
 		return sock->ops->sendpage(sock, page, offset, size, flags);
-
+	}
 	return sock_no_sendpage(sock, page, offset, size, flags);
 }
 EXPORT_SYMBOL(kernel_sendpage);
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
