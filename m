Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1680CA0FF9
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 17:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PYvMXTL/L8wQ4W0lq8RrjJ8AdQQN2IpzN2ellUDipiI=; b=1kOtRWAwkDD9NZLLPU4ZxcLPZ3
	tUopFxAvTqbjjDjOv8tk1y6DYwJoJHXtxk0L0hKYEAE7t0+YpYEX44Y1V9gGK5nEKVJ6M7w8bHgUe
	Oi4EAnsoqg8QgbYyOAZlsOOOpzklKO4VsqNMzCaIhMVFukgeSNGep2hmpWTdsVabBujE3VePiAAEp
	LRlYrT1DSC6MERvGsX04HMmTjWlwTgmBZMsNX8InRJISoAY376PeKb+zf/5ASnGzhE8pYmpC5ub2U
	ZSeeHcYCT+OZuaMbFNZvlEK291u3l+Ve18S8VibqAzJzm+VLr9bfpLfhGNDIjYUsYqvhd2tAt0MFg
	ylSIUg5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us2rw-00000006We4-3Htr;
	Fri, 29 Aug 2025 17:26:32 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us00c-000000060Pz-0GUj
	for linux-nvme@lists.infradead.org;
	Fri, 29 Aug 2025 14:23:19 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57T8ipbL3730783
	for <linux-nvme@lists.infradead.org>; Fri, 29 Aug 2025 07:23:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=PYvMXTL/L8wQ4W0lq8
	RrjJ8AdQQN2IpzN2ellUDipiI=; b=SWw0kCzkbtdFY+9Qliofm3RHRg+Waqm2TB
	Rfd8s9zK9NGrixoYycr0K7SudfK66WhIGHJH6q5T7s/QIHTts2dBEFaPp3XeuV4j
	S2wm9XwONM2IbiA7AvMMVYsGuPmPxeTMuslKcWmkTKYgD2G0WBE8TuNIH7POBq7s
	ZyS3VhNM8EWo0y8miTy0N6u/FPoM+ttQtpzzO52Fl8TmFvU9J8WsknzK6ItEjXhE
	OP8xMMUVGwh+uyQM3K1Zuo8yURgBSP1f/Uz0ioxxjrBdeQ1BPCy6fsYJG3vIFEer
	khr5Icga89xLe5t3Tx7ivDsPKeFWgxEPwadurTLWLxJKRfU+xWsA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48u54easbk-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 29 Aug 2025 07:23:17 -0700 (PDT)
Received: from twshared21625.15.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 29 Aug 2025 14:23:15 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4D48811FADB5; Fri, 29 Aug 2025 07:23:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <martin.petersen@oracle.com>,
        <jgg@nvidia.com>, <leon@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/2] blk-mq-dma: p2p cleanups and integrity fixup
Date: Fri, 29 Aug 2025 07:23:05 -0700
Message-ID: <20250829142307.3769873-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rK6zNp-kJxXtakkdfhO8x6fCBSGD9k6d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDEyMSBTYWx0ZWRfX2hb5R4dxaGUS
 lVPXUi0WSxPln7nGU5d09fRwLlxk3NjyrRnx7EIDOE16LgAkTexqVPpu9Mc+audJQsPQ1kI39hW
 /P7ZbJ0+R12n1OtZJGuSFWY1G43mgrdMHzkQMK4U2Ivdxm7njJrTbbpLL/VhX/9aT1tIrrbd7hE
 a6t2VG4/gQrF/jUMj1Mqs0epWx900p6kK0otfyZDl9Ept9osjb9FH3nIYhS7aV/Z416Syibngk2
 dE/riHO+/oGsEmPTkfjc3UpPfOqTydIqN4cRirfbE4q40bcR0+Im9jpwq/P3EoqJehcRl94TJkv
 r/D7oszEQtUFo9buwxBk1kjBt4O26r11fE3RIWkG/MSKqrP5mI4o98VLtMO6fY=
X-Proofpoint-ORIG-GUID: rK6zNp-kJxXtakkdfhO8x6fCBSGD9k6d
X-Authority-Analysis: v=2.4 cv=MeJsu4/f c=1 sm=1 tr=0 ts=68b1b7d5 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=An7AkMqwXWfVQp4ObIYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_05,2025-08-28_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_072318_108209_47AE32C4 
X-CRM114-Status: GOOD (  10.19  )
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

After reviewing and discussing with Leon and Jason on some of the
proposed updates, it became clean that having the callers track p2p dma
usage doesn't scale, and we have a convenient way to track these things
in the existing structures anyway. So, thank goodness nvme is the only
client of this API at the moment while we work out the kinks.

While looking at it, I also noticed that integrity wouldn't attempt to
use p2p pages, which I think was simply an oversight.

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


