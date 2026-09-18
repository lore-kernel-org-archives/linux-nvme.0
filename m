Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6064EC982E3
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 18:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iwvVNb6cm1y2qw4F8+YbBTYnwc0WNp/u3zezKCfM2m8=; b=ZZC+cg9jmlvgUUg3eqYenKzOX/
	ZEiMnshceA4p1PsqkTwMyTMzeRJiZdkSbDzNBpfgG1gF9CxAFTNAz8IbsWV5Xat/h9qE8to6VvV0t
	B6ZwZACfFnoPsSZDb5w5ig6cTmV/e2+PSQDKdCUmjbd3P/jIxyBIqLrmG2Ubo3ut/zL3t35/eRskq
	Ta0jlOd+V/3VUr85Bhl9SHkPKw4hKG5F8LHjDeRKvUV0IszXCA8FUguSvtipBSqYn30oLrYKOBRnZ
	QfqTRGSwvvg/+LI5+d0/bbtOuZE02948kseRJxrEe7wuodhlobahNYRz589W2NJL6UJ3IGJk8UuCR
	wfFOYR3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d8x-0000000FGxU-2nYX;
	Fri, 18 Sep 2026 18:17:03 +0000
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d8u-0000000FGwK-3Dro
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 18:17:02 +0000
Received: by mail-pj2-x0f.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso1008934a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 11:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789755420; x=1790360220; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iwvVNb6cm1y2qw4F8+YbBTYnwc0WNp/u3zezKCfM2m8=;
        b=fyn7pF/xVxf0taWw2shvX8odCvAUqwLLsFwa8jmBSKHX4+ist925IFCPPGXdmov8e9
         LLDIgsGM6+4b9r/g+1WPMaOTCEXgchaxelfVW8TUUJAukm16ML5Zxuwtd1J/EBKt6rh4
         iuruP5SaYDps0XCAK9PiRfTCHxBQmMIaztKkGAN6+nrNotwLkCQqPfwSTvfNoCIKAqv/
         hL1bTPkiB7SHxNbFXk5RPSDD4WL+jizdqsPZxXcfkE4Bas+tOvIZXcOwwyNLfjo4+7zC
         XJqnueNn89WA5PUy69QkHncDiBANx0Q2RZFf9lJWPmORioIAeU+BP36+jupjG5Mx3ES6
         CuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755420; x=1790360220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iwvVNb6cm1y2qw4F8+YbBTYnwc0WNp/u3zezKCfM2m8=;
        b=SgfNW4W1/+VznmI0QT2DLdNwjRBPI8TphVil1XQSyh/jHjzHDlIAk3nh7gRc+Q4kKL
         rf1MuEeLSCpUgYbgc6vgp9Rs6FIr7UHGS+wJyXGT9Bi0MNQ0B0dRy/UGNaI/2tBrAKal
         2oCCAdEELNBT20DmyUHUgURCdCloFcePtk/lGGMKL7zcu4lwTrwoRhnfSrJkGc8J5wDZ
         63JUr6WT1DvDo8EsucDPG1qcHq/JVz9AiPqGf93AaCo2+YJqdLkbAXcsTD2TM29PpAXZ
         6JfwsyMJ3lwwvaujfQcCU72z2EplYn/BiPgerPOMJhZwHsqvpE13AsL2/XHljgIKGjLf
         jjYg==
X-Forwarded-Encrypted: i=1; AKwUvByiXB1XQXU23hOITRurfvuxv+Rbj/t48fc/wancehnA8dJEY9DUv7vqpJ6hrw0eI9/ZeTUl/dbjGyUf@lists.infradead.org
X-Gm-Message-State: AFuF++neUBoSOBsu44bAjgGLI2eiyderKQiMl239yBcH5CoxAHVWUcCu
	QOyTTO/pnTXwBwiOsgC9NN6SrnRw2sgAhrtYfNabdKwB8jj0WICtRImy1NOOAkNi7hQ=
X-Gm-Gg: AYBFou3fnct756pVa8R73yO41KP5u20CfvqOC7x6vewc1eRGVpk4YHgYqRpXTpCRwsN
	tn+CXVzREiJ8lJ1ZgU6SUKi4DaKKGwX9KHUHZktahrxlTHmA5CaKgXMtTMtv1905M0SwGExCuZh
	eQUV+HkZ8DNvuiZlej1cBYGNXFuYuAdDXezjAL9PDeTfng9HejqHcRhpEp6ptM8t2ndbQRu5Py9
	rwc+JpnjCGvVDWSKpC/9mmUdvG9nVrKBGa4P8+sewWyAcbU0hXi8muzFucKdjFwG2Y+PkyIUjn8
	G2C9DbfRN+2U8oYy7CW9ujSKSQsyJY31WtS/N2nuG7RSv0CkmLfgJwiOtOb0I/lHj36ShwZcF4S
	SkIwwSoe3s6gXhnpDMNeAvyxjU5oH2YQY6f9K/EPu69sIMlAJwoFpxJ14708BY3hZz/vl95PTe2
	ste06RtBwwWz8BGQQyrcVO43BkAmJNVyAxomfJOF1iypgVV3JwkYsNpx7ZUl9gVW654PjYOvrjW
	tFVB7ItP/NCm2YjtO4oEHy/8WsSzJBi
