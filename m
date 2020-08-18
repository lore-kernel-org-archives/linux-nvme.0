Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4D0C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 13:13:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7D7207D3
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 13:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jbn9SLFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7D7207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SqnrV8dFjsHy0DKDPECv7789QhuyzywcH7pUd2R1fbg=; b=jbn9SLFnLyxXSok451SKqhWVx
	l2tM8TxC0OSQdz3o+ZcFlW4b5i9u2Jtt6mh+ayIeRnN/soSNskD3GQx5lGNpcIUw74YyPGNWNmkv+
	+iANkRcsLoC2smjg5OruEi57YMHoUA4ih/BIWkwdIuHTaK/8XduHvWw/2ddmZB4G9+KVoIu6e0A0H
	w8dnhUHPvrZhKIJwsUf0wKKbIqX7GU87HA0oZPsnLT8lIdDTkWKZyRxp3+63+qwYbt3eQT2P5Dmaa
	Qlzq1x0nVugvNLNdRQzURzpP/8azj5pBnOyKNPcNwvWxC36vn32qFIHiUx8SH3krxVY6NuxtiSMj7
	xnFUH11WA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k81Qs-0005ry-8D; Tue, 18 Aug 2020 13:13:42 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k81Qp-0005qe-NM
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 13:13:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 811D9B178;
 Tue, 18 Aug 2020 13:14:04 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, open-iscsi@googlegroups.com,
 linux-scsi@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: [PATCH v7 6/6] libceph: use sendpage_ok() in ceph_tcp_sendpage()
Date: Tue, 18 Aug 2020 21:12:27 +0800
Message-Id: <20200818131227.37020-7-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818131227.37020-1-colyli@suse.de>
References: <20200818131227.37020-1-colyli@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_091339_870107_A1519072 
X-CRM114-Status: GOOD (  14.60  )
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
index 27d6ab11f9ee..6a349da7f013 100644
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
