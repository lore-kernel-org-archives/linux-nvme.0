Return-Path: <SRS0=rRT3=GK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B05C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 04:54:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16AAF23118
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 04:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AAF23118
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9kELB/mC8oP4UiuReZUIE6xswlvKLwIrqY1H/AAtLD8=; b=erocYCs4sjcwijkesAquhfFwUT
	sshRQ0QjyI6ibIybWlZ4e+tX8j/7iJpf3UM5bRGGq9Je65P6aRn5iggvSj6oRXGqu10/YUqH9bPQN
	nF+9dIJTB2OWP+mRDTcOTMVTDdYq3nsku6T0jineaxpexYVb2JYN9kgsAV4eu+5oOoogrJgp2u06U
	TqrEnzDIHCKcb0OZi9YUBAPJha+H8pE3sxZAzBU2dDVtWAQ7xNTEPtgr6CfFFXZfchhp0v9apvdY2
	i192wu1RP6aBQOTRM/DDSYtd9inzpGxqino+xAYs0l7KUaIx1O1ftKZKMz3MDP7mOAFsUW10NqL9W
	xTFmGnJQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxNJe-00081g-Ml; Thu, 07 Jan 2021 04:54:30 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxNJa-0007zM-Ae
 for linux-nvme@merlin.infradead.org; Thu, 07 Jan 2021 04:54:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=4oInMZarf9FwxYLkkisIPmrydhZh7/5qerA3GRaIzok=; b=U7IWiRkEg+ltJkd5iKLbJO3TM5
 YEwfqR/90Ddvx2DL+/A94E0S25AiBP9AO8GgSiFbkmAy7WFkeD5pVvvWRWYN5EcTTrwj5WUkDQh2w
 MHirOslVLgar1uWAoMDKEvZkzz0EGoMmjJpVOBLZVZOGprnxToCZUWAKrjJtSE+n2tLu4sR9b1PzI
 395RA7wVNYDkTc8PrODIPmZEjTZf0qT6xZLZxzZl3Re8jfP9ChiwypCCUKkVP6L9ZzvNDMeFs/tOU
 KgMtAokLDC3ToS+/Khg2Vw3A1ZmiOfIHyoYUwEBSnFb6oKkrFw4nQiJcXeJf/fUwyyubOC0wXAIP+
 t7SrVLVA==;
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1kxNJ0-0032qr-Lt
 for linux-nvme@lists.infradead.org; Thu, 07 Jan 2021 04:54:13 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id CD6F23888C;
 Wed,  6 Jan 2021 20:53:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com CD6F23888C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1609995199;
 bh=f/2I+FLZjC0fqYnR3obg3qRmBz5qh2SymcdHUZZffN8=;
 h=From:To:Cc:Subject:Date:From;
 b=C5N3x28uKK2SQkyCThDksWxhZ1QuQQ2hI9Swgn1yY6cs6EGJDtj+Gc3brV2aYZLm5
 oX7mrqbDUODZAh0pbW1scG7lxEG7GipE8RNpKEW04KPHjroJFdWRGIxJHo2DHxe4Nm
 VbHiQbRjGyvp8h5EgHaOoEshAdQAcpq1qVUawwEo=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Subject: [PATCH v7 00/16] blkcg:Support to track FC storage blk io traffic
Date: Thu,  7 Jan 2021 03:30:14 +0530
Message-Id: <1609970430-19084-1-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210107_045413_291387_C4C5FEE1 
X-CRM114-Status: GOOD (  14.61  )
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
Cc: Muneendra <muneendra.kumar@broadcom.com>, jsmart2021@gmail.com,
 mkumar@redhat.com, emilne@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This Patch added a unique application identifier i.e
app_id  knob to  blkcg which allows identification of traffic
sources at an individual cgroup based Applications
(ex:virtual machine (VM))level in both host and
fabric infrastructure.

