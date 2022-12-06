Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7D8C63705
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 09:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r6bDmubpSl8tUlgzkgDWtOqtlVz8r+PkQm+zH66kAv8=; b=pRhl2PJVx2Fdm+bnIiYmU5oMes
	06MrG48MdI0CiGpadMySLJOGq7wsMY8YneYDXIldpO1qGfEIVSqBvIuPF0510mmiieHICFa87fLFz
	vlVQ4hD5NX9jZgkGUFnTKTtV0YPUdj7owCbKlJOGoALls1W7n0O35Dmqsf1ZNdojNeRn2X86rd20L
	ihHn38UHWn+YqaFGiVtLFPQLqlWiVfnUJ2K3luLS6Xuo1hVFnOQSY3+0cFe5hEPZ0gv1yILbObboe
	4c/PnJ80pNfKJgmf+985MRoqlejYhRboqr/KFrobkmqDPmGPuXSn5+5Dvrlswke6Hp+cd2X5FERsB
	ygcDGIhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Ucf-006UoM-Kg; Tue, 06 Dec 2022 09:52:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2UbH-006Tip-PM
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 09:50:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 49C9361616;
	Tue,  6 Dec 2022 09:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66613C43143;
	Tue,  6 Dec 2022 09:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670320255;
	bh=lqVU3SBmQ1eCIYMlGUwkPNT1E5x77hO70+K76rh3sNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqNeANjpZGiJzUXeYQCRXUFj2XtD43ysfM9ul5m1EQMi2qjahDppFBV8XAhODb1Pv
	 SS72aRV4W+BI6bhdJRFgh+sguBBVRmB+LEyV+bYDLiWGjw7Q/Z0JYdwBykP64VR3DS
	 UEaFEvpzn45078sxmTW5VZSRsGyF+UxVRWk/49B9bVOD95FUv7B2Zvr0M7UviAUu20
	 h8wOeYph4h0sJuyA1117yIvlx+7X16fAVmhMJDjKquOdArVS9LiR9XCVO33DDlLMgS
	 dJAgnaLG1c+MRkSkygY90n2BFaoUb+2Ybj4jK8DJO4K9qahy+gosYkhq/KmRbFdnbh
	 Es9hamSJ3gbQA==
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
Subject: [PATCH AUTOSEL 5.10 10/10] nvme-pci: clear the prp2 field when not used
Date: Tue,  6 Dec 2022 04:50:27 -0500
Message-Id: <20221206095027.987587-10-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221206095027.987587-1-sashal@kernel.org>
References: <20221206095027.987587-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_015055_897402_0289BFDB 
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
index 089f39103584..c222d7bf6ce1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -817,6 +817,8 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
 	cmnd->dptr.prp1 = cpu_to_le64(iod->first_dma);
 	if (bv->bv_len > first_prp_len)
 		cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma + first_prp_len);
+	else
+		cmnd->dptr.prp2 = 0;
 	return BLK_STS_OK;
 }
 
-- 
2.35.1


