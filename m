Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686AACD4F54
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 07:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=b+YxUb9tnY9+516KxTbXxWzTyfA5pPGtJElvbz03+zw=; b=Ni/iS2dwSYeTaCjyYdSCiqG8f6
	yidCVgtbb+B68DB9GnGFMc02WEIVy1qEXFmcYBhjCmhLU3CMqUiPSmewyJzqTl/4Mmv5bOEhVzCPv
	hX2Ei6CfWkq8gyvXcysr1O+Oca7WpdNDJtpCOwmp3MNb79LtDc+mvVIO+5INQBOHQzH2vEjJn/Y8F
	VsyswG/iI44Q9Mq+y+PzhQUScbc/IumnT9W/bJB1AWZwvxsk4mzpTHgz2y4M1jODsSt4XKVJIzK8y
	FbBXJvSa2GKsRszB9UeWK8eh9d6s3DrFQ2klhVQctzCDUE5+r7P4uKZ3FTV4/3C5GU8gmph2WdE3f
	jMwxkaTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS95I-00000003UlN-2PgX;
	Wed, 27 May 2026 07:53:48 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS95G-00000003Ukp-1HoE
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 07:53:47 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-367c26471f5so7365117a91.1
        for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 00:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779868425; x=1780473225; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b+YxUb9tnY9+516KxTbXxWzTyfA5pPGtJElvbz03+zw=;
        b=o2n2ISnJ5AxUrBr5UhEsJrDwUL8CQqBcweRei0nUCWijpKghe9JrQVAMIF4HffqFUV
         zuIigNvWso31CZbHU4hPF5t+S6J77Z15rmEs0oHyv+rp7ojzrHLJmHFbrhZqYd+Vqhg5
         8iUcnbFY3K6kSk7znXzgYrl4EQICzGeVGD4fdLhYPsYxCnF6durGlgdV/7Wop5hWsrwa
         FN3YO43EtxEUndn7cdItMBeJDiNTs8b+UCXUl8AitwkxeaZRSOPj8jzb52WJ7u2ASOSy
         ARXk0fXe58FLKzVMcPjetP64xoLQz3D+v04TnkKHbm95EdzPfNB+DrQChyXAjQ+aHtWz
         i0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779868425; x=1780473225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+YxUb9tnY9+516KxTbXxWzTyfA5pPGtJElvbz03+zw=;
        b=H8qr373UbdW63dwYjc61W86Xw/XTElpRCCaLr3je0qVYBvdO+tEWOU0p7qdifGmccf
         0pbJ7MxtR5Eqfp6uEvCXJ3UgJAFKYW4IjSFDiQZt+kPttdCfs5g1+gANGUKglbMFzIGJ
         ivUoUho1/CJNW3vqclMzyTE4feXBDF6qmZmldtjLd1CLPczepPgI+jTwn04oCspwWrNR
         N5FDYSPonR0bYL923X9ReEXKoVwXVon5JYbizXbajO66SakKSIvGT9gAvxO5Xp/EWhw0
         hyl9ZJB+6OyCYolVz3QZHRtR4iZfX1wCudHcX0PIDnbp+cbMC4TIkWiunQEoqMZDzuWh
         ijqQ==
X-Gm-Message-State: AOJu0Yy4OlEzkERdN1tAZ+w24tXfrArtngXrivt3sCDin3VDHwJQiGMe
	yC/NPvwsejZfZUCK8WBBoCEETgW8B3ZkzOsGN4iGRo3otsJIhymz1iD6
X-Gm-Gg: Acq92OEGp9knEa4a6gif6ZP9AE0prXruFn2Qu4rCD85lh0sqnafr4Qwc5w090Hhr/m7
	JZdb/IycxLKA5z/jZP19fVmXl0APlLw5oyl/iUmNl5AEYQi8e4xgLdSjwy1fxRE8CDNLzFGocFI
	hftxRiJn8XUe886aX8978GiHryNEukvLu/jb3JzyCr/75qOUYAkwKetR4Jlkw40Hi2H0BXTV8t0
	yef+muBZT2swqETajXGkWxHG7eh5G5QHZfwY7HNSjv+tNA6kZZ/INAb7RZEkCj8kslfcJnSwcRM
	l6FD8Z91lo3XPnkn4nrqxpUYK3HeMwQOLEfrTHCl3n9YBF+5VWk5/sKYSGNFUjtj0swmSVq8Jy+
	SnW2ANtKOCO7wpvYt3L8d5sgUuctvj+7U3myIirFTXnypgXGl7DCvvJDJpxTLjlaL2/1RZHbcFZ
	zVWSraJppCQ2z/iAp5ujBDhvun9byTlKasANBCeWI=
