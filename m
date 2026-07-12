Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2898EC44506
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=33htQlp1eahVTS4hIDwWZa8cpMgaahnmJhYr8QovReE=; b=tsoUk9ku3d7k5IWdmUKWl6RiWE
	Z4vF8GHiCmKxuji2odhmt251X9zTgOSwrghGOKbRQ9r2fRenGkKw3PpvLXKV2fGKpLi3j//s1kV/a
	d0c1MerxUleBnuKvec1y6e3difeB7S14w3tHuc4LvAisU8sM/ihqwDo+2oz/9z1bJfqOmIq+d6v+L
	2CO0I3MbGw/cBbZB7eR8mvuit+Jnth1c45iE1iNALIq/Ix0jti3zc6yqdFffv31DxF2V24q3v8vEK
	HTkKRei5J33KqaQsqveYjOO0vP0Kl7h2RvPmsiTNggykrKE/Dlb0uiPaHKYRwNYwFoS+pSh07AWRM
	f9rNcijw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsj-000000071Mu-0vMP;
	Sun, 12 Jul 2026 02:25:25 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsb-000000071KN-48tp
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:21 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2cc6dd436c6so24499445ad.2
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823116; x=1784427916; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=33htQlp1eahVTS4hIDwWZa8cpMgaahnmJhYr8QovReE=;
        b=O842W2cS2nIm0UF4AjV5rmqFA4DvljQf4HGe3iqY9lLBu6LhavLzblZGKjJ+8tgtMo
         hrqnt3fXq4WvP+r7tiiB/VyrrjQW6z501kr1lHd/RKTjnDJKnOsR1bw1HwXhQijEJb8J
         xrkhF9Ow9d1TfgDTWbz9Xz82RDUWKAiS8eViurBlqNvJhGPAJ7KrO6F0bGngetMooZ/k
         rVHKDfMXsWqEcwfDX7jQSQxF+9YukbCIbq1qYywCYQ/H3738Das5UIgxmI/AZDuHF/LX
         ZcQELSSHbvD46oO0meNIt3Cj1Gw+MZYzHoLAnN5pb1U5KbaUkjjgfAy6bj8QLimQavl8
         yheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823116; x=1784427916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=33htQlp1eahVTS4hIDwWZa8cpMgaahnmJhYr8QovReE=;
        b=FB9b6sarseCAU9LPjYye7tXFstGMQgqA9ctRaQ1AHPj/C5+1+CjLxyjkLaTHBRxzH8
         xWv7Y5CBXTfa4y4NrAamLCYWKlYUb6SeL22EvK5O4upGJwVlAjdnBCb/yYsdRKn99hMW
         SN5rmXjxT2zuEEoDWGXgjEMvu9z9UGcw9ZYh/0wQx92laIbXXTOifzA/lw9VXTk2z3cZ
         uR5JieitT/RmNo0LUoqW+RVVFcRKLLgpyLN//oFdDs3SDrmWkcSEFUagEfM4xTFgbwpn
         I844No4W17Is68ROtsdSq74RGf4knrGWALlrRI9UC3x9prouPCLPyHDLFAuShl9nfDJJ
         NyFg==
X-Forwarded-Encrypted: i=1; AHgh+RorFxvpQKJrjcUxmCNShjBt7zMRZjnE1KZy/ph3Bb/cdO4XIfH5T+mrOz3qeZL/Cu+9PyuPWUBtsUBH@lists.infradead.org
X-Gm-Message-State: AOJu0YyQhQgN8RHhqRylM4JdvSyMRbe1kX8DaDUn0HlDUzVjqM8J10n8
	ascWEaFuOeMin7yOGmqvXu9QA7sAzi1vAGn7wnKAdsA0j28SCgSo8E9M2XGTIWD9Apw=
