Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91336C6FA8B
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Sep 2022 21:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qkCxKX5HfJQ4HYgMDvj1UBb2JjlkPsVCi05vMjkp6L4=; b=qpwfERsD8I4hw8w5Nw74RKzPqn
	Ie8pDl5pJmWW95z8KCH3A8mZPqIJXdho7wtaGHEEv9bwTx/NhSVcd/SbBQx+QunZftApxbyLGKJsq
	b1bdhdvVeZ+yMLNBWQcow4RGT9dcNC/FxluiyzuVntFXsiSmdjEHzij+sePmm6EqZiOVuZFW4eaCT
	0lOVkV/cDix7sFC5cZkW4imrt+LO+EFPQfXjbbdBIbu46NaMJnO9+Nsq/cxPSdA6uwD7CbnWZ+E9Z
	4Q9uSjWseU6HlNeCO/czmkPBiD07pAbwo0vxtB5O7++vGGSbrhpV1Je+cI3Sbmn1k6vyQLf3zXsdY
	HiDw/D+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX7r0-00DRoB-PL; Sat, 10 Sep 2022 21:17:30 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX7qv-00DRn3-Gk
	for linux-nvme@lists.infradead.org; Sat, 10 Sep 2022 21:17:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 88E6760EC5;
	Sat, 10 Sep 2022 21:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18003C433D7;
	Sat, 10 Sep 2022 21:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662844644;
	bh=k/IRruyCkZWhZI+atk2d7eT+R5sJKTlp9ZUCQcg/64c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T42lwsKWVgIEf3yVp6cCWjGLowj1CxEqw3PUoSu3s/utYi+QWwUDz+d2vo5Nf3M+b
	 meCf/giYeCHDmzMbWv81dksXd3+Z6yn9B2MpgAVS2nF7OJH0ZJy7DnHqR8tVUtjGbv
	 M0abV7UU8Hzy0FM1WXr+2A/Krdmd8ox6qNnMrT015FYPOP5hTH53KbUXMod0a4E+7B
	 RFL1v/k4/3+TqsgiTo00qBFs2pRicefJnvWEols6bawuuwVSQqRcav73ouVOltcdf0
	 TKFU75TpPowev+v8OBpVuMfAyIWzrMv2eG4wA+7Kl6aWz6AIMif+o+sDVDRrlolPgP
	 DJZNixtrfh4pg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyamin Ayesh <me@shyamin.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.19 26/38] nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM610
Date: Sat, 10 Sep 2022 17:16:11 -0400
Message-Id: <20220910211623.69825-26-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910211623.69825-1-sashal@kernel.org>
References: <20220910211623.69825-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220910_141725_613905_4296FFD7 
X-CRM114-Status: GOOD (  12.64  )
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

From: Shyamin Ayesh <me@shyamin.com>

[ Upstream commit 200dccd07df21b504a2168960059f0a971bf415d ]

Lexar NM610 reports bogus eui64 values that appear to be the same across
all drives. Quirk them out so they are not marked as "non globally unique"
duplicates.

Signed-off-by: Shyamin Ayesh <me@shyamin.com>
[patch formatting]
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 73d9fcba3b1c0..9f6614f7dbeb1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3517,6 +3517,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1d97, 0x2263), /* Lexar NM610 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.35.1


