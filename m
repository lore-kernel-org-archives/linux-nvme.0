Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98E3C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 16:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=34AVyp8D/2rTg5gc6PV5wOhGYBVl0qG8WJ975vzlQOc=; b=FZCUA2N/hoZwohYmed4WMQ34ML
	K9H+3F6hYZA3+lE2TyO7ylAarXeehgFTAkePn50Q3+dIKjPfoofDcibvDUdcCnWsHOlhjNBf5dhKJ
	9zzZXBTwjTdLq0/qHBHvvygtWIwjKrFpNJ10EeGxpGjzxlLiB1nUWbPhXlo/pmFPpeNottuf3XiI8
	1epy5IVF1MvZjV69zBtOiglSPVyYM4ERYT0ONxlQ/2avyUtkNHB+le7iutJ6S24JHuNb2Bg+/7A6Z
	N4oHkgHv+fAXRnFlQB6gWbClnUofVq6BhS40D0NWmo5ySzUj3WrCWvw/TFbTeqNEXiCiH7mt2LsoY
	e9pr58RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nICj7-004QvN-IN; Thu, 10 Feb 2022 16:55:25 +0000
Received: from alexa-out.qualcomm.com ([129.46.98.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nICj4-004Qtr-ES
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 16:55:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1644512122; x=1676048122;
 h=from:to:cc:subject:date:message-id;
 bh=34AVyp8D/2rTg5gc6PV5wOhGYBVl0qG8WJ975vzlQOc=;
 b=dtvLACIWeqkGG2tJYyD2OvMBR53Z/AJ0GqR3IYC6RFDiiU7ecOzU9YiO
 X35qWJB0+x/i9Dv6Fv4yZav3FQgX4rJuBGOXsh/bXYOIZ1eTmzv+v5YBh
 QXbyI7LkiwPVYQPwpGNjwMWg+IOfR4Tqyl0lKRqh2ryR/UFkIc9OjOsmE s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
 by alexa-out.qualcomm.com with ESMTP; 10 Feb 2022 08:55:16 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
 by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA;
 10 Feb 2022 08:55:14 -0800
X-QCInternal: smtphost
Received: from maggarwa.ap.qualcomm.com (HELO nitirawa-linux.qualcomm.com)
 ([10.206.25.176])
 by ironmsg02-blr.qualcomm.com with ESMTP; 10 Feb 2022 22:25:07 +0530
Received: by nitirawa-linux.qualcomm.com (Postfix, from userid 2342877)
 id 739773C37; Thu, 10 Feb 2022 22:25:06 +0530 (IST)
From: Nitin Rawat <quic_nitirawa@quicinc.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>,
 Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH v2] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Date: Thu, 10 Feb 2022 22:25:04 +0530
Message-Id: <1644512104-24035-1-git-send-email-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_085522_536944_D97C5EBF 
X-CRM114-Status: GOOD (  10.23  )
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

Enable quick suspend quirks for Sc7280 platform, where power
to nvme device is removed during suspend-resume process. This
is done to avoid the failure dring resume.

This enables simple suspend path for this platform.

Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---

Change from v1-v2:

*Moving the check condition outside vendor/device check
 to make this platform specific

---
 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed6..fa25d9fab 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3032,6 +3032,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
 		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
 			return NVME_QUIRK_SIMPLE_SUSPEND;
+	} else if (of_machine_is_compatible("qcom,sc7280")) {
+		/*
+		 * Append quick suspend quirks for sc7280 platforms
+		 * so that simple suspend path is executed for this
+		 * platform to avoid any resume failure.
+		 */
+		return NVME_QUIRK_SIMPLE_SUSPEND;
 	}

 	return 0;
--
2.7.4


