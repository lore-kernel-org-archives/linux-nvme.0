Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3866C77B71
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 19:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nWvxQ8Ox9CeKkhvc5Inedpz7NyvfDoB9E9p0Y0nxkTc=; b=wi3SQIqSTz0yy/sj9kBCvQ/7BE
	CUbXKZ0QW1DCD1FtKwP0jqzZySGFvvi1aGuDljNbD3QEfjAc0kZbAZehHJ90D6cMr2YzNdqxiPvAC
	+3gST/Y5TwBqci3xvz5iWj1kLSd8Nld2VOGxJvd5t4KNRJvXqVh5dfYNhT+ce+CMB7esvcnb0mGGJ
	QLDqrowC0wT+UjT3oWUidH/qm5PWhufzM4Z5CMj7u6qk1Bg/BuPydiJCX8vN8MHGo7bGbgaHJhnlv
	louutc7r6WSm2hkNkEVazc11bFjpkDsl+FSGc9Vd4lJG2i+pZVw/TNQb5qGh8NYJYZSrodV7ehdrB
	hOeUuT8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkra6-00AxKa-1c;
	Fri, 07 Apr 2023 19:17:06 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkra2-00AxIb-0c
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 19:17:03 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 337GiKdQ028055
	for <linux-nvme@lists.infradead.org>; Fri, 7 Apr 2023 12:16:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=nWvxQ8Ox9CeKkhvc5Inedpz7NyvfDoB9E9p0Y0nxkTc=;
 b=OMxWj1dCoTMrTXODRy05JY3uVMH1f8FGOsGMWChfKTeP674FLF3qMplOvrrVRf/YG5dD
 6jBrN/oJ5cQbWNI5XRvWDhWnwN2zk8jxOuWjsBbBwwpS20Bg21Hj0Ra+OYT9a1sHlVqo
 lmJ6jePSfIMh4SP6VGO3AUfO2ZXEH7ydjadfz6ILE6kYdFS1R5noL1pWuq6+3ibHZfAf
 vtjNtNyDvBEgcoLjD2HrbMevlVmY/nRTbEAQ8dFCMXzZuz72DzR/siQQXR8PdCNU1Ajw
 sw2nTsWiIirzB5mNe4DGkvthMnP9te+hX+TuUnGQsSF0Air7wkTa99/f8SP+3ajj+1tu aQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3pt9yhn2am-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 07 Apr 2023 12:16:58 -0700
Received: from twshared21760.39.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 7 Apr 2023 12:16:56 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 66855157B5F7D; Fri,  7 Apr 2023 12:16:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>
CC: <sagi@grimberg.me>, <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/5] nvme io_uring_cmd polling enhancements
Date: Fri, 7 Apr 2023 12:16:31 -0700
Message-ID: <20230407191636.2631046-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: daH8yPttgjV5cMaintzm1WOtiEUsGSFI
X-Proofpoint-ORIG-GUID: daH8yPttgjV5cMaintzm1WOtiEUsGSFI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_12,2023-04-06_03,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_121702_364568_0C439E4E 
X-CRM114-Status: GOOD (  13.38  )
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

Similar idea as the original v1, but even better.

This series originally aimed at improve polling without payloads, and
fix a potential bug when polling multipath. This ended up significantly
simplifying the nvme uring_cmd handling in the process.

In order to ensure we're polling the correct thing, we need the original
request, but we can't depend on the "cookie" since the field has
multi-purpose. But we have a free spot for the request in the driver's
"pdu", so the driver just needs to detangle the "bio" occupying the same
spot.

Keith Busch (5):
  block: add request polling helper
  nvme: simplify passthrough bio cleanup
  nvme: unify nvme request end_io
  nvme: use blk-mq polling for uring commands
  io_uring: remove uring_cmd cookie

 block/blk-mq.c                |  18 +++++
 drivers/nvme/host/ioctl.c     | 137 ++++++----------------------------
 drivers/nvme/host/multipath.c |   2 +-
 drivers/nvme/host/nvme.h      |   2 -
 include/linux/blk-mq.h        |   2 +
 include/linux/io_uring.h      |   8 +-
 io_uring/uring_cmd.c          |   1 -
 7 files changed, 47 insertions(+), 123 deletions(-)

--=20
2.34.1


