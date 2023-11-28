Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FCAC46CA3
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 22:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gz46DOJDVW8DfYBnHMREJeF0H1ddTB4qso7LZwreJ6o=; b=dtVhhcqwAYYBrAxz1PosnRdVs2
	uMqeWdOI9qr4AHm+Bcgx+IwbuMRbfeLgcz4CjOqjATc0G/5nGwuVSiG/6t3n014genJ2sYWVtsdjf
	WFTR1WicbXuGuBqW7bgod0bw7zRntLxV9ggiN4ih90rI/4V25R+fMVGzTKW8dqdA4DPyIpPYJ7O5a
	NrkNFoMlOPuEesZ7EPlk5weG6yNZJ5GvEc/v/oB0GxFleiovKZg8ogWYVABnKr4aFoN7QYbAx2oyq
	sfAqm92iMCytCwpN9e4VIgYUjBJ9oHGaGfNr9vd+B/dXQ7vpbrjEAE1KZjpUisICgnz7vnCLoxF+T
	ICyGCqoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r86Ys-006UCQ-1b;
	Tue, 28 Nov 2023 22:28:10 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r86Yp-006UC2-2F
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 22:28:09 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASLBWe9004321
	for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 14:28:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=gz46DOJDVW8DfYBnHMREJeF0H1ddTB4qso7LZwreJ6o=;
 b=e78lj2AdR8+aKuGsH8bAe1QDYY7SRTJXK+h4dI89Y7FFvhMmWB2sT7O2It7xNVNTqbac
 uD0APeHUs/irvjVRBEMwSsTl01RNJM/AA4kJCce/M1OKAV+wuA1IH4weeQIqOUObED5j
 ujxB6RHOV5Jv4b+gkb97B+9q6Czv4t3UVNXQJEnHRUANa9XOVmMnxEFcL7j3ImAXMD2s
 E8iQOYp7ol1CeBdrn7EkZVOYknDf8K77WNfLiU2D5neyDE3gIoq29kaC1TXZriQib2gG
 uBvHP8Z4VX3k8B4SpoEJP1BeVWRx97arZtdc0km5VvF/7CFvmFJNtKCdNzRvc9Mf0LW5 wg== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3unjktb1xs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 14:28:05 -0800
Received: from twshared4634.37.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:28:04 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 62B152252F0CA; Tue, 28 Nov 2023 14:27:54 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, <ming.lei@redhat.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 3/4] iouring: remove IORING_URING_CMD_POLLED
Date: Tue, 28 Nov 2023 14:27:51 -0800
Message-ID: <20231128222752.1767344-4-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128222752.1767344-1-kbusch@meta.com>
References: <20231128222752.1767344-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: AwYNpFJSnDRSmPIne7UHbiCpqupMtj5F
X-Proofpoint-ORIG-GUID: AwYNpFJSnDRSmPIne7UHbiCpqupMtj5F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_24,2023-11-27_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_142807_995307_76D47FC9 
X-CRM114-Status: GOOD (  13.89  )
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/io_uring.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index aefb73eeeebff..fe23bf88f86fa 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -28,7 +28,6 @@ enum io_uring_cmd_flags {
=20
 /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
 #define IORING_URING_CMD_CANCELABLE	(1U << 30)
-#define IORING_URING_CMD_POLLED		(1U << 31)
=20
 struct io_uring_cmd {
 	struct file	*file;
--=20
2.34.1


