Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52D3C00140
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Aug 2022 16:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8lReZdcTYdIHAj71wx1nJeUfZ+0HnE66EFO+CeaoAJE=; b=lS2am/HcmxJoxUheItUiZuS2mB
	Ybcv+nAEQUEJ6UVaoxmimlOuLO6XCALjfRZlSgXc9/73aRXPjUqdBGL0xdh6+hbIXOUUz46iweMjP
	lEV/G2KcngNU9f+0PFu8D2QcFcPomRkQaJfGiHkbzeGUgj1yB3QKYVs0H1iAZGQuSFzX6kXv6P7Kg
	O+oi21nWfU1Tn6zbfPDTu18evaYwOAzYo4W/xEAlovxFNpNI6EzuvNbhse6PZC3WLLv62QwLfckn6
	8XsmoTiyLt72zBdeRYoSQDgLuE38WwrFaOBoVFNz3GvpfNut5aACBi1Wi0AicjPUiFOcdVTz0ljmC
	JDZZdEwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK08i-00GiUJ-Q3; Fri, 05 Aug 2022 16:25:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK08V-00GiOU-HF
	for linux-nvme@bombadil.infradead.org; Fri, 05 Aug 2022 16:25:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=8lReZdcTYdIHAj71wx1nJeUfZ+0HnE66EFO+CeaoAJE=; b=nY4r2Okmy+gBkpG9pYqK1+nihr
	xctS5iqwsrdK01m9Comjr/KoVYAcdBBE07IM1Vcqbp4zbckQjA0PU1zBhvls2Rs7Oomm/S+tn0xZi
	rG1zAjMCpw1FwVhrl0JlrzWCkKWrseNMq0KVCRKyI7UT1936ppdAYWOt/Yr8JO0FFFs1ujFxWMM7r
	/sZqqGBxUu/k4m/9N5zeVilFYpgXYDOuwE2XjDh6TW7k1Rx4701d7JqjP81cujgSl+0aUy7V0BVd4
	lYtjgsKDqkydExM+5QAVGbzWH5MF6tIdXdPwW23Ywi6Xa752hyZlyql38ZRUFmaSAiwrEhU6scEr2
	YjOs5/oA==;
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK08P-003Igt-Qp
	for linux-nvme@lists.infradead.org; Fri, 05 Aug 2022 16:25:18 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275G6vZ6012323
	for <linux-nvme@lists.infradead.org>; Fri, 5 Aug 2022 09:24:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=8lReZdcTYdIHAj71wx1nJeUfZ+0HnE66EFO+CeaoAJE=;
 b=hDLVPUbDviGVwoUuIjajlQlposOw+/tuaTOc9OU/mScEWupEPQ3ufruiOeBG/ak0IMu2
 lhS7pEo/XM0v+FsjsHuoEdY55hUT/clKJEmL6XFkUXa3RVi+7uYGqsp1Hcax1jvKH4Db
 mi/TMLpelQNQkdC/mBW3Mn1IUwSTaJUQIgE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hs3cf1d6a-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 05 Aug 2022 09:24:53 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 09:24:50 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 3C17F70374FD; Fri,  5 Aug 2022 09:24:45 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Team <Kernel-team@fb.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/7] dma mapping optimisations
Date: Fri, 5 Aug 2022 09:24:37 -0700
Message-ID: <20220805162444.3985535-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4Q0quk8eUyxqSxXsELS1BlhswD2DdBnv
X-Proofpoint-GUID: 4Q0quk8eUyxqSxXsELS1BlhswD2DdBnv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_09,2022-08-05_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220805_172514_584888_67C2F7D0 
X-CRM114-Status: GOOD (  17.23  )
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

From: Keith Busch <kbusch@kernel.org>

Changes since v2:

  Fixed incorrect io_uring io_fixed_file index validit checksy: this shou=
ld
  have been validating the file_ptr (Ammar)

  Various micro-optimizations: move up dma in iov type checks, skip
  iov_iter_advance on async IO (Jens).

  NVMe driver cleanups splitting the fast and slow paths.

  NVMe driver prp list setup fixes when using the slow path.

Summary:

A user address undergoes various represenations for a typical read or
write command. Each consumes memory and CPU cycles. When the backing
storage is NVMe, the sequence looks something like the following:

  __user void *
  struct iov_iter
  struct pages[]
  struct bio_vec[]
  struct scatterlist[]
  __le64[]

Applications will often use the same buffer for many IO, so these
potentially costly per-IO transformations to reach the exact same
hardware descriptor can be skipped.

The io_uring interface already provides a way for users to register
buffers to get to 'struct bio_vec[]'. That still leaves the scatterlist
needed for the repeated dma_map_sg(), then transform to nvme's PRP list
format.

This series takes the registered buffers a step further. A block driver
can implement a new .dma_map() callback to reach the hardware's DMA
mapped address format, and return a cookie so a user can reference it
later for any given IO. When used, the block stack can skip significant
amounts of code, improving CPU utilization and IOPs.

The implementation is currently limited to mapping a registered buffer
to a single io_uring fixed file.

Keith Busch (7):
  blk-mq: add ops to dma map bvec
  file: add ops to dma map bvec
  iov_iter: introduce type for preregistered dma tags
  block: add dma tag bio type
  io_uring: introduce file slot release helper
  io_uring: add support for dma pre-mapping
  nvme-pci: implement dma_map support

 block/bdev.c                   |  20 +++
 block/bio.c                    |  24 ++-
 block/blk-merge.c              |  19 ++
 block/fops.c                   |  24 ++-
 drivers/nvme/host/pci.c        | 314 +++++++++++++++++++++++++++++++--
 fs/file.c                      |  15 ++
 include/linux/bio.h            |  22 ++-
 include/linux/blk-mq.h         |  24 +++
 include/linux/blk_types.h      |   6 +-
 include/linux/blkdev.h         |  16 ++
 include/linux/fs.h             |  20 +++
 include/linux/io_uring_types.h |   2 +
 include/linux/uio.h            |   9 +
 include/uapi/linux/io_uring.h  |  12 ++
 io_uring/filetable.c           |  34 ++--
 io_uring/filetable.h           |  10 +-
 io_uring/io_uring.c            | 139 +++++++++++++++
 io_uring/net.c                 |   2 +-
 io_uring/rsrc.c                |  27 +--
 io_uring/rsrc.h                |  10 +-
 io_uring/rw.c                  |   2 +-
 lib/iov_iter.c                 |  27 ++-
 22 files changed, 724 insertions(+), 54 deletions(-)

--=20
2.30.2


