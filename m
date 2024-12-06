Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29212E77173
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 22:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qzN9V22hHNPCY40Lp/Ysqsn5kxkAoYivYUU6jILwvog=; b=XAq0vpSRJDpndkUKEf9HmPhYT+
	gyI0obJKFo+P1N59aJ6l41d7R/Th2fZnbF6T7CQPL1uerPDwO6EAidar7T9qyE//aepEVb9+zVQ9W
	nJUNY7wWGfj5IAWk0xYmS1oF6PoCjYww7s4P0Sqb8P74lRNvfs62C5MjA3DAGztY/SwkT81hXW8c7
	ZB6S1S0bBnaT5AUt8OiJBMxuVHcncOikiWZOArK5ppCVhuDIB6+3DQnqzjr8hK3YIOkhtQPOWTezp
	gK+AQcBlTWPPj0L826OofvP1gNPSJrvwgvktwpUd8xpZjIJCG54Rly1cIZ+Y1zbrvVvcueeNyGV2R
	6LAE9qjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJgpp-00000002v5M-0JWG;
	Fri, 06 Dec 2024 22:30:05 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJgpm-00000002v4Q-2P7H
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 22:30:03 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6LhFLU009968
	for <linux-nvme@lists.infradead.org>; Fri, 6 Dec 2024 14:30:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=qzN9V22hHNPCY40Lp/Ysqsn5kxkAoYivYUU6jILwvog=; b=EEJpDR2SJIhO
	h3HfDz3yAvaNWeiwepFTxsQ/izLsizdVvQBou3TVBfm7uIltSOmrMVkcbKd03Xr9
	3nRDBjSaFEQinCc32mHA1sXRQgE+5Z9aGPrz3D0Z68yJl9+yq01mDhDeqjhpf8qW
	LKF3WgFxFq6p36aI+5t8uihFCgWFbIZoi8mXlkmJ3wwBlh45Le9dFgr4xJpp5//S
	iULHXwklnd+hweRVgIqvirLkcXkyjMDxocnQ1ufSXXkeMlbVAVQQ0qOb4uFQMN8S
	MQX+DbrFHDECZVLCAaJN9Z/xi8Jj/T11GfrzPy9saPjlOex0VQvPHD+i7M2ouVGu
	tP0EoJN6Cg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43c2yy3cm9-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Dec 2024 14:30:01 -0800 (PST)
Received: from twshared55211.03.ash8.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Dec 2024 22:29:56 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 0003415B8CB6E; Fri,  6 Dec 2024 14:18:26 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv12 02/12] fs: add a write stream field to the kiocb
Date: Fri, 6 Dec 2024 14:17:51 -0800
Message-ID: <20241206221801.790690-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206221801.790690-1-kbusch@meta.com>
References: <20241206221801.790690-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XbPmeMWXQRb9zXBT5xZj_R714F0dq7aU
X-Proofpoint-GUID: XbPmeMWXQRb9zXBT5xZj_R714F0dq7aU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_143002_746392_FF8F60A3 
X-CRM114-Status: UNSURE (   9.62  )
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

From: Christoph Hellwig <hch@lst.de>

Prepare for io_uring passthrough of write streams. The write stream
field in the kiocb structure fits into an existing 2-byte hole, so its
size is not changed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2cc3d45da7b01..26940c451f319 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -373,6 +373,7 @@ struct kiocb {
 	void			*private;
 	int			ki_flags;
 	u16			ki_ioprio; /* See linux/ioprio.h */
+	u8			ki_write_stream;
 	union {
 		/*
 		 * Only used for async buffered reads, where it denotes the
--=20
2.43.5


