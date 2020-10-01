Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E820C4727C
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 07:55:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DCC2145D
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 07:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ymLTv98s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DCC2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W3eVpGYX8HtS9l8k3s4yLjT0EIx5n2hi4FbU16ULLN8=; b=ymLTv98sbheI6PSiShqL7P+d6
	9xydHPm5Z2Xs1D3GmKUTr/t17Hw2hr7MJonbq4tYi33JI7zyJLjm0a6S5AdHR4FfM2GgVRbd0aFrg
	SkAfZClwi0rS4V7eXUZJPsCVKYPC5f/CTA6Y0eDCHfm8KEQKBKkv8viW7X8erfp1vvobNEXWTPXVI
	DdkaCcpq8/dDCNJCiw7JX54RUklLYFlWDIUQdvBJuh5azUZsC37enY8xF2BBwiadytmEECKsjtIJT
	5NtRSY+0u2gjJRP5LViW38bWp4W99CqJroU6wyJLt8swUCNP3p4RMmy5D83Ua6UvTVxsfQfLfL5Ao
	OoWxsymbA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNtQf-0004T4-BV; Thu, 01 Oct 2020 07:55:05 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNtQd-0004RM-4X
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 07:55:04 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 27327AD03;
 Thu,  1 Oct 2020 07:55:02 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, open-iscsi@googlegroups.com,
 linux-scsi@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: [PATCH v9 5/7] drbd: code cleanup by using sendpage_ok() to check
 page for kernel_sendpage()
Date: Thu,  1 Oct 2020 15:54:06 +0800
Message-Id: <20201001075408.25508-6-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001075408.25508-1-colyli@suse.de>
References: <20201001075408.25508-1-colyli@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_035503_309403_DBF2B80E 
X-CRM114-Status: GOOD (  17.27  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
 Coly Li <colyli@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

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
 drivers/block/drbd/drbd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 04b6bde9419d..573dbf6f0c31 100644
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
