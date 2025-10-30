Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACDACCF9F0
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 10:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lrWomnt2RkjdZ4Z5iNToshADxztTqsPrQkf5CnpOO+Q=; b=mZkwuMAXnzlhC6
	ePkB+iFo373zLDzrkKK+lz4+cUQS3nYvtS4JAFxXIvDZEbY4kdtxvavUDaumicZnRSf0t3q+t8dee
	TyOl2qS4Z/hCqA2O/pSZdLPpB0ZxTP+tR+Keslq4EINtUpFMl1uYety4uXLR/rHKF54MDNgzIMoTf
	jbj5wzQtr6M7WylAcIJk2ygnZH/N6H2oC4yOITO6XB3jW1hET/0Yus7nx2+8t2KGy4z2hKI3oqgno
	19Fx9+kN6lOYiXFDYDs2//J8gvadsf9UJ0f5VKlNHVgxDJdRUpGEPpvdaXPbeQ6cbSd8LW4BlFOk/
	Pu9Dv4GNXisg8swfH0LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEPXU-00000003w8h-2uuM;
	Thu, 30 Oct 2025 10:05:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEPXT-00000003w8X-1Hcn
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 10:05:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6EF87602C7;
	Thu, 30 Oct 2025 10:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C04C4CEF1;
	Thu, 30 Oct 2025 10:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761818750;
	bh=z/zO5AzIwHGXSvca67Xe/lROEaDfqic3LtCNKZTOdck=;
	h=From:Subject:Date:To:Cc:From;
	b=SmYdSVe0yFp+VVuHZh63j8huPAJBWKYezRk4c0+jpfqRyNdQMfMDSw2cyYlaGhA5C
	 9NmOqO+pWNxexKtBrNxHvra9q0PnJoIzBBORPdeHGLQo/+4MyWpckdYzSBInzqejc3
	 oMTnHa3UXcah/Axx1ekJupNJdxcI1wIPAFniPMfVSdqRmG7PFVVcPrILUVfsmrQMQD
	 q2xhOEaT8uj+90//zJ/eFzCTDOwLrfRbwm+XoamKB965LZzWucceEtqnyvVqQp67Mm
	 tKBPqdPNvvx8QiF0v79T4jlTwZVqwwGmoGBw2d9ln7tZeNemlftSoHxYIYKG4wwnqr
	 Ng49ddlnYihDA==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v2 0/5] nvme-fc: misc small improvents
Date: Thu, 30 Oct 2025 11:05:44 +0100
Message-Id: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ7CIBBFr9LM2jEMQmlc9R6mC1OHllihgYZoG
 u4u9gAu3/95/++QODpOcG12iJxdcsFXkKcGxvnuJ0b3qAxSSE1Cdujzize04xLCita9OaFibbi
 TlixpqOIa+Siqdxsqzy5tIX6Oj0y/9O9cJhRoWq2kIdW1dOmfHD0v5xAnGEopX9R+ol21AAAA
X-Change-ID: 20251028-nvmet-fcloop-fixes-4e57e82f1f15
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3
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

Updated the first patch to use the safe iterator variant as suggested by Justin.

orig cover text:

I've collected a bunch of patches from the last debugging session. I think it's
worth documenting which conditions are expected in the cleanup path by adding a
bunch of WARNs.

Also found a deadlock in the nvme-fc code, so this one should definitly go in.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in v2:
- use safe iterator variant in first patch
- added missing signed off tag
- collected reviewed tags
- Link to v1: https://patch.msgid.link/20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org

---
Daniel Wagner (5):
      nvme-fc: don't hold rport lock when putting ctrl
      nvme-fc: check all request and response have been processed
      nvmet-fcloop: check all request and response have been processed
      nvmet-fcloop: remove unused lsdir member.
      nvmet-fc: use pr_* print macros instead of dev_*

 drivers/nvme/host/fc.c       |  8 ++++++--
 drivers/nvme/target/fc.c     | 48 +++++++++++++++++++-------------------------
 drivers/nvme/target/fcloop.c |  9 ++++++---
 3 files changed, 33 insertions(+), 32 deletions(-)
---
base-commit: 77a4fe6a06e265bd94d2b3cdc87fb3cde877a05b
change-id: 20251028-nvmet-fcloop-fixes-4e57e82f1f15

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


