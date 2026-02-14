Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1F1EDF142
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vWvrFVliAreSaQBreORol8DpIbPpwaItTUlHVNdYwK8=; b=PPmFUodlqPU43VX+cmedp6mXXb
	tmppSvnknOuEk7Zr7i2s0XkzuEwLSmBFQhjqDqr4+MBRsf41igpW7c2vZJordn87XP3g3ryvcW2qU
	ix8pyoF/JR1KMDiSOaimTSWZqwjxupQWFm0zTHG1xqKqVROnbc6/ldzTQ04jbZxn+t+4ZMNVAnOB3
	Uc3oQ4mzKsQ5BKCtIfVP+6YD8ZVDr6ynLuiI0/y7xwTz2cdLme9iX9zu+v4XoFX7m3QozVPEqAaCd
	kTmHYzvBSVBl9jzBC6Y3Uj7C4vOWikfDVXcJgFCazqCtXtf/ndsq8Ro5BsSWFzH2ZW5IdS0XVcAov
	y18OkinA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gb-00000004Evz-0UA0;
	Sat, 14 Feb 2026 04:28:25 +0000
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7GY-00000004Euk-0ctf
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:23 +0000
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-1270ac5d3efso1594421c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043301; x=1771648101; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vWvrFVliAreSaQBreORol8DpIbPpwaItTUlHVNdYwK8=;
        b=F4lQQdhzXG/BvhH4Bvcu4mbFIacEaFN+lgytMtcJLpq2gFvEnRwJCpTBwBAvYEGiCX
         c1nJVJI0cwQUz8yQRQMmO7/dpmSkkg1aFzcQ2n+/J3/wgi4LyMseH9qvGbPi8kK7lKfp
         0oiuUHGstP1W6Q4vEY7Ul9ihFx30uU9j6+kidA/0A6iKW1dGu/UuoXIL03VB8/zqy9d/
         MyD9Wvoq40TEzu4XO2/bwPuyoh2rBddGmKYauoFyIT8iDUz6Lsld7yzHuDKp20Cf/wHF
         cDhnwL/5PlPmoZrFHr6sc6mpneOlYkB46JU0m611FHUX4aF+Gm6LBU6oKrUXSyGCy7sj
         VBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043301; x=1771648101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWvrFVliAreSaQBreORol8DpIbPpwaItTUlHVNdYwK8=;
        b=DTUgKzotK2cy2+4F+CP2gHjQc108qCoszW6q6Sn7CEuRcai+MyCFHZAC60HBYHrbHY
         O6aZhHwdAcN2edjMYtnIM30eHKqKX+nLcrp7EWg7o3K02iGNqcy7yZMCuf45k3TbUQmh
         2q5RDyHpRtjzsYForNMf60J+XzjftUsPrFxnASdA/FxLqSSaSGz1Fp423zIM7rcT594e
         FUOUzXnRva29J++JC5nBi+aElvNd7QTBep/TXJFtCSSfeo24sXt5AhW6lfDCx0y+mOCa
         EYxNayiykoYitDh+Q+2SguHP7j9FEplJ2bfpZFWBp6B15JPgnl/+gOgmyVjPv642HVLd
         ZfOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWJ510L7SPzBD53F1o3OWYHswANRdznoPDRrXY2TYQUHZqA+FcFp8MUKvPNT4P7EfnqYW6IZENG0W9@lists.infradead.org
X-Gm-Message-State: AOJu0YzFfQwp9UzCgLJXlYHzDM1Fz9PYtDrW8/X1nq+9RToTUZ07/fWo
	KaZnJTL6dk7Cuohad0BHpEWC9Srqk3n0QCMq4ewPCqZFwwkg+vrxB0qezkQMwVeW4do=
X-Gm-Gg: AZuq6aKd1j/1Cl6ovcLGJt4y2kO316WMM5Xf5bvAuKhRDfxLFODaa+k6oPxG1in6OfU
	PTYrZqLOEoCddHZZnItUzki5GngqI78HAk894EI/GsAau3k8vw2FtYEpClNH7YZ7yikDv+h88V4
	S/ejTpSSdXV9TYjXHe1HWEMsVnOx+NMh//2YFYiwUjYQD7rSxUgdCFlHtDyoVfrQiofhm1QfKCW
	9UwJkY+wko9TqIRyEVDLdvSLBQw/220+CAZX9WHouLEzsyn24VNbNZItkF88XHXI9TBYbREqFl1
	BbtUJWl91gGfLWVLqARdAO1RrVRUwpXf1WzvrFrTNjgYuCDWH3/9oS2U+9KRISqNjd6XYP2AJqC
	K9SxbMIEj1SnvfTnMDsMYhLzTjtKCxrhcaanfuX5Y96Klel7lR7Lor/CU6k6QeJ09VNjGhzoAAs
	W+y/fjmtYxkXv28qxL3aUEPfuX8ZMgr6FrIfx0gjsHdTitDQ==
