Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F63CA0EC0
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Aug 2025 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bwM44L2rmZ/Bx0r6Muhs0y83imXKIEPNsSBmomJX38Y=; b=GDduBDHVYf/3imWoLRJlGbUVwt
	nJlhNVRBgQJC6KfG4PQrEZDg5SzXG9ZW1wVShsWqDWEjQ5lVStozehGBxlAXgtScWxKm+ORMC2bqD
	0ZheheGPDPjGGJX2GgFrvMN1/dnJO3MlbLpI1hdgboFnEC9SCEszaKDO3u4kwENfF5dsFPMdIy+mV
	vG4tYjZ4HTLgO/n0oWT3vZnFQjIkAmDgOoAtvWF55dyzsxZb3E+haYAaPcvXeIB/Oh6/9MaUf4Ihj
	GU0zgT2n61VluxTYuXiYu4L0KVkZnE1ZomC1fS8c3oR4rWqCHQRW0hYtwlmHFuSSFEkN88Q9XyZCk
	s2QLjfGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujfYg-0000000FV6m-0CLL;
	Wed, 06 Aug 2025 14:56:02 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujfUb-0000000FUQY-1sm0
	for linux-nvme@lists.infradead.org;
	Wed, 06 Aug 2025 14:51:51 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766c8P3017902
	for <linux-nvme@lists.infradead.org>; Wed, 6 Aug 2025 07:51:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=bwM44L2rmZ/Bx0r6Mu
	hs0y83imXKIEPNsSBmomJX38Y=; b=p/rbOyY8QnMl6Yzn7pNdSJy1BRcleSfD6M
	5XjCZlM5tevCB1RIAGE22X+/bk6uZk0xPaKp6oBh52fkPoCWtfzpFMNVji001BzC
	QzCnx9O1C0TCW7aP6S0j4pe4XMtWrA4w2IfMkQuOBEZbTRZhCitOeAPOPxhtIDL2
	yTCnhTn/gltdisn+NDpgPM1gqP4e3A7yhRwCozanFRX5Poxlzu0m/GmM06n1e2YK
	cSVr1jFnxmVdRlTMRIgEzG+k3KChWP3VYQkcDYl3gO5MJZe/UvaXJndfik2oG9bp
	DOKIjPcGR5A7hli2M0N/Lp0shjpl2cFd7T/RLZ90XzlfUzw+PjiA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48c1xsjnbn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 06 Aug 2025 07:51:47 -0700 (PDT)
Received: from twshared10560.01.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 6 Aug 2025 14:51:45 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id D6E9059F45B; Wed,  6 Aug 2025 07:51:37 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/2] block: replace reliance on virt boundary
Date: Wed, 6 Aug 2025 07:51:34 -0700
Message-ID: <20250806145136.3573196-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rvh6ARUXZ7hHWlN2v_87RT4V63hj7UFc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5MiBTYWx0ZWRfX9xxntl4h4mxa 38PRY5AF1VXH04rm4xzQ2xvcy81L0AEoYAfY5IXt/pksa1QEkyhEieUMTyMuaMZ+Ht1a1Tptu44 T3UOEgD3JrAFvYK/40X+Uv7pIF2t3MLteXcY892TcUwIKqNlK+cTPJ9rqLsWQ8yAck6HFRJdGNi
 tCOrX4OBVtfzB+1i3WTe6rmKcS9ZtVa5R3OfQhR9hIQpXX74y5KVDP2sNGzsJczsTIfcYZjv28R P56tScEm4W0kpQNf5HT6Ziwu5nk46zu6RNlCVyWob7OY5pugT3pB9H7JJ44XvSpHbcaYr5FDOm0 aeRpTxNjivIyQlEzfLZUsnnHIoEK9te7rxIaA5cOqlpSLGcLp6tEpc6RkBr1xno81KpykS2YlnM
 BET/IDa7dT5cvxfoHz9RgU1QAig4wkVLmnQpzlozQ6rq9F+LfgLoxdR3VTHMdPzd8Wkv6ck9
X-Authority-Analysis: v=2.4 cv=DPaP4zNb c=1 sm=1 tr=0 ts=68936c03 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=6zhmPM5ITRsy1UUQ_BkA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: rvh6ARUXZ7hHWlN2v_87RT4V63hj7UFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_075149_615211_E831203B 
X-CRM114-Status: UNSURE (   9.28  )
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

Changes from v1:

 - Replaced macro with inline function (Caleb)

 - Replaced unsafe tail bio vec access with safe access

 - For nvme, always set the max_segment_size limit rather than depend on
   it being set through the virt_boundary_mask usage.

Keith Busch (2):
  block: accumulate segment page gaps per bio
  nvme: remove virtual boundary for sgl capable devices

 block/bio.c               |  1 +
 block/blk-merge.c         | 32 +++++++++++++++++++++++++++++---
 block/blk-mq-dma.c        |  3 +--
 block/blk-mq.c            |  5 +++++
 drivers/nvme/host/core.c  | 15 ++++++++++-----
 drivers/nvme/host/pci.c   |  6 +++---
 include/linux/blk-mq.h    |  6 ++++++
 include/linux/blk_types.h |  2 ++
 8 files changed, 57 insertions(+), 13 deletions(-)

--=20
2.47.3


