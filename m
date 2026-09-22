Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EB7C982FA
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 20:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Vsx5sNHXuWXYLFUY3r/lMl9Ziy/DA8qKQ5KpvcRU7Oo=; b=hmTvPNPjyTvZmzPoRPsBm07dhz
	0WZ3r0R8v1qTfiCCVRFR8WJ5/R/v8yObRyrYVQS0L0taZY8L53LtOzfCJ8mCkyYRot4hANxlqOe+v
	B9fyJhJFhv8YAvcOi53tKnXGXLzdsr0UAdzNKcbCjkHLXnt2N0YURBOrH03I5wfqVGQfFc+JRFfQY
	Sqi5wmmPqzbl/wgAnWFZuUAtIlqsh5zVK2gmq734qXkRveZigwUkkm1xGrGs79/hHoZCK/6rzNR0k
	kPw1NtZ2sAO+5zq5iZwf7M86/ytTy6ptSKvNCblMYOeXR8AjJupXuDdE7WwZkSF+rmDXPLKRnIywY
	nOT1QIUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x96mB-00000006VYv-1SS8;
	Tue, 22 Sep 2026 20:07:39 +0000
Received: from mail-yx1-xb167.google.com ([2607:f8b0:4864:20::b167])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x96m8-00000006VY8-2XPe
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 20:07:38 +0000
Received: by mail-yx1-xb167.google.com with SMTP id 956f58d0204a3-672b96ef4b8so65636d50.3
        for <linux-nvme@lists.infradead.org>; Tue, 22 Sep 2026 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1790107655; x=1790712455; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vsx5sNHXuWXYLFUY3r/lMl9Ziy/DA8qKQ5KpvcRU7Oo=;
        b=BjWApym/yU/1XiNp/r0Ig/vVl1HurCTb9/Jv4x30UkR29IL9ppwF8pG1usJfqXqa1m
         TCKV9lw1L9Lkvu1bdGiMCF5d6zyHZ1zFhde+EgSCTjlE5a+quXwH1Iev1y/+mk3F23gI
         IMaC0BcGKQDPCuDwAN7VzMu25f71nJV9dmRTCL65rwg9zAiN9ewRq6zrxeTE7FNqZZAz
         ufr5igPdZiIw/gvoJwXMxj9yOOHOjhVWR38TEbX4oJKuFaVBGlfdkQzm4R+mWmYf24Yj
         ZDuAgi2E+N4cEe+FBKdnzKPmoVQXyRbQmW4/93Tu+dI7+qvIwylfJv3b5RjblEeKEnHp
         e5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107655; x=1790712455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vsx5sNHXuWXYLFUY3r/lMl9Ziy/DA8qKQ5KpvcRU7Oo=;
        b=1pXn2KgjSaAgWiK0ha87xRCYtunWnOqNZyqPDXU5DRhHtqFjnQ+GnhZcw8X/oeV7pL
         qVkJRxYqg+eHB0H607I8Og3hZHoI/yrVwWmnTnrCMVwY7xA8b0LNaCFcJbWnAXQ7Yhn/
         FsxwOP7Si3mX3ig+BnI1NdrYNq5uu1rFryur92KfPl7NTCBZ8owpqDCRIqm22gYPcfcg
         i0f4NFsETAIQisnQK8hYBOjq7JF+aapdnp1TI3HvW3g9sbXg96mvyiT1QdlDJWgYRx3o
         M3oz3PPnvI3e0hOn+vc5oLe0j3bao5omX1du7VgRf56iXJdKJHI3wdy1NTg/OwNKV+LJ
         pl+g==
X-Gm-Message-State: AFuF++l7T5HqD57k/j+vzU4hw2AzBjKFTpFijxOXSGf42PlxtwacV+o4
	vnzc7kVN2F3PHOtxLf4AI8LqevmNW55Vs7bFqSnT7NHVVHc4eMUe93vPP83aNKvZMtW/ozfnRs+
	hzkFVGsxm4nVzFT5DkUDRzQrzUNBFFN7SmZwT
