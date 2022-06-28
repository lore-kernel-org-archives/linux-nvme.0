Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585FDC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jun 2022 02:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aHO0/h107Iiqltnsrq0+KOToOzYmPa+19kbKnsng2MM=; b=vsvYyHFtd0LQ33gFZWRkzCW/gz
	PB1EX3Gwl9qZzagJdoC12+SzGUacof+0pia1TDTRdW+kh1K+IHuDuHeKMUOyRpEht2PpXm/6RxiGi
	OxA2M7MBiJnk/ncvrC04mXrFC3qSMJCJ1QMQmZU6j4/5/8ZVUhHnJUx1exoe5ZnCEtD89s/D5JISW
	cltro4j+T4+L7kPAb4VQzsWIQVT6G82RMytjNqSBcDjsPsWlVwbU012hwCUQuEi1iByPayyNYAfpG
	AuQ8mENiyemakMhwrCY5TcgxkpemlodJxssdbUOjTgUt6nJfhSi8lwhGFABgJCXcRrsd1T0fv8+gD
	7pWxvSkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o615N-003nsC-Ov; Tue, 28 Jun 2022 02:36:17 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o60uj-003i8A-7j
	for linux-nvme@lists.infradead.org; Tue, 28 Jun 2022 02:25:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id F1259B81C0A;
	Tue, 28 Jun 2022 02:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CF1C36AE5;
	Tue, 28 Jun 2022 02:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656383115;
	bh=deo1JpcjXYBtYYZozWyByG/bZH+UmISxdIj5AZqleGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dqLq6kE1XrGtHZsp3RM/soXJmxx+tUPlnWmdgweaLvpCo0mdDTFew1/nI5Dq1zmVi
	 cwCAfOuuEESpYoun/EAztCIZAiaOlrTj99+ec1zdVMfMY4UOp303i5CDWq00xqc10K
	 GAMo10Jvauvkz74G0sgKbWvs7MCAkAFfu5gcDieGS56o52pcvOWUXWJQwFjGIN8F5k
	 CNpLRYAExybqYB2kLTaCGfQ40BmMhxojohtPMF7QdSORpcVQxZYHo1Y0CuvWoobECq
	 ZosH+0WXbkjQq8whA3gFQ3aNuFQabpZJiUza320mb2rJn2BIvQqkIyTltI2Gf2BQdM
	 i0Eo9ulUWkucw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leo Savernik <l.savernik@aon.at>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 26/27] nvme: add a bogus subsystem NQN quirk for Micron MTFDKBA2T0TFH
Date: Mon, 27 Jun 2022 22:24:12 -0400
Message-Id: <20220628022413.596341-26-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628022413.596341-1-sashal@kernel.org>
References: <20220628022413.596341-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_192517_505965_E99256EC 
X-CRM114-Status: GOOD (  13.42  )
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

From: Leo Savernik <l.savernik@aon.at>

[ Upstream commit 41f38043f884c66af4114a7109cf540d6222f450 ]

The Micron MTFDKBA2T0TFH device reports the same subsysem NQN for
all devices.  Add a quick to ignore it.

Signed-off-by: Leo Savernik <l.savernik@aon.at>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 10fe7a7a2163..0dfb60a8037e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3196,6 +3196,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	 { PCI_DEVICE(0x1344, 0x5407), /* Micron Technology Inc NVMe SSD */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN },
 	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
-- 
2.35.1


