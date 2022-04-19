Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEAAC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Apr 2022 18:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=knORAF0Zbe7cJWKxt2MD6lhqixjOcwP75G6A32fXVWM=; b=JZ13QlI9uNv9qOBYSP2JBVDCbq
	IZVJm++NcW5vLyeI4AOGkSxskN5480QEVgHcpr7LU/Ca8tZULg+gIJ2Q3CruESGS0RAdVgC3W5VD4
	0QiBKijxAuJrSYZd2VZgQt26rBXPuC189S+KEYgYwCsHzMOjt1mqiMFgP4bOUp+GbYMsfeL4iaPEN
	7KB0VLFQOTfAcWRiEHwpkhQ0dqx+xKfMFhgc7DNMpUALGWTedhVh2tYWUaCMGjk7xcQumaaezhmJp
	zC2cEHLqwTuXx/aUhLNdNmgQXr4LzLdapLgaybVjUIA6lOEzL5G2e08usPBXuHjeATJhfZyGBNTSt
	5DQf86YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngsMc-005YY6-TF; Tue, 19 Apr 2022 18:14:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngsL8-005XXy-4H
 for linux-nvme@lists.infradead.org; Tue, 19 Apr 2022 18:12:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1A8C9611E4;
 Tue, 19 Apr 2022 18:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDB4C385AB;
 Tue, 19 Apr 2022 18:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650391956;
 bh=ZCI+Z/fhFeIR7DPzLPNHVclofRd5T2YSEHC7i8xxUkE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SGbHl9EQ9g13fjlrkCCv7uRiTxe67lnlwyt8z7H2R7fI5n11rsxoM5SU75yyor28C
 ykOPY9EFWgUoJAZL9b7lrEjfMuwrz4u/9Hl/BYcr0HCK1E2iW3E/zp8uWfUDNiimQJ
 UEpGd4kxYcKbRi2TEQv1fG5nIL+qb6JF8U/DfzCQDnZaxs3DK1f2CYft9RI598fikU
 vbRvTxDOD9XNvmvOXSQTTtz3lLVeCXZ7TETvwRvGD4wSIBXNGwKJ5qP44PeIFiR7+N
 PpmZywpU21PfOyQBpkou1QMdEivAr8HmtFan/YpLZH+xI1il9nArC2eOPNp1G4KAaY
 6o0jjrgjmP2nQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Sasha Levin <sashal@kernel.org>, axboe@fb.com,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.17 32/34] nvme-pci: disable namespace identifiers
 for Qemu controllers
Date: Tue, 19 Apr 2022 14:10:59 -0400
Message-Id: <20220419181104.484667-32-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419181104.484667-1-sashal@kernel.org>
References: <20220419181104.484667-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220419_111238_317459_92E703E7 
X-CRM114-Status: GOOD (  17.28  )
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 66dd346b84d79fde20832ed691a54f4881eac20d ]

Qemu unconditionally reports a UUID, which depending on the qemu version
is either all-null (which is incorrect but harmless) or contains a single
bit set for all controllers.  In addition it can also optionally report
a eui64 which needs to be manually set.  Disable namespace identifiers
for Qemu controlles entirely even if in some cases they could be set
correctly through manual intervention.

Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6be611f49a45..e4b79bee6206 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3405,7 +3405,10 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS |
-				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+				NVME_QUIRK_DISABLE_WRITE_ZEROES |
+				NVME_QUIRK_BOGUS_NID, },
+	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
-- 
2.35.1


