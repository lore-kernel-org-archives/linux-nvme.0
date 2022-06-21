Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555A4C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mbOINVv9GCm947xSPnxaCsaAUWgWjB6RUU4gbjBoIDQ=; b=ifwxJy+OXSuGpeE58bIzmBZXMX
	evZ4Jp7J14lwaAqETGRTh1ompjpCdqw/NXdXiM/weeq4Mn73188FuqmqL8OnWne08xvI7md9oHRF7
	zz+9gk1tULNUzwImHqKxFXqXThv0eAjj2m67gsZs3D7ZOVVnhQP3yYl6q0pGVJItTFlkj7f1uhX77
	fGdOK0ZE0ipPNgmyWlAsMJOZrUp/eVlKTBotDA2wrg/pGL72Uy7O4QKleTBYRfpv6dDLTVxrjyvqY
	ol20wqZPTy+mlt92o0zfr13U5MClegapjkX5vnTPrwSij+4VYV6iwKKRYOBYbySZlQwoLbwzALnAm
	cbIpMDPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kp3-0076BG-ON; Tue, 21 Jun 2022 20:50:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3koq-00764q-Cr
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:49:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C78DC61890;
	Tue, 21 Jun 2022 20:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017FBC341C4;
	Tue, 21 Jun 2022 20:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844591;
	bh=r/ki/nn5lDRi/fmgq8xrIpBItw40es9Cpxv7lHYtyd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KGpD27CnziA9dXi+tldVs48JKnS5pGfeQ8z46buKWKYa7eU7BPgpbUcj2agrVMPbh
	 wrgEpMCd9edrZarGiLymkhzKat4lKJGcuX7HCQGIcpmoM295DT0GhZA/y6kqQrOOX+
	 LxcKkuD6xZhObtZ5VTIKueOgum2LVYosKnUOwyHJMgwBUIs9VFm7Wr+B7OOwDbs/J3
	 n7Um5P8mvZOYWYa4U7shC+Fgv1O59ZaKnmULfUv9xGMvNrOYgzGn/G3w1OohP+ZiPx
	 75Rk1YCElWoWGp+7JDs0JjOrPs4ekU/fm1hRsnjKxZjiICwCXMLATvlxXnAzqXILoW
	 7vheTmXbuqpmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.18 09/22] nvme-pci: phison e12 has bogus namespace ids
Date: Tue, 21 Jun 2022 16:49:15 -0400
Message-Id: <20220621204928.249907-9-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621204928.249907-1-sashal@kernel.org>
References: <20220621204928.249907-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_134952_509721_76E3BB82 
X-CRM114-Status: GOOD (  12.05  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 2cf7a77ed5f8903606f4f7833d02d67b08650442 ]

Add the quirk.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216049
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 37a2a88d35c9..a14f204b07c1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3455,6 +3455,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
 				NVME_QUIRK_DISABLE_WRITE_ZEROES|
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1987, 0x5012),	/* Phison E12 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1b4b, 0x1092),	/* Lexar 256 GB SSD */
-- 
2.35.1


