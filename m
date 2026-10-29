Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0907606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Zvn5pp9M;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=j8BpKVub
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hSJOnlOabCTmSi0uHjLz0MVDSTtAIqK4qmA4AJ4bDwQ=; b=Zvn5pp9Mw2GztBU6lJkhClJWx2
	WgP2pszgo3KZovsYo7buTuddFkH0SBq2FPbtgoey9mEcglOzFiJPdlZ7SKHxKPPj6PuL4/RkmP5dq
	VllIJjtERoisVFP/K9SbM9AxcqZeQiMY+Fo/s4XWe1F2G+jfUJwR1qojlbNZHaeHy8esMgPHWEoXc
	S9osxdylNVR2bxllIMA6zHBTs/LH75tUesY7SiJjogAf9VrYlZ3UXjyss2RfE9Atbh1o12IDZ/WbE
	mKVhEkfuAcaYYMNUj8r2rCqKRdMvghRjzzSMb3W34MxkWpJ8ViWt0HHNzus28wlLG+FMy628zvILM
	3ScQbdLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRR-00000009gG2-1UkX;
	Thu, 29 Oct 2026 15:53:25 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRN-00000009g7R-2hsg
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:22 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCdk4J428233
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=hSJOnlOabCTmSi0uHjLz0MVDSTtAIqK4qmA4A
	J4bDwQ=; b=j8BpKVub7T5sujwvxn+Nl9d2Ekh5wT8bUBbPBMjsm6ny06AUPCIB0
	mZT8e/4Dw65ekyha7L+GnGQi+bEhPHeAAFx9pekg5pGMu6FIwD6qrY8ALRLUrSEe
	tOJUqykuEA6uzxtDsTZDfUEFrMijMNv+yLs/3lNBTwUl8maFrF3W2wCSTMG1TWpE
	cb0KCrQ6PuecgdF4R+eS1YoMWfo8AdaDafFL31Mm45VwjYVG7PnyyeXAL4TveZcr
	hLUUguyTvOYhUmFrdGsWZ02Nd6V7zfTqnepq2CH8i0nVta4z+1kF96vXGgKT39u3
	ylnyTtDwJ09GyRcMx8hqPvFz6BmTp2lsQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hm5vk1jry-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:21 -0700 (PDT)
Received: from twshared30277.33.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:12 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C9CA92E22CEE1; Thu, 29 Oct 2026 08:53:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Chris Mason <mason@kernel.org>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 19/19] nvmet: wait only for executing I/O in preempt and abort
Date: Thu, 29 Oct 2026 08:52:52 -0700
Message-ID: <20261029155252.2332266-20-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ccNHPXDM c=1 sm=1 tr=0 ts=6ae36bf1 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=03ozwUkBphtHgyqjj1sw:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=iGV3XuuONPWERPlOXG8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX7ciqo4gEnNSr
 zqhhK1dtO9+Jp8dS4qqci4eEpslrw8t5xoBCxDbvXnH+1ZzKapMbVjmuE/qyLl7Iycx1i8d3pwU
 XmK1IYuSWeheoBPZOb4p60ZqzP6Z7nbdLGATwKZ6vxn6ogVcbbkZLrEYcKphlHbmp/Xjk2Py9Or
 P1EJcxdhvsb+5Y0F46aG3ESi7GfxaaxDFYnAfopeZKQ6/BxNbXxRU1Ra8CZHt00hbFWVrzl7wqD
 0QbfLXOi5ahNxSNOb91/NflnOnxSLBBsb2C0ajopMv141cHXJYrSEWCUuSErlLv+1jkuBjroKG7
 tibjVswSBK7sIHswWUgEYrQFmka+uvNHO9BQIYfC1TtODQ1IeHz3yFrL8fYZka9POsKHmjhcdUM
 TI7JP6NbUgUXrTqNPbE2t2D/spPqZ2TLe04S394B5brDifWYWeAcwh0RyxN9cJ5wXpXuHJAQiPN
 O3QGD1k9/PJbpAv/JkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX2TepgKhEa6BZ
 0miyXlN9nr0zYajDaWmZ2LVfQEuxsyHZc5gRa6YnHdJbfWQmjab5nR5oRl8nyHFm9etudpqvU/2
 O0frLjpXLlP6ZAUbHuHz6DIkXCIfDfo=
X-Proofpoint-ORIG-GUID: eKjEY_hvQYo-cRvY84fU0oqC0sx5wvpQ
X-Proofpoint-GUID: eKjEY_hvQYo-cRvY84fU0oqC0sx5wvpQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085321_694157_D905ADD7 
X-CRM114-Status: GOOD (  23.08  )
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

