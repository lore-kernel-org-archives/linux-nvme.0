Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AB8C36013
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 19:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=625UNCZM4QGRK3cVKqtvQTiUqdD7+p90TqpeI7OzcGs=; b=JinxPg+utKw1IBl5ld1e1JGrdT
	jyJ6XghZntMu3TT2PSNS+vc8ckHPTzmqZLzEyNXVNpFMjNVANTOTwIGeqfoiKfipjkPcTWCwLZK6y
	joBcDaZrQaGt13Mht9Drc8knQKpF69edP+JtX47zVBdwR0jUuO/WGMLOXvlICu9ZdZ/xCRIieNniB
	uSghBatxRWQWRMmPp2PYXKZXzwgap3zPddv4vWyDqPT/R+7KbOOTZ9FP/bTqXciXk/ZTFGp+G9yBM
	BYJDUuefelQOj/Hcj6E3uDNrtGwSfuHGUFeDpMO3Vh4P+QyvY+q827XXExdNYoMQPssSG6LPfaloI
	ikQn9h0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyFZD-0000000EBky-0vIn;
	Fri, 28 Mar 2025 19:40:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyFXU-0000000EBPz-3ug4
	for linux-nvme@bombadil.infradead.org;
	Fri, 28 Mar 2025 19:38:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=625UNCZM4QGRK3cVKqtvQTiUqdD7+p90TqpeI7OzcGs=; b=XPyJbUO2g1SQ3f3CgcQbc5WJ3V
	n+yC8+81KvUI3/1rQ1v2ONP48OdC4Gv46OFZhqyxH8wzoAVxTJcxajW5it7DXog5aqw70ME4LaeSN
	jSpcc5RwZarnI5X5gGDVWZ8RuVTYSzkGz0q72OCJGcnbyGZmXC0yISiTecgOSOAzMPfR3OjGjg18b
	h0GaW4FW814pqVpP8wzJbitvEvnHNxj4mxDBXaIfJn0ugHax/t/akRNxpXItsEQtfGgyqzTKtpNZz
	5NvCA5eDwx7vMjJGIkODYbKItII7g1Is9dmzPWgt1urJ9dHLN03ZKo0qB8FnD9Pj/9ePCDBFkNmJ8
	OU0q/o3w==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyFXQ-00000006E4U-49fT
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 19:38:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743190720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=625UNCZM4QGRK3cVKqtvQTiUqdD7+p90TqpeI7OzcGs=;
	b=VPxa0TlJafzuAFohe2BlFemZ9MGZqZcMiCiUj7fs3WohNwXxujs7PzY8R0DyWAtpCmClEw
	uk2wJ/ABIY8byVhJAD+fimPhBP8ulQJVRbB/tY6IEMIrs5yLC916ckbu0o08D0pg6rGg6v
	yVxDwWuFrax3CBi8dYB4nvpgNpb7JbQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743190721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=625UNCZM4QGRK3cVKqtvQTiUqdD7+p90TqpeI7OzcGs=;
	b=K1VB+/JiL+4x5TFDScIYvll4rj1CFbjBMBjFh+yPogMGNMXkGbkwFprD/Wn8QWSjwQx/aP
	RtMRYZmHRXFCHoipgmZSuQ6tZc3tbxFL7C9XeKPFfoGHB4h7GzEyXdFe4btyDgUAkjE7Be
	OxMGwFnQpTldKSZZesVuLXl6/S1ZDjU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-f6kqXyQSP8K0U4574qwa6w-1; Fri,
 28 Mar 2025 15:38:37 -0400
X-MC-Unique: f6kqXyQSP8K0U4574qwa6w-1
X-Mimecast-MFC-AGG-ID: f6kqXyQSP8K0U4574qwa6w_1743190716
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 983F0180AF52;
	Fri, 28 Mar 2025 19:38:36 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.17.17.223])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C06781828A92;
	Fri, 28 Mar 2025 19:38:34 +0000 (UTC)
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
Subject: [PATCH v3 2/5] nvme: change the NVME_MULTIPATH config option description
Date: Fri, 28 Mar 2025 15:38:23 -0400
Message-ID: <20250328193826.356257-3-jmeneghi@redhat.com>
In-Reply-To: <20250328193826.356257-1-jmeneghi@redhat.com>
References: <20250328193826.356257-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_193845_242129_23F07CC6 
X-CRM114-Status: GOOD (  12.48  )
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