X-Gm-Gg: AfdE7cnN90m3TTeqn8PYT+oy4BchlYvMozpuErC9ovnNtuAkorLnjLojnVzjpgtxBpY
	y8143lyCemgApCTACjkjvuYbqIXUV80Db8FFlTi6bxgHJro9m96tJ6X5z/aGo3DMhJi/Cw0OyqT
	9quhJL+y/jk65Usv7TKdcK0TedYEopsbL0enq2y1vFlHKrMaDxL4VRn61DqVmgBQpHdzO3zGJhy
	Mfamf2Ej22RPiJjnIjOdMUzO1aeSkIhob8Keo5FuXEDeDFxWW9K7LvvWUGrB6QZrte0oFR7NCrp
	rVi+P1lbW5+20Q0srD/OALSB6QeVZVpdqHl3Ow77E0vMqlu1Y+Q4YoKYV/W1kIhuxYkeCBQK8aZ
	LZFCIkx49TA3neqHglu/zX+cXB3z+mfVWW+yrAoImQf7vibFtP3HNuq8VtYoZ5fbbtDNCVfTnwV
	029tCP
X-Received: by 2002:a05:6a21:9d91:b0:3c0:9c1a:894d with SMTP id adf61e73a8af0-3c110b333a3mr4482408637.69.1783823115450;
        Sat, 11 Jul 2026 19:25:15 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:14 -0700 (PDT)
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
	Hannes Reinecke <hare@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v5 00/16] TP8028 Rapid Path Failure Recovery
Date: Sat, 11 Jul 2026 19:23:21 -0700
Message-ID: <20260712022437.3743117-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192518_345877_02EC026E 
X-CRM114-Status: GOOD (  25.02  )
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
Inflight IOs on the impacted nvme controller need to be terminated first
before they can be retried on another path. Otherwise, data corruption
may happen. CCR provides a quick way to terminate these IOs on the
unreachable nvme controller, allowing recovery to move quickly and avoid
unnecessary delays. In case CCR is not possible, inflight requests are
held for a duration defined by TP4129 KATO Corrections and
Clarifications before they are allowed to be retried.


On the target side:

* New struct members have been added to support CCR. struct nvme_id_ctrl
  has been updated with CIU (Controller Instance Uniquifier), CIRN
  (Controller Instance Random Number), and CQT (Command Quiesce Time).
  The combination of CIU, CNTLID, and CIRN is used to identify the
  impacted controller in the CCR command.

* The CCR nvme command implemented on the target causes the impacted
  controller to fail and drop its connections to the host.

* The CCR log page contains the status of pending CCR requests. An entry
  is added to the log page after a CCR request is validated. Completed
  CCR requests are removed from the log page when the controller becomes
  ready or when requested in the Get Log Page command.

* An AEN is sent when a CCR completes to let the host know that it is
  safe to retry inflight requests.


On the host side:

* CIU, CIRN, and CQT have been added to struct nvme_ctrl. CIU and CIRN
  have been added to sysfs to make the values visible to the user.
  CIU and CIRN can be used to construct and manually send admin-passthru
  CCR commands.

* New controller states FENCING and FENCED have been added to make sure
  that inflight requests do not get canceled if they time out during the
  fencing process. FENCED exists so that the controller state machine
  does not have a transition from FENCING to RESETTING. Instead, FENCING
  -> FENCED -> RESETTING. This prevents a controller being fenced from
  getting reset. Only after fencing finishes is the impacted controller
  reset.

* Controller recovery in nvme_fence_ctrl() is invoked when a LIVE
  controller hits an error or when a request times out. CCR is attempted
  first to reset the impacted controller. If it fails, inflight requests
  are held until it is safe to retry them.

* Updated the nvme fabric transports nvme-tcp, nvme-rdma, and nvme-fc to
  use CCR recovery.


Ideally, all inflight requests should be held during controller recovery
and only retried after recovery is done. However, there are known
situations where that is not the case in this implementation. These gaps
will be addressed in future patches:

* A manual controller reset from sysfs will result in the controller
  going to the RESETTING state and all inflight requests being canceled
  immediately, and they may be retried on another path.

* A manual controller delete from sysfs will also result in all inflight
  requests being canceled immediately, and they may be retried on
  another path.

* In nvme-fc, the nvme controller will be deleted if the remote port
  disappears with no timeout specified. This results in immediate
  cancellation of requests that may be retried on another path.

