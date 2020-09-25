Return-Path: <SRS0=ggB5=DC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6CEC47420
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 15:01:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D556E235FD
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 15:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XGsT72Zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D556E235FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YIqMLJkJ7uFlpZvYtvweaVWfjhT/YG25C/NW3+rY/UU=; b=XGsT72Zv46l8hAGG21gnFYShn
	W7fLkrz+VVfKuH/cdK7LOw2XnlGBfhoDE6c8JQLcTAU0dDa2lBVoWNQ/LYjODkSnvs8MU0hC1Fd8e
	BCpygTFBqiuBHpZSF20lN4kkCEJh7kt/PXUjuNF9Dg71sypjnqaC1WfVD9zwdqiOkIZyZIbOPGmvD
	JclH5AuqJToaezhQmfukmjpB0+Je6QmeRCjVCJXH/CS1kjMfqXROsFGz3ZKpEVasvxGdzkTozXyW1
	j0inN6p9Oyg1/M9XrWq2KB/Z3GFF3rJl7V/7KW9LDfYW2Op7Z/bnhVuPnEYUbBKp4c3DEJ9dcoC9G
	uOPqPqF7w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLpEL-0002LZ-6f; Fri, 25 Sep 2020 15:01:49 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLpEI-0002L5-KN
 for linux-nvme@lists.infradead.org; Fri, 25 Sep 2020 15:01:47 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A0E5AACA3;
 Fri, 25 Sep 2020 15:01:45 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, open-iscsi@googlegroups.com,
 linux-scsi@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: [PATCH v8 1/7] net: introduce helper sendpage_ok() in
 include/linux/net.h
Date: Fri, 25 Sep 2020 23:01:13 +0800
Message-Id: <20200925150119.112016-2-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200925150119.112016-1-colyli@suse.de>
References: <20200925150119.112016-1-colyli@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200925_110146_834992_D21AB6CF 
X-CRM114-Status: GOOD (  18.26  )
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
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Coly Li <colyli@suse.de>,
 Hannes Reinecke <hare@suse.de>, Jan Kara <jack@suse.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

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
 include/linux/net.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/net.h b/include/linux/net.h
index d48ff1180879..05db8690f67e 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -21,6 +21,7 @@
 #include <linux/rcupdate.h>
 #include <linux/once.h>
 #include <linux/fs.h>
+#include <linux/mm.h>
 #include <linux/sockptr.h>
 
 #include <uapi/linux/net.h>
@@ -286,6 +287,21 @@ do {									\
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
+	return  !PageSlab(page) && page_count(page) >= 1;
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