nvmet_parse_io_cmd() takes the pc_ref for an I/O command as soon as it's
parsed, and "preempt and abort" waits for all pc_refs of the preempted
controllers before it releases pr_sem. But a write that still needs its
data can't complete without the host sending it and without the
transport context receiving it, and that same context is where Register,
Acquire and Release sleep on pr_sem. So a host that sends a write and
holds the data back, then preempt and abort with its own key, then
Register on the same queue, deadlocks io_work, the abort work and the
write with each other. Two well-behaved hosts get there by accident
when one fences the other while it re-registers under I/O. The
connection can't be torn down, the namespace can't be disabled, and
with nvmet_config_sem held across that, nobody can connect.

Take the pc_ref when the transport calls ->execute(), once all the data
is there: nvmet_parse_io_cmd() stashes the real execute method and
installs nvmet_pr_execute_io(), which gets the reference, rechecks the
reservation access since the host may have lost it since parse time,
and calls through. Preempt and abort then only waits for commands that
have started executing, which need neither the host nor the transport
to finish. A write whose data arrives after the abort now fails with
Reservation Conflict where it was previously executed, that's the
input the hang needs.

Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/core.c  |  2 +-
 drivers/nvme/target/nvmet.h |  4 +++-
 drivers/nvme/target/pr.c    | 42 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1ed250cd4b56e..4f6fb7c4181ab 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1176,7 +1176,7 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req=
)
 		if (ret)
 			return ret;
=20
-		ret =3D nvmet_pr_get_ns_pc_ref(req);
+		nvmet_pr_set_execute(req);
 	}
 	return ret;
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 7b429cc16d491..99b3bf5cbd3b6 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -513,6 +513,8 @@ struct nvmet_req {
 	struct nvmet_port	*port;
=20
 	void (*execute)(struct nvmet_req *req);
+	/* what nvmet_pr_execute_io() calls once it has the pc_ref */
+	void (*pr_execute)(struct nvmet_req *req);
 	const struct nvmet_fabrics_ops *ops;
=20
 	struct pci_dev		*p2p_dev;
@@ -1041,7 +1043,7 @@ void nvmet_pr_exit_ns(struct nvmet_ns *ns);
 void nvmet_execute_get_log_page_resv(struct nvmet_req *req);
 u16 nvmet_set_feat_resv_notif_mask(struct nvmet_req *req, u32 mask);
 u16 nvmet_get_feat_resv_notif_mask(struct nvmet_req *req);
-u16 nvmet_pr_get_ns_pc_ref(struct nvmet_req *req);
+void nvmet_pr_set_execute(struct nvmet_req *req);
 static inline void nvmet_pr_put_ns_pc_ref(struct nvmet_pr_per_ctrl_ref *=
pc_ref)
 {
 	percpu_ref_put(&pc_ref->ref);
diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 1a03f74c2e14f..798f5ce9011f8 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -1060,7 +1060,7 @@ u16 nvmet_pr_check_cmd_access(struct nvmet_req *req=
)
 	return status;
 }
=20
-u16 nvmet_pr_get_ns_pc_ref(struct nvmet_req *req)
+static u16 nvmet_pr_get_ns_pc_ref(struct nvmet_req *req)
 {
 	struct nvmet_pr_per_ctrl_ref *pc_ref;
=20
@@ -1072,6 +1072,46 @@ u16 nvmet_pr_get_ns_pc_ref(struct nvmet_req *req)
 	return NVME_SC_SUCCESS;
 }
=20
+static void nvmet_pr_execute_io(struct nvmet_req *req)
+{
+	u16 status;
+
+	status =3D nvmet_pr_get_ns_pc_ref(req);
+	if (!status) {
+		/*
+		 * The host can have lost its registration since the command was
+		 * parsed. A get that succeeds after "preempt and abort" has
+		 * resurrected the pc_ref has to see that. In percpu mode the
+		 * get orders no later load, so this pairs with the
+		 * smp_store_release() in __percpu_ref_switch_to_percpu(). While
+		 * the resurrect is under way the get is a fully ordered
+		 * atomic_long_inc_not_zero(). queue_work() in
+		 * nvmet_execute_pr_acquire() orders the unregistration before
+		 * the resurrect.
+		 */
+		smp_rmb();
+		status =3D nvmet_pr_check_cmd_access(req);
+	}
+	if (status) {
+		nvmet_req_complete(req, status);
+		return;
+	}
+
+	req->pr_execute(req);
+}
+
+/*
+ * "Preempt and abort" waits for the commands that hold a pc_ref. Until =
the
+ * transport calls ->execute(), the end of a command can depend on the h=
ost,
+ * which may still have to send the data, and on the context and the res=
ources
+ * of the transport. So a command gets its pc_ref only then.
+ */
+void nvmet_pr_set_execute(struct nvmet_req *req)
+{
+	req->pr_execute =3D req->execute;
+	req->execute =3D nvmet_pr_execute_io;
+}
+
 static void nvmet_pr_ctrl_ns_all_cmds_done(struct percpu_ref *ref)
 {
 	struct nvmet_pr_per_ctrl_ref *pc_ref =3D
--=20
2.52.0


