Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A17104891F
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 22:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RUIpiL+ETinhgcxbF3zsLQKsMyyJnBp6MmzUqHPBa/s=; b=RN9Z0BjBNtZ3tyZRtQrFNFNv8d
	eNoYQcfH8jI4/sQArQISzkcrEpTBuy/fFLaBQxm6FPgNj8xTxSxeredHFl9BZlTYV/9XPHxGKxpzN
	PHTGe1yleRk/EzH1ymDEiaRhOxVygYJW43u7mIsr3E7/bgMaRYwHucypkp9tr7Rpr/qLx534qmXN/
	6edIzFDl5pHqlCX6md9nYm9l1imjP1/1nrZidXuXoUch0v28bIm6E5ish4kXfC/3npbaGH1LW09Yp
	D4HII6OgAMhwqomEBHzpOCHUkJ6UO7RnCL7G/bWzpDi3VvOab1/qJq0Lh0sv4xm/2ZhrJ0J1uwX2s
	HAGplU0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6QT-00000009Dlj-2rQm;
	Fri, 27 Feb 2026 22:35:13 +0000
Received: from mail-qv1-xf61.google.com ([2607:f8b0:4864:20::f61])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6QP-00000009Dki-0xZi
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 22:35:11 +0000
Received: by mail-qv1-xf61.google.com with SMTP id 6a1803df08f44-895498f3819so2546096d6.3
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 14:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772231707; x=1772836507; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RUIpiL+ETinhgcxbF3zsLQKsMyyJnBp6MmzUqHPBa/s=;
        b=IZSIzgQDKCU1U+d7wyxHBpYgdT2m0ngKiGJr+sl1MxKsmP1Jm7p+h1tQgO8mYTyy3X
         Gg8VAutiHB2bSsPG6FOTYSFN2QHPQWwG71ZKb1sYRxnaqek8PGu5i9x9y2PnGs6qc3xl
         4wA+B8K7x9Df1196tv7L6TM9Juqp7uibu3CSrNB21vJmdLdDGtTiBqFbtb/gAGZyYkL6
         W+OC6RGox2tevJTIawKPVX2spU4mXF7GZFzgVy7AQ/eSTQR3GAMdEWKbJNUabnmCvHQg
         a087V714T7W3Mg/mPVFuq5U5buHIzm75vt8wKgBcW5qHUy7gl3MtKrRhypTYXmOE6v/d
         CCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772231707; x=1772836507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUIpiL+ETinhgcxbF3zsLQKsMyyJnBp6MmzUqHPBa/s=;
        b=qiu2vzHD23m24BNUJsax6Ndabn6M+wXEy/4Rzdabv9b6OLDw2F6g9j2kvQC3iOQrGC
         dm8P4Y7T+QSTCfJ7lv0EjuHi9R5xKfnSbN3yzgvql9MwB7BEpt/SNdG0qSGh7ZmBmBfo
         jG0bGqu/ssolcQrLX4WCVU1iEc3ELRXXfYUMfJIRXO6ZwDIZyAlfJNltcow55oBybojX
         MyRFc6Qq/DO34X4pXqks2dSUi+fReoKY+ryAUBCl9kyP1ZkrGeI/II90SCfQtogw0wK4
         clxCbH1moOGJd7jfeK11+7GMekff/sOmntVW51oMqs0bzLLat72dR9DPATQJYVf7FhcL
         IOwA==
X-Forwarded-Encrypted: i=1; AJvYcCURvysVexlcviDeNxthiNmBDU91wlfxMaUxletjzJJ4ZcYK4+UCWMGDc3HJEDKYpk1cmwqCSHqMDDyD@lists.infradead.org
X-Gm-Message-State: AOJu0YxEz7nAJE31TN/GQhgrVBUb3zicT0aAm8a/X3Tkf4zKJzjWUANb
	4jq08ys61CT2Z00aKrt3g9pSEhDFbA8FAaEVFTVR9E3H/CHFksH2Zm/19QjI+GAoJoAbdnXIij8
	dFVUdaEeW3mP/Dqt2RWpaQ4YKG2iKrHuuzlQG
X-Gm-Gg: ATEYQzwIrj0T+ebEc6DUlz/BFyOv8OkKJQqeAUe/NV4VScTbgoH7D18oapmR5qX9Bx6
	bTwlnVITaKQYWmwj7M33bnUns3KcNEGY1Kt1D1caYZE4zLz81CuppUlgi01AqJOwbZ0PRpELVp7
	WwJjxclIEZGsoEwE+PFMKjdQf4bI3+Qkh4IdhBvjy1hByANtf7wYl3OqXjY4koIsbusvhoA2Vfu
	B83MhfW8yuy3bDPiYNnlSSXYUYjy4lJOZa+GDz8Fwm+PhMpocAI2ocwKtGKiR3tj3rXTXtRakFC
	+HJyEIJmFgRMg5KbJ9cf6diBcO+bGD3od7gb16Ncq86NXxyv2+YbTYFvRHPvgp1Lg6F0Rdhze7s
	5zeM38SNk8wq+sZO3C+E7EOwTzTOAltlp/aVsIv+orIg1aXajMCGKNA==
X-Received: by 2002:a05:6214:800a:b0:897:ac:13f0 with SMTP id 6a1803df08f44-899d1d861aemr47334816d6.1.1772231707333;
        Fri, 27 Feb 2026 14:35:07 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-899c7154514sm5901616d6.7.2026.02.27.14.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:35:07 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9592634076F;
	Fri, 27 Feb 2026 15:35:06 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8937FE420D8; Fri, 27 Feb 2026 15:35:06 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Ming Lei <ming.lei@redhat.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 0/5] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
Date: Fri, 27 Feb 2026 15:34:58 -0700
Message-ID: <20260227223504.1162421-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_143509_347851_C44B4A0C 
X-CRM114-Status: GOOD (  14.18  )
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
that calls io_uring_cmd_done(), io_uring_cmd_post_mshot_cqe32(), or
io_uring_mshot_cmd_post_cqe(), so they don't need to be polled.

Allow uring_cmd requests to be issued to IORING_SETUP_IOPOLL io_urings
even if their files don't implement ->uring_cmd_iopoll().

Use a new REQ_F_IOPOLL flag to track whether a request is using iopoll.
This makes the iopoll_queue opcode definition flag unnecessary.

The last commit removes an unnecessary IO_URING_F_IOPOLL check in
nvme_dev_uring_cmd() as NVMe admin passthru commands can be issued to
IORING_SETUP_IOPOLL io_urings now.

v4: check non-iopoll CQEs against min_events in io_iopoll_check() (Ming)

v3: fix REW -> REQ typo (Anuj)

v2:
- Add REQ_F_IOPOLL request flag, remove redundant iopoll_queue
- Split IORING_OP_URING_CMD128 fix to a separate commit

Caleb Sander Mateos (5):
  io_uring: add REQ_F_IOPOLL
  io_uring: remove iopoll_queue from struct io_issue_def
  io_uring: count CQEs in io_iopoll_check()
  io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
  nvme: remove nvme_dev_uring_cmd() IO_URING_F_IOPOLL check

 drivers/nvme/host/ioctl.c      |  4 ----
 include/linux/io_uring_types.h |  3 +++
 io_uring/io_uring.c            | 28 +++++++---------------------
 io_uring/opdef.c               | 10 ----------
 io_uring/opdef.h               |  2 --
 io_uring/rw.c                  | 11 ++++++-----
 io_uring/uring_cmd.c           |  9 ++++-----
 7 files changed, 20 insertions(+), 47 deletions(-)

-- 
2.45.2


