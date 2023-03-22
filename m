Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79CBC6FD20
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 00:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PqBhCyiwe+FbLj/O2dAwfE8VOdddZLf4CUTWFk8SpJw=; b=Fqpn30fsIQbWL+6GIbGwoQd0tT
	TiV8sKVWAT19PpyjMsEpUF1oUAnCR+BD9rMbk+3AM8hi09C+RYtbbuV0ZIxDOUaQlToJwwG+F+oM7
	Vr67IM5yMFvNWP4dfTetHafrWfRApC+ipH8OLXQRKnEktKjtMjxUIWgmIGBEqr7jNubyXRsyZX6lQ
	p3QzyZBRGLZ1qRkVOfbsyYVI0lJldybord8cO9uxRIQtKHYyuTZm7mqJqPe7VKew0ZYDCIuOK9kAi
	G3uFEcZxLQcfqIlQH4IWybiS8hnEP+0+HWgS2ayFksdYo7mRMveLQfvFPSQcHXO75rM24X4hXxCAp
	YOqIGUSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pemGt-00E9Rl-05;
	Wed, 22 Mar 2023 00:24:07 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pemGn-00E9QZ-0p
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 00:24:05 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M02RCR011146
	for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 17:23:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=PqBhCyiwe+FbLj/O2dAwfE8VOdddZLf4CUTWFk8SpJw=;
 b=cSPTdatEUayRsDxdc0tqEpABPsy8Ld5arFoUP/JSqM5MVd5jHB68tcqUIgwXTJWK9vFl
 drpAW4Jcsh9CW2ZsQXAx+ys5viLF1Q/12FQourXrEEfLPZ7c2Ofh3i1hOsSqcJgew+7u
 Uy6RVLGkVcMjxNCUobZPWJ3zL78EWFQLEu9w43gjkE5prawgJqLM9wdIJzk+//xn326A
 eIYRBgylzg9XcTe0vHDVUUFgNK4oDOLOjve7zQyoQmy+A88amv/2ENdYiYQ8Uyrg4fjj
 Rw/CH+dAjm0+x2E9yH65ccIjcVoeh0c8Wz7nPXsE3By5eDEcjVnFAF9ts0bzCFHVzhIR uQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pf07cyykc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 17:23:57 -0700
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Mar 2023 17:23:55 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id C32131419697D; Tue, 21 Mar 2023 17:23:51 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/3] nvme fabrics polling fixes
Date: Tue, 21 Mar 2023 17:23:47 -0700
Message-ID: <20230322002350.4038048-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Rl0PLj7DsIVzaZC-dKVgLc76dzLCeMDN
X-Proofpoint-GUID: Rl0PLj7DsIVzaZC-dKVgLc76dzLCeMDN
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_172401_523741_8F15591E 
X-CRM114-Status: GOOD (  14.70  )
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

I couldn't test the existing tcp or rdma options, so I had to make a
loop poll option. The last patch fixes the polling queues when used with
fabrics.

Note, this depends on patch I sent earlier today that I should have just
included in this series:

  https://lore.kernel.org/linux-block/20230321215001.2655451-1-kbusch@meta.=
com/T/#u

Keith Busch (3):
  nvme-fabrics: add queue setup helpers
  nvme: add polling options for loop target
  blk-mq: directly poll requests

 block/blk-mq.c              |  4 +-
 drivers/nvme/host/fabrics.c | 95 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |  5 ++
 drivers/nvme/host/rdma.c    | 81 ++-----------------------------
 drivers/nvme/host/tcp.c     | 92 ++---------------------------------
 drivers/nvme/target/loop.c  | 63 ++++++++++++++++++++++--
 6 files changed, 168 insertions(+), 172 deletions(-)

--=20
2.34.1


