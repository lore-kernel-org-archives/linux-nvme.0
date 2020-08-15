Return-Path: <SRS0=fF/j=BZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4282C433E1
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2020 12:43:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F80C23118
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2020 12:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ed14/qdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F80C23118
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VeArMRjtYRQnOYPZ0P6E7cw5+cqg0hJgM1pS2bhaY18=; b=Ed14/qdTzwFai6i/59cbBNCHP
	gTKUBYjLs8rGJr+/NKc0nTSxIrubzKzvTASghBaTUInt8+md94jL470PuLoHgjQ75t+xsZwqGRT53
	2vbidoK7s8TLhWvlAyUVYDb3NHf3s4Duh1m6WRI8TTDVFNt1pD5ckeqfWiYDZXcALq1WpThjvh5ub
	o6Ml/Mdm+ocvdSrK8NiBTESLt8BZ3W6Ltvv3IYgr+PnLDHq2wjKAQyzhIfelHdLfEIpa8URfJhehn
	TN2aGsrTllQfB75mUfh16d54V5SX2raz0WZqigEToYqYYT8hnA6vk1u2GgpvDgLWEAR1pvNV6FQqs
	46mf85CGg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6vWo-0000TG-DI; Sat, 15 Aug 2020 12:43:18 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6vWg-0000SF-9T
 for linux-nvme@lists.infradead.org; Sat, 15 Aug 2020 12:43:11 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EBD8AB1BE;
 Sat, 15 Aug 2020 12:43:32 +0000 (UTC)
From: colyli@suse.de
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v4 3/3] drbd: code cleanup by using sendpage_ok() to check
 page for kernel_sendpage()
Date: Sat, 15 Aug 2020 20:42:54 +0800
Message-Id: <20200815124254.115076-3-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200815124254.115076-1-colyli@suse.de>
References: <20200815124254.115076-1-colyli@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200815_084310_542300_9D95053D 
X-CRM114-Status: GOOD (  17.31  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, netdev@vger.kernel.org,
 Philipp Reisner <philipp.reisner@linbit.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Coly Li <colyli@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Coly Li <colyli@suse.de>

In _drbd_send_page() a page is checked by following code before sending
it by kernel_sendpage(),
        (page_count(page) < 1) || PageSlab(page)
If the check is true, this page won't be send by kernel_sendpage() and
handled by sock_no_sendpage().

This kind of check is exactly what macro sendpage_ok() does, which is
introduced into include/linux/net.h to solve a similar send page issue
in nvme-tcp code.

This patch uses macro sendpage_ok() to replace the open coded checks to
page type and refcount in _drbd_send_page(), as a code cleanup.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
---
Changelog:
v3, introduce a more common sendpage_ok()
v2, fix typo in patch subject
v1, the initial version.
 drivers/block/drbd/drbd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index cb687ccdbd96..55dc0c91781e 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1553,7 +1553,7 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 	 * put_page(); and would cause either a VM_BUG directly, or
 	 * __page_cache_release a page that would actually still be referenced
 	 * by someone, leading to some obscure delayed Oops somewhere else. */
-	if (drbd_disable_sendpage || (page_count(page) < 1) || PageSlab(page))
+	if (drbd_disable_sendpage || !sendpage_ok(page))
 		return _drbd_no_send_page(peer_device, page, offset, size, msg_flags);
 
 	msg_flags |= MSG_NOSIGNAL;
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
