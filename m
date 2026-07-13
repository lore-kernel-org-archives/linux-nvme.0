Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA2AC44507
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2fn2gtZrJrMBMygP2UI2ix/dHIlz0KNp+E6gd6CEnxw=; b=Gpr15GijYItlxnapJvhtIU/ZHs
	B6ZBISqFMdZJmOktZQGF4XcPkkgQZVqZz8iVKfmPq7yS7J7FjnDi+E68qWHpZ2BTNgwMhXrX2aC6f
	f+1Zy739tl6Z/Ge8nY9NCecww/CYggqwyVDQWsLcJHkoU+E54sqOjX+XvE96rEDuE6VtqM/NZ7LSy
	nFBjvloESzHhBwieBxUOpfh2BHDjibLVFSv4RZRx4DAjgHjNaFpoNRHzrfByJjDj8tE0xPT7ZGv2X
	SpmimN96S1AWqMTA/WElkV8+Xs60pjwmaUolLFqdi+8TMHRX2XLnnvI6yDxsr3aCYseusVv2/OWlr
	Aa2vuRjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFGB-000000094to-2ZnB;
	Mon, 13 Jul 2026 11:55:43 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFG7-000000094mx-1hf7
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:40 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6fsTP1668576;
	Mon, 13 Jul 2026 11:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2fn2gtZrJrMBMygP2
	UI2ix/dHIlz0KNp+E6gd6CEnxw=; b=miyzMrOmO7LF5cJwL3mUr0VKTaAE1XJpG
	NR6Rd/vRCO4TkYidPQWZmTS3C1Un8GEYr+ZEFX5Vus0+z/wgTv/BL+Kpis42OzJe
	O1GsSGyAlRhiUvEfS+rgzm57hHgdqAVEGWXgJbztJEEEfUx5IxwnVyFRpx1tOfs7
	P9+7fAaOPA57ci6iXXhndhTz6kG15QqPn2VnT2uvgUKY2oBSldCyd0QClBkrSy+p
	Ig4Odtr2pnLYiHuSkNvv263+Fy9FGVZ9NP+aDXxnojJBW6zrOAhTUnHkgUSlYamE
	ilaGLoGGnqEZQEnCXP2z7yp0xUgoSM/jjODGOT43pX7oJQueblkBQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwg1vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBnuoH010517;
	Mon, 13 Jul 2026 11:55:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxw6es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBtRMn48562662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DFCF2004B;
	Mon, 13 Jul 2026 11:55:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A58520040;
	Mon, 13 Jul 2026 11:55:25 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:25 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 14/20] nvme: add context annotations in fabric.c
Date: Mon, 13 Jul 2026 17:24:15 +0530
Message-ID: <20260713115444.465704-15-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Cdz1jkgVFV0lNI72_gdtIRUNMDfb6skb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX52Qf0Ci/6qtJ
 BNrZ/5yupAnRANuIAmrmQvkGcfd2DFMNq5jZjay+WgbVKiFbsgklWtMK1IauB5kyPQ1lpPbJzvs
 sWbT2EDWklW6E6bqJR8psCpQRqdDQzf1lXsI/nYVBswW3/V0F3TUgSDB6Zx7QaPNHeO/1bnLP1O
 9H15w3l72Zm7y6JplQJ/JeDlwYvtrs4ZmHMTDf1bPxW+nh/H/ib5z5vIPrpZpGfxjPC8YnRAy0t
 deOMG4f9garDipgL8IrOYFCQJYQ5OHerDXt5ixmvwkfpwlfZ/wnzL+SbdVgo+Cgp5FlOdjJ3HQL
 dt4JWa7jx0udw12+YxlEPivf/jGGa6FsfQyJn5UO/FMb9UPCGuNbZ3147uRCGTFEvxot2qmojF6
 Lpr/mKTZwK8s8Qg+L+9FlG/QY20JVRrqBoKxd4ODhosQeMwRo4OpfRJDnmDxoyur0BdfGVtWd/P
 NEtrYiJMO7SFFgic1WA==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a54d234 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=-W7SLkP_sVXSNSbjlKUA:9
X-Proofpoint-ORIG-GUID: 8UYGcwGA6qjeYPr48lyrH7mN_iqtU4-J
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfXwoCD5/+hoRjZ
 yf4yIP+rOMGZ5w7imHzzygioosJC2wRqcA7fbiYeQureIV4jLhOXH8GS0yW0+f1xKa7l/19BVqG
 3DDKW6do4qi8/2SSR/lNzAaFP2BzJPI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045539_594978_AF491BF7 
X-CRM114-Status: GOOD (  13.89  )
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

The global nvmf_transports list is protected by nvmf_transports_rwsem
and the global nvmf_hosts list is protected by nvmf_hosts_mutex.

Define both lists using LIST_HEAD_GUARDED() so that Clang's context
analysis can validate accesses to the lists against the corresponding
locking requirements.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/fabrics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ac3d4f400601..fd5abd04e080 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -14,11 +14,11 @@
 #include "fabrics.h"
 #include <linux/nvme-keyring.h>
 
-static LIST_HEAD(nvmf_transports);
 static DECLARE_RWSEM(nvmf_transports_rwsem);
+static LIST_HEAD_GUARDED(nvmf_transports, nvmf_transports_rwsem);
 
-static LIST_HEAD(nvmf_hosts);
 static DEFINE_MUTEX(nvmf_hosts_mutex);
+static LIST_HEAD_GUARDED(nvmf_hosts, nvmf_hosts_mutex);
 
 static struct nvmf_host *nvmf_default_host;
 
-- 
2.53.0


