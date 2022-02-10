Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EAFC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 12:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K2aBTgWx9LPBifqZtMRBr5zTaj93/UxFbnz6K+FhbXc=; b=31Zy6jk5sRgncOdOMKpS28Pr0s
	18f+wlQLYfm3LM8070k4mENPYMDRrlRaaohHWpbxU/iLBtceoLLiWjNv5euaEEYbTqftvyQyfU/HN
	2GY8LYHGiuZkgKwt53EofM4suuF6G6WgIHvsB76+++1dLW7L6pWNey1w+70YbsJJfKPYEK+Si9Gzk
	2297YhX9SBIszGXvZUzvUz6wRjjQ+wDtnQr+zn6U8c5ZRpyFESLNof5iTWppV16bCGvn5wvklnRp3
	2IWgNSZRouLJljzWyU0nAAfiKyTkXXv7vg5jMvVRDZ1Wl2YvApYTSUAJtKSKV7Zr6mrNO2ieK7Jzu
	yJCuKXFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nI8S3-003kS9-Fq; Thu, 10 Feb 2022 12:21:31 +0000
Received: from alexa-out.qualcomm.com ([129.46.98.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nI8S0-003kQZ-Pt
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 12:21:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1644495688; x=1676031688;
 h=from:to:cc:subject:date:message-id;
 bh=K2aBTgWx9LPBifqZtMRBr5zTaj93/UxFbnz6K+FhbXc=;
 b=DIEyIstDL0vK0zjORLCFQ4G8535ntxF2Z5cX27md4avVVTQKEMTP1uqy
 k7Jb67Aja/jRd+nwpFXPHquod8/FFnfs24gGyUaov4RastB4chuBSntFU
 GJ0C3AEW7hdHAt/v/xKdas+DzoA99KjuSVNOs3GX0tQaatvob+Q547exf g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
 by alexa-out.qualcomm.com with ESMTP; 10 Feb 2022 04:21:27 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
 by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA;
 10 Feb 2022 04:21:25 -0800
X-QCInternal: smtphost
Received: from maggarwa.ap.qualcomm.com (HELO nitirawa-linux.qualcomm.com)
 ([10.206.25.176])
 by ironmsg01-blr.qualcomm.com with ESMTP; 10 Feb 2022 17:51:19 +0530
Received: by nitirawa-linux.qualcomm.com (Postfix, from userid 2342877)
 id 0E7443C1F; Thu, 10 Feb 2022 17:51:18 +0530 (IST)
From: Nitin Rawat <quic_nitirawa@quicinc.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>,
 Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH v1] nvme/pci: Add quick suspend quirk for Toshiba drive.
Date: Thu, 10 Feb 2022 17:51:16 +0530
Message-Id: <1644495676-8124-1-git-send-email-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_042128_915906_31455235 
X-CRM114-Status: UNSURE (   8.98  )
X-CRM114-Notice: Please train this message.
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

The Toshiba KBG40ZPZ256G SSD is having resume issues on SC7280 platform.
Hence enabling quick suspend quirks for Toshiba KBG40ZPZ256G on sc7280
platform so that nvme device is taken through shutdown path
during resume.

No issue is seen after enabling this quirks.

Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 drivers/nvme/host/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed6..04c5954 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3032,6 +3032,15 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
 		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
 			return NVME_QUIRK_SIMPLE_SUSPEND;
+
+		/*
+		 * Toshiba KBG40ZPZ256G on Sc7280 platform is having NVMe
+		 * Resume issue. Appending quick suspend quirks for sc7280
+		 * platforms so that full NVMe device shutdown path is
+		 * executed during resume.
+		 */
+		if (of_machine_is_compatible("qcom,sc7280"))
+			return NVME_QUIRK_SIMPLE_SUSPEND;
 	}

 	return 0;
--
2.7.4


