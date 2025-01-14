Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F462E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jan 2025 15:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sbVspRvH31NJw2zaJPLrPbTLMZJLdpt7JRBsUIzeJiI=; b=e+Pf4YEUO+QkPqJh/BjoXVhtnF
	5O8ZnxTwvieh3cIywCITGBjwtuoQoe1e8+sI9SAgOxWIPK4599it7J6MI8IMpIU3t7zx7BrFPhDU5
	CjMH106c40Lj15OJQv+ytA8WEGFFs+gW05mVVoG2C+490hzV5j9K+KgrBWCCJH8ourTZWrz6fh/7G
	8J58T3q35ZlUwbjO8OTQDR6sgviOoXmE7P3Zs80YnnaaG2KtXnoNUlT1P3PGrHB+ptn3FATGipQl8
	zQQcOsp19tvGZViwmOkxSQnq9BXNuW5as68Z6Db6T1t24NhPU5xj66GdxlM4EZZz6dTvTizCCQoIK
	j7lW4ODw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXiyc-00000008sgH-0o9M;
	Tue, 14 Jan 2025 15:37:10 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXiyZ-00000008sfj-2D1U
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jan 2025 15:37:08 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EFYuIE006351
	for <linux-nvme@lists.infradead.org>; Tue, 14 Jan 2025 07:37:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=sbVspRvH31NJw2zaJP
	LrPbTLMZJLdpt7JRBsUIzeJiI=; b=GMzhBEigDhOSNhVJxo8mMi8U22Vcz2k6z6
	AHTbb00zGpVkiEWHtdSbiN0oBbki3kqv7mVMDSh5PXbxhmboOoAvRdJbaQrcsbji
	wdzkxzL0VGnxkv/sHugZJ/nUE+pkjqTITfg5to7hdHoMondmwDvLqFBjO1p7BZPg
	Dri+x4tdtXujLfKuSXW14UsnfD5q0LsOOw4kzbRZCoZzUy0vEQHVTSbibfPPjYfx
	xmCwo/k43EYPWR0I9IyOuCBVhTrPAHPTeZD3YKZwLO/QvpoalCzMwbMLNnFanXrz
	2/laaVt8bajfNW0GT1izFpnpEN4NEb8GpDXm0Y1IPNmuNNsf1YKA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 445sgn8k35-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 14 Jan 2025 07:37:06 -0800 (PST)
Received: from twshared18153.09.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 14 Jan 2025 15:37:03 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id A890416E36A99; Tue, 14 Jan 2025 07:36:54 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <axboe@kernel.dk>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        kernel
 test robot <lkp@intel.com>,
        Guixin Liu <kanie@linux.alibaba.com>
Subject: [PATCH] nvmet: fix rw control endian access
Date: Tue, 14 Jan 2025 07:36:53 -0800
Message-ID: <20250114153653.797604-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: lA132biyQG9LuWE5cGVNM8EL9pvazmpd
X-Proofpoint-ORIG-GUID: lA132biyQG9LuWE5cGVNM8EL9pvazmpd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_073707_643615_15AC0E88 
X-CRM114-Status: GOOD (  10.57  )
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

Fixes: 3ec5c62cfcf060e ("nvmet: handle rw's limited retry flag")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501142128.WexgyMTv-lkp@i=
ntel.com/
Cc: Guixin Liu <kanie@linux.alibaba.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/io-cmd-bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c
index 6380b60fd4900..2b09b2c69857a 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -272,7 +272,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *r=
eq)
 		iter_flags =3D SG_MITER_FROM_SG;
 	}
=20
-	if (req->cmd->rw.control & NVME_RW_LR)
+	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_LR))
 		opf |=3D REQ_FAILFAST_DEV;
=20
 	if (is_pci_p2pdma_page(sg_page(req->sg)))
--=20
2.43.5


