Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A587C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KlyMoA/F8P54mwfHTB+37n6dpw4FKEwYFULT2wUGkfU=; b=UTh29LL8VxclGK+wcd7h+smAwg
	/setXAoqa05ET7aOkkQcWLxdd0pakfvyPCx+ARDe9Bw/wx6PO62obEBOAkdiAlHqWjuv7gsBephTr
	B7H+MSJqzbH7ARutALwtgR8IoFFsQoeKPADW9kyn6ivZ2vCA/s0S1bLBjFzA0JjwxDEMffkEUdHxD
	TQoIb0zTDAOBJvOiNWQ/7QmOmP9bO2fWaP0JfT8DYANgBBxx/5Bri/1tOvHXtq8RWZ6y5wAdcGK+W
	cy5ckuIes0U8OmqW9nwOi7yjN63CXalLU+UrlKy/JeUABpgmhs6L5qmcwWlL30vn/0EsiWeDe22uk
	D4nkPubA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kun-0079Gp-01; Tue, 21 Jun 2022 20:56:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kpq-0076j2-9u
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:50:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D3911618BF;
	Tue, 21 Jun 2022 20:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE0EC341C4;
	Tue, 21 Jun 2022 20:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844653;
	bh=27H04Xa7RUasluHV4FQZNrDJjyArwUaxGVE6ViV4Bog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AVMqPiqpkLEb9Zr0jwH47KrjRIJwGdl+lGKnPSljnqJoTTdbycI5xgdaIvIUnD2fb
	 bpT7X0Suk2FZ+YOdj0UszUqkhwNMlDQ6LcwzruRxjmBM04MGee57Pf2oph27wWO2LK
	 rIB6usHIPk6PY/nzguV6iSqNHjHrWGoCIxccuFFxoj5qkWeVzQONUfzYDEKREBtSgm
	 3rXw2mTANf/3TsBuoBfXtdPOgClGleIFPTiJwzW3r1dYDkmddgPGEtLhFvddwxzddh
	 lHd99fywFUh1Fi1opIpAeyx9KBj60EYdqUDMqVd504PfSKVKXXn755Zcx1l4PWGSSr
	 xeCJE7A0x+/zQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 07/17] nvme-pci: phison e12 has bogus namespace ids
Date: Tue, 21 Jun 2022 16:50:30 -0400
Message-Id: <20220621205041.250426-7-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621205041.250426-1-sashal@kernel.org>
References: <20220621205041.250426-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_135054_460078_B33AC853 
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
index 700857af5b79..93d1f12f31bb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3344,6 +3344,8 @@ static const struct pci_device_id nvme_id_table[] = {
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


