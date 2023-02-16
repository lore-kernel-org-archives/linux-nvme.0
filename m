Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349E0C61DA4
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Feb 2023 16:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GK4CWb3Es7tFPwx1wffTSvX6+ySEGLJXNL/nuS9qcQo=; b=xIZHJlx0IhzlNZLgGNWc6MY0ka
	fHzXMNGaTgpFCgolh/Vj7X/97zmoXuJ5r4M1LBF9pTph0z46EvctBafWMtM8MvYzaMnhW5oD773k5
	NDU67B1o7+q0Mr9V49L6vufMi3c842btVlZ1KkdsSf+oJT+Yg08iKPZnCIa0zkzJVbdujxz0IFXhH
	FmixGaXWX/6Z7494k0PKPU8bl1qanGQ4tewGIntfu+jQEWVFq8yaIUiyFZdnBRpjCi3goMhmbftzR
	LUY+VLpnF0KhNHwh3zyfFvgTe3cUaB0VcNyvFErSJ8T2KKD798JebRmPI0N5CWCdBtDXvOuWpo2oa
	NC+JdaEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pShMy-00BEvR-8L; Thu, 16 Feb 2023 16:44:28 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pShMu-00BEsx-Qh
	for linux-nvme@lists.infradead.org; Thu, 16 Feb 2023 16:44:26 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GCvdc3030777
	for <linux-nvme@lists.infradead.org>; Thu, 16 Feb 2023 08:44:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=GK4CWb3Es7tFPwx1wffTSvX6+ySEGLJXNL/nuS9qcQo=;
 b=BUZy//9E2lmIc40l4NJfZbnGwb2U6RntlAV/4p8ZQLd9Ytz0sUgmevvrw+vtVVe+OwWM
 nGb1l07ECIwU+EfUzTYFENJkZ4FpuFGUftqH47wpM57HdbkKYNBu8MxXkB5ZZ47oaj1j
 I0R54cfiviixUTTLZoLrcVQNpS6dY0EDMBPgLtF9XRiPCGjUMTUfarAHNIKLMPE1Uvjb
 FLKz10L7nOt2Yq4s5o0LaEgAmAdMAEa0w/gucynQNWD4ROwV7msW4O9Qub+nNc24oR7g
 rrLCvJgOjhenwfzaDH9W7NUz2zzBhraKMV+x2NBiiMU4Fu9EoW+Qqt+soqpkQFm3CsMT Tg== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nsbb6mn5n-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 16 Feb 2023 08:44:20 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Feb 2023 08:44:17 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id D7235117F10DE; Thu, 16 Feb 2023 08:44:03 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-pci: refresh visible attrs for cmb attributes
Date: Thu, 16 Feb 2023 08:44:03 -0800
Message-ID: <20230216164403.501894-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ZMtjV2AaX5DI159nLi2YXI6rk4EtKMvh
X-Proofpoint-ORIG-GUID: ZMtjV2AaX5DI159nLi2YXI6rk4EtKMvh
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_12,2023-02-16_01,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_084425_069183_99F73BBD 
X-CRM114-Status: GOOD (  16.45  )
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

The sysfs group containing the cmb attributes is registered before the
driver knows if they need to be visible or not. Update the group when
cmb attributes are known to exist so the visibility setting is correct.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217037
Fixes: 86adbf0cdb9ec65 ("nvme: simplify transport specific device attribute=
 handling")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6d88ddd355657..c11e0cfeef0f3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -110,6 +110,7 @@ struct nvme_queue;
=20
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 static void nvme_delete_io_queues(struct nvme_dev *dev);
+static void nvme_update_attrs(struct nvme_dev *dev);
=20
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
@@ -1923,6 +1924,8 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if ((dev->cmbsz & (NVME_CMBSZ_WDS | NVME_CMBSZ_RDS)) =3D=3D
 			(NVME_CMBSZ_WDS | NVME_CMBSZ_RDS))
 		pci_p2pmem_publish(pdev, true);
+
+	nvme_update_attrs(dev);
 }
=20
 static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
@@ -2209,6 +2212,11 @@ static const struct attribute_group *nvme_pci_dev_at=
tr_groups[] =3D {
 	NULL,
 };
=20
+static void nvme_update_attrs(struct nvme_dev *dev)
+{
+	sysfs_update_group(&dev->ctrl.device->kobj, &nvme_pci_dev_attrs_group);
+}
+
 /*
  * nirqs is the number of interrupts available for write and read
  * queues. The core already reserved an interrupt for the admin queue.
--=20
2.30.2


