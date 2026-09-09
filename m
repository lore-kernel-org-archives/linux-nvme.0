Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19CCC88E41
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 22:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sAKhWIfpeZ5+jLFDZPzZcWORkKqrMwJSrxhzssQpKO4=; b=h1eMFcmbM7W8qP0STlClN4EYQf
	jo+smNqAG3PucpAu16T7aU6s+J3i1hiQ1Gb+T6AsNNxJ+VS6gBk5m20nmM4hDZwkm9pRi+oZ7rsAP
	ok72RWXRUbzQxDuXMymxgploic1JqpMN+q9KH4K64PAAjoayoa77N3MktE9v9WM1cO9SS1NtSj4DR
	UcI6oIReIzQ34+u5wgZ8oQTGRnYQeWSw5o/aW8YsWzB81/M3bRLCjHb78fHJxG06/nXYvezxQTw5Z
	m3zXJVO/x8qrrw8lWPoszVh13lDY0DvnsuRW9QA1hWwsooceeVNyVyrCe1JnXIu5l0rOkXaxRkrKr
	RJ59E4bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Qmy-0000000D0lG-1u5C;
	Wed, 09 Sep 2026 22:29:08 +0000
Received: from mail-pj1-x1063.google.com ([2607:f8b0:4864:20::1063])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Qmu-0000000D0jG-2UfL
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 22:29:06 +0000
Received: by mail-pj1-x1063.google.com with SMTP id 98e67ed59e1d1-398fb0feb91so191698a91.0
        for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2026 15:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788992944; x=1789597744; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sAKhWIfpeZ5+jLFDZPzZcWORkKqrMwJSrxhzssQpKO4=;
        b=a4/BOh7OOFSxwOEqL4P2i5QbnUAu70YPM120HjkVtKMp54/cgt1wAKCk51aTw2nq2z
         VgXwaTa60kgcL4VPJfmpya/vzBBZrZ6RWJy063CRhAmWJ837pysIwDSqA9B6MX8JtYQJ
         J7JgGaeOE+6Z5Ez6mkvdD9dRIAj0R1XsJKdQKgzs58YUdv6vWIE/sgYWR5GwJ23e1Qlm
         gslYxmiM6MdbHBoFH39l1WLFY/n6PAF7cbGqqJtPllCvZSOIyiRPU29+42YqV+lfncJU
         xJNCfbWfDeWRBkf/p0tHvik8L81sCVHvzxyS4Y14CCZkqUGIVXOqmr3mICYc827MJhha
         KMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992944; x=1789597744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sAKhWIfpeZ5+jLFDZPzZcWORkKqrMwJSrxhzssQpKO4=;
        b=ogqOiE25362/2+Tnv2W3atRY65pAmoyB2RP6sHBUdK8KdpvWR4U0ZbYDwYVdsaGQ75
         LsWDYSNit+Hn+JerVy+Y1P3jwOy3SQzJwmc6ntARoUUsJBJWhwepvqvFFiheu6alVzm4
         Cq4idYTY9fT6L6Ds75dxXBRAPbujG1AmiP91F8czarfej450eR19r/8R3anS5VkxwqZI
         8JEGyBgq4X42o7a5CU8xsHpBMK0GaQLTaYy83qQPR7BgIY2prCoeBdiXt0mNSnJ0aiVm
         56XeYN9XB7D642WEJESqQKNzOvHuFqzaHrCWVvvl1miEsk0B0NyuzIX6S973QHemRuWc
         TkVg==
X-Forwarded-Encrypted: i=1; AKwUvBy421awHqrH9NLPHuKPhw7NWQnClq8dj8wXeyBG/TXPK38TtlYqP+k+nYRjF3Kh4w7oPiV28ieMtzme@lists.infradead.org
X-Gm-Message-State: AFuF++nF5I2PfHDUv76YHoVByq5H6dNvD4rt+nfVoHWPC/RwGOvYAPSe
	iFhayGy0on6hl4pCfWqOaxBLkrUzyVIhCeVtnOqXgaRs572/kZSQa39BGfHl6kkTyZZqLAFxbea
	TQr7sQRPmKeSEUblVmVRiMsrxB1/X9e/1BwVeR3Zb2IO7kVYdvA6s
