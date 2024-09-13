Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D17FA3755
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6y9rD6Dk3tNRV9fyuTVRHShNKs2WzpQhXVBZOLTq17I=; b=tTd3URsmS0SpqeBLoJndSo8IQK
	BjEAORhYES8z04mqyXdRtyMKBDE+QsgH6xWuWUQ1WkHRozt/G6gRdesQY6p55M1pSEoK/qGm59dsh
	43O+BZI8VQiZTSC7i05v2EGRrRo/ytbyQQoDjogjwoqFce+AfdCBst8mgnU/TwFS+iEVw/sCh6ATq
	E5amejbgm1wX1IhLgZiFbGpI3G4anOr5Qp0yIvrj1ZOoRnPTK8ebeeFz3HDneEATAoS/HFab4i2i5
	ET0T4XX+4r/VoPvGBjASpQLyp3IXbaAgxuU5f84chZm8EAy83l5upiHIlw0q7gfuWld0d1yaMIUFh
	3b+AcWzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6bj-0000000G4a2-0X98;
	Fri, 13 Sep 2024 13:45:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6bT-0000000G4WZ-1XpE
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 13:44:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726235090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6y9rD6Dk3tNRV9fyuTVRHShNKs2WzpQhXVBZOLTq17I=;
	b=QQ6t2pzTiVN7FySb2xv9dDEGqfZRbJqf6aFrzUzw2wuA85KdctOoEVq58wJksXtFuSkXvi
	w3AC4l89J64rl/C1yd+NkL95imtLmIi69zOavpLH4nAWtcbM6esLbi3uWpsgAw6g2xJ8FB
	GiOf1Kv6tvZ2ByaS11RbK+KYTqzDGlU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-uGnBkkd6OReQcFErcCXn5Q-1; Fri,
 13 Sep 2024 09:44:46 -0400
X-MC-Unique: uGnBkkd6OReQcFErcCXn5Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F26491955F25;
	Fri, 13 Sep 2024 13:44:44 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.65.135])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1414130001AB;
	Fri, 13 Sep 2024 13:44:42 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: Keith Busch <kbusch@kernel.org>,
	ens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	David Jeffery <djeffery@redhat.com>
Subject: [PATCH 1/4] nvme: use queue's configured timeout not global config value for passthru
Date: Fri, 13 Sep 2024 09:44:27 -0400
Message-ID: <20240913134430.5416-2-djeffery@redhat.com>
In-Reply-To: <20240913134430.5416-1-djeffery@redhat.com>
References: <20240913134430.5416-1-djeffery@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_064451_501368_605C7B87 
X-CRM114-Status: GOOD (  11.15  )
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

The nvme_init_request function overrides a device's timeout value and forces
use of NVME_ADMIN_TIMEOUT or NVME_IO_TIMEOUT. Remove use of these values so
that devices with different transports and characteristics are not forced to
use the same timeout value.

Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 983909a600ad..7ad83d443101 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -708,10 +708,8 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
 		struct nvme_ns *ns = req->q->disk->private_data;
 
 		logging_enabled = ns->head->passthru_err_log_enabled;
-		req->timeout = NVME_IO_TIMEOUT;
 	} else { /* no queuedata implies admin queue */
 		logging_enabled = nr->ctrl->passthru_err_log_enabled;
-		req->timeout = NVME_ADMIN_TIMEOUT;
 	}
 
 	if (!logging_enabled)
-- 
2.46.0


