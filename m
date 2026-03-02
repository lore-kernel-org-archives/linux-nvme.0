Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BE8EB363C
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 22:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tulloy8rxXy1RM3wBOFmF6jrhTDe/6JLBSoOZ+7rgrc=; b=URND5dZxbbnjIOcfpJ6km1kcp5
	X5atT4lG/U7M/ZK3zmpRYFM2A0wc6vZRBR8e1DyqhDBvuEh+B04DHlzcoNTItqrSgxoXqbkqxOz+B
	Qmnp9e04eGMBiJ53pIx0Bp+04KDpNPNftrtbS4rX9KZc5q+VPTL2iceifARCihLieLjLvBoaTtvrA
	R92MqvCArfIrYwOC7dY0Ae1CDKj4C058WvDlRouoNmRGKp+P6JyPW90Mz0Z+rw830iLS2u0d7q+jv
	6+eoYSORpFa3qV53B20kuX3qJ4GSR3Hf0ZbA3srxLMwBOL+qmrd4QXi+X4yz5G+3DBqVmiGt2eNHj
	gD8SMtnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxBi2-0000000E6z4-2MM6;
	Mon, 02 Mar 2026 22:25:50 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxBhz-0000000E6y6-1qpA
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 22:25:48 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 622IxsaH3095533
	for <linux-nvme@lists.infradead.org>; Mon, 2 Mar 2026 14:25:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=tulloy8rxXy1RM3wBO
	FmF6jrhTDe/6JLBSoOZ+7rgrc=; b=fTo1NNEDNfjH4OMcjZ6Wk/zZPC1a4I4QRQ
	En6/FN21yK7eX+UhXxjrPBDjm2z2j9RexjuKB/xo4qBN5fETfprdSewR51zoqehp
	ftD6QHlWJPY/NTazc1GcQmGVGxXZQ27DosUk4D1a+I9xUpwfI5CnYNcoPoBbSzVo
	VD+m6vPwkXiCYLUTAOrsCiv32/nqWU2rhY13IsjxRZ9m/LNmCrQDBC1SNTeN5t5q
	B2GHqxw04+Qit+T7yQVtsIfy6l+rlZcsCjdeYVZvTJWfdUNuQtXSNrOUEbcykJGL
	fI8RcnvCrVyObAvCNgNmirvoAjCnrD7TvQxytSPqb5zMdqo568IQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4cngast52d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2026 14:25:45 -0800 (PST)
Received: from twshared108583.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 2 Mar 2026 22:25:44 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 44C2698597E4; Mon,  2 Mar 2026 14:25:33 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <mlombard@redhat.com>
CC: <jmeneghi@redhat.com>, <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: [RFC-PATCH 1/2] nvme-multipath: delete gendisk under subsys lock
Date: Mon, 2 Mar 2026 14:25:31 -0800
Message-ID: <20260302222532.3400786-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2NSBTYWx0ZWRfXzpizQYQEs6wN
 1ORTp/UyJFKdoOQw81QJOYg6k5dLVcSPfCzeKr4uAKmtlwcJ8Yb7nBt3fquEvbiQkm0tT8ohKcL
 uW2lJC8SREUywIY28T9SO2MdF9FMyGaAcXa7Kf4VYv6NeuRy0vwdf/disHiV013HEr0AX4qZFZ1
 BPKte8knp7PMXAUIR417eOtWXkVSMcxWbn08MyQlNQ69dHos2jrmBbhvGDQOUdRzfMvtFl1njrg
 mSwyXcaVa7o9jlId1uAc0ECWQnK/9zdV7YGn0kb2yxi7wHhiCKeXLSelIGx3H+XsCHosktZs6Ab
 sSHMKW7akI7QgkwYkXNUbWTFxjlpHr/MshjRp2EwlDpagZ4jmLkU+DYDKVnUPWyb6f9vU3ONnMk
 yrY+ZxSWH6iJtR4ytDQ8vjI+R353HBUoK9OilOjkQO4EhvRz2m1f0+NzGHVR7GkuFwEeYawhM7y
 y/qyQtqLSY5W44nxZdA==
