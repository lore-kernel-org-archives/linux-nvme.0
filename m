Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24D0E77183
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 20:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G34l3SOOFGkaA0U1xJroIsh8jMJs5H/F/yQIJ0OM8to=; b=3KuEYXFxdy6/3P7oMf/c63EU0F
	E9/zre94hjFJacKCQjR9A6Gwv1gOq6fouoTAn8OOemHn/yi+MaR+5P1yuu+ZReHBbfKHWChRI4l0F
	S3GZKMxOXsDT6pWps6UVTRgGlHR2dgCwZ87HhGPsU82sOhumFtFiFLcRG0yeCnD6RJiCjDdf+um8Y
	+eDzl9SE7qsfnZSIuOjTQL/eJ1hc84SuxJGPOzTZGPDqc9uyaKJsGj4LFyu/SqfqRPxmU7m+Lf1ys
	KPdVJ3kOBtO2IKd6OpykEDjyZUCOOXJPPrQT3PsPcVp6QCMc74KPDIMsUYGTqpQiYf1cjkIP3ofEX
	TOrCuDiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tL6dI-0000000Cdeq-0L4J;
	Tue, 10 Dec 2024 20:15:00 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tL6cz-0000000Cdaa-1vJX
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 20:14:42 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAFTacO002068
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 12:14:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=G34l3SOOFGkaA0U1xJroIsh8jMJs5H/F/yQIJ0OM8to=; b=XmwSIivf4vGA
	olF16CIKetK8FSQVvppwSrGJNVw3biCeVoLWYq9LEwHJMcDzZ/TRYmkv2xeSOFwE
	H50nzAxANd4T7UA2IbF4bXJzczo85YfLTZPcC9l4rakliqAqLU2mamxb7b0xZIPN
	vvEUZcXmNEmkcNDXpZYPJSOHeIgQyBJ7FmOf3a78xFXlIx2N4aRkvQSD+7KlJrkD
	KsvCSZhY5sEEO2/tkXEzHq/9R6Oa84SZt63tL/WlpIvxOTeIXgVW3b83hdeoYWde
	CyHT01G1QYqFt/LBDiZPkkbQ8yTKPqmCqDndWzjTQ//y9rrwuz51J0Ms9yInjXY2
	BeyCxrS2EA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43eraujddj-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 12:14:40 -0800 (PST)
Received: from twshared60378.16.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 10 Dec 2024 20:14:36 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 280A715D5C7B9; Tue, 10 Dec 2024 11:48:08 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Hannes Reinecke <hare@suse.de>,
        Nitesh Shetty
	<nj.shetty@samsung.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv13 01/11] fs: add a write stream field to the kiocb
Date: Tue, 10 Dec 2024 11:47:12 -0800
Message-ID: <20241210194722.1905732-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241210194722.1905732-1-kbusch@meta.com>
References: <20241210194722.1905732-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: jZsqW66TtIIvyieh-FI3o9XWupeYP57U
X-Proofpoint-ORIG-GUID: jZsqW66TtIIvyieh-FI3o9XWupeYP57U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_121441_616731_833C81FF 
X-CRM114-Status: UNSURE (   9.71  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
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


