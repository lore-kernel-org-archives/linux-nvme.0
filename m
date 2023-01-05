Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C118C4708E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Jan 2023 23:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gxFRXl+lznUis4CHhzmNjuDnAEOqVSS2ZgFFiTAsaqs=; b=r6UvOjOdbBXRyDN3klCQZVec/J
	HduYG2xx7l6gsa9yiGq2FDZqdBmGtXkyrdfS+FIlQW0Seb8d/zRFurGq2NJ+e08Yv3DPto1QyGHvM
	MHMLje79MjctFRcRKFpoe/mEXCo1q2pGp5BW7L7CoJK7hf2dHwOMdwYbUSdM6W1LEvA2b1ThJ0nJv
	+vV22CTsHdcyqXi1slSWRL0Ai7UjbUPJJjOquvzrXqRqYL+oGKXZSQrd4QQIDLn9XFZSXB5iy1LqH
	ayWcnGu18YuHkK8psOnyCG/PcvgytSBq5k+qrVtB5cCMHOXDAQk8rgT57mI3iipIfH2LTjQST6yYY
	GB0v5wMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDZYc-00G5VI-BE; Thu, 05 Jan 2023 23:21:58 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDWr3-00EYLj-FO
	for linux-nvme@lists.infradead.org; Thu, 05 Jan 2023 20:28:52 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305HtFsA011951
	for <linux-nvme@lists.infradead.org>; Thu, 5 Jan 2023 12:28:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=gxFRXl+lznUis4CHhzmNjuDnAEOqVSS2ZgFFiTAsaqs=;
 b=cV1iVPlCaSO5ViW1Vl2Vjr/ekhnQau7dFnHHJk56ITZdTj3/6L9SJBFioyJtuiAkByyK
 gIx8Clmg3f/oCrjUAqX86aJbm2Co4D4BJhpPTsxki8RyVaLVCfHbUvD2g1nthH+8evqS
 gFNxpenTLcRHh+SWsBrWAiZwS/1Va/UHMTiiVrD4sLdlPkuwirXiAMTZtKfEsSDqu9qv
 F3m04kczn9DTKVZ/i5fJL23f/jOy14/q9T0fasBGXy96k2U81s9MAI7YFwH1vJvGrQxh
 tnr/YuiWLlR4evb7Fzgtrr0P4L4v0ocCIPF6CUjR/e9CvBQAfc3Myp3w6B7Bi0u/iEvG xg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mwnjyn8b5-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Jan 2023 12:28:44 -0800
Received: from twshared41876.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 5 Jan 2023 12:28:42 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 2B006E457D79; Thu,  5 Jan 2023 12:28:35 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/4] nvme patches for 6.3
Date: Thu, 5 Jan 2023 12:28:29 -0800
Message-ID: <20230105202833.3225645-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xSQLvFXU4I3cP5el_mDv9YzydfjWlfcb
X-Proofpoint-GUID: xSQLvFXU4I3cP5el_mDv9YzydfjWlfcb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_11,2023-01-05_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230105_122849_570315_9BAD33E4 
X-CRM114-Status: GOOD (  11.46  )
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

Just a collection of patches developed earlier that didn't make it in
time for the 6.2 merge.

Keith Busch (4):
  nvme-pci: remove SGL segment descriptors
  nvme-pci: use mapped entries for sgl decision
  nvme-pci: place descriptor addresses in iod
  nvme: always initialize known command effects

 drivers/nvme/host/core.c |  81 ++++++++++++++++---------------
 drivers/nvme/host/pci.c  | 100 ++++++++++-----------------------------
 2 files changed, 68 insertions(+), 113 deletions(-)

--=20
2.30.2


