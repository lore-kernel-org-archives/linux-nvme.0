Return-Path: <SRS0=6Pwq=ZV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC9CC432C0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2019 00:28:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1184208E4
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2019 00:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hk6tkJBp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HfXpRiJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1184208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qeKBtmRrrv2/a+lHVsKlDmO6hA+0hxXqDLf+RVJIq4I=; b=Hk6tkJBp5gHxl6
	ZJG2HnXTZ0AhCL1pXeAXZ2XvRKlec54ebsqhPDYZC2RJIuDHaABQP36UEv9NbN/yKwP93AOleHDCL
	PiE9ubNcBl/vzaax/PTBhd0bSQa7CXLNJ2CUvAtWmvlYKXx1vzwtOdCl7pW7/84DGmfSSiNYHFSHW
	txofVjH1k8Bt6AjPnLVG7LfdfC0+e6C2bV/i0HusKtuqEwKOprUMnG3+EvJVvzk4taJJAi+O24oa2
	AIp1bupBJYSbq8k24cJIcGxxsszU+Ta5qeFV99oiYJOws6y1ifGZzeJdGQiXoOQr5q6Vv7NX8HPwk
	Sl4BVZ+nxKRxwfFQICgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iaU91-0000Au-Cb; Fri, 29 Nov 2019 00:28:23 +0000
Received: from smtp-fw-4101.amazon.com ([72.21.198.25])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaU8y-0000AR-Dr
 for linux-nvme@lists.infradead.org; Fri, 29 Nov 2019 00:28:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1574987301; x=1606523301;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=a7f32fXCkof522HiPqK6fsE+My19udIte4x55hAbjnA=;
 b=HfXpRiJSWMgGDnCG09d7cDDPFSXILTA5h4MUwpe7EfHUFrEGCK9GvFiV
 GOKUM1cVgx76LCgEn8SbowWuEIKoyz0AMD/umE/bRunQf+t/EICGzgKU9
 Tu5DjgQAp7RPdGdtXu/e48pryl5+FOgaEkv8xCqPVjsptKMF0Dzm+xbfr Q=;
IronPort-SDR: 7/EzmWUdm1qRGJWMxSosYKyrelAcEQG3WsSmdp8jwH3QPTLZ6I7FwznNGb/SiBlI5QoKGDMhAj
 EJeELVkw5CUQ==
X-IronPort-AV: E=Sophos;i="5.69,255,1571702400"; 
   d="scan'208";a="6225819"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.124.125.6])
 by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP;
 29 Nov 2019 00:28:11 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
 by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS
 id 7396CA2A54; Fri, 29 Nov 2019 00:28:09 +0000 (UTC)
Received: from EX13D11UWC002.ant.amazon.com (10.43.162.174) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Nov 2019 00:28:08 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D11UWC002.ant.amazon.com (10.43.162.174) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Nov 2019 00:28:08 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 29 Nov 2019 00:28:08 +0000
From: Balbir Singh <sblbir@amazon.com>
To: <linux-nvme@lists.infradead.org>
Subject: [RFC][PATCH] nvme/core: Notify udev about capacity change
Date: Fri, 29 Nov 2019 00:27:46 +0000
Message-ID: <20191129002746.6622-1-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.5
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191128_162820_603408_95CFF2FC 
X-CRM114-Status: UNSURE (   8.74  )
X-CRM114-Notice: Please train this message.
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
 Someswarudu Sangaraju <ssomesh@amazon.com>, Keith Busch <kbusch@kernel.org>,
 Balbir Singh <sblbir@amazon.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Someswarudu Sangaraju <ssomesh@amazon.com>

NVME capacity can change asynchronously via NVME_AER_NOTICE_NS_CHANGED
The current stack does the right thing and resizes the disk via
set_capacity() called from nvme_update_disk_info(). This patch adds
a user space notification via uevent to let udev know that a resize
occurred if the capacity changes.

Signed-off-by: Someswarudu Sangaraju <ssomesh@amazon.com>
[Balbir - send the notification only on capacity change and wrote the
changelog]
Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfe37a525f3a..a413aee3107d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1757,6 +1757,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	sector_t capacity = nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
+	sector_t old_capacity = get_capacity(disk);
 	unsigned short bs = 1 << ns->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt;
 
@@ -1807,6 +1808,11 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		capacity = 0;
 
 	set_capacity(disk, capacity);
+	if (old_capacity != capacity) {
+		char *envp[] = { "RESIZE=1", NULL };
+
+		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
+	}
 
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
-- 
2.16.5


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
