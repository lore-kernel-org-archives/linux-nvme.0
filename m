Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37E9CD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 06:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=j/wevI1sLg8S2EbmVtTC+VPPuMKDhyu9mvjQNOPePrA=; b=cRU+Cgdl8WQWFUpIH1nzhqUXTZ
	FqcZuLJ44slqDeY+UQnekawueUvsAFTTc83sbyFKt8bIZj3BIqtpwN4jK+9ZzJxOGefAeSdwG1dxk
	EUd8FRWQfIkjpK4XnX7qxmb6xgFvnVXR7Pa992TDhopvWdfYScYgL0ilHrPNgGcJfICcmw0UYgeOG
	nLZs5s4pKyl5t+ChcDTZ/gOTdRdbpqXlRCxSmrG/adF1xWEIUnLKTCdaT8aoKUlsfz+WSpyyTyyxk
	sJ4ldTJN0n5TEffZUeBWUpNzD1gqHQRuoKxWOBMIWrLVMeJFFbphzI5tLq4P5Zlq7QsnDMC4cKwHS
	LpvgRoxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS7dE-00000003OIJ-460G;
	Wed, 27 May 2026 06:20:44 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS7dC-00000003OHn-3GW6
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 06:20:43 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QL4Rea735199;
	Wed, 27 May 2026 06:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=j/wevI1sLg8S2EbmVtTC+VPPuMKDhyu9mvjQNOPeP
	rA=; b=Z+aJlnVhmScBduGJVPfa9/ytXidwCuvgo1EgyLcsEaAq+o5cTebH04ZGh
	KASBlF+ED5L5IHkEXcMni6ICSOrBcf/enqqRrkvMF6oRawMkSL8RvBCyDrKnMGiV
	FDfpLbYcCjqOmjTV6HD9Bos/C4w4IJbSv6T5N0PqEXIbqOgHa9M+YReEi8Q2Osk5
	iLGiolvaVYBcF123RVE1HKZrPWc6aPYouDAuuRNiaIfQnzaYsY6QkWCJseqBJbgl
	QkM5mg9pO3ySORmEJT7MQEiFECObuJJzQ5W201FxE2RK+g3Jx8gW4FeqETTeTVFO
	Oygxui7mN2vVvMGSfjsu0JyHOYQ4g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nc6pd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 06:20:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64R69DwE014116;
	Wed, 27 May 2026 06:20:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb1p1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 06:20:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64R6KNft52363684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 06:20:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A85D2004B;
	Wed, 27 May 2026 06:20:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8379F20040;
	Wed, 27 May 2026 06:20:21 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 06:20:21 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, sagi@grimberg.me,
        gjoyce@linux.ibm.com, mkchauras@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH] nvme-multipath: fix flex array size in struct nvme_ns_head
Date: Wed, 27 May 2026 11:50:00 +0530
Message-ID: <20260527062010.4036702-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a168d2c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=HqYaFTBhK8PxBfYp4pkA:9
X-Proofpoint-ORIG-GUID: J3Yg43ITBWFoen-3ItjNWMMOTS4agiTl
X-Proofpoint-GUID: J3Yg43ITBWFoen-3ItjNWMMOTS4agiTl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA1NyBTYWx0ZWRfX+PlmysTUUa5V
 rtAEHYIPcT2pi9XedpmLOeVyuSvp0fVcq84FSjQMHAkPawrKT79Lyq4y154RB4v/c7d704rZUk9
 4Yk2M+Co2Tu9bMfFzcHMUV7Kmcx92bTcez7FEM2+bqe11yZzqi6Agdm65yAp89kLIcVJTIAaKJm
 WYwcERw/+mnYhyzfqDRkc/ahSXpjkol1vYkVh5WTf++CE48OyOyb5V1DTMHceyVV1ypErZ3X1BM
 Uv4BOV8dw9tNj+OBoyZVpvet+7QwWYTJNXGgcs0+xliSLte06e/g4vzzb3/naFUm/OB4/j+Y7nc
 uOU2cWFDsfLidQR1Vcd5+xv78b3c02u9EqSHt0OxANKML7G3vT3Pmy+zMKr7jK45HWicWRvHLU7
 n0iDcp2J3f2JA98nVYH+PWhHW5C/dq+rFuqTn7V4hnQZQKrfqMpB6ju0OnIPQAkL97VaHXJfJiL
 IIp8YXQgF2fhkaY6w8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_232042_938626_E4FA5401 
X-CRM114-Status: GOOD (  16.76  )
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

