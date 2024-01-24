Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230DCC47E49
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 17:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/fqUaM5KMtexxWgJM9SrBZTS+cNZD9VIDHwvv9xBOow=; b=y9CkyZ8MAO6j6DSzTo/rm4Ho5e
	vwQrcMJ33EfpC94O6lsR+pL7MVHoJsiyeFgEoM0TC3UAjNbWxWAzH3GzAOFTwxW9XBLU6VHWckxoa
	V9FhvvZ+J7xGlpx3hjiDKVCQdvQDaLTR8OW5Cp+GQu4/IPuPWQxXcAikALIBk5TIlHN4eX+9MV+cL
	VpbwmPbN0eC0a8rFBoKZQNKEorkck8+7Zk5/bYQPTQQBR0zCnVIo5/B5TtoOxp7jWZYLDSPk1WKz4
	hJi6nu2/gW0oKTyAB9a5Z7Dyx4fYjkIrOiiUu2jD4w3vV/0JFv6uWW5WEuuAcGoNJi8XxZ7hPZyNA
	CDAECK4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSh3x-004Teh-0N;
	Wed, 24 Jan 2024 17:29:21 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSh3t-004Td6-0M
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 17:29:18 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 40OC7g92013266
	for <linux-nvme@lists.infradead.org>; Wed, 24 Jan 2024 09:29:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=/fqUaM5KMtexxWgJM9SrBZTS+cNZD9VIDHwvv9xBOow=;
 b=c1K2MrKdVqKQru6d4syE2LDv3HbOrDELiIyKmc/W+4iFYicT/QzcOZFmdef0MambAwSH
 JNqHAy0Mqwra7btiBLJfCHxq06enHKQV++PPf60rAjP94lj4SgiA2LJX49Ca0f4Z+Gkn
 sd3Cr8Xk2HEK//+rXeczVqb5PHadCllxijyJPW7cRAPwYEZtVA6dcRpJ9WTc/N0QaeUt
 /I35NQx825XOylIh6XfrG7u1CDXxJexFpqwp8Ek940UqhM4Tohh2/7y1kWxl+NRhDte7
 6tr2uqhLpp91ZSciSfgYXfOncpkF1syju6inGyer3m2RQ6T5km/9ZULf58nStbZG5SPe Rg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3vu12r29tw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 24 Jan 2024 09:29:12 -0800
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 09:29:11 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 50D8A24775B57; Wed, 24 Jan 2024 09:28:56 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: use ctrl state accessor
Date: Wed, 24 Jan 2024 09:28:55 -0800
Message-ID: <20240124172855.1901146-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: FDs74SqX63UlzxsEIOVYSq7b57K6-Zlc
X-Proofpoint-ORIG-GUID: FDs74SqX63UlzxsEIOVYSq7b57K6-Zlc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_092917_377712_626348D4 
X-CRM114-Status: GOOD (  20.08  )
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

The ctrl->state value is updated in another thread using WRITE_ONCE, so
ensure all the readers use the appropriate accessor.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/auth.c      |  2 +-
 drivers/nvme/host/fabrics.h   |  8 +++++---
 drivers/nvme/host/multipath.c | 15 ++++++++-------
 drivers/nvme/host/sysfs.c     |  6 +++---
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 72c0525c75f50..2a12ee878783f 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -897,7 +897,7 @@ static void nvme_ctrl_auth_work(struct work_struct *w=
ork)
 	 * If the ctrl is no connected, bail as reconnect will handle
 	 * authentication.
 	 */
-	if (ctrl->state !=3D NVME_CTRL_LIVE)
+	if (nvme_ctrl_state(ctrl) !=3D NVME_CTRL_LIVE)
 		return;
