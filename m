Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4967C43602
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KzKjfiOm8C5ofWaZarKqIxzGPOR4iEIRQYAY15MYzQY=; b=QoPpy3Os3Pwp1MAAnhOtwr7BgI
	o1hM+LAttTLSOdEnvxOd97+6o5kgAVvVP+cZLguy1TAZHAdB83nYuNXhK8VTUa44bfav1N4xsaHkN
	b8ydLwmJvxd3U3c2sxSZZXvZJOwMQ9I2VTjg6yLxos0pInYoSoDNZoHe3A3nOq/YpX/l+ShdDaaQ2
	nb0h/OMw+deLtptSid0V0Kipmli6jAfUowmL6829Nukju6Xd2BoUwUDNfUe6abBSCyz79NGhVm5Gv
	89Tqc1Yg5kftdoHyB71iw2lTiIPFHy934rzUCXAHFtvRfsPC06TtrwJodT4O5VaOwAxG2tTgib904
	YKmRwrqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7V-0000000CiJe-0zGP;
	Mon, 06 Jul 2026 14:16:25 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7S-0000000CiG6-0oFi
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:16:23 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIL2C007623;
	Mon, 6 Jul 2026 14:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KzKjfiOm8C5ofWaZa
	rKqIxzGPOR4iEIRQYAY15MYzQY=; b=HQeZkMgk+H1ljF6U+aNxSB1So4H+EPzRz
	ue8X/bcEZ/g/Y4nqDvujNuG+TJwkRXj18XCLCyWkWCPAYeEQPZaQBN8EKMbv/Jej
	g99F4BDgwhNkGFm3Zzs7e21BNATBAz4PfGmeNq5tUxMkX90k+dg4Au5wzCmdm2CF
	/pH5hiZLIGUuSz/pyLOVC+9RwSn7kMNqXC8Wn2krhJO4zik8Tp0XkQ+XzUvHLtOW
	arHbPlIbDtr7ExsZ4u0k1nY70NG/7QAjxaifW4N/A+brvcgsPnwRfuMgW8YZyvfc
	fdUsuXv+GlRn3ESfQSVjamfXmA4IsMitP99zAnTsjGgBpXy67K80Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3huru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4o5Q031559;
	Mon, 6 Jul 2026 14:16:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h5tk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EG8mu52691436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:16:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A90720043;
	Mon,  6 Jul 2026 14:16:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66A4B20040;
	Mon,  6 Jul 2026 14:16:06 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:16:06 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 13/18] nvme: add context annotations in rdma.c
Date: Mon,  6 Jul 2026 19:44:15 +0530
Message-ID: <20260706141452.3008233-14-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4bb8ae cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=pOGEuHxQbtI5uFpJoR8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX5hkndFe6nNBK
 PKl6kfSaolQE2L4cYTwIWYUDarpRAemYgrdBt2GT6oa1MCLHI9UiicGLYT3RKlKnRCEI8qHUSqD
 QB81UfFMBdCGTZCaKH6kcilSKx9hQ+w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX8TXRX9/98s05
 /cBeo+ttZ6JkGWtcba0J4EmMQO+P31oCcrERWpDGylmrwM6qlqH6SZj14WfrK9cnIL+0gTNVyIT
 i3IhdcRb3SFYDTsjP9Ku7nh1121/rcVfWCHDhWcJdKGo4+2U0TIGUJQMFE1xjgqKWM4JvXiw9mx
 H4rkwpg4YXasiU1weSnD83WJPQGIMrdpo1lfls6NTu8Cbtzi0qiSOTJz+NnqQ2ne+JGjb4kAzHB
 Iaug2E5MfqrvDXBJUp3BN+R9XMoApM6zm15RmFWzFFqq/mUB4BjyhN/hsvRNvo1Sj/6zUFOgJ7x
 oqSHQDUCeSGRS1jETdgIdw6lDwNaTV2rqXpiYwPWBdlkrXoK0bc2C4bqkINQTiGv4LXfh4+7mUv
 wwMRsyZ81E7Hr2pLG7LIR4x2r15HAtOS9Yc7xHh42XKz+MhJzGaTqcy03ekvA1k63o5gkZmzQtr
 0SUf4ottiNtUEXknfQQ==
X-Proofpoint-ORIG-GUID: Nmsu7_GBFUV67bnF7WHUxqBbb5ttKCNK
X-Proofpoint-GUID: P3UkbellE2rKRiO44oNiQ4-FQuYPkfk8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_071622_250199_1F38E468 
X-CRM114-Status: GOOD (  18.17  )
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

device_list and nvme_rdma_device::entry are protected by
device_list_mutex. Define device_list using
LIST_HEAD_GUARDED(device_list, device_list_mutex) and annotate
nvme_rdma_device::entry with __guarded_by(&device_list_mutex) so that
Clang's context analysis can validate accesses against the corresponding
locking requirements.

Similarly, nvme_rdma_ctrl_list and nvme_rdma_ctrl::list are
protected by nvme_rdma_ctrl_mutex. Define nvme_rdma_ctrl_list using
LIST_HEAD_GUARDED(nvme_rdma_ctrl_list, nvme_rdma_ctrl_mutex) and
annotate nvme_rdma_ctrl::list with __guarded_by(&nvme_rdma_ctrl_mutex).

It is safe to initialize nvme_rdma_ctrl::list while allocating the
controller object because the list entry has not yet been added to
nvme_rdma_ctrl_list. Annotate the initialization with context_unsafe()
to suppress the corresponding Clang context analysis warning.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/rdma.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..bf392035037a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -39,11 +39,18 @@
 #define NVME_RDMA_METADATA_SGL_SIZE \
 	(sizeof(struct scatterlist) * NVME_INLINE_METADATA_SG_CNT)
 
+static DEFINE_MUTEX(device_list_mutex);
+static LIST_HEAD_GUARDED(device_list, device_list_mutex);
+
+static DEFINE_MUTEX(nvme_rdma_ctrl_mutex);
+static LIST_HEAD_GUARDED(nvme_rdma_ctrl_list, nvme_rdma_ctrl_mutex);
+
 struct nvme_rdma_device {
 	struct ib_device	*dev;
 	struct ib_pd		*pd;
 	struct kref		ref;
-	struct list_head	entry;
+	struct list_head	entry
+		__guarded_by(&device_list_mutex);
 	unsigned int		num_inline_segments;
 };
 
@@ -112,7 +119,8 @@ struct nvme_rdma_ctrl {
 
 	struct delayed_work	reconnect_work;
 
-	struct list_head	list;
+	struct list_head	list
+		__guarded_by(&nvme_rdma_ctrl_mutex);
 
 	struct blk_mq_tag_set	admin_tag_set;
 	struct nvme_rdma_device	*device;
@@ -132,12 +140,6 @@ static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
 	return container_of(ctrl, struct nvme_rdma_ctrl, ctrl);
 }
 
-static LIST_HEAD(device_list);
-static DEFINE_MUTEX(device_list_mutex);
-
-static LIST_HEAD(nvme_rdma_ctrl_list);
-static DEFINE_MUTEX(nvme_rdma_ctrl_mutex);
-
 /*
  * Disabling this option makes small I/O goes faster, but is fundamentally
  * unsafe.  With it turned off we will have to register a global rkey that
@@ -2254,7 +2256,10 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
 	ctrl->ctrl.opts = opts;
-	INIT_LIST_HEAD(&ctrl->list);
+	/*
+	 * Safe to init list while allocating ctrl object.
+	 */
+	context_unsafe(INIT_LIST_HEAD(&ctrl->list));
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
 		opts->trsvcid =
-- 
2.53.0


