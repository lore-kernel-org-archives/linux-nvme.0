Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479AAC369D9
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 06:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LqYHFr0mrgMqrUwwElLjieyeFAIun+7PKR9DKA06zOo=; b=dwGi225/gz0/Q3A7y9Isl4IQPI
	UhgcuneFAzeqXdTHbcJOpo+uEKeZmigODBYUj+qDtNUfkyGVJbZNXwGvMQYDa5sfwh3wLEXyOIjmO
	eN6LSKnEltGvvH+Lzar0byNtt1919JthYIX0/O2/JrZvvCxQW8s1qeK5wWIjIVA7+DG6uFIMlBmz7
	t1XvJeSWq1nMJj7ysnSlArC6pcqVwLYXtXfaoW9M2RadGPagGh1yatgmiaGY+JOmRrJ1/U5iw3FSV
	wExMRJDT01ud9NBwXmiAr4qcmtDZB/jZJqK3PNwouWOOyw0j1PXpR+1TPI0TOdiO2wlaDbSJTEC4i
	W9Jovnvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9I6p-00000005752-0Jlt;
	Mon, 28 Apr 2025 06:36:55 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9I6e-0000000572c-1QAP
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 06:36:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 28670A49BDB;
	Mon, 28 Apr 2025 06:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6762AC4CEE4;
	Mon, 28 Apr 2025 06:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745822202;
	bh=M9Gas2kpjN0/jFi+ZvN27rKgyeYGSVrVCfXbZN4Oyjw=;
	h=From:To:Cc:Subject:Date:From;
	b=RLQkQ2sL3SNyyX4NPRRWGZ9dR6TWXxHekTba+orS1S7pFKjXgwZI0pmZj/LcDGEyu
	 ibioLjEwb7HEiDcUbzI+SJcMOkK+GSeeehMPlKucSnLPbapD+LMtAkqWfAPKiz3Iqy
	 58x4HN2Avj2sLosM9Q+6iSPVlcDI6qP9XtaAUNniuBLgPh/D4Dh1gKa1eZTtpZZKwd
	 yQMQMWcmZwH69M8xINag4yG0diDJ6GPLyFb50Hh7FYN0zwieUc0HEoSlWzWmb4twh2
	 RIvww7s2vTENSWHmT0pARALSWGdOzUWJIMdZ9wF5GjxWp3+HI7Upu7Ja0BQoVJgXPr
	 o0O3rgkLOChag==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv3 0/4] nvme-fc: FPIN link integrity handling
Date: Mon, 28 Apr 2025 08:36:31 +0200
Message-Id: <20250428063635.125879-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250427_233644_448909_69F2965A 
X-CRM114-Status: GOOD (  11.20  )
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

From: Hannes Reinecke <hare@kernel.org>

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

Changes to the original submission:
- Changed flag name to 'marginal'
- Do not block marginal path; influence path selection instead
  to de-prioritize marginal paths

Changes to v2:
- Split off driver-specific modifications
- Introduce 'union fc_tlv_desc' to avoid casts

Hannes Reinecke (4):
  fc_els: use 'union fc_tlv_desc'
  nvme-fc: marginal path handling
  lpfc: enable FPIN notification for NVMe
  qla2xxx: enable FPIN notification for NVMe

 drivers/nvme/host/core.c         |   1 +
 drivers/nvme/host/fc.c           |  99 +++++++++++++++++++
 drivers/nvme/host/multipath.c    |  17 ++--
 drivers/nvme/host/nvme.h         |   6 ++
 drivers/scsi/lpfc/lpfc_els.c     |  72 +++++++-------
 drivers/scsi/qla2xxx/qla_isr.c   |   1 +
 drivers/scsi/scsi_transport_fc.c |  27 +++--
 include/linux/nvme-fc-driver.h   |   3 +
 include/uapi/scsi/fc/fc_els.h    | 165 +++++++++++++++++--------------
 9 files changed, 256 insertions(+), 135 deletions(-)

-- 
2.35.3


