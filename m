Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C96CCF2C4
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Oct 2026 01:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fP46F+XvGnx9CdMMM+Zzwz/exfVRKEgKwRy73Evl4hs=; b=pcvvWiK5GEPm0v6H14kbCTm66U
	UrJjWmTJlBFjnAR42O5Y0ZPYvWWF1T8lQIKwZbdsuCL8KLbNCyDFDFf6fesmgoejG4DtTuBDUK0+F
	0cEW5kFu9aA6WoVib8h6tlPJhb/MvDWPgcJnWEN30WvzU/4jLuH4SCPnkYEWebWn+Ytqujudofdj/
	n5sMpK2q88PMfOJtHGVnrdYR1OAKSJPz+ds3syUlrDyPIKLHVXe1BqevZlKV0HdIqHGXQxBD1hfPD
	BKrkWPLYS+di4DNqfA9055CBOViO1Y2a4fvDiZ7wz/MdmWnP2/dheUomyWvUgnB3z4cjEB/ipN+TJ
	iiS1OOhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIFGx-00000005O6P-18vR;
	Sun, 18 Oct 2026 01:01:11 +0000
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIFGu-00000005O60-1KKo
	for linux-nvme@lists.infradead.org;
	Sun, 18 Oct 2026 01:01:09 +0000
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-35aa0cf7c40so2011806eec.1
        for <linux-nvme@lists.infradead.org>; Sat, 17 Oct 2026 18:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1792285267; x=1792890067; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fP46F+XvGnx9CdMMM+Zzwz/exfVRKEgKwRy73Evl4hs=;
        b=EY7BnL1rbieeq6cJRM6xXjNCAlq7bwzT0XXY+qx0EZiB4g0pKj+Ixlx0lOcuvYzesI
         zpUbYC72wZJQR9koevq00NQiaNICO0ALP248Oi4C9hCFjvcdSRonqJBx9tQceTqSvZke
         Qfa2bDCZ/rIoQiWvliloTWbOJ8hK/hume63jzLoxD7j74gZcWL9vb+CxrB/aOHsErVAl
         Z1B0pzYACS0y6H9K3f4/kJt7Me43bGlmmlVEm5wDWzHhXnBWV+76frpepTnWFK2YWage
         sWkGcopdBtp6GhHg82kQ8+8NwruRSc+fg2eSdwa5/RzcTnwx0OxbVMldolMLMb2eUApe
         sJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792285267; x=1792890067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fP46F+XvGnx9CdMMM+Zzwz/exfVRKEgKwRy73Evl4hs=;
        b=mpDi5ubmzOGaD5IECHHNvKUGvMN+acdIPWJsmRoT5Bi0fAUuj2td/PQnTyPlFFaqT1
         yfjS6w7/ZPuGvysx716pdLqYJqoZpnU21OFXCkO2FxWO915SbVnbsVa6nBoUM+QeCZy8
         jUkyVHSuxcXRtLbOEsph8GRKq8z6Y8S/wt8ZLdKtUhYNCr8gAN7oO6ClH+lLimrwfj26
         E0Lyym3M0GKtQ/Roebl+U6igl3/8BcJp8osB3b+dlFST7IN1ZZkH5wmcOBKBXqM9TZnD
         QtxSk0jOan6nXgoHuakIrI1UG3o51Pv5kp1MAqKGv3t6ozTBnPXClOIKRfLvAO5PI5Go
         kbjQ==
X-Gm-Message-State: AFq9FYJUaOtGQRal7Rr866Lsrf6I6wo0mKxoJP1s9xr3E99DgYhqKuen
	rnXmxwe5vD7VU46IP+/G4UCYEH8LjT3YXt50EseGB+87K8rMVNtUVvrq6vKx1YwJjo6Gr98KC4u
	PUEu3DmyPXQ==
X-Gm-Gg: AYBFou1vwyJUgHPwYVP7+uRAQ5xXdSjjdOgDYTmnbmna/qFDUeeoVOxi5jwb33b7xvf
	T0WcGDNJ++RL7ZJOF1hCtZrHQGEaRanm9mIxv/SnSci64GnZXMB4KjcZDe++Z5oFuePHJcZGcGO
	pttA9tL4MUhDJbNYlyy9vWy5JTRNiKi5V52ubmVERIAfdABXJn45SKTvHhgwAn+UekJeyVSYOCg
	sGqpJXbVcO2HkNBvDqQFZNEjD6Ef4pnSN3LwV1P1X2WM5Nlgi80AGwI0WJncl06666uidStoxpR
	gmVAFd6RjmkoPMIO/vC39/xDUQAEOYbuMGYHJ6rxkYzy13IW0zvLUK6o3FvyQA1kqYxAHpsbKPQ
	gs4hkarPBkYqPHsKzeUX6IyEBlLf30zq9AKSWgmiMLDbazYtFm4fJT8OOcirzzJOTRQeeHgyskr
	TzdCTLPBQekGVWsdvKC38BgIToXGb8Q9UOmh/cXZFWC5PuCS/HqJrGdzjBCIGD6Y/I2azWbIh/U
	qb2rvlFbS3lRVL5Ax9reh1woh56n9whOICxiCX0oPOi
