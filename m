Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D78CFA450
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aZpoqSywv8Y9migEf4XunN/74Y7OmlwA7xu+s9yo2v0=; b=DS/9Ml8AlbRA1JQRPH+BSaRMPF
	zz9Hr1UZuc1N+UJTN/PgXbSbHamo4eLs2VrY6EA1Q6DhC3L9tErn6y7KJBjJBD+2n7Yr2tX9DLbQ/
	bXbHQvD0jeFmTB0kdtdkzAQaQEFlNi2/wGpoQ0iqEpt2lUuGtS3KGUGHZkRw3BUevcjts6q9Vh/XO
	f65EuMaDEgQ/shWN+tj0KqtmyDBAmG5KVnkBk/xcfaPKBjhYVnXitoYdEtt/6+LjoOBFWV8/gpVy6
	FHdNJjkSgcdaWLOamhgHowAZhSMqDryYWxmgTcSEuOeqJATthb2z0Baz50v0/W5l+b9kBskyHkOHP
	UvplqPhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3e7b-0000000F7q5-3KKA;
	Wed, 23 Oct 2024 16:22:07 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3ddw-0000000F2Pr-08cc
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 15:51:31 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NCo6XT022598
	for <linux-nvme@lists.infradead.org>; Wed, 23 Oct 2024 08:51:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=aZpoqSywv8Y9migEf4
	XunN/74Y7OmlwA7xu+s9yo2v0=; b=c6IlPp458d8L+d14JkaslqGZq8oJgGq832
	4RrsA4NbnvXzT6258nlh4dM++fcBxyVaZOMvxQ/uYC0QWN2MhWbrg2ATXozGXoRC
	U31/y2ohe5WhzB0mXn3vE+XO5YVJBTV6uu1mbNXeZdLGKyVXlUI1oRrYaNTvOWUg
	Iadmd7YUIJmtZQ/B5mFNPQkDOTWsZsW9oVjHhM65hZQzUNNHZaZe5aZTBHd4+kVA
	Oif6tQHOi0E/IXu12JipoGnb/L/kwH0AE2aYCFYiDgaskJkj//FeS7TbObwHPcJ1
	qPp5R6NoaZVEDJRH405LAP5TuleMMcQn144jSRDJ+C3X6F21bVDA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42exswabw6-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 23 Oct 2024 08:51:25 -0700 (PDT)
Received: from twshared3293.08.ash8.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 23 Oct 2024 15:50:58 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 07A0C14662878; Wed, 23 Oct 2024 08:50:56 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <martin.petersen@oracle.com>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>, David Wei <dw@davidwei.uk>
Subject: [PATCH] nvme: module parameter to disable pi checks
Date: Wed, 23 Oct 2024 08:50:48 -0700
Message-ID: <20241023155048.634988-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: FSxHW0VfmnJfY2zOo5DsoCIx1tfo_9mh
X-Proofpoint-ORIG-GUID: FSxHW0VfmnJfY2zOo5DsoCIx1tfo_9mh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_085128_230846_8AA61E37 
X-CRM114-Status: GOOD (  14.27  )
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

A recent commit enables integrity checks for formats the previous kernel
versions registered with the "nop" integrity profile. This means
namespaces using that format become unreadable when upgrading the kernel
past that commit.

Introduce a module parameter to restore the "nop" integrity profile so
that storage can be readable once again. This could be a boot device, so
the setting needs to happen at module load time.

Fixes: 921e81db524d17 ("nvme: allow integrity when PI is not in first byt=
es")
Reported-by: David Wei <dw@davidwei.uk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba6508455e185..67f8125df96a9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -91,6 +91,10 @@ module_param(apst_secondary_latency_tol_us, ulong, 064=
4);
 MODULE_PARM_DESC(apst_secondary_latency_tol_us,
 	"secondary APST latency tolerance in us");
=20
+static bool disable_pi =3D false;
+module_param(disable_pi, bool, 0444);
+MODULE_PARM_DESC(disable_pi, "disable protection-information if used");
+
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -1763,6 +1767,7 @@ static bool nvme_init_integrity(struct nvme_ns_head=
 *head,
 		struct queue_limits *lim, struct nvme_ns_info *info)
 {
 	struct blk_integrity *bi =3D &lim->integrity;
+	int pi_type =3D head->pi_type;
=20
 	memset(bi, 0, sizeof(*bi));
=20
@@ -1777,7 +1782,10 @@ static bool nvme_init_integrity(struct nvme_ns_hea=
d *head,
 	    !(head->features & NVME_NS_METADATA_SUPPORTED))
 		return nvme_ns_has_pi(head);
=20
-	switch (head->pi_type) {
+	if (disable_pi)
+		pi_type =3D 0;
+
+	switch (pi_type) {
 	case NVME_NS_DPS_PI_TYPE3:
 		switch (head->guard_type) {
 		case NVME_NVM_NS_16B_GUARD:
--=20
2.43.5


