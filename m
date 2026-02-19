Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5120FE9A057
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 17:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DQ0IUqmOj4ktterC5Me/w/j1jMtCqZq/q6fvEBLAaBM=; b=YtsaGVYWcMe0aVerRq+bc41XxO
	5KtrA6qBJaNTpfNxh1fA+GsyyPsu9s5tY3nw5iCkN4K//UcnK35jtxy8a54APSH9SERrTtnh/b9ox
	dJICuvNdxSWlpIidsZpuB0GDLjAddvXaAD6JZHiUXp33vJGTGYvPzh2rikFDZ3AFhnvf2VVkU7e0R
	4iA991qZYT0xa84ioR73OXu7o0AoKYjPKp+uMlRbbq1jMh6LBMFb3G9SVnF8LlLXurIrLi2AjqOWN
	BEgqU9ECqUUMvSdAhEZLR5FZyyQH4MyPl35PxHYrSYl0pEY6QBXolOletLY5QT0doB3qhYUDeztX4
	s//hfphw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt7k7-0000000Bh38-30PO;
	Thu, 19 Feb 2026 17:23:11 +0000
Received: from mail-qt1-x861.google.com ([2607:f8b0:4864:20::861])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt7k2-0000000Bgzw-412M
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 17:23:09 +0000
Received: by mail-qt1-x861.google.com with SMTP id d75a77b69052e-506a65d8698so1441651cf.3
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 09:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771521785; x=1772126585; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQ0IUqmOj4ktterC5Me/w/j1jMtCqZq/q6fvEBLAaBM=;
        b=TKAIKzCmXVKWudDedyzjh94yc4SDu7OZxti89ty7rTHmuSXT74DBmK1DE7a7n6ZNZX
         1pcJx73qeiwIJYQfyx5pmgzHILpQI4h5skmJ8+9VAZ+CMp5csAtNV4SjgZnp0B7qSz+4
         hcr3vkOe3YctTDSOhY6AMxciKYz33JDPX9824CVcudSkQm2DX8hKMiOPvgzlTcLkbmEb
         3gHKzS7L4Kf/KgHcVx8/sEIKLwY9cLT/awfFRjIMGzFeLbc+t1xY1v12QKkBkgZBTKHb
         6lsPnzaQmSo3XelwHzpoPpmvkTjyYK95876VVz+m+si3H/bWFba3/2HBgWbzH89kowBN
         nwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521785; x=1772126585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ0IUqmOj4ktterC5Me/w/j1jMtCqZq/q6fvEBLAaBM=;
        b=jQRUDPwC5het5pcd9ti86FtFClJcNcpvWC5cJXO3e9N/k94aG7yHqdGkxRnQcOrnrr
         iaUEY6SX/O8U8LDykzwZmUWNeVYlVczc+W+RlxqDCNA5zLcnzr83ITGeYEhlzyNav5dd
         wdGpyQBvoi5dlSBISdBogn+BsLS8d4I/BxV/0W+XDGSUug8dVec/dVBEyLFQTEs6uT9A
         x12CWyTwLDmLowfTc/f7zQ+WepygTTWi83y0fi9TpC1+eUw0AMfTfHDL6j9N17lmi/tv
         uF5VKuV8+00aVt0m1oF2FXrdkcpyGN+HyLTmuUNvJqKadVobKlYazUWA7zbdVFECTJEG
         7gGg==
X-Forwarded-Encrypted: i=1; AJvYcCUnBKXBQEwG6YGDgd1k9YjXBY/kPczF3eLliRMhdG4JethP7YR7ZfGd0sPO0mZ7mvUTYvjmpCVYk+I3@lists.infradead.org
X-Gm-Message-State: AOJu0YzcyqSdktGDvNRQxRvz1zqDSJ9iLbAHalfaXbgHvZtuZSowGLjb
	1jYOm4r/0jinmwNQok8SuVKYy7nHS1mBa7dNfg18BC0LC/sCMZOEV0+YDblrhxzUbtgQCPzTfAW
	TMB92+swRrDaBFxDf6apP10fc5OgzhSgJ8tPS
X-Gm-Gg: AZuq6aKi/Jx790glWREYKqZ+c44uxQw8XMgWCxW3undNX3lvvEnmQZ8FWa0CyPFHfAt
	RmVZbcBnnaMaWZbN6nIq6900i97wTVFRJRCRyPab+wJWfeZTeD+9ifguu4sPxA+ba3DA3N/yPhD
	cV80J92GnhYzAQX7mmS4O+dlu9q11bt3Xtvfw3qKJqoqmT2k++LCBgTu7TFCK3HcmYkmKj/mxs3
	14GIqFOK1e82V49pXogPOGu0mu5OJCl0KAbnFv0byhFqLktnyPJ/XP3DI124M+cIQya+XBb0uSh
	yrhjp1Y6APzSCp8a9EXLvtZ6VctFKI+PWvkm78/qSBUf8Op85WEYevZkkVotrE4GYjA1bS5aV6E
	lNFHiTd4q0zCF8IKwRX9NAKL6C9nguMMwscD99shr6+QNNJXlJTcL6Q==
X-Received: by 2002:ac8:5ccb:0:b0:506:bb3d:384c with SMTP id d75a77b69052e-506bb3d4c96mr198048761cf.10.1771521785284;
        Thu, 19 Feb 2026 09:23:05 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8971cd571a2sm31063356d6.20.2026.02.19.09.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:23:05 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 995183400C7;
	Thu, 19 Feb 2026 10:23:04 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7CDCFE41AE3; Thu, 19 Feb 2026 10:23:04 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anuj gupta <anuj1072538@gmail.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 0/4] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
Date: Thu, 19 Feb 2026 10:22:23 -0700
Message-ID: <20260219172228.429479-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_092307_007609_7532BB27 
X-CRM114-Status: GOOD (  14.46  )
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

Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
requests issued to it to support iopoll. This prevents, for example,
using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
zero-copy buffer registrations are performed using a uring_cmd. There's
no technical reason why these non-iopoll uring_cmds can't be supported.
They will either complete synchronously or via an external mechanism
that calls io_uring_cmd_done(), so they don't need to be polled.

Allow uring_cmd requests to be issued to IORING_SETUP_IOPOLL io_urings
even if their files don't implement ->uring_cmd_iopoll().

Use a new REQ_F_IOPOLL flag to track whether a request is using iopoll.
This makes the iopoll_queue opcode definition flag unnecessary.

The last commit removes an unnecessary IO_URING_F_IOPOLL check in
nvme_dev_uring_cmd() as NVMe admin passthru commands can be issued to
IORING_SETUP_IOPOLL io_urings now.

v3: fix REW -> REQ typo (Anuj)

v2:
- Add REQ_F_IOPOLL request flag, remove redundant iopoll_queue
- Split IORING_OP_URING_CMD128 fix to a separate commit

Caleb Sander Mateos (4):
  io_uring: add REQ_F_IOPOLL
  io_uring: remove iopoll_queue from struct io_issue_def
  io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
  nvme: remove nvme_dev_uring_cmd() IO_URING_F_IOPOLL check

 drivers/nvme/host/ioctl.c      |  4 ----
 include/linux/io_uring_types.h |  3 +++
 io_uring/io_uring.c            | 10 ++++------
 io_uring/opdef.c               | 10 ----------
 io_uring/opdef.h               |  2 --
 io_uring/rw.c                  | 11 ++++++-----
 io_uring/uring_cmd.c           |  9 ++++-----
 7 files changed, 17 insertions(+), 32 deletions(-)

-- 
2.45.2


