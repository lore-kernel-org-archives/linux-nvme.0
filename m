Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4D5CDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 15:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=p0WjUc4vLfEtzfqeD61Mot1OdvMxukOfxmo5qKfqmk8=; b=NvIaMV8On4euuaO+c0+2qVysFY
	BWuPOE1XVJtoQ0TVzvEhf38Xp5FHh+ey9KFD9+EDRmBYD0wmmkVPTw17jhU5/jXBkSceeb6DTMlp0
	E58otcZM7IxzFaim2zAYMMrFFB4PwAfkpk7E6BgzCR+hCZwEV5dL538+Ywi1kyvfKo67hvg+S3TZr
	8BHcFm+Dc5RRLitZ1TYY0gF9eTh69vcB3Ri+CQ9XK8E9+RbfpTiPuZtgO1Ix9jXREwkMpl8PM2T6z
	R1u9snTq+cCqrbkZmmAUObOdvbgBpH5vpd/6heVGsOqjgDCSKVCsEyc6kwKfCJZJ7Ze6kKKIe3Vwx
	rHsHp9Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qt8Oz-00F1zA-2F;
	Wed, 18 Oct 2023 15:24:05 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qt8Ov-00F1yG-2Z
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 15:24:04 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IB8i9B027339
	for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 08:23:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=p0WjUc4vLfEtzfqeD61Mot1OdvMxukOfxmo5qKfqmk8=;
 b=BDz+6X7qzfjvMbwTgF7VvLEHY6IuoJwlk3jUVBR6lK7lN9LrPXX/oIQvFbhIuJMop9v6
 QocOhwUF7tZ0bst+Y8YaJEDj998xjy03czkXpR0sdCLZsEvoMTHrru/5sU6jBZdWh1LP
 cGUkZbwzH64gnG2sEt2KcHV9JDThPD5JbH1eIA4RK/gaUXQhNy+VYwXS+2Qhe1f+rMZ7
 UolJXcGSzNAua9v3DBnrW/+cG5HdioSf97XEN/iC7WxijQ39OmP8LBXi1k1uR7BVT3ti
 g4TREMmiw/PEw7sI7Hx8r8EezuD3I448zF0M6eSyhYHruu7aDEDpINtmPDk1za19vuDI nw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tte7n9hy9-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 08:23:57 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 18 Oct 2023 08:23:56 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id C28C3205F3CE0; Wed, 18 Oct 2023 08:18:43 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/4] block integrity: direclty map user space addresses
Date: Wed, 18 Oct 2023 08:18:39 -0700
Message-ID: <20231018151843.3542335-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0IBX1uBvkVinmptujBK9Zl7T3xR2Tygo
X-Proofpoint-ORIG-GUID: 0IBX1uBvkVinmptujBK9Zl7T3xR2Tygo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_13,2023-10-18_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_082402_157319_3D605C80 
X-CRM114-Status: GOOD (  12.87  )
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

Handling passthrough metadata ("integrity") today introduces overhead
and complications that we can avoid if we just map user space addresses
directly. This patch series implements that.

Keith Busch (4):
  block: bio-integrity: add support for user buffers
  nvme: use bio_integrity_map_user
  iouring: remove IORING_URING_CMD_POLLED
  io_uring: remove uring_cmd cookie

 block/bio-integrity.c         |  67 +++++++++++++
 drivers/nvme/host/ioctl.c     | 174 ++++++----------------------------
 include/linux/bio.h           |   8 ++
 include/linux/io_uring.h      |   8 +-
 include/uapi/linux/io_uring.h |   2 -
 io_uring/uring_cmd.c          |   1 -
 6 files changed, 104 insertions(+), 156 deletions(-)

--=20
2.34.1


