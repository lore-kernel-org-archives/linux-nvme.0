Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CCCC87FCA
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=h16HvIigt2XSFX4l7hVzZW8JA4EzMQgFO0SgFpo9SY0=; b=bL9pB5545bk2VXbjRMh2qZsWlY
	zaWs5W7OXUCQfySkNGYzpMNLqLBuhnc0Qz4wqoa6JkFvsyW8666aIOLoeM6c6eK8rm+u5Xf/LIQQQ
	pmp7YVMHihsGmlawCAtuIAu9qsEBDDazI/aN19/Zqvny2dQHb2bVObjydfeDQpd3sChC8hzK9htTK
	fWPAg0CDBKHCy5HISYGWZ9KCA31NY+dfP6BLB58M1l/A84puhcmi0z+WM/ekwgFIRkRgigICw3M7o
	SZMj9LUIb251eBhlaq+5HC+n/Br3bdg/3PCf9rfbYGR9o5RT+fyQD3r72njYUz4ZVxGbGmO0BJy3n
	Vf5HTy8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uglPv-0000000GuXo-3LVp;
	Tue, 29 Jul 2025 14:34:59 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uglPr-0000000GuWO-32jY
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 14:34:57 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T6XuaP006367
	for <linux-nvme@lists.infradead.org>; Tue, 29 Jul 2025 07:34:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=h16HvIigt2XSFX4l7h
	VzZW8JA4EzMQgFO0SgFpo9SY0=; b=wFL37IQcxRWftNqPGSqyUlUtkpXsrVHtAW
	u91lHDpMYGoOBHZp7HQVe0j5gLMJ3OqDDZx2dNMrv1BVlXIZ/+oG2ElroocFAsG7
	Y/ptsH8OdS8ZbFWBE18jtNKLR7S35igxumMx3znFGmRLp0wiACC3DzDHFt+HSW17
	EWHIDMlvVJ+k2W3jwTXIqBSArBjXesCUUjRXVhh5dmmsRULaEd8HpIoS6g938TGd
	wQ4qmX68QVCBcG4nvu1eiLM9X/C8O6CeDZg5Pot8ZCuhyrvm01akAzKmvE9FER5b
	lcszCyhnf2HrADE7NqS9xvWU1NJSdh4Y1Kfo8oDJgRhd8krhI5kw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 486ne9kgej-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 29 Jul 2025 07:34:55 -0700 (PDT)
Received: from twshared63906.02.prn5.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 29 Jul 2025 14:34:52 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 715931CC41FB; Tue, 29 Jul 2025 07:34:45 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/7] blk dma iter for integrity metadata
Date: Tue, 29 Jul 2025 07:34:35 -0700
Message-ID: <20250729143442.2586575-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=JPs7s9Kb c=1 sm=1 tr=0 ts=6888dc0f cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=-7KjEqLkBevZipjnv6YA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExMiBTYWx0ZWRfXyOiEeP2oY6CT CiNTPT14c5wIGk5WGP5mFxHLI6QTeO3FCG/QBoI30oKPl8wTKaNlWiJY7OQsbvEI1uhssToexCX 8U3ErBi+Up1YCgjmucmJfEBwjRR9QuZf8H3Psjolian3gCYpt4eqcsaP5z1uBGEByocvnH4hgw6
 mYs6vlr83/X5csEiJW+XHBDqOgjMuj5FC5+Bv4+ifA367UNyf6S6lqO7KcjBqarKSApBtKvlKh3 P/4nQ2B26cPSpWbfWB2sbeh7N26vNlZcNGqjlyaSW/cCLfv9eCjywifdDL88Dsur0kbEVwdSYml bhuE+EpXez3UZjFAAm0NnJwbouLeswq04fPATEyZr/j3dqJqgozzlPnrOg/9RPXBCr84/escvz+
 HP588JvDcpeKKBIpYwlCMx+NNOI89VqwOQ3Ma6jIRVxm3KfuqCkEAW2wpf4eRMTiTQUBCI6G
X-Proofpoint-GUID: PS4xnMqusotOV5Sx5BBHq751QWpRZJ15
X-Proofpoint-ORIG-GUID: PS4xnMqusotOV5Sx5BBHq751QWpRZJ15
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_073455_765681_D97CDAB3 
X-CRM114-Status: UNSURE (   9.81  )
X-CRM114-Notice: Please train this message.
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

Previous version:

  https://lore.kernel.org/linux-nvme/20250720184040.2402790-1-kbusch@meta=
.com/

Changes from v2:

  - introduce the "blk_map_iter" type for the lower level's physical
    address mapping.

 - fixed missing "static inline" for stub functions

 - appened "is_" prefixes to bool types

 - nvme uses the MPTR method when it's a single entry, execpt for user
   commands, which will always use SGL when possible. This nicely
   unifies the setup and teardown for each, too.

Keith Busch (7):
  blk-mq: introduce blk_map_iter
  blk-mq-dma: provide the bio_vec list being iterated
  blk-mq-dma: require unmap caller provide p2p map type
  blk-mq: remove REQ_P2PDMA flag
  blk-mq-dma: move common dma start code to a helper
  blk-mq-dma: add support for mapping integrity metadata
  nvme: convert metadata mapping to dma iter

 block/bio.c                   |   2 +-
 block/blk-mq-dma.c            | 226 ++++++++++++++++++++--------------
 drivers/nvme/host/pci.c       | 181 +++++++++++++--------------
 include/linux/blk-integrity.h |  17 +++
 include/linux/blk-mq-dma.h    |  16 ++-
 include/linux/blk_types.h     |   1 -
 6 files changed, 253 insertions(+), 190 deletions(-)

--=20
2.47.3


