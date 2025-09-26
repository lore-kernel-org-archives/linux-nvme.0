Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DBECAC5B5
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Sep 2025 00:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Wvu9uFFeJOFDOc53VVq5RN+mSYEcZ4WSKOSXb2ynPRM=; b=AZbNIpSxsytAC1+3lcB99WRTGU
	uWBvBL6Ws5YkJyBTohAWHwJVLXfIM/ufLs+vRWbzkl0linzba97ZB9bngtIIC9irfoyS/yUphW2b0
	VOq19V/UC4R6Y6SodYZBhqo+Fhjbm1z4b6pcMkg8rLP2/in3FvPwx+3S+mNba53qAJjfn7wpHjPAb
	2mVsQjHzk/WOuicu+UYSX/s02tENTnBcKg5X8ZS+D2zYPYNxiqhr0KaPFX/BfO3ZGGn0dAlGrVZV7
	IZhj72RDHrc+EvB1G43Yarptm7+IhAd/3N+1/jPhZ8JooPnKEhoux4rQ19Q2qD+d9RQgpg0PaQcBG
	xJBgzUEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1vuk-0000000EAYI-0hRM;
	Fri, 26 Sep 2025 00:02:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1vug-0000000EAXV-0JFh
	for linux-nvme@lists.infradead.org;
	Fri, 26 Sep 2025 00:02:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758844932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wvu9uFFeJOFDOc53VVq5RN+mSYEcZ4WSKOSXb2ynPRM=;
	b=adG57n1VdZ73iU7aI242mEwXuqvgVWrr7JWsPuzG+YOFAHU0eJwj9rkaeyh/H7j66dhFDO
	b7EnlI/1MAFtw2kfo/OQy5AipX3UWgqs/S2Y2yTkgTZwFZ/OKhmD3Yz8DqfXrfq7nO7SBE
	umfLQRLbtee/djeQSzp6KAgq2LqwUCo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-HynJ0YY2PzKJbxUkpHmGHA-1; Thu,
 25 Sep 2025 20:02:09 -0400
X-MC-Unique: HynJ0YY2PzKJbxUkpHmGHA-1
X-Mimecast-MFC-AGG-ID: HynJ0YY2PzKJbxUkpHmGHA_1758844928
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27E7319774D4;
	Fri, 26 Sep 2025 00:02:07 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen7.rmtusnh.csb (unknown [10.22.81.200])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD9631800579;
	Fri, 26 Sep 2025 00:02:03 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: hare@suse.de,
	kbusch@kernel.org,
	martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: bgurney@redhat.com,
	axboe@kernel.dk,
	emilne@redhat.com,
	gustavoars@kernel.org,
	hch@lst.de,
	james.smart@broadcom.com,
	jmeneghi@redhat.com,
	kees@kernel.org,
	linux-hardening@vger.kernel.org,
	njavali@marvell.com,
	sagi@grimberg.me
Subject: [PATCH v10 00/11] nvme-fc: FPIN link integrity handling 
Date: Thu, 25 Sep 2025 20:01:49 -0400
Message-ID: <20250926000200.837025-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_170214_542365_E780EB97 
X-CRM114-Status: GOOD (  22.75  )
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

FPIN LI (link integrity) messages are received when the attached fabric
detects hardware errors. In response to these messages I/O should be
directed away from the affected ports, and only used if the 'optimized'
paths are unavailable.  Upon port reset the paths should be put back in
service as the affected hardware might have been replaced.  This patch
adds a new controller flag 'NVME_CTRL_MARGINAL' which will be checked
during multipath path selection, causing the path to be skipped when
checking for 'optimized' paths. If no optimized paths are available the
'marginal' paths are considered for path selection alongside the
'non-optimized' paths.  It also introduces a new nvme-fc callback
'nvme_fc_fpin_rcv()' to evaluate the FPIN LI TLV payload and set the
'marginal' state on all affected rports.

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

Testing has been performed by sending all FPIN LI ELS messages from the
switch to the Host and verifying the proper nvme multi-pathing behavior
is effected with each of the eight different FPIN link integrity events.
Results were verified with iostat and with the nvme list-subsys command.

