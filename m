Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AD5CD98D2
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=482+rx7pETF3THliVAeXcE/AnoGqEywTilqtWkrs5BE=; b=fa1eLgAUm1jVMhcT15nXTS63nK
	FmGmGhNZ4eFgT9bYWQ7fGXm7a/HEWeupcCU75wWbFlzJKC/ksdcZZf5cZZMg9AHIlpMVTtq6sQybk
	70Q5dIoYrl0cU0rUUJ3fll4eV+g+gMUgOV1Cdo+HnxLi2obzdteG2qtAb1ty+tjEq6Rs79vUnsbRD
	Vh654PjzW5jEI3pD+ZqtxJ++88ZxYdgIRlZgOVodOm9TaXEymlbv6OhQuVQ7HWShI+tKF1Zd3C15G
	7FXOshpDhTd9B3XzvfS/ym3eDDBHGosuKTpP5tTditS8sDlhNgXCUpOG17HxurcaQAS+Jifl0hG0u
	Jv1rvpzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhq-0000000D1JV-3UMr;
	Sun, 14 Jun 2026 13:16:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhl-0000000D1Bk-2NOu
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:53 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECn7293522370;
	Sun, 14 Jun 2026 13:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=482+rx7pETF3THliV
	AeXcE/AnoGqEywTilqtWkrs5BE=; b=MhUEHm0IAnD0qiovk3B7le4gA57OJmsIE
	mL4WEM+5JrbDmYIP62BcKuRsC73LsTIOHqV7cIBlmwP6+4Tglld0h/OAgCvWGX9G
	b1Yf1DeIVu3hI4drbr5SCzU0o8j5fj31+N+WWk/22Q9UtYZO5ROHrqVnEdEzLkrH
	ITWKqPPt0Op4VzK3Gxa2YjqJvETlqyLmQzVEiosB6nvny7rIduHDFip1KgpPVhxJ
	3KzhnuKyr6NEQspvdRwnUy+vG7QAr8AGqMRlv68LoGqFrLgwFb7baOdUQeaCff95
	XCrI1a+1V6/syYgpQnnKzkyIxr0xm3oMLFO5F+7916EErvyCJY4vg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0b9vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4aW5018127;
	Sun, 14 Jun 2026 13:16:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvsrjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDGagx15401346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:16:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 760BB20043;
	Sun, 14 Jun 2026 13:16:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B32BA20040;
	Sun, 14 Jun 2026 13:16:33 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:16:33 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 15/17] nvme: add Clang context annotations in tcp.c
Date: Sun, 14 Jun 2026 18:45:30 +0530
Message-ID: <20260614131541.2017845-16-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: HuS83iaIYThgpxqDndyKw4oXrsgKkNaa
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a2ea9b9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=TfvOO_zgRogsC6GeyRwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX9Jub9UZrshHH
 GbJP0JGi+dvzcri50IWsAgueP4eY931up7DAXBNJKDdk5l3AUWfuRk8X01mrzeGRleGII9P7eQY
 O2BOgH2rDG4Ga4kZavweWre1FDkoQ63VxCZ+DghPb4QzewI8l/4ZzW9ltqJobuN9xVdVj/4CEYo
 eS2KTEYHqDgJAedKh/LVzJmFYeqg4zhp63kQsvK5zNN5kqQdokH4rwOoM9JHk5czCvaZhnYO4u1
 +wAUoQDy30Pf23eyEQwT2FyBVMaq8SZkZ3rnnRVRoXetTVVlxo0eKb+RyK3uyrVdluLSa4kSzUT
 +BYR+yAR1FbtIAsWKp+U/J8DS8M61gN5XwsKBCGVQLc47G6URiPaI+Pa/39JAFlsbrnDHDtDE77
 bv3nKw9v020ynsCQzf8Bhs+o4rQlpIz/6o2fGaX14cgi+xOIHdqiWfH3vVzwYzrr0hhJT4hP0BG
 YxWYiunQNkg6Rj2+wdw==
X-Proofpoint-ORIG-GUID: TcEp6qERzbBlofVgF1W44brM2tZ7guNP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX3+BXvpNgiyqU
 2kfs8sfkGX8g1VsbD3AIdC7wd7lD/UAUFOd1egQPaOjFf/38S0c0XAcTUJ2XgIWiCoWvhqLoLQd
 XXTQlXOoKhQ2kPPBS1gaP4GcN38uuDQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_061649_733555_9277A535 
X-CRM114-Status: GOOD (  18.00  )
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

The nvme_tcp_ctrl_list and nvme_tcp_ctrl::list are protected by
nvme_tcp_ctrl_mutex. Annotate both with
__guarded_by(&nvme_tcp_ctrl_mutex) so that Clang's context analysis
can validate accesses against the corresponding locking requirements.

It is safe to initialize nvme_tcp_ctrl::list while allocating the
controller object because the list entry has not yet been added to
nvme_tcp_ctrl_list. Annotate the initialization with context_unsafe()
to suppress the corresponding Clang warning.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/tcp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 68a1d7640494..c4662ccb5c49 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -182,13 +182,16 @@ struct nvme_tcp_queue {
 	void (*write_space)(struct sock *);
 };
 
+static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static __guarded_by(&nvme_tcp_ctrl_mutex) LIST_HEAD(nvme_tcp_ctrl_list);
+
 struct nvme_tcp_ctrl {
 	/* read only in the hot path */
 	struct nvme_tcp_queue	*queues;
 	struct blk_mq_tag_set	tag_set;
 
 	/* other member variables */
-	struct list_head	list;
+	struct list_head	list __guarded_by(&nvme_tcp_ctrl_mutex);
 	struct blk_mq_tag_set	admin_tag_set;
 	struct sockaddr_storage addr;
 	struct sockaddr_storage src_addr;
@@ -200,8 +203,6 @@ struct nvme_tcp_ctrl {
 	u32			io_queues[HCTX_MAX_TYPES];
 };
 
-static LIST_HEAD(nvme_tcp_ctrl_list);
-static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -2910,7 +2911,10 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
 
-	INIT_LIST_HEAD(&ctrl->list);
+	/*
+	 * Safe to init list while allocating ctrl object.
+	 */
+	context_unsafe(INIT_LIST_HEAD(&ctrl->list));
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
 				opts->nr_poll_queues + 1;
-- 
2.53.0