X-Received: by 2002:a05:7022:4581:b0:119:e56b:91ea with SMTP id a92af1059eb24-12741bb7e86mr734066c88.27.1771043300889;
        Fri, 13 Feb 2026 20:28:20 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:20 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v3 00/21] TP8028 Rapid Path Failure Recovery
Date: Fri, 13 Feb 2026 20:25:01 -0800
Message-ID: <20260214042753.4073668-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202822_220293_5A3D906E 
X-CRM114-Status: GOOD (  22.69  )
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

This patchset adds support for TP8028 Rapid Path Failure Recovery for
both nvme target and initiator. Rapid Path Failure Recovery brings
Cross-Controller Reset (CCR) functionality to nvme. This allows nvme
host to send an nvme command to a source nvme controller to reset
the impacted nvme controller, provided that both source and impacted
controllers are in the same nvme subsystem.

The main use of CCR is when one path to the nvme subsystem fails.
Inflight IOs on impacted nvme controller need to be terminated first
before they can be retried on another path. Otherwise data corruption
may happen. CCR provides a quick way to terminate these IOs on the
unreachable nvme controller allowing recovery to move quickly avoiding
unnecessary delays. In case of CCR is not possible, inflight requests
are held for duration defined by TP4129 KATO Corrections and
Clarifications before they are allowed to be retried.


On the target side:

* New struct members have been added to support CCR. struct nvme_id_ctrl
  has been updated with CIU (Controller Instance Uniquifier), CIRN
  (Controller Instance Random Number), and CQT (Command Quiesce Time).
  The combination of CIU, CNTLID, and CIRN is used to identify impacted
  controller in CCR command.

* CCR nvme command implemented on the target causes impacted controller
  to fail and drop connections to host.

* CCR logpage contains the status of pending CCR requests. An entry is
  added to the logpage after CCR request is validated. Completed CCR
  requests are removed from the logpage when controller becomes ready or
  when requested in get logpage command.

* An AEN is sent when CCR completes to let the host know that it is safe
  to retry inflight requests.


On the host side:

* CIU, CIRN, and CQT have been added to struct nvme_ctrl. CIU and CIRN
  have been added to sysfs to make the values visible to the user.
  CIU and CIRN can be used to construct and manually send admin-passthru
  CCR commands.

* New controller states FENCING and FENCED have been added to make sure
  that inflight request do not get canceled if they timeout during
  fencing process. FENCED exists so that controller state machine does
  not have a transition from FENCING to RESETTING. Instead FENCING ->
  FENCED -> RESETTING. This prevents a controller being fenced from
  getting reset. Only after fencing finishes the impacted controller is
  reset.

* Controller recovery in nvme_fence_ctrl() is invoked when LIVE
  controller hits an error or when a request times out. CCR is attempted
  first to reset impacted controller. If it fails then inflight requests
  are held until it is safe to retry them.

* Updated nvme fabric transports nvme-tcp, nvme-rdma, and nvme-fc to
  use CCR recovery.


Ideally all inflight requests should be held during controller recovery
and only retried after recovery is done. However, there are known
situations where that is not the case in this implementation. These gaps
will be addressed in future patches:

* Manual controller reset from sysfs will result in controller going to
  RESETTING state and all inflight requests to be canceled immediately
  and may be retried on another path.

* Manual controller delete from sysfs will also result in all inflight
  requests to be canceled immediately and may be retried on another path.

* In nvme-fc, nvme controller will be deleted if remote port disappears
  with no timeout specified. This results in immediate cancellation of
  requests that may be retried on another path.

* In nvme-rdma if HCA is removed all nvme controllers will be deleted.
  This results in canceling inflight IOs and may be they will be retried
  on another path.


Changes from v2:

- nvmet: Implement CCR nvme command
  - Minor changes addressing review comments on v2.

- nvme: Rapid Path Failure Recovery read controller identify fields
  Addressed security concern that CCR can be used to cause denail of
  service. Changed the permission of CIU and CIRN sysfs attributes
  from S_IRUGO to S_IRUSR. This makes sure only root user can read
  these attributes.

- nvme: Introduce FENCING and FENCED controller states
  Addressed code review comments. Minor changes.

