Return-Path: <SRS0=ggB5=DC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093F0C4727C
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 15:02:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A027120715
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 15:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SZUbj/3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A027120715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FLuaYHcVPW2k52E5JHqibT/shfgmF4YY0g1YAmY/uKM=; b=SZUbj/3V80N9SDjiMBnaI89R4
	tQwzSvQq5ROhUQYhyEOzX5wXAS2EM/jNOKvJccGZ+Mrr1ehfuKF7fsmGa/CRB+eiLxbzf5nqE7kRM
	7WirnDRcI+Kl07aYLElDpoehsU6il4gmfiUPxjArJCz3DzUah7PHyllbFENJEfKZiCAEzuPQYMFrz
	gv01gM3OLXs7SfxCjThml7iuQffA4KoJaCfFAtxnXkwroXtS/cjyo90dtXY3S9TmA1VEzxpF2xPor
	VqAPiUNLKra9nNslld+FEyr9hU9UbxpufkueCtUbw0bUSZiCj/Auqn4ES+hLRoIvdeT/NOurwrBxW
	b5GEwp0KA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLpEs-0002Yo-2z; Fri, 25 Sep 2020 15:02:22 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLpEo-0002X1-UX
 for linux-nvme@lists.infradead.org; Fri, 25 Sep 2020 15:02:19 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F1C89B04F;
 Fri, 25 Sep 2020 15:02:17 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, open-iscsi@googlegroups.com,
 linux-scsi@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: [PATCH v8 7/7] libceph: use sendpage_ok() in ceph_tcp_sendpage()
Date: Fri, 25 Sep 2020 23:01:19 +0800
Message-Id: <20200925150119.112016-8-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200925150119.112016-1-colyli@suse.de>
References: <20200925150119.112016-1-colyli@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200925_110219_141568_2103BBD4 
X-CRM114-Status: GOOD (  14.65  )
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
Cc: Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, Coly Li <colyli@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In libceph, ceph_tcp_sendpage() does the following checks before handle
the page by network layer's zero copy sendpage method,
	if (page_count(page) >= 1 && !PageSlab(page))

This check is exactly what sendpage_ok() does. This patch replace the
open coded checks by sendpage_ok() as a code cleanup.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
---
 net/ceph/messenger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index bdfd66ba3843..d4d7a0e52491 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -575,7 +575,7 @@ static int ceph_tcp_sendpage(struct socket *sock, struct page *page,
 	 * coalescing neighboring slab objects into a single frag which
 	 * triggers one of hardened usercopy checks.
 	 */
-	if (page_count(page) >= 1 && !PageSlab(page))
+	if (sendpage_ok(page))
 		sendpage = sock->ops->sendpage;
 	else
 		sendpage = sock_no_sendpage;
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
