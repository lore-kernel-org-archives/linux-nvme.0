Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE552CE8E8C
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 15:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VRlPPfh+XcwQ28/Ct17KfA96VSQthuwgwuWfDsR56LM=; b=ZPs+vFQ8/6rphT6N1Lc8pIMHre
	b3Y3EzkgVtBHXQPI2VpzcZhW/rUsYWpLZ1EtFxz4kyoc2EUbol5Zj2It/hwFQzVpIyuPEhh9TZ7kX
	l+o1s/GmVijwkhzU9cKqPbbI7bLKnYntIhbuVm4hWv1I5Kfkyq2WFWrPcFYf1ewKroNf774rWGazz
	WAu0m82BQXharuqaY7Dg53pZlPj+PF5GEo5T2T/vSySNSBd9USbWQFubLoDTuRMxlH39EXivtrUGi
	a4pdtXlmiOI8X/BliM3x8253RRMUtD0lH+/R1A9ociU31sYz22cNRt/9YwJx068RopKUiN4PTSyn0
	qFiUbi1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3zzo-00000000y5L-0hhj;
	Thu, 24 Oct 2024 15:43:32 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3zk4-00000000uKb-3R47
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 15:27:19 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OFIVUa008850
	for <linux-nvme@lists.infradead.org>; Thu, 24 Oct 2024 08:27:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=VRlPPfh+XcwQ28/Ct1
	7KfA96VSQthuwgwuWfDsR56LM=; b=DOFOnsvdGUCnoSinyf21h99ilJcvJFjVzt
	wh1f/lj1dsEkW1oRQX9E3dlhbgZTmwOGBEizbE2tlIVrCSYgbVkMP8qravrc0Adr
	+JY8/o1g94RpQXCw6V2o8z0atAt+W4YNkfhzqkTNhKB1GsmjUsg3dMUWV2y+CCY8
	xGYHN8IwQN9DQEQe7WMq1fKG/AOXVRnDBMTI3RvWr91xVPCCw8uENwBwUpkGMwsT
	Bf+L6oFwZycrYj/VH6+ggg++ZTPREKEkkwWG6YCwNuF+gz/0HcwkbVOum0MNcgah
	92seVUTPpV1WUJ3qZlDz558qXjCPEvh8+9BYgO9NVv/FDgvbRjSw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42frrsr238-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 24 Oct 2024 08:27:13 -0700 (PDT)
Received: from twshared4570.02.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 24 Oct 2024 15:27:11 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 1D35B146D61D6; Thu, 24 Oct 2024 08:27:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <martin.petersen@oracle.com>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>, David Wei <dw@davidwei.uk>
Subject: [PATCHv2] nvme: module parameter to disable pi with offsets
Date: Thu, 24 Oct 2024 08:27:02 -0700
Message-ID: <20241024152702.2998364-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: R61EQAVOq0ssW-YnQ9gBUWCGbHCyzRXN
X-Proofpoint-ORIG-GUID: R61EQAVOq0ssW-YnQ9gBUWCGbHCyzRXN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_082717_399590_17D6CEC0 
X-CRM114-Status: GOOD (  13.15  )
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

A recent commit enables integrity checks for formats the previous kernel
versions registered with the "nop" integrity profile. This means
namespaces using that format become unreadable when upgrading the kernel
past that commit.

Introduce a module parameter to restore the "nop" integrity profile so
that storage can be readable once again. This could be a boot device, so
the setting needs to happen at module load time.

Fixes: 921e81db524d17 ("nvme: allow integrity when PI is not in first byt=
es")
Reported-by: David Wei <dw@davidwei.uk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Restrict the disabling only to the pi formats that have offsets

  Disable the pi_type in the head rather than just with blk-integrity

 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d0..2054535d7c2ef 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -91,6 +91,10 @@ module_param(apst_secondary_latency_tol_us, ulong, 064=
4);
 MODULE_PARM_DESC(apst_secondary_latency_tol_us,
 	"secondary APST latency tolerance in us");
=20
+static bool disable_pi =3D false;
+module_param(disable_pi, bool, 0444);
+MODULE_PARM_DESC(disable_pi, "disable protection information if it has a=
n offset");
+
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -1915,6 +1919,8 @@ static void nvme_configure_metadata(struct nvme_ctr=
l *ctrl,
 		head->pi_type =3D id->dps & NVME_NS_DPS_PI_MASK;
 	if (!(id->dps & NVME_NS_DPS_PI_FIRST))
 		info->pi_offset =3D head->ms - head->pi_size;
+	if (info->pi_offset && disable_pi)
+		head->pi_type =3D 0;
=20
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		/*
--=20
2.43.5


