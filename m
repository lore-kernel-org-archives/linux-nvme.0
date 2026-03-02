Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687A7EB363C
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 22:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sdaoGFmyj0EaPe8O5WuTtu+1B12ZJME1iifY8NCrXAg=; b=4FfVBG22F8HKRHjFTUSL38hB1H
	dHWhx5f+8zbLcApqVgMWHUobr1hEAAXVM+4B6JPVDOfEOESeaV7h50+wksk6tMZOzI1twe+uXpFhq
	PVdCJBVE2amKaAvVnopB4991Poe0AR0srBbpEA2jYjML7uPFWReX5QhgHD8lEA1xInK3wsQHxsAf7
	b6rQFRvI/2txndphK2URkwxRgZZZbqUgrKMQc8au8E1T5Y9SAI2HPHJqIDsO5BuLPt/WRX690vhXa
	yyjANV+EvXiMmFyuB10ExDpK+rTBD7RYyPlCEOm89P9giBaL8c+S1aByTjeQKfDxI+BPXyeGlJs80
	jtF/TikA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxBi3-0000000E6zK-3kHq;
	Mon, 02 Mar 2026 22:25:51 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxBi1-0000000E6yn-2huK
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 22:25:50 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622MLXnQ4024781
	for <linux-nvme@lists.infradead.org>; Mon, 2 Mar 2026 14:25:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=sdaoGFmyj0EaPe8O5WuTtu+1B12ZJME1iifY8NCrXAg=; b=orLHqseTdNMH
	qtJaV1XlPV9TylfDQ8rWrvuHvtpjRIRtxp0LqdEFp3AagEen9T5/ekkafZsXYfo+
	fQcXIJDMer1tORMZS7UB5xyo5Bty/r+gjY3PvgH8ZP7Rgeok2wO3/LHv6JwFwmNg
	rPfHfZZWRXJQWSjB1IKqCTJu967cjhhrABlxoCpWegT6BRpjFelRXC7qKczcvLVs
	1IJHYW4PJotTcHl0L7u4kDwIH+nG1kG0B2d9g0DFS1Bpf4ro7F1yVsscxqrsvqNW
	nsQZYqIbDUSARroDpwEAc3BCFH3HVA/4P8Xp0xpgVaKdYLSAqRV2S1jOXdwiSPdh
	tT5nzV0umQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cn1hq2ju0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2026 14:25:48 -0800 (PST)
Received: from twshared17475.04.snb3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 2 Mar 2026 22:25:48 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4628998597E5; Mon,  2 Mar 2026 14:25:33 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <mlombard@redhat.com>
CC: <jmeneghi@redhat.com>, <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: [RFC-PATCH 2/2] nvme: use the namespace id for block device names
Date: Mon, 2 Mar 2026 14:25:32 -0800
Message-ID: <20260302222532.3400786-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302222532.3400786-1-kbusch@meta.com>
References: <20260302222532.3400786-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=S5fUAYsP c=1 sm=1 tr=0 ts=69a60e6c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VwQbUJbxAAAA:8 a=qfwSZh0Zux13ifkg2nIA:9
X-Proofpoint-ORIG-GUID: WeskWETVa-Hqao_hwSUKqlXI-z2zK44J
X-Proofpoint-GUID: WeskWETVa-Hqao_hwSUKqlXI-z2zK44J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2NSBTYWx0ZWRfX/BNEzpZnPpNd
 hwlbUC0g3/WITMOKjh9arauQuKdg9XYhwcX/C+GISq5eRUn516ssB98FmFlKP3yh1qQ7Q6jgs48
 cSkMLQengMQVIb6w9NjZ9Er3CnacTxHISC7zifDtdh3sChQcRQIPQtJGHcAB1N7rcb/3NLgayyj
 WC/gdLruYEgXOrQDUTfm6AmYU5Q3bCZw7gjch1aKTbmP8JFL8R6uve+qI3p/EhXt499WYJMuVxY
 ALBjJQCTe/ax9FCPTryT1aeSZZJ59rIk4BMblzO0BrXCFlGvDdO//1u88/XsnfDGsf5Pg/hbDds
 Riv9xNC9BGSfHFDJ3aCu6+XqNAnGS6KES9jUJ8dpNF/1Mh5NACnLUAaDaN/3VBNyGfxba38wc77
 LBy6MA77uCtg9GsSviRKzP4Sp6vaek1gMAWOzPdtm/jLWBT7s8wodmX7xgzJpo8ujJEUXlIPBeF
 2tYazpq653cdGw/mDVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_142549_689878_FA0E420F 
X-CRM114-Status: GOOD (  16.20  )
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

We can now assume the ns_id provides a unique number within a subsystem
when creating a namespace kobject. Use that rather than pulling an
available bit from an ida, which becomes unnecessary once we use the
controller's reported identifier.

