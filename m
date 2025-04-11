Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B13C3601E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Apr 2025 01:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eWMRE5n89Q3oYkFXKVPTa6twiNvPyEdAxJTN67+MhUw=; b=r5hswh1smMD7F79/IVUIyxgIPE
	wOhIr0l6RSSBbvpVMONrKUEkWp4NZ0obOck+nUlChuBh9IfAcpN7WsVw3iSLdjwnKSizprnfLy/Cb
	ks/tO3LW9EPG/VbdsWP5LE/bU2MX49K/QrviykCLUeHVJhkaRMQ/XEsfci35Sn2bowIUDEj1n/XK7
	aab/THAvSZB82T6VWqJ7ZokBWHTuaTl19xkPq2KrKxpxVh0qgVhqmRbG5y6wVs6kAySmgbZ2FPMAT
	Emtew7eHJhDHg8DT3Suqqw1LSCyGbCJEyX9RmKna062BMyWuFOq9IanQtRm0T+RHH3NQp3HWoZ5JG
	95+ZnVCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u32lQ-0000000CBTL-0hzj;
	Fri, 11 Apr 2025 01:01:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u32lN-0000000CBSw-44tL
	for linux-nvme@lists.infradead.org;
	Fri, 11 Apr 2025 01:00:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9EE0D49D68;
	Fri, 11 Apr 2025 01:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE890C4CEDD;
	Fri, 11 Apr 2025 01:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744333257;
	bh=IZQOMUCRZMQQWtM6OcdHrUH6XhdRKk/HRVzljAfM710=;
	h=From:To:Cc:Subject:Date:From;
	b=ZAwKfep6K3oiRaFe1hTvFwDXcf4I+mbWig2RNAIMwjjEY39lz8/suy8bHXlXQszVb
	 Ql5OOKR2QTZFC0eQeeh/kfNz+g8TWaqjrLa9tagjoi6IK1N5Ir2GB8mKMJlDoB4fEr
	 GS3owUSbJ7Oc+2qhpfwsyhcxv2D1WpsskrDAwWc14xNG1mhP0zV8Z3lL+Hf/6qjS3w
	 05PjzGVP9jWxyqKKY+xOd1xI3Z+pTdXPeFRwSBYHW4bgHFY/2KEm7FyBJgGY5QLBAX
	 Y2u4sc6dQS3c7GbnPR8/qYYoxMBBAxFFpMcDOgHsnGSvY7Zen3D1ZZHw47wvgjQpts
	 PFRkCCYERwp/g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvmet: auth: Avoid sparse warning in nvmet_auth_sq_free()
Date: Fri, 11 Apr 2025 10:00:15 +0900
Message-ID: <20250411010015.1017829-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_180058_026474_7612716A 
X-CRM114-Status: GOOD (  10.55  )
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

When compiling with C=1, the following sparse warning is generated:

auth.c:243:23: warning: Using plain integer as NULL pointer

Avoid this warning by using NULL to instead of 0 to set the sq tls_key
pointer.

Fixes: fa2e0f8bbc68 ("nvmet-tcp: support secure channel concatenation")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 0b0645ac5df4..cef8d77f477b 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -240,7 +240,7 @@ void nvmet_auth_sq_free(struct nvmet_sq *sq)
 {
 	cancel_delayed_work(&sq->auth_expired_work);
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
-	sq->tls_key = 0;
+	sq->tls_key = NULL;
 #endif
 	kfree(sq->dhchap_c1);
 	sq->dhchap_c1 = NULL;
-- 
2.49.0