X-Received: by 2002:a17:90b:17c1:b0:39d:f2a1:3a with SMTP id 98e67ed59e1d1-39e54c19b62mr7168200a91.15.1789755419464;
        Fri, 18 Sep 2026 11:16:59 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm335107eec.24.2026.09.18.11.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:16:58 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/18] TP8028 Rapid Path Failure Recovery
Date: Fri, 18 Sep 2026 11:14:00 -0700
Message-ID: <20260918181614.3947933-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_111700_816619_5B3764C7 
X-CRM114-Status: GOOD (  31.51  )
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
both the nvme target and initiator. Rapid Path Failure Recovery brings
Cross-Controller Reset (CCR) functionality to nvme. This allows an nvme
host to send an nvme command to a source nvme controller to reset the
impacted nvme controller, provided that both source and impacted
controllers are in the same nvme subsystem.

The main use of CCR is when one path to the nvme subsystem fails.
Inflight IOs on the impacted nvme controller need to be terminated
first before they can be retried on another path. Otherwise, data
corruption may happen. CCR provides a quick way to terminate these IOs
on the unreachable nvme controller, allowing recovery to move quickly
and avoid unnecessary delays. In case CCR is not possible, inflight
requests are held for a duration defined by TP4129 KATO Corrections
and Clarifications before they are allowed to be retried.

On the target side:

* New struct members have been added to support CCR. struct
  nvme_id_ctrl has been updated with CIU (Controller Instance
  Uniquifier), CIRN (Controller Instance Random Number), and CQT
  (Command Quiesce Time). The combination of CIU, CNTLID, and CIRN is
  used to identify the impacted controller in the CCR command.

* The CCR nvme command implemented on the target causes the impacted
  controller to fail and drop its connections to the host.

* The CCR log page contains the status of pending CCR requests. An
  entry is added to the log page after a CCR request is validated.
  Completed CCR requests are removed from the log page when the
  controller becomes ready or when requested in the Get Log Page
  command.

* An AEN is sent when a CCR completes to let the host know that it is
  safe to retry inflight requests.

On the host side:

* CIU, CIRN, and CQT have been added to struct nvme_ctrl. CIU and CIRN
  have been added to sysfs to make the values visible to the user. CIU
  and CIRN can be used to construct and manually send admin-passthru
  CCR commands.

* New controller states FENCING and FENCED have been added to make
  sure that inflight requests do not get canceled if they time out
  during the fencing process. FENCED exists so that the controller
  state machine does not have a transition from FENCING to RESETTING.
  Instead, FENCING -> FENCED -> RESETTING. This prevents a controller
  being fenced from getting reset. Only after fencing finishes is the
  impacted controller reset.

* Controller recovery in nvme_fence_ctrl() is invoked when a LIVE
  controller hits an error or when a request times out. CCR is
  attempted first to reset the impacted controller. If it fails,
  inflight requests are held until it is safe to retry them.

* Updated the nvme fabric transports nvme-tcp, nvme-rdma, and nvme-fc
  to use CCR recovery.

* Controller deletion now waits for an active fencing window to end
  instead of failing, so a sysfs disconnect, rdma device removal, or
  module unload during fencing no longer drops the deletion or leaks
  the controller.

Ideally, all inflight requests should be held during controller
recovery and only retried after recovery is done. However, there are
known situations where that is not the case in this implementation.
These gaps will be addressed in future patches:

* A manual controller reset from sysfs of a LIVE controller will
  result in the controller going to the RESETTING state and all
  inflight requests being canceled immediately, and they may be
  retried on another path. A reset issued during a fencing window is
  rejected by the state machine.

* A manual controller delete from sysfs of a LIVE controller will also
  result in all inflight requests being canceled immediately, and they
  may be retried on another path. A delete issued during a fencing
  window now waits for fencing to end instead of being dropped.

* In nvme-fc, the nvme controller will be deleted if the remote port
  disappears with no timeout specified. For a LIVE controller this
  still results in immediate cancellation of requests that may be
  retried on another path. If the controller is already fencing, the
  association is torn down without completing the held requests and
  they are only allowed to fail over once fencing ends.

