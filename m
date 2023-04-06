Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAC3C77B6E
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 11:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t0JRrHLtqQ48S732omv98Mmu5qyB7m5CPn6j+hgdMZs=; b=HghLRcgdB1RLbD2c585+Zf954A
	XPLxzRvgC8fXq7OAYos3dXce3EyuoWxRxwCf0DKjyqxExyBq+n7UmA4dbgP5hp5kT2MLrk8KxWkGG
	zSCK8y9dSTaiw4ProRxxjYBEq/IqKEfj8KV94eIYLK3znztk/1rbW5tfXEPLbY1dfiUF1wLIa/3vv
	wVtQAj3m0dpH2K+ag1P6pSQa1+Evx2GJ53y0KqjolYSOLv7dAHM0pLTxAMfu5RQIHH+sSSaX1BLc8
	PU/Du4cNGothgWQOacmjCg/3KgDVU3D+of4D6Yyz8fv/TjozMVYNoPl6yTiPDq0bIjwYV/hVWJuZu
	Vs05HPnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkNqS-007A16-0i;
	Thu, 06 Apr 2023 11:32:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkNqM-007A0L-1i
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 11:31:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 216236464C;
	Thu,  6 Apr 2023 11:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83467C4339C;
	Thu,  6 Apr 2023 11:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680780713;
	bh=eBzU8vQiMbfz0jRxd2uHd5AUtO5xCXilGDbV5mGZO/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6PQhxgUzfMEqi5SYb6IDW1Srw6i+6YA/gmm4TJ3kLT4sG7mvWkQN/QsS7oW0OIuK
	 VpoLcYYrNuNLSjN0/elBq65EAb2GlTkrIkBBJGA137l4OMPAKmO32YTFc9e9MBlXgm
	 GnRT1t2gc4T4m4KW2oSIgelMqPil8LAiOVUUSQA7jTENiEy1HyxucuB4nUQNks+5nj
	 bQ3et07J4SdWbmUKfoqjLXm4cNzZkmLkmbwldtZagbEGQVjXLaZo/w8F3efxgGc2DU
	 T1lb4MvJvWUoYCjBSXFD7p5Tjx3F5WBerk2IXPBX5NQZX/28Wth1O5IkNyg7TPpSPG
	 KqWHCyhOYi+Dg==
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
Subject: [PATCH AUTOSEL 6.2 10/17] nvme-pci: mark Lexar NM760 as IGNORE_DEV_SUBNQN
Date: Thu,  6 Apr 2023 07:31:24 -0400
Message-Id: <20230406113131.648213-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406113131.648213-1-sashal@kernel.org>
References: <20230406113131.648213-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_043154_641440_76E32698 
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
index ea3f0806783a3..2e3fae6e1fb30 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3494,7 +3494,8 @@ static const struct pci_device_id nvme_id_table[] = {
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


