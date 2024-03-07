Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91D7C54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 17:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OpppoTIfiy5Z0s220a5sjniA5+/+HwLWPMJkVmLp0yU=; b=D09jktUkATRTP1Mj/p1FodGF/M
	pSXjM15GOZ43HI6daHU9Yxld/wXklcna3XVWWIzkEoh0SHLco5jyAray99l+kIowqxqIHLccFs9ER
	WlpmlkcnoigY0VLIgj1b3avAnCTiJqohHci3qx89UZ50Cmh6KwiiVoTVEBxvl25yCSKBK7NqGQqW7
	6dfmo0Ew4bL5xKbKwXwdhHmtjo84hAt/GrvSlwWRNf0QT4xzN+Js6BJ95Y6eiTyePx3QDskALHPMe
	9utdbk4HktY4u8TXI/F87+iSHRCrYeqXQqLqpMlxPB9dGkcOSVX6VVDukqb52ZUF83fZIKvzy6Hdk
	82JzXJXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riH6N-00000005b32-16fl;
	Thu, 07 Mar 2024 17:00:15 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riH6J-00000005b1z-3x5z
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 17:00:13 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427EAmrs023260
	for <linux-nvme@lists.infradead.org>; Thu, 7 Mar 2024 09:00:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=OpppoTIfiy5Z0s220a5sjniA5+/+HwLWPMJkVmLp0yU=;
 b=dxEsJQCldQmeuO7Nrf/OA7GOMEMDz1u8nU2TSqnjVi1k5vl8KoxCqVv7+qDsudhoMZos
 xd6aIICjsbFed0OflVryT/aN71RwkkG8Skstk3w1IJ2pRmJhn0DM2aMojPCyhmD63cbO
 NIObz/04AtITTK4iR9T7xki8odj5LMpi8XFzcLaoJiPzyjcMEadARIGffGINVajGj+6M
 IorUpMSryJ8XgOWc75R1TMoVvsDKe6bMFFtOHj16AoP2RliuuBDz62IlNJJBCeuAkMQk
 /0QJ2RfiG9GEVBuN/yKoeSdHck61L95oIFacYgo0vfhDmN56PqeSajsUhQABvv+y7srS Zw== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3wqf419rym-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 09:00:07 -0800
Received: from twshared9865.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 08:59:41 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 6A73F25E883BE; Thu,  7 Mar 2024 08:59:34 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Len
 Brown <lenb@kernel.org>
Subject: [PATCH] nvme: change shutdown timeout setting message
Date: Thu, 7 Mar 2024 08:59:33 -0800
Message-ID: <20240307165933.3718589-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ZtSgK_VFc8zz4F5On15p2iP0f5BHtnss
X-Proofpoint-ORIG-GUID: ZtSgK_VFc8zz4F5On15p2iP0f5BHtnss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_13,2024-03-06_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_090012_165360_78B8B34D 
X-CRM114-Status: GOOD (  15.13  )
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

User visible messages containing the word "timeout" can be alarming.
This one nvme is just reporting a potentially informative device
configuration, and everything is working as designed. Change the text to
report the less concerning "D3 entry latency", which is where this value
comes from anyway.

Reported-by: Len Brown <lenb@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2baf5786a92fe..0dcaf3973dc49 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3233,7 +3233,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctr=
l)
=20
 		if (ctrl->shutdown_timeout !=3D shutdown_timeout)
 			dev_info(ctrl->device,
-				 "Shutdown timeout set to %u seconds\n",
+				 "D3 entry latency set to %u seconds\n",
 				 ctrl->shutdown_timeout);
 	} else
 		ctrl->shutdown_timeout =3D shutdown_timeout;
--=20
2.34.1


