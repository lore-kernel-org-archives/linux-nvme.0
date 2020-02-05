Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56CEC35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:38:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE0A2072B
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c6Z9AUF3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7JDKVEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE0A2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=kSV9/O7bx8iHLeEp57Vwd6JSulzFyhRrZXwwBeIaE4w=; b=c6Z
	9AUF35b+5alV5+t7nRCo6fOXSRRjjXeubiyMreapM8BSh4DGC6O6ZNJjPVZX4yhyl/g0nKcW/Q0X2
	9lSGvj65ZA+qEkJwcGLsr53XH1khSXk3mdXHtBx/yxIvLAF33vc/bBfxRa8t2DN6JTkdeIOEBuUTI
	dwZRr1AaEYFX/YtQwiYirrCqGBFxmn6nbw1cCZ2FiQ0feUMP2EBN8aVdVYjQa9gSpcAQjpBttogL+
	n0JhRE/bI3nWsAU/qJKxisLkvcgAv8S0qfI394T54H7NFgP//G/O6xBmtGfIgnaGCuMQQ6Rzx94Zn
	FBA45SARYDR1p5UTOZ9RRqltIVIoCaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPYu-0003R2-Fo; Wed, 05 Feb 2020 18:38:08 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPYq-0003Pu-D3
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:38:05 +0000
Received: by mail-wm1-x334.google.com with SMTP id f129so4071487wmf.2
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=WhIR/RQvEIuGCotuPv2yKWrhmSc+jt0q9JX9SmAoBvU=;
 b=K7JDKVEo6mS6JgJ1tk7FTfQck4fgtcDYHIyOaq9Xyog0YM15OH8/NJsOJimuHs3+Mn
 U10YmQHftOnyH30ijyW4rXy59evxYBi6DtrFA1gXDzxd4rjAsgT2NFDf6MMt0nfbxS/j
 O0xgDPAJCBCOlCNbvbSyNf1gNVvxKEmdh85nSEHQx3rrSEjMIP2Ak6/qRl3bHJDMtgU0
 35rpvyZ0mVCNdrNgaa+64XDIcN3SAyubx6b3aMu+LKbpbIZIH4HPif4IbDtKqwgTjjPB
 w/8yiTSc3l0OqYCTPK//Yu4PFEaMt/eBTO36iceQe9Axvt39xwWkVGBl73jtr4hB07XR
 qhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=WhIR/RQvEIuGCotuPv2yKWrhmSc+jt0q9JX9SmAoBvU=;
 b=Ui8Do5DMeHmDkPI3xUHJdq2fm1IhsL29ewdeakc8im+yGNa09R9VUoE0sJ5rs56KNf
 6J5WUJt4Fg/KDq11sOluyNfqFDJ+iyfNu2TY+LGHiLQknImOQY5XBfmpx53YBz/kfrDJ
 kUI5zzpQ+P3YTPMxTfVvj6rGfhUDkiyYQ3Tjkboo4RZCKCqNQO3tuCNOBYXi3pi3DpBZ
 ybtRhf7PF6itAgsOSLSL1PA64AbJBtGJokUZPdqf1m9uS0Y2crtJNUAfRwDXURWc/7zK
 69pQ60xLS5bgE4HzwCr/smmbdYcoLhPqadrmbxxkxVAks3PSK0AkLi3TKI1lVTLSMoL3
 5aRg==
X-Gm-Message-State: APjAAAUS4ZbRgNqX//OYUWSiWHIJDxpS+6pbZGMDKPcwcYPSokILN3Eo
 UKObQd7vTC82Z4YdJP1MgUnZQomg
X-Google-Smtp-Source: APXvYqxG+jryMoFzcGfZDL3BQXZ3sR3afxkuPTFa9SbCAMlsmq5iaSk8u9oIkSrDJHyD3/4c8sidbw==
X-Received: by 2002:a05:600c:21c6:: with SMTP id
 x6mr7133428wmj.177.1580927882212; 
 Wed, 05 Feb 2020 10:38:02 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:01 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 00/29] nvme-fc/nvmet-fc: Add FC-NVME-2 disconnect association
 support
