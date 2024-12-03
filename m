Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74F7E64A83
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 11:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D9tVKH5ZJCPN6t9I+nT8n+gUKTGrFMASYMHa2krJaMY=; b=WNyOEutaGXY2xNEVxBhG5zsrYi
	jdrNQUzY/jcUvDsi9FM7Lr49BG10QTuNM5C6H3yx4RqM4dqaYXaAk5IK0VO9YuCAOYVrVz6ilev3j
	YeWTcUvuIf3111JYH054038o2zxq/n0xiyt86C8GV4K+6AUIJzHx1ETWD9JUr9gGIz2AHayKlOXOe
	XFNiB2SKnAA8j528mh0ecxCSZhBMFxrDX0QtWMcQSF4JxME9ret19H+Wi3JoYVvQEEdFv5LCON3Wm
	+YiSjqEBvYgrekY8W/fV3dTIr6xltGI4r7xFUQ1G/cNWEGcYP/jVWvwBQLtdAqxMCjkDQlTKKa5JA
	uHBcZMWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIQrw-00000009EAp-0g9R;
	Tue, 03 Dec 2024 11:15:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIQgT-00000009BWe-3Xiq
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 11:03:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6ABC85C6C1D;
	Tue,  3 Dec 2024 11:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ABDC4CED8;
	Tue,  3 Dec 2024 11:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733223793;
	bh=q/4EU0cRrWIkiXqk0dXjd/z6g01ABRxjlms3ls0l7Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8+tvnuDWzrdv6nX1+0K5gUflaSUsyw7zHJ2DB68r6ua03EW8McGybZmD/3t9kZAY
	 o0QMxtm5NRwqrEho95sRnrzWaA0QWz1bCMYUyzqhhhjNN8E+hieTpBaUVa9VlHIUEl
	 CnSY7XwWBh/Z+OA3/xG9vW1sPDjmZBp2nxGG4yecKWhSDw1pGcMDKuxcl7S3sA9u8A
	 mgLmK28X/ilhqHG0B8XFAS+mAcSatBSxHlTJpP0FNIyV9Q7YWvNwqmvLCj55gCOtlX
	 yJeknhBIQNAyvkazOwzjBJU0W09Jf3oHCvI0I33ufIDM2uzqCXouk365zR7EkaQJeS
	 5NQZFjaOUZEXw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 08/10] nvme-fabrics: reset admin connection for secure concatenation
Date: Tue,  3 Dec 2024 12:02:36 +0100
Message-Id: <20241203110238.128630-10-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241203110238.128630-1-hare@kernel.org>
References: <20241203110238.128630-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_030313_914982_4E3B083D 
X-CRM114-Status: GOOD (  12.58  )
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

When secure concatenation is requested the connection needs to be
reset to enable TLS encryption on the new cnnection.
That implies that the original connection used for the DH-CHAP
negotiation really shouldn't be used, and we should reset as soon
as the DH-CHAP negotiation has succeeded on the admin queue.

Based on an idea from Sagi.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9268c6f2c99f..3ce5cfe8a135 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2260,6 +2260,16 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
+	if (ctrl->opts && ctrl->opts->concat && !ctrl->tls_pskid) {
+		/* See comments for nvme_tcp_key_revoke_needed() */
+		dev_dbg(ctrl->device, "restart admin queue for secure concatenation\n");
+		nvme_stop_keep_alive(ctrl);
+		nvme_tcp_teardown_admin_queue(ctrl, false);
+		ret = nvme_tcp_configure_admin_queue(ctrl, false);
+		if (ret)
+			return ret;
+	}
+
 	if (ctrl->icdoff) {
 		ret = -EOPNOTSUPP;
 		dev_err(ctrl->device, "icdoff is not supported!\n");
-- 
2.35.3


