Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C73DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 20:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jsiMHNGnwK5aOfnfdJPXvi+L/dETJi4cf0IWcHr0ezM=; b=cet4v+Za1hez5TN7xMYtcsB9RH
	8F4v6SBRkTUWHa2GuIYrU7ISG6U5V/8q6gRJWPAK2oyRVkXV92c47S3fpy8B84OExv54ruz9Np6fB
	GSsqLUVnj3EzQ9fxxnQufqQ5Ps6nACrC7UEi2+THqo13yFqzBldarIZR7ntGV0XFyPNTVYeWFs9bn
	i2iXDtFp3WEga7jEDjrVqaZCokiM8keP6uT7aW0Dn2tIx3+PgzEJWMmZDbXUvSCkLYHl4XD6tYsaD
	ISLkyR/B1fED0nu25JisKnl+N9bUUlU630k9bYRWM3kpgZzl1VqcPaAmX2bEo87RmrkaaemRfFqv4
	gktgNTAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIGRn-004u3a-4G; Thu, 10 Feb 2022 20:53:47 +0000
Received: from alexa-out.qualcomm.com ([129.46.98.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIGRk-004u3B-DQ
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 20:53:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1644526424; x=1676062424;
 h=from:to:cc:subject:date:message-id;
 bh=jsiMHNGnwK5aOfnfdJPXvi+L/dETJi4cf0IWcHr0ezM=;
 b=HUQlz4XTiPquXMMOUbiZoXrE/2yI9XkDoOPRRbLCCpj413+60gHRzn5T
 8qMwa1vitI9fT1azTNWSVZF9wmLo28LLruJAMp6EUL1Qhd4nrfi3xGNj6
 rF2IJHncFbJrGdYkigmyRsokqd7mPxmoVU1cnZaAITzKXicWWKRf3ToOW g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
 by alexa-out.qualcomm.com with ESMTP; 10 Feb 2022 12:53:43 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
 by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA;
 10 Feb 2022 12:53:41 -0800
X-QCInternal: smtphost
Received: from maggarwa.ap.qualcomm.com (HELO nitirawa-linux.qualcomm.com)
 ([10.206.25.176])
 by ironmsg01-blr.qualcomm.com with ESMTP; 11 Feb 2022 02:23:31 +0530
Received: by nitirawa-linux.qualcomm.com (Postfix, from userid 2342877)
 id 5D1903B6F; Fri, 11 Feb 2022 02:23:30 +0530 (IST)
From: Nitin Rawat <quic_nitirawa@quicinc.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>,
 Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Date: Fri, 11 Feb 2022 02:23:28 +0530
Message-Id: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_125344_530043_5D9D24DC 
X-CRM114-Status: UNSURE (   9.61  )
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

Enable quick suspend quirks for Sc7280 platform, where power
to nvme device is removed during suspend-resume process. This
is done to avoid the failure dring resume.

This enables simple suspend path for this platform.

Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---

Change from v2-v3:
* changed if/else condition

---

 drivers/nvme/host/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed6..1dff749 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3034,6 +3034,15 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_SIMPLE_SUSPEND;
 	}

+	if (of_machine_is_compatible("qcom,sc7280")) {
+		/*
+		 * Append quick suspend quirks for sc7280 platforms
+		 * so that simple suspend path is executed for this
+		 * platform to avoid any resume failure.
+		 */
+		return NVME_QUIRK_SIMPLE_SUSPEND;
+	}
+
 	return 0;
 }

--
2.7.4


