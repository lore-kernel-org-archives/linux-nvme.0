Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB97DC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 20:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vn6X0NSrBCyy75YvHAJe+5TwuMczOHtCmNh2r6npjvQ=; b=HZ2SoUXGIiUFIGGNWMhoqkcUGf
	wsGj77QjRnCQcf5txYUjx0dK9C/IvWb881SZgYTI1Sw0pq19YhnJ9Sy1Sj+rAAO9vvFUWnqq86kmE
	FCSR3FNac7c6Z3g0edyy5lONcvsB0qbXeAaRNSLPf3s8+ZdPZzRi3vmoYivejmdShVQz5AOhDWqWJ
	7EsMlzkHH+x92DWoOEGEEONLLlKmYRbawZYv8o/En1BX1D4OGiOzKDaKEW550Xf6Z7XLnDRi7Dm7x
	VDpIiyBADYdPEwINXjralLQxFKPH4Ne9hOSh0WcvyM8qJRKdl5gdcvvzY68Xs4jJNTUf2/MtN5qLI
	zJDwGBYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzlEu-009kHW-Ku; Fri, 10 Jun 2022 20:28:16 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzlEp-009kER-WA
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 20:28:14 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AIDr5b028807
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:28:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Vn6X0NSrBCyy75YvHAJe+5TwuMczOHtCmNh2r6npjvQ=;
 b=gfl9ocP7iOrYLEoTx6jCtY6uLlCSynOE7FrOGM3DDr56hWN/DmmH3pRw8UOeb9ChewvV
 iXDA0J8osLKsjpn3n1PrDXwaQogujvDBR5IVyeEcM7Q40G59AaO2yu09hqM548BMj+gu
 4VHX+SwkzQIzYgaVhYWwqxxVUkQjshn0DLc= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmb208rpu-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:28:10 -0700
Received: from twshared10560.18.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 13:28:09 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id AA3AB4E9D69A; Fri, 10 Jun 2022 12:58:31 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCHv6 04/11] block: introduce bdev_dma_alignment helper
Date: Fri, 10 Jun 2022 12:58:23 -0700
Message-ID: <20220610195830.3574005-5-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610195830.3574005-1-kbusch@fb.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7rdZChG5aw7dyb3KxWQ7lHQ2l7r6c5lP
X-Proofpoint-ORIG-GUID: 7rdZChG5aw7dyb3KxWQ7lHQ2l7r6c5lP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_08,2022-06-09_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_132812_212279_05C9B60B 
X-CRM114-Status: GOOD (  14.29  )
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

Preparing for upcoming dma_alignment users that have a block_device, but
don't need the request_queue.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 608d577734c2..ab7e6aa17954 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1366,6 +1366,11 @@ static inline int queue_dma_alignment(const struct=
 request_queue *q)
 	return q ? q->dma_alignment : 511;
 }
=20
+static inline unsigned int bdev_dma_alignment(struct block_device *bdev)
+{
+	return queue_dma_alignment(bdev_get_queue(bdev));
+}
+
 static inline int blk_rq_aligned(struct request_queue *q, unsigned long =
addr,
 				 unsigned int len)
 {
--=20
2.30.2


