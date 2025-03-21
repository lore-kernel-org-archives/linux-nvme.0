Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA70DC36000
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 19:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mHccgnyGjmXgT4aBmP5V5Ck7Nqm5/kAs+bF2mszWGKw=; b=QxrzPLoi9PK1Vi3bIVHj6SszhB
	Jj2TrMvm/lqRo9tIj6CY4Xj+mQDOOryzR5fz9H118vnR1Zme6l2JapoMRD7Hy6VsLdcMWuLIszEED
	+64DreHBW5Bd9GDoNX5ebfPyqWZ5Bq413jLhnqPPxtJCwOdUJ2uSn2Ulajp8rsDlAuuuim+WD7aZG
	ibcYVMktCOHZehHA9KLzp4PSWzzmmUPoTmFWx/4SMRDv6krsdNTb44UeD789BU4KBC9IXkhkvBjqI
	gac8wpOlTcsO0jZPTCEWH7wawx1jzoBy8VosKH1xHWpI3/b5MZlU3V2U+1DYPizh6Xf2qFpl3Gysa
	BwdLSKWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tviMx-0000000G557-46zk;
	Fri, 21 Mar 2025 19:49:27 +0000
Received: from mail-il1-x161.google.com ([2607:f8b0:4864:20::161])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvhQ3-0000000FuJK-0HVs
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 18:48:36 +0000
Received: by mail-il1-x161.google.com with SMTP id e9e14a558f8ab-3d44b338e04so661885ab.0
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742582913; x=1743187713; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHccgnyGjmXgT4aBmP5V5Ck7Nqm5/kAs+bF2mszWGKw=;
        b=EVY4xrQwGyp7ac69yvVcM+bB7DxGolzz/yzWoLv3tWGnV5ZUQLoQeEMinR3vKyuL2d
         SE3FRDIhATEAyGLZI+MW23y0md8NZ9++Upf8a5W2JE1c+6+xqt91Fg7ynrDN351FqU4K
         HyB8qB/+jgZgUw1WgwTn5TGEXPtzxlJYiQGDRxfQzhT1UJUJtjnLVYtuVmsV0BLUsyk7
         AwmBVZdb2/gQQYl/A8h52coSiJUyXC6NsscGwSptKEoTDd2xBh7PB9EBXXnT8zMjoTUr
         gp/ddkRIP6EsY2qYPfNN+wDzI+b1ZIISl4xcQkmuC2VVwgerUu38TMUrLJWpeHmZOSOV
         oNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742582913; x=1743187713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHccgnyGjmXgT4aBmP5V5Ck7Nqm5/kAs+bF2mszWGKw=;
        b=XwR8t9+ZIlIpom6Fki6yeoJFHutgQ3nkJTdo4npO1YKJLo7j/0R2w2WbQpcPbqiKQU
         LPdxQkqjRE7Uv/L/KDcReMI3CTzeqvIhWOMsXzRMSlu0An9SMfA/9Rk4e++Ki1LFl0gc
         IHbx+fjml4WQlIdBNDAHEFJO4BEkmBPrm6j4GycT/QSYuHPGJFkP3DA2HAJDdTDldYPJ
         yzZuApZN734HXhDTamOP/9D97XGpQQUUdLR68qgTXUwyb05794FcTZuu6CP7Kw0dasm+
         jvy+T6gVV3O2+/NzcSBr/EtW/BU0s91mcLDmW82aSfke9ac5mr2y57VHvNvMuDCi5vUx
         uZ6g==
X-Forwarded-Encrypted: i=1; AJvYcCWNntdn2ikq0gn4i36fzEOWLyJmUInxYauPGzPOCjhpqBCEQxLNA83+KgGLKiInZbF38NsT/0UQj7Jo@lists.infradead.org
X-Gm-Message-State: AOJu0YybWXf74WtULUnKUCdA7Rtt1imgHbs2/pSjDcG6hyZ4+Q6Kpqij
	9L8DFwj74ut8ziSdAZ1+59HsP7hz648Z6hRbEe1R//EOlCl5DaDEXv00X+n84pQlQFS2Q2DaWph
	y8R7MaiP2XosJKD+vZczN5R/qVSUFgTYN
