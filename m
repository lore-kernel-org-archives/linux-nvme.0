Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA37C35FFC
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Mar 2025 23:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=95vARJpK8cN2Fns4HX6JH0We9Ct8sqPV6rO+P5EgzGU=; b=XlwfwpQ2JAik2DO5giXDeV0/XN
	BTHbueuE7RKcTla3+G03novfQk2YUdB8yNr6lDp54vktle6hQIQA2CEPMgHGXh04bdzdh5TeTacwa
	26mNobxhbG6wblI6eFpBtH1S0ShiJMFBfq1MvAiIEY+0W331eYCw8GnD0viorzNBGW/fbKlJHlVbK
	U56n3JEL1eo7BDrpKfHNCTU3zy4oKIMvsnK7YRbNPdhdkRXrgx26VfKj+TjhZ7czRZDl0SPiMrfua
	ht8oJ1IgG2WB3KMplC264491kbUZjq/cusRAfQz0hyG7tjP+NdPNF9y8U1a6t8jTiPlpF3GnuimfC
	mSPwnGVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tw8H9-00000000RRN-14f7;
	Sat, 22 Mar 2025 23:29:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tw8H6-00000000RQ9-1weY
	for linux-nvme@lists.infradead.org;
	Sat, 22 Mar 2025 23:29:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742686147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95vARJpK8cN2Fns4HX6JH0We9Ct8sqPV6rO+P5EgzGU=;
	b=FzMJVALNkCQKvsitzeDVkFULb4j7ugJqgEKAMNOI+eidq+8a2GCDmmgoywcxQE52iKs1rP
	NBFhgEO3LjqQV7mTPI4N6kcZtEQk7TkOzuXqXCYFkCbkRDRGnxl9UIHCX1Pdf0OGmgRmqj
	6voKWKsNb2udGNjCdDhZnf/keKpdSLc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-TgRwl_51OHWc1S5qIG9mQw-1; Sat,
 22 Mar 2025 19:29:04 -0400
X-MC-Unique: TgRwl_51OHWc1S5qIG9mQw-1
X-Mimecast-MFC-AGG-ID: TgRwl_51OHWc1S5qIG9mQw_1742686143
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09EEA195E92A;
	Sat, 22 Mar 2025 23:29:03 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.80.230])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EAD7180A802;
	Sat, 22 Mar 2025 23:29:00 +0000 (UTC)
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
Subject: [PATCH v2 2/3] nvme-multipath: add the NVME_MULTIPATH_PARAM config option
Date: Sat, 22 Mar 2025 19:28:47 -0400
Message-ID: <20250322232848.225140-3-jmeneghi@redhat.com>
In-Reply-To: <20250322232848.225140-1-jmeneghi@redhat.com>
References: <20250322232848.225140-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250322_162908_562333_40E67126 
X-CRM114-Status: GOOD (  12.42  )
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

The new CONFIG_NVME_MULTIPATH_PARAM option controls the core_nvme.multipath
parameter. When CONFIG_NVME_MULTIPATH_PARAM=n the multipath parameter is
removed from the kernel and nvme multipathing is permanently enabled.
When NVME_MULTIPATH_PARAM=y the nvme multipath parameter is added to the
kernel and nvme multipath support is controlled by the
core_nvme.multipath parameter.

By default CONFIG_NVME_MULTIPATH_PARAM=y

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Tested-by: John Meneghini <jmeneghi@redhat.com>
Reviewed-by: Bryan Gurney <bgurney@redhat.com>
---
 drivers/nvme/host/Kconfig     | 13 +++++++++++++
 drivers/nvme/host/multipath.c |  3 ++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index d47dfa80fb95..c8458b10c83f 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -28,6 +28,19 @@ config NVME_MULTIPATH
 
 	  If unsure, say Y.
 
+config NVME_MULTIPATH_PARAM
+	bool "NVMe multipath param"
+	depends on NVME_CORE && NVME_MULTIPATH
+	default y
+	help
+	  This option controls the inclusion of the NVMe core module
+	  "multipath" parameter. If this option is disabled the
+	  nvme_core.multipath parameter is excluded from the kernel.
+	  If this option is enabled the nvme_core.multipath parameter
+	  is included in the kernel.
+
+	  If unsure, say Y.
+
 config NVME_VERBOSE_ERRORS
 	bool "NVMe verbose error reporting"
 	depends on NVME_CORE
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6b12ca80aa27..cad76de2830a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -10,10 +10,11 @@
 #include "nvme.h"
 
 bool multipath = true;
+#ifdef CONFIG_NVME_MULTIPATH_PARAM
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


