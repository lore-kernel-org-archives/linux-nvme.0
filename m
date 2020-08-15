Return-Path: <SRS0=fF/j=BZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB84C433DF
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2020 12:43:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E6E23102
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2020 12:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yLBULNIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E6E23102
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ny30hWGzHIZ+gso8g8S/YXGeFk9G4oPJVEWijHnuwXE=; b=yLBULNIUSHBICOpg+3ZmGWbVsT
	X4TEZJQnyowE4/K9arWBT+hjp6C3LEDm3/eo4+xvLpnFweKNyNVbcDDO8ah5UzSx8fwaKEoosX4aA
	hvO6+IWoOhsBZaZSrPGf50+aL4mKK4k0ZG2MdzvN8r1Vx0HD3Aw6kSRMTuwe3MZUkiu2fILus2CYN
	OYXrWMdmdgv4IQQtv/3/jm2IsvchNhegoKGydBEf+SCdtepQmUPXIESY/qlHjI7PVBbAN8oKyZSkp
	EWJS78uPOj2VEm6EJOCwa4+PLq8oB3i6rXWGlAWYMlg1yVz8BqJARPLzuwWhfGdbI9Nnyo8low2fk
	ktcj112A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6vWk-0000S4-LV; Sat, 15 Aug 2020 12:43:14 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6vWa-0000RN-W3
 for linux-nvme@lists.infradead.org; Sat, 15 Aug 2020 12:43:06 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 40F9AAD4B;
 Sat, 15 Aug 2020 12:43:26 +0000 (UTC)
From: colyli@suse.de
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v4 1/3] net: introduce helper sendpage_ok() in
 include/linux/net.h
Date: Sat, 15 Aug 2020 20:42:52 +0800
Message-Id: <20200815124254.115076-1-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200815_084305_185147_92770BAA 
X-CRM114-Status: GOOD (  17.99  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Coly Li <colyli@suse.de>,
 Hannes Reinecke <hare@suse.de>, Jan Kara <jack@suse.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Coly Li <colyli@suse.de>

The original problem was from nvme-over-tcp code, who mistakenly uses
kernel_sendpage() to send pages allocated by __get_free_pages() without
__GFP_COMP flag. Such pages don't have refcount (page_count is 0) on
tail pages, sending them by kernel_sendpage() may trigger a kernel panic
from a corrupted kernel heap, because these pages are incorrectly freed
in network stack as page_count 0 pages.

This patch introduces a helper sendpage_ok(), it returns true if the
checking page,
- is not slab page: PageSlab(page) is false.
- has page refcount: page_count(page) is not zero

All drivers who want to send page to remote end by kernel_sendpage()
may use this helper to check whether the page is OK. If the helper does
not return true, the driver should try other non sendpage method (e.g.
sock_no_sendpage()) to handle the page.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Jan Kara <jack@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Vlastimil Babka <vbabka@suse.com>
Cc: stable@vger.kernel.org
---
Changelog:
v4, change sendpage_ok() as an inline helper, and post it as
    separate patch.
v3, introduce a more common sendpage_ok()
v2, fix typo in patch subject
v1, the initial version.
 include/linux/net.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/net.h b/include/linux/net.h
index d48ff1180879..97e8f1a8a427 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -286,6 +286,21 @@ do {									\
 #define net_get_random_once_wait(buf, nbytes)			\
 	get_random_once_wait((buf), (nbytes))
 
+/*
+ * E.g. XFS meta- & log-data is in slab pages, or bcache meta
+ * data pages, or other high order pages allocated by
+ * __get_free_pages() without __GFP_COMP, which have a page_count
+ * of 0 and/or have PageSlab() set. We cannot use send_page for
+ * those, as that does get_page(); put_page(); and would cause
+ * either a VM_BUG directly, or __page_cache_release a page that
+ * would actually still be referenced by someone, leading to some
+ * obscure delayed Oops somewhere else.
+ */
+static inline bool sendpage_ok(struct page *page)
+{
+	return  (!PageSlab(page) && page_count(page) >= 1);
+}
+
 int kernel_sendmsg(struct socket *sock, struct msghdr *msg, struct kvec *vec,
 		   size_t num, size_t len);
 int kernel_sendmsg_locked(struct sock *sk, struct msghdr *msg,
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
