Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FE6C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 31 May 2022 19:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=faOcvTN3625CjqrjeCHz0BkjmPq+BgAMSxF65DUtUoM=; b=meG4YghUuxw5IbxJxYkBEFHF+Q
	a2kMd/Rw27jfo9JnaQEzUJ3N/tolg3fZHTFoPUioh0eM4OsZeXV0Ztkp3gqGVlJ8Ee9nl09EjSVqF
	WRBH3hmoMAJRxNKa9Pi8vW07NRqUHv+EHyt3BXevII7/nV/MaxrctQgd+0A5iZp60EydvL0K5Tqz8
	SREgeddsPbXOYjSarPpmIEjBIZPvGMMZaVgSZiTQWbQ03L23YcINce/ITIirU3oeAHx6T5kwlYjA6
	zlt7Go2DYSR1YQK9T3zAHpxf7QMfoecv1ioCjMXTaMu+KV/TLRODZyGWuBsfB4xgSigmHutlxu6/7
	XVUw7MoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw7dv-00CLSl-Cx; Tue, 31 May 2022 19:35:03 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw7dr-00CLRp-7a
	for linux-nvme@lists.infradead.org; Tue, 31 May 2022 19:35:02 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24VFiHZ7013628
	for <linux-nvme@lists.infradead.org>; Tue, 31 May 2022 12:34:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=faOcvTN3625CjqrjeCHz0BkjmPq+BgAMSxF65DUtUoM=;
 b=o+Yz1J/lJmFWJxCQC08urvZ/4CXyrNLPg4C8MzGWsS4hd+uDw+QeKJMGdf1dOfzgGppI
 xScI39G1CWTtqDUOHCM4S/VdGvaHVzHFlrjhKjWUCMPBuZUTq28+NxbrkGn5N64Zcm1e
 XoEn/bn/CHj2IW6ZUN7dwH+rxrLj+ZN0Fnc= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3gbfdtg8ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 31 May 2022 12:34:58 -0700
Received: from twshared3353.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 31 May 2022 12:34:56 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 8D0D34924B0E; Tue, 31 May 2022 12:11:38 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCHv5 04/11] block: introduce bdev_dma_alignment helper
Date: Tue, 31 May 2022 12:11:30 -0700
Message-ID: <20220531191137.2291467-5-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220531191137.2291467-1-kbusch@fb.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EmTCdSndEwqExX3e2bKh31ehcWvUaOoy
X-Proofpoint-GUID: EmTCdSndEwqExX3e2bKh31ehcWvUaOoy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_07,2022-05-30_03,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220531_123459_431732_AE12947E 
X-CRM114-Status: GOOD (  14.64  )
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
index 5bdf2ac9142c..834b981ef01b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1365,6 +1365,11 @@ static inline int queue_dma_alignment(const struct=
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


