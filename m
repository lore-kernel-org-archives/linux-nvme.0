Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F01FC3ABBE
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 19:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nc37vacZ579khucXSGdXP97s+i5VhtR2LgtWg+zzjOE=; b=yu5+h7rvNf5m+JxSIadTkTPCTt
	hxTvoxMoW3COZxG/lUxCGGlBHKIApHlpYQXFN/39Ja+18TSYNNCqcWPqsLtn8oeIXQLJxTwgfAw7j
	aJ6J7xTm3o1TSnzqVp+i+Ws6FglryoZEimXN26U+qPhqx3nv2O8815dzngN0X4zCSEoIr81XEUX1k
	smx58VuC5SMOEadMA2TYNp/sgg02vAn07q41ToS9r52AUUJ83lky8DV1aMovhFg4lFDyqrlsHW1Ao
	HWAoCdg/FwUYAsTXMFwukCedS5PPJm9/HxMv2YTo7WHGb+nBdYI0AGiwm2DMNwRQKLVrir1rE763j
	Cy5JMNlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCOMk-0000000DHM6-3NcO;
	Tue, 06 May 2025 19:54:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCKKF-0000000CW4L-2eLB
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 15:35:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7557B5C57DA;
	Tue,  6 May 2025 15:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175DFC4CEE4;
	Tue,  6 May 2025 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746545718;
	bh=mQmpvC8aQH4uvVMKeow38iLYKdKwmIBTcwZD8qtAy0A=;
	h=From:To:Cc:Subject:Date:From;
	b=lwv9o/iQqMypmtytbtQSXPd8ESjvWvPaB8232sKBL0YiXUeNAIRotH7Zb58HPtSjw
	 vrBfdbbo5uypvDOdgDCnYCobDF8ocZ4e1YfeY+suemRW4BlEeJEBHYYT6ZlhU5wrN9
	 WxNR8FQsO/1aHL+iuUPcJ2cTVJmgioq6lkuiMSPaser1GN+YZs9aFxOBiJ7HCKy8jV
	 sx/N2dXH6B22TJovL9YXmMuL7KNYWBpNkKZOiSSvVpMuhQbF7E0LPEEs8o+g3kaObn
	 S1DkXCMcKsjQJcYa6Ky8aG1TAb0TcTDMFf/dfWNS6o7O1pSHIrk/dOQPaT84PggnwQ
	 5bPc5kqKKhh8g==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv4 0/5] nvme-fc: FPIN link integrity handling
Date: Tue,  6 May 2025 17:35:02 +0200
Message-Id: <20250506153507.83094-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_083519_710403_677CDA32 
X-CRM114-Status: GOOD (  11.83  )
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

FPIN LI (link integrity) messages are received when the attached
fabric detects hardware errors. In response to these messages I/O
should be directed away from the affected ports, and only used
if the 'optimized' paths are unavailable.
Upon port reset the paths should be put back in service as the
affected hardware might have been replaced.
This patch adds a new controller flag 'NVME_CTRL_MARGINAL'
which will be checked during multipath path selection, causing the
path to be skipped when checking for 'optimized' paths. If no
optimized paths are available the 'marginal' paths are considered
for path selection alongside the 'non-optimized' paths.
It also introduces a new nvme-fc callback 'nvme_fc_fpin_rcv()' to
evaluate the FPIN LI TLV payload and set the 'marginal' state on
all affected rports.

Changes to the original submission:
- Changed flag name to 'marginal'
- Do not block marginal path; influence path selection instead
  to de-prioritize marginal paths

Changes to v2:
- Split off driver-specific modifications
- Introduce 'union fc_tlv_desc' to avoid casts

Changes to v3:
- Include reviews from Justin Tee
- Split marginal path handling patch

Hannes Reinecke (5):
  fc_els: use 'union fc_tlv_desc'
  nvme-fc: marginal path handling
  nvme-fc: nvme_fc_fpin_rcv() callback
  lpfc: enable FPIN notification for NVMe
  qla2xxx: enable FPIN notification for NVMe

 drivers/nvme/host/core.c         |   1 +
 drivers/nvme/host/fc.c           |  99 +++++++++++++++++++
 drivers/nvme/host/multipath.c    |  17 ++--
 drivers/nvme/host/nvme.h         |   6 ++
 drivers/scsi/lpfc/lpfc_els.c     |  84 ++++++++--------
 drivers/scsi/qla2xxx/qla_isr.c   |   3 +
 drivers/scsi/scsi_transport_fc.c |  27 +++--
 include/linux/nvme-fc-driver.h   |   3 +
 include/uapi/scsi/fc/fc_els.h    | 165 +++++++++++++++++--------------
 9 files changed, 266 insertions(+), 139 deletions(-)

-- 
2.35.3


