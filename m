Return-Path: <SRS0=KTZ6=3S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2474FC2D0DB
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2020 15:30:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6306206F0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2020 15:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JiMV4t4p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="ivOD8oT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6306206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UsIfVOvRpfLX6FSQNCi3GMkhOpan08CnAZqGUf1iFgI=; b=JiMV4t4pebsWXZ
	vQs57Kr3ImiANmsv3Dexv6q1h/WGagrOqzopXEmAATI+VkaPWkuSWlZoBD5Y3g2unTiq5B6YQl1Pw
	mrQX4b0A+9//ytMVmmOxKFsIva6He/WTt8hmnm3QUQkHp4h5dnUGzIJI++UtRASxDOWLe38qf8jP0
	lCOe114N5cUKF3IJO2kNcV69iF9f3S74Q1Fre4N3ej8XuXRIlK43xDkSCsfgitQ++yk9Cx22UnG27
	VEA8bdbgxRvxD2U2LfqjNnndfCJgMI/aT72S4KKwTfmoZ1UqIG+VnEgBGz+GhegZzk8IY0zas5QIb
	jCCV/59XZdOi89Uiry+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iwpIJ-0002wk-MV; Wed, 29 Jan 2020 15:30:19 +0000
Received: from mta-02.yadro.com ([89.207.88.252] helo=mta-01.yadro.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwpIF-0002l2-1E
 for linux-nvme@lists.infradead.org; Wed, 29 Jan 2020 15:30:17 +0000
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id EF00547645;
 Wed, 29 Jan 2020 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1580311806; x=1582126207; bh=xeKBFhwWSTTwej2sxwygwuCy4WQRim+mRqk
 7q7AVbHg=; b=ivOD8oT0wqkQfyf7JCqW7gE7dYEncKIpuN+hu/DT/2lENcSfQYc
 hGZVLStWZWiw2pKagoh1VdLmC9/KeVa4dk+f3/X7jsLpxHua3bGcng920eJG9bZH
 JyM3pDXD3WT4el8xczW7NcSy2DSTJOmtpQEP0u5bz9Ewy83p/SJt+GVo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UfTyEeKG9cAF; Wed, 29 Jan 2020 18:30:06 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id A730F47621;
 Wed, 29 Jan 2020 18:29:55 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:55 +0300
From: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linux-pci@vger.kernel.org>
Subject: [PATCH v7 25/26] nvme-pci: Handle movable BARs
Date: Wed, 29 Jan 2020 18:29:36 +0300
Message-ID: <20200129152937.311162-26-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
References: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200129_073015_441174_0C136FEA 
X-CRM114-Status: GOOD (  13.31  )
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
Cc: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
 linux-nvme@lists.infradead.org, linux@yadro.com,
 Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hotplugged devices can affect the existing ones by moving their BARs. The
PCI subsystem will inform the NVME driver about this by invoking the
.rescan_prepare() and .rescan_done() hooks, so the BARs can by re-mapped.

Tested under the "randrw" mode of the fio tool, and when using an NVME
drive as a root filesystem storage. Before the hotplugging:

  % sudo cat /proc/iomem
  ...
                3fe800000000-3fe8007fffff : PCI Bus 0020:0b
                  3fe800000000-3fe8007fffff : PCI Bus 0020:18
                    3fe800000000-3fe8000fffff : 0020:18:00.0
                      3fe800000000-3fe8000fffff : nvme
                      ^^^^^^^^^^^^^^^^^^^^^^^^^
                    3fe800100000-3fe80017ffff : 0020:18:00.0
  ...

Then another NVME drive was hot-added, so BARs of the 0020:18:00.0 are
moved:

  % sudo cat /proc/iomem
    ...
                3fe800000000-3fe800ffffff : PCI Bus 0020:0b
                  3fe800000000-3fe8007fffff : PCI Bus 0020:10
                    3fe800000000-3fe800003fff : 0020:10:00.0
                      3fe800000000-3fe800003fff : nvme
                    3fe800010000-3fe80001ffff : 0020:10:00.0
                  3fe800800000-3fe800ffffff : PCI Bus 0020:18
                    3fe800800000-3fe8008fffff : 0020:18:00.0
                      3fe800800000-3fe8008fffff : nvme
                      ^^^^^^^^^^^^^^^^^^^^^^^^^
                    3fe800900000-3fe80097ffff : 0020:18:00.0
    ...

During the rescanning, both READ and WRITE speeds drop to zero for a while
due to driver's pause, then restore.

Cc: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/nvme/host/pci.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 365a2ddbeaa7..42976c13d3f7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1644,7 +1644,7 @@ static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	if (size <= dev->bar_mapped_size)
+	if (dev->bar && size <= dev->bar_mapped_size)
 		return 0;
 	if (size > pci_resource_len(pdev, 0))
 		return -ENOMEM;
@@ -3049,6 +3049,23 @@ static void nvme_error_resume(struct pci_dev *pdev)
 	flush_work(&dev->ctrl.reset_work);
 }
 
+static void nvme_rescan_prepare(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	nvme_dev_disable(dev, false);
+	nvme_dev_unmap(dev);
+	dev->bar = NULL;
+}
+
+static void nvme_rescan_done(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	nvme_dev_map(dev);
+	nvme_reset_ctrl_sync(&dev->ctrl);
+}
+
 static const struct pci_error_handlers nvme_err_handler = {
 	.error_detected	= nvme_error_detected,
 	.slot_reset	= nvme_slot_reset,
@@ -3126,6 +3143,8 @@ static struct pci_driver nvme_driver = {
 #endif
 	.sriov_configure = pci_sriov_configure_simple,
 	.err_handler	= &nvme_err_handler,
+	.rescan_prepare	= nvme_rescan_prepare,
+	.rescan_done	= nvme_rescan_done,
 };
 
 static int __init nvme_init(void)
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
