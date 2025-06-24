Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF139C7EE31
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jun 2025 19:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aJQ+CfFkA9iAqiCj8E24/Yt4zZ360MbvKSI3hujd2E4=; b=HDsYJHDem3+n0YDA9Rm32KEFPW
	L6uIya7Y90wEk2P0wsYIo4+d+7nnHat2hpCi/BjdgxAq8mFkK5aO1O8tpvNd/UqhKu8tnTEtwulPk
	sn1Q9EgHAt94xrabPxtjhL0ABe2O90FnxfwQEvhROwjwOd2MgnbIAQhFvRxzq+3YksYtNW16NzUs2
	RBSIAOpjpbop1vXNvSKCmy4C+4SydPaG8o0OdxzS4Ss7Lo6Me1/qnGzOJOVbjr41rnjs1BabXtKXf
	+Q4tey4KA1uMbXTLwPUN12KzRjTp6GlLVtfmUX2JAwPCj0k5VfxJQRs8O08xVObTK0oNyJ36A716j
	+VO/si8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU9jj-00000006gFI-1pJF;
	Tue, 24 Jun 2025 19:55:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU6hu-00000006HzC-329y
	for linux-nvme@lists.infradead.org;
	Tue, 24 Jun 2025 16:41:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750783272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aJQ+CfFkA9iAqiCj8E24/Yt4zZ360MbvKSI3hujd2E4=;
	b=AOfMdA1OqxqRTz/atQdz1DUCR8rs0WQlyAvKtrJY298i/DXvzJ7iZ3dMbyvihbX0lJC8wo
	0oktDUVUDnXtCQOjSEwZScCAl6ihzHsdZ0UjxFh9nIOeMii8WPeDzkgq7n82MFAKwUOpQQ
	TU05PqwMGNArHjJZDb/IaXrobtVtWBQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-fPIuYxthPE6RZcRERKC4SA-1; Tue,
 24 Jun 2025 12:39:36 -0400
X-MC-Unique: fPIuYxthPE6RZcRERKC4SA-1
X-Mimecast-MFC-AGG-ID: fPIuYxthPE6RZcRERKC4SA_1750783174
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 488AB19560AF;
	Tue, 24 Jun 2025 16:39:34 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.42.28.215])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E12AE30001B5;
	Tue, 24 Jun 2025 16:39:31 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hare@suse.de,
	mlombard@bsdbackstore.eu
Subject: [PATCH] nvme-tcp: log TLS handshake failures at error level
Date: Tue, 24 Jun 2025 18:39:30 +0200
Message-ID: <20250624163930.104848-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uEqbIzeq2DDfN29zoBhlzTCZm1lnx2S6wvEqfW_BwAM_1750783174
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_094114_839862_3C10CEDF 
X-CRM114-Status: GOOD (  10.46  )
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

Update the nvme_tcp_start_tls() function to use dev_err()
instead of dev_dbg() when a TLS error is detected.
This ensures that handshake failures are visible by default,
aiding in debugging.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/tcp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d924008c3949..26d26823a0c5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1745,9 +1745,11 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			qid, ret);
 		tls_handshake_cancel(queue->sock->sk);
 	} else {
-		dev_dbg(nctrl->device,
-			"queue %d: TLS handshake complete, error %d\n",
-			qid, queue->tls_err);
+		if (queue->tls_err) {
+			dev_err(nctrl->device,
+				"queue %d: TLS handshake complete, error %d\n",
+				qid, queue->tls_err);
+		}
 		ret = queue->tls_err;
 	}
 	return ret;
-- 
2.47.1


