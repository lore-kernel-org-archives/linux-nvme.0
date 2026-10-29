Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B17606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UeupuGbN;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=fdCDc9s5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ld/KYE43Sr/GbuMcQC/gA/eFGsFr8F+t0JPU0+cSomw=; b=UeupuGbNb/eqM9755A7S2v8Xi1
	yOj7Q3bDxB6H2BAGT4PSBMOghseE3d7MGdMc/EhU/qlDA3B9Xvz3GhnLntV2+98O7G86/xdqL0OHW
	7dSTW0qF1YIXAlELAxXuKjbqQnbmaOTqYGUtv7leIBnqASx5BmfzGUsCHXWKIYD0kuwpiW/8STy4H
	BIiuM73SxYAjxP1PVUwKszUqO8Mrrrr4pYlKCCTz3Q7audDwSK5GHvrpx/f+e/08SGtDMTe7wbxTC
	uKkWdIS6+OJCexAdoZELUk1U5JaC7N2XIl2imlkMWqx7bAY/OZizaZtvXAXInCoOLTj2uWVwP8C0R
	p1eTWSHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRG-00000009fwS-3pTW;
	Thu, 29 Oct 2026 15:53:14 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRC-00000009fta-1AFX
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:13 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCdNgg2670384
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=ld/KYE43Sr/GbuMcQC/gA/eFGsFr8F+t0JPU0
	+cSomw=; b=fdCDc9s55FB9H+kPt13yFHnbcYR1ex4N+/5enndri+EvDjEi55FnK
	WL1j57w2Cmau149MIbE0qSZFIySi0B775sLmYPT7iUqEouCehh24hEFBabLcT0bH
	dnuk5rxahn2AcjxGgk1nTl9rfnrcn7VSnKhUxfXw+J+hXau1D2S3JlvNoXFEdKe8
	O12VwX6i3EGuxeMjFzEcPP7zzCmWDthhiXXEIsfCJNouvnBHmwzKu/vvA1a495NO
	u6uu82MD1gH/EUPi9TXY2bxi9Yz8nKOKXehUK9SPOQAQTOPEVjBkdVQHy0wkJZvv
	IcjDDdDmnXiTgHQlVNUAm4ejXrptt9FCw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hm28qjnp5-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:08 -0700 (PDT)
Received: from twshared13996.31.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:05 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 5D09F2E22CEB3; Thu, 29 Oct 2026 08:52:57 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Chris Mason <mason@kernel.org>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 09/19] nvmet: fix pc_ref use-after-free in preempt and abort
Date: Thu, 29 Oct 2026 08:52:42 -0700
Message-ID: <20261029155252.2332266-10-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfXx9bZSg0E/1xm
 /tzbe6sdkIo54frCZ6FtZLPtW2VtHDlr3sFgrHUT/WqE6JMbIJvdewN9x5LLnFwfeou9CTnv6Hw
 K2z0OwUwC9ldUGKmjKjPTmWOosIwHwM=
X-Proofpoint-GUID: 7T5yfkxTWdWFCIgk1xgh251_bPPuCph2
X-Proofpoint-ORIG-GUID: 7T5yfkxTWdWFCIgk1xgh251_bPPuCph2
X-Authority-Analysis: v=2.4 cv=NudE4MdJ c=1 sm=1 tr=0 ts=6ae36be4 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=cJzY04SRZynBs7MXj8gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX1XTQvfkn9Mcf
 Fp8UdukHrsTLaoPtYE+Fo0mXbdt0/xnhxhsUwSaAa1miOoQCAgknOL0m8tldlKZ8/SfSfRC1bQ9
 EsfbSLfpVXZ5Pf3clVgwk/0WjTnekBhyGt5vH3sDw9r8DPfg5w8ivq/1fFmp+gML5duB/wKsiq+
 BTsz/yAOpIxqfKuM+dbHypg86Imb8jKIUoTrZKuWHGXuZAyPBvsJxQnw+oZToz8fu/WcJSrmLH4
 +8oTXuCRyu42HcXzTwrkYC1R6KvKlgWqvA4nl737cFmbrhpL/sRcGA7i9W2YZ81/0imFOj+jrCm
 taWhMURaE6I6f920E6iTRmjmsteEXl7SRWElegknJosR9+ukHEq4waoNK/OPEBMna7MWlchpgPS
 51qGyDYdiR+TjKRU6HDrENea+dQkPZsvxhUK5fHfgXVBuXMxjENWLT2mud+rHHhkgjNloujtLE0
 r2qwmP49V6H8wy8F7AQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085310_354465_A28CD1B8 
