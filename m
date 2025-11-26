Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B4DD10373
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0DYMwugwCCMRbCMYT3zoF/0wVBmZFEJOOVa8ErucyPQ=; b=sQrLuMxSKAP9gyGmwPsdNYZMDt
	aXXeyiVs/hx3z6qClovjCr63i5zeUnQ8hmk6A7dYAjMDOLdIOTRK8pOZ4Ae5PRU85tmRHu9dtZvA7
	SNSiW/aCtiJ1sDXA2s0hH0ciFW91pDC39cvDak1zWpSeUbQ5d4nQBCQoeTfg+1vyTsHdn4KqTGO9G
	0lcVKsJFylIoqE+XFZkvZnPFuMdHmWOHTvhEcGrouPqwSuXJfEzjBdYVeYF3ywQssn/AIdMvIV7Xy
	4OF4TMup8KBeieM+91yFvzgDyLpTdQINVtXyYMnlFN4QnCCCVbjpfAMrFfL/jICtNU8WsH/D0mE/y
	reOZcVIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO525-0000000EDLr-3UqV;
	Wed, 26 Nov 2025 02:13:25 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO523-0000000EDKa-04QO
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:13:24 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-29806bd47b5so37630465ad.3
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 18:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764123202; x=1764728002; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0DYMwugwCCMRbCMYT3zoF/0wVBmZFEJOOVa8ErucyPQ=;
        b=W2ugtHuRdz6+PhXsWiB0+qwG7WarGsXb0wpxbhvCPuVgH2QDjXkn57sCKadWWZIhes
         jEgYAZdM/hS7b44po2dg5nUWnX5lw6FKVc6JCuO+RhSl33rXcoqw7l42xpCxDBon4zNc
         /zqauHIkRQ9h/XQbbJ7gY6Fi8xvphswcN6gQLRjLiSserOhxmoiIsgNKvs0pw0ZusBo7
         XqvCos58cf2KrcVPCavavD6MAgH9DRe3f8ZEsf7wC+dGdKO2DmZJKKscjn3co6LePErw
         cRFCJ+oKJVA1+Gtg2v/1K+zHV6iGEfKDvhLFpV7EVALAuDXq04MnSjemU5qEYhOH2WPz
         iTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764123202; x=1764728002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DYMwugwCCMRbCMYT3zoF/0wVBmZFEJOOVa8ErucyPQ=;
        b=FeWBQcnwHeeDC9zjWBPp3W7w0XUsoSaiHRl1YpyShgYDaFsYj/i2SxGtLTyzLNSIXj
         s+Kb1r5FAbEl7GSaAhkzFLZPlasgavM6XMvMqirlL6MQpA1zBwUdT7NnzKEaJaRW2rjd
         M8OC6p0vu5sEPZpj24O5zbQs2vqKoIbPLNintc+icq3eFvg9I6sQ1B2wdnFXWz/QrAUz
         ZtGSOuSILVpF0gtOeKkyfk9+V+Qj1h7CEvY4HSsAf+Ej1lY2P155vBXN5LAHwzhGuWJj
         LnrWlHILgc45hT9txRqLjnDt1mAaagaG6RtIiopcd16d9YDS/cKKURnKwvAloDchgfxr
         /Pfw==
X-Forwarded-Encrypted: i=1; AJvYcCXXSYJhMDpRZ6kV+uBfdR+8/YwnDb6TtitlxIbyG1xArpKSIfBIQd7lSgU2c5XoQ+mo4QCwH6lCmRMt@lists.infradead.org
X-Gm-Message-State: AOJu0YyJ5xPWgzw7H0nfDneLCObABAormvb61GAXEh3JauWw8pvg1NEY
	6yNG/7PeupUd/x6yv6hcpVsh3r0n23B6T5AEBzzuhu4LNODEYFz4JBRqGBrLzIa0p6U=
X-Gm-Gg: ASbGncv5nL9anp0yGQAryhzBBZV/65rt+w5go2CJhaY9fr4xvdD7AUCdjxZGbcbooLZ
	yIMgUgnNbmFVvi7PqFcgfkawRaovwkZ8eqGZadmzrio03V4YsXRhKrSB2y7Hca/6eUclf3x8Rr8
	etCsSACtXUrlksTYR238opUzhzXyaS3a6CQbPMvlFJDyRY5u3OOavnl9d9uEJueW8wYlQnXUDBs
	zYCOG5kBgOtvZs1FkcQNKml8YOwVm8tc0LZ4w80fieij2o6uiAYAAlxTff2/54NlCStzuYDJzWh
	8FKoVHyW6I1g2xmc0ssUHYXoBNhwWKkb+yOdvFS6de3hq0oXsYqfkPZL4RVOqw0aGmhIKQ2dEnk
	75XUoBil6fvHv22Szx0hfCFPWg1AlyCOFXdSJcReqRgK06cpOnb+/YmSHUQTC0wJRG2C1TffJlL
	1oCVVNxlL7i1oEcEEqUUsV0N1bKkavAsCMRA==
