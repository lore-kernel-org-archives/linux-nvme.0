Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29804CCA476
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Oct 2025 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N+hNHTQnK6A8zF0BrmJylzXaFw/77S9mJ3a2IKnV200=; b=dbaUoob3eq1TUBb+s7zhWXIoBl
	xs7+DjIts/5Jq8eTQD+1IciYNx0Ikg/PTKg0bLbgpLN6l35myDLi7ZIo3jS6Xeu2VqkIRgyJK85Ib
	yYbKEM3IdMCSGr373LAAJ4jsXqS7yOfqSHrtjdJ+Saxtr09kgN8kQa0uB0J0YHg5sNKV0N2fPCz+r
	/inV85tj/LKia+NDbKmBou1oPHAoWRZYCdoE+k+Rs5kVTpu5aBbe1F09p69M/Vm8tM9w3pzV7iSKU
	XAJe9XPzRbCMf19FMYGt7DUvGG7ZIL8g67izepFOf7ulwJk3PrFGqUt0YhoSMg3yHH+BJAegWuXlg
	MQpzw8xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6BsM-00000002VwC-1u4i;
	Tue, 07 Oct 2025 17:53:26 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6BsJ-00000002VvJ-3HWw
	for linux-nvme@lists.infradead.org;
	Tue, 07 Oct 2025 17:53:25 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 597FSQcF3665456
	for <linux-nvme@lists.infradead.org>; Tue, 7 Oct 2025 10:53:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=N+hNHTQnK6A8zF0Brm
	JylzXaFw/77S9mJ3a2IKnV200=; b=Sw1e+Gl5jE2har88tADSYc6lnl6Q2g/kAH
	f8MUgavWrAHpX9XfJGNrz+qkwgpXG7GmHBfnONaCut4/QjdE/trtP9rJ0yw/0BEh
	JJ93Uar58W24vP+c9mDOrLFLJJbldOttsMneuxBBaB+roZ/5fsNDwCe72nVMd8FO
	aaGS0TEFqb6AOiZeiOMCr83qd5Zwl63fSDRKM3VG9QtwIqcyja4BkfWAex4ozS2f
	VdTaCrymUXH7jcT/1lWdoqMAe1pa1l0TYUubO/ib+F5dfwt5OXqRViMEuJc7Lgfu
	ILP9yHF4uRIsAjrXRjZFdDhOs7K25qXL9sNXTQGo/0vOal8MGwSA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49mwg6ms78-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 07 Oct 2025 10:53:23 -0700 (PDT)
Received: from twshared25257.02.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 7 Oct 2025 17:53:03 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 0AE26278193A; Tue,  7 Oct 2025 10:52:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 0/2] block+nvme: removing virtual boundary mask reliance
Date: Tue, 7 Oct 2025 10:52:43 -0700
Message-ID: <20251007175245.3898972-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: K79Dz72aMKfh4yIvpX1C0aLxDOmj5_6n
X-Proofpoint-ORIG-GUID: K79Dz72aMKfh4yIvpX1C0aLxDOmj5_6n
X-Authority-Analysis: v=2.4 cv=PsSergM3 c=1 sm=1 tr=0 ts=68e55393 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=D3lQaUfW4OkPWDUkTUkA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE0MSBTYWx0ZWRfX+cK2Y+9h1LZz
 R+wsBl54ToOqZcDXNom+9utS3WqLuscme1NSjHNGmCr0CdsZNhuQgeQG1z4vTrFHK3fc0Wr03+4
 z7Oq+Kr8JcrEME8Rrvh5IqxCO70LnGgpOPTuvBtQx4uMzyVRGe1EwMH7R1MFrmRYCiEFNhQr7Cd
 GsJkCzgmT1wD3hQjKDYN3HdhaGyJmSNEwHlB+WGD5ywQeTcu39ZaOuwH3WrS8PWBaHaDaiBBGrS
 +voEkJbuI2h7Jxh28ipAhM1Yas1kqppIV7Y7Gdc1mK+AWjs2aw6EE65CPH1K0xh21a80dI9dvn6
 qOwRGk6zwwig96GsXh7PWk+Dcp9GEUm1NB432gX6fGHBzdTOoUu8MMjDFrQzcSL0j4f4KnX10Aw
 WZXAy74hnSycqhCLfc9dpt7VpqC6MQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251007_105323_825307_4BD6A55C 
X-CRM114-Status: GOOD (  15.46  )
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

Previous version here:

  https://lore.kernel.org/linux-nvme/20250821204420.2267923-1-kbusch@meta=
.com/

The purpose is to allow optimization decisions to happen per IO, and
flexibility to utilize unaligned buffers for hardware that supports it.

The virtual boundary that NVMe uses provides specific guarantees about
the data alignment, but that might not be large enough for some CPU
architectures to take advantage of even if an applications uses aligned
data buffers that could use it.

At the same time, the virtual boundary prevents the driver from directly
using memory in ways the hardware may be capable of accessing. This
creates unnecessary needs on applications to double buffer their data
into a more restrictive virtually contiguous format.

This patch series provides an efficient way to track segment  boundary
gaps per-IO so that the optimizations can be decided per-IO. This
provides flexibility to use all hardware to their abilities beyond what
the virtual boundary mask can provide.

Note, abuse of this capability may result in worse performance compared
to the bounce buffer solutions. Sending a bunch of tiny vectors for one
IO incurs significant protocol overhead, so while this patch set allows
you to do that, I recommend that you don't. We can't enforce a minimum
size though because vectors may straddle pages with only a few words in
the first and/or last pages, which we do need to support.

Changes from v3:

 - More comments explaining what the new fields are for

 - A bit of refactoring to reuse the bvec gap code

 - Also count gaps for passthrough commands, as it's possible to send
   vectored IO through that interface too.

 - The nvme side has all the transport ops specify a callback to get the
   desired virtual boundary. PCI supports no boundary for SGL capable
   devices, while TCP and FC never needed it. RDMA and Apple continue to
   use current virtual boundary mask as it's not clear if its safe to
   remove it for those.

Keith Busch (2):
  block: accumulate memory segment gaps per bio
  nvme: remove virtual boundary for sgl capable devices

 block/bio.c                 |  1 +
 block/blk-map.c             |  3 +++
 block/blk-merge.c           | 39 ++++++++++++++++++++++++++++++++++---
 block/blk-mq-dma.c          |  3 +--
 block/blk-mq.c              | 10 ++++++++++
 block/blk.h                 |  9 +++++++--
 drivers/nvme/host/apple.c   |  1 +
 drivers/nvme/host/core.c    | 10 +++++-----
 drivers/nvme/host/fabrics.h |  6 ++++++
 drivers/nvme/host/fc.c      |  1 +
 drivers/nvme/host/nvme.h    |  7 +++++++
 drivers/nvme/host/pci.c     | 28 +++++++++++++++++++++++---
 drivers/nvme/host/rdma.c    |  1 +
 drivers/nvme/host/tcp.c     |  1 +
 drivers/nvme/target/loop.c  |  1 +
 include/linux/bio.h         |  2 ++
 include/linux/blk-mq.h      |  8 ++++++++
 include/linux/blk_types.h   | 12 ++++++++++++
 18 files changed, 128 insertions(+), 15 deletions(-)

--=20
2.47.3


