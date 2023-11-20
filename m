Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDF2C5AE5B
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 22:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jAGKyWeA8QTcQMk/vfy8VOIt2qAQYrVxiznwPWy89lU=; b=CrR9mEYkhefWIeTwCfrayclUA5
	rUsO3Od4Y40zop0S0k3FU+kBZ9n5wN53z02dXmHji720HC5Hw0pL73imqubhNRNKIELzvAmaTB4pO
	Agou3W6PSyh20FLiH/tiL1bnmgOWspg+ngLKH0oqGAelNDvxoXnpaspcTSZmz8cd+S1cbrsjmqrWW
	9ACNEBkJniX6EPBTD+IqUsSM9MoMHtE5K86nqJrmxEJgY/kUhVJ/lJYXHcLqRCGo7+g+Rro/A4/9t
	w1rRpr7iOtuYnTwJw0hz79IsSDczSo40d0CSKoAWrfO/uMKqqLPZuva+P2INm07XOqojxqBY4k+Vp
	tz0fduuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5CxG-00Ezbw-1I;
	Mon, 20 Nov 2023 22:41:22 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5CxA-00EzYE-11
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 22:41:17 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3AKMSZNG013393
	for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 14:41:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=jAGKyWeA8QTcQMk/vfy8VOIt2qAQYrVxiznwPWy89lU=;
 b=bqLjqQdMna77OQGoh74v+kipvppsSBqh35fz4GwW9q3Vf8Ub2mEy/qqSq5cMRVmGP39Y
 Ir7wMjSkuULc4BNoHlenQnXVaW3wz1MZGhMXlPPZeHS7F813JUC4Wg/gYpteZxcbI7Oo
 mY622oAwU6TeyK7sSR+OHmoKOhO/u7Z5Li3pcG6RdM+u+oA0YxfsU0sHKWlBIR5mc8d5
 ge2Kf06rPi+3wr9lMKzu/AfqKmCa39b1liibrwfXcnlDmGxEoXnbd37U49Lq7slYbDH9
 4GoaEg+Qy6dZ1ogTYhJeB3zvF87r8/9kMcEYDR68P0la53VM/kAUH0RuOQEfZLi7nUqR Ew== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ugbt1abug-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 14:41:15 -0800
Received: from twshared13322.02.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:41:02 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id E21F821F1B1B1; Mon, 20 Nov 2023 14:40:59 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 4/5] iouring: remove IORING_URING_CMD_POLLED
Date: Mon, 20 Nov 2023 14:40:57 -0800
Message-ID: <20231120224058.2750705-5-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120224058.2750705-1-kbusch@meta.com>
References: <20231120224058.2750705-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Pkc9aXXbNOPoIx2vxnj3bEM39N6NWNF5
X-Proofpoint-ORIG-GUID: Pkc9aXXbNOPoIx2vxnj3bEM39N6NWNF5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_144116_466172_04C70CB0 
X-CRM114-Status: GOOD (  13.40  )
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