The user observable change is that the suffix of the nvme namespace
device handle name will always be consistent regardless of which
controller is scanned first or what the namespace attachment state is
for a given controller being scanned. The prefix will still be dependent
on the order the controllers were connected/probed.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c      | 19 +++++--------------
 drivers/nvme/host/multipath.c |  4 ++--
 drivers/nvme/host/nvme.h      |  2 --
 3 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7a558d5103a21..3f2f9b2be87c2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -667,7 +667,6 @@ static void nvme_free_ns_head(struct kref *ref)
 		container_of(ref, struct nvme_ns_head, ref);
=20
 	nvme_mpath_put_disk(head);
-	ida_free(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
 	kfree(head->plids);
@@ -3113,7 +3112,6 @@ static void nvme_destroy_subsystem(struct kref *ref=
)
 	list_del(&subsys->entry);
 	mutex_unlock(&nvme_subsystems_lock);
=20
-	ida_destroy(&subsys->ns_ida);
 	device_del(&subsys->dev);
 	put_device(&subsys->dev);
 }
@@ -3257,7 +3255,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ct=
rl, struct nvme_id_ctrl *id)
 			put_device(&subsys->dev);
 			goto out_unlock;
 		}
-		ida_init(&subsys->ns_ida);
 		list_add_tail(&subsys->entry, &nvme_subsystems);
 	}
=20
@@ -3868,7 +3865,7 @@ static int nvme_add_ns_cdev(struct nvme_ns *ns)
=20
 	ns->cdev_device.parent =3D ns->ctrl->device;
 	ret =3D dev_set_name(&ns->cdev_device, "ng%dn%d",
-			   ns->ctrl->instance, ns->head->instance);
+			   ns->ctrl->instance, ns->head->ns_id);
 	if (ret)
 		return ret;
=20
@@ -3890,14 +3887,10 @@ static struct nvme_ns_head *nvme_alloc_ns_head(st=
ruct nvme_ctrl *ctrl,
 	head =3D kzalloc(size, GFP_KERNEL);
 	if (!head)
 		goto out;
-	ret =3D ida_alloc_min(&ctrl->subsys->ns_ida, 1, GFP_KERNEL);
-	if (ret < 0)
-		goto out_free_head;
-	head->instance =3D ret;
 	INIT_LIST_HEAD(&head->list);
 	ret =3D init_srcu_struct(&head->srcu);
 	if (ret)
-		goto out_ida_remove;
+		goto out_free_head;
 	head->subsys =3D ctrl->subsys;
 	head->ns_id =3D info->nsid;
 	head->ids =3D info->ids;
@@ -3925,8 +3918,6 @@ static struct nvme_ns_head *nvme_alloc_ns_head(stru=
ct nvme_ctrl *ctrl,
 	return head;
 out_cleanup_srcu:
 	cleanup_srcu_struct(&head->srcu);
-out_ida_remove:
-	ida_free(&ctrl->subsys->ns_ida, head->instance);
 out_free_head:
 	kfree(head);
 out:
@@ -4162,14 +4153,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl,=
 struct nvme_ns_info *info)
 	 */
 	if (nvme_ns_head_multipath(ns->head)) {
 		sprintf(disk->disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
-			ctrl->instance, ns->head->instance);
+			ctrl->instance, ns->head->ns_id);
 		disk->flags |=3D GENHD_FL_HIDDEN;
 	} else if (multipath) {
 		sprintf(disk->disk_name, "nvme%dn%d", ctrl->subsys->instance,
-			ns->head->instance);
+			ns->head->ns_id);
 	} else {
 		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
-			ns->head->instance);
+			ns->head->ns_id);
 	}
=20
 	if (nvme_update_ns_info(ns, info))
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index 02a50181d1dd6..8715b04ff92a8 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -640,7 +640,7 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head =
*head)
=20
 	head->cdev_device.parent =3D &head->subsys->dev;
 	ret =3D dev_set_name(&head->cdev_device, "ng%dn%d",
-			   head->subsys->instance, head->instance);
+			   head->subsys->instance, head->ns_id);
 	if (ret)
 		return ret;
 	ret =3D nvme_cdev_add(&head->cdev, &head->cdev_device,
@@ -767,7 +767,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, str=
uct nvme_ns_head *head)
 	 */
 	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
 	sprintf(head->disk->disk_name, "nvme%dn%d",
-			ctrl->subsys->instance, head->instance);
+			ctrl->subsys->instance, head->ns_id);
 	nvme_tryget_ns_head(head);
 	return 0;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ed8ce356c363e..142a5684205a8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -499,7 +499,6 @@ struct nvme_subsystem {
 	u8			cmic;
 	enum nvme_subsys_type	subtype;
 	u16			vendor_id;
-	struct ida		ns_ida;
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_iopolicy	iopolicy;
 #endif
@@ -540,7 +539,6 @@ struct nvme_ns_head {
 	struct nvme_effects_log *effects;
 	u64			nuse;
 	unsigned		ns_id;
-	int			instance;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u64			zsze;
 #endif
--=20
2.47.3