X-Gm-Gg: AYBFou1Mv3lwttnevdFbchSYpu0DKsr9nTb1slpuBq/WrNSOSBBH0wQjWzkOGeuL2+s
	PjIbWAvKyXvC8NRiMgPaUvHdlKxIX0x82Z7yWvELvpu2od27IcHK4YH8LAfZOEptHT83SV6wCcr
	iWszvPKBI8dUrfIeIPeL6rMK22NvLwepuIlxOGVDZj+BKeDBhQ6W97VDYn7LrWBkk248j7+9gnW
	Fy1FiMQGGPqw4FelsplHb+SinQYafULWY0OQD0fosL2KwQYGSjbW4qP03uY97bX7JVgeRNPQU7g
	6kLd47aSinJAbQrIrqZcavucmuFxKKzNNtpLPArWXduHSdv6ulJ0IKVn2sNrc0v/VsioORTiL9h
	ZWXKb6aPvFNJlQvwZ
X-Received: by 2002:a17:90b:384d:b0:398:bac0:238e with SMTP id 98e67ed59e1d1-39b3d8377camr32217761a91.6.1788992943615;
        Wed, 09 Sep 2026 15:29:03 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39d77406179sm490112a91.5.2026.09.09.15.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:29:03 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id E70B9402A9;
	Wed,  9 Sep 2026 16:29:02 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DE5A0E40322; Wed,  9 Sep 2026 16:29:02 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/6] io_uring/nvme: support fixed buffer for metadata
Date: Wed,  9 Sep 2026 16:28:30 -0600
Message-ID: <20260909222836.2475352-1-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_152904_818679_964EC1A0 
X-CRM114-Status: GOOD (  17.66  )
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

io_uring NVMe passthrough supports using a "fixed" (registered) buffer
for data, but not metadata. On high-IOPS workloads, the pinning and
unpinning overhead for the metadata pages is significant and could be
avoided if fixed metadata buffers were supported.

This patch series adds the necessary plumbing to allow NVMe passthrough
commands to use fixed buffers for their metadata. The metadata and data
fixed buffer indices can be specified (or omitted) independently.
Supporting separate fixed buffers is important as metadata buffers are
often stored in separate memory from the corresponding data buffers. For
ublk zero-copy I/Os, sharing a buffer index would be impossible as the
data buffer is a kernel registered buffer while the metadata buffer is a
userspace registered buffer.

My main question is which layer the metadata fixed buffer should belong
to: core io_uring, io_uring_cmd, or NVMe passthrough? In this initial
implementation, the io_uring_cmd layer stores the metadata buffer node
and the NVMe passthrough layer defines the UAPI.

The main argument for moving the implementation to a more generic layer
would be to reuse it for other io_uring request types. For example,
IORING_RW_ATTR_FLAG_PI could also benefit from a fixed metadata buffer
option, though this series doesn't implement it yet.

On the other hand, core io_uring_sqe and io_kiocb space is very limited,
so it may be undesirable to dedicate it for a somewhat niche use case.
The metadata buffer node storage could be pushed to the NVMe passthrough
layer after my in-flight series [1] to reclaim nvme_uring_cmd_pdu space.
However, managing request-scoped resources from a ->uring_cmd()
implementation is a pain, as the same request can call ->uring_cmd()
multiple times and may or may not complete when ->uring_cmd() returns,
depending on the ->uring_cmd() return value. io_req_uring_cleanup(), in
contrast, provides a single cleanup path for all uring_cmds.

[1]: https://lore.kernel.org/io-uring/20260909155848.2069290-1-csander@purestorage.com/T/

Caleb Sander Mateos (6):
  bio-integrity: remove dead bio_integrity_copy_user() error path
  nvme/ioctl: remove struct nvme_uring_data
  blk-integrity: pass iov_iter to blk_rq_integrity_map_user()
  nvme/ioctl: pass iov_iter to nvme_map_user_request()
  io_uring/cmd: support fixed buffer for metadata
  nvme/ioctl: support fixed buffer for metadata

 block/bio-integrity.c           | 51 ++++++++++--------
 block/blk-integrity.c           |  7 +--
 drivers/nvme/host/ioctl.c       | 91 +++++++++++++++++++--------------
 include/linux/bio-integrity.h   |  1 +
 include/linux/blk-integrity.h   |  6 +--
 include/linux/io_uring/cmd.h    | 12 ++++-
 include/uapi/linux/nvme_ioctl.h |  5 +-
 io_uring/rsrc.c                 | 28 ++++------
 io_uring/rsrc.h                 | 17 ++++++
 io_uring/uring_cmd.c            | 30 ++++++++++-
 10 files changed, 160 insertions(+), 88 deletions(-)

-- 
2.55.0


