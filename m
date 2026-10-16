Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F52CC6B2D
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 03:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AGDNv6DXYCdi1YpS0B//tI0y8MWeq3h9UmAnwKtKtAw=; b=rqzentJFcwdyH70gNEfo78yzRH
	izIo0kdsQXiukJczsJ8p68QWL5Sp4KyearhwX/mH4WQ1184+gZInXv+xt9BUPeIhkTbbG0fsmzGuU
	nK21I9g8jlLba5agGxxE3/YECJgRb6Q8VL4kvphaiG2CJe6XMQWQLzbpY/ChcUNfOI+DfkDyXybt+
	1io9sfUyGWEyIdhK+UG2AFJq3nZmVw8Z9jPbk+ODS1FSRF8XrFZr9COB15EL5NyXygJnjR+G0HF/F
	47Ym3KGTQI5OdCiLHjsqx4h193i51UqXA/NcsgqJM8mCNxhzKcrLe6SuFvn2juXhu6CN4I4N9hoIH
	yvYk77Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHYmz-00000001rmR-0JFt;
	Fri, 16 Oct 2026 03:39:25 +0000
Received: from smtpbgau1.qq.com ([54.206.16.166])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHYmv-00000001rl3-1wC8
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 03:39:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1792121904;
	bh=AGDNv6DXYCdi1YpS0B//tI0y8MWeq3h9UmAnwKtKtAw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Z1owmv3v9aNByffY6gO1tgZkgHNFKRfL1T36LUi5sJunuG4vmCDCoFAl+bsfeaYLW
	 jzdSZBlS7jpi+kY15Ua8IMMX2UvD8RuqfjgtVYB5b3cPz9AormoDTo4uKazl3Eq3/2
	 gD257y1u2IOW6hYp7yW8ODXtP51LHJQUjvoFgykA=
X-QQ-mid: esmtpsz16t1792121888tf237f946
X-QQ-Originating-IP: 6fQ2S3TEPi2t6gERGoZkbAJ10M1tt2OG07DsHcpNjxU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 Oct 2026 11:38:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5942305316129943371
EX-QQ-RecipientCnt: 7
From: Kun An <ankun@uniontech.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hch@lst.de,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Kun An <ankun@uniontech.com>
Subject: [PATCH] nvme-pci: force simple suspend on Inspur NF50
Date: Fri, 16 Oct 2026 11:38:05 +0800
Message-Id: <20261016033805.9978-1-ankun@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: MzMRvi13BjTiLT99NtVfTyXxOBdKLH2ZtaZpEXdas8RSs8ZJtw6UHfzA
	33idxN7xHPJ9p0cj4UMPd8FhUzWF7JuCOIfNuEYGHkfZ/ZJMDcGJ+4zeVndvB+n4KJreram
	CEC5zTbAgwMrAyMDeE84IeB4WuLuvqvx1zumbg/XYBSl9gsvHiB8lUnqep4xcRyQZoknRkD
	8VXpPe7uKypg72uHA5TQHGUqz3W/uLEih6uJ2ZHMEAO8pXQquft4VmJTTBbX1xUzxvpRl1i
	CRmdj8ihXfXG2p5Xo/z+1EhQMzywcFI7EJEjlrBZpydTIbaotNX5kL5S8hI2DLKPjy2xKtk
	Ath18Ueih4/RVHOUcoqHnrQ+wIcjTyEMGq4ZPs59km6r/EhypOGcRBX/cTZnjvl60Xkqvtb
	j45Y+rjqGjaHqcJrb4dac8h50NGOJ6NXWFX7xrMQl7HgUWZ73RUu0krmpA3pzaCEg0baWzp
	c7v7H/Qpbl2ELvMyJCElrcc8ot83QxjW3O8xn3smbA7cL81ORjbc/76A4xzFFpOoAwVG5hD
	qFhAtC1T/OU65lSQz253Ww8SpoWWtPWZM3tXWG5N/eIcpUPRYazH4uiGalwc/Q8/SLb6KO9
	kVWe3cSm2fclzelsGvAzvWdt8brky8prM/HMXoQXIuSTRFSEr1ZlcOBhKXix5T+ptROIQdg
	G6j88ZdKj3EVF6cJjH/02f4TpZUYlxzTtpNveA3usZW5fyqAxM61oBqxo6VgDwxy0RSHTRU
	9zELDDgbjBZEU55I0H7dW9uPclLdGkSaBRcoyITRbxqEEKff+xSQtoPXjpUcIczBP3mfkno
	UWJb0efyJMz3DULpPCFNlgAhEi+ggA0WgxRpP2LzBtz/d6N4tSr5R5F7oMKw1o2UbSA8hBJ
	orc7OZ3CMFTgD5G5/EjiIZb22JaHLy2lKcwurnJoWOH1DmAUzSeDsLBd5jGLnFKOSFEsaa2
	QLtHa/TKZEDrrZ+G5t2mWa3jxpsgesN5NPtzA0+8qVZNSwLVGbMI1gwZUou5sbuCg0VgDrD
	LTJOfxYE7l1Bc340p9Vyk0WinuRkpoabPnovv+2bIpiTlFDazmPVd83GIsMim7Q+DSkRNrC
	Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_203922_157217_F9042801 
X-CRM114-Status: GOOD (  10.62  )
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

The Inspur CP300F3 / NF50 platform loses the PCIe link across S3 and
NVMe resume fails.  Force the simple suspend path for this board.

Signed-off-by: Kun An <ankun@uniontech.com>
---
 drivers/nvme/host/pci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 77317e5d00f9..c24214c92e82 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3664,6 +3664,20 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
 	}
 
+	/*
+	 * On the Inspur CP300F3 / NF50 (Phytium) platform the SoC root complex
+	 * does not keep the PCIe link alive across an S3 (deep) suspend, so an
+	 * NVMe controller that the host-managed suspend path leaves in a
+	 * non-operational power state never comes back after resume (I/O
+	 * timeouts, reset failure, filesystem abort).  The firmware does not
+	 * advertise firmware-managed suspend and the failure reproduces with
+	 * SSDs from different vendors, so key off the board instead of a
+	 * specific device and always take the full shutdown path there.
+	 */
+	if (dmi_match(DMI_BOARD_VENDOR, "Inspur") &&
+	    dmi_match(DMI_BOARD_NAME, "NF50"))
+		return NVME_QUIRK_SIMPLE_SUSPEND;
+
 	/*
 	 * NVMe SSD drops off the PCIe bus after system idle
 	 * for 10 hours on a Lenovo N60z board.
-- 
2.20.1


