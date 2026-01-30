Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A311E6BF3C
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yRCnfJL1AhUwVhtaNTyqMZcDiqAPROP54eRaRo/hfy8=; b=v8f+oMoC+rrIY1uB8krEykcpoh
	YJmI81KnGtONhPnHHn8AzlYmp+4JkaY0CGs9y8VEeapk+Ufm5PN33FK3Dkk9LWr6Wpd8FmcBFdF/Z
	GNAQjAjzws+Cf4Xw1BE86g17It2P748cSa1w69SZIU/6PQH2APpqy4vubc65cYjL2pxktDyLMgdL6
	6S4lnj2hWBNccfsuA/k4HaVVBT2Sr+b9MgyLe1eRCf9SbARI1frwTttHTzyw901uMKRTegAs9W4HM
	GfPwauQyJmhD8535tvR1rrlvjYeggGKYnZBsERLxdFwJMAftbMFlrrunYoOKcD1esnfWDWjAd1sTy
	pyw4yLpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6J-000000022gV-0i3b;
	Fri, 30 Jan 2026 22:36:27 +0000
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6H-000000022fd-0WOn
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:36:26 +0000
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-12339e2e2c1so1688582c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769812584; x=1770417384; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yRCnfJL1AhUwVhtaNTyqMZcDiqAPROP54eRaRo/hfy8=;
        b=AeAKsW8rgGsV3/HlUQ4m+mGmvz7rilOxmBClFSsopecc9B7FU7KrHmbOoHxif/5RGj
         XrWkYyxJDBlQSTbNiZ3hWSF+r/4SMlgGkRhloGEc7PnMy/LwnS3ifOpEZ1g0HFBOtMPn
         tYxGoiYHM/wum25BJH/wfhBNgmfMJW6OLGNt2f884yQsQxuwZiQ41Csu0l9UZiDt1oTF
         ZOIaZCCwDqddzO0wAl2t4c5XAh+OPEdWLAvnT70wK3ilVkwzHu+Hja6+Yc3f5cdjHgtU
         uIr80IMWnPYExc+D+7W5ugU3p+5hfXpAEv1HJq/DgjdPZi413G5iJLRMPTZY0r1aZnsL
         oouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812584; x=1770417384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRCnfJL1AhUwVhtaNTyqMZcDiqAPROP54eRaRo/hfy8=;
        b=bCMl7D2BLGED5Kg8/CWai1lBFQpMz9SFcz0eA+xI/9szP6u49++9HFACVH4DHj8PHL
         YEJpD7cfDq9/UZUaSDY3WYc7Wj39rU7aG3Nltpj/JRX/jJe1ABOZCJGM0lebmiQfLbv5
         F41reZUdcigNv8O5CenMRFmAITESJaTjfYN+fWsPwUdMyMmaUH3Y1c1K5vWS25U73qGD
         EJPUhErEn0mUj9kITF34Jo1aU1qnlIPpTecvJDMiePcdQNRbPprWiMgwbId8s5noItAb
         OIlcwTQTv6VBbqxSUAIa5RiGikAz9ufZgXV+zd+j9o8tgizA8HsjBgaoD32bDgw/Mut0
         DoGg==
X-Forwarded-Encrypted: i=1; AJvYcCVDWeGichkauiuUTlMX/Gjnf4u+j42idQcaXMFNNVIVN4Dtwkvfb34HATERlPU5PT5r2VkyyqycsQAb@lists.infradead.org
X-Gm-Message-State: AOJu0YxJ0A2zga9VdQZulm8o07OCMPf8Gan75qu2oo0tRLdqUj9HFGTA
	JefQcWH9n0omZURFsGpYNt7pjZ3M1K4sI3VEAYLlfutk4u+T3cNblqdnzaLl681cRVs=
X-Gm-Gg: AZuq6aKFPEwD4MzNgjbFQ03APZ+vFoKNchRojOffknCDGbdYaALo3Q3OoPoHfikeGqI
	eSJmyEN60mTCq46y8f64oL2ZjF0kwHZ1UohyV/7zoKfPWP4xsW+ZHDv3x5ZpQ5/lm9qoaeroapQ
	5JJkYRG3tJjdCdnoSi3mRr1wMGjqDA0vUw0jqsPcO4ZsVwxmOTlmZoPwJzCDsLybABPFUCO546E
	Snvd8m1UzM9Kg+i6rLgbeHBF5czDpj6Idsv2PsvhvzibhTyDXlCX7/aZ+EQKTQWqedutV6wGguo
	cEdffBoenGn/XwB6eyoK3Da45qyw+ZuhGBRivqb2zE5qp4rhAIexVklhG9sqepUxfdHO6/pt4En
	EzmIZtIo67JnNUw75fT+d2GETjoi6FuHc8sAxVxhEdOOT4gRpmfGbmcrDefd5TJAZJNuL9bytt2
	CMf7U2kjxxRY9uvQh971jZk4Uq32tyHOKSWA==
X-Received: by 2002:a05:7022:6886:b0:124:9f56:832e with SMTP id a92af1059eb24-124b1093e80mr4183627c88.18.1769812583554;
        Fri, 30 Jan 2026 14:36:23 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-124a9d6b906sm13161717c88.4.2026.01.30.14.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:36:23 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v2 00/14] TP8028 Rapid Path Failure Recovery
Date: Fri, 30 Jan 2026 14:34:04 -0800
Message-ID: <20260130223531.2478849-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_143625_173233_EB86D6BD 
X-CRM114-Status: GOOD (  21.48  )
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
host to send an nvme command to source nvme controller to reset impacted
nvme controller. Provided that both source and impacted controllers are
in the same nvme subsystem.