X-Gm-Gg: ASbGncsf+Tud6azZdqzLGbtKpXC66suqO+zV1x9Bg+L4q+lcP7YsyWHHP5aILFEzBo7
	2MY3Y5x12wGQlCoC8umXdLWSrQ1dRZssL/YcKzaNCAEPmDkQsuRBqXXuzO+Trxmcgwroi0SNrmB
	tNt9qK02rIZMs8Yr/+be2pfparNv4IDYUdrhjA2NyIWu+dhosYpEg40uT1w6uks0fy9yTaQcpdz
	PGhJf1BnKzaILcsiGD+bCcUHUVFHVe2LnQW5y0/W5RpqJ9Nhla4fjEdQsL4RpIK1h2DyRpOo4hx
	EMfQOq31uD/e/uqCs39jKaiECSNcgdKPyBT01x1d8HxhTBF2
X-Google-Smtp-Source: AGHT+IE2gq8VfE7y0u8ZE/y1UaXhkIL7UtIv5Dn35ylqA63nyjKdHBiBzbQoseHLAnZkyIwqHMeuICy9o9u5
X-Received: by 2002:a05:6e02:1fc7:b0:3d4:2db:326f with SMTP id e9e14a558f8ab-3d5961853b9mr13368595ab.6.1742582913368;
        Fri, 21 Mar 2025 11:48:33 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f2cbf03526sm103702173.56.2025.03.21.11.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:48:33 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B430F340245;
	Fri, 21 Mar 2025 12:48:32 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id ADE5DE4192A; Fri, 21 Mar 2025 12:48:32 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Xinyu Zhang <xizhang@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/3] Consistently look up fixed buffers before going async
Date: Fri, 21 Mar 2025 12:48:16 -0600
Message-ID: <20250321184819.3847386-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_114835_152789_0ED87BC5 
X-CRM114-Status: GOOD (  14.21  )
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

To use ublk zero copy, an application submits a sequence of io_uring
operations:
(1) Register a ublk request's buffer into the fixed buffer table
(2) Use the fixed buffer in some I/O operation
(3) Unregister the buffer from the fixed buffer table

The ordering of these operations is critical; if the fixed buffer lookup
occurs before the register or after the unregister operation, the I/O
will fail with EFAULT or even corrupt a different ublk request's buffer.
It is possible to guarantee the correct order by linking the operations,
but that adds overhead and doesn't allow multiple I/O operations to
execute in parallel using the same ublk request's buffer. Ideally, the
application could just submit the register, I/O, and unregister SQEs in
the desired order without links and io_uring would ensure the ordering.
This mostly works, leveraging the fact that each io_uring SQE is prepped
and issued non-blocking in order (barring link, drain, and force-async
flags). But it requires the fixed buffer lookup to occur during the
initial non-blocking issue.

This patch series fixes the 2 gaps where the initial issue can return
EAGAIN before looking up the fixed buffer:
- IORING_OP_SEND_ZC using IORING_RECVSEND_POLL_FIRST
- IORING_OP_URING_CMD, of which NVMe passthru is currently the only
  fixed buffer user. blk_mq_alloc_request() can return EAGAIN before
  io_uring_cmd_import_fixed() is called to look up the fixed buffer.

Caleb Sander Mateos (3):
  io_uring/net: only import send_zc buffer once
  io_uring/net: import send_zc fixed buffer before going async
  io_uring/uring_cmd: import fixed buffer before going async

 drivers/nvme/host/ioctl.c    | 10 ++++------
 include/linux/io_uring/cmd.h |  6 ++----
 io_uring/net.c               | 13 ++++++++-----
 io_uring/rsrc.c              |  6 ++++++
 io_uring/rsrc.h              |  2 ++
 io_uring/uring_cmd.c         | 10 +++++++---
 6 files changed, 29 insertions(+), 18 deletions(-)

-- 
2.45.2


