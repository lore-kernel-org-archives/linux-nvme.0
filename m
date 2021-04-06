Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A34C433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 05:59:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958E36128D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 05:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958E36128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DQpvO0ECp4HUkj1mxMGdzOxLsOchKUvF+lZAVmEez3I=; b=NYLEo72xOiRmzubq9vjhuRyOc5
	5IOD6Uh5DOMNtWWNiuFrFR1qD+QYA6U1kFnfhQszptIZRS1Af+7Wy3GJ/hagbM2GISmCYC57I0jlB
	XD4v5fmsxX7IITEehqapxyeqQBS/Lg/zkfrjMjZhXMgungj3FnbwLN7uE/LG67n8zbSkuBZf/9tYw
	0fafLTM5SwGdVmGzHVsBDqAhP24MrxMyFDXD6iemlDgm4o7S6yyXGXuIy26NWo+lc3S9f8TjDq6rM
	x/fOSLBR2RAwIZS+nZrXwhy5m3ggbPU4Am8/siqKTDTtTnxy5wpL+PGHQXi4xxzc4z8K5+NG4GJ+B
	rDtvWDgA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lU1ED-0049t7-Lh; Wed, 07 Apr 2021 05:59:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU1E6-0049qv-4g
 for linux-nvme@desiato.infradead.org; Wed, 07 Apr 2021 05:59:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=3qd7q0Rx2iVXcKZFTI2lOYJoX6ZU643OKzYZjcUXKcs=; b=DoHzMIV+J5VQgaekA5UM2EWy6K
 282iNHlrA7pPl/PiGyfaBb+2CbtrvouRsq3g6HAJlkQtfCwumWijiRmBmlLdut713VBpe+4wTDCkx
 DNmtc0X/YqXk01C2HlH1wh8WjAdtcFhP3RyW/DiBqFd0UqhqvaXu/vAoVR0K6hlWHrYGtFfvlbecj
 la5D1laJiLVB9J7ZghX6UWK6/zpgl53qsCnocoynExhExyPDmh9A7Nska2sdl1qXmvwCTLaNmFQ9S
 FvzXKxv9y+ZsYh7T9baPIcdsm8bPC9fSyfPiUlQaLp1XweiNLoIgpOvCNr2repPEdRw99zAD7dnpn
 eUdrJpWg==;
Received: from saphodev.broadcom.com ([192.19.232.172]
 helo=relay.smtp-ext.broadcom.com)
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU1Dg-00DyT0-8K
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 05:59:31 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 4A285828A;
 Tue,  6 Apr 2021 22:58:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4A285828A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1617775137;
 bh=nT3x3+hl0h44eCepYM/vCImNksgt2ni3AeJu7f6pqY8=;
 h=From:To:Cc:Subject:Date:From;
 b=IXoF4Us+Whx7wbBrf1F9Cohrk4PmJ7+1QFX614n6HgA/Y2BTGe70oKdU/IgL1Ixdh
 2eTmyvRqJ8ufMpvM0SJmHxYL7MoE5nNFctYsSdfj1MFYp5iK1w7gGc2PTv2pvlOWCs
 GOi8AZ34Wp55WusM3/T2NjRtx39z5qHEvu1I5qjg=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Muneendra <muneendra.kumar@broadcom.com>
Subject: [PATCH v9 00/13] blkcg:Support to track FC storage blk io traffic
Date: Wed,  7 Apr 2021 04:36:24 +0530
Message-Id: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_065929_582229_DE670654 
X-CRM114-Status: GOOD (  14.57  )
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
in  the blkcg associted with cgroup id under
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

The patches were cut against  5.13/scsi-queue tree

v9:
Addressed the issues reported by kernel test robot
Replaced lpfc_get_vmid_from_hashtable with the
generic kernel based hashtable (include/linux/hashtable.h)
and made the changes in the code accordingly.
Addressed the locking issue and also merged few patches

v8:
Modified the structure member,log messages and function declarations
Added proper error codes and return values

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



Gaurav Srivastava (10):
  lpfc: vmid: Add the datastructure for supporting VMID in lpfc
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

Muneendra (3):
  cgroup: Added cgroup_get_from_id
  blkcg: Added a app identifier support for blkcg
  nvme: Added a newsysfs attribute appid_store

 block/Kconfig                    |   9 +
 drivers/nvme/host/fc.c           |  73 +++++-
 drivers/scsi/Kconfig             |  13 ++
 drivers/scsi/lpfc/lpfc.h         | 122 +++++++++++
 drivers/scsi/lpfc/lpfc_attr.c    |  48 ++++
 drivers/scsi/lpfc/lpfc_crtn.h    |  11 +
 drivers/scsi/lpfc/lpfc_ct.c      | 257 +++++++++++++++++++++-
 drivers/scsi/lpfc/lpfc_disc.h    |   1 +
 drivers/scsi/lpfc/lpfc_els.c     | 366 ++++++++++++++++++++++++++++++-
 drivers/scsi/lpfc/lpfc_hbadisc.c | 147 +++++++++++++
 drivers/scsi/lpfc/lpfc_hw.h      | 124 ++++++++++-
 drivers/scsi/lpfc/lpfc_hw4.h     |  12 +
 drivers/scsi/lpfc/lpfc_init.c    | 104 +++++++++
 drivers/scsi/lpfc/lpfc_mbox.c    |   6 +
 drivers/scsi/lpfc/lpfc_scsi.c    | 316 ++++++++++++++++++++++++++
 drivers/scsi/lpfc/lpfc_sli.c     |  63 ++++++
 drivers/scsi/lpfc/lpfc_sli.h     |   8 +
 include/linux/blk-cgroup.h       |  56 +++++
 include/linux/cgroup.h           |   6 +
 kernel/cgroup/cgroup.c           |  26 +++
 20 files changed, 1758 insertions(+), 10 deletions(-)

-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
