Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A327C19F32
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 03:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BE/DQRlr1UZMYjXT2iLkw402U/iU1veOuNJ4jK09ueU=; b=sa53q9uVyvd6c2ap24WGBlKR6y
	Uo/WNu4fBOzARcO30259T2AYILCwyFHED+zvilgIDENfUne/U7E7up+xNt3wXbHqePXtjs+6yxsfA
	Ziu0/GqFUzg6JCkuySAgil7AhOsAklQLGGhCwtfm7dEBUSXIISTGAjn1M4TIiGxW/5PFJXmqmA9M9
	ge6khTfEmfVhuWbF86ZsrQ8FGQ2iH+RJID0/XeNP+C6CdqAKrphEvtSU2Y5Q6zREKRCCTXp7rS1S2
	jhyFss3CNWiB8ztVdmwZ9MC++4maiiuCZEEoWMjFaraqngmBfqzOWYSI+RmWJq3UeuiyxbbeEgz4u
	5rT1uoIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnr0x-00000009ZVF-1YZX;
	Fri, 28 Feb 2025 03:26:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnr0t-00000009ZSv-3erN
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 03:26:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740713171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BE/DQRlr1UZMYjXT2iLkw402U/iU1veOuNJ4jK09ueU=;
	b=MVOWSdi1l5SWc6RUeeAOCzjFWzrMhXM2HLqOiAz0mH+Prt2thht8/Q4MFvDqouu0iYZUhY
	GBfqR2E980ETPebtDalCsPmDZCtBw/7VfMfxD14G8rQuvpfecS1rnxT7oS8ShgvczlPceU
	0r5aoXRI7JRk9pDO8HHRBTgoXDLWq0E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-jEL8Oe1TNe2t2kg3JLj7rQ-1; Thu,
 27 Feb 2025 22:25:58 -0500
X-MC-Unique: jEL8Oe1TNe2t2kg3JLj7rQ-1
X-Mimecast-MFC-AGG-ID: jEL8Oe1TNe2t2kg3JLj7rQ_1740713157
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4429C18011E4;
	Fri, 28 Feb 2025 03:25:57 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.88.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B4BC18009AE;
	Fri, 28 Feb 2025 03:25:53 +0000 (UTC)
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
Subject: [PATCH 2/4] nvme-multipath: add the NVME_MULTIPATH_PARAM config option
Date: Thu, 27 Feb 2025 22:25:39 -0500
Message-ID: <20250228032541.369804-3-jmeneghi@redhat.com>
In-Reply-To: <20250228032541.369804-1-jmeneghi@redhat.com>
References: <20250228032541.369804-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_192611_978265_82A2B50F 
X-CRM114-Status: GOOD (  12.72  )
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

The NVME_MULTIPATH_PARAM option controls the core.nvme_multipath module
parameter. When NVME_MULTIPATH_PARAM=n the multipath parameter is removed
and core nvme multipathing is enabled. When NVME_MULTIPATH_PARAM=y
the multipath parameter is added and multipath support becomes
configurable with the core.nvme_multipath parameter.

By default NVME_MULTIPATH_PARAM=y

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/Kconfig     | 15 +++++++++++++++
 drivers/nvme/host/multipath.c |  3 ++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 91b0346ce65a..c4251504f201 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -28,6 +28,21 @@ config NVME_MULTIPATH
 
 	  If unsure, say Y.
 
+config NVME_MULTIPATH_PARAM
+	bool "NVMe multipath param"
+	depends on NVME_CORE && NVME_MULTIPATH
+	help
+	  This option enables configurable support for multipath access with
+	  NVMe subsystems. If this option is enabled NVMe multipath support is
+	  configured by the nvme core module parameter named "multipath". If
+	  this option is disabled the nvme core module "multipath" parameter
+	  is removed and support for NVMe multipath access can not be
+	  configured. When this option is disabled a single /dev/nvmeXnY
+	  device entry will be seen for each NVMe namespace, even if the
+	  namespace is accessible through multiple controllers.
+
+	  If unsure, say Y.
+
 config NVME_VERBOSE_ERRORS
 	bool "NVMe verbose error reporting"
 	depends on NVME_CORE
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2a7635565083..4536ad5fbb82 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -10,10 +10,11 @@
 #include "nvme.h"
 
 bool multipath = true;
+#ifdef NVME_MULTIPATH_PARAM
 module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
-
+#endif
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
-- 
2.48.1


