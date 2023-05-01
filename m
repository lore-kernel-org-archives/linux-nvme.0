Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED5EC77B73
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iLgVdrB4oVPgC3k99vUC3+6QNoVQOw4/ZWLtGA4hzNQ=; b=G7x7fhTM/zGkshTry1RKM46zgC
	Yz9AKlil/pfvKGpK+WyEaLHCNWGWHuTrtafpv8vbct13obVPU2XsW+vy1Pi3C0KAzoZEODpRm5zNn
	2X4jQhNaGklCgPuzjQfv6gL3N4+po2bUGZaFmaLpb8ZJkS2PfkWOgfjJyJtb2KqvXW9aLyVLRatyB
	5lJh5K/iuabAcfxL0MFHCOcj2BxQtYbJ4U0Pu2+3x+SgdnIeTq/2Ht7kTaPdSujkhAQGXOc+ROR8L
	0+UYShUx0TPU4BnGwQbIEIhIWx9QN0sfHXwM9xzy3eUPtdvrO2acAGpSHPld4fmxD7B/p1uyjnuO7
	DHEI0rYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptVWo-00GEU1-1P;
	Mon, 01 May 2023 15:33:26 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptVWm-00GET4-0w
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 15:33:25 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34146rPY005058
	for <linux-nvme@lists.infradead.org>; Mon, 1 May 2023 08:33:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=iLgVdrB4oVPgC3k99vUC3+6QNoVQOw4/ZWLtGA4hzNQ=;
 b=OG/ZId0D9ynI23fxnLyv4CjDrHEs3F1bg+hEa0G9+7X6yu9cETjK2Wwx9JhOGDzYdYLB
 TRAvI/RgehqYIXFSu0c3oiMJavvg/siNH8cCBwAUS4MubMHIPo1wTKp/A+9Ln6+sUAQ2
 Kkty4YTxeMrqL+JbxahHCflg3XlfOb1YSdZs8sfLA+V/oyG6B1wPjltvWfFbW0jbnl5w
 sKh+kuB58TFuH43P/KGguJzgT4WFHkSekKzzLn7N6W8sAP4E0/IqEmObW5BGWoZleS0s
 I/+cB/w80oJvXM9BR2I+HEFeYSk1Wm5T3Nky9m15IExQtflRZF7oOkcbLN3/khe0DnCH 2g== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q923huhs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 01 May 2023 08:33:21 -0700
Received: from twshared4006.05.ash7.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 08:33:20 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 3A1F01777ADBA; Mon,  1 May 2023 08:33:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <joshi.k@samsung.com>, <axboe@kernel.dk>, <hch@lst.de>,
        <xiaoguang.wang@linux.alibaba.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [RFC 0/3] nvme uring passthrough diet
Date: Mon, 1 May 2023 08:33:03 -0700
Message-ID: <20230501153306.537124-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DNsmhXSBNx9V60JXyJJ4pjwtcQVY8MC4
X-Proofpoint-ORIG-GUID: DNsmhXSBNx9V60JXyJJ4pjwtcQVY8MC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_08,2023-04-27_01,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_083324_497503_0A7F8170 
X-CRM114-Status: GOOD (  13.63  )
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

When you disable all the optional features in your kernel config and
request queue, it looks like the normal request dispatching is just as
fast as any attempts to bypass it. So let's do that instead of
reinventing everything.

This doesn't require additional queues or user setup. It continues to
work with multiple threads and processes, and relies on the well tested
queueing mechanisms that track timeouts, handle tag exhuastion, and sync
with controller state needed for reset control, hotplug events, and
other error handling.

Marked RFC right now because I haven't tested out multipath or teardown.

Keith Busch (3):
  nvme: skip block cgroups for passthrough commands
  nvme: fix cdev name leak
  nvme: create special request queue for cdev

 drivers/nvme/host/core.c  | 39 ++++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/ioctl.c |  6 +++---
 drivers/nvme/host/nvme.h  |  1 +
 include/linux/bio.h       |  7 ++++++-
 4 files changed, 44 insertions(+), 9 deletions(-)

--=20
2.34.1


