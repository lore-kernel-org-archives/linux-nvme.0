Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BF1C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:34:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF4764EF6
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF4764EF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DL7iOaZ1PRzW93t8QOJDv1ps5CTs4hXjKKElyB8u0CI=; b=MGoQJ10aeJsmDe6HPM1Yx/NxUy
	D4cgTqrR1BOegFPFpuUTr0Ho5I0NDO4LrhjQshdawQTEzElg/knhZXfwV+pWd2aX3Y0q6B2RKLCix
	FQwAyHYI16nFpkudMLyPIrkDLN9OakahskexwFZvgMYpWgTG2GNfmGelolQGle+FDRVdnVKTNhGTZ
	YlT9MFseEcazedUg22gcdG1ASdAIpoJ1pc5K53e9FZ35W17ZFnS1YHdOYHkR8Pa8gPFKKVUcV8Qk2
	M6lnOgas8PlhSIoOB6AnU6dHhFXSuCiSt6CjdeVFgHGm095mu2jBhzMZjVI4VnU2irD3hHlnDGCVG
	tDKSAHpg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHnB5-008csz-Fa; Thu, 04 Mar 2021 12:34:03 +0000
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHn99-008cSr-Ps
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 12:32:08 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 9B4CD24355;
 Thu,  4 Mar 2021 04:20:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9B4CD24355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1614860404;
 bh=v1ezuB3jbcKDskk9u9m7+Qopj32EWapNdSLpPFu+KcQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=a3UAAiNeF20QruQIp2xNvK13/wroPDizp69OrwfhE9EM9NL2RAKwUCii6jSLPqR6K
 60/RHV31mG0Bozq3/dIEzAVjTYdP7VH9lb/kDCS+e1Q4u1LhvNi182l8KJUdVurnKS
 RndkLtFxWQo3W6eDpW2dN0TcBXR5QKNCRqsqcGaw=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Muneendra <muneendra.kumar@broadcom.com>
Subject: [PATCH v8 16/16] scsi: Made changes in Kconfig to select
 BLK_CGROUP_FC_APPID
Date: Thu,  4 Mar 2021 10:57:26 +0530
Message-Id: <1614835646-16217-17-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Added a new config FC_APPID to select BLK_CGROUP_FC_APPID
which Enable support to track FC io Traffic.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>

---
v8:
No change

v7:
Modified the Kconfig comments

v6:
Modified the Kconfig comments

v5:
No change

v4:
Addressed the error reported by kernel test robot

v3:
New patch
---
 drivers/scsi/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 06b87c7f6bab..20aa1536a3ba 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -235,6 +235,19 @@ config SCSI_FC_ATTRS
 	  each attached FiberChannel device to sysfs, say Y.
 	  Otherwise, say N.
 
+config FC_APPID
+	bool "Enable support to track FC I/O Traffic"
+	depends on BLOCK && BLK_CGROUP
+	depends on SCSI
+	select BLK_CGROUP_FC_APPID
+	default y
+	help
+	  If you say Y here, it enables the support to track
+	  FC I/O traffic over fabric. It enables the Fabric and the
+	  storage targets to identify, monitor, and handle FC traffic
+	  based on VM tags by inserting application specific
+	  identification into the FC frame.
+
 config SCSI_ISCSI_ATTRS
 	tristate "iSCSI Transport Attributes"
 	depends on SCSI && NET
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
