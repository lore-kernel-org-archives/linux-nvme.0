Return-Path: <SRS0=M8F8=XG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE30C49ED6
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 23:42:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961A9206CD
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 23:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cqHcYl/9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="UVQl5gcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961A9206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=tdmxF3hj/p3UcSDRiei/qftZiJRxtAGZjEohb4l1GtY=; b=cqH
	cYl/9oLwet71vNT/odUdlwf2gtjuQXd0ZwiAmT3TVYG6MC2ooX3Q4m8/jPQw5JpFPEjeYRj92c/bX
	3g2uagrZ7TUyFNNU3ijiOACVHBZay30gNvo5j1US2dU/fMjDEUkKe9tYgncfrTMgLLuQYDGn4vQ48
	HmgurV2GBCrksa2gJqX7CIYG4wEOs2A0SHPy8rVxJx7OOR35HHaJaYCD4jlBSdZrZcApDMhT9eHm7
	QuTiSq3/NCIKuZu38PljeVi3yS6glw4McnPeuPTKteaFKHWSEvnJ7yBjV4TGryKdh9dDHA3lLKhdR
	NVv74NjrY3DOzL5zMVDX2m6eHzasXEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8CG4-0000sb-1U; Wed, 11 Sep 2019 23:42:44 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8CG0-0000rl-Cd
 for linux-nvme@lists.infradead.org; Wed, 11 Sep 2019 23:42:41 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x8BNOiG0000446
 for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2019 19:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=UsdcHnQerIrW+zZqSKECSoY4BuSb3CSM/ugV5iEKsw0=;
 b=UVQl5gcLz6ymaGVbL6BTtQXCJbdXxJJPPJ0USpoAPSlOM04p2K1UVvt27ZaCrhp0f0nM
 gMPZ79RbDq14s2oRHJhE5ydFp+6fCvYTnbZ4qjMK/RnSiB56teFuZ6tmQZfGy3hFnk/3
 OQCcYI4jQjo7vdLzuOsle4ajTXvAK6orUG2ieLEWR53q2o0cXNW6rzC8IFTw1hWcsFZr
 Pg/4vPEDVsNOVI7duTzcNK/O8R32wRK0WSgDnbxLkA2NrAF9QaJCAGFiuhF2bllkHALM
 W+zuBerkT6R3BGez+RkZxjFQI7svIEEzmgkIWkbkcbr9YRjf460RVuIsBkIK3ZIWExdf 8g== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 2uv748fas0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2019 19:42:36 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x8BNMpiw033872
 for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2019 19:42:35 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com
 [143.166.85.207])
 by mx0b-00154901.pphosted.com with ESMTP id 2uxjdv64b7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2019 19:42:35 -0400
X-LoopCount0: from 10.173.37.27
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; d="scan'208";a="1296789607"
From: Mario Limonciello <mario.limonciello@dell.com>
To: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-pci: Save PCI state before putting drive into deepest
 state
Date: Wed, 11 Sep 2019 18:42:33 -0500
Message-Id: <1568245353-13787-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-11_11:2019-09-11,2019-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxlogscore=586
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1906280000 definitions=main-1909110206
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=720
 spamscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0
 bulkscore=1 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909110206
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190911_164240_552904_95D066A7 
X-CRM114-Status: GOOD (  14.87  )
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
Cc: Crag Wang <Crag.Wang@dell.com>, Sagi Grimberg <sagi@grimberg.me>,
 Mario Limonciello <mario.limonciello@dell.com>, sjg@google.com,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Ryan Hong <Ryan.Hong@Dell.com>,
 Jared Dominguez <jared.dominguez@dell.com>, Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The action of saving the PCI state will cause numerous PCI configuration
space reads which depending upon the vendor implementation may cause
the drive to exit the deepest NVMe state.

In these cases ASPM will typically resolve the PCIe link state and APST
may resolve the NVMe power state.  However it has also been observed
that this register access after quiesced will cause PC10 failure
on some device combinations.

To resolve this, move the PCI state saving to before SetFeatures has been
called.  This has been proven to resolve the issue across a 5000 sample
test on previously failing disk/system combinations.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/nvme/host/pci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 732d5b6..9b3fed4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2894,6 +2894,13 @@ static int nvme_suspend(struct device *dev)
 	if (ret < 0)
 		goto unfreeze;
 
+	/*
+	 * A saved state prevents pci pm from generically controlling the
+	 * device's power. If we're using protocol specific settings, we don't
+	 * want pci interfering.
+	 */
+	pci_save_state(pdev);
+
 	ret = nvme_set_power_state(ctrl, ctrl->npss);
 	if (ret < 0)
 		goto unfreeze;
@@ -2908,12 +2915,6 @@ static int nvme_suspend(struct device *dev)
 		ret = 0;
 		goto unfreeze;
 	}
-	/*
-	 * A saved state prevents pci pm from generically controlling the
-	 * device's power. If we're using protocol specific settings, we don't
-	 * want pci interfering.
-	 */
-	pci_save_state(pdev);
 unfreeze:
 	nvme_unfreeze(ctrl);
 	return ret;
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
