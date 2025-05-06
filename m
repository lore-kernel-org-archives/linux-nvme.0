Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6A8C3ABBE
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 02:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GQHc4PeQbSzHfhPR4M2KZp5IKUW+jAAArriSyr5mnc4=; b=AIn1M4e1OHVIoMQCq4+gnQFGbZ
	cT9xo12s0tR3zgOXoh0z17OqTXv/ONUazcL5EYkNgJLT5b615Blz0w52VjPxIn2/qt8HUFBEDWGZH
	uW1UxV7FLsd/F83v0uhlk0bVY91EcZyocTdGL0CAw4+HTVebr02TpqFot+Dei9vqDK/mHe6m5XE2v
	LtxlD5rciAUCZCHsryQSNJMaXuQRgs0LZg1QmUSGo7aB1dGVMPfCKsD6CB6u2axJkFqagxcS1aNss
	Lo0eHf/7MSjdLT8dfLlLEFmeJbtwyaFIy3lyW+xeoBly82dmEz37Jyus5f8IQ6rYjgq04OzVc4NsU
	8VyO1faQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCUc8-0000000DxBj-3joC;
	Wed, 07 May 2025 02:34:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCPxO-0000000DRAB-03Ut
	for linux-nvme@bombadil.infradead.org;
	Tue, 06 May 2025 21:36:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=GQHc4PeQbSzHfhPR4M2KZp5IKUW+jAAArriSyr5mnc4=; b=GS7Ahcbp9+2fkSKeDVWdU4TpAO
	RxZ1PuWEztTsGnHfodVBYEVS0ZyE6r/HIUvpl2NkLwYdFby+qGwy/Xr5WJKGNuzxH8mDPTdVPs09g
	7GxxfOC4gqxJEtZWNgJIsepzG8SHs7ezvuR6vEtBw2W+z02lFDoAHVusEnQJ1vCo/s9F3/r4s3DnG
	0ipkg2rRTVNPPmQiYsmsm77wCI9nA1AvIniKKMKdrlyuzV+KQmiWZQD8VCT/HlXLnADSqLpO9yCNp
	sYi+iMmZNG7Sr1ijFeDcKrQpEwjHYfWTjQNP51i5CNEpM6P0CJnaxFcUgxdteVrLzs3XoWL7KATpy
	Fsp4uf9w==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uCPxJ-0000000FhGo-2qwj
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 21:36:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8C149446A9;
	Tue,  6 May 2025 21:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B1FC4CEF0;
	Tue,  6 May 2025 21:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746567350;
	bh=z+Mr6Ym3UPcatOcr7n2Yrm8AYWpQ6LViN7grat5QJLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O1RrPeDzaZqCaxOReuEZ4YpnlKuC+mfouX9EkNMf39/oL609dNZXbQ4K1S8+3sUCy
	 P4xTH1FUUjlPur3kW1sf8i07rJt3JzzkyPTU3kfP6mncR3g+XwFMyAj1Te2GG+t0lv
	 Srxydy+YnhVTd1pu5nARqs/660KdKUoyJcW64vlE+8Iwj+lXZYNzZwU9e1BcyJg88t
	 fACA7gIGGEqID+nIZPtPa4gGAjboHS2R1qgbLqLyfzr7Y9f5O90ZfGz1GN5lPQWY0p
	 09dl2ke7eagm4LH2Lk8afnFKr+Y+QbI4ajCIXoBJ2SsUzunbvStcmujoQkFl7jKmk5
	 eLCReClqdNjew==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Wentao Guan <guanwentao@uniontech.com>,
	WangYuli <wangyuli@uniontech.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 12/20] nvme-pci: add quirks for device 126f:1001
Date: Tue,  6 May 2025 17:35:15 -0400
Message-Id: <20250506213523.2982756-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506213523.2982756-1-sashal@kernel.org>
References: <20250506213523.2982756-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_223602_339959_5CAA9EBE 
X-CRM114-Status: GOOD (  11.74  )
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

From: Wentao Guan <guanwentao@uniontech.com>

[ Upstream commit 5b960f92ac3e5b4d7f60a506a6b6735eead1da01 ]

This commit adds NVME_QUIRK_NO_DEEPEST_PS and NVME_QUIRK_BOGUS_NID for
device [126f:1001].

It is similar to commit e89086c43f05 ("drivers/nvme: Add quirks for
device 126f:2262")

Diff is according the dmesg, use NVME_QUIRK_IGNORE_DEV_SUBNQN.

dmesg | grep -i nvme0:
  nvme nvme0: pci function 0000:01:00.0
  nvme nvme0: missing or invalid SUBNQN field.
  nvme nvme0: 12/0/0 default/read/poll queues

Link:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e89086c43f0500bc7c4ce225495b73b8ce234c1f
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1dc12784efafc..d4d109df3c84d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3626,6 +3626,9 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
 		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
+	{ PCI_DEVICE(0x126f, 0x1001),	/* Silicon Motion generic */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_BOGUS_NID, },
-- 
2.39.5