* In nvme-rdma, if the HCA is removed, all nvme controllers will be
  deleted. Deleting LIVE controllers still cancels inflight IOs, and
  they may be retried on another path. Controllers in a fencing window
  are now deleted only after fencing ends.

Changes from v5:

- nvme: Introduce FENCING and FENCED controller states
  - Treat FENCING/FENCED controllers as available paths in
    nvme_available_path() so a multipath head does not fail all IO
    while its last path is being fenced

- nvme-fc: Refactor IO error recovery
  - Split into two patches, "nvme-fc: start error recovery instead of
    aborting timed out IOs" and "nvme-fc: perform error recovery
    directly from ioerr_work"
  - nvme_fc_start_ioerr_recovery() queues ioerr_work directly in
    DELETING/DELETING_NOIO so that a dead target does not hang
    controller deletion
  - nvme_fc_ctrl_ioerr_work() claims RESETTING before tearing the
    association down and skips recovery when another state owns it
  - nvme_fc_reset_ctrl_work() tears the association down before
    nvme_stop_ctrl() so that flushing ana_work or fw_act_work does not
    get stuck waiting on IOs that never complete

- nvme-fc: Use CCR to recover controller that hits an error
  - Tear the association down at the start of fencing_work, releasing
    all LLDD resources as soon as the controller enters FENCING. This
    fixes a use-after-free followed by a panic when the LLDD is
    unloaded or shut down (e.g. lpfc during kexec) while a fencing
    window is running: the LLDD's bounded unload waits expire before
    the fence does, its resources are freed, and the post-fence
    remoteport_delete upcall lands on freed memory
  - Stop keep-alive and cancel async_event_work before the teardown.
    AER submission bypasses blk-mq and must not reach the LLDD after
    the hw queues are deleted. cancel_work_sync() is used instead of
    flush_work() because fencing_work runs on nvme_wq, the same
    rescuer-equipped workqueue async_event_work is queued on

- nvme-fc: Hold inflight requests while in FENCING state
  - Split nvme_fc_delete_association() into
    __nvme_fc_teardown_association() and
    nvme_fc_flush_held_requests(). fencing_work now runs only the
    teardown at fence start and the held requests are completed on the
    FENCING -> FENCED transition, so they can fail over only after CCR
    succeeds or time-based recovery ends
  - Complete the held requests while still in FENCING, before moving
    to FENCED, so an io timeout cannot claim FENCED -> RESETTING and
    start reconnecting while the flush is running

- nvme: Add support for CQT to nvme host
  - nvme-fc: complete the held requests in fenced_work when time-based
    recovery finishes, matching fencing_work
  - Dropped the Reviewed-by tags due to the above change

- New patch "nvme: let controller deletion wait out a fencing window"
  - DELETING is not reachable from FENCING or FENCED, so during a
    fencing window nvme_delete_ctrl() fails with -EBUSY and its
    callers silently lose the deletion: a sysfs disconnect is dropped,
    rdma device removal returns early, and module unload leaks live
    controllers. Add nvme_delete_ctrl_wait(), use it in the tcp/rdma
    module exit paths and rdma device removal, and make
    nvme_delete_ctrl_sync() wait the same way

v5: https://lore.kernel.org/all/20260712022437.3743117-1-mkhalfella@purestorage.com/


Mohamed Khalfella (18):
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
  nvme-fc: start error recovery instead of aborting timed out IOs
  nvme-fc: perform error recovery directly from ioerr_work
  nvme-fc: Use CCR to recover controller that hits an error
  nvme-fc: Hold inflight requests while in FENCING state
  nvmet: Add support for CQT to nvme target
  nvme: Add support for CQT to nvme host
  nvme: let controller deletion wait out a fencing window

 drivers/nvme/host/constants.c   |   1 +
 drivers/nvme/host/core.c        | 275 +++++++++++++++++++++++++-
 drivers/nvme/host/fc.c          | 333 +++++++++++++++++++++++++-------
 drivers/nvme/host/multipath.c   |   2 +
 drivers/nvme/host/nvme.h        |  27 +++
 drivers/nvme/host/rdma.c        |  61 +++++-
 drivers/nvme/host/sysfs.c       |  27 +++
 drivers/nvme/host/tcp.c         |  59 +++++-
 drivers/nvme/target/admin-cmd.c | 126 ++++++++++++
 drivers/nvme/target/configfs.c  |  36 ++++
 drivers/nvme/target/core.c      | 115 ++++++++++-
 drivers/nvme/target/debugfs.c   |  21 ++
 drivers/nvme/target/nvmet.h     |  20 +-
 include/linux/nvme.h            |  70 ++++++-
 14 files changed, 1083 insertions(+), 90 deletions(-)


base-commit: fd9beb8870736e1c6a0b2351d88a161aaeb2b326
-- 
2.55.0


