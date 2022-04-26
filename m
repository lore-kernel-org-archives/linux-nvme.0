Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B8AC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 18:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ggZmwkwKypSDiS4yhtI8TJjcFYQbbXlExtLkqn+x1w=; b=oqqc8r+kOkpt2QjwkxnIpJOyDH
	HlvUyl1+ncuWYBV8oRUEiFngCDoqxOD/zLCzMRAr2eBlPWI3Mbcn3oT7Rs37xESHSfdONzAGbPUKx
	MsB0Hhh1LdqaedzhPPZjfAYfdPAFGFE66rx3fNDTlwFn8iZqdLls1oUIGumZWmRKhCu59vVNKQxKw
	oxqyQtSW8BIkOuQWdtwf3q6Sojdr+mY8gN9HAF4/0fLigv6IJDJSwbHNjwuilaZYn3uPQJXPVzdzr
	MOiV4K3GucO1+BWpIOaYxGAd3Tp/hdWfJuTdWTsCVsXrAvfkp1YTdwAxs+IVOzqtFMdm0zCRhZIVc
	k24OuyBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njQ0U-00Fke2-EX; Tue, 26 Apr 2022 18:33:50 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njPpa-00Fg0S-97
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 18:22:38 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 23QGQSga018712
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 11:22:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=0ggZmwkwKypSDiS4yhtI8TJjcFYQbbXlExtLkqn+x1w=;
 b=FD14C0ceS0kapUkGA3FqtvPVaO5uR9VVkzWVcr23Qd37/iaIDYPIijTmfFfJFD0DVpgZ
 Ix7OLrukm/y38NVwFerAguvc6XQezhKOJptQzBmRPivHbLqqNUnDtc8ibEACWCZpGVTf
 bI042ZeL/bWWYXfBaVZT65y9GMagK0d+7pc= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by m0001303.ppops.net (PPS) with ESMTPS id 3fmd4rv7n5-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 11:22:33 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub202.TheFacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 11:22:30 -0700
Received: from twshared6486.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 11:21:46 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
 id 49E20E2E5690; Tue, 26 Apr 2022 11:21:36 -0700 (PDT)
From: Stefan Roesch <shr@fb.com>
To: <io-uring@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <kernel-team@fb.com>
CC: <shr@fb.com>, <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 02/12] io_uring: store add. return values for CQE32
Date: Tue, 26 Apr 2022 11:21:24 -0700
Message-ID: <20220426182134.136504-3-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426182134.136504-1-shr@fb.com>
References: <20220426182134.136504-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MMt5Pv_DrnOsPcQD08iGQ5v45yi7PAN1
X-Proofpoint-GUID: MMt5Pv_DrnOsPcQD08iGQ5v45yi7PAN1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_05,2022-04-26_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_112234_504197_197D8768 
X-CRM114-Status: GOOD (  16.58  )
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

This reuses the hash list node for the storage we need to hold the two
64-bit values that must be passed back.

Co-developed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/io_uring.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4c32cf987ef3..bf2b02518332 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -964,7 +964,13 @@ struct io_kiocb {
 	atomic_t			poll_refs;
 	struct io_task_work		io_task_work;
 	/* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll */
-	struct hlist_node		hash_node;
+	union {
+		struct hlist_node	hash_node;
+		struct {
+			u64		extra1;
+			u64		extra2;
+		};
+	};
 	/* internal polling, see IORING_FEAT_FAST_POLL */
 	struct async_poll		*apoll;
 	/* opcode allocated if it needs to store data for async defer */
--=20
2.30.2


