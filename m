Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAD2C43458
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 20:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FbHrFT3aPOIRk2G2iDaIAzJcsRnUxYpIE1B26zLqdvs=; b=HWwwkoPwMtZXmilOSIqUORS5W4
	rXEiz0XaORSrkp+TTQlt5CM7ij0e/W0zmjEANk74E1Fjjq/d2/YQ0CPzNUPxdWx5S1KB1cPgSVUBo
	bPdwWTG6QQtrQBlrNSfLST2c8+ZP/DH24I5+MEvC2znO5vNnXM6up3Vw/KZ9LEeJdfhfBf+Z68Zop
	m+5S7SOzKBiHOpr4/vQSO+q4f6KxL2nCit7G2THaxR6VBaY1n8k3tUH26s00Qmd2VJRlYcZxTUAp/
	ykH+lTNxXyE4yK/LdEVfqK/IRuOo/TWZ+5upDhALU0dRWdh7HHfzIIQWAlgNnWoEigqVznXPvOExr
	1b4sbPTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjjWH-0000000DCkF-1W3m;
	Tue, 14 Jul 2026 20:14:21 +0000
Received: from mail.tipi-net.de ([2a03:4000:43:185::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjjWD-0000000DCg8-2mLZ
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 20:14:20 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A9041A47FE;
	Tue, 14 Jul 2026 22:14:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784060046; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=FbHrFT3aPOIRk2G2iDaIAzJcsRnUxYpIE1B26zLqdvs=;
	b=3wtQYsN7VJ1WRWzmPblt5yts6xFJNnZFV/J+trD/CTYf+ntlOAVUrXDPUoUALb79eZw4sj
	dGV4qEwxA4pNSPRBPCNZv6x7vpHTsFeH98/vVgRJj1s7PvPt80yYY26QEaBihHgdmVXVd3
	jADDInXrEjXRLPc18setVSzNV/763ec3/89V+IyERXCxvb8KgJ8o1VTw9Gxg1l2QDYLq+w
	Y6Ty40J2B7K/8JS5hBJt7a5lmEEMB0jq8HoPtEfSSn/atKyIKL8yJH1IjjbP3pIh+5jfgz
	h60xO9FZ2GSVquY02+jywc75BCRk7i6MuNRH9DHrjfgtAdBW7BC5yjCEHQDkSA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	roger.pau@citrix.com,
	phil@raspberrypi.com,
	linux-nvme@lists.infradead.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH 6.18.y] nvme-pci: DMA unmap the correct regions in nvme_free_sgls
Date: Tue, 14 Jul 2026 22:13:42 +0200
Message-ID: <20260714201342.1347823-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_131418_460899_5A9DA518 
X-CRM114-Status: GOOD (  10.75  )
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

From: Roger Pau Monne <roger.pau@citrix.com>

commit a54afbc8a2138f8c2490510cf26cde188d480c43 upstream.

The call to nvme_free_sgls() in nvme_unmap_data() has the sg_list and sge
parameters swapped.  This wasn't noticed by the compiler because both share
the same type.  On a Xen PV hardware domain, and possibly any other
architectures that takes that path, this leads to corruption of the NVMe
contents.

Fixes: f0887e2a52d4 ("nvme-pci: create common sgl unmapping helper")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[nb: drop the attrs parameter added in 6.19 by commit 61d43b1731e0
 ("nvme-pci: migrate to dma_map_phys instead of map_page"), which is
 not in 6.18.y]
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
This hits 6.18 too: besides the known Xen PV issue, the missing fix
leads to corrupted data on NVMe disks with SGL support on BCM2712
(Raspberry Pi 5).

Reported and diagnosed in https://github.com/raspberrypi/linux/issues/7496
Backported by Phil Elwell in https://github.com/raspberrypi/linux/pull/7500

 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5e36a5926fe0..8c66fd23a143 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -761,8 +761,8 @@ static void nvme_unmap_data(struct request *req)
 
 	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
 		if (nvme_pci_cmd_use_sgl(&iod->cmd))
-			nvme_free_sgls(req, iod->descriptors[0],
-				       &iod->cmd.common.dptr.sgl);
+			nvme_free_sgls(req, &iod->cmd.common.dptr.sgl,
+				       iod->descriptors[0]);
 		else
 			nvme_free_prps(req);
 	}
-- 
2.53.0


