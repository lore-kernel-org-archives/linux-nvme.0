Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC22410F3DC0
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2026 00:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OUfAUhOe+fz1n7pxKjOUsQHT/O9aZ9wFUk8VQLCphA0=; b=SnRh6s5biCC4W0XEjI0qTYr0U3
	ZsIKaNpLdPQHiu5agmQqWDvW76HPLGGAxgOyIzNLRoeLMMTudBT9rCLzyXVfVVYJMta7ga24QMQ9g
	0x/s6qhMwBZKMLeEJwsPQ9h1HPKoCT5NXWB8VsicdWXUQLZdtfvkPl19DsPrjUxuod8VvN3c527Jh
	XjCGegrfl/UlqLJFA3QseguuSNUEvh4byARJzwQlG7osPeofTbGGP1RfzpVQY48Yb5FLK4MY566kP
	affWMaxoxbaOhq6fektqbqrWNGA3qtCLxr1zsXk42YiQg9hpInxk/dLZiF9T/XLrA52ALBtmwDnM5
	21xMaoow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoJ-00000008Nol-1UFV;
	Sat, 28 Mar 2026 00:45:55 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoF-00000008Nnr-1Rbq
	for linux-nvme@lists.infradead.org;
	Sat, 28 Mar 2026 00:45:53 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so1875471a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 17:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774658750; x=1775263550; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OUfAUhOe+fz1n7pxKjOUsQHT/O9aZ9wFUk8VQLCphA0=;
        b=aXNSURnk6zqkTva6Ce0g76nfJDl8YLqR3RXC5dKXqAFa8qfhrP2ZiGOngxvT//RFqj
         m/hQGKqGkeLLlustLGTqGpF67Bi8Y9iX3nwZJmqud6g8hStQkmXiNb6LKpX3yUeZpr8q
         2s8gw8mqS7cNIFz/oTPAR94nqR0c48pGSrFt+mIjOJE+3iBV+vYYx8l5GBwl//ki+7ZG
         RjHRdo0gNSAUjZBa7w05p9+0ZhBYQdm74Vx/QSzE3XOlkayxZ3XsByTo6KWbo7F5F1mj
         1dc3RtUOsd743j3danr6eVXn4Ya6pzKA31TQqepi/YVTdp0CNp8qzGAbbw32Qfif/eGH
         vU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774658750; x=1775263550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUfAUhOe+fz1n7pxKjOUsQHT/O9aZ9wFUk8VQLCphA0=;
        b=KgIVS/h3TJSAG8o7PFAB0LtdevNIBO1u6Klzv8Frp/p2uHcXtPh2bfYOj54GKKQRGn
         NqsYA9z5Wu01OlSWzpSA40zbIvWw9N9znBFB2/KrLx5MYD/3+kZVuB4yXF91ceoyqkMJ
         cECSRxM9SZYggPDvofqBdEKGoHRAquwVrwbCIQ91yna2RCKDxJibDky6GTUbfqvNXqxH
         AEUsE0jzsERoZCC9Vcpt08TP0UMLSROy1pNvy7UAny+1CClUOpW+MH4qaKPuCafrkGhF
         f3h8k22A+lhwAQ+DJ9qQKjPNw6h3DSQgY/pAkxYpXlULbMHu4OPbKKBWd5RY4ChOG5ry
         TqFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX53CiM97Lo2gEvGUFmye0o++AwF0XBr41dFmKHddo9qrZhToJlM/CoebSZZ+Ex8g8P96wNDDP7qfiJ@lists.infradead.org
X-Gm-Message-State: AOJu0YzH3ICeNDMv4R5LtuXDtlmZyafD4SnClzazlO/qm92YuYugCvBc
	K/V3tyciDZS+Xd0ofsP5frsrxVDNJ+yeue1E9VTP/2eKZN1Pzni+l7OKeUxjqFeG4N8=
