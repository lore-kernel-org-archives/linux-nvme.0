Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874FFC7EE2E
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jun 2023 20:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1kZjeiWSwR0l0AHDID9w8iNkq6BqXuyHlq5IGLxTmXc=; b=O9R9QGhPecCM/J5X2jkynPCPJe
	Pib3l0hgrtr4WiTzZS+dDc+PxjKGw0YCzLz8CmVnmh1YBa5mHmDRdHc/9c0aNHVmbboNghVx1tVSb
	wROx1YTvxc1FSi5XQxZX0CK/VAfEHYNjidM6ZNR62jeYD+ZlqjxRggGTqJVQrIxVyCWO7+WiLpLcc
	3mYqSbseO5uH8u51K2hPiVUVNj7upXNpL0I5KjKf3V14CXDIR5VMk5hFG7/W1kAJNZ6zyGxVl+8uU
	yivOqhyHcmgxvs3mczRZnOFuZFNFRyOSZz2n7JjKq4iduYhIXbfyRj6qHgvKgl3UBb9OeojILGTnA
	KcPkCDcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7izR-00EDtc-2u;
	Fri, 09 Jun 2023 20:45:45 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7izO-00EDsQ-26
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jun 2023 20:45:43 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359KLZgx020324
	for <linux-nvme@lists.infradead.org>; Fri, 9 Jun 2023 13:45:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=1kZjeiWSwR0l0AHDID9w8iNkq6BqXuyHlq5IGLxTmXc=;
 b=ihq0nR7GzmXeIHgpFcbkUS/Wt0cGqkh8v7JpOh4Oud+ZAXc/WN5U6PoFch22p1hPOuLF
 PAikMmi5HjgondPR1YCGqltq3fkjugpi2+doa7uo/qU4kURdQsyJf0zU32OF3MZtWnQ8
 N/B5nGvI+8Dp6sUlToexLxriCPEE4PluHPu3N2uA4rmIo7u4J/xmsd82MvBTFlDMOS7y
 0JINKFKYARUOe6upHPA34q76ieQIYcHcykHekjB+JBGOqT82V0Oue4+6B6Pfw7avT8Tb
 OE57xzOsgDL7qfxAy+JEkBysaXONHBkvQASMNfQl8t7KlWKeb3LLNI5g815IACi8L1R1 uw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r4b1ug53k-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 09 Jun 2023 13:45:42 -0700
Received: from twshared5974.02.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 13:45:39 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id E007F19D4CC35; Fri,  9 Jun 2023 13:45:19 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <hch@lst.de>, <axboe@kernel.dk>
CC: <sagi@grimberg.me>, <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/2] enhanced nvme uring command polling
Date: Fri, 9 Jun 2023 13:45:15 -0700
Message-ID: <20230609204517.493889-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KTX6iKp69lOfCiJb2qKoSsZwEP_WgqOe
X-Proofpoint-GUID: KTX6iKp69lOfCiJb2qKoSsZwEP_WgqOe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_16,2023-06-09_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_134542_694390_DCC400CD 
X-CRM114-Status: GOOD (  12.02  )
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

Changes from previous version:

  Used the new hctx polling for the existing request polling use case.
  (Christoph)

  Open coded the qc/rq conversion functions since they're simple and
  have one caller each. (Christoph)

  Merged up to block/for-6.5/io_uring because (1) this series touches
  io_uring uapi, and (2) using this baseline prevents a future merge
  conflict.

Keith Busch (2):
  block: add request polling helper
  nvme: improved uring polling

 block/blk-mq.c                | 48 ++++++++++++++++--------
 drivers/nvme/host/ioctl.c     | 70 ++++++++++-------------------------
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      |  2 -
 include/linux/blk-mq.h        |  2 +
 include/uapi/linux/io_uring.h |  2 +
 6 files changed, 56 insertions(+), 70 deletions(-)

--=20
2.34.1


