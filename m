Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E98C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 07:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4LGC4AEtQnLkeXR9HVSyr9dL0xUBwV2AJw6cSMUBEBQ=; b=Q81nSnxI5pSdF7/EYM+Z9o1StI
	HTsfB82ybqMAHF12VLHjrX8Yfk9fyRTPvxB2UGBSd45kCgCzmMq8VNHeEqaJZaXKeMaA1sPUh6rYH
	01ehx1mSNwfPaXEvCoQM3RBOm2+MnWo47XV5qamZ4+UqgkxqnOzscQCIPlj14GKANET8bobMYWtj9
	dn1sw0pFeiNKcWbrL73DutW1YRWZ3qyLHx2OuNIOtzjKe93DR77c+WwHCj0Yfgohw+QR0ciwF+AqB
	6X9jA2mc04AEKJlLudSHbN2bnmdOUzmkgupGH1+hjaXMsRZkaqSB4ySQTHD6qgYqrCu6hitKeGJ+W
	zbqLG4+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0ErT-000000084z8-17yz;
	Thu, 03 Apr 2025 07:19:39 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0ErS-000000084yW-0Sr6
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 07:19:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 901CB68422;
	Thu,  3 Apr 2025 07:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E9EC4CEE8;
	Thu,  3 Apr 2025 07:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743664777;
	bh=7/bCulPxh64RkCE6BkjHo3fusfbzBTF+eZWn1BscDiY=;
	h=From:To:Cc:Subject:Date:From;
	b=aWahlQjhPEM4WwRVW5CkFe4DRhpv0z3cWyeePspst8VDgL5WLTpxKxoUOEfddUO28
	 15CRorgZ7dSyD+58L9kGZ2gSnIp8r3Kh7axFOlUwPmSdi77DDf+OzCyX9WvvAkRtbj
	 FxnmdVgxeKfphB33CeaNgsCk9u4QA/UM885TSvJb6DkHrwEldwiJ/ebQojFfvul4G8
	 HcL5moOK/JrGV/eUneRthjPkucU2KjpPm2EklNtxfY2cV1aDVamoLWa4QUdArwixWx
	 sHbkSdFRo0ZEq1DWwIHm3Axu1eteyw5tYMOKnYK5ONq0O5/4KK0FsDgZMTLomDgnxO
	 +mpDGcMZmekMQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 0/2] nvme: missed AENs during scanning
Date: Thu,  3 Apr 2025 09:19:28 +0200
Message-Id: <20250403071930.52154-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

I have been tracking down a long-standing issue from one of our partners
which had a test where namespaces have been remapped in quick succession.
The operation was to remove a namespace and add a new namespace at the same
NSID with a different UUID and different ANA group ID.
And that repeated in quick succession.
There had been several attempts to fix this ([1], [2], and the patch from
Keith in 1f021341eef4 ("nvme-multipath: defer partition scanning")), but
the test case continued to fail ending up with all paths in ANA Inaccessible.

Eventually it turned out that we're skipping NS Changed AENs; if namescan
scanning is active when we receive a NS Changed AEN we'll simply ignore it,
and do not re-read the namespace list as we should.
Additionally the NVMe base spec states (NVMe Base Specification v2.1, Figure
151 'Asynchonous Event Information - Notice': Asymmetric Namespace Access Change):

  A controller shall not send this even if an Attached Namespace Attribute Changed
  asynchronous event [ .. ] is sent for the same event.

so we need to re-read the ANA log page after we rescanned the namespace list to
update the ANA states of the new namespaces.

As usual, comments and reviews are welcome.

[1] https://lore.kernel.org/linux-nvme/20240902111548.41430-1-hare@kernel.org/
[2] https://lore.kernel.org/linux-nvme/20241007100134.21104-1-hare@kernel.org/

Hannes Reinecke (2):
  nvme: requeue namespace scan on missed AENs
  nvme: re-read ANA log page after ns scan completes

 drivers/nvme/host/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.35.3


