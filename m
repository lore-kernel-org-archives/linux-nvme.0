Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341B1CCF9E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Oct 2025 15:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EFIZQeJR5FSynCcyHYl/Lkvd3eAJSCdZBiYgYe5IDRw=; b=U9ReIYAkOrhJgEheezR2pU5JGi
	n67mlxDmVjnCadAiQVX2hQGBQepRgn4uWzjYxreJvKPNu0Tsgu/p/KcAjm7x0CguWuVI7YSNRTDQg
	XKyFyCsMZPEkZDFw35Gzr7DznSB9kCwMjYJzlnUdukgDupD0u4zaHJPIs4zbwPgw1IA4i3noLRAiI
	UzeVWP0OJz8jKvxQUAsl8CXcfrHErhy3ic+cmRIpEEJRhFisRuWf0Yb1kRFgibWx0PhDEcAqHIdAp
	s95gRPRfjiVp/WmTORCtnhmImXbv0UCdJRqvxRvOv+GrWeQtzB5SXnFJnw5NWBGCE4FYCSCXySfjy
	YYlQMnag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDlap-0000000GAd9-3OUa;
	Tue, 28 Oct 2025 15:26:39 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDlao-0000000GAcg-1zkz
	for linux-nvme@lists.infradead.org;
	Tue, 28 Oct 2025 15:26:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DFCAA603D9;
	Tue, 28 Oct 2025 15:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3768DC4CEFD;
	Tue, 28 Oct 2025 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665197;
	bh=uk4BXDqQZAgKrVvpodOAU8C2ZzT9WsLHCrNjmUbOuuk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zsr5vbNpeCASQVoVA89FzshZNjVQeNybVav7TArfjjGz0NBsdOXD5gZRLvoMafmGW
	 8Fi15S8xgwf8U7jtMi1ALItXHPTidOFf+yXF47MRpLMnhYAIoYRggjxE+klAz9PSxq
	 KVjtyuMkH+HQQa9F5GjpQzyFbC8uaBJduiP3V6IAD3Q40nKl6M2dOYGNl++qwZtveY
	 4ITErAtU3DR3ygX79kq3S1vII4WPmT9BH6Pv42W2j/v1BzjN04K/XZJaf9jWXe9zJT
	 xt04l2UDbf8wJ926UWP119j1yyWi3B3E4W9/RbxneJ76wxeYiYOYDbb7KLl88FK337
	 aVuH0YF2WePzg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Oct 2025 16:26:22 +0100
Subject: [PATCH 3/5] nvmet-fcloop: check all request and response have been
 processed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-nvmet-fcloop-fixes-v1-3-765427148613@kernel.org>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3
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

When the remoteport or the targetport are removed check that there are
no inflight requests or responses.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 5dffcc5becae..4e429a1ea2bd 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1111,8 +1111,10 @@ fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 	rport->nport->rport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
-	if (put_port)
+	if (put_port) {
+		WARN_ON(!list_empty(&rport->ls_list));
 		fcloop_nport_put(rport->nport);
+	}
 }
 
 static void
@@ -1130,8 +1132,10 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 	tport->nport->tport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
-	if (put_port)
+	if (put_port) {
+		WARN_ON(!list_empty(&tport->ls_list));
 		fcloop_nport_put(tport->nport);
+	}
 }
 
 #define	FCLOOP_HW_QUEUES		4

-- 
2.51.0


