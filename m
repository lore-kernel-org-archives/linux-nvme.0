Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3E1EB3625
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 17:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tuZ5NgGmMK+fSDZK0DCtbPhVzRqmyqfPDxUv7waUs3k=; b=JOMRNQULAsTI8m6orij09sxv9V
	RzZgKKH1+h9RJtXyIbp9tRoDZOf1meQzaAhVCOmPpkTR+PvpyMpd/O6HBsUy0TcfLZX/B2N1hsXcz
	8e+7sUISXrvFXtozjaUaX8BJTM+TO8raL8CzC5VXouNZ2XbS77ZrhQor5FVbtrFcn6QP8wcTd+PJT
	vc/dpCFXNT35KqHkdO7vPC1Iy2UlDBa4usEP9CVPqefv0pWsEvpZ8e5Q+INSrtmzT1SX4jZldiJ+8
	V8DGoMTR2PBmNTMuj5YCEBYy/aztsvLQLrm0KpXbZXYyzcS0V4WkmW1SZ5KHR1TKd/Gjh+sCS1pCj
	2Nqenh/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx75C-0000000DaqS-2vw6;
	Mon, 02 Mar 2026 17:29:26 +0000
Received: from mail-ot1-x363.google.com ([2607:f8b0:4864:20::363])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx759-0000000Danc-2ihK
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 17:29:25 +0000
Received: by mail-ot1-x363.google.com with SMTP id 46e09a7af769-7d2ebc06f66so806456a34.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2026 09:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772472562; x=1773077362; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tuZ5NgGmMK+fSDZK0DCtbPhVzRqmyqfPDxUv7waUs3k=;
        b=TVuIyZ6BG+zpF0f4VVEk4ShbBvXgueCXzALpf41+hXeNTxZp3oifQRPQ2PVQjsrsZf
         L1ANr6XaUqymVpWwaeZb8Be9QkU47GwCBef/bA0PSjo4C0/z+oYdjWDTBf8CWe+Cu3B+
         vA4GSBOQr7IJIbaBmQAoo7/cOzSWdW4/+QMHEvBZJuYPr7Yg4B3TlahMlDMMSfuWAW3K
         t5Kz0aINaxAvBaYDuy8q4XdBIBfBLituVmDkwxnezDZ9HzbjbkcdCpmnin7bwH3rTXpj
         PX5+qZW/4xUwHjAmGP3WtNW/B9ML8KO4ENUXFMQYGjby8ixnRwWMvebvPQUH1vKDF8TF
         65vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772472562; x=1773077362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuZ5NgGmMK+fSDZK0DCtbPhVzRqmyqfPDxUv7waUs3k=;
        b=msWvJQgoOO7KuWZN1h1fX31E5lxWFKzr2Vz1jdOKymt6XzUQpZjLv6bYMiZI2jbwp0
         kAQH27XlCnbojffKJkezSrBLJ2D5IB3duBv1ei97/0QoyJK2kOBVRnwwCkcyhNKcTOsW
         lnU1r9n2obaHQiB6AMcKXxnZiaG8OKiZwQxT/7ysIwkfXCmsxzw8hBSlU2urf4eiVdv4
         mPsb0r7wfdiku6sslrCA+TUyugkkCgSnoWralAC5Pf75NqAlD3MJfkDyZ3CAoRIOGcht
         Gf+PTNlWs5yQXFG7ZCJYmo7cAlRjPLf35JdCEVU73sE6is6kPGEsIIm10Cd9oFSx5dKx
         39DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOuraX8jy5KAFxFH5H8u3isPbfRtJ+EoBaIozpwybni3mLcT/vKpxfcZVXvQPSl6HYvcpwFyEHonh+@lists.infradead.org
X-Gm-Message-State: AOJu0Yzt/OepmTcAapDE8wSpeff6yKHifh+Xa8DSNNVKODaU6voMTwNC
	TZoRbfkFcAcz1B+vkgI4L4BnBd0XH4H45aAlfu+JtdNc133vSy741ZdXV1Y0r7RQewihGiLvBB1
	7TcRaZlrEB5b0X1aYuJnUjyWYzh0nfGHc/AUk
X-Gm-Gg: ATEYQzwgsKZPSw/2JVR5PVOvaHddWLIvWKi78PuaxbzhViFqsfG1dhqfqNBFINIF9Xc
	ZDApQVaXLnhKu1U6MAGf8Xm+TRP3RrBAfLHKVagcj7hyoTDueA+HL2VVwZnerVMrUrYO2V0W+z7
	Kw55GGadlBQ3kT8QTxWdYcG2GMDsV4pklf/gU2PwDmexYnMh9uxCQaZUaQAfGe8wk3m/E+WB/L9
	AsKqm+Z0HNvRSWycgprFloHkhQO4B4OWEIXFM2ojMybsqFftq7aevDllbRSkT9ylbZ4EbNr2QYI
	MF0iXe2xgI6AJ5SEAekRxKmmVXo6/8jlgrJrZSTOF7gpXEJKhx6rp02bnoSx8U69cKvBRqlY/bP
	Cg19Y5RttgvIs9/cwanfzpw0XmzAKL0ikVsGixcUKu+StOMa0cClXWg==
X-Received: by 2002:a05:6830:718b:b0:7d1:474a:191f with SMTP id 46e09a7af769-7d591a02761mr7098900a34.0.1772472561822;
        Mon, 02 Mar 2026 09:29:21 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d5865024ffsm1764607a34.4.2026.03.02.09.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:29:21 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 09317340199;
	Mon,  2 Mar 2026 10:29:21 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 00D5AE41FBD; Mon,  2 Mar 2026 10:29:20 -0700 (MST)
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
Subject: [PATCH v5 0/5] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
Date: Mon,  2 Mar 2026 10:29:09 -0700
Message-ID: <20260302172914.2488599-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_092923_758653_024D0645 
X-CRM114-Status: GOOD (  14.43  )
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

v5: perform one iteration of iopoll when min_events == 0 (Claude)

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
 io_uring/io_uring.c            | 19 ++++++-------------
 io_uring/opdef.c               | 10 ----------
 io_uring/opdef.h               |  2 --
 io_uring/rw.c                  | 11 ++++++-----
 io_uring/uring_cmd.c           |  9 ++++-----
 7 files changed, 19 insertions(+), 39 deletions(-)

-- 
2.45.2