X-Gm-Gg: ATEYQzzm42PxmL3dJ2FFWtu5W4eewm5SIkc5eUvuYBAuX5uTQXStfE5T1PO273FV9Ao
	jsG42tXCm8h+a9Spx7Kmhl8rJFhK30GofIZUBEuVTSUQJEMdTWQeuLB6pAYxZRrL9Pa/Q/Xz5/z
	Pb92c0XphZ/7/tHaWqy/fgCYKpLXFIf3XpQcLcadAa+szoUlqLbdpqmEt0iAnXFOagl+P2ayr3c
	S9Jicmff7umil9I11y5YuLCDxyFw9K34q7PdiTNneXBsmUvD8ofyiLdtK4sSsymSCsmed3P2oeY
	pl4UzdH6DRwq7t/eVtVRJTJZK7FCe/j4J0HEDNRBYQuFW2JydVUTal8WOd1bnrprSG36J3BXPv/
	mzeL1nCesiaep62Srsw5PBoTzyo57DgfmLXzVHAdLdXzKaSa6HZ0ZYbC09Tez/vLI3BQTrQo1Vp
	WZMV4lL90=
X-Received: by 2002:a17:903:22ca:b0:2ae:8077:b1c7 with SMTP id d9443c01a7336-2b0cdcd5911mr50850695ad.37.1774658750100;
        Fri, 27 Mar 2026 17:45:50 -0700 (PDT)
Received: from ceto ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b242683064sm5342705ad.33.2026.03.27.17.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:45:49 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
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
Subject: [PATCH v4 00/15] TP8028 Rapid Path Failure Recovery
Date: Fri, 27 Mar 2026 17:43:31 -0700
Message-ID: <20260328004518.1729186-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_174551_528850_C3FEFF07 
X-CRM114-Status: GOOD (  21.50  )
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


Changes from v3:
- nvmet: Implement CCR nvme command
  - Fixed a bug in the order of members of struct nvme_cross_ctrl_reset_cmd
  - Use kmalloc_obj() instead of kmalloc()

- nvme: Implement cross-controller reset recovery
  - Now CQT has been removed updated nvme_fence_ctrl() to return
    success or failure instead of remaining time.
  - Updated nvme_issue_wait_ccr() to respect deadline set in
    nvme_fence_ctrl().

- nvme-tcp: Use CCR to recover controller that hits an error
- nvme-rdma: Use CCR to recover controller that hits an error
  - Updated log nvme_fence_ctrl() return value

- nvme-fc: Refactor IO error recovery
  - Updated the commit message
  - Updated nvme_fc_start_ioerr_recovery() to handle
    CONNECTING case first.

- nvme-fc: Use CCR to recover controller that hits an error
  - Updated log nvme_fence_ctrl() return value

- nvmet: Add support for CQT to nvme target
- nvme: Add support for CQT to nvme host
- nvme: Update CCR completion wait timeout to consider CQT
- nvme-tcp: Extend FENCING state per TP4129 on CCR failure
- nvme-rdma: Extend FENCING state per TP4129 on CCR failure
- nvme-fc: Extend FENCING state per TP4129 on CCR failure
  - Dropped CQT patches


v3: https://lore.kernel.org/all/20260214042753.4073668-1-mkhalfella@purestorage.com/

*** BLURB HERE ***


Mohamed Khalfella (15):
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
  nvme-fc: Do not cancel requests in io taget before it is initialized

 drivers/nvme/host/constants.c   |   1 +
 drivers/nvme/host/core.c        | 225 +++++++++++++++++++++++++++++++-
 drivers/nvme/host/fc.c          | 215 +++++++++++++++++++++---------
 drivers/nvme/host/nvme.h        |  24 ++++
 drivers/nvme/host/rdma.c        |  30 ++++-
 drivers/nvme/host/sysfs.c       |  25 ++++
 drivers/nvme/host/tcp.c         |  30 ++++-
 drivers/nvme/target/admin-cmd.c | 123 +++++++++++++++++
 drivers/nvme/target/core.c      | 110 +++++++++++++++-
 drivers/nvme/target/debugfs.c   |  21 +++
 drivers/nvme/target/nvmet.h     |  18 ++-
 include/linux/nvme.h            |  65 ++++++++-
 12 files changed, 812 insertions(+), 75 deletions(-)


base-commit: dd09eb443372f9390d36051d86ebe06e9919aeec
-- 
2.52.0