* In nvme-rdma, if the HCA is removed, all nvme controllers will be
  deleted. This results in canceling inflight IOs, and they may be
  retried on another path.


Changes from v4:

- nvmet: Implement CCR nvme command
  - Validate transfer length at the start of
    nvmet_execute_cross_ctrl_reset()
  - Match the impacted controller on hostnqn in addition to cntlid in
    nvmet_ctrl_find_get_ccr()
  - Dropped a stray semicolon after the list_for_each_entry loop

- nvmet: Implement CCR logpage
  - Use kzalloc_obj() instead of kzalloc()
  - Rename the loop-local status to ccr_status to avoid shadowing

- nvme: Rapid Path Failure Recovery read controller identify fields
  - Store CCRL as a plain u8 ccrl instead of an atomic_t ccr_limit

- nvme: Implement cross-controller reset recovery
  - nvme_fence_ctrl() now returns the remaining wait time again instead
    of success/failure: 0 on CCR success or on fencing timeout, and the
    remaining jiffies when no source controller is available, so the
    caller can fall back to time-based recovery
  - On a per-path CCR failure, keep trying the remaining paths until the
    deadline instead of returning immediately
  - Rework the concurrency accounting to an up-counter ctrl->ccr_used
    checked against the ccrl limit instead of the ccr_limit countdown
    atomic. This was reworked because of a potential race condition:
    sctrl goes through nvme_init_identify(), which sets ctrl->ccr_limit,
    and then nvme_put_ctrl_ccr() increments it afterward.
  - Take ctrl->lock before checking state / accounting and use the
    nvme_ctrl_state() accessor

- nvme: Implement cross-controller reset completion
  - Use kmalloc_obj() instead of kmalloc()
  - Cap the number of walked log entries at NVMF_CCR_PER_PAGE

- nvme-tcp: Use CCR to recover controller that hits an error
- nvme-rdma: Use CCR to recover controller that hits an error
- nvme-fc: Use CCR to recover controller that hits an error
  - Adjust to the new nvme_fence_ctrl() return value; log "CCR failed,
    starting error recovery" instead of the errno

- nvme-fc: Do not cancel requests in io target before it is initialized
  - Dropped from the series; it was applied upstream.

- nvmet: Add support for CQT to nvme target
- nvme: Add support for CQT to nvme host
  - Re-added the CQT patches that were dropped in v4. CQT (Command
    Quiesce Time) is exposed as a target subsystem attribute defaulting
    to 0 and reported in Identify Controller; the host reads it, exposes
    it via sysfs, and uses it to bound time-based recovery (fenced_work)
    in nvme-tcp, nvme-rdma, and nvme-fc when CCR is not possible

v4: https://lore.kernel.org/all/20260328004518.1729186-1-mkhalfella@purestorage.com/

Mohamed Khalfella (16):
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
  nvme-fc: Refactor IO error recovery
  nvme-fc: Use CCR to recover controller that hits an error
  nvme-fc: Hold inflight requests while in FENCING state
  nvmet: Add support for CQT to nvme target
  nvme: Add support for CQT to nvme host

 drivers/nvme/host/constants.c   |   1 +
 drivers/nvme/host/core.c        | 234 ++++++++++++++++++++++++++++++-
 drivers/nvme/host/fc.c          | 241 +++++++++++++++++++++++---------
 drivers/nvme/host/nvme.h        |  26 ++++
 drivers/nvme/host/rdma.c        |  63 ++++++++-
 drivers/nvme/host/sysfs.c       |  27 ++++
 drivers/nvme/host/tcp.c         |  63 ++++++++-
 drivers/nvme/target/admin-cmd.c | 126 +++++++++++++++++
 drivers/nvme/target/configfs.c  |  36 +++++
 drivers/nvme/target/core.c      | 115 ++++++++++++++-
 drivers/nvme/target/debugfs.c   |  21 +++
 drivers/nvme/target/nvmet.h     |  20 ++-
 include/linux/nvme.h            |  70 +++++++++-
 13 files changed, 968 insertions(+), 75 deletions(-)

-- 
2.54.0


