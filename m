Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76B4CCA473
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6WVUoa+eZcnUMqzheuyrPVYsT2CsYfXdJJ0WJB8VH9o=; b=TbDR0+c6pZ5lzJiox85zU0FH6b
	Dshg2Us8PExX27Jv+Ssi2KrQ2OCuHQnNq5i0Tf/1b+MNPUsFoyYShYvtyoqezFNI1EQx7AMIce2Pc
	1hbMSpitkhDdqGXmmgU+y8LMQ+whsfARNDsHr8XgS+p+0/styMH46/wof5O5l+JzCs4vERg9DeTKT
	94q3VTpVBOdBnO9jpxUZaeAon7fAPGicC5AYD3SLlvIeHBqRpKTBRIKPxZfs4tsrvJj/jJ4RfFjak
	L8ltDG6ahPVjUyM5KGpl9Gx+mEueiHSkBgH/Nx8RyolPCSrPeoSAk8tt0cunkn2F7MG0uGr7KIEDV
	LlwwVg6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kw7-0079w0-Qj; Tue, 21 Jun 2022 20:57:24 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kpt-0076kX-2F
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:50:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A463761881;
	Tue, 21 Jun 2022 20:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE98C3411C;
	Tue, 21 Jun 2022 20:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844655;
	bh=xgy/yEXvcMh2r2fyvGlviOnY/dveL3HAV6Wo8r2f3BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FyMkhRrO4gfzYlyaa14bHL3IDxL4X6eYmhsmpeq5OT43+DJCkWWNG56QnasFxA/VJ
	 4yFLArIYvyEjgoRvypFrVrCC0BTFRx2p1iPN0rY+bdRq/Y6mS0JLiauek+zZkXupwF
	 uk6WS7iP68mhYyt1NLbozcjQa0KEOfGAsYZfquDkpgE38b8JH4uI4C2GFRbthB8fvG
	 AtvXbCAWaLQM64SAbSEN7vq+A77DTx4uaa6tNlsRpuihobEjBF6pCW0tmfEEUZ9AM7
	 SvNJO7gQMoAYuQxvAc3aVvnaQ+ydZHdfKNr2c+3/OVCYCFtUKGmGeuZkqt596Iiamf
	 cuF40CPWE26kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 09/17] nvme-pci: sk hynix p31 has bogus namespace ids
Date: Tue, 21 Jun 2022 16:50:32 -0400
Message-Id: <20220621205041.250426-9-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621205041.250426-1-sashal@kernel.org>
References: <20220621205041.250426-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_135057_186900_A88FF167 
X-CRM114-Status: GOOD (  12.31  )
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

[ Upstream commit c4f01a776b28378f4f61b53f8cb0e358f4fa3721 ]

Add the quirk.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216049
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f06bc7596e2b..78e382651198 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3359,6 +3359,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1c5c, 0x174a),   /* SK Hynix P31 SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
-- 
2.35.1


