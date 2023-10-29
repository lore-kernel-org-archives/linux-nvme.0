Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAC2C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Oct 2023 22:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8xoPQfat+KOXFyDaG2ERxUhnT3QtL3hf3Y3r3ImM9Ws=; b=RgSb5OA1dc04bC0T7n2B1mIWoH
	NP6mxBr2zHS2FOTxLLxZXm9JcOSmfBCepVbr6TcZxS8/D99bwz+g/2WeoZ2Y/o84Z5J1aWV7uio0a
	zUIzz1gX/Rg1yTl28zJjgZDvDuRwMsWZB79U4vRmhtxRSrDwd2nYzo3FDUMIbj5lVMrjRR/WliI8o
	GpHS+P3NK6cVPz+fvUhA5iWAK8mdxcDZP3SQC7CGDqLkXCHj+Q7yWACGT5AXA90ehCChYxto+nT7z
	rgfLjxVBF0IxjYfkqARW7IlTsRwYgIgAD4lwWPfD/CzSUJGsKG+ZNP0QkWAfofF4dRBeC5alL4xE7
	ZsHt3DRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxEkG-002EOE-2p;
	Sun, 29 Oct 2023 22:59:00 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxEkE-002ENV-0X
	for linux-nvme@lists.infradead.org;
	Sun, 29 Oct 2023 22:58:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 468FDCE123E;
	Sun, 29 Oct 2023 22:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B35C116B9;
	Sun, 29 Oct 2023 22:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620335;
	bh=dEu3444VhH0+iwkcPyJ9iW+h66Z9iMseq9nw/fn7lP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNdjrKfndki2ajr9XqCxc5UFDasfROyy9KoLHSiqGIBGiyEqRLJdpn2m4y0gD1mmQ
	 mpd8XBTJrqc5T+jOsytqrvkfVUcdGyxIGl8rXr6E9hHRXSeHY95e34Fz5AHAdzGcZV
	 OVwXQCnph14rClzXIyAnw+u/XZ3bq6glwrSNgEUIjU1K1k7DGd2JdT5XPLF6fFIjEN
	 osH1AL2MP8cryhGJ9E20hlNIyi4G9GZQfH+GcR6kHUI970+bdpaqXJ8bvCHhGHWniz
	 lgnlwU6ezlg4jXQWbvpJwzSLSVECSYlP4ITFHSL0gqiXwMGulnmC6rPXCk5RUwTXF/
	 Ow4nDDXjygXmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	welsh@cassens.com,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 37/39] nvme-pci: add BOGUS_NID for Intel 0a54 device
Date: Sun, 29 Oct 2023 18:57:09 -0400
Message-ID: <20231029225740.790936-37-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225740.790936-1-sashal@kernel.org>
References: <20231029225740.790936-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.60
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231029_155858_373268_14892983 
X-CRM114-Status: GOOD (  10.04  )
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

[ Upstream commit 5c3f4066462a5f6cac04d3dd81c9f551fabbc6c7 ]

These ones claim cmic and nmic capable, so need special consideration to ignore
their duplicate identifiers.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217981
Reported-by: welsh@cassens.com
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 64990a2cfd0a7..886c3fc9578e4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3439,7 +3439,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+				NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
-- 
2.42.0


