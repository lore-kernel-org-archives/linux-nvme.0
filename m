Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D67EC8742
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Sep 2023 18:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QWmWOHF2kStxZNUk4MazgA7GlrOHMD+B76AIe95Nk4U=; b=om/NJNMsV8aO3uUEGR1A4arz3Z
	VeThWM+p6NMQ8fvGt0KgN8Tmh6m0qQ0Hgz6W+/ZdrIg8xe3OcOZvcyA3ScuU9h1TLyIogSVY9uLFV
	+Gk+V918RTyO3Tq70VN+GiRSoPUt4qEMycWbSEBJOs2LYVzVVVRjJBgNE09wXwsZuss2c8/kZnipz
	leHxdyqjLL512FK5H33xo+pPPSU2byFrVIgPZAADmsF2+CXIqfCSteoPpwPZVFYKjHQQO+NrWZtOU
	c6D1YVwxlY5vmy2MpH3Ni6d20DeS1SHWhZJDcOc8/uGywSpPf4tOQwvssoByGJ4JomNsDXpT/eHuG
	FH8P1JrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeJrQ-00CYlc-32;
	Thu, 07 Sep 2023 18:36:12 +0000
Received: from mail.archlinux.org ([2a01:4f9:c010:3052::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeJrO-00CYkr-0V
	for linux-nvme@lists.infradead.org;
	Thu, 07 Sep 2023 18:36:11 +0000
From: Felix Yan <felixonmars@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1694111768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QWmWOHF2kStxZNUk4MazgA7GlrOHMD+B76AIe95Nk4U=;
	b=MNm2Ub3uQ8Dh+Q7+p5ak587lyDFZChGVD/r6xxCMFLbkV8grzNDkuFWpqVS7pe7iFUQQuZ
	glVtyuvagCsQtES2k3N0+axxVxwgcxtrvPOZsSwr7Ykpwpt2SLovmb0SVKrz7WyZtKmKK9
	hzudGKVsh6jdep2qfZLnAWV6nmQXAGNquaeKaSplTDGrIrLXxQD5dhQlkO8s483GHlKNY9
	/zCsTZoi8ewZKkyyzXyIJs7k930KZcgegCPdHsQ4/Q2Q7UrPa4ZKQl905IPRj/vHU/AYJR
	EQi2DD6XXDWRFyDJ0tMikPhiciF3KC3IUxu6VAcOGP3tOcMwYNBhmY/QODPpodV0vdbTyU
	AnnNKWAkPonqPozjv0w8ljsLf9gRRkbtyVYb6o+Zh7IlFlle/La94/hDU3DDR9s7hSrAdf
	Ipc9pJXKTMg4b/yqgCu8UlxZYEdjh4+p7D+UDAhOsPdmB8CQeeylw0u09A7eoNWVZJ3EM2
	CQyW+pBeOl5rowOxNx+OyBtOeNkALlUB9nDU1VvWtWcB9Iqw54uJl39fcsakENYCu1WPXX
	Iqv9jika61cKHcMkToK0U9hRbRbB6K7yaAPA+qixsUqyeCBflzTkXE7WXszDWJB595dw5x
	q9M0fWWExeXlxXaPJM2guDsb0FmzAtqPGYWyroo2WKCD9liq6do7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1694111768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QWmWOHF2kStxZNUk4MazgA7GlrOHMD+B76AIe95Nk4U=;
	b=I9aqoA3LjIEgdySzT9RTa6FTPMoSoJ9SfNi2CqzBdI0GH1rJEG/HuEKnvBQ7UzqXyin81G
	IuiNYpSkxHX+NuCA==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=felixonmars smtp.mailfrom=felixonmars@archlinux.org
To: kbusch@kernel.org,
	highenthalpyh@gmail.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: xuwd1@hotmail.com,
	Felix Yan <felixonmars@archlinux.org>
Subject: [PATCH v2] nvme-pci: add NVME_QUIRK_DELAY_BEFORE_CHK_RDY for MAXIO MAP1602
Date: Thu,  7 Sep 2023 21:36:05 +0300
Message-ID: <20230907183605.631347-1-felixonmars@archlinux.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_113610_344643_D62F3A66 
X-CRM114-Status: GOOD (  13.64  )
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

4TB SSD with MAXIO MAP1602 controller cannot by initialized
in nvme_enable_ctrl with a high probability, which causes the system
to be unable to use SSD, and SSD device only be shown in lspci.

dmesg output of problem

----------
nvme nvme1: Device not ready; aborting initialisation, CSTS=0x0
----------

Problem and fix are verified with my MAP1602 controller SSD device.

Applying the NVME_QUIRK_DELAY_BEFORE_CHK_RDY quirk to nvme_enable_ctrl
too as the quirk name actually matches what is being done there. If this
should be a different quirk, please let me know and I'll adapt.

Adding also Lexar NM790 and AIGO P7000Z with the same controller
but has their vendored pci device ids.

Signed-off-by: Felix Yan <felixonmars@archlinux.org>
---
 drivers/nvme/host/core.c | 2 ++
 drivers/nvme/host/pci.c  | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3a01b79148c..dea1749d40dc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2281,6 +2281,8 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
 		return ret;
+	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
+		msleep(NVME_QUIRK_DELAY_AMOUNT);
 	return nvme_wait_ready(ctrl, NVME_CSTS_RDY, NVME_CSTS_RDY,
 			       (timeout + 1) / 2, "initialisation");
 }
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2f57da12d983..fe02593c48d0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3439,7 +3439,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1602),   /* MAXIO MAP1602 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_BOGUS_NID |
+				NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
@@ -3457,6 +3458,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
 		.driver_data = NVME_QUIRK_BOGUS_NID |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1d97, 0x1602), /* Lexar NM790, AIGO P7000Z */
+		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x10ec, 0x5763), /* TEAMGROUP T-FORCE CARDEA ZERO Z330 SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4b, 0x1602), /* HS-SSD-FUTURE 2048G  */
-- 
2.42.0


