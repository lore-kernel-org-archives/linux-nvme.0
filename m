Return-Path: <SRS0=wEPw=XB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9753C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 18:13:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B85214DE
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 18:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="usIdsvq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B85214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tXfIFvGWwQJ9v0XPOEBFqIciBCuF4EWmL9vLaCil4Ss=; b=usIdsvq8zH9zRKrzGgTKbPxgq7
	iM5z+gDZWEfavGIXkEvgENxFvY0oCiqZpuXwGiKP3LWuJlQ3xUgzdP5H9p8nvJaY5j+2DfhTc1tn3
	9Fo87guJRn8sNIpIMmAoAXToCvP6TWnPjsAErKUFkneDC6f0DPnTKlyo69M9fsnPhmFO6ytqa0c/e
	bmFDXyUwVQ9SjSZwDKJOyCrjZPBHRn55STuJFzRaI0cbnh1oKo5h3Yb/5XoNJP/VGxyYd+txCxm2j
	FYPYF68rQlpzrsoxpAb12cdseXZRQR1X+R49lAtb98NmfjPAnl14tTYfY6F/LonoeOmPYET/A8iSm
	4S7Pm/gQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i6Ijc-0002HC-6e; Fri, 06 Sep 2019 18:13:24 +0000
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d]
 (helo=sagi-Latitude-E7470.lbits)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1i6Iiq-0001O2-UL; Fri, 06 Sep 2019 18:12:37 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v5 5/4 nvme-cli] udev: convert the discovery event handler to
 the kernel support
Date: Fri,  6 Sep 2019 11:12:35 -0700
Message-Id: <20190906181235.20365-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190906181235.20365-1-sagi@grimberg.me>
References: <20190906181235.20365-1-sagi@grimberg.me>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The kernel will not send us a specific event for discovery but
rather the AEN result code. So expect NVME_AEN=0x70f002 for
discovery log change events.

Also, we don't get the NVME_CTRL_NAME env var anymore as this is
available from the device $kernel.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules b/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules
index c909fb036d54..cbbebc56ea80 100644
--- a/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules
+++ b/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules
@@ -6,10 +6,12 @@
 #
 
 # Events from persistent discovery controllers or nvme-fc transport events
-ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_EVENT}=="discovery",\
-  ENV{NVME_CTRL_NAME}=="*", ENV{NVME_TRTYPE}=="*", ENV{NVME_TRADDR}=="*", \
+# NVME_AEN:
+#   type 0x2 (NOTICE) info 0xf0 (DISCOVERY_LOG_CHANGE) log-page-id 0x70 (DISCOVERY_LOG_PAGE)
+ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_AEN}=="0x70f002",\
+  ENV{NVME_TRTYPE}=="*", ENV{NVME_TRADDR}=="*", \
   ENV{NVME_TRSVCID}=="*", ENV{NVME_HOST_TRADDR}=="*", \
-  RUN+="/bin/systemctl --no-block start nvmf-connect@--device=$env{NVME_CTRL_NAME}\t--transport=$env{NVME_TRTYPE}\t--traddr=$env{NVME_TRADDR}\t--trsvcid=$env{NVME_TRSVCID}\t--host-traddr=$env{NVME_HOST_TRADDR}.service"
+  RUN+="/bin/systemctl --no-block start nvmf-connect@--device=$kernel\t--transport=$env{NVME_TRTYPE}\t--traddr=$env{NVME_TRADDR}\t--trsvcid=$env{NVME_TRSVCID}\t--host-traddr=$env{NVME_HOST_TRADDR}.service"
 
 # nvme-fc transport generated events (old-style for compatibility)
 ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
