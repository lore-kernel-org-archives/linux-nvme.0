Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEACC021A6
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tZfjhCpl1dptQIU9XDQ05LqvOxfyc+cVth6px8jwYg4=; b=yWs7mIdY4S+0yYy4hrCIdX5zV2
	42F3Y8HikTQimAGNVF3tzZQGRbb4EmQ8ur+m6ZpZVXmJulBy8wv1nIlWO5kxOpfvL5eC5HDLPMkSa
	r/nYNpCvTNIv+eoOlx9hHk0msFUgoYO2c+oHlthlP0l44dH2FSrPXQm+CSbHkGuHYA45Rn5KMBx5m
	G3Ob+d6Uy628CRRElWjySitiu4Ymi/eubpZuHTrRoylIvwN8nEYkG9kjOEUL/Ubexl6AieQ1sIFoU
	DxF4f1lQFov5WaQ+QsVcTeqDYXuj9p8AufpqfKPVMLz1kGG+ZZC6IEMR/wzan52fa0cWjvgqAz9Gm
	q33SMaEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWeo-0000000DOhN-49Pp;
	Mon, 24 Feb 2025 11:29:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWV4-0000000DK4O-1XJt
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 11:19:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CD4E05C678E;
	Mon, 24 Feb 2025 11:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF1EC4CED6;
	Mon, 24 Feb 2025 11:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395989;
	bh=uA1lwD82vb+sC0QUB7bxcLlcxVnvh0W+B39WusQlBZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TjSCXUUXhfOmlsDpTEjj64Vtin4y0eGR0XzhsUvC4IfQ+p43I0abzZdcROBxwrQvl
	 zWyC9dP5RgUsUd43YrWK2R7DHFKK4Q5kx+lA2trHsohIs3W5+qJChZUd5yU8L4dlku
	 iHb7Itt7uQ1ZaE9WyJcjMluOSWgxMf/V1GLxKY9XbTpQyIUWBbqtRGfx7PdS+ev/+U
	 ewTXUbbhSF7DBANFyBA11CO15emRB7Lq6iX60eCx6O6Bxx5zF3dPhKzKZijKww/Z9P
	 M8QMX9+Mil/rH02SS33+idogZm6EzdO9y8fRPTx9p0QPGAbMGQpzGt7nGxVz4VMjQf
	 4xGBnO81KC4HA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christopher Lentocha <christopherericlentocha@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 13/20] nvme-pci: quirk Acer FA100 for non-uniqueue identifiers
Date: Mon, 24 Feb 2025 06:19:06 -0500
Message-Id: <20250224111914.2214326-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111914.2214326-1-sashal@kernel.org>
References: <20250224111914.2214326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.79
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_031950_515343_1406ED3E 
X-CRM114-Status: GOOD (  16.42  )
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

From: Christopher Lentocha <christopherericlentocha@gmail.com>

[ Upstream commit fcd875445866a5219cf2be3101e276b21fc843f3 ]

In order for two Acer FA100 SSDs to work in one PC (in the case of
myself, a Lenovo Legion T5 28IMB05), and not show one drive and not
the other, and sometimes mix up what drive shows up (randomly), these
two lines of code need to be added, and then both of the SSDs will
show up and not conflict when booting off of one of them. If you boot
up your computer with both SSDs installed without this patch, you may
also randomly get into a kernel panic (if the initrd is not set up) or
stuck in the initrd "/init" process, it is set up, however, if you do
apply this patch, there should not be problems with booting or seeing
both contents of the drive. Tested with the btrfs filesystem with a
RAID configuration of having the root drive '/' combined to make two
256GB Acer FA100 SSDs become 512GB in total storage.

Kernel Logs with patch applied (`dmesg -t | grep -i nvm`):

```
...
nvme 0000:04:00.0: platform quirk: setting simple suspend
nvme nvme0: pci function 0000:04:00.0
nvme 0000:05:00.0: platform quirk: setting simple suspend
nvme nvme1: pci function 0000:05:00.0
nvme nvme1: missing or invalid SUBNQN field.
nvme nvme1: allocated 64 MiB host memory buffer.
nvme nvme0: missing or invalid SUBNQN field.
nvme nvme0: allocated 64 MiB host memory buffer.
nvme nvme1: 8/0/0 default/read/poll queues
nvme nvme1: Ignoring bogus Namespace Identifiers
nvme nvme0: 8/0/0 default/read/poll queues
nvme nvme0: Ignoring bogus Namespace Identifiers
nvme0n1: p1 p2
...
```

Kernel Logs with patch not applied (`dmesg -t | grep -i nvm`):

```
...
nvme 0000:04:00.0: platform quirk: setting simple suspend
nvme nvme0: pci function 0000:04:00.0
nvme 0000:05:00.0: platform quirk: setting simple suspend
nvme nvme1: pci function 0000:05:00.0
nvme nvme0: missing or invalid SUBNQN field.
nvme nvme1: missing or invalid SUBNQN field.
nvme nvme0: allocated 64 MiB host memory buffer.
nvme nvme1: allocated 64 MiB host memory buffer.
nvme nvme0: 8/0/0 default/read/poll queues
nvme nvme1: 8/0/0 default/read/poll queues
nvme nvme1: globally duplicate IDs for nsid 1
nvme nvme1: VID:DID 1dbe:5216 model:Acer SSD FA100 256GB firmware:1.Z.J.2X
nvme0n1: p1 p2
...
```

Signed-off-by: Christopher Lentocha <christopherericlentocha@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b1310e69d07da..a36ec6df6624b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3509,6 +3509,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1dbe, 0x5216),   /* Acer/INNOGRIT FA100/5216 NVMe SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e49, 0x0021),   /* ZHITAI TiPro5000 NVMe SSD */
-- 
2.39.5


