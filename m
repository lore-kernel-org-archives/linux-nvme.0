Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3BCC3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 09:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s5qzHmZZRO8pWW2ADk+7SyAlbuiY4u4vl4MYlKnch2M=; b=hx7W6kAUZTNXk2HtnE74wWqb0a
	TDkTx1cwDiZgaK8K5CeDPKjQV3Mk8mHS7FHLesbry3EvwOuK4N90rgYjyIXb1Exx9KDRY+9hWdIGy
	/vDpreZNZwUrakXbQ6ew27cC+MTbymR11iYWjZDpx5M0b/GfAUktY96FoV8GW0j9yS1tO+OysLIFN
	5WrkUFPQPyL/eK0AxhDEfSTMMY69Sl6TQYGV7Pfjt6cWS6RzGWWJo92zpBJR/INYXY2mkkq5G/1Lk
	jFt9xUNglC1iTHgYKvdvt2R+s6+okbn2rQ11v4TrCmO4eN2b/mjIUxhnNDT1BHGXuveTlhEKWeQLF
	ARsyi8cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2UaX-006T8g-0k; Tue, 06 Dec 2022 09:50:09 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2UaI-006Sv2-CZ
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 09:49:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 06459B818E7;
	Tue,  6 Dec 2022 09:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700EBC43470;
	Tue,  6 Dec 2022 09:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670320191;
	bh=sLFnxQ8KdDFsbpCr7Ub0zv1OPy+heet3m84NrOcex7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KG8NhlQq3/IiD2BrECDt96Xk+ulfdRs7uwd2Nh35rDl+uugldHKYBagmT61AkJnvE
	 shfhKY0tNdoYKHDk5Tnd/7Al4gLkJEgF4yayy++71AJCwi9b5nymHtYuyc2lmZVKQE
	 xm+HYIizqgycX++vQzLE0NKMDBUJlhsNboLBYEu7o9FrK4bjPrVy47cMnHDXy4MUvx
	 0RVZlw8Z8hxEH7x1gb1ewnr6TzbGPN8QguAPB9YEQNhII6JKKGwZT8LgO1c85O9QH7
	 fb7cQ4tAdqroIE4lXHa4tjuDsJuYbsTBXOQYKHSCKn0Ng5KGfASs6oVVtugvm6K9sh
	 JQ/ypR69heEZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lei Rao <lei.rao@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.0 12/13] nvme-pci: clear the prp2 field when not used
Date: Tue,  6 Dec 2022 04:49:15 -0500
Message-Id: <20221206094916.987259-12-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221206094916.987259-1-sashal@kernel.org>
References: <20221206094916.987259-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_014954_618801_3EFF95FA 
X-CRM114-Status: GOOD (  13.31  )
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

From: Lei Rao <lei.rao@intel.com>

[ Upstream commit a56ea6147facce4ac1fc38675455f9733d96232b ]

If the prp2 field is not filled in nvme_setup_prp_simple(), the prp2
field is garbage data. According to nvme spec, the prp2 is reserved if
the data transfer does not cross a memory page boundary, so clear it to
zero if it is not used.

Signed-off-by: Lei Rao <lei.rao@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0f34114c4596..6867620bcc98 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -804,6 +804,8 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
 	cmnd->dptr.prp1 = cpu_to_le64(iod->first_dma);
 	if (bv->bv_len > first_prp_len)
 		cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma + first_prp_len);
+	else
+		cmnd->dptr.prp2 = 0;
 	return BLK_STS_OK;
 }
 
-- 
2.35.1


