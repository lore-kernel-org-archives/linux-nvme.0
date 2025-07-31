Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CF6C87FD6
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 15:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dHyeKnG3m5lYgQY6OD04dVFvOoVjGKnoxFkIYe4DwGU=; b=kV5sCvk2TCtKL6MiKf8iI+xBqd
	6GU3zkHj+xeDJmPwHNefZ5CO0mtaV6A8xuWCh2qE9m3xpNSUUmS2nHEST/FO2F6YtA0wU3XKjPzZD
	PwjfRk1lNeqxF9V66vbErKSfeOcUZiRw4w2L7Pb9gUDbNoBEvFIkjKi6efaHhIjtA62hjtsY9amaY
	zXZjNus4dzuTMBVOGwsKSrgqPbPbg+QKxjzS5nsK4rtUJ3IhzxQv5le3Ftpuv5tgkSQu8nCz+I0iz
	sFzF424pNjcPvw/7EylsS/pJ2CmIrlE+38ZiOIPYZiONx50kNreWuDKjHg8Nd76rHAjzmHjnhgAWX
	2/WiBHbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhV5z-00000003wix-1nw6;
	Thu, 31 Jul 2025 15:21:27 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhUqU-00000003vCZ-2CjV
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 15:05:27 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VE7REK012264
	for <linux-nvme@lists.infradead.org>; Thu, 31 Jul 2025 08:05:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=dHyeKnG3m5lYgQY6OD
	04dVFvOoVjGKnoxFkIYe4DwGU=; b=Lpic8GQOR4zVD6swRTSyk5gGUMFaRtWxvY
	Y4ZaEb2YWz0TrVb6RUAhn0OAnF0SCPvTtriiWoICOzN0bnfsfDd6svWSubd6XGP6
	qBiGmdwQ41f6gwy6xCgXpItNKfs3Ri/tkobAa5FKRuGvEBPWz8hm4plB28TsUXFe
	2o7QgSuQLfzzI7T0arN9bYIGtJsAFzePA02MHKUcjpCTyl0LErBOAWbGCqurD3OY
	AZYHRjyk/G13lDaAJKH54rMepl7QlcJ9xuOShprmSLKCbCUrUTsUS3HF0L68Dmc6
	OzRZsT6Pc3JzXVwYtOxTUpHtcAFohwVZ7tzwJTISTCw8Du7dgUUg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4883mj2k83-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 31 Jul 2025 08:05:25 -0700 (PDT)
Received: from twshared0973.10.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 31 Jul 2025 15:05:24 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id E4D0B231DA6; Thu, 31 Jul 2025 08:05:13 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 0/8] blk-mq: introduce blk_map_iter
Date: Thu, 31 Jul 2025 08:05:05 -0700
Message-ID: <20250731150513.220395-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=K/giHzWI c=1 sm=1 tr=0 ts=688b8635 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=0iyWCkrW18D_fWTiA50A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: zQnrL9gN1iNilsiPWvNFIw_nCr3M5aWl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMiBTYWx0ZWRfX7YyIr1gMmlHJ 9xU5e5PwM+Q4GDVWaiNSEmn4qlq/GGGscbtl0kj71Z3kL/Yk3j5+5ccKVXEqJP1NlydT5rrMC1t tQ7P6+Vhd2lhkUPJO6JKrEWf3vVV8FklGBkd7pqIrsRtBoej4SfBOrnVN2QR075En8SzNwmmXd5
 44RkSW4WDsglaeYdmyhAw2GK6JmPiyjS8LXtHMyyRMpKdORe4yYfagYBA2/mfNuJHgGkqQ6Ddtu lzcgiNr9d9a3E6yJarTh2ZsqziDt6Pma4LY4RA971R9EmXFybU0qYlcNqLrW2GPjZ4XQEbL9JGE zSuxp0GLljTNXUXujg6NT7RPLp/3jifI/pSTExOmthr+CDDjG9lXRxRRoEbIROKtXGrj2r8VikE
 M+2ZcEZnOBvinZtAUtzxkt4tdMTk+iZFuoyduubyOVVow/T2Ts9/GiA4hmVNpS/h1EKxdLja
X-Proofpoint-GUID: zQnrL9gN1iNilsiPWvNFIw_nCr3M5aWl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_080526_682821_64A79F85 
X-CRM114-Status: GOOD (  10.17  )
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

Previous version:

  https://lore.kernel.org/linux-nvme/20250729143442.2586575-1-kbusch@meta=
.com/

Changes since v3:

 - Fixed special vec handling

 - Fixed address check for dma_mapping_error

 - Fixed nvme leaks on dma iteration errror

 - Added an nvme prep patch to reduce code duplication when unmaping
   sgl's

 - On the last patch, I retained the previous MPTR setup for when a
   single integrity segment exists for non-user requests. A code comment
   in the data path claims that is more efficient than the DMA iterator.

Keith Busch (8):
  blk-mq-dma: introduce blk_map_iter
  blk-mq-dma: provide the bio_vec list being iterated
  blk-mq-dma: require unmap caller provide p2p map type
  blk-mq: remove REQ_P2PDMA flag
  blk-mq-dma: move common dma start code to a helper
  blk-mq-dma: add support for mapping integrity metadata
  nvme-pci: create common sgl unmapping helper
  nvme-pci: convert metadata mapping to dma iter

 block/bio.c                   |   2 +-
 block/blk-mq-dma.c            | 237 ++++++++++++++++++++--------------
 drivers/nvme/host/pci.c       | 190 +++++++++++++++------------
 include/linux/blk-integrity.h |  17 +++
 include/linux/blk-mq-dma.h    |  16 ++-
 include/linux/blk_types.h     |   1 -
 6 files changed, 279 insertions(+), 184 deletions(-)

--=20
2.47.3


