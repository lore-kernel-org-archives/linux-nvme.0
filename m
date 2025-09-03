Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2F0CA1018
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 23:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kNigbhOw5104cTDxarUDCQp3n+YBPouop4Xjq6Ecb60=; b=DE+yGp8Ge+ZzNH/q3/3YHTaiie
	HvjqOPmSi5Vl/5ceceY4y8uNJ9jguKhTQkhSC689JwCfQ3bAp55X7hUfQBgROKbrp4imkWkmBUjGS
	JMDPfdunY6LlrdZyxXlI5kbCdwos2OURM3YIWnNAxv2Bul6XHIv1ABZX5WdiXdM3/yEcFRWnR8YvB
	2u/THLJp3nHCUMFjWbdUNZW5Uy+gdsIri2eoBe6mt41FBPHlHZ7dwEuOlu4d8MZIDu+SU4Cp53p8e
	ZH2Kh0wSeAhE0hEnoHOuv3O2Ltor/gvxjHgISAHMnijAVgSNePvB5M/PPt2NFnRmggB39kDahzTQm
	Pa4/orQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utwho-00000007tDQ-2DN6;
	Wed, 03 Sep 2025 23:15:56 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uttET-00000007Ss1-1P2g
	for linux-nvme@lists.infradead.org;
	Wed, 03 Sep 2025 19:33:26 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 583J83K93438984
	for <linux-nvme@lists.infradead.org>; Wed, 3 Sep 2025 12:33:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=kNigbhOw5104cTDxar
	UDCQp3n+YBPouop4Xjq6Ecb60=; b=KHcGxk8OquEGHQ4MbJAbYuwkNkoA1P6uvu
	ViIuHK0yLS2citSvNNtigRT7LS88/wCdul1afW1c7mhE5WGLuj4OU3JTvyXgQ5/B
	O2fFbcoO0OZG+yqfI7sr9W2Qbsr+LaUd9wmAFNbCoMFO+yR0q0Ka1ylN/cQsCVqZ
	gPQG/MqRkfNMBbC8UIhVNA8Epl0bzux9VwuwJKVNTlSEwAhMIitrJJXxbM4P3FfN
	HEoZOArzjHNIyajL7jJUqNkgmOT2VdkBEeIrvuLCE0jnUIW2taY4mEmffJriqpPg
	yAnC0mD2Rh5Xf+FSPoDy3Ul6SA7q+M8laDSftd61haNU/MTpY9FQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48xq6g2t0c-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 03 Sep 2025 12:33:24 -0700 (PDT)
Received: from twshared21625.15.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 3 Sep 2025 19:33:21 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C71E914CE620; Wed,  3 Sep 2025 12:33:17 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <martin.petersen@oracle.com>,
        <jgg@nvidia.com>, <leon@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/2] blk-mq-dma: p2p cleanups and integrity fixup
Date: Wed, 3 Sep 2025 12:33:15 -0700
Message-ID: <20250903193317.3185435-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iX0CeQgbl1_9TpSqyo_U7z-LkINLXId2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE5NiBTYWx0ZWRfX/yLe5CuspNtd
 nIA3CLbNSeiEagGLlqU/a5dgaEXaJN4pT7fqNIkCYiZkhkcrJX8l8Y50GONNgyMUcK9Q6ItdZYr
 HpPJPjf3dx5nVOYEWM2qznwYesTf9sCJ1EItUNJTzxGXkz2iviQq2XLuKwVrI2a+UOHeMJHblt2
 WWBzQCBsIm808RMFOFSrHp9xCiVcF77Y1vEt27009nd1K7D/LxzvcFI7S96ZBJceALhYifJSxrM
 oX8qdjqrqHNH+Umrc1+eznnZpqpcUT/foLpFQt1o7/o8wyV/fjxbE5UPtslLsrSgRIzLYHWWUpg
 GEI1VbgJuvnKO7fWV2PM2g63n2ulhYeJHgeIaFu+N27jG5p+KOfeT3gfAGtX+M=
X-Authority-Analysis: v=2.4 cv=E/HNpbdl c=1 sm=1 tr=0 ts=68b89804 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=DmgYukzzZP0S0QPcof4A:9
X-Proofpoint-GUID: iX0CeQgbl1_9TpSqyo_U7z-LkINLXId2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250903_123325_375569_DBCF1CEB 
X-CRM114-Status: UNSURE (   9.42  )
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

From: Keith Busch <kbusch@kernel.org>

This series moves the p2p dma tracking from the caller to the block
layer, and makes it possible to actually use p2p for metadata payloads.

v2 had a mistake when CONFIG_BLK_DEV_INTEGRITY was not enabled, and this
update fixes that.

Keith Busch (2):
  blk-integrity: enable p2p source and destination
  blk-mq-dma: bring back p2p request flags

 block/bio-integrity.c         | 21 +++++++++++++++++----
 block/blk-mq-dma.c            |  4 ++++
 drivers/nvme/host/pci.c       | 21 ++++-----------------
 include/linux/bio-integrity.h |  1 +
 include/linux/blk-integrity.h | 15 +++++++++++++++
 include/linux/blk-mq-dma.h    | 11 +++++++++--
 include/linux/blk_types.h     |  2 ++
 7 files changed, 52 insertions(+), 23 deletions(-)

--=20
2.47.3