- nvme: Implement cross-controller reset recovery
  - Refactored nvme_find_ctrl_ccr(), more idiomatic code.
  - Update nvme_issue_wait_ccr() to return
    - 0 on success.
    - EIO in case failure submitting CCR command
    - ETIMEDOUT timedout waiting for CCR operation.
    - EREMOTEIO CCR operation failed.
  - Updated nvme_fence_ctrl() such that CCR is operation
    is tried on one source controller maximum.

- nvme-tcp: Use CCR to recover controller that hits an error
  - Dropped ctrl->fenced_work. Moved to CQT patches.
  - nvme_tcp_fencing_work() resets controller regardless of
    CCR success or failure.

- nvme-rdma: Use CCR to recover controller that hits an error
  - Similar to nvme-tcp

- nvme-fc: Decouple error recovery from controller reset
  - nvme_fc_start_ioerr_recovery() queues ctrl->ioerr_work in case of
    CONNECTING, DELETING, and DELETING_NOIO without changing controller
    state.  For CONNECTING it addresses an issue raised during
    codereview. For DELECTING{_NOIO} it addresses an issue observed
    during testing where a controller is deleted with inflight IOs.
  - Updated nvme_fc_ctrl_ioerr_work() to handle CONNECTING state in
    special way just aborting outstanding IO. This change addresses an
    issue raised during code review.
  - nvme_fc_error_recovery() has been updated to flush
    ctrl->ctrl.async_event_work as mentioned in code review.

- nvme-fc: Use CCR to recover controller that hits an error
  - Changes similar to nvme-rdma and nvme-tcp

- nvme-fc: Do not cancel requests in io taget before it is initialized
  - A new patch added to address an issue observed during testing.

- CQT changes have been pulled to separate patches
  - nvmet: Add support for CQT to nvme target
  - nvme: Add support for CQT to nvme host
  - nvme: Update CCR completion wait timeout to consider CQT
  - nvme-tcp: Extend FENCING state per TP4129 on CCR failure
  - nvme-rdma: Extend FENCING state per TP4129 on CCR failure
  - nvme-fc: Extend FENCING state per TP4129 on CCR failure

v2: https://lore.kernel.org/all/20260130223531.2478849-1-mkhalfella@purestorage.com/

Mohamed Khalfella (21):
  nvmet: Rapid Path Failure Recovery set controller identify fields
  nvmet/debugfs: Export controller CIU and CIRN via debugfs
  nvmet: Implement CCR nvme command
  nvmet: Implement CCR logpage
  nvmet: Send an AEN on CCR completion
  nvme: Rapid Path Failure Recovery read controller identify fields
  nvme: Introduce FENCING and FENCED controller states
  nvme: Implement cross-controller reset recovery
  nvme: Implement cross-controller reset completion
  nvme-tcp: Use CCR to recover controller that hits an error
  nvme-rdma: Use CCR to recover controller that hits an error
  nvme-fc: Decouple error recovery from controller reset
  nvme-fc: Use CCR to recover controller that hits an error
  nvme-fc: Hold inflight requests while in FENCING state
  nvme-fc: Do not cancel requests in io taget before it is initialized
  nvmet: Add support for CQT to nvme target
  nvme: Add support for CQT to nvme host
  nvme: Update CCR completion wait timeout to consider CQT
  nvme-tcp: Extend FENCING state per TP4129 on CCR failure
  nvme-rdma: Extend FENCING state per TP4129 on CCR failure
  nvme-fc: Extend FENCING state per TP4129 on CCR failure

 drivers/nvme/host/constants.c   |   1 +
 drivers/nvme/host/core.c        | 222 +++++++++++++++++++++++++++-
 drivers/nvme/host/fc.c          | 249 ++++++++++++++++++++++++--------
 drivers/nvme/host/nvme.h        |  25 ++++
 drivers/nvme/host/rdma.c        |  63 +++++++-
 drivers/nvme/host/sysfs.c       |  27 ++++
 drivers/nvme/host/tcp.c         |  63 +++++++-
 drivers/nvme/target/admin-cmd.c | 124 ++++++++++++++++
 drivers/nvme/target/configfs.c  |  31 ++++
 drivers/nvme/target/core.c      | 113 ++++++++++++++-
 drivers/nvme/target/debugfs.c   |  21 +++
 drivers/nvme/target/nvmet.h     |  20 ++-
 include/linux/nvme.h            |  70 ++++++++-
 13 files changed, 953 insertions(+), 76 deletions(-)


base-commit: cd7a5651db263b5384aef1950898e5e889425134
-- 
2.52.0