=20
 	/* Authenticate admin queue first */
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index fbaee5a7be196..06cc54851b1be 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -185,9 +185,11 @@ static inline bool
 nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 			struct nvmf_ctrl_options *opts)
 {
-	if (ctrl->state =3D=3D NVME_CTRL_DELETING ||
-	    ctrl->state =3D=3D NVME_CTRL_DELETING_NOIO ||
-	    ctrl->state =3D=3D NVME_CTRL_DEAD ||
+	enum nvme_ctrl_state state =3D nvme_ctrl_state(ctrl);
+
+	if (state =3D=3D NVME_CTRL_DELETING ||
+	    state =3D=3D NVME_CTRL_DELETING_NOIO ||
+	    state =3D=3D NVME_CTRL_DEAD ||
 	    strcmp(opts->subsysnqn, ctrl->opts->subsysnqn) ||
 	    strcmp(opts->host->nqn, ctrl->opts->host->nqn) ||
 	    !uuid_equal(&opts->host->id, &ctrl->opts->host->id))
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index 2dd4137a08b28..5bc72653013c5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -156,7 +156,7 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 		if (!ns->head->disk)
 			continue;
 		kblockd_schedule_work(&ns->head->requeue_work);
-		if (ctrl->state =3D=3D NVME_CTRL_LIVE)
+		if (nvme_ctrl_state(ns->ctrl) =3D=3D NVME_CTRL_LIVE)
 			disk_uevent(ns->head->disk, KOBJ_CHANGE);
 	}
 	up_read(&ctrl->namespaces_rwsem);
@@ -223,13 +223,14 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns=
)
=20
 static bool nvme_path_is_disabled(struct nvme_ns *ns)
 {
+	enum nvme_ctrl_state state =3D nvme_ctrl_state(ctrl);
+
 	/*
 	 * We don't treat NVME_CTRL_DELETING as a disabled path as I/O should
 	 * still be able to complete assuming that the controller is connected.
 	 * Otherwise it will fail immediately and return to the requeue list.
 	 */
-	if (ns->ctrl->state !=3D NVME_CTRL_LIVE &&
-	    ns->ctrl->state !=3D NVME_CTRL_DELETING)
+	if (state !=3D NVME_CTRL_LIVE && state !=3D NVME_CTRL_DELETING)
 		return true;
 	if (test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
 	    !test_bit(NVME_NS_READY, &ns->flags))
@@ -331,7 +332,7 @@ static struct nvme_ns *nvme_round_robin_path(struct n=
vme_ns_head *head,
=20
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 {
-	return ns->ctrl->state =3D=3D NVME_CTRL_LIVE &&
+	return nvme_ctrl_state(ns->ctrl) =3D=3D NVME_CTRL_LIVE &&
 		ns->ana_state =3D=3D NVME_ANA_OPTIMIZED;
 }
=20
@@ -358,7 +359,7 @@ static bool nvme_available_path(struct nvme_ns_head *=
head)
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
 			continue;
-		switch (ns->ctrl->state) {
+		switch (nvme_ctrl_state(ns->ctrl)) {
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
@@ -667,7 +668,7 @@ static void nvme_update_ns_ana_state(struct nvme_ana_=
group_desc *desc,
 	 * controller is ready.
 	 */
 	if (nvme_state_is_live(ns->ana_state) &&
-	    ns->ctrl->state =3D=3D NVME_CTRL_LIVE)
+	    nvme_ctrl_state(ns->ctrl) =3D=3D NVME_CTRL_LIVE)
 		nvme_mpath_set_live(ns);
 }
=20
@@ -748,7 +749,7 @@ static void nvme_ana_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =3D container_of(work, struct nvme_ctrl, ana_wor=
k);
=20
-	if (ctrl->state !=3D NVME_CTRL_LIVE)
+	if (nvme_ctrl_state(ctrl) !=3D NVME_CTRL_LIVE)
 		return;
=20
 	nvme_read_ana_log(ctrl);
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 754e911110420..6b2f06f190de3 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -311,6 +311,7 @@ static ssize_t nvme_sysfs_show_state(struct device *d=
ev,
 				     char *buf)
 {
 	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
+	unsigned state =3D (unsigned)nvme_ctrl_state(ctrl);
 	static const char *const state_name[] =3D {
 		[NVME_CTRL_NEW]		=3D "new",
 		[NVME_CTRL_LIVE]	=3D "live",
@@ -321,9 +322,8 @@ static ssize_t nvme_sysfs_show_state(struct device *d=
ev,
 		[NVME_CTRL_DEAD]	=3D "dead",
 	};
=20
-	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
-	    state_name[ctrl->state])
-		return sysfs_emit(buf, "%s\n", state_name[ctrl->state]);
+	if (state < ARRAY_SIZE(state_name) && state_name[state])
+		return sysfs_emit(buf, "%s\n", state_name[state]);
=20
 	return sysfs_emit(buf, "unknown state\n");
 }
--=20
2.34.1