X-Gm-Gg: AYBFou1g+f458HjeFUzbxqpBGUowf2ZFNFjbUSaFl2yGoaLyH+p9JeZjMQN1eppsrzZ
	NWi/UqarEm0rGWONnY/CF6oUJY+wnkADI5KZEL3rw7DdbDXMPvYeb1G7j1KRaOxLA4Xy1IU0MWV
	bSGgWsL+Nj0WUh8Y/XTlMmk12bi16lmHWohwvKeoMIlUXI9U0hYYkfVNbUZwL/CCi21dg6u1Veh
	P+LRUHdujVm6IKUjmckC4Ihekr3YBSPNu699VTp4XrJpzqmp2Gn2ewt6S5j0FnVx2LIPVOjf3cQ
	vs4pBSZ1WZ5kfSkFgqA6r1+ltPoDlJa733HAj0ipRoIx1MLP43Pb0hOa7jblZEBY3kR707SD3xL
	m3ThN9LkAFWogPl2ay7W0zKT0JKDVhpE=
X-Received: by 2002:a05:690e:24e:b0:672:99e0:ec08 with SMTP id 956f58d0204a3-672d59b5281mr219751d50.160.1790107655240;
        Tue, 22 Sep 2026 13:07:35 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-672d80499fasm12358d50.13.2026.09.22.13.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:07:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (bond0.slc5-n22m24-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:429])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id B3E1B4014B;
	Tue, 22 Sep 2026 14:07:34 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id AE4343F9F5; Tue, 22 Sep 2026 14:07:34 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	adailey@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: [PATCH v4 0/3] nvme-tcp: parallelize I/O setup queue in connect
Date: Tue, 22 Sep 2026 14:07:15 -0600
Message-ID: <20260922200718.3941465-1-sgogte@purestorage.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_130736_688303_B30162CA 
X-CRM114-Status: GOOD (  12.01  )
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

Similar to commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue
allocation and startup"), I/O queue allocation and start steps
(including authentication) can be parallelized for nvme-tcp as well.

Patch 1 fixes a pre-existing bug: nvme_tcp_alloc_queue() used
current->nsproxy->net_ns to create sockets during initial connect
while it used kernel's init_net for reconnect and error recovery
paths. The fix captures the caller's network namespace at controller
allocation time.

Patch 2 is a preparatory refactor: it splits the queue-count
negotiation and TLS PSK checks into helpers so that the individual
steps can be called directly from nvme_tcp_configure_io_queues(). No
functional change.

Patch 3 has the async implementation: it fans the per-queue alloc and
start out over an async domain, serializes the per-cpu queue-count in
nvme_tcp_set_queue_io_cpu() that can now run concurrently, and uses
ctrl->net for all socket creation.

Testing on a 64-core host with 64 IO-queues shows nvme-tcp connection
time reduced from 61ms to 11ms.

blktests - nvme suite, TCP transport (nvme_trtype=tcp)

Tested with:
- Ubuntu 22.04 LTS (Jammy Jellyfish), x86_64, KubeVirt VM
- nvme-cli v2.13 / libnvme v1.14 (built with libkeyutils)
- ktls-utils tag ktls-utils-1.4.0 (c63c04b) (tlshd) linked
against gnutls 3.8.5

---
v4:
  - Moved conditional from nvme_tcp_configure_io_queues() to
    nvme_tcp_setup_io_queues().

v3:
  - Added patch 1 fixing a network namespace bug: reconnect and error
    recovery paths were creating sockets in init_net instead of the
    controller's namespace. Patch 3 now uses ctrl->net (from patch 1)
    instead of hardcoding init_net.
  - Patches renumbered accordingly (v2 patch 1->2, patch 2->3).

v2:
  - Resending the entire series to fix missing numbering in the
    original patch 2 subject line. No functional code changes.

v1: https://lore.kernel.org/20260824222939.301887-1-sgogte@purestorage.com/
v2: https://lore.kernel.org/20260824225648.316962-1-sgogte@purestorage.com/
v3: https://lore.kernel.org/20260910202812.1642832-1-sgogte@purestorage.com/
---

Surabhi Gogte (3):
  nvme-tcp: store and use the caller's network namespace
  nvme-tcp: refactor I/O queue setup path
  nvme-tcp: parallelize I/O queue allocation and startup

 drivers/nvme/host/tcp.c | 139 +++++++++++++++++++++++++++-------------
 1 file changed, 96 insertions(+), 43 deletions(-)

-- 
2.55.0