These tests were run with all scenarios including where there were only
non-optimized paths available, and where all paths were
marginal/degraded. All multi-path io-policies were tested including:
numa, round-robin and queue-depth. When all paths on the host are
marginal/degraded, I/O continues on the optimized path that was most
recently non-marginal.  If both of the optimized paths are down, I/O
properly continues on one of the marginal/degraded non-optimized paths.

Testing has been complete with both Broadcom (lpfc) and Marvell (qla2xx)
32GB HBAs.  Both HBAs successfully complete all tests.

For a complete description of the tests that were run, please see
bugzilla 20329.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220329

New refactored implmentation enables administrators to manually control
port marginal states via sysfs. For example:

# Set remote port to marginal state
echo "Marginal" > /sys/class/fc_remote_ports/rport-4:0-1/port_state

# Clear marginal state (set to online)
echo "Online" > /sys/class/fc_remote_ports/rport-4:0-1/port_state

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

Changes to v8:
- Rebased patch series to nvme-6.17.
- Added patch from Gustavo Silva, "scsi: qla2xxx: Fix memcpy field-spanning
  write issue", which resolves the field-spanning write issue
- We decided to leave the "marginal" state as is, because the transport
  driver uses the term "marginal".

Changes to v9:
- Rebased patch series to nvme-6.18.
- Refactor and fix a patch from Gustavo Silva, "scsi: qla2xxx: Fix 2 memcpy
  field-spanning write issue", which resolves the field-spanning write issue.
  This new version of Gustavo's patch fixes a bug found in testing.
- Refactored original implementation
  New functions added:
    nvme_fc_lport_from_wwpn() - Find local port by WWPN
    nvme_fc_fpin_set_state() - Set marginal state on controllers
    nvme_fc_modify_rport_fpin_state() - Main API function
  Functions removed:
    nvme_fc_fpin_li_lport_update() - FPIN processing logic
    nvme_fc_fpin_rcv() - Direct FPIN message processing
  Functions modified:
    fc_rport_set_marginal_state - allows administrative control

This patch series is based upon nvme-6.18.

Bryan Gurney (2):
  nvme: add NVME_CTRL_MARGINAL flag
  nvme: sysfs: emit the marginal path state in show_state()

Gustavo A. R. Silva (1):
  scsi: qla2xxx: Fix 2 memcpy field-spanning write issue

Hannes Reinecke (2):
  fc_els: use 'union fc_tlv_desc'
  nvme-fc: marginal path handling

John Meneghini (6):
  nvme-multipath: queue-depth support for marginal paths
  nvme-fc: add nvme_fc_modify_rport_fpin_state()
  scsi: scsi_transport_fc: add fc_host_fpin_set_nvme_rport_marginal()
  scsi: lpfc: enable FPIN notification for NVMe
  scsi: qla2xxx: enable FPIN notification for NVMe
  scsi: scsi_transport_fc: user support for clearing NVME_CTRL_MARGINAL

 drivers/nvme/host/core.c         |   1 +
 drivers/nvme/host/fc.c           |  80 +++++++++++++++
 drivers/nvme/host/multipath.c    |  24 +++--
 drivers/nvme/host/nvme.h         |   6 ++
 drivers/nvme/host/sysfs.c        |   4 +-
 drivers/scsi/lpfc/lpfc_els.c     |  82 ++++++++-------
 drivers/scsi/qla2xxx/qla_def.h   |  10 +-
 drivers/scsi/qla2xxx/qla_isr.c   |  18 ++--
 drivers/scsi/qla2xxx/qla_nvme.c  |   2 +-
 drivers/scsi/qla2xxx/qla_os.c    |   9 +-
 drivers/scsi/scsi_transport_fc.c | 154 ++++++++++++++++++++++++-----
 include/linux/nvme-fc-driver.h   |   2 +
 include/scsi/scsi_transport_fc.h |   1 +
 include/uapi/scsi/fc/fc_els.h    | 165 +++++++++++++++++--------------
 14 files changed, 391 insertions(+), 167 deletions(-)

-- 
2.51.0


