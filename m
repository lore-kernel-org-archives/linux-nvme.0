Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E24BCA100C
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Sep 2025 23:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7RQc815K1cguAID8fXNkab2jZSzhJE3mElKVPnNFJkw=; b=ED087v/wjsIY8WVk3zr1yqAx9v
	VAIKSzh3IIEIytt1YkuBnObdhhPDTqcIT6j9XwKDmzntbZSiBaOTRN27yg2c+66YiiE54Wf5rQt/g
	uNh9rv+N2H1hSxHJMaumXGfEOYSngYntRLcmi6+x7LeCitvcsqJx0E0CoLOA/ic/OFNKWn5q7JdVq
	3hPXJk0O8Ipjj1jej7gu/imWuJ5IymkowuPGOozMJ7TKl+Sm7NT32Ea3gZA2nT1l9V8Sy/SVI+dSt
	DH1I0RZZwP0LBZ24wnVSYQ3npqCTWDdEKCSFUQehGpMY+zn1jnq7uGYD49TDGRs/r7laJ4FD7sELn
	zTJynGXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utDh5-0000000EE2c-0Qhk;
	Mon, 01 Sep 2025 23:12:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut6oQ-0000000DBSW-0j1O
	for linux-nvme@lists.infradead.org;
	Mon, 01 Sep 2025 15:51:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6A34C447AF;
	Mon,  1 Sep 2025 15:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0227C4CEF0;
	Mon,  1 Sep 2025 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756741877;
	bh=+d4/imJUBiI3Xursn4W/oBtcM8JHT5OMCHlOTWaPeoA=;
	h=From:Date:Subject:To:Cc:From;
	b=anQyuVvdGy5pkqnFSRSjk+XpK46Zk9Se9/r+byAPbSZYqL64rFOO29O7uxeWWIG56
	 zX1b97FoWVQVs7guBPkYeUdPz3mxl+XmCg+QBGFeK8VhQnSK4mMWWnyv2RbMOwRKbR
	 3eV0OvB/D7wOKgLqipJpO1qTjHWzeWD4dkWBKQMTEbcpDFMfBUkXhVK2/xxkkBrq7Z
	 xtWnzbARjGbUAx0OsNeD9J68ZtaSN3H65cMPUXLCausjKHSrr/LW1eSx9WJNffb4Id
	 b5clSzOptCyyBIuzomJ2IXI7dlhqm4U6U4gNffA7Q+/V8ABwJharudZIUlrK1Wd0ym
	 7dQZzltzGPpiQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 01 Sep 2025 17:51:13 +0200
Subject: [PATCH] nvmet-fcloop: call done callback even when remote port is
 gone
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-nvme-fc-fix-leaks-v1-1-3ae0aa88d5e5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPDAtWgC/x2MSQqAMAwAvyI5G6jV4vIV8RBrqkGt0oII4t8tH
 odh5oHIQThClz0Q+JIoh09Q5BnYhfzMKFNi0Eob1aoC/bUzOotObtyY1ogVaWOpbGpDI6TuDJz
 k/+yH9/0AmPJ1cWMAAAA=
X-Change-ID: 20250901-nvme-fc-fix-leaks-4a25ca3875ab
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_085118_234741_0E2FE2F0 
X-CRM114-Status: GOOD (  14.65  )
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

When the target port is gone, it's not possible to access any of the
request resources. The function should just silently drop the response.
The comment is misleading in this regard.

Though it's still necessary to call the driver via the ->done callback
so the driver is able to release all resources.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs-OBA0WMt5f7R0dz+rR4HcEz19YLhnyGsj-MRV3jWDsPg@mail.gmail.com/
Fixes: 84eedced1c5b ("nvmet-fcloop: drop response if targetport is gone")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 257b497d515a892a39da82d2f96b3fa3c6e10cdd..5dffcc5becae86c79ef75a123647566b2dfc21f6 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -496,13 +496,15 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 	if (!targetport) {
 		/*
 		 * The target port is gone. The target doesn't expect any
-		 * response anymore and the ->done call is not valid
-		 * because the resources have been freed by
-		 * nvmet_fc_free_pending_reqs.
+		 * response anymore and thus lsreq can't be accessed anymore.
 		 *
 		 * We end up here from delete association exchange:
 		 * nvmet_fc_xmt_disconnect_assoc sends an async request.
+		 *
+		 * Return success because this is what LLDDs do; silently
+		 * drop the response.
 		 */
+		lsrsp->done(lsrsp);
 		kmem_cache_free(lsreq_cache, tls_req);
 		return 0;
 	}

---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250901-nvme-fc-fix-leaks-4a25ca3875ab

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


