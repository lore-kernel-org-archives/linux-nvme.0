Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2946CD3447
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 13:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BVKCLfutJ9Jep2t24jA5cCMSy//+4lcBcY9pGhqGlCc=; b=C1eihJ+4yxzL0K3JtPS2uozOqs
	inKzClRui3VrvzP9v/RNsmXC8HvUmQXL5sbK982LMZoKq7mJzy05+ehmR0aBcr7C9pFb9tKaAx2rV
	BlBNrH5HXejNISms/ZPSS/GDPfKKdxBpzz5WzqhS+7v8gLVpicbxB/j31VbJ/iaVYn//zjii8LAU0
	xNK8TSla4/9bK6g8e30KzCqWlW3U7bDYzZdHonQ3plUYTbJdNlt24mDNUMvCw4OWwk/ztS5ADHpbS
	fyaOA08CBEWF53zGNt0HltjBcWbV9FJsumo9CnneKntpyJ3b2cC8DFht2CQs1R+hZUOl/tMWJPESr
	zMOPoajg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLLLC-00000006Ycp-13re;
	Fri, 08 May 2026 13:34:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLLLA-00000006Ybo-1BoH
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 13:34:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778247243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVKCLfutJ9Jep2t24jA5cCMSy//+4lcBcY9pGhqGlCc=;
	b=cvwhwxgxVvt3jLh93+7Yt8zuEQwoY7oa5r920pp6Z3aMPl6yDXZmWSUQRIJVX4FpVvBxQh
	eStoajazfaxyte5MU11s5wO11grRHevJPNOS4bbPLVSCeCbtRfxwdAike0EHeIlasDBaVq
	ob3fvZVny06bhangDJzy8DNUpyTsajM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-dm5eYXuUPjqOcwmydOVUqQ-1; Fri,
 08 May 2026 09:33:56 -0400
X-MC-Unique: dm5eYXuUPjqOcwmydOVUqQ-1
X-Mimecast-MFC-AGG-ID: dm5eYXuUPjqOcwmydOVUqQ_1778247233
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84C921955F29;
	Fri,  8 May 2026 13:33:53 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.105])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B93B195394A;
	Fri,  8 May 2026 13:33:49 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mheyne@amazon.de,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@arkamax.eu,
	mkhalfella@purestorage.com,
	chaitanyak@nvidia.com,
	hare@kernel.org,
	hch@lst.de
Subject: [PATCH V4 3/9] nvme: fix race condition between connected uevent and STARTED_ONCE flag
Date: Fri,  8 May 2026 15:33:29 +0200
Message-ID: <20260508133335.98612-4-mlombard@redhat.com>
In-Reply-To: <20260508133335.98612-1-mlombard@redhat.com>
References: <20260508133335.98612-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2uCWg07LvmU039NKTUAMtZ2GZd7JthNJg0zS1vcjHIk_1778247233
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_063404_392787_8CF64C89 
X-CRM114-Status: GOOD (  12.20  )
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

When a controller connects, nvme_start_ctrl() emits the
"NVME_EVENT=connected" uevent and sets the NVME_CTRL_STARTED_ONCE flag.
Currently, the uevent is emitted before the flag is set.

This creates a race condition for userspace tools (like udev rules)
that might rely on the "connected" event to configure sysfs attributes.
Specifically, if a udev rule attempts to set the newly introduced
`admin_timeout` attribute immediately after receiving the uevent,
the sysfs store function might evaluate the NVME_CTRL_STARTED_ONCE
bit before it is actually set, resulting in spurious -EBUSY error.

Swap the order of operations in nvme_start_ctrl() so that the
NVME_CTRL_STARTED_ONCE flag is set before the uevent is sent.
This guarantees that the admin_timeout can already be changed
when userspace is notified.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b1bfcd0a0e5b..22be8cf5e982 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5039,8 +5039,8 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 		nvme_mpath_update(ctrl);
 	}
 
-	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
 	set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags);
+	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
 }
 EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
-- 
2.54.0


