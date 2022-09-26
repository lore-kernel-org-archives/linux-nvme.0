Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931FEC07E9D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 21:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SUEOAdgT2pBoqBUelsBz0+r1fiX2xzPqIn3G+cCYZbs=; b=1D3bPjtM1LT035CUcde10TLTbR
	33EA8wBOP0swv9quGRk93EAXDak7elHxK2FdrE/V27har56MzN306OYUP5WUrTz9zAb5WkFyHo/gg
	g8m4YMjJP+SHSn2h8pUxbIBeUQGJHFzBp0pH3fZYW1umFBaEY8cfqK/ePR/HMgKojhHi5Am8GAtYc
	mdNZp10qcRVNIKS3XuBqD1q8D+4Pp2kKYd4IhYEZRM4efpuxDrQqNEDZo48212ryHNX6OQl9qOKz3
	lQtjj76211pRKf/W+PWgwT9Ayc7S6q5S5XSRTYdSXafHAW4gjYMG/YcLxLbQtvvPg7pIScjouS4mU
	qb+zsJvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocvER-006rB6-8K; Mon, 26 Sep 2022 21:01:39 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocvEN-006r8u-Dd
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 21:01:36 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QKCWHp003309
	for <linux-nvme@lists.infradead.org>; Mon, 26 Sep 2022 14:01:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=SUEOAdgT2pBoqBUelsBz0+r1fiX2xzPqIn3G+cCYZbs=;
 b=EGCIfZhRVCeiYYf1aADRoyUf6ELzTpanw+QY51COITTRiOJmNPDOeCrGtJf12awNaTFb
 T48LC/KbTUC9iP6ieN+60mirq9mj6dA1tYX3yxrRt7oDQivxNTNQAJBT1d3zzLhoB1Tt
 FSRhDYQW/DCypPQsBrSRiYmfxORmSjNF9AI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsyn066bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 26 Sep 2022 14:01:30 -0700
Received: from twshared2996.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 14:01:20 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id DC2749115CD7; Mon, 26 Sep 2022 14:01:07 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-pci: report the actual number of tagset maps
Date: Mon, 26 Sep 2022 14:01:07 -0700
Message-ID: <20220926210107.1677422-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: S9Af152i4V4gC6TE7xfaoC-oY0Hiil7J
X-Proofpoint-ORIG-GUID: S9Af152i4V4gC6TE7xfaoC-oY0Hiil7J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_140135_612356_AAE24C58 
X-CRM114-Status: GOOD (  17.78  )
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

We've been reporting 2 maps regardless of whether the module parameter
asked for anything beyond the default queues. A consequence of this
means that blk-mq will reinitialize the all the hardware contexts and io
schedulers on every controller reset when the mapping is exactly the
same as before. This unnecessary overhead is adding several milliseconds
on a reset for environments that don't need it. Report the actual number
of mappings in use.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 70b1922c8953..59fa2490b646 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2526,9 +2526,11 @@ static void nvme_pci_alloc_tag_set(struct nvme_dev=
 *dev)
=20
 	set->ops =3D &nvme_mq_ops;
 	set->nr_hw_queues =3D dev->online_queues - 1;
-	set->nr_maps =3D 2; /* default + read */
+	set->nr_maps =3D 1;
+	if (dev->io_queues[HCTX_TYPE_READ])
+		set->nr_maps =3D 2;
 	if (dev->io_queues[HCTX_TYPE_POLL])
-		set->nr_maps++;
+		set->nr_maps =3D 3;
 	set->timeout =3D NVME_IO_TIMEOUT;
 	set->numa_node =3D dev->ctrl.numa_node;
 	set->queue_depth =3D min_t(unsigned, dev->q_depth, BLK_MQ_MAX_DEPTH) - =
1;
--=20
2.30.2


