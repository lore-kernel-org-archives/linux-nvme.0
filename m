Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E44C9830D
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 11:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pyti8VLBIYzqMmjyRAmWY9p82lUnc07qo588iOZXmI8=; b=fwXome83SfZfBdtAExkUgsRoxv
	ahOP5+qGFyGIlR8/0fjE9bqHm/Yy04VKk3t8ID57wV8Zt5zUsAdRva0lkqJBA3iwLG/+xxIdPlwPH
	Gz75qOK4vEFB44SZP0iMDZyRqbwHk6e/61ZhddAkc69g13kJ9OLX9L5GmjJ9r+tY6QOHOGuO0YrVI
	Up538kh/joACGKZBsWGPf+dD8TrdZkjaOT25FqWMw9RSTIGWXbfGwYI6r2GgfZQp8UVXX675iTOtJ
	GYUTPYNqZrL+HKC1PoZ/+/9nTQNpY2U/wJgVvNKeG62kkvz4WruJTG9h661OmR6mLms7Bbmf4Kfg0
	NUkv0cfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA3zw-0000000DBLk-3fQD;
	Fri, 25 Sep 2026 11:21:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA3zu-0000000DBKS-1oJb
	for linux-nvme@lists.infradead.org;
	Fri, 25 Sep 2026 11:21:47 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4a2SY102333;
	Fri, 25 Sep 2026 11:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pyti8VLBIYzqMmjyRAmWY9p82lUnc07qo588iOZXm
	I8=; b=UBMQMOzIZTltR+cggklO1KKEIleNjwuTfvS7YSYcJGn9RLcZFFn8V850r
	tZHhMAGZqqu08BO/fx7YbhXwxAl2D5yj2b04Fl1UNV8JnEvNcMzgLOGDIdx43yOM
	BaWcD5wVUDjldlmvA9/vUMN9EjPMVqpY6GQrnsgbkF43FcqltuP1J1HoLbdVA4LD
	NYyh1JqYFWPCP/uV9UhaaKiYEyL7APSUMca8Nojt5FZnYPux1PHQv8skBfMNC29u
	FvNWCscuBYSTmQwqk3h4X2FsLNJWYa3k9sn2F1nzC+rNEal5RsVVjG2MRJYNiDlR
	cMeUH/oGl2WtugqiI6wSvm1ANoV+Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvnru5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 11:21:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P9qImS3296974;
	Fri, 25 Sep 2026 11:21:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qt7nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 11:21:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PBLU7M40305110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 11:21:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4851E20043;
	Fri, 25 Sep 2026 11:21:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DA8A20040;
	Fri, 25 Sep 2026 11:21:28 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 11:21:28 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, gjoyce@linux.ibm.com,
        chaitanyak@nvidia.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 0/2] nvmet: passthru cleanup and fixup I/O hotpath
Date: Fri, 25 Sep 2026 16:51:08 +0530
Message-ID: <20260925112120.790530-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zdu3S7FqzIdE9mH4GoI3KO4bNOg5BooL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfX6XkTYB6oUNcC
 Kq1aiGA6F00mtis2iw93G3hVLyNPZ4OA0B0PQcIiLQqhV7nBFvQmkX1y+m2r4zdeFJPJ96oWjUD
 8pACfDLevNf3CvzZzk+3IPWceUHb8AE=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab6593e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pKjuB8a3nET1hfl5FYMA:9
X-Proofpoint-GUID: Zdu3S7FqzIdE9mH4GoI3KO4bNOg5BooL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfXzHwYYNTU52wE
 2GW3dn0X4D3UCqtUwnUei0wR6ZBNZdHLsfSA8tfm/KuR8oyson6vPY9sv99b69Awe4SVxxM8LEi
 Z6btO8vwy4W9G5KGi8qDIK4KUMHTl6swkK5yDueXVAXgYwG2JyFY+4E1LAl6opbnK1gJsdH5FmS
 izy2p2AcDMiaBQWYU7ybgYlAIGROV6TYBmsl4tuBk2i6knabOC3ImCG28PD4bRpF6Q2JnaWNQEN
 ny7B0oGEEXn0Nq1wetwT4z+6jun94YwsNpUkhAwrMOAg0Z5QudvWql3CqwwEJl46cEjod9yobG2
 XLIPdjHpXkxnpwDISUjonHPYsQLcp/zzyspllMfLrdyncL5l3gNo+XgTptv+DxZpxzd9KH+2cQx
 iPXNOJB4JD4EplgJVQkC78yG3Er1SnwqeyXKkUijIK+VRSGrVLvr7N8P00iJWqQ0KpfcpsH7YXR
 sGpTuzLvA00wernY8VA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_042146_592980_A36B86CC 
X-CRM114-Status: GOOD (  13.01  )
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

Hi,

This series addresses a race in the passthru I/O hotpath where
concurrently disabling the passthru controller while I/Os are in flight
can result in a use-after-free bug.

We were able to reproduce this bug with NVMe/TCP configured and by
injecting an additional delay into the target-side I/O processing code.
If the passthru controller is disabled while an I/O is still in flight,
it results in the following kernel crash:

BUG: Kernel NULL pointer dereference on read at 0x00000030
[...]
CPU: 9 UID: 0 PID: 4143 Comm: kworker/9:5H Kdump: loaded Not tainted 7.3.0-rc3+ #14 PREEMPT 
Hardware name: IBM,9080-HEX Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.00 (NH1110_031) hv:phyp pSeries
Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
[...]
NIP [c0080000156d8fe0] nvmet_passthru_execute_cmd+0x58/0x45c [nvmet]
LR [c0080000156d8fc4] nvmet_passthru_execute_cmd+0x3c/0x45c [nvmet]
Call Trace:
 nvmet_passthru_execute_cmd+0x3c/0x45c [nvmet] (unreliable)
 nvmet_tcp_done_recv_pdu+0x2d0/0x718 [nvmet_tcp]
 nvmet_tcp_try_recv_pdu+0x29c/0x348 [nvmet_tcp]
 nvmet_tcp_io_work+0xe8/0x838 [nvmet_tcp]
 process_one_work+0x224/0x5ec
 worker_thread+0x1f8/0x3e8
 kthread+0x178/0x1ac
 start_kernel_thread+0x14/0x18

There are two patches in this series. The first patch groups all
passthru-related fields into a separate struct nvmet_passthru, which
makes the code easier to maintain and reason about. The second patch
fixes the kernel bug described above.

As usual, code review comments and feedback are most welcome!

Thanks!

Nilay Shroff (2):
  nvmet: introduce struct nvmet_passthru
  nvmet: fix use-after-free error in passthru I/O hotpath

 drivers/nvme/target/configfs.c | 45 +++++++++--------
 drivers/nvme/target/core.c     |  6 ++-
 drivers/nvme/target/nvmet.h    | 41 +++++++++++++---
 drivers/nvme/target/passthru.c | 88 +++++++++++++++++++++++++---------
 4 files changed, 130 insertions(+), 50 deletions(-)

-- 
2.53.0