The main use of CCR is when one path to nvme subsystem fails. Inflight
IOs on impacted nvme controller need to be terminated first before they
can be retried on another path. Otherwise data corruption may happen.
CCR provides a quick way to terminate these IOs on the unreachable nvme
controller allowing recovery to move quickly and avoiding unnecessary
delays. In case of CCR is not possible, then inflight requests are held
for duration defined by TP4129 KATO Corrections and Clarifications
before they are allowed to be retried.


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
  have been added to sysfs to make the values visible to user. CIU and
  CIRN can be used to construct and manually send admin-passthru CCR
  commands.

* New controller state NVME_CTRL_RECOVERING has been added to prevent
  cancelling timed out inflight requests while CCR is in progress.
  Controller flag NVME_CTRL_RECOVERED was also added to signal end of
  time-based recovery.

* Controller recovery in nvme_recover_ctrl() is invoked when LIVE
  controller hits an error or when a request times out. CCR is attempted
  to reset impacted controller.

* Updated nvme fabric transports nvme-tcp, nvme-rdma, and nvme-fc to use
  CCR recovery.


Ideally all inflight requests should be held during controller recovery
and only retried after recovery is done. However, there are known
situations that is not the case in this implementation. These gaps will
be addressed in future patches:

* Manual controller reset from sysfs will result in controller going to
  RESETTING state and all inflight requests to be canceled immediately
  and maybe retried on another path.

* Manual controller delete from sysfs will also result in all inflight
  requests to be canceled immediately and maybe retried on another path.

* In nvme-fc nvme controller will be deleted if remote port disappears
  with no timeout specified. This results in immediate cancellation of
  requests that maybe retried on another path.

* In nvme-rdma if HCA is removed all nvme controllers will be deleted.
  This results in canceling inflight IOs and maybe they will be retred
  on another path.

Changes from v1:

* nvmet: Rapid Path Failure Recovery set controller identify fields
  - Added subsys->cqt defaults to 0 to maintain current behavior.
  - subsys->cqt is configurable via configfs
  - Added ctrl->cqt initialized from subsys->cqt.
  - Renamed ctrl->uniquifier to ctrl->ciu, ctrl->random to ctrl->cirn.

* nvmet: Implement CCR nvme command
  - Refactored nvmet_execute_cross_ctrl_reset() for simpler error handling
  - Renamed CCR list from ctrl->ccrs to ctrl->ccr_list.

* nvmet: Implement CCR logpage
  - Added CCR status and flags enums

* nvme: Rapid Path Failure Recovery read controller identify fields
  - Renamed ctrl sysfs attributes uniquifier -> ciu, random -> cirn

* nvme: Introduce FENCING and FENCED controller states
  - Added two states (FENCING and FENCED) instead of (RECOVERING and
    controller flag RECOVERED)
  - Updated __nvme_check_ready() such that fabric controller in FENCING
    state is not ready to send requests. Also a request sent while
    controller in FENCING state is completed with host path error
    instead of returning BLK_STS_RESOURCE.

* nvme: Implement cross-controller reset recovery
  - Renamed nvme_find_ccr_ctrl() to *nvme_find_ctrl_ccr() to pair with
    newly added nvme_put_ctrl_ccr(). The later handles releasing source
    controller used to issue CCR command.
  - Renamed nvme_recover_ctrl() to nvme_fence_ctrl().
  - Deleted nvme_end_ctrl_recovery() because the state change has been
    moved to nvme_change_ctrl_state().
  - Renamed CCR list from ctrl->ccrs to ctrl->ccr_list.

* nvme-tcp: Use CCR to recover controller that hits an error
  - Added ctrl->fencing_work and ctrl->fenced_work instead of changing
    ctrl->err_work and using it for fencing purpose.

* nvme-rdma: Use CCR to recover controller that hits an error
  - Similar change to nvme-tcp.

* nvme-fc: Use CCR to recover controller that hits an error
  - Similar to nvme-rdma and nvme-tcp.

* nvme-fc: Hold inflight requests while in RECOVERING state
  - Updated nvme_fc_fcpio_done() to hold the first request that starts
    error recovery. That was one of the limitations mentioned in the cover
    letter of v1.

v1: https://lore.kernel.org/all/20251126021250.2583630-1-mkhalfella@purestorage.com/

Mohamed Khalfella (14):
  nvmet: Rapid Path Failure Recovery set controller identify fields
  nvmet/debugfs: Add ctrl uniquifier and random values
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

 drivers/nvme/host/constants.c   |   1 +
 drivers/nvme/host/core.c        | 208 +++++++++++++++++++++++++++++-
 drivers/nvme/host/fc.c          | 215 ++++++++++++++++++++++----------
 drivers/nvme/host/nvme.h        |  25 ++++
 drivers/nvme/host/rdma.c        |  62 ++++++++-
 drivers/nvme/host/sysfs.c       |  25 ++++
 drivers/nvme/host/tcp.c         |  62 ++++++++-
 drivers/nvme/target/admin-cmd.c | 124 ++++++++++++++++++
 drivers/nvme/target/configfs.c  |  31 +++++
 drivers/nvme/target/core.c      | 108 +++++++++++++++-
 drivers/nvme/target/debugfs.c   |  21 ++++
 drivers/nvme/target/nvmet.h     |  20 ++-
 include/linux/nvme.h            |  70 ++++++++++-
 13 files changed, 897 insertions(+), 75 deletions(-)


base-commit: 8dfce8991b95d8625d0a1d2896e42f93b9d7f68d
-- 
2.52.0


