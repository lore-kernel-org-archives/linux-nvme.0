Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18854C433FE
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Oct 2022 17:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=T/XZfxK3Gm9Hej56TjYA0VoFLDQruLSp+UIXliyC5Vc=; b=FZQJ86vuEN6Ve8AjFvAp4FDH9k
	Fmf9/GGiqy7p+5LfzJUtZ6uoT5QS9i6j0fSzSllWtWdgGN0RZdw7DTIpg+RF5WCKGnNoqw8/alvwp
	iROXIdDyE7KkVqchpu0ho3futAMJs3M8wa4He5fXR3UKGUPyX9dKo6a2KbjUZr7bQEhnq1tV80sOP
	sJxoahPwA97ZZUtbRbOtTZJ8khI7JuwIWbBxoe+i3nkHalj1YZnBKjWoOwp8nLgLRpmZGwhCzmYBQ
	YRxol+a5oLocyaoIDkUVQz4LsBaeagPoQ1wo5tcXkkqidg32lTlZ9l8G2fE9sXjKLXrhBK4yPHtsY
	Dj02/R+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohaFW-00Fvd5-0t; Sun, 09 Oct 2022 17:38:02 +0000
Received: from so254-28.mailgun.net ([198.61.254.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohaFT-00FvcP-DB
	for linux-nvme@lists.infradead.org; Sun, 09 Oct 2022 17:38:00 +0000
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=abhijittomar.com; q=dns/txt;
 s=mx; t=1665337071; x=1665423471; h=Message-Id: Date: Subject: Subject:
 Cc: To: To: From: From: Sender: Sender;
 bh=T/XZfxK3Gm9Hej56TjYA0VoFLDQruLSp+UIXliyC5Vc=; b=N/zVbik56GNAOS5p1p0ttmmAf01B/Ws2p+fFiw65aYmCI9jo0X5nnk1gqT+etPm4BISRQYQI
 fSg56Jeaty1HAdtuFaZBrA/lkGPM+3+zGNU4LY/obaZV/HaeyWl2N9WEddomn43IeqiTNECM
 2qYewfBKUqT0wA5SqP7Ztk8L3Fg=
X-Mailgun-Sending-Ip: 198.61.254.28
X-Mailgun-Sid: WyJiODUwZSIsImxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZyIsImQyNmQ0MyJd
Received: from
 newwireguard.5yaaqpyeffpexbl0sr2b0h3vtf.rx.internal.cloudapp.net (<unknown>
 [13.71.41.3]) by 8eed7f4a1d57 with SMTP id 634306efcf9de181024bc8c3
 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256); Sun, 09 Oct 2022 17:37:51
 GMT
From: Abhijit Tomar <abhijit@abhijittomar.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abhijit <abhijit@abhijittomar.com>
Subject: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM760
Date: Sun,  9 Oct 2022 17:37:44 +0000
Message-Id: <20221009173744.12173-1-abhijit@abhijittomar.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221009_103759_537315_41133E5A 
X-CRM114-Status: UNSURE (   7.04  )
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

From: Abhijit <abhijit@abhijittomar.com>

Add a quirk to fix Lexar NM760 SSD drives reporting duplicate nsids.

Signed-off-by: Abhijit <abhijit@abhijittomar.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8dd1dddbb..8970edf3f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3517,6 +3517,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.17.1