Added a new sysfs attribute appid_store to set the application identfier
in  the blkcg associted with cgroup id
/sys/class/fc/fc_udev_device/*
With this new interface the user can set the application identfier
in  the blkcg associted with cgroup id.

This capability can be utilized by multiple block transport infrastructure
like fc,iscsi,roce.

Existing FC fabric will use this feature and the description of
the use case is below.

Various virtualization technologies used in Fibre Channel
SAN deployments have created the opportunity to identify
and associate traffic with specific virtualized applications.
The concepts behind the T11 Application Services standard is
to provide the general mechanisms needed to identify
virtualized services.
It enables the Fabric and the storage targets to
identify, monitor, and handle FC traffic
based on vm tags by inserting application specific identification
into the FC frame.

The patches were cut against  5.11/scsi-queue tree

v7:
Modified the Kconfig comments

v6:
Addressed the issues reported by kernel test robot
Modified the Kconfig files as per standard

v5:
Renamed the function cgroup_get_from_kernfs_id to
cgroup_get_from_id.

Moved the input validation at the beginning of the function in 
Renamed the arguments appropriatley.

Changed Return code to non-numeric/SymbolChanged Return code
to non-numeric/Symbol

Modified the comments.

v4:
Addressed the error reported by  kernel test robot

v3:
removed RFC.

Renamed the functions and app_id to more specific
Addressed the reference leaks in blkcg_set_app_identifier
Added a new config BLK_CGROUP_FC_APPID and made changes to 
select the same under SCSI_FC_ATTRS

V2:
renamed app_identifier to app_id.
removed the  sysfs interface blkio.app_identifie under
/sys/fs/cgroup/blkio
Ported the patch on top of 5.10/scsi-queue.
Removed redundant code due to changes since last submit.
Added a fix for issuing QFPA command.



Gaurav Srivastava (12):
  lpfc: vmid: Add the datastructure for supporting VMID in lpfc
  lpfc: vmid: Supplementary data structures for vmid and APIs
  lpfc: vmid: Forward declarations for APIs
  lpfc: vmid: VMID params initialization
  lpfc: vmid: Add support for vmid in mailbox command, does vmid
    resource allocation and vmid cleanup
  lpfc: vmid: Implements ELS commands for appid patch
  lpfc: vmid: Functions to manage vmids
  lpfc: vmid: Implements CT commands for appid.
  lpfc: vmid: Appends the vmid in the wqe before sending
  lpfc: vmid: Timeout implementation for vmid
  lpfc: vmid: Adding qfpa and vmid timeout check in worker thread
  lpfc: vmid: Introducing vmid in io path.

Muneendra (4):
  cgroup: Added cgroup_get_from_id
  blkcg: Added a app identifier support for blkcg
  nvme: Added a newsysfs attribute appid_store
  scsi: Made changes in Kconfig to select BLK_CGROUP_FC_APPID

 block/Kconfig                    |   9 +
 drivers/nvme/host/fc.c           |  73 +++++-
 drivers/scsi/Kconfig             |  13 ++
 drivers/scsi/lpfc/lpfc.h         | 121 ++++++++++
 drivers/scsi/lpfc/lpfc_attr.c    |  47 ++++
 drivers/scsi/lpfc/lpfc_crtn.h    |  11 +
 drivers/scsi/lpfc/lpfc_ct.c      | 252 +++++++++++++++++++++
 drivers/scsi/lpfc/lpfc_disc.h    |   1 +
 drivers/scsi/lpfc/lpfc_els.c     | 369 ++++++++++++++++++++++++++++++-
 drivers/scsi/lpfc/lpfc_hbadisc.c | 153 +++++++++++++
 drivers/scsi/lpfc/lpfc_hw.h      | 124 ++++++++++-
 drivers/scsi/lpfc/lpfc_hw4.h     |  12 +
 drivers/scsi/lpfc/lpfc_init.c    | 109 +++++++++
 drivers/scsi/lpfc/lpfc_mbox.c    |   6 +
 drivers/scsi/lpfc/lpfc_scsi.c    | 334 ++++++++++++++++++++++++++++
 drivers/scsi/lpfc/lpfc_sli.c     |  65 +++++-
 drivers/scsi/lpfc/lpfc_sli.h     |   8 +
 include/linux/blk-cgroup.h       |  56 +++++
 include/linux/cgroup.h           |   6 +
 kernel/cgroup/cgroup.c           |  26 +++
 20 files changed, 1782 insertions(+), 13 deletions(-)

-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
