Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A36C197BF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 22:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tGmuivmMHmt4jFgZMic73AMs0v4Z1lHbqPxCC+pdAbM=; b=jCAl4kjwEOOO0L5NZH1suF2LKP
	+f1i1cqx7Ub8ZBSHDUn8SarcKzYVcflcaKQ73UWehsxhHuzTAYu5XtU8fLKC7MwLkaj4vwjgdPsf1
	yKb8XTxn/XzxlyQQfk9dIc4bLJ4LlUw3Mi1ZQIbwkQjS2AZcAVrb1chOW018Fq7nQwRew5lQTGWwJ
	xm3UEWxqwptIatULSEOccuBtSlLriS3Wfgf0kD4Cz9mvHmjq1V8sT5pzv+GaVPz0mfhmZT1Ej1R3C
	7/e2zQcoOl1Jnb+2zSkzKE0XDoVXusZYmPsoOeD0PE0yUfKWVj+GabGbif/H7bAJ6EPzmC6LokcTi
	jyI2gjGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnmXv-000000092v3-3K5o;
	Thu, 27 Feb 2025 22:39:59 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnmXn-000000092sW-1oel
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 22:39:59 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RMdhwn011846
	for <linux-nvme@lists.infradead.org>; Thu, 27 Feb 2025 14:39:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=tGmuivmMHmt4jFgZMi
	c73AMs0v4Z1lHbqPxCC+pdAbM=; b=ASpfbFoEdU/KznfrV6HeguHKDk/nVJvHz2
	3b4AltKvwffZWw7yH+2Uhpw7UJBfwRNK140pV4xalP5PHy+nTsg2jOhTXFJziny0
	By/mS5/VMYZrTvD77rdwwy/TbZs2QWthnBBiXKJIYrFzApN8t5BSquWSp+ueXRya
	AjqLZ73t4F/IrwZpYw0OlsS5npL8cS/weEuhp7EWuatInnkFBVU6lIK6plM50//Q
	OBUr5iLaJSErW0sINmbFUrLrBfOsu6TwhzEauXZ1X27LRR+D3muEoma1RDrLB6BJ
	JLNXCEKVwiagjYlVy7Am3TO7OjFZ7gKMoPfPyaBX5/F0n5mUMHcQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 452wtb9nw9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 27 Feb 2025 14:39:47 -0800 (PST)
Received: from twshared32179.32.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 27 Feb 2025 22:39:13 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 684D91888280A; Thu, 27 Feb 2025 14:39:17 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <ming.lei@redhat.com>, <axboe@kernel.dk>, <asml.silence@gmail.com>,
        <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-nvme@lists.infradead.org>, <csander@purestorage.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv8 0/6] ublk zero copy support
Date: Thu, 27 Feb 2025 14:39:10 -0800
Message-ID: <20250227223916.143006-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ytcdSQJDAWAotgq964Jb0Oe69yu3pecx
X-Proofpoint-ORIG-GUID: ytcdSQJDAWAotgq964Jb0Oe69yu3pecx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_143952_065025_953680A6 
X-CRM114-Status: GOOD (  10.83  )
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

This one completed liburing 'make runtests' successfully.

Changes from v7:

  Prep patch, mostly from Jens, that removes the "do_import" parameter
  from the generic rw prep.

  Added check for kernel buffers in rw's loop submit. This file
  operation requires __user pointers, so can't use it there (Pavel)

  Added a bool, is_kbuf, so that we don't use the existence of the
  "release" callback to distinguish user vs kernel buffers. And had user
  buffers define its own release function so that we can remove a branch
  check on free.

  The io node and imu caching is moved from the table to ring ctx. This
  is the simplest solution to situations where the node outlives the
  table it came from.

  Fixed missing (parens) logical error checking for ublk flags.

  Minor cleanups to reduce diff churn.

Keith Busch (5):
  io_uring/rw: move buffer_select outside generic prep
  io_uring/rw: move fixed buffer import to issue path
  io_uring: add support for kernel registered bvecs
  ublk: zc register/unregister bvec
  io_uring: cache nodes and mapped buffers

Xinyu Zhang (1):
  nvme: map uring_cmd data even if address is 0

 drivers/block/ublk_drv.c       |  59 ++++++++--
 drivers/nvme/host/ioctl.c      |   2 +-
 include/linux/io_uring/cmd.h   |   7 ++
 include/linux/io_uring_types.h |   2 +
 include/uapi/linux/ublk_cmd.h  |   4 +
 io_uring/filetable.c           |   2 +-
 io_uring/io_uring.c            |   5 +
 io_uring/opdef.c               |   4 +-
 io_uring/rsrc.c                | 189 +++++++++++++++++++++++++++++----
 io_uring/rsrc.h                |  13 ++-
 io_uring/rw.c                  |  85 ++++++++++-----
 io_uring/rw.h                  |   2 +
 12 files changed, 318 insertions(+), 56 deletions(-)

--=20
2.43.5