X-CRM114-Status: GOOD (  22.23  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chris Mason <mason@kernel.org>

With reservations enabled on a namespace, the target keeps a pc_ref per
controller, a percpu_ref counting that controller's I/O on the
namespace. "Preempt and abort" kills the pc_refs of the preempted
controllers and waits for the kill to be confirmed in
nvmet_pr_set_ctrl_to_abort(), then waits for the count to drop to zero
and resurrects them in nvmet_pr_do_abort(). Neither holds a reference
to the pc_ref, only pr_sem. nvmet_ctrl_destroy_pr() frees the pc_refs
under subsys->lock when the controller goes away, so a host that
registers a key, disconnects, and sends preempt and abort with that key
over a second connection frees a pc_ref that the abort is sleeping on:

    preempt and abort on C1            last put of C2
    nvmet_pr_set_ctrl_to_abort()
      percpu_ref_kill_and_confirm()
      wait_for_completion()
                                       nvmet_ctrl_destroy_pr()
                                         percpu_ref_exit()
                                         kfree(pc_ref)
    percpu_ref_switch_to_atomic_rcu()  /* use after free */

Put the pc_refs that an abort has killed on a per-namespace list.
nvmet_ctrl_destroy_pr() only flags a pc_ref on that list, and
nvmet_pr_do_abort() frees flagged ones once it's done with them. The
list and the flag are written under the xarray lock.

Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/nvmet.h |  5 ++
 drivers/nvme/target/pr.c    | 92 ++++++++++++++++++++++++++-----------
 2 files changed, 69 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index d7804bf91aaa8..a89b384c4bbc9 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -88,6 +88,8 @@ struct nvmet_pr {
 	 */
 	struct semaphore	pr_sem;
 	struct list_head	registrant_list;
+	/* The pc_refs that a running "preempt and abort" has killed. */
+	struct list_head	abort_list;
 };
=20
 struct nvmet_pr_per_ctrl_ref {
@@ -95,6 +97,9 @@ struct nvmet_pr_per_ctrl_ref {
 	struct completion	free_done;
 	struct completion	confirm_done;
 	uuid_t			hostid;
+	/* Both are written under the lock of ns->pr_per_ctrl_refs. */
+	struct list_head	abort_entry;
+	bool			ctrl_gone;
 };
=20
 struct nvmet_ns {
diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 14eaa99f98fa3..1c0d6cac1a6b3 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -468,18 +468,54 @@ static void nvmet_pr_confirm_ns_pc_ref(struct percp=
u_ref *ref)
 	complete(&pc_ref->confirm_done);
 }
=20
+static void nvmet_pr_free_pc_ref(struct nvmet_pr_per_ctrl_ref *pc_ref)
+{
+	percpu_ref_exit(&pc_ref->ref);
+	kfree(pc_ref);
+}
+
+/*
+ * The controller goes away. "Preempt and abort" sleeps on the pc_refs o=
n its
+ * list, so leave the free of such a pc_ref to nvmet_pr_do_abort().
+ */
+static void nvmet_pr_erase_pc_ref(struct nvmet_ns *ns, unsigned long cnt=
lid)
+{
+	struct nvmet_pr_per_ctrl_ref *pc_ref;
+
+	xa_lock(&ns->pr_per_ctrl_refs);
+	pc_ref =3D __xa_erase(&ns->pr_per_ctrl_refs, cntlid);
+	if (pc_ref && !list_empty(&pc_ref->abort_entry)) {
+		pc_ref->ctrl_gone =3D true;
+		pc_ref =3D NULL;
+	}
+	xa_unlock(&ns->pr_per_ctrl_refs);
+
+	if (pc_ref)
+		nvmet_pr_free_pc_ref(pc_ref);
+}
+
 static void nvmet_pr_set_ctrl_to_abort(struct nvmet_req *req, uuid_t *ho=
stid)
 {
 	struct nvmet_pr_per_ctrl_ref *pc_ref;
 	struct nvmet_ns *ns =3D req->ns;
 	unsigned long idx;
=20
+	xa_lock(&ns->pr_per_ctrl_refs);
 	xa_for_each(&ns->pr_per_ctrl_refs, idx, pc_ref) {
-		if (uuid_equal(&pc_ref->hostid, hostid)) {
-			percpu_ref_kill_and_confirm(&pc_ref->ref,
-						nvmet_pr_confirm_ns_pc_ref);
-			wait_for_completion(&pc_ref->confirm_done);
-		}
+		if (uuid_equal(&pc_ref->hostid, hostid) &&
+		    list_empty(&pc_ref->abort_entry))
+			list_add_tail(&pc_ref->abort_entry,
+				      &ns->pr.abort_list);
+	}
+	xa_unlock(&ns->pr_per_ctrl_refs);
+
+	list_for_each_entry(pc_ref, &ns->pr.abort_list, abort_entry) {
+		/* Killed for another host that this command preempts. */
+		if (percpu_ref_is_dying(&pc_ref->ref))
+			continue;
+		percpu_ref_kill_and_confirm(&pc_ref->ref,
+					    nvmet_pr_confirm_ns_pc_ref);
+		wait_for_completion(&pc_ref->confirm_done);
 	}
 }
=20
@@ -618,20 +654,27 @@ static u16 nvmet_pr_preempt(struct nvmet_req *req,
 static void nvmet_pr_do_abort(struct work_struct *w)
 {
 	struct nvmet_req *req =3D container_of(w, struct nvmet_req, r.abort_wor=
k);
-	struct nvmet_pr_per_ctrl_ref *pc_ref;
+	struct nvmet_pr_per_ctrl_ref *pc_ref, *tmp;
 	struct nvmet_ns *ns =3D req->ns;
-	unsigned long idx;
+	bool ctrl_gone;
=20
 	/*
 	 * The target does not support abort, just wait per-controller ref to 0=
.
 	 */
-	xa_for_each(&ns->pr_per_ctrl_refs, idx, pc_ref) {
-		if (percpu_ref_is_dying(&pc_ref->ref)) {
-			wait_for_completion(&pc_ref->free_done);
-			reinit_completion(&pc_ref->confirm_done);
-			reinit_completion(&pc_ref->free_done);
-			percpu_ref_resurrect(&pc_ref->ref);
-		}
+	list_for_each_entry_safe(pc_ref, tmp, &ns->pr.abort_list, abort_entry) =
{
+		wait_for_completion(&pc_ref->free_done);
+		reinit_completion(&pc_ref->confirm_done);
+		reinit_completion(&pc_ref->free_done);
+		percpu_ref_resurrect(&pc_ref->ref);
+
+		/* Off the list, the pc_ref belongs to its controller again. */
+		xa_lock(&ns->pr_per_ctrl_refs);
+		list_del_init(&pc_ref->abort_entry);
+		ctrl_gone =3D pc_ref->ctrl_gone;
+		xa_unlock(&ns->pr_per_ctrl_refs);
+
+		if (ctrl_gone)
+			nvmet_pr_free_pc_ref(pc_ref);
 	}
=20
 	up(&ns->pr.pr_sem);
@@ -1052,6 +1095,8 @@ static int nvmet_pr_alloc_and_insert_pc_ref(struct =
nvmet_ns *ns,
 	init_completion(&pc_ref->free_done);
 	init_completion(&pc_ref->confirm_done);
 	uuid_copy(&pc_ref->hostid, hostid);
+	INIT_LIST_HEAD(&pc_ref->abort_entry);
+	pc_ref->ctrl_gone =3D false;
=20
 	ret =3D xa_insert(&ns->pr_per_ctrl_refs, idx, pc_ref, GFP_KERNEL);
 	if (ret)
@@ -1067,7 +1112,6 @@ static int nvmet_pr_alloc_and_insert_pc_ref(struct =
nvmet_ns *ns,
 int nvmet_ctrl_init_pr(struct nvmet_ctrl *ctrl)
 {
 	struct nvmet_subsys *subsys =3D ctrl->subsys;
-	struct nvmet_pr_per_ctrl_ref *pc_ref;
 	struct nvmet_ns *ns =3D NULL;
 	unsigned long idx;
 	int ret;
@@ -1095,19 +1139,14 @@ int nvmet_ctrl_init_pr(struct nvmet_ctrl *ctrl)
=20
 free_per_ctrl_refs:
 	nvmet_for_each_enabled_ns(&subsys->namespaces, idx, ns) {
-		if (ns->pr.enable) {
-			pc_ref =3D xa_erase(&ns->pr_per_ctrl_refs, ctrl->cntlid);
-			if (pc_ref)
-				percpu_ref_exit(&pc_ref->ref);
-			kfree(pc_ref);
-		}
+		if (ns->pr.enable)
+			nvmet_pr_erase_pc_ref(ns, ctrl->cntlid);
 	}
 	return ret;
 }
=20
 void nvmet_ctrl_destroy_pr(struct nvmet_ctrl *ctrl)
 {
-	struct nvmet_pr_per_ctrl_ref *pc_ref;
 	struct nvmet_ns *ns;
 	unsigned long idx;
=20
@@ -1115,12 +1154,8 @@ void nvmet_ctrl_destroy_pr(struct nvmet_ctrl *ctrl=
)
 	mutex_destroy(&ctrl->pr_log_mgr.lock);
=20
 	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
-		if (ns->pr.enable) {
-			pc_ref =3D xa_erase(&ns->pr_per_ctrl_refs, ctrl->cntlid);
-			if (pc_ref)
-				percpu_ref_exit(&pc_ref->ref);
-			kfree(pc_ref);
-		}
+		if (ns->pr.enable)
+			nvmet_pr_erase_pc_ref(ns, ctrl->cntlid);
 	}
 }
=20
@@ -1136,6 +1171,7 @@ int nvmet_pr_init_ns(struct nvmet_ns *ns)
 	atomic_set(&ns->pr.generation, 0);
 	sema_init(&ns->pr.pr_sem, 1);
 	INIT_LIST_HEAD(&ns->pr.registrant_list);
+	INIT_LIST_HEAD(&ns->pr.abort_list);
 	ns->pr.notify_mask =3D 0;
=20
 	xa_init(&ns->pr_per_ctrl_refs);
--=20
2.52.0


