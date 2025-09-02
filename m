Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7379CA1005
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 00:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9ORkJ89cvsyKX82bbvxxMnq3y50ntuJ0q7elgqyduRc=; b=F+L+e1kLpIZePkJ+Zv1p5e4BNq
	OrnxV3+5GZsSN1+xhu+wyD9m+TOW+Z4/pvAIUwygQR+kSKYsnU2DRw417sc1og1STfrATfdmXCwLC
	jv7MgTOwuJpukAaM3oNKM5I/q5tzkXAw1g5lYDtF4e2e6w2rL6WLwXZmZREXrUWWLzHx18maA5/iI
	TTefc3s91+n8k7Mu9XixpUWVyr/wVpKnu186/MSjujDgk1/7mrJrztarcPUM+y/veeTlJJzCPUoaA
	CZ9kdKMXbqIQtot6D5SPcc3E/ZC6ysdiP9r6CIKaI7MvAIYOfNfk4DcjzVSD/B+fApUf0bDXi6YPN
	fH6lIlEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utbcP-00000002pdJ-0GfS;
	Wed, 03 Sep 2025 00:44:57 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utXCH-00000001pUU-1QQT
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 20:01:42 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 582IJahj4048692
	for <linux-nvme@lists.infradead.org>; Tue, 2 Sep 2025 13:01:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=9ORkJ89cvsyKX82bbv
	xxMnq3y50ntuJ0q7elgqyduRc=; b=fFx7tsOI3VbZjmuPYy/AZYAp/FT2SkEvQ6
	1vJQ64wdltI4YWHKv9vGHQUnoi5F03r4T17z4RGDk6lF375NfLlhWkLcTWLbqY9d
	etmeWCEqaldYp3mNEKApAyaw2iKaQZFen/cwCny9SVhbodm9s+oPWI6jCAYgR5z/
	qzyOSvUNAVYeoQRaMFVAQECuV7Ex3PEnnDmeal/B40BTQH0qCnEN4sH9Foq9PmMn
	u7tjs2Qk/Qpa6SxdL7x2aWGraGNHXh3L5UbGs94mLqjAdX4FDztwTEByeqTpPP4X
	gYl96WUw7v3Jp6IeobRQ5ZFmBgnPurxd4ZpqUHEtGVfbov5b7ZVQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48x5rtgsn1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 02 Sep 2025 13:01:40 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 2 Sep 2025 20:01:37 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9A9B6142C455; Tue,  2 Sep 2025 13:01:22 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <martin.petersen@oracle.com>,
        <jgg@nvidia.com>, <leon@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/2] blk-mq-dma: p2p cleanups and integrity fixup
Date: Tue, 2 Sep 2025 13:01:19 -0700
Message-ID: <20250902200121.3665600-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: datn3FGWRDh8yx_WgFAiaAnEWCvXSiMG
X-Proofpoint-GUID: datn3FGWRDh8yx_WgFAiaAnEWCvXSiMG
X-Authority-Analysis: v=2.4 cv=duXbC0g4 c=1 sm=1 tr=0 ts=68b74d24 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=f_Omk_ncVSdtrnns-hoA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDE5OCBTYWx0ZWRfX8MgQ83T7eQWe
 3Spax3dKWNmaDHlQbeONMFaCd2QcbC/RAJ+Mf4Jgu1wc1D1L/ECYvArMtuVGCuYjlbS2jgVtpxY
 XV1SfTL6iWMR8DVApAIWxW2INpXnWHLwT3X66FOUIZbO/PfyzeNEc03OC2EpWDic3D9Iof0shgU
 kaRXxLSkHCTmal6omTlyVoGTNeWzQIAjlU+sp7HcGxW3uXyLWMZt05KiggmTFYylkOG0rmrNtFj
 thZ6XFm4GTVj94ySQASzsLgLhd8pTOBxy0h4dOzSkLER1p61Qvl79ppdizMuXWOtMKFLjvqz87J
 2RR5rGwJOTinpy+xKpTuWsQ6uRIK3r75xHQ7ADhwV+CgyH1P915cr1C5jR+AhY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_130141_493681_2178714C 
X-CRM114-Status: GOOD (  10.00  )
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

v1:

  https://lore.kernel.org/linux-nvme/20250829142307.3769873-1-kbusch@meta=
.com/

Changes:

  Folded in a fixed to patch 1 that was inadvertently included in patch 2=
.

  Added review.

Keith Busch (2):
  blk-integrity: enable p2p source and destination
  blk-mq-dma: bring back p2p request flags

 block/bio-integrity.c         | 21 +++++++++++++++++----
 block/blk-mq-dma.c            |  4 ++++
 drivers/nvme/host/pci.c       | 21 ++++-----------------
 include/linux/bio-integrity.h |  1 +
 include/linux/blk-integrity.h | 14 ++++++++++++++
 include/linux/blk-mq-dma.h    | 11 +++++++++--
 include/linux/blk_types.h     |  2 ++
 7 files changed, 51 insertions(+), 23 deletions(-)

--=20
2.47.3