Date: Wed,  5 Feb 2020 10:37:24 -0800
Message-Id: <20200205183753.25959-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103804_445186_2D08A828 
X-CRM114-Status: GOOD (  21.95  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: James Smart <jsmart2021@gmail.com>, martin.petersen@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

At the tail end of FC-NVME (1) standardization, the process for
terminating an association was changed requiring interlock using FC-NVME
Disconnect Assocation LS's between both the host port and target port.
This was immediately relaxed with an ammendment to FC-NVME (1) and with
wording put into FC-NVME-2. The interlock was removed, but it still
required both the host port and target port to initiate Disconnect
Association LS's and respond to LS's.

The linux nvme-fc and nvmet-fc implementations were interoperable with
standards but the linux-driver api did not support all the functionality
needed. It was missing:
- nvme-fc: didn't support the reception of NVME LS's and the ability to
  transmit responses to an LS.
- nvmet-fc: didn't support the ability to send an NVME LS request. It
  also did not support a method for the transport to specify a remote
  port for an LS.

This patch adds the missing functionality. Specifically the patch set:
- Updates the header with the FC-NVME-2 standard out for final approval.
- Refactors data structure names that used to be dependent on role (ls
  requests were specific to nvme; ls responses were specific to nvmet)
  to generic names that can be used by both nvme-fc and nvmet-fc.
- Modifies the nvme-fc transport template with interfaces to receive
  NVME LS's and for the transport to then request LS responses to be
  sent.
- Modifies the nvmet-fc transport template with:
  - The current NVME LS receive interface was modified to supply a
    handle to indentify the remote port the LS as received from. If
    the LS creates an association, the handle may be used to initiate
    NVME LS requests to the remote port. An interface was put in place
    to invalidate the handle on connectivity losses.
  - Interfaces for the transport to request an NVME LS request to be
    performed as well as to abort that LS in cases of error/teardown. 
- The nvme-fc transport was modified to follow the standard:
  - Disconnect association logic was revised to send Disconnect LS as
    soon as all ABTS's were transmit rather than waiting for the ABTS
    process to fully complete.
  - Disconnect LS reception is supported, with reception initiating
    controller reset and reconnect.
  - Disconnect LS responses will not be transmit until association
    termination has transmit the Disconnect LS.
- The nvmet-fc transport was modified to follow the standard:
  - Disconnect assocation logic was revised to transmit a Disconnect LS
    request as soon as all ABTS's have been transmit. In the past, no
    Disconnect LS had been transmit.
  - Disconnect LS responses will not be sent until the Disconnect LS
    request has been transmit.
- nvme-fcloop: was updated with interfaces to allow testing of the
  transports.
- Along the way, cleanups and slight corrections were made to the
  transports.
- The lpfc driver was modified to support the new transport interfaces
  for both the nvme and nvmet transports.  As much of the functionality
  was already present, but specific to one side of the transport,
  existing code was refactored to create common routines. Addition of
  the new interfaces was able to slip in rather easily with the common
  routines.

This code was cut against the for-5.6 branch.

I'll work with Martin to minimize any work to merge these lpfc mods 
with lpfc changes in the scsi tree.

-- james



James Smart (29):
  nvme-fc: Sync header to FC-NVME-2 rev 1.08
  nvmet-fc: fix typo in comment
  nvme-fc and nvmet-fc: revise LLDD api for LS reception and LS request
  nvme-fc nvmet_fc nvme_fcloop: adapt code to changed names in api
    header
  lpfc: adapt code to changed names in api header
  nvme-fcloop: Fix deallocation of working context
  nvme-fc nvmet-fc: refactor for common LS definitions
  nvmet-fc: Better size LS buffers
  nvme-fc: Ensure private pointers are NULL if no data
  nvmefc: Use common definitions for LS names, formatting, and
    validation
  nvme-fc: convert assoc_active flag to atomic
  nvme-fc: Add Disconnect Association Rcv support
  nvmet-fc: add LS failure messages
  nvmet-fc: perform small cleanups on unneeded checks
  nvmet-fc: track hostport handle for associations
  nvmet-fc: rename ls_list to ls_rcv_list
  nvmet-fc: Add Disconnect Association Xmt support
  nvme-fcloop: refactor to enable target to host LS
  nvme-fcloop: add target to host LS request support
  lpfc: Refactor lpfc nvme headers
  lpfc: Refactor nvmet_rcv_ctx to create lpfc_async_xchg_ctx
  lpfc: Commonize lpfc_async_xchg_ctx state and flag definitions
  lpfc: Refactor NVME LS receive handling
  lpfc: Refactor Send LS Request support
  lpfc: Refactor Send LS Abort support
  lpfc: Refactor Send LS Response support
  lpfc: nvme: Add Receive LS Request and Send LS Response support to
    nvme
  lpfc: nvmet: Add support for NVME LS request hosthandle
  lpfc: nvmet: Add Send LS Request and Abort LS Request support

 drivers/nvme/host/fc.c             | 555 +++++++++++++++++++-----
 drivers/nvme/host/fc.h             | 227 ++++++++++
 drivers/nvme/target/fc.c           | 800 +++++++++++++++++++++++++----------
 drivers/nvme/target/fcloop.c       | 228 ++++++++--
 drivers/scsi/lpfc/lpfc.h           |   2 +-
 drivers/scsi/lpfc/lpfc_attr.c      |   3 -
 drivers/scsi/lpfc/lpfc_crtn.h      |   9 +-
 drivers/scsi/lpfc/lpfc_ct.c        |   1 -
 drivers/scsi/lpfc/lpfc_debugfs.c   |   5 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c   |   8 +-
 drivers/scsi/lpfc/lpfc_init.c      |   7 +-
 drivers/scsi/lpfc/lpfc_mem.c       |   4 -
 drivers/scsi/lpfc/lpfc_nportdisc.c |  13 +-
 drivers/scsi/lpfc/lpfc_nvme.c      | 550 ++++++++++++++++--------
 drivers/scsi/lpfc/lpfc_nvme.h      | 198 +++++++++
 drivers/scsi/lpfc/lpfc_nvmet.c     | 837 +++++++++++++++++++++++--------------
 drivers/scsi/lpfc/lpfc_nvmet.h     | 158 -------
 drivers/scsi/lpfc/lpfc_sli.c       | 126 +++++-
 include/linux/nvme-fc-driver.h     | 368 +++++++++++-----
 include/linux/nvme-fc.h            |   9 +-
 20 files changed, 2970 insertions(+), 1138 deletions(-)
 create mode 100644 drivers/nvme/host/fc.h
 delete mode 100644 drivers/scsi/lpfc/lpfc_nvmet.h

-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
