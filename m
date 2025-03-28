Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB13AC36014
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 19:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mTopFJvlk34hyUN56gjPiK5ncmjWmYtuhJkCrhP6gA8=; b=s9SKK0We0YgQHRPYEtAwW191y0
	JIHfL1ARmj6CYqvHQO56qslKrXTsx12bLK68ZzauEKGm573SR0TYSXam9jz9a/SvF4VF5q9BSfehf
	wDl5FEys87zm9P1P3RDEGrBa9817wSEagdOzxALkuv5HFeQ1n98GqGUy/vd8JM3KcRTWF3mSHlIU3
	3bEUIHYYerUVF9S8SSPY5VjuEF3+WsC8IWeyrt/Bl2JVl6VCWA9i0H7IncWHAlvZtPdH1eu1zS+Ca
	Q0HxtsvHY5T81gcOOTCIeJefvSygnA+553A2g75ZxsQNY3EKT/CB0ZwCML1mvM4KcxdzyzeSk1whP
	qLF0vsmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyFZF-0000000EBmd-1Dn8;
	Fri, 28 Mar 2025 19:40:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyFXW-0000000EBQo-21e2
	for linux-nvme@bombadil.infradead.org;
	Fri, 28 Mar 2025 19:38:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=mTopFJvlk34hyUN56gjPiK5ncmjWmYtuhJkCrhP6gA8=; b=Ek1sy3JVTrR8ysArw1sGCocR6j
	zoZnElNwQZ1DqUu2gjt+54Vg/PnSXuWOq7o+2kZ60I+RkhMLnLxe5ZIMheFa21TrZBqhb+d4z6mCp
	JfpRw7dG2y6ASb4QQHT2wGxIFedpaI7hK8Nogn8wfDe8JN1MbgdKEjBeLvrpEatFxT+UWlta+4AMQ
	oygCM6T/AjcVZJQR9LdwV46pPc6/q1IgoJrg2Q1zBjoChXkA4U754Yd4ns5psGEpVqXmaxVoy3J0x
	8OCOhvJI5Yn14cLW6jIo5b+EAD9n+AHWju6RRsWvmM3nNx55cs9rEXMDmxRfa049Lpymo8eeGT/NU
	u5ZXywPg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyFXR-00000006E4X-3A5u
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 19:38:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743190723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTopFJvlk34hyUN56gjPiK5ncmjWmYtuhJkCrhP6gA8=;
	b=NvIxdtliFS+lCavESvGMWbxuiyidCkenjICGsmoA+SyMiS3saGezLADz7qdnDVMXVJpTx0
	btABa5cGTt8Av/KddYjCFo12SvzucJNP9xkMFpgOiGyrBtzfIUe9oe2HcwDXjjuAHA89Dq
	+06Ev08hNnivTJB7Q5axzj2KW/JwcXs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743190723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTopFJvlk34hyUN56gjPiK5ncmjWmYtuhJkCrhP6gA8=;
	b=NvIxdtliFS+lCavESvGMWbxuiyidCkenjICGsmoA+SyMiS3saGezLADz7qdnDVMXVJpTx0
	btABa5cGTt8Av/KddYjCFo12SvzucJNP9xkMFpgOiGyrBtzfIUe9oe2HcwDXjjuAHA89Dq
	+06Ev08hNnivTJB7Q5axzj2KW/JwcXs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-S3yrDD4UONOd5OGQtyVauA-1; Fri,
 28 Mar 2025 15:38:39 -0400
X-MC-Unique: S3yrDD4UONOd5OGQtyVauA-1
X-Mimecast-MFC-AGG-ID: S3yrDD4UONOd5OGQtyVauA_1743190718
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA96A1945103;
	Fri, 28 Mar 2025 19:38:38 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.17.17.223])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF2391828A92;
	Fri, 28 Mar 2025 19:38:36 +0000 (UTC)
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
Subject: [PATCH v3 3/5] nvme: add the NVME_ENABLE_MULTIPATH_PARAM config option
Date: Fri, 28 Mar 2025 15:38:24 -0400
Message-ID: <20250328193826.356257-4-jmeneghi@redhat.com>
In-Reply-To: <20250328193826.356257-1-jmeneghi@redhat.com>
References: <20250328193826.356257-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_193845_982694_5DD27C2E 
X-CRM114-Status: GOOD (  10.92  )
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

The CONFIG_NVME_ENABLE_MULTIPATH_PARAM option controls the
core_nvme.multipath parameter. When CONFIG_NVME_ENABLE_MULTIPATH_PARAM=n
the multipath parameter is removed from the kernel and nvme multipathing
is permanently enabled.  When CONFIG_NVME_ENABLE_MULTIPATH_PARAM=y the
nvme multipath parameter is added to the kernel and nvme multipath
support is controlled by the core_nvme.multipath parameter.

By default CONFIG_NVME_ENABLE_MULTIPATH_PARAM=y

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Tested-by: John Meneghini <jmeneghi@redhat.com>
Reviewed-by: Bryan Gurney <bgurney@redhat.com>
---
 drivers/nvme/host/Kconfig     | 11 +++++++++++
 drivers/nvme/host/multipath.c |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index d47dfa80fb95..8c04b6b93982 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -28,6 +28,17 @@ config NVME_MULTIPATH
 
 	  If unsure, say Y.
 
+config NVME_ENABLE_MULTIPATH_PARAM
+	bool "NVMe enable multipath param"
+	depends on NVME_CORE && NVME_MULTIPATH
+	default y
+	help
+	  This option enables the core_nvme.multipath parameter.
+	  If this option is disabled the core_nvme.multipath parameter
+	  is excluded from the kernel.
+
+	  If unsure, say Y.
+
 config NVME_VERBOSE_ERRORS
 	bool "NVMe verbose error reporting"
 	depends on NVME_CORE
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6b12ca80aa27..83084093e8db 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -10,9 +10,11 @@
 #include "nvme.h"
 
 bool multipath = true;
+#ifdef CONFIG_NVME_ENABLE_MULTIPATH_PARAM
 module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
+#endif
 
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
-- 
2.48.1