X-Received: by 2002:a05:7301:71a4:b0:361:344d:e906 with SMTP id 5a478bee46e88-361a195c23dmr5957696eec.14.1792285266951;
        Sat, 17 Oct 2026 18:01:06 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([71.202.170.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm24198870eec.20.2026.10.17.18.01.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:01:06 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	nilay@linux.ibm.com,
	dwagner@suse.de,
	sgogte@purestorage.com,
	hare@kernel.org,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	Saravanan D <saravanand@crusoe.ai>
Subject: [PATCH v5 0/2] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Sat, 17 Oct 2026 18:00:57 -0700
Message-ID: <20261018010059.83120-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261017_180108_367589_38A0CBFA 
X-CRM114-Status: GOOD (  12.33  )
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

On hosts that partition their CPUs after connect time, the connect
time io_cpu selection can land a queue's socket work on CPUs owned by
a different workload. This series lets a control plane set each
queue's io_cpu directly through sysfs.

The first patch adds core helpers for a transport neutral

  /sys/class/nvme/nvmeX/queues/<qid>/

directory per queue under the controller device. The second patch has
nvme-tcp expose io_cpu and managed attributes there.

Changes since v4 [1]:
- Rebased onto nvme-7.4, which sets up the I/O queues in parallel
  (61b0ed3be81b) and serializes the io_cpu accounting with
  nvme_tcp_cpu_queues_lock. The per controller io_cpu_lock is gone,
  and the io_cpu writes take nvme_tcp_cpu_queues_lock instead.
- A queue's directory now follows the queue's allocation, added in
  nvme_tcp_alloc_queue() and removed in nvme_tcp_free_queue(), so the
  directories match the queue count after a reconnect (Nilay). The
  core allocates each directory and its release frees only that
  allocation, which drops the transport's reference counting and
  completion (Nilay) and fixes the use after free, the controller
  leak and the teardown hang found by the Sashiko review of v4 [2].
- The transport creates the queues directory once before the parallel
  queue setup, and the kerneldoc states which calls may run
  concurrently (Nilay).
- The user assignment flag moved from the core into the nvme-tcp
  queue flags (Nilay).
- io_cpu is read through nvme_tcp_queue_io_cpu() and written through
  nvme_tcp_queue_change_io_cpu(), which carries __must_hold() for the
  context analysis (Nilay).
- The sysfs store collapsed to a single path and no longer checks
  NVME_TCP_Q_ALLOCATED, since the directory only exists while the
  queue is allocated (Nilay).
- The queue stop now clears NVME_TCP_Q_IO_CPU_SET under
  nvme_tcp_cpu_queues_lock, since a store may move io_cpu between the
  clear and the decrement.
- nvme_tcp_free_queue() drops NVME_TCP_Q_IO_CPU_SET, which also fixes
  a ledger count leaked by every failed I/O queue connect.
- io_cpu parses a decimal cpu number, and the ABI entry describes the
  directory lifetime, persistence across CPU offline and the behavior
  with wq_unbound.

[1] https://lore.kernel.org/linux-nvme/20260927070925.47209-1-saravanand@crusoe.ai/
[2] https://sashiko.dev/#/patchset/20260927070925.47209-1-saravanand%40crusoe.ai

Saravanan D (2):
  nvme: add per-queue sysfs directories
  nvme-tcp: allow setting per-queue io_cpu through sysfs

 Documentation/ABI/stable/sysfs-nvme |  29 +++++
 drivers/nvme/host/core.c            |   6 +
 drivers/nvme/host/nvme.h            |  23 ++++
 drivers/nvme/host/sysfs.c           |  88 ++++++++++++++
 drivers/nvme/host/tcp.c             | 173 ++++++++++++++++++++++++----
 5 files changed, 299 insertions(+), 20 deletions(-)


base-commit: 2e8e30b3cf9f165e1a1d079331543cb7f2ad0e0c
-- 
2.55.0


