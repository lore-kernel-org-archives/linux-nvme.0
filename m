Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C588DEB2705
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 19:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IGiAPbbMfsQTX9jO1MQ7cuWDlu18F+vQHpCBLNpkJEQ=; b=jTcpmgu+kjN9aBmNzS+xStzn0y
	sGytZtvD8NIksqYjKYK06rGNpRhMRiMXEFrvygb2WHFgO9l6QMElI8Mt8yYuWJUppsRX0h/1EnJVf
	LZpy4xJSZjk3Z3yAgyuoCRha0z7Ci09VLYAWqQVtDYfWZo8w34Zgk6lspsMtYzPhaUAzCKyt7cdny
	DHzih2xFyiJasdnUz4uyne6bXeFJS/FXXM+s7YYyW2/iajla7XaEEHSVIoKFgclyrLbYqRSKkC8Y9
	B34cV1HHxrvWFwmSsghG85hADfRer5i8cNhiKecUyqR7dR3hR8bqU7hnGaTEaRdp+ibsUv4EVI/te
	1GiMBRxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vptY7-0000000HRfH-06Y4;
	Tue, 10 Feb 2026 19:37:27 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vptY4-0000000HRev-3jDT
	for linux-nvme@lists.infradead.org;
	Tue, 10 Feb 2026 19:37:26 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 61AHCoEU1722667
	for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 11:37:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=IGiAPbbMfsQTX9jO1MQ7cuWDlu18F+vQHpCBLNpkJEQ=; b=BLB9YuO3Xj/1
	JHQjHATbbP7uDHVkUCuys1LbQi0FFMWfOva9AFHKAKjg/6wXYvbTP9Ubj+5+1kZt
	auNqwW+C71OjgBj0/KY37+n7vMnwbPMPtmPmAGVHXLYhwKvEM3JtgT3oz/cObu6T
	W53QpvMf6ETYRwFyDDkqwwx8dGkjGhobwDGtHa7BYEaifmwWJDVOGm6LDYsek8BH
	khT5an6mO8DoPfVqZcjk6TMvKhnQtYE0idrBroruOmhJUT+KP1ZdLmOi5d+nL/7Y
	N2u7kmkHZzYbCRh7jVwi/h7+1WVJjtvMfRXpAVU69XNVMYU+Pr/xvaCvcGxwyd0i
	5hSfNUUWYg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4c84y0nds6-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 11:37:23 -0800 (PST)
Received: from twshared41309.15.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 10 Feb 2026 19:37:21 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 76A2F77808CD; Tue, 10 Feb 2026 11:37:16 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/3] nvme-pci: do not try to add queue maps at runtime
Date: Tue, 10 Feb 2026 11:37:15 -0800
Message-ID: <20260210193715.2543091-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210193715.2543091-1-kbusch@meta.com>
References: <20260210193715.2543091-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ylO5Vb3O-3voWmRdObyiSQ3T3csNH150
X-Proofpoint-GUID: ylO5Vb3O-3voWmRdObyiSQ3T3csNH150
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE2MyBTYWx0ZWRfXwKhly8lvxeGT
 HvrBp9t56p7b5/u0WiWy6CY3pU4iHh7DM1ecQyb2+IvOBJWuioCmEarsUl+NP8iTkF0W/44WQSB
 NwihQqVQPSwWnJ2NX3hdublTYGRQFETldRhYikg34XaVTvP6fjI2I6HUT1GsseXTg2W6fHLzRcN
 X0y9W+oBmd3J68Tsl3PJDyGQ/K4Ya6w/WzsxtER8k99Pd6v5LWT960Ez48rPEne5O+WohhBPFS+
 dA7XmLKnIQWB1o6e4Sgs8mlU0hN42qnKqFNz2Ts72SaWvtzexa0MUO6DJD4zRChzDaGrX4B2fy5
 RFmNHwUJmXFe915M+j55SAgb/I8tuO5JH4Mtu72Oj+LQlXdcdqLKxvEkFa+2G63A+El+Uuibpmw
 iIGYHJIZNn+GvBDkl5AL+JKUgirPJEC1oGM6eGp0q81Lfk0s423nlhZHkmy06ZsMFSY2ots+igK
 rBJ3mLO0hsvQETAKl4A==
X-Authority-Analysis: v=2.4 cv=ctqWUl4i c=1 sm=1 tr=0 ts=698b88f3 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=3PqamS-XlMzQfuyNXKMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_113725_177518_CCBFC4D9 
X-CRM114-Status: GOOD (  10.95  )
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

The block layer allocates the set's maps once. We can't add special
purpose queues at runtime if they weren't allocated at initialization
time.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f6d5c242fb689..43d214d31a8cf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2775,6 +2775,20 @@ static int nvme_setup_io_queues(struct nvme_dev *d=
ev)
 	dev->nr_write_queues =3D write_queues;
 	dev->nr_poll_queues =3D poll_queues;
=20
+	if (dev->ctrl.tagset) {
+		switch (dev->ctrl.tagset->nr_maps) {
+		case 1:
+			dev->nr_write_queues =3D 0;
+			dev->nr_poll_queues =3D 0;
+			break;
+		case 2:
+			dev->nr_poll_queues =3D 0;
+			break;
+		default:
+			break;
+		}
+	}
+
 	nr_io_queues =3D min(nvme_max_io_queues(dev),
 			   dev->nr_allocated_queues - 1);
 	result =3D nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
--=20
2.47.3


