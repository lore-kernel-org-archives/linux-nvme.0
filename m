Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97345EB64DA
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jun 2023 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ddm0xE+SDsRgf1p/y+2H/LI+mWp7U7DSsZMuvzLz7YA=; b=Y+8ilC6rZ9vvUN5LFGvkpEXnXC
	BW2YaFlKOOe5TRm2KS0uDZ/KnzOZloCtQ1GcEnMKdSe/BmMY2KVXVyQRfLgxFx4Gy0AENTr3vkmDU
	WaClQiFJnESFYlzTnHIHG5fG5yzXl4OwbxTzhO/4iVMFaetjPMloZEYk55n4YK+7kGB805A5zmG8q
	zfjiFf3fncbYbh2oI3FkHVyeNp7ytlOaCz+A5fG8Qm+KenfT5tOTpVDo3lxGQIrnNUTW9Mj202c/o
	6a7ePSD/RIf6wKvSFJSwO6uYdKRnjHUbd3MI8ztccZsbwUbtThNZo03UBT0sLwlM2dnEyMuq1TGph
	BQNRcsLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9op3-00FHyu-01;
	Thu, 15 Jun 2023 15:23:41 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9ooz-00FHyJ-33
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jun 2023 15:23:39 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 35F2CmSF025381
	for <linux-nvme@lists.infradead.org>; Thu, 15 Jun 2023 08:23:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=ddm0xE+SDsRgf1p/y+2H/LI+mWp7U7DSsZMuvzLz7YA=;
 b=LzJWNyM9nfuW0D0oBshE6GEonZyE0Tf2Fx1Jd3llf8x5ThxOek7O1wjzkOxBCmmi3IcK
 D8H9O9rRuDG62v1g9jpRVHXXAPyvKx+U9OTgu+ISuldwAoY9xF6oSPquMHJi4lVMo3X6
 eQ38n5w3nmU9kwfDA96jZnJFxxVGywbTrUz6mhzSYRljdEYEUWZQywislhAwjgY5H4Vp
 EPcewTfhk5KU4TRyvR1+6gcZJGozBzCSZIXOf3A1IlgPSMa+E/wCCf1PkGxF1dffV/XX
 mb7XEWSCN8b6hZoC4IwGY6oz73Azjmvajs9s3fxuDCRi4IbFfcuCzIiNb6iUl8VoMZgr vQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3r7sncmg90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 15 Jun 2023 08:23:35 -0700
Received: from twshared10457.08.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 08:23:34 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 243AA1A20C19C; Thu, 15 Jun 2023 08:23:19 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, Maurizio Lombardi <mlombard@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH] nvme: forward port sysfs delete fix
Date: Thu, 15 Jun 2023 08:23:18 -0700
Message-ID: <20230615152318.3391960-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fleeY3xB54rCdxH6St9An5NXwFIbpdEt
X-Proofpoint-GUID: fleeY3xB54rCdxH6St9An5NXwFIbpdEt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_11,2023-06-15_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_082338_230355_27F2A524 
X-CRM114-Status: GOOD (  16.10  )
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

We had a late fix that modified nvme_sysfs_delete() after the staging
branch for the next merge window relocated the function to a new file.
Port commit 2eb94dd56a4a4 ("nvme: do not let the user delete a ctrl
before a complete") to the latest to avoid a potentially confusing merge
conflict.

Cc: Maurizio Lombardi <mlombard@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 796e1d373b7c1..45e91811f905c 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -202,6 +202,9 @@ static ssize_t nvme_sysfs_delete(struct device *dev,
 {
 	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
=20
+	if (!test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags))
+		return -EBUSY;
+
 	if (device_remove_file_self(dev, attr))
 		nvme_delete_ctrl_sync(ctrl);
 	return count;
--=20
2.34.1


