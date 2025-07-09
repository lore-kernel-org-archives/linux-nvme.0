Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A51C83F18
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jul 2025 22:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RMSEzuSMHQUet25qqmNOIuxpcUMMqMmw4+avLlRu0QY=; b=rDskkCDemu9QFSkw0Wp2IN66Ut
	SmOtm0rweTtDOsEpcL6lZQ6zHa8NWpkCUr5pnG1C464JrbC2sDztZC+iQag+nskPd2yFDsrWHSe3S
	LxWVXWNTUPW5N97ER65m7HXCJ4MRwZLPmjbegVvPGrR17UyHGMVJ7aUgoWq5G6eiIGM6pLV5pmpe2
	ZbFU+DZYaHtnpJSFFds6aQ8+zRwcrCAOXEbNmGQstp00rJRLyuvFFmh5cxKXAypbeUDr1TsoUU2rr
	mxSKHn8EeaavvGC4hHJTcr4Uj410fn4clG/cwMRSwakz3PuLKZvu/WJwDUfNbM3mJhJCoDe4EBNh6
	y2LxdJgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZdj1-0000000A9dh-2H3r;
	Wed, 09 Jul 2025 22:57:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZcCk-00000009tXe-009t
	for linux-nvme@lists.infradead.org;
	Wed, 09 Jul 2025 21:19:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752095988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RMSEzuSMHQUet25qqmNOIuxpcUMMqMmw4+avLlRu0QY=;
	b=YLAl3wan1i9kFCcsFlhDFTcpZbWG/gkYZbDBJFGnyCY0uuiC2JQJHWz8pnVUsDncVqDww6
	EqPts9O3QgjJ9k8fGUl5klkQyKRyksg+lP13gRZU3vo7vBxYZoNC2paFn3/I1EufdMmW3E
	7Olh2XjakUrrPtQ2KcFZ7NEJXogDmfI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-D5aLalJtOQe3R7O72F2XtQ-1; Wed,
 09 Jul 2025 17:19:44 -0400
X-MC-Unique: D5aLalJtOQe3R7O72F2XtQ-1
X-Mimecast-MFC-AGG-ID: D5aLalJtOQe3R7O72F2XtQ_1752095983
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6033180028C;
	Wed,  9 Jul 2025 21:19:41 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.44.33.49])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0A2D30001B1;
	Wed,  9 Jul 2025 21:19:34 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	njavali@marvell.com,
	linux-scsi@vger.kernel.org,
	hare@suse.de,
	bgurney@redhat.com,
	jmeneghi@redhat.com
Subject: [PATCH v8 0/8] nvme-fc: FPIN link integrity handling
Date: Wed,  9 Jul 2025 17:19:11 -0400
Message-ID: <20250709211919.49100-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250709_141950_112784_7D12CD38 
X-CRM114-Status: GOOD (  19.30  )
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

The testing for this patch set was performed by Bryan Gurney, using the
process outlined by John Meneghini's presentation at LSFMM 2024, where
the fibre channel switch sends an FPIN notification on a specific switch
port, and the following is checked on the initiator:

1. The controllers corresponding to the paths on the port that has
received the notification are showing a set NVME_CTRL_MARGINAL flag.

   \
    +- nvme4 fc traddr=c,host_traddr=e live optimized
    +- nvme5 fc traddr=8,host_traddr=e live non-optimized
    +- nvme8 fc traddr=e,host_traddr=f marginal optimized
    +- nvme9 fc traddr=a,host_traddr=f marginal non-optimized

2. The I/O statistics of the test namespace show no I/O activity on the
controllers with NVME_CTRL_MARGINAL set.

   Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s
   nvme4c4n1         0.00         0.00         0.00         0.00
   nvme4c5n1     25001.00         0.00        97.66         0.00
   nvme4c9n1     25000.00         0.00        97.66         0.00
   nvme4n1       50011.00         0.00       195.36         0.00


   Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s
   nvme4c4n1         0.00         0.00         0.00         0.00
   nvme4c5n1     48360.00         0.00       188.91         0.00
   nvme4c9n1      1642.00         0.00         6.41         0.00
   nvme4n1       49981.00         0.00       195.24         0.00


   Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s
   nvme4c4n1         0.00         0.00         0.00         0.00
   nvme4c5n1     50001.00         0.00       195.32         0.00
   nvme4c9n1         0.00         0.00         0.00         0.00
   nvme4n1       50016.00         0.00       195.38         0.00

Link: https://people.redhat.com/jmeneghi/LSFMM_2024/LSFMM_2024_NVMe_Cancel_and_FPIN.pdf

More rigorous testing was also performed to ensure proper path migration
on each of the eight different FPIN link integrity events, particularly
during a scenario where there are only non-optimized paths available, in
a state where all paths are marginal.  On a configuration with a
round-robin iopolicy, when all paths on the host show as marginal, I/O
continues on the optimized path that was most recently non-marginal.
From this point, of both of the optimized paths are down, I/O properly
continues on the remaining paths.

The testing so far has been done with an Emulex host bus adapter using
lpfc.  When tested on a QLogic host bus adapter, a warning was found
when the first FPIN link integrity event was received by the host:

  kernel: memcpy: detected field-spanning write (size 60) of single field
  "((uint8_t *)fpin_pkt + buffer_copy_offset)"
  at drivers/scsi/qla2xxx/qla_isr.c:1221 (size 44)

Line 1221 of qla_isr.c is in the function qla27xx_copy_fpin_pkt().


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

Changes to v4:
- Change 'u8' to '__u8' on fc_tlv_desc to fix a failure to build
- Print 'marginal' instead of 'live' in the state of controllers
  when they are marginal

Changes to v5:
- Minor spelling corrections to patch descriptions

Changes to v6:
- No code changes; added note about additional testing

Changes to v7:
- Split nvme core marginal flag addition into its own patch
- Add patch for queue_depth marginal path support

Bryan Gurney (2):
  nvme: add NVME_CTRL_MARGINAL flag
  nvme: sysfs: emit the marginal path state in show_state()

Hannes Reinecke (5):
  fc_els: use 'union fc_tlv_desc'
  nvme-fc: marginal path handling
  nvme-fc: nvme_fc_fpin_rcv() callback
  lpfc: enable FPIN notification for NVMe
  qla2xxx: enable FPIN notification for NVMe

John Meneghini (1):
  nvme-multipath: queue-depth support for marginal paths

 drivers/nvme/host/core.c         |   1 +
 drivers/nvme/host/fc.c           |  99 +++++++++++++++++++
 drivers/nvme/host/multipath.c    |  24 +++--
 drivers/nvme/host/nvme.h         |   6 ++
 drivers/nvme/host/sysfs.c        |   4 +-
 drivers/scsi/lpfc/lpfc_els.c     |  84 ++++++++--------
 drivers/scsi/qla2xxx/qla_isr.c   |   3 +
 drivers/scsi/scsi_transport_fc.c |  27 +++--
 include/linux/nvme-fc-driver.h   |   3 +
 include/uapi/scsi/fc/fc_els.h    | 165 +++++++++++++++++--------------
 10 files changed, 275 insertions(+), 141 deletions(-)

-- 
2.50.0


