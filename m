Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1539CC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  4 May 2022 16:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kHCxhgTRVCZCY0wTUT+Ftx2hh6wYUIhaJ3MlJ1aPO9M=; b=lTQaF5eXixWFyO21mIe8jwbA0S
	bqIrmhtm0GKQ13pxhnT8qHOTAOC8y/DcGaAPoD71tDXyZTQgpUU6pHigQE/ZiJuhLZrRUwKBKniS5
	yTjkPVAA58Fvc5mNweRDkijHQVhc2F3rkf/uTyCfvqclImrICgksKLjM3tlNM7kYYyE2bPZA8OSd1
	aLSEWhqidLpXCXrBb7uWS3se6ge+c9ulU8hRCpxHjt0VhfM8nhT56r0OWpgCMQiNlLKKwrmQQd5sa
	cQXxc1g8bbCdJttDbSv16xP669nGR7atWsNr/W3xVax6Urgkc8845UUbvrC8uYcXglwPafJYCtOgB
	+SaSAIvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmHvj-00Bfno-I3; Wed, 04 May 2022 16:32:47 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmHvX-00BfjI-EF
 for linux-nvme@lists.infradead.org; Wed, 04 May 2022 16:32:36 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
 by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 244Dvfor001359
 for <linux-nvme@lists.infradead.org>; Wed, 4 May 2022 09:32:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kHCxhgTRVCZCY0wTUT+Ftx2hh6wYUIhaJ3MlJ1aPO9M=;
 b=J3TEJX35Je29viL31mJQhGfNtJyn1qfVpKIZTps77nTQiXaXZKLFg/K4WEkw5San/zgI
 Kx1dDJyedJG9+Vo2r3RW6BtZTLEIkqVdwMJmhLA9yTVRKjtBdj0gwt3nZghPwymca552
 rL4CRes0krZ/3yccBzQVOVYJXOxolC71m6Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by m0089730.ppops.net (PPS) with ESMTPS id 3fuf22c20r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Wed, 04 May 2022 09:32:34 -0700
Received: from twshared8508.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 4 May 2022 09:32:33 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
 id A22323939681; Wed,  4 May 2022 09:32:22 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@kernel.vger.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [RFC 1/4] block: export dma_alignment attribute
Date: Wed, 4 May 2022 09:32:04 -0700
Message-ID: <20220504163207.891761-2-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504163207.891761-1-kbusch@fb.com>
References: <20220504163207.891761-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 1Pd3Cf5XEPQ7L6HsuRTFfkUKmEvM95sv
X-Proofpoint-ORIG-GUID: 1Pd3Cf5XEPQ7L6HsuRTFfkUKmEvM95sv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_093235_640157_C1664AA6 
X-CRM114-Status: GOOD (  15.00  )
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

User space may want to know how to align their buffers to avoid
bouncing. Export the queue attribute.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 88bd41d4cb59..14607565d781 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -274,6 +274,11 @@ static ssize_t queue_virt_boundary_mask_show(struct =
request_queue *q, char *page
 	return queue_var_show(q->limits.virt_boundary_mask, page);
 }
=20
+static ssize_t queue_dma_alignment_show(struct request_queue *q, char *p=
age)
+{
+	return queue_var_show(queue_dma_alignment(q), page);
+}
+
 #define QUEUE_SYSFS_BIT_FNS(name, flag, neg)				\
 static ssize_t								\
 queue_##name##_show(struct request_queue *q, char *page)		\
@@ -606,6 +611,7 @@ QUEUE_RO_ENTRY(queue_dax, "dax");
 QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
 QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
 QUEUE_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
+QUEUE_RO_ENTRY(queue_dma_alignment, "dma_alignment");
=20
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 QUEUE_RW_ENTRY(blk_throtl_sample_time, "throttle_sample_time");
@@ -667,6 +673,7 @@ static struct attribute *queue_attrs[] =3D {
 	&blk_throtl_sample_time_entry.attr,
 #endif
 	&queue_virt_boundary_mask_entry.attr,
+	&queue_dma_alignment_entry.attr,
 	NULL,
 };
=20
--=20
2.30.2


