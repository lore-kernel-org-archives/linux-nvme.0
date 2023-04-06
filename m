Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C10DC76196
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 11:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QoEDEC1grgFv8WNW0wPCXtXbYBAIWLImcyWWn4bPAJk=; b=jVUCeoc0cDkH7Vkgr+U1Yfs3t2
	7zesYJH4LLBIC9uCtY8AqD+0cHZ3zfZGR8bHc4Sbe8gLDIcvGZBzVSZMncKa8xHf5mIEZqBKOP3KX
	KYfsGgcBWk/wV/gBN3CktXGIFLBVtXYIzEZXZlavUK+pBULrfut8YJZ2aazKUONm4bTFy6kFjvnao
	C2SPnArUx0Rqli8NieWDeJVLtOe9bqo+UrNJy1cXsUqaZzrz/38mIeh3ycN7bQGNe2JzL+pCxPKUH
	PPEBbjrA289UinC43f6IArBGcARqB+ACAbf8to2vmwRRP3tuKldeNuXuc6W4amwI0I1f+G9pHsphd
	2KwBcxHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkNr2-007AFt-2N;
	Thu, 06 Apr 2023 11:32:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkNqz-007AEd-2T
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 11:32:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 415F4617E7;
	Thu,  6 Apr 2023 11:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8262C4339E;
	Thu,  6 Apr 2023 11:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680780752;
	bh=YPqLRuLBlA7GT+I4tUtOZhBnYocg1filgWEr1J8fJ9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f+ZsWbBgkZ/MT9HuFzDUhrvKzxPf3uQvJEPrLSueBREZex/aZh/scVwJjJ6Qzes16
	 C9W12rMmkoWcGoI+WHtBG1y2Lasy0OqoHaT01lEku4Q/73fPRTI//dwRZ/N0Le6jza
	 8a5I8qHqnRclJuOxhgY6C+ImF6p2cEF0DAgOMi27ENw01gFEm2G+zRHZw0GfDMgfZy
	 vNdItDmYCvy4i9BOhgViW7jlVWB6Ur7dF2Zjm4mrrLAs0s1T2e4ALTkLOYeLk3moV1
	 spu7z/Ahv/6NlGLlqnMex1qmSxWXOMZTU72UVql6G1VTP8TSAwvS8Rc9r6wiZWsQfZ
	 MLZsp6LjjfCzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Juraj Pecigos <kernel@juraj.dev>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 10/17] nvme-pci: mark Lexar NM760 as IGNORE_DEV_SUBNQN
Date: Thu,  6 Apr 2023 07:32:04 -0400
Message-Id: <20230406113211.648424-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406113211.648424-1-sashal@kernel.org>
References: <20230406113211.648424-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_043233_877092_9EEA690E 
X-CRM114-Status: GOOD (  14.49  )
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

From: Juraj Pecigos <kernel@juraj.dev>

[ Upstream commit 1231363aec86704a6b0467a12e3ca7bdf890e01d ]

A system with more than one of these SSDs will only have one usable.
The kernel fails to detect more than one nvme device due to duplicate
cntlids.

before:
[    9.395229] nvme 0000:01:00.0: platform quirk: setting simple suspend
[    9.395262] nvme nvme0: pci function 0000:01:00.0
[    9.395282] nvme 0000:03:00.0: platform quirk: setting simple suspend
[    9.395305] nvme nvme1: pci function 0000:03:00.0
[    9.409873] nvme nvme0: Duplicate cntlid 1 with nvme1, subsys nqn.2022-07.com.siliconmotion:nvm-subsystem-sn-                    , rejecting
[    9.409982] nvme nvme0: Removing after probe failure status: -22
[    9.427487] nvme nvme1: allocated 64 MiB host memory buffer.
[    9.445088] nvme nvme1: 16/0/0 default/read/poll queues
[    9.449898] nvme nvme1: Ignoring bogus Namespace Identifiers

after:
[    1.161890] nvme 0000:01:00.0: platform quirk: setting simple suspend
[    1.162660] nvme nvme0: pci function 0000:01:00.0
[    1.162684] nvme 0000:03:00.0: platform quirk: setting simple suspend
[    1.162707] nvme nvme1: pci function 0000:03:00.0
[    1.191354] nvme nvme0: allocated 64 MiB host memory buffer.
[    1.193378] nvme nvme1: allocated 64 MiB host memory buffer.
[    1.211044] nvme nvme1: 16/0/0 default/read/poll queues
[    1.211080] nvme nvme0: 16/0/0 default/read/poll queues
[    1.216145] nvme nvme0: Ignoring bogus Namespace Identifiers
[    1.216261] nvme nvme1: Ignoring bogus Namespace Identifiers

Adding the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk to resolves the issue.

Signed-off-by: Juraj Pecigos <kernel@juraj.dev>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 60452f6a9f711..1bef32cd10252 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3550,7 +3550,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1d97, 0x1d97), /* Lexar NM620 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_BOGUS_NID |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.39.2


