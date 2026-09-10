Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC52CC88E41
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 20:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bDCr9GzV1B1Q6u77NnAu+24+DGPgnFPYx7acDChAt8Y=; b=XPzAhG0D4K/4HAp0NwHSdgGm16
	XwLDK8EKm6M7SbsiuLaDHWdwsaX5CwGsHxpRcZjqA43IYDbj6u5cHNPaN18J1JGz7aNUSDNVysWUo
	zxDogW7FPL5k8tJ5rrY+nEe/9BOPlsy/62qMGFKtIW6IBQAM7GVTdcysvIMSbjImtgmXGLSlXmBB/
	aOWh4xZ+x2OrDMvFDoKYEomMb7nXJ3Tv3MfhWg5LeqVvzlfc5xV7UG4MKifudZzRscXmp/rDwl0pH
	UX/3IijcCAEhnN3/hBx+Bvy9Hvbp/1dQGkppf0sv1b45b59gKF+AWXkwP7xIjtczuVx7sf6FK2H8D
	dMVLgFlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4lNy-0000000FKhl-1V81;
	Thu, 10 Sep 2026 20:28:42 +0000
Received: from mail-qk1-x764.google.com ([2607:f8b0:4864:20::764])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4lNu-0000000FKhM-2G81
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 20:28:40 +0000
Received: by mail-qk1-x764.google.com with SMTP id af79cd13be357-92e99ef0902so1978385a.2
        for <linux-nvme@lists.infradead.org>; Thu, 10 Sep 2026 13:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789072116; x=1789676916; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bDCr9GzV1B1Q6u77NnAu+24+DGPgnFPYx7acDChAt8Y=;
        b=KOHrfByoYtPqQw4Lv2UlewcvuHB5ATLR893n4p9rNI3DanB1OKzYHl93oWNSboBZEs
         MP4L+xnIF2ZSFi+y5Ak6QSTimQ3gR7Imu7/cjZu3QcG/4bc3np+Jdqp0iO1HHIy5mMJm
         jJHeMK2kmRYxqBz7IJkjsGzGQvMk1x/+1ccrnMb3IodHnGHhdsYjI3RRIgrhMYS6mCsP
         G9Xd3ypgCEk9wMuKiZvFm3ndGWQg/qh5GOLWcYBrlaEaCjLAaQwcW+ugeGaypmss27EB
         MGHJWjiLSAc0Sobf5NXri5SzhFGJLiHFdD7zrt3IYQxZ07kn64TzVeN4SQPpRTuMoBO3
         dXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789072116; x=1789676916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bDCr9GzV1B1Q6u77NnAu+24+DGPgnFPYx7acDChAt8Y=;
        b=oihqmtdt8SAG3XdvkRtCKB5qrniHYThmn657ssnQL/P+vAonRTZq/d67gD/oIsLFQw
         IixzsP+GyX/EIoLqB0jx6HhCokLlNqme6j0a8U0Szm1+WxRbuabRd/hcvpul5Pyg+Jkg
         9CrA0iUgdU82ufiNdSTc0Kigix2tXIPAkhG18gxq16+7BWsBt67893ZJQMXtCSENlBYB
         uv1xUnhuAVNozGcPAVohDqQwwZ25+trdYy9acPGjOCuYk4RgN8/jyaZt3faFjtiugCTu
         sOFUYve62HJW+VBjlowI2Fqk79292DGu4BVVlz1kM1QtvRbV0uICDqEuEMwqDoKuFFCp
         vAkg==
X-Forwarded-Encrypted: i=1; AKwUvBz1zr7ITb0wE0jbLiNGZTI/RAYiGQ9MQfSIjUcmK9aGdp5COX6gCQCekfmwxbPdTs6lUDK8uEJehux/@lists.infradead.org
X-Gm-Message-State: AFuF++nuwH6Ib3GRcGJe3xHTyI/VDnYxN4mVQOY5plWxUctTjDaL3Qdn
	KBpjyFYHjcOjnB7t1JbHWLxs0vK0J0Ey5s9sRTY5s3BG0Z5g6iwToqMg7Z0CAGBSuxEGOPl2VTb
	nN5VDvtwjQYTcymE2wy60AEZx6TYShf5+HLBu
X-Gm-Gg: AYBFou0tj95bwqIpmJQSnUdd5SkvwMCKCfGWrQKTOuMtLcfuYDSxU/KJ/dwnXB7tDt4
	otEGCqU8QfLt4mjnjCHmQBzHQkEExsb/WoY4zSn2ePe9d5lg5upa3PcfKsO+SBTAF4L8KLSUo1F
	i8wbWrwDXwQIOh/5YWgimHJHrdO2R0v2NkQKKptzr1W3b2I6AP80tpM/adsmfUmqy9RkPgwIgys
	NYGKTvmPvOgofsSDhSVuXLALqs3Bx/XbyUnSUNRjAliZpKXmyBI+GebzFDeIAvUAq8sRagAmUW3
	bzqSqfQlM1NNPXhnKE1AehvP0Nw3fdoxCe+X8UKDmCKU+BMZADrRi04grnxRnXNlZD0++IoRaek
	nuY2wZ86zKqgUE1tOlmQAAerlqrdlSVs=
X-Received: by 2002:a05:620a:40c5:b0:936:e938:b07a with SMTP id af79cd13be357-939ea048390mr86167985a.8.1789072116518;
        Thu, 10 Sep 2026 13:28:36 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-939e8102456sm7339885a.2.2026.09.10.13.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:28:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (bond0.slc5-n22m24-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:429])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id E2889400F1;
	Thu, 10 Sep 2026 14:28:35 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id DE99A51EC2; Thu, 10 Sep 2026 14:28:35 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Solganik Alexander <sashas@lightbitslabs.com>,
	Roy Shterman <roys@lightbitslabs.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	adailey@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: [PATCH v3 0/3] nvme-tcp: parallelize I/O setup queue in connect 
Date: Thu, 10 Sep 2026 14:28:09 -0600
Message-ID: <20260910202812.1642832-1-sgogte@purestorage.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_132838_745293_B86A0AC4 
X-CRM114-Status: GOOD (  11.48  )
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

---
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
---

Surabhi Gogte (3):
  nvme-tcp: store and use the caller's network namespace
  nvme-tcp: refactor I/O queue setup path
  nvme-tcp: parallelize I/O queue allocation and startup

 drivers/nvme/host/tcp.c | 144 +++++++++++++++++++++++++++-------------
 1 file changed, 98 insertions(+), 46 deletions(-)

-- 
2.55.0


