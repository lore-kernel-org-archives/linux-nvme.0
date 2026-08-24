Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFE7C5DF81
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 22:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7NL0avwy/b1oj7AKuA7zyx+lPprGdI4OlhtLVwe8rvw=; b=xbziJswiV7dxoH+XNXWADXppVy
	coC1IryjNfp5d5nMCrUHl9psTnEDCQI8nVBUAhel4j2q/3LT3yQb60/Z/TnwwyJ0+KsCAogglh7Zv
	FgGiO27wNLsJEFCC/u8zYQC3Vgm/zDTavMJq1H0yz3jTOBQBnVav9REsPsF/tljRWyXqvBsz/31Lb
	erqeAxptNS0LuEtESdE2AZLcGx6gIEJzN2yJovJ1sKRRHgVZIOpp8EK+uvl2FGY2cvRJWo/AANSmE
	DoABUBEjW6VDsNaJS45wGFIH2kQSmkiy5cKnW+URZk5P67FWj/Ym/xOkqDOyeIzvLrQnyJ3EiVw5d
	+8hHcibQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wydbB-0000000HTLx-43h4;
	Mon, 24 Aug 2026 22:57:01 +0000
Received: from mail-pf1-x463.google.com ([2607:f8b0:4864:20::463])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wydb9-0000000HTLa-2MGS
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 22:57:00 +0000
Received: by mail-pf1-x463.google.com with SMTP id d2e1a72fcca58-848643382fcso4221413b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2026 15:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787612218; x=1788217018; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7NL0avwy/b1oj7AKuA7zyx+lPprGdI4OlhtLVwe8rvw=;
        b=ZCnMFD5BFAKPe78dfLDd2ayPHlZZ52g6UU3gOL11LSx/56WdPf3/5qUGg40IjmHmjO
         5Ql1OmKxuePm39WiZtoQKK3Vd+xk8Kid/lG+ax4O+jLd3uI19dN9HI0gYSg8lvKD6p7/
         aSXcnGCfKxxDMymvNCee0miDkLAls2Nn3ytDPxFGo/8unkowcJXlNctM37DX0wUtQC1y
         3R0kk3nXXrtdIMph6KOFPzyWTe1vEtX3eD+nt00FdFmHdiUnP4cv5MtyZbckUjJa7MBg
         CEg2GC7og2dVSUXZVqGnNk0Vr+oketz0T417oa5y3TlWuRj3Mp1EzxRJ3qg4gmJN+iw6
         pHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787612218; x=1788217018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7NL0avwy/b1oj7AKuA7zyx+lPprGdI4OlhtLVwe8rvw=;
        b=dV0MpZSxit/hUKS6MD7ON1COlXNyb381uHNFYBZ8gRvS6LXksMYbOqIG7AS/1hpeWt
         oNxuRuanaVvQZ3+c5ek0TnnKvrInDnPY8GDNX9nYFjsgdYI0oFYUyewKep/LfqX8Dw7H
         myNgkLGoBNzuqYjDihPnPTbiGzlh4PXLw9mbZwB+/+Xyp+LH1FWxXGKwNzAs9C5OVHT+
         Z5lHbZ0dfJIMQc44Xd/pQ2cdnK4ihNjZUGXbkV/9KpFlOeTVm4FpK+CPjONBHt2B9Npj
         tIZ9wBhPvSgsDIS4adOLxDT1puvfqIdNXXDKjLS502sgS3PJf6Hiu7lv5odh6rlHYwGw
         OZ/w==
X-Gm-Message-State: AFuF++kNfYhGPxBknLab/tsAC9RbY+rvxo+Yco9z2HFd+Q6TrI8/SXoi
	lxcS2shJR6CAz4d7Nj5jFrZ28YakPI/lrATtB9NzNQAbIFyKGVdy8HvQja7uOtBeZwB53rLhPQX
	CZvfee6W2uvfri/UnItj23kQVY/gq+gMG0DCchuLH78tBNwMl/8tY
X-Gm-Gg: AR+sD11O4R+3aIE5JhWCUPZPVRDzUmg7TP24MgxdJgHLWmcpczbZ4fk5Q6zdBNQ4Orw
	QgnHjfSuNq7sI7uyBYvE2RQEmvNdc7tBSzZQVdalZeO91s+hBdaRw0zP+gPC6pKX5Fklz6uINSy
	Gt39NxJGQrRWRT9xTHPrzU97130EF8XJzM58kUYiBe2WjeFQuYLI+OWvmlsHil/fG8LoWt9FJ1e
	mVZgMYsg1hHvntvgHbqTCrZkvTaOKZmVICuguj0aa+0VdSKCkO9edSBMvkS8u/ZoWLUJW972gfi
	2eMDs8OgW5PzgxnfGdhC9aAxABzjjzcuUfBvPAnYYbeDJU75ApHfepIa684csEI5yZOHEUrh43n
	rPJKxnyHUD9aWibg=
X-Received: by 2002:a05:6a00:e17:b0:848:599f:26b with SMTP id d2e1a72fcca58-851fa02e749mr55039666b3a.14.1787612218302;
        Mon, 24 Aug 2026 15:56:58 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8521004aa47sm3970557b3a.0.2026.08.24.15.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:56:58 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (dev-sgogte.dev.purestorage.com [10.112.19.91])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id A1C2A402B2;
	Mon, 24 Aug 2026 16:56:57 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id 9CD0951D05; Mon, 24 Aug 2026 16:56:57 -0600 (MDT)
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
Subject: [PATCH v2 0/2] nvme-tcp: parallelize I/O queue connect
Date: Mon, 24 Aug 2026 16:56:46 -0600
Message-ID: <20260824225648.316962-1-sgogte@purestorage.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_155659_624728_A7CAE4DC 
X-CRM114-Status: GOOD (  10.61  )
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

Patch 1 is a preparatory refactor: it splits the queue-count
negotiation and TLS PSK checks into helpers so that the individual
steps can be called directly from nvme_tcp_configure_io_queues(). No
functional change.

Patch 2 has the async implementation: it fans the per-queue alloc and
start out over an async domain, serializes the per-cpu queue-count in
nvme_tcp_set_queue_io_cpu() that can now run concurrently, and
switches sock_create_kern() to init_net.

Testing on a 64-core host with 64 IO-queues shows nvme-tcp connection
time reduced from 61ms to 11ms.

---
v2:
  - Resending the entire series to fix missing numbering in the
    original patch 2 subject line. No functional code changes.
---

Surabhi Gogte (2):
  nvme-tcp: refactor I/O queue setup path
  nvme-tcp: parallelize I/O queue allocation and startup

 drivers/nvme/host/tcp.c | 139 +++++++++++++++++++++++++++-------------
 1 file changed, 93 insertions(+), 46 deletions(-)

-- 
2.55.0


