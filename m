Return-Path: <SRS0=COHi=LT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CA5C48BC2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jun 2021 05:30:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB54D6140A
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jun 2021 05:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB54D6140A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=i+f7CDFkRGd1LZM/RSb7eLOIgCQzlwEdBNNreBoIjkk=; b=UL0aBp3OU3fvyH
	8Hy3FVNd7vqGFlVfUCvCfYR7334lUO+yir+M8Cjgkn9/xVYRvvtvWjMnzeovmpzWsAHWe2oE9VuXL
	umD+u0xvagp74YG86C7Xj2SD+QtgWf2ieT9SUTqMYS15CGDqRFO7KbfIUGSLccFQYTotqFpo7FaHM
	qSrTax3qUDPp/RLKUIfWJuLFnnFPMboGzNnkrLB/OkugU0aixlMwxXnk/6M7stNFk0WHGbSyV9mVn
	EnRtUDGec//cRa+EMuFFy7iQztQOOXWRzFyXsGTh5nc/tq7ESRuucOKQmGtwMeZnFXBecuqqjUojb
	9sGdRhOlV8NOTkmSFTZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwePi-00HJTE-LB; Fri, 25 Jun 2021 05:30:02 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwePf-00HJSt-5b
 for linux-nvme@lists.infradead.org; Fri, 25 Jun 2021 05:30:00 +0000
Received: from 1-171-95-206.dynamic-ip.hinet.net ([1.171.95.206]
 helo=localhost) by youngberry.canonical.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1lwePW-0003qp-A4; Fri, 25 Jun 2021 05:29:50 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Koba Ko <koba.ko@canonical.com>,
 linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Revert "nvme-pci: use simple suspend when a HMB is enabled"
Date: Fri, 25 Jun 2021 13:29:44 +0800
Message-Id: <20210625052944.4140054-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_222959_255265_DEF0837F 
X-CRM114-Status: GOOD (  11.95  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This reverts commit b97120b15ebd3de51325084136d3b9c3cce656d6.

There are at least two issues introduced by that commit.
Config space becomes inaccessible after s2idle:
[  827.776792] nvme 0000:58:00.0: can't change power state from D3cold to D0 (config space inaccessible)
The NVMe in question is recovered correctly but PCIe ASPM setting is lost as result.

The second one is more severe, the NVMe becomes unreliable and cause the
rootfs unreadable after s2idle.

Since reset DMA is not possible on suspend/resume, revert the commit to
solve the regression.

Cc: Koba Ko <koba.ko@canonical.com>
BugLink: https://bugs.launchpad.net/bugs/1912057
BugLink: https://bugs.launchpad.net/bugs/1927866
Fixes: b97120b15ebd ("nvme-pci: use simple suspend when a HMB is enabled")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/nvme/host/pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc6..72d2121f82068 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3079,15 +3079,9 @@ static int nvme_suspend(struct device *dev)
 	 * the PCI bus layer to put it into D3 in order to take the PCIe link
 	 * down, so as to allow the platform to achieve its minimum low-power
 	 * state (which may not be possible if the link is up).
-	 *
-	 * If a host memory buffer is enabled, shut down the device as the NVMe
-	 * specification allows the device to access the host memory buffer in
-	 * host DRAM from all power states, but hosts will fail access to DRAM
-	 * during S3.
 	 */
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
-	    ndev->nr_host_mem_descs ||
 	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
 		return nvme_disable_prepare_reset(ndev, true);
 
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
