Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45769C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 27 May 2022 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UmvSBQAyd9Hi305jVIfNZFIiIb8ezzbbr9WK2GM8Kmo=; b=BtD9r/xx4jIrfAkgGRWDYKamVj
	eObzHhdp8nzdAn9ospQ+gGn1f6tGNiXcRQXbi/nwlFponAeW2rrVB5uyxLxPSwaNixxaFnGe0f9VS
	Wge/LlpSDdhFnPDdsbrL4u0zt1R8iNOb+TNSiL7qj7/fSCFLAW0DPA5FZ+v6kktAqMy8iCThFuhOI
	92G4XL2XzASLl09N/nz2FQk/YQsaq0P3Iuf2W6/fA3JHgII6Kt6QrahJAlWRUHTB+ddltExqQVBb+
	kMhQSQT7S+r9sP+eUQzyb7cg1XmVzJg+BxQKvFiMv7O3gma90cweNUC+5YSamVDr3+9IH7s7vVZH8
	lWsh+KdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nudjV-000fJS-Fg; Fri, 27 May 2022 17:26:41 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nudjT-000fJ8-7p
	for linux-nvme@lists.infradead.org; Fri, 27 May 2022 17:26:40 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24REfvFi009264;
	Fri, 27 May 2022 17:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=UmvSBQAyd9Hi305jVIfNZFIiIb8ezzbbr9WK2GM8Kmo=;
 b=SMVwLRPvL7mDTFGuQ+I5Xrc80NnnZzpKCfilwPz/Lv1HPFaVf3zauSw2UvShMsbpi9Tf
 W1QtjHR8bwZIJW3kbncQbItVwZ4E1XPEmyNtv4rxX9LwnS4cUyebPEpPGcrmWeJrsDY5
 ttMcY8UdfWRbSeDugFm87YfZVZpyC3BMHSFFukgiQhOwmQhCmxAekdZSyPjkZu5FaGLz
 SkRWYJm4fu4TUMxe3uBp+K4ZOJk4gREzd+TE768cR6ouIuBNvBhA/H+juBsYpOMRQ1h7
 yy4R4CIkzerjNSC0iUgkgbWxUaKK615qOmFLA8bvBHkCcX/EwouLW1eOmUNYln5urlpz hQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gb0mn3aht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 May 2022 17:26:33 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
	by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24RHL8vt018367;
	Fri, 27 May 2022 17:26:32 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by ppma04wdc.us.ibm.com with ESMTP id 3gaenbq0mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 May 2022 17:26:32 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24RHQV0E63570318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 May 2022 17:26:31 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CE8CAC068;
	Fri, 27 May 2022 17:26:31 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0233AC0A4;
	Fri, 27 May 2022 17:26:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
	Fri, 27 May 2022 17:26:30 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: hch@lst.de
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, hare@suse.de,
        wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH 1/1] nvme-multipath: show wrong nvme ns after dlpar a nvme device
Date: Fri, 27 May 2022 10:49:37 -0500
Message-Id: <1653666577-3733-1-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RGwb994MpoY8C1XeCGe0_oO6al3isD6Q
X-Proofpoint-GUID: RGwb994MpoY8C1XeCGe0_oO6al3isD6Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_04,2022-05-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=845
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205270083
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220527_102639_551892_4B38425A 
X-CRM114-Status: GOOD (  18.75  )
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

From: Wen Xiong <wenxiong@linux.ibm.com>

If we have an active partition/namespace on nvme device, nvme device driver
won’t release these controller IDs/Namespaces IDs when dlpar remove.
So we got the wrong nvme devices names if nvme device driver still use old
subsystem id as controller id when dlpar add it back. We expect to see new
nvme devices with new controller IDs/Namespace IDs.

For example, we have a nvme U2 device with 4 namespaces in linux,

After system boots up,
Controller id:  0
Subsystem id:   0
namespaces ids: 1, 2, 3 and 4
nvme devices  : nvme0n1, nvme0n2, nvme0n3 and nvme0n4

Dlpar remove with active partitions on nvme0n1,
Controller id :   ID=0 still hold reference, ID=0 won’t be removed,  but /dev/nvme0 not exists anymore
Subsystem id :    0(nvme-subsys0 still exist in nvme list-subsys)
Namespace ids:    ID=1 still hold reference, ID=1 won’t be removed, but /dev/nvme0n1 not exists anymore
Nvme devices:  all nvme devices are gone in /dev

Dlpar Add back
Controller id:  1
Subsystem id :  0 still use old controller id=0
namespaces ids: 2, 3, 4 and 5
nvme devices:   We saw "nvme0n2, nvme0n3, nvme0n4, nvme0n5" in /dev
                /dev/nvme0 not exist anymore,
                We expect to see: nvme1n2, nvme1n3, nvme1n4 and nvme1n5

The patch fixes the issue.

Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d464fdf978fb..945974ceef3c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -495,7 +495,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	head->disk->fops = &nvme_ns_head_ops;
 	head->disk->private_data = head;
 	sprintf(head->disk->disk_name, "nvme%dn%d",
-			ctrl->subsys->instance, head->instance);
+			ctrl->instance, head->instance);
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, head->disk->queue);
 	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, head->disk->queue);
-- 
2.31.1