struct nvme_ns_head contains a flexible array member, current_path[],
which is indexed using the NUMA node ID:
head->current_path[numa_node_id()]

The structure is currently allocated as:
size = sizeof(struct nvme_ns_head) +
       (num_possible_nodes() * sizeof(struct nvme_ns *));
head = kzalloc(size, GFP_KERNEL);

This allocation assumes that NUMA node IDs are sequential and densely
packed from 0 .. num_possible_nodes() - 1. While this assumption holds
on many systems, it is not always true on some architectures such as
powerpc.

On some powerpc systems, NUMA node IDs can be sparse. For example:
NUMA:
  NUMA node(s):              6
  NUMA node0 CPU(s):         80-159
  NUMA node8 CPU(s):         0-79
  NUMA node252 CPU(s):
  NUMA node253 CPU(s):
  NUMA node254 CPU(s):
  NUMA node255 CPU(s):

That is, the possible/online NUMA node IDs are: 0, 8, 252, 253, 254, 255
In this case: num_possible_nodes() = 6

So memory is allocated for only 6 entries in current_path[]. However,
the array is later indexed using the actual NUMA node ID. As a result,
accesses such as:
head->current_path[8] or
head->current_path[252]
goes out of bounds, leading to the following KASAN splat:

==================================================================
BUG: KASAN: slab-out-of-bounds in nvme_mpath_revalidate_paths+0x22c/0x290 [nvme_core]
Write of size 8 at addr c00020003bda35b8 by task kworker/u641:2/1997

CPU: 1 UID: 0 PID: 1997 Comm: kworker/u641:2 Not tainted 7.1.0-rc5-dirty #14 PREEMPT(lazy)
Hardware name: 8335-GTH POWER9 0x4e1202 opal:skiboot-v6.5.3-35-g1851b2a06 PowerNV
Workqueue: async async_run_entry_fn
Call Trace:
[c000200037fa7510] [c0000000021c23d4] dump_stack_lvl+0x88/0xdc (unreliable)
[c000200037fa7540] [c0000000009fda90] print_report+0x22c/0x67c
[c000200037fa7630] [c0000000009fd508] kasan_report+0x108/0x220
[c000200037fa7740] [c0000000009fff48] __asan_store8+0xe8/0x120
[c000200037fa7760] [c008000018e76474] nvme_mpath_revalidate_paths+0x22c/0x290 [nvme_core]
[c000200037fa7800] [c008000018e6556c] nvme_update_ns_info+0x4a4/0x5e0 [nvme_core]
[c000200037fa7a50] [c008000018e66270] nvme_alloc_ns+0x6d8/0x1a70 [nvme_core]
[c000200037fa7c20] [c008000018e679fc] nvme_scan_ns+0x3f4/0x630 [nvme_core]
[c000200037fa7d10] [c00000000031f22c] async_run_entry_fn+0x9c/0x3a0
[c000200037fa7db0] [c0000000002fa544] process_one_work+0x414/0xa10
[c000200037fa7ec0] [c0000000002fbf00] worker_thread+0x320/0x640
[c000200037fa7f80] [c00000000030d0f8] kthread+0x278/0x290
[c000200037fa7fe0] [c00000000000ded8] start_kernel_thread+0x14/0x18

Allocated by task 1997 on cpu 1 at 35.928317s:

The buggy address belongs to the object at c00020003bda3000
 which belongs to the cache kmalloc-rnd-15-2k of size 2048
The buggy address is located 16 bytes to the right of
 allocated 1448-byte region [c00020003bda3000, c00020003bda35a8)

The buggy address belongs to the physical page:

Memory state around the buggy address:
 c00020003bda3480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c00020003bda3500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>c00020003bda3580: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
                                        ^
 c00020003bda3600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 c00020003bda3680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

Fix this by allocating the flexible array using nr_node_ids instead
of num_possible_nodes(). Since nr_node_ids represents the maximum
possible NUMA node IDs, indexing current_path[] using numa_node_id()
becomes safe even on systems with sparse node IDs.

Fixes: f333444708f8 ("nvme: take node locality into account when selecting a path")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3032d6ad6b1..96809227a0e2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3926,7 +3926,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	int ret = -ENOMEM;
 
 #ifdef CONFIG_NVME_MULTIPATH
-	size += num_possible_nodes() * sizeof(struct nvme_ns *);
+	size += nr_node_ids * sizeof(struct nvme_ns *);
 #endif
 
 	head = kzalloc(size, GFP_KERNEL);
-- 
2.53.0