X-Proofpoint-ORIG-GUID: 4DDAmOBy_DabFkwFcPTFWQ1OPcoI5mZP
X-Proofpoint-GUID: 4DDAmOBy_DabFkwFcPTFWQ1OPcoI5mZP
X-Authority-Analysis: v=2.4 cv=U82fzOru c=1 sm=1 tr=0 ts=69a60e69 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=DLGBNgRvOwZS6mn5G4YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_142547_696511_F45CC856 
X-CRM114-Status: GOOD (  16.72  )
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

To maintain symmetry with the disk add side, perform the disk deletion
under the nvme subsystem lock. This will ensure consistent ordering of
device naming when adding namespaces while concurrently deleting stale
references.

The deferred removal requires special attention to the nvme_subsystem:
the head may be holding the final reference in the deferred path, so
take a reference on it while removing the head.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c      |  3 +--
 drivers/nvme/host/multipath.c | 28 +++++++++++-----------------
 drivers/nvme/host/nvme.h      |  1 +
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a5c1af443420b..7a558d5103a21 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -147,7 +147,6 @@ static const struct class nvme_ns_chr_class =3D {
 	.name =3D "nvme-generic",
 };
=20
-static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
@@ -3119,7 +3118,7 @@ static void nvme_destroy_subsystem(struct kref *ref=
)
 	put_device(&subsys->dev);
 }
=20
-static void nvme_put_subsystem(struct nvme_subsystem *subsys)
+void nvme_put_subsystem(struct nvme_subsystem *subsys)
 {
 	kref_put(&subsys->ref, nvme_destroy_subsystem);
 }
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index fc6800a9f7f94..02a50181d1dd6 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -682,6 +682,8 @@ static void nvme_requeue_work(struct work_struct *wor=
k)
=20
 static void nvme_remove_head(struct nvme_ns_head *head)
 {
+	list_del_init(&head->entry);
+
 	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
 		/*
 		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
@@ -700,16 +702,14 @@ static void nvme_remove_head_work(struct work_struc=
t *work)
 {
 	struct nvme_ns_head *head =3D container_of(to_delayed_work(work),
 			struct nvme_ns_head, remove_work);
-	bool remove =3D false;
+	struct nvme_subsystem *subsys =3D head->subsys;
=20
-	mutex_lock(&head->subsys->lock);
-	if (list_empty(&head->list)) {
-		list_del_init(&head->entry);
-		remove =3D true;
-	}
-	mutex_unlock(&head->subsys->lock);
-	if (remove)
+	kref_get(&subsys->ref);
+	mutex_lock(&subsys->lock);
+	if (list_empty(&head->list))
 		nvme_remove_head(head);
+	mutex_unlock(&subsys->lock);
+	nvme_put_subsystem(subsys);
=20
 	module_put(THIS_MODULE);
 }
@@ -1292,8 +1292,6 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32=
 anagrpid)
=20
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
-	bool remove =3D false;
-
 	if (!head->disk)
 		return;
=20
@@ -1314,17 +1312,13 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *=
head)
 	 * Ensure that no one could remove this module while the head
 	 * remove work is pending.
 	 */
-	if (head->delayed_removal_secs && try_module_get(THIS_MODULE)) {
+	if (head->delayed_removal_secs && try_module_get(THIS_MODULE))
 		mod_delayed_work(nvme_wq, &head->remove_work,
 				head->delayed_removal_secs * HZ);
-	} else {
-		list_del_init(&head->entry);
-		remove =3D true;
-	}
+	else
+		nvme_remove_head(head);
 out:
 	mutex_unlock(&head->subsys->lock);
-	if (remove)
-		nvme_remove_head(head);
 }
=20
 void nvme_mpath_put_disk(struct nvme_ns_head *head)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 44801801fc289..ed8ce356c363e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1283,6 +1283,7 @@ struct nvme_ctrl *nvme_ctrl_from_file(struct file *=
file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 bool nvme_get_ns(struct nvme_ns *ns);
 void nvme_put_ns(struct nvme_ns *ns);
+void nvme_put_subsystem(struct nvme_subsystem *subsys);
=20
 static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 {
--=20
2.47.3


