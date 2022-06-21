Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BB0C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cv4u33FINQsUZrDYQPQi6uxk59zhbgS8omwf0UheM8Q=; b=hy2cd+uyYvcvC/t2ylCHECrh/t
	HF4E2QenFA9kT7bjMhd2dmW/1aFPGnrAsi0MWtBaEEJpPsu/Rz0/7LUYqudDNL4NB+7FypX0vLWNO
	Oe7+KnRYaVoxX4uBnIdAzqM+JWOsuWO2qyJ5vpgXAN/tYrZg9uG3HQQ6IdIYbN3/et+bBMjg0kI+U
	JFhIYmxpa39plO89Zgw843GQF0KcF981xVjaDq+LdzizfUNHGkFfumyXX++KGPAftYuQH3qFhZghD
	XaW//iIy2q4u8I/0TacXZiIAkbLez51xkSXEQJ0yT2mbhuWpJCv6RjLoPEw2sFK7UCw5cSt8HeKrS
	5pZ4vbWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kpK-0076Na-7i; Tue, 21 Jun 2022 20:50:22 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kou-007671-J1
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:49:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 641636188C;
	Tue, 21 Jun 2022 20:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C27CC341C5;
	Tue, 21 Jun 2022 20:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844595;
	bh=3POKS7eqdY7o25MR6JJowXEP8imSIiQYhNPSKvJWOXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i88MvBhaXVnPg7hyQSEKxEVXnCSpfCzCyqEZ7vDxoAykmoFRQv10cCCWSHN/HZt4t
	 5NjpXglkH81CkHYp3UR/5G9jovZFnu1xNCfeMoG0eW31FUgBwYIhY+n9fEmoNIlTuS
	 utprI14GgZE7RpCnoXwxDUK+PbilofXwuzXLNWcb0ULRuPc4XcO6PsMFCrjqSKx6jj
	 nop9AO6f3/hYBbWGLl3CUwALM8fCqM6bPwqCJWC6ctfa3OxhWQ81jcX8jA6I1wLTeZ
	 R/ceQbiLdF6JeFmummn9oCyk7n3qwFaitFcSHPlQP05te81ga0KE+KooypNrPoscgV
	 LqEaD5CzMB7ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ning Wang <ningwang35@outlook.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.18 12/22] nvme-pci: avoid the deepest sleep state on ZHITAI TiPro7000 SSDs
Date: Tue, 21 Jun 2022 16:49:18 -0400
Message-Id: <20220621204928.249907-12-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621204928.249907-1-sashal@kernel.org>
References: <20220621204928.249907-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_134956_754041_9E64E691 
X-CRM114-Status: GOOD (  13.04  )
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

From: Ning Wang <ningwang35@outlook.com>

[ Upstream commit 6b961bce50e489186232cef51036ddb8d672bc3b ]

When ZHITAI TiPro7000 SSDs entered deepest power state(ps4)
it has the same APST sleep problem as Kingston A2000.
by chance the system crashes and displays the same dmesg info:

https://bugzilla.kernel.org/show_bug.cgi?id=195039#c65

As the Archlinux wiki suggest (enlat + exlat) < 25000 is fine
and my testing shows no system crashes ever since.
Therefore disabling the deepest power state will fix the APST sleep issue.

https://wiki.archlinux.org/title/Solid_state_drive/NVMe

This is the APST data from 'nvme id-ctrl /dev/nvme1'

NVME Identify Controller:
vid       : 0x1e49
ssvid     : 0x1e49
sn        : [...]
mn        : ZHITAI TiPro7000 1TB
fr        : ZTA32F3Y
[...]
ps    0 : mp:3.50W operational enlat:5 exlat:5 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:-
ps    1 : mp:3.30W operational enlat:50 exlat:100 rrt:1 rrl:1
          rwt:1 rwl:1 idle_power:- active_power:-
ps    2 : mp:2.80W operational enlat:50 exlat:200 rrt:2 rrl:2
          rwt:2 rwl:2 idle_power:- active_power:-
ps    3 : mp:0.1500W non-operational enlat:500 exlat:5000 rrt:3 rrl:3
          rwt:3 rwl:3 idle_power:- active_power:-
ps    4 : mp:0.0200W non-operational enlat:2000 exlat:60000 rrt:4 rrl:4
          rwt:4 rwl:4 idle_power:- active_power:-

Signed-off-by: Ning Wang <ningwang35@outlook.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6f9672e92b9c..7d5e40f5a993 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3486,6 +3486,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.35.1


