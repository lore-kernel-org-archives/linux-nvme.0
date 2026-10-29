Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3827F606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CzKmxCm9;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=YAUOoCdZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=a3aLfOsf8PzDzXysvYOcG5hJg/EYvNFDEMeMDjIslB4=; b=CzKmxCm9UdBjSU6Bwiu26cze0e
	DBUHZ0fzl1P7isM+4f6KK98thh6etTb1J4Y5VIwNbdfZMTiHc2Eyp3ULBAXUtVXZngcK+d2btEsKa
	ZEF8e79DUMA68BMnqXzaxMTwhCilNCQWob5hUJB6C7aFZjbTO//OS/l4LyeDNa/AWbdgMLmG3TjqU
	1P3dEkrULm0fbLxAEFN2kZeu3uszZkmM7h2kjnnOyrv1CX4Fee0dWEjUZYmY018aR5mWbUgiXYEjf
	fvUl39Gm7GOF31f4l1UBE1WXZehwwfOIojLu135EZPWZ/xHSBewSMNzg1Nsnng152YHGHsdCkFqIH
	jcXO5AWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRY-00000009gXM-2cMD;
	Thu, 29 Oct 2026 15:53:32 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRR-00000009gGn-3HVK
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:29 +0000
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TEoUvP1324344
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=a3aLfOsf8PzDzXysvYOcG5hJg/EYvNFDEMeMD
	jIslB4=; b=YAUOoCdZU8UnH8M1fn+2OtIgchS7dvSFuCsFmYl5Qz4vb8wpYUs+O
	63I+TEdudCjYbEfUvg4RWvKxeIxu71hMKC0HMIT1WLxQ3KWYSIaDN8/ivz0HwMm/
	1nSCr3k1DqJwOSZuuw+3b6YSQJBlGwJNa14l6BtajzripUzlr8BMZQNP8BWEE3cQ
	swRmTV90FT5riLNb+s8qFCVyxxSLWKtAXBjlfZZixi4txv3jGqDBqTDwYsCAlarx
	dA8SJoEeP39w+7E4TyFPF7fus2kLjWJUrZ0LXDq+KJlqGZtfi46CGU87PUe3Bs+L
	+KNdpWr1mh0lE0nuacz74DbbIfZWk4vng==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hm88vrjr4-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:25 -0700 (PDT)
Received: from twshared9449.02.snb2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:14 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id B7D112E22CEB7; Thu, 29 Oct 2026 08:52:57 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Chris Mason <mason@kernel.org>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 10/19] nvmet: move preempt and abort work off nvmet-wq
Date: Thu, 29 Oct 2026 08:52:43 -0700
Message-ID: <20261029155252.2332266-11-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX7GaeYrJbuSO9
 GJKSRoYe3PiesxDCeSNTcWeS/nBLe70mIW2odIf/FZEQM1OiCXJA3mKc4Tc8eokM6VTGAUsFrYf
 tBpKr6dTJSMJ03cF9/Cv4zvbu2vViZ8=
X-Proofpoint-ORIG-GUID: fzgvyrHKStn89hq2CDUDxNFK2s7g5_6A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX3ykT2jjGPBiS
 pOaLtQ5fE2dFCbfqAx5vzI6z5yZhl82D7HDnU/oyo7vOy95wTksJ2IjkhW0WAB6Le3cY9iWyazi
 Kn1LwrtWh3lSVRhIYT9aBXV9UUPw8sFz0wcfGh20x0zsGQmymsBg6iCiEptKBCFtB+P9HLdziCs
 8kAvGLalI4QcHChHIiXIAsJVp+o4jCfr5rRE6Q3HoPaLeraOBtXU2+AQEoBz2uCkiE0R+8jp9tz
 fKQLZA+hWKiFQ1v7D8Vj84/MBdjQ0ykdp144a86XEJX/QkVYwpMw0f3HWaXwfcKa+7J4nz6xs1O
 JZrKrYizzha5QVDQsMXbBsagU7ignPjoBocD6H22K2cjQf56jONk3lgVZKz6AYW10Ma1UprvME5
 aJ6ZCi0brwxclWQ3Q7RgX5h2N0b5FgGArEZAfXKvv+D/7y2IEjqAbeC74CjkLuV+RUno6gpjAh8
 DiAI/vx5fXb6vuZhU7g==
