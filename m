Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B80EEB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 15:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7xJEk34tEH6FIJEekYz02+Tfg3/XU/pkt7ulPk4t3DE=; b=E03VRKoCdNw40XFXf/gYvKbdBq
	0Fbt1V9AfIejQ+BZ20tkdjcRSbhnZH5cfP7ZQRWCL8vb1+imjq+ri08lyAu9rOSykofq0ee5XZeKz
	yOrdXM9St3mAabkX/2dtRi2VA+li5isO48VtCNxUVtGSu0get1YIWv2paUtAI7qr4PSWDfYF7bmXS
	JJbhkIhM8VQ5IgGhIoZ6YSo1F8T551pI58X9T2G6ryPDgjAf8g5cwIh8d9e1yeSbqt3emkCnfPnJR
	301dGFkoLwl7lA2DJI749uEkFfKyKZo9KcjfsVo2fnCT9NXWHVbN6x8XEqB7dm55uZcPCSWGL69/N
	bmSNPAHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJbmc-000Lxd-2e;
	Wed, 12 Jul 2023 15:29:38 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJbmZ-000Lx1-2q
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 15:29:37 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CD7rOU006144
	for <linux-nvme@lists.infradead.org>; Wed, 12 Jul 2023 08:29:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=7xJEk34tEH6FIJEekYz02+Tfg3/XU/pkt7ulPk4t3DE=;
 b=l3YjPy/VtFyLCtADZbNeMHVg3cc+JSBtuNbF/7l7nE0l4E57+ZLADXH8nEMzoUJIuOX2
 m1sK68R7lt+4L0FvtgJHcKaGfGGoQ3mGPz54efhOqXQkvIlWmpzBNpmt6odvbE+NbaI7
 0w9dYcr+bc6pUSLhMnq9msmOTgXssKcBEpRzBkPWrm/a/AWmrosXVtQMdR4INzPESsD5
 E/4tLaqcECAL/cm3vHbXKjFeS9l2ZeOJHDqtXpcouIkcJYAE9cKk/gInwYabSDplemUV
 LbkjKmL8hcOSPKs7aLLmarcRlMiSUv0LIR0PVQB6Oyl7GkES/vt/Mpe3f8gYsq3QYiE/ gQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rsg905e5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 12 Jul 2023 08:29:33 -0700
Received: from twshared6002.09.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Jul 2023 08:29:31 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 363AF1B7D8A77; Wed, 12 Jul 2023 08:26:44 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn
	<johannes.thumshirn@wdc.com>,
        Breno Leitao <leitao@debian.org>
Subject: [PATCHv2] nvme: warn only once for legacy uuid attribute
Date: Wed, 12 Jul 2023 08:26:39 -0700
Message-ID: <20230712152639.281545-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tRKrNFiLLspPTZtfA3qVolZ1rxNz0H5O
X-Proofpoint-ORIG-GUID: tRKrNFiLLspPTZtfA3qVolZ1rxNz0H5O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_11,2023-07-11_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_082936_041634_61F4641D 
X-CRM114-Status: GOOD (  16.80  )
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

Report the legacy fallback behavior for uuid attributes just once
instead of logging repeated warnings for the same condition every time
the attribute is read. The old behavior is too spamy on the kernel logs.

Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 45e91811f905c..212e1b05d2984 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -92,7 +92,7 @@ static ssize_t uuid_show(struct device *dev, struct dev=
ice_attribute *attr,
 	 * we have no UUID set
 	 */
 	if (uuid_is_null(&ids->uuid)) {
-		dev_warn_ratelimited(dev,
+		dev_warn_once(dev,
 			"No UUID available providing old NGUID\n");
 		return sysfs_emit(buf, "%pU\n", ids->nguid);
 	}
--=20
2.34.1


