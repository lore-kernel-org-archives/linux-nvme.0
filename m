Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3616FC36005
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Mar 2025 23:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=625UNCZM4QGRK3cVKqtvQTiUqdD7+p90TqpeI7OzcGs=; b=knB758JN5vDl9ntLDieInlEfE6
	vTfXY8gG1mSQu35Sv9tM53OBFRE/LIKRxs5TRFXYTnKTcyjQGkVFUqtsXd53INNf84idohLwkqo+h
	XiuiWlg/XtM7yNqBEGnzdw85jiiyXDur1lulf4rbg3L6YrlRLKKlfBMtI///dFXeCGKfyXTX2BC2w
	8GyOyIdeIepFOBljd+gbQkuwJs7CfOgEPZsJyM5z8KXhzz0X5/G3rVWYf30w/DnsEDuA/oy4OCq/e
	2CGjTbvVjj8Rt54ygtj81QomyMWYigFh3s9BJp/prXcFIyJtKRlJJbwUm3a+kW7Z+cjlRqJ8wYuGS
	TbcViswQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tw8H7-00000000RQj-0MoF;
	Sat, 22 Mar 2025 23:29:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tw8H3-00000000RPT-3J6j
	for linux-nvme@lists.infradead.org;
	Sat, 22 Mar 2025 23:29:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742686143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=625UNCZM4QGRK3cVKqtvQTiUqdD7+p90TqpeI7OzcGs=;
	b=LqJQtiQWuQaPnLaJah2gI7XsQZOSnAqTB6wxljQUT1AHFv2YtAvKvtsCA2Zy1fCJPnip3i
	Ep2psevNAwpTzLZtXlPARpxPmJPSRcU1x28MgCWd6E69ZThCH6WLxUk+N6Xce22ZkOfiaf
	j0FyVKZdAkibGV7y58L921VVRHHmu3Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-m2y5PiuGM1ybCcbv38OcJg-1; Sat,
 22 Mar 2025 19:29:02 -0400
X-MC-Unique: m2y5PiuGM1ybCcbv38OcJg-1
X-Mimecast-MFC-AGG-ID: m2y5PiuGM1ybCcbv38OcJg_1742686141
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF630180035C;
	Sat, 22 Mar 2025 23:29:00 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.80.230])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C31AF180A802;
	Sat, 22 Mar 2025 23:28:58 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: loberman@redhat.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	bgurney@redhat.com
Subject: [PATCH v2 1/3] nvme-multipath: change the NVME_MULTIPATH config option
Date: Sat, 22 Mar 2025 19:28:46 -0400
Message-ID: <20250322232848.225140-2-jmeneghi@redhat.com>
In-Reply-To: <20250322232848.225140-1-jmeneghi@redhat.com>
References: <20250322232848.225140-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250322_162905_904049_959A9F4D 
X-CRM114-Status: GOOD (  12.25  )
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

Fix up the NVME_MULTIPATH config description so that
it accurately describes what it does.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Tested-by: John Meneghini <jmeneghi@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/Kconfig | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 10e453b2436e..d47dfa80fb95 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -18,10 +18,15 @@ config NVME_MULTIPATH
 	bool "NVMe multipath support"
 	depends on NVME_CORE
 	help
-	   This option enables support for multipath access to NVMe
-	   subsystems.  If this option is enabled only a single
-	   /dev/nvmeXnY device will show up for each NVMe namespace,
-	   even if it is accessible through multiple controllers.
+	  This option controls support for multipath access to NVMe
+	  subsystems. If this option is enabled support for NVMe multipath
+	  access is included in the kernel. If this option is disabled support
+	  for NVMe multipath access is excluded from the kernel. When this
+	  option is disabled each controller/namespace receives its
+	  own /dev/nvmeXnY device entry and NVMe multipath access is
+	  not supported.
+
+	  If unsure, say Y.
 
 config NVME_VERBOSE_ERRORS
 	bool "NVMe verbose error reporting"
-- 
2.48.1


