Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A951C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:37:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D733C2072D
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OSI70h03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D733C2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y9Ehnh8sgRQf/imr3gQvteNRZpA7kt2oXIy/6x8i+xM=; b=OSI70h03Z80e541SIK6XQK1LS7
	Ilr5+pYmsAu09Xq3Bpxg6iGad0UQcOraQG7v78DY39jXSIVs63CltT/9jmPob1k2zAyCgJH8b7WIg
	9Ep5GGvp3UjbpN7av1zESTfnItgvncwF5bBasdG7ZvehdyYHJ0eDdurzaSzlix8oSgj+fsu79vc48
	HRP2nCbDb4pZUxyf4IXxpkipf/odl2ywFAOOjOe3G5Eq3rJqGfU2dykGkAUvKCuKCsc6rQmPEvglR
	bhBXtXIL2al6ezQv26o2xRlCXDq43xe1mLAZlraEPWuAOLUErE19nARbiHPd1Qa3dK4fwIW6jnl/V
	qfEMi1VQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8dG2-0000ao-Ut; Thu, 20 Aug 2020 05:37:03 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8dFz-0000aN-RT
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 05:37:01 +0000
Received: by mail-wm1-f52.google.com with SMTP id k8so511422wma.2
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 22:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gNuFYsTQqmLOurbVKzLfUkhyRRTPx1edTir6TWd6ChE=;
 b=mX7CtJUZSKzaK2JoC3so696YT4AMQ1Y9638ZX5GwpvLlF6Ja/YcAEy7Oj5KunrEeBJ
 WpIfJ6DEmodNv3MTSlo1+Eo2CRmDfFhHyPGh9lDZKEVf0mmezYN7jmIoiR5ZzibGspjD
 CYNxFaGXcfkWdZOIyGgDmArmavkQzJj2lVZ8QVE13PVbqBMWxPiYI8KN7xUkYKlb5+nf
 PXkFB/hm9L3et+oC0OvyLHJk4GKL/P2TetnAXiz6g4CiGHlQi4/vzo8ka7gE3DikieH1
 hxp3ZXlmWCOO7ILWwSvWPLyXhwydB7i3Xkwy2CPY0L0GpgBHtzpxl1Zkig8vzkj14/uO
 FC4Q==
X-Gm-Message-State: AOAM5327GyCuS8niDmWyA60z+LjHzqRJXoV/z+gcRuNJ9H4zEBZrihI1
 qqtV52ITLkrOtBRG4raMfqDcqXIBxqYMIA==
X-Google-Smtp-Source: ABdhPJygxC8kJqDTsdF8JwrS1lW+5zmPr+h0iyf6kbLkSG3Bx1wPwp4dheOYAXFluO/4Jxkg1LTuFA==
X-Received: by 2002:a1c:540c:: with SMTP id i12mr1588316wmb.96.1597901818418; 
 Wed, 19 Aug 2020 22:36:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id a10sm1900353wro.35.2020.08.19.22.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 22:36:57 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v3 0/9] fix possible controller reset hangs in
 nvme-tcp/nvme-rdma
Date: Wed, 19 Aug 2020 22:36:42 -0700
Message-Id: <20200820053651.197057-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_013700_266125_DDD4F38B 
X-CRM114-Status: GOOD (  12.58  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When a controller reset runs during I/O we may hang if the controller
suddenly becomes unresponsive during the reset and/or the reconnection
stages. This is due to how the timeout handler did not fail inflight
commands properly and also not being able to abort the controller reset
sequence when the controller becomes unresponsive (hence can't ever
recover even if the controller ever becomes responsive again).

This set fixes nvme-tcp and nvme-rdma for exactly the same scenarios.

Changes from v2:
- move NVME_CTRL_NEW state check in __nvme_check_ready to a separate patch
- various comment phrasing fixes
- fixed change log descriptions
- changed patches nvme-tcp/nvme-rdma: fix timeout handler to restore the
  timed out requests cancellation for all the non-LIVE states as the request
  is going to be cancelled anyways. The change is now purely fixes how
  we serialize and fence against error recovery (as pointed out by James).

Changes from v1:
- added patches 3,6 to protect against possible (but rare) double
  completions for timed out requests.

Sagi Grimberg (9):
  nvme-fabrics: don't check state NVME_CTRL_NEW for request acceptance
  nvme-fabrics: allow to queue requests for live queues
  nvme: have nvme_wait_freeze_timeout return if it timed out
  nvme-tcp: serialize controller teardown sequences
  nvme-tcp: fix timeout handler
  nvme-tcp: fix reset hang if controller died in the middle of a reset
  nvme-rdma: serialize controller teardown sequences
  nvme-rdma: fix timeout handler
  nvme-rdma: fix reset hang if controller died in the middle of a reset

 drivers/nvme/host/core.c    |  3 +-
 drivers/nvme/host/fabrics.c | 13 +++---
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/rdma.c    | 68 +++++++++++++++++++++++--------
 drivers/nvme/host/tcp.c     | 80 ++++++++++++++++++++++++++-----------
 5 files changed, 119 insertions(+), 47 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
