Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0E1C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 22:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x1zlHo3Q0pSUeyHRtLLKebQeFEuwDiMtVQDgTgJdZPI=; b=MVAxICk/c1OaGRgE6dfc+cLx3D
	VxXq5BK1iE/MFWLHGuzv9zWPwzQNBwk2ETG+uE2brH47W2nk7IbJnmd+yiAlrCBJXXmz1zmheirEh
	o+spKIjmN+agNzXKJG/AvtcFpGeplRT++Fcqxusw5Ii6bneIftx0iKDJmhfpCbyLRfNrUGTuzjfek
	PaUDKXfyH1lNraGg1PiGz0QaVIB7/oSnzzlZGjF65GiPGPIzr8O9IU2ZVeUvLxInvuEUOmjbGSyTG
	/BfgPP7iFf6XvoMrAO1G/4OXQUd3jvIetJj+0D92JxhUfoqW4+XAQMn8G9ietWey/zTLRccN10/6D
	2Q/J4aBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r86Yw-006UDx-2s;
	Tue, 28 Nov 2023 22:28:14 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r86Yu-006UCo-0m
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 22:28:13 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASLBWeJ004321
	for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 14:28:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=x1zlHo3Q0pSUeyHRtLLKebQeFEuwDiMtVQDgTgJdZPI=;
 b=dG3HqqGRFHXTBBk8APEbObBCyu6vU73Q5nDlkLQx6qbOii2BB8NLtdrkPx6jHU/HUkQM
 EUnowuO0q6U0Ts75TU2c+HbFYwlmgBOPaw+e1k2d/3OXDJCTD4nM6L1vQDEgBkmsbyHC
 oDeRHnfPFriji3t4PyJzlM25VDjaetmAzQ6Xgy8DVscC7UpNEmyEYhCEMvxqERyrgskj
 PQkMNdZFJ/z7xW6GjzhB8fPsTdi5TFDdScoqYV9T2IzLROyJabEjC52eBw1AOagk35FV
 Y/1HzQWe6v552XUrq1fzRFAh8Prclt+KM/lUycE3DHOLADv5vUroJQnmL+y5IRPvIV3E eA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3unjktb1xs-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 14:28:11 -0800
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:28:05 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 3AE362252F0C0; Tue, 28 Nov 2023 14:27:53 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, <ming.lei@redhat.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 0/4] block integrity: directly map user space addresses
Date: Tue, 28 Nov 2023 14:27:48 -0800
Message-ID: <20231128222752.1767344-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: sv8hAl1GLSf7VU-9PxQ0v0w3_41u5j_Y
X-Proofpoint-ORIG-GUID: sv8hAl1GLSf7VU-9PxQ0v0w3_41u5j_Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_24,2023-11-27_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_142812_401542_BED84859 
X-CRM114-Status: GOOD (  11.97  )
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
directly. This patch series implements that, falling back to a kernel
bounce buffer if necessary.

v3->v4:

  Code organization suggestions (Jens, Christoph)

  Spelling and unnecessary punctionation (Anuj)

  Open code the final user page unpin (Ming)

  Eliminate another allocation for the bounce copy by moving the bvec
  into the bip rather than just a pointer to it (me)

Keith Busch (4):
  block: bio-integrity: directly map user buffers
  nvme: use bio_integrity_map_user
  iouring: remove IORING_URING_CMD_POLLED
  io_uring: remove uring_cmd cookie

 block/bio-integrity.c     | 203 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/ioctl.c | 197 ++++++------------------------------
 include/linux/bio.h       |   9 ++
 include/linux/io_uring.h  |   9 +-
 io_uring/uring_cmd.c      |   1 -
 5 files changed, 243 insertions(+), 176 deletions(-)

--=20
2.34.1