X-Received: by 2002:a17:902:db07:b0:2ba:3e50:e3f5 with SMTP id d9443c01a7336-2beb0634c8amr248897615ad.30.1779868424801;
        Wed, 27 May 2026 00:53:44 -0700 (PDT)
Received: from n151-105-216.byted.org ([240e:b1:e401:3::a4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56bc151sm147558455ad.24.2026.05.27.00.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:53:44 -0700 (PDT)
From: guzebing <guzebing1612@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guzebing <guzebing@bytedance.com>
Subject: [RFC PATCH 0/1] nvme-pci: detect I/O queue depth changes after reset
Date: Wed, 27 May 2026 15:53:19 +0800
Message-Id: <20260527075320.3178600-1-guzebing1612@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_005346_351956_31EFD84E 
X-CRM114-Status: GOOD (  15.45  )
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

From: Guzebing <guzebing@bytedance.com>

We have hit a case where an NVMe firmware activation made the controller
report a different CAP.MQES value after the following controller reset.
This was seen in production on a Memblaze PBlaze5 510 device:

  model:        P5510DS0384T00
  old firmware: 224005A0, CAP.MQES-derived queue depth 1024
  new firmware: 224005F0, CAP.MQES-derived queue depth 128

One way to hit this path is to activate the new firmware and then reset
the controller:

  nvme fw-download /dev/nvmeX -f fw_bin.tar
  nvme fw-activate /dev/nvmeX -s 2 -a 1
  nvme reset /dev/nvmeX

When the I/O queue depth derived from CAP.MQES became smaller after that
reset, the driver failed to recover any usable I/O queues.  In our
production kernel this was logged as:

  nvme nvme0: IO queues lost

The namespaces were then removed, so the corresponding block device
disappeared.  The opposite direction is less visible: if the CAP-derived
depth becomes larger, reset can complete without an error and the block
device can remain usable, but the live queue depth state is not updated
consistently.

The reason is that reset updates only part of the live queue depth state.
The nvme-pci reset path disables the controller, re-enables it, re-reads
CAP, and recalculates:

  dev->q_depth
  ctrl->sqsize

from the new CAP.MQES value.  Later, however, nvme_create_io_queues()
reuses the existing struct nvme_queue entries.  nvme_alloc_queue()
returns immediately when the queue already exists, so the old values
remain in:

  nvmeq->q_depth
  nvmeq->cq_dma_addr
  nvmeq->sq_dma_addr

Create CQ/SQ then requests queues with nvmeq->q_depth entries (encoded
in the command as nvmeq->q_depth - 1) and uses the old SQ/CQ DMA
addresses, not the newly computed dev->q_depth.  The blk-mq side also
keeps the old depth: the reset path updates the number of hardware
queues through blk_mq_update_nr_hw_queues(), but it does not resize the
existing tag set or update its queue_depth.

This explains the observed shrink failure and the expected grow case:

  * If the CAP-derived depth becomes smaller, the driver may try to create
    an I/O queue with the old larger nvmeq->q_depth.  A controller that
    now enforces the smaller CAP.MQES-derived limit can reject the Create
    CQ/SQ command.  If no I/O queues are recovered, nvme-pci removes the
    namespaces, so the block device disappears.

  * If the CAP-derived depth becomes larger, the old nvmeq->q_depth is
    still within the new controller limit.  Queue creation can therefore
    succeed and the device can remain usable, but the live state is
    inconsistent: dev->q_depth and ctrl->sqsize reflect the new capability
    while nvmeq queue resources and the blk-mq tag set still reflect the
    old depth.  The larger depth is not used until the controller is
    removed and probed again.

There are two broad ways to address this.

The direct fix would be to make reset recovery handle a changed live queue
depth.  That would require updating or rebuilding the nvmeq depth and
SQ/CQ DMA allocations, and resizing the block-layer depth state
consistently, including the blk-mq tag set, scheduler tags when present,
and queue->nr_requests.  That is broader than an nvme-pci-only change
and needs block layer review.

This RFC instead takes the smaller approach of detecting the reset-time
CAP.MQES change and making it visible.  If the live I/O queue depth
shrinks, reset recovery is failed before recreating I/O queues.  If it
grows, the driver warns and continues with the existing queue resources.

Feedback would be appreciated on whether this detection is useful on its
own, or whether nvme-pci should instead support full live queue-depth
resizing together with the required blk-mq changes.

Guzebing (1):
  nvme-pci: detect I/O queue depth changes after reset

 drivers/nvme/host/pci.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

-- 
2.20.1

