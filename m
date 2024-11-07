Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3FFD5D687
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=URYLYIzLtYYdJf4U43/elwyM7l4XtqzYOOXzX6+Vt3k=; b=0bgTdHhCp32qhNmHzalBG3E6L9
	IZOiIM+3aQEOqkEyjN9mc/46gldHsEYIOaZUTgnx2I/riK9IF7KKB5rz7TEKqoE7uff+5iHJUofru
	vkieaptP5BxZijVSRp/2OE8sYQO8Hv+AEmj6YqZuNFxF9IMuUejBvXU3PlaqwqDnmQH0CLpQ8Mkka
	imBK9pvgRax1RL5IcQ6q5Bk1NMoUIFWbpEbiztNc7NYxpBIiMpBz1yI1A+QXGUn/bpLIcNbnpYxoC
	m9+48/Cv0O6pukJ2/PTHCQdfJ8u1WjSKjvpk4o8pvujijoOGhKnc41dtwZL7Oqh9b7EQtNU3nE1xY
	ceEZe3wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t98c7-00000008A9Y-3WMW;
	Thu, 07 Nov 2024 19:56:19 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98Ls-000000086Zh-2XXd
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 19:39:33 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImPr1018669
	for <linux-nvme@lists.infradead.org>; Thu, 7 Nov 2024 11:39:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=URYLYIzLtYYdJf4U43
	/elwyM7l4XtqzYOOXzX6+Vt3k=; b=ODjkuNkXgh46/03mbdv23HhrBGn0dkBcG/
	1HfHWsxOBBRaanMS75b4XaJsOlEmCPs6Loe+fKiHsIHL+fEVj1u8jjXaeZtlwkRV
	5AOkd1Ev2KKOeD8/b4I5GJa45H/5XuMRETenlIWh6UfaOlOxR/8s2jOMoPWq5q1x
	ajUucLlR/McNCe9PuxmUQuWFSJLevztO4mrZjfe0TRLn+m0akLCVABLNZFZwMIJ7
	mH3hct+qlteYkl53YMhlc171Kn9zzVQdvvQp8u2sUhWAKicFkfe8pdU+ha+b4VMv
	fNUrsbEJtSWj0BFVGUeC/XdcgzRjdjP6JQFhM5kmNNovcZyr/plA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42s12shjp8-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 11:39:32 -0800 (PST)
Received: from twshared23455.15.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 7 Nov 2024 19:39:05 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 27CC714DC39E4; Thu,  7 Nov 2024 11:38:54 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>, <kch@nvidia.com>,
        <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 00/13] nvme target 2.1 and independent identify ns
Date: Thu, 7 Nov 2024 11:38:35 -0800
Message-ID: <20241107193849.995554-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-GUID: cHPOAPCqc0sCHcq7BbqLU6t20zCq5sVH
X-Proofpoint-ORIG-GUID: cHPOAPCqc0sCHcq7BbqLU6t20zCq5sVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_113932_676775_6162E882 
X-CRM114-Status: GOOD (  10.30  )
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

Changes from v3:

  Defined the log structs for logs supported and features supported

  Used defines for those log attribute bits

  Fixed some patch ordering to avoid compiler error hazards part way
  through the last series.

  Removed unnecessary type-casts

  Fixed setting correct request completion status on one of the logs

  Used the correct and reviewed version of the host side rotational
  support

  Added the "no_vwc" patches from Guixin at the end since it is all in
  the same area of the code

  Added more comments explaining the relationship between the namespaces
  and their "endurance groups".

  Added reviews.

Guixin Liu (2):
  nvme: check ns's volatile write cache not present
  nvmet: report ns's vwc not present

Keith Busch (9):
  nvmet: implement id ns for nvm command set
  nvmet: implement active command set ns list
  nvmet: implement supported log pages
  nvmet: implement supported features log
  nvmet: implement crto property
  nvmet: declare 2.1 version compliance
  nvmet: implement endurance groups
  nvmet: implement rotational media information log
  nvmet: support for csi identify ns

Matias Bj=C3=B8rling (1):
  nvme: use command set independent id ns if available

Wang Yugui (1):
  nvme: add rotational support

 drivers/nvme/host/core.c          |  19 ++-
 drivers/nvme/host/nvme.h          |   1 +
 drivers/nvme/target/admin-cmd.c   | 257 +++++++++++++++++++++++++++++-
 drivers/nvme/target/fabrics-cmd.c |   3 +
 drivers/nvme/target/nvmet.h       |   2 +-
 include/linux/nvme.h              |  67 +++++++-
 6 files changed, 337 insertions(+), 12 deletions(-)

--=20
2.43.5


