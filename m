Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3A606A322
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oztWOslc;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=gqrcj7cL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3xBrDcZFd80Ul5kXzUkyKrsSjyIhpaV6/CILIoL496g=; b=oztWOslcZyDJP+IGCcyBeisx3m
	+ROutRrsVTkqrsW/WBeyQwsdVkzl+f8FGVj2bXHg0kKa7dC3i1aeIT1xrwqhxALxGxMs7vnA3VLQF
	3YvTfFjsZl5XAt8fHZQMJW1tOP/mNrpAY/4kj8NNo0LMUElR86sygwl6js5Skb4X8Lg7kTtYHKn0L
	mGO/ruI7eZXMt0DyF84r7MPBlINBjbr+yP14SCGc6zhYzeFSWNmTGQxEvwAJVUuTlvKBj3g12XTZ6
	qBs9Ej7KXQYChkIclm3bFbcJKVGj6QJFEgQalAby/rs0d38/ApXepxgSNjyF/QFpNY+ChHdn22O+O
	EK4D0A4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJbLN-0000000CgL6-3MGP;
	Wed, 21 Oct 2026 18:47:21 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJbLK-0000000CgJs-1Quu
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 18:47:19 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69LHrwUt1477582
	for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 11:47:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=3xBrDcZFd80Ul5kXzUkyKrsSjyIhpaV6/CILI
	oL496g=; b=gqrcj7cL3fIFUR5L5PuBYwrN2ZXXVOcA/3XAjPIatsD7GboMTeonR
	ZxAgI2VrRgymi0o7NA4d19ceaklLrfFcxkOpQVGeOaA+Aw/uEU2G/oyJBkQSXGqg
	w/P9/n5f4bHNs4969EkzPrODrmBvzJo9TtEd5NPG6vNLxGwwQ1YVL6vABU/ZfcjA
	XccTX2Vu/tv5i2QirR36vmxPDmk6shYZc7Wa6lofo/q+yU+Kcj4foLgKZB5hn48X
	QFT1dOJGRaFp+qSYkAQ0HqrbmPvAub7gynCpXeOXXT/p0auoCY7TSwT8Ray47heB
	obVhrnbgDhfJhf36P68DrMjYSAJ8reTcA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4hdw56xu11-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 11:47:16 -0700 (PDT)
Received: from twshared31846.02.snb1.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 21 Oct 2026 18:47:14 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9B4FF2DBB477D; Wed, 21 Oct 2026 11:46:59 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <axboe@kernel.dk>, <asml.silence@gmail.com>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] block: reject dma-bufs larger than 4GiB
Date: Wed, 21 Oct 2026 11:46:57 -0700
Message-ID: <20261021184658.644645-2-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261021184658.644645-1-kbusch@meta.com>
References: <20261021184658.644645-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3rV1tES5XrTUZst9eADmmaarCXbW6osk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3NCBTYWx0ZWRfX691Xs7BB3+2P
 MYjNyvbcSJmdkrDz0FMiX7eueGtQVxf8jin+5YgsRfezzSBeQSdkxVXh7uXbdc3Zx3sxSPkQ2Cd
 ozC/VPwpyJ26k8kK3Qw4/TibpoaCTFbFhB8rpDlvDqxsjRFcagmIg54zwvlAUMiqxE6B85iJRm2
 ITS+umeapbSi4KtJKzNrlYMxGnY6rVoVovrZJEdBsSV+Dn6QjgAqMfKNXWA3Q9T1Cf61SQXMr+l
 BJUA6pxhP1HsEIaE8PfTGqNoL0lY9NNeQ3718x2UdTwMDcRT9SmKU1Rcgc/QGxLaU6JrgejZuZP
 92MyMZa7tXjcpgkCFx4CMN3cFEAfY59SM1hIRcqb1QoKORgttjEryuJ4J2csvDNkljfKryI7oTN
 yCb1IXkUbS5CbKq9vIxmeQrKQ7vQ5/9lcUbE2e48f2Ukc3lB42x7KWPMpKTYMMxWNd7LTmg/y3b
 KguzwihRyyZaFpCZRmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3NCBTYWx0ZWRfX86ii2ufCdxKM
 uwhrSFDYzwB6QYOjHx4CVcRqAz7+1s69z1G7OOnReL5GuW+cvcN/YJu6dk1iYI+omWWPpKtowiC
 cO5eeUnw1EJJeqBSuvMZdohY6/H4mbY=
X-Authority-Analysis: v=2.4 cv=J+Q/fwnS c=1 sm=1 tr=0 ts=6ad908b4 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=VwQbUJbxAAAA:8 a=kMFwTpXalVGouGIobfMA:9
X-Proofpoint-ORIG-GUID: 3rV1tES5XrTUZst9eADmmaarCXbW6osk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_114718_537981_26E39A80 
X-CRM114-Status: GOOD (  12.40  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Busch <kbusch@kernel.org>

The dma-buf offset is set in the 32-bit bvec_iter bi_offset. Reject
buffers that can carry an offset that would wrap.

Fixes: 839231d19393 ("block: add dma-buf support for raw bdev")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c | 3 ++++
 1 file changed, 3 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 46cb86dd36d23..a974b423869eb 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -19,6 +19,7 @@
 #include <linux/iomap.h>
 #include <linux/module.h>
 #include <linux/io_uring/cmd.h>
+#include <linux/dma-buf-io.h>
 #include "blk.h"
=20
 static inline struct inode *bdev_file_inode(struct file *file)
@@ -1009,6 +1010,9 @@ static int blkdev_init_dma_buf_io_ctx(struct file *=
file,
=20
 	if (!(file->f_flags & O_DIRECT))
 		return -EINVAL;
+	if (ctx->dmabuf->size > UINT_MAX)
+		return -EINVAL;
 	if (!disk->fops->init_dma_buf_io_ctx)
 		return -EOPNOTSUPP;
 	if (bdev_has_integrity_csum(bdev))
--=20
2.52.0


