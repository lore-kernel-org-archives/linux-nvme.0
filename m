Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF893CDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bq/y6Ay8FGWy4bqRyOewKN5HseTbnUMhXdfqoo3Xi2w=; b=iD3JTes/4c+MXsj3kU+6gVrYmS
	nCSbW2RB+BHC4OBC6/tpoGBvNiUuj894Y/WIjiERo2lRo4yBeAin4+PZ+eqXZbieUBxsgjXtJEHPl
	ItdarlM4hbtT0gLL0mpEY+TYkjt7tW2ZDCGd6nWyQVtsPJPsIm6qnzLPbbrUmlUkTZtkigFqh830t
	cLItiWsGE+E8FsWRLXU5nZc+3JewN6qqbW90roZFhB758RVI/zsh1HOUDeBPJFB2gDkoA124WgaJE
	4AbiQJeI2cfV6SerxTYotGr6BvhxV49WruJlmtrVgeNR1U16KLIA0cBY/5V4eTct5GjaZSOLOtyzc
	yx4iNuxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qt8PX-00F24Q-0g;
	Wed, 18 Oct 2023 15:24:39 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qt8PT-00F22h-2G
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 15:24:36 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I4Xcjv026840
	for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 08:24:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=Bq/y6Ay8FGWy4bqRyOewKN5HseTbnUMhXdfqoo3Xi2w=;
 b=MCFJOt0EEzV+lPQ8Ulbj9Z8LbMbOLV52ixk6rERRXZw6QgtGrmtRjgjTu9T3lJHKLVDW
 sYIiAvdj9/y1Wb1vycn2WMgocggMowB+NS9Fhf2VG+UP0vRDIyAlx0CRqXhpaMGvN9ip
 JmwQ6fXuG9n33nswWv1F5sh4dMfQPnqK3dQk9U1AEl8doLRLfkUne3hhExRtFYtrUsCa
 xw24CNympXpuAiPm2UuI+lX2aD/7E6x7btQG3Cj127cVYMljBBRV5vaxdhGwCQkAcYwv
 QtU/dY5LUZl8I5yYehp9xJBVa76Vl0CYUkmcfMUQboeECnwtV3ji+1hEhodWjxuNv2z1 mQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ts86xq5bv-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 08:24:34 -0700
Received: from twshared5242.08.ash8.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 18 Oct 2023 08:24:32 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 7E7C2205F440D; Wed, 18 Oct 2023 08:24:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/4] iouring: remove IORING_URING_CMD_POLLED
Date: Wed, 18 Oct 2023 08:18:42 -0700
Message-ID: <20231018151843.3542335-4-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018151843.3542335-1-kbusch@meta.com>
References: <20231018151843.3542335-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: sciIl7U6Ozi4XpXKkfualptDylJA-frh
X-Proofpoint-ORIG-GUID: sciIl7U6Ozi4XpXKkfualptDylJA-frh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_13,2023-10-18_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_082435_852935_AA92D38B 
X-CRM114-Status: GOOD (  14.52  )
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

No more users of this flag.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/uapi/linux/io_uring.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.=
h
index 8e61f8b7c2ced..10e724370b612 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -249,10 +249,8 @@ enum io_uring_op {
  * sqe->uring_cmd_flags
  * IORING_URING_CMD_FIXED	use registered buffer; pass this flag
  *				along with setting sqe->buf_index.
- * IORING_URING_CMD_POLLED	driver use only
  */
 #define IORING_URING_CMD_FIXED	(1U << 0)
-#define IORING_URING_CMD_POLLED	(1U << 31)
=20
=20
 /*
--=20
2.34.1


