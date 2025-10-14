Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC52CCD192
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Oct 2025 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wJt9aA7Z2dipsC5sJfbrKnoSz9SDb71SUd6mhYZTWdA=; b=W4nz4/u+L7CKWYjdxo+TIU4M3r
	7aKB5XUqAc7v2AqDiusCBrd6c5NSVwplaBtbi7BSScuGdcHe415WagDNZpXDgwfDQ/OZ7dw7W5vEv
	Ph22KLR0DoABsdpaApm+PCWarWPTD1BNg3xBn9VBF5oqlygzeE7wnWGRzZLw+3z4X8TsnWStu/Anx
	FQbXN9o+COE6nvCJE5PFXLzo6BTsoPdDh2TH5jN1WUp0LFjjfrd44TH9yXGue3vuyMS1zrHjCRByc
	FwYAbzQU0IW09wkq/XA9MvM/PZIiyXrAP1J4OuAIBZpk4VO/WkKBplcLthdD2P8uFBbEHGo9kDkZm
	1LLzHeQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8gat-0000000GjZj-2o2e;
	Tue, 14 Oct 2025 15:05:43 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8gak-0000000GjS6-28aD
	for linux-nvme@bombadil.infradead.org;
	Tue, 14 Oct 2025 15:05:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=wJt9aA7Z2dipsC5sJfbrKnoSz9SDb71SUd6mhYZTWdA=; b=Rcs6ZOp1j8RI11T3fSdr4AuVJU
	0JQDYBl9lDAMFgsZvr62nfE2eWLv8/AhcSF0c8vzSzXDdZTwBcwHA/EW7xtdWnj0Ck3UvoYBvMM8b
	5uS+ucuqst5BaQM0n3KlZtDLJpbTD9zXP7qz7AYdRRIfNpwbl4Qx+Wc4gVVcigzDnAkwWc61Psma6
	vnjC7ZXYWYIm0g1AwsCn+bzTctLY0P7pP52A+SC15Ngi9DQPRnGtpsFhqMz+XyOhHAYNRe4zgad14
	reF2KWYlmP/iVoz7j73Ihoxcq3QLJQS/+ZvEVTin2kntIvZU6kwijqjzLmx6xdD442GqD5xdpPxzc
	kzhrqrqQ==;
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8gaW-00000005GWC-1ofs
	for linux-nvme@lists.infradead.org;
	Tue, 14 Oct 2025 15:05:31 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59E6N8iC1449956
	for <linux-nvme@lists.infradead.org>; Tue, 14 Oct 2025 08:05:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=wJt9aA7Z2dipsC5sJf
	brKnoSz9SDb71SUd6mhYZTWdA=; b=gwgfMs1/uCImlrog1yCeRcx4aHJlxkAfoQ
	3IaJ8WemXj+cW+pl/DnISmc1zWGW2DMGyM/FyveZ/2s8wg/8hYfhpW1eidbh7Tie
	evcfWeXUzqwLenRk37BKtBflfYJ9w0Dy8wwt5Wio/Lm17QoKXATMOTYPe5J9tQzV
	4UZ0KE0BIhgEDhmyDl67eZzOBskP/7drO+LhmZ/Qk/8qbnjgY1nosBhrfvaWGQKU
	oEjI7fyevxDxbov53LE80LvfQ0QeTzrjdlbf31j/xDq6JkFR/KDr2AjOye+VsMvx
	l3ZWP7mOF7W7qGz9KHZrtZRIYU7iaA2gDYg5WupQ7b0uhqBwfmgQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49sh70ju3e-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 14 Oct 2025 08:05:15 -0700 (PDT)
Received: from twshared7571.34.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 14 Oct 2025 15:05:11 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4E7932B305DB; Tue, 14 Oct 2025 08:05:08 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 0/2] block, nvme: removing virtual boundary mask reliance
Date: Tue, 14 Oct 2025 08:04:54 -0700
Message-ID: <20251014150456.2219261-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sUK4iTJec-FX9uu1_jPIOo0Np4LCcajR
X-Authority-Analysis: v=2.4 cv=G9oR0tk5 c=1 sm=1 tr=0 ts=68ee66ab cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=D3lQaUfW4OkPWDUkTUkA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDExNCBTYWx0ZWRfX2hDOwP8/3cW2
 Ic6JKfkHxCVpPmDBaL2/1T1v3+gPfPeItOXJ5Ojnv1YYJM7UnBQ9lxC6VffPmuav+rd7qMbtxCv
 YdirPpgP1+xqKTJo/2aw1FVFevbDfOtUoNobrgMHHEFdHnxzoph6ckP34hnlzkPbCmt5dLO2Lmj
 JVfN4s3A/zI5PlXpbTP/alJylujnTwwnEXdd8R+f8TZTrfJDHXem36ZHfcG1HUZiHMEV7GS+VoT
 akIwVU5vdrCCirCoK1UtvHhHDFvitlLfcfuGkex1cGVPlVmaueegFAOLBCqErZTci3ngPfgZTmd
 stmjBKZ5QAiAq1AQiP0P2blFs45rKwVvREvKdqIS2sIMrYOde8KAfoGslwQmldHMIaciP7I1qXI
 k+RLYKHaIL94DgMXGCsGLuutmLdabw==
X-Proofpoint-GUID: sUK4iTJec-FX9uu1_jPIOo0Np4LCcajR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_160527_561884_8CF0BBAC 
X-CRM114-Status: GOOD (  15.24  )
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

  https://lore.kernel.org/linux-block/20251007175245.3898972-1-kbusch@met=
a.com/

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

This patch series provides an efficient way to track segment boundary
gaps per-IO so that the optimizations can be decided per-IO. This
provides flexibility to use all hardware to their abilities beyond what
the virtual boundary mask can provide.

Note, abuse of this capability may result in worse performance compared
to the bounce buffer solutions. Sending a bunch of tiny vectors for one
IO incurs significant protocol overhead, so while this patch set allows
you to do that, I recommend that you don't. We can't enforce a minimum
size though because vectors may straddle pages with only a few words in
the first and/or last pages, which we do need to support.

Changes from v4:

 * Keep the same lowest-set-bit representation in the request as the
   bio; provide a helper to turn it into a mask

 * Open-code the bvec gaps calculation since the helper is being removed

 * Additional code comments

 * Keeping the virt boundary unchanged for the loop target for now. Only
   pci, tcp, and fc are not reporting such a boundary.

Keith Busch (2):
  block: accumulate memory segment gaps per bio
  nvme: remove virtual boundary for sgl capable devices

 block/bio.c                 |  1 +
 block/blk-map.c             |  3 +++
 block/blk-merge.c           | 39 ++++++++++++++++++++++++++++++++++---
 block/blk-mq-dma.c          |  3 +--
 block/blk-mq.c              |  6 ++++++
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
 include/linux/blk-mq.h      | 16 +++++++++++++++
 include/linux/blk_types.h   | 12 ++++++++++++
 17 files changed, 125 insertions(+), 13 deletions(-)

--=20
2.47.3