X-Proofpoint-GUID: fzgvyrHKStn89hq2CDUDxNFK2s7g5_6A
X-Authority-Analysis: v=2.4 cv=HKVWhYtv c=1 sm=1 tr=0 ts=6ae36bf5 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=VRxMdunAoUGt0ObhHIQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085325_877305_66C02A2F 
X-CRM114-Status: GOOD (  18.69  )
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

nvmet_pr_do_abort() runs on nvmet-wq, holds pr_sem while it waits for
the preempted controllers' I/O, and releases it at the end. nvmet-wq
also runs nvmet_tcp_release_queue_work(), which cancel_work_sync()s the
io_work of a closed connection, and that io_work may be sleeping on
pr_sem in a reservation command. So a host that keeps a write in flight
on a preempted controller, sends a second preempt and abort, and then
closes enough connections with a reservation command in flight fills
nvmet-wq with release works that wait for pr_sem. When the first abort
finishes, the second one is queued on a full workqueue behind them and
never starts, pr_sem is never released, and the accept work doesn't run
either, so nobody can connect.

Queue the abort work on its own workqueue so it starts regardless. The
release works can still fill nvmet-wq while pr_sem is held, and a
file-backed namespace's flush, DSM and write zeroes need nvmet-wq
themselves, so this is a mitigation.

Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/core.c  | 11 ++++++++++-
 drivers/nvme/target/nvmet.h |  1 +
 drivers/nvme/target/pr.c    |  6 +++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 27b27c83ff831..1ed250cd4b56e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -29,6 +29,7 @@ struct workqueue_struct *nvmet_wq;
 EXPORT_SYMBOL_GPL(nvmet_wq);
 struct workqueue_struct *nvmet_aen_wq;
 EXPORT_SYMBOL_GPL(nvmet_aen_wq);
+struct workqueue_struct *nvmet_pr_wq;
=20
 /*
  * This read/write semaphore is used to synchronize access to configurat=
ion
@@ -2018,9 +2019,14 @@ static int __init nvmet_init(void)
 	if (!nvmet_aen_wq)
 		goto out_free_nvmet_work_queue;
=20
+	nvmet_pr_wq =3D alloc_workqueue("nvmet-pr-wq",
+				      WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (!nvmet_pr_wq)
+		goto out_free_nvmet_aen_work_queue;
+
 	error =3D nvmet_init_debugfs();
 	if (error)
-		goto out_free_nvmet_aen_work_queue;
+		goto out_free_nvmet_pr_work_queue;
=20
 	error =3D nvmet_init_discovery();
 	if (error)
@@ -2036,6 +2042,8 @@ static int __init nvmet_init(void)
 	nvmet_exit_discovery();
 out_exit_debugfs:
 	nvmet_exit_debugfs();
+out_free_nvmet_pr_work_queue:
+	destroy_workqueue(nvmet_pr_wq);
 out_free_nvmet_aen_work_queue:
 	destroy_workqueue(nvmet_aen_wq);
 out_free_nvmet_work_queue:
@@ -2055,6 +2063,7 @@ static void __exit nvmet_exit(void)
 	nvmet_exit_discovery();
 	nvmet_exit_debugfs();
 	ida_destroy(&cntlid_ida);
+	destroy_workqueue(nvmet_pr_wq);
 	destroy_workqueue(nvmet_aen_wq);
 	destroy_workqueue(nvmet_wq);
 	destroy_workqueue(buffered_io_wq);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index a89b384c4bbc9..7b429cc16d491 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -528,6 +528,7 @@ extern struct workqueue_struct *buffered_io_wq;
 extern struct workqueue_struct *zbd_wq;
 extern struct workqueue_struct *nvmet_wq;
 extern struct workqueue_struct *nvmet_aen_wq;
+extern struct workqueue_struct *nvmet_pr_wq;
=20
 static inline void nvmet_set_result(struct nvmet_req *req, u32 result)
 {
diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 1c0d6cac1a6b3..1a03f74c2e14f 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -756,7 +756,11 @@ static void nvmet_execute_pr_acquire(struct nvmet_re=
q *req)
 	if (!status && acquire_act =3D=3D NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT=
) {
 		kfree(d);
 		INIT_WORK(&req->r.abort_work, nvmet_pr_do_abort);
-		queue_work(nvmet_wq, &req->r.abort_work);
+		/*
+		 * Not nvmet_wq: works on it can wait for pr_sem, which this
+		 * work releases.
+		 */
+		queue_work(nvmet_pr_wq, &req->r.abort_work);
 		return;
 	}
=20
--=20
2.52.0