X-Google-Smtp-Source: AGHT+IHX3yT5pXdf7LYjSNE6WgFqzyyar12yID69DwGd9ndEqYxMAf61RI2rL1JknD6xXgHVKt+nNg==
X-Received: by 2002:a05:7022:ec16:b0:119:e56b:91da with SMTP id a92af1059eb24-11c9d811990mr11265772c88.11.1764123201516;
        Tue, 25 Nov 2025 18:13:21 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11cc631c236sm17922979c88.7.2025.11.25.18.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:13:21 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [RFC PATCH 00/14] TP8028 Rapid Path Failure Recovery
Date: Tue, 25 Nov 2025 18:11:47 -0800
Message-ID: <20251126021250.2583630-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_181323_219944_F6728A5B 
X-CRM114-Status: GOOD (  18.67  )
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

- New struct members have been added to support CCR. struct nvme_id_ctrl
  has been updated with CIU (Controller Instance Uniquifier), CIRN
  (Controller Instance Random Number), and CQT (Command Quiesce Time).
  The combination of CIU, CNTLID, and CIRN is used to identify impacted
  controller in CCR command.

- CCR nvme command implemented on the target causes impacted controller
  to fail and drop connections to host.

- CCR logpage contains the status of pending CCR requests. An entry is
  added to the logpage after CCR request is validated. Completed CCR
  requests are removed from the logpage when controller becomes ready or
  when requested in get logpage command.

- An AEN is sent when CCR completes to let the host know that it is safe
  to retry inflight requests.


On the host side:

- CIU, CIRN, and CQT have been added to struct nvme_ctrl. CIU and CIRN
  have been added to sysfs to make the values visible to user. CIU and
  CIRN can be used to construct and manually send admin-passthru CCR
  commands.

- New controller state NVME_CTRL_RECOVERING has been added to prevent
  cancelling timed out inflight requests while CCR is in progress.
  Controller flag NVME_CTRL_RECOVERED was also added to signal end of
  time-based recovery.

- Controller recovery in nvme_recover_ctrl() is invoked when LIVE
  controller hits an error or when a request times out. CCR is attempted
  to reset impacted controller.

- Updated nvme fabric transports nvme-tcp, nvme-rdma, and nvme-fc to use
  CCR recovery.


Ideally all inflight requests should be held during controller recovery
and only retried after recovery is done. However, there are known
situations that is not the case in this implementation. These gaps will
be addressed in future patches:

- Manual controller reset from sysfs will result in controller going to
  RESETTING state and all inflight requests to be canceled immediately
  and maybe retried on another path.

- Manual controller delete from sysfs will also result in all inflight
  requests to be canceled immediately and maybe retried on another path.

- In nvme-fc nvme controller will be deleted if remote port disappears
  with no timeout specified. This results in immediate cancellation of
  requests that maybe retried on another path.

- In nvme-rdma if HCA is removed all nvme controllers will be deleted.
  This results in canceling inflight IOs and maybe they will be retred
  on another path.

- In nvme-fc if controller is LIVE and an IO ends with an error from
  LLDD, only this IO will be completed immediately. However, the rest of
  inflight IOs will be held correctly because the controller will have
  transitioned to RECOVERING state.



Mohamed Khalfella (14):
  nvmet: Rapid Path Failure Recovery set controller identify fields
  nvmet/debugfs: Add ctrl uniquifier and random values
  nvmet: Implement CCR nvme command
  nvmet: Implement CCR logpage
  nvmet: Send an AEN on CCR completion
  nvme: Rapid Path Failure Recovery read controller identify fields
  nvme: Add RECOVERING nvme controller state
  nvme: Implement cross-controller reset recovery
  nvme: Implement cross-controller reset completion
  nvme-tcp: Use CCR to recover controller that hits an error
  nvme-rdma: Use CCR to recover controller that hits an error
  nvme-fc: Decouple error recovery from controller reset
  nvme-fc: Use CCR to recover controller that hits an error
  nvme-fc: Hold inflight requests while in RECOVERING state

 drivers/nvme/host/constants.c   |   1 +
 drivers/nvme/host/core.c        | 197 +++++++++++++++++++++++++++++++-
 drivers/nvme/host/fc.c          | 194 ++++++++++++++++++++-----------
 drivers/nvme/host/nvme.h        |  24 ++++
 drivers/nvme/host/rdma.c        |  51 +++++++--
 drivers/nvme/host/sysfs.c       |  24 ++++
 drivers/nvme/host/tcp.c         |  52 +++++++--
 drivers/nvme/target/admin-cmd.c | 127 ++++++++++++++++++++
 drivers/nvme/target/core.c      | 103 ++++++++++++++++-
 drivers/nvme/target/debugfs.c   |  21 ++++
 drivers/nvme/target/nvmet.h     |  18 ++-
 include/linux/nvme.h            |  57 ++++++++-
 12 files changed, 778 insertions(+), 91 deletions(-)


base-commit: fd95357fd8c6778ac7dea6c57a19b8b182b6e91f
-- 
2.51.2


