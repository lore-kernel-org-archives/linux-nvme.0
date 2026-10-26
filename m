Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98E606A31D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Str56odQ;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=fzNgFFGD;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YeSJxbQE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=kb5pQq4WHoogiigiYBIedv5563mcMxjFosm4L4ifRP8=; b=Str56odQQb06YT+OY8VXT3YREE
	n3z67pmEDkWmCNGkRnoAnkjZGG5TGlweoimBmFQm0BGFkoTzXguj9lscYBcOFPfK70nCDVe93YTfy
	pvPv4RvGYfJUsbFhdsPpEKFbDFWZILmWlV5yoWXcok50QiE5aT5Oy6gGhJNhOVWBFpnbrogZFSJ/a
	t1HNjAp4dTl46l2fKtqe28rgVE9drAoX34i4I/1VqU8oW9xnI/KV9KfYvUQ4PcVhG5Q06fjgcJu5X
	nNI65KYGsBwIHjThviYJK/ukKDOSmjH1XLGf7vYFuspbaHRYeG73gn4789mWNVaF3IX9zq2lynjiM
	z9kldT2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLJuR-00000002VqY-1Pq3;
	Mon, 26 Oct 2026 12:34:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLJuQ-00000002Vq0-15Yu
	for linux-nvme@bombadil.infradead.org;
	Mon, 26 Oct 2026 12:34:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=kb5pQq4WHoogiigiYBIedv5563mcMxjFosm4L4ifRP8=; b=fzNgFFGDlV2fbX/2yGZKNNu8zs
	R/4+pwNOdn5SXpIialBFNIUPkk9A4qLG3MRDR+D+WppE59bY450ZJEop1I3hNSYW/cyXWpJJzMrIo
	pJrgjC3JBc6akjx8oFG7hyngRBnYeXwzyHyTf5zNKx4ftFmWZMpgReJmI/XugeKffSKwU8PWLiZRq
	3z7jMG5EMh6SfBJ37KE5RBvgYViqvohjk7M2RB0TMeMkDpozpW6H8wQi0TgYbOnW07O5VVrnHSfsO
	yASlHFEXoAzodoaAhXsa8I9slm7uduTVqpV+EajlgrIPjP+bTZD9pSdUKeskB6rj7ZJOP37OGW0cF
	1wjRceCg==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLJuM-0000000Dp4r-407K
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 12:34:37 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QBECVL2188758;
	Mon, 26 Oct 2026 12:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kb5pQq4WHoogiigiYBIedv5563mcMxjFosm4L4ifR
	P8=; b=YeSJxbQE8YseEqsLA9GpAPXEr/mx5EFTQKcLBCpNY8duRdW8gWpHLjXow
	NCcFAIHYzd6lXvSQHmOkMF8cT5HY30K3zZ355dfvhEYcUV2sGy7Svn2QB3D3L9U+
	iFq2zLHH1+YKB2BINO3l9/KX7Ms9MgvXsA74ql0xIuBdFDSgR8yiy3l2CeavktCA
	3dOa5vxTsRHNLh8i/sqQWohOeUtLrfsOlAhr8Kw65zpy8OG1b17L0tdt5ysGiKMn
	HvLShLf8hYu3nbrXIMnrDkSvlLxhh9baVp0YMwObKOeX6QzDYDMw3V6ENlkl3fKC
	j0ds9rgCUco3zPj6gqll8L32WnMFg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3fssmq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:34:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QB5LtZ2503111;
	Mon, 26 Oct 2026 12:34:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh9py5jnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:34:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QCYGJQ48300406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 12:34:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6F1420043;
	Mon, 26 Oct 2026 12:34:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 139CF20040;
	Mon, 26 Oct 2026 12:34:13 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.162.42])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 12:34:12 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, dwagner@suse.de, hch@lst.de, hare@suse.de,
        sagi@grimberg.me, chaitanyak@nvidia.com, gjoyce@linux.ibm.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 0/2] nvme-tcp: NIC topology aware I/O queue scaling and queue info export
Date: Mon, 26 Oct 2026 18:03:21 +0530
Message-ID: <20261026123411.1988949-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6adf48cb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=wNQ-CETjAz0c3D07IokA:9
X-Proofpoint-ORIG-GUID: 1BenEmAI1orb1ZgGGkWq8J5-y9cBsoN-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfX3fMnAPVA4jwG
 FPZzINPN62UXUIffMP78etDagjB2lT6fD7Yd8i4LGhE/2qYV7/n4bEHoj9QNLViPj7i/ZflpzMU
 gfqG55abrHnZwqBxBGYzJz1SEoyaJ1CnD1Ylp+S3JBVopky8hmMZXkvqffAR6JZSqpKeqI+z4FX
 W7eQ0rsH4gocBhwa0Ju6+tjL9di+TeTPsAXhdgPCreRS+NkjvcGEiCCKE6AYrIfr5jiRCLIBh/g
 BUxWh3PEX74oFOUy5cJI1jGr7YRw87lssyYQfk/pZGc/Len1wtM5UsNYp2AYHlEFdL3NMj3PEbM
 ZYvNb9xZ3BZo2JbUvGvYo0WDz8ZodkY7vECaIGjKsfdppPgfRgOBTMRr/H8RnvmHXMmYvu6QbiT
 SYHTtiTZUuGd14I/XVANPXc5DRA+XChWaz2uIxhnRp9RCHx7yL8/xvQmJcpHEHd8XB7y4HGUxWw
 OkNPdgV9M34s84OD3Dg==
X-Proofpoint-GUID: 1BenEmAI1orb1ZgGGkWq8J5-y9cBsoN-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfX2iW19TbdNISo
 FD0+KBJmqUoJ/pNFBnZX/4yHHe8IEwCqmxZw/g/HRZfQl6UbAesUW3niWu1a/WVkuW4kFLVIa4t
 DdUCWYk+0JjS8LwhA2v+BS+njuLJsrU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260048
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_123435_314199_65375C83 
X-CRM114-Status: GOOD (  19.26  )
X-Spam-Score: -0.7 (/)
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series has been revised based on feedback from the netdev
community [1].

Following the feedback, the logic for determining the number of fabric I/O
queues (nr-io-queues) has been moved to userspace in nvme-cli [2]. As a
result, the first two patches from the previous series, which implemented
this logic in the kernel driver, have been dropped. This series contains
the remaining two patches, which export NVMe/TCP I/O queue information
through debugfs to facilitate host-side network tuning.

The first patch introduces debugfs helper functions that can be used by
drivers to export debugfs attributes. 

The second patch exports NVMe/TCP I/O queue and TCP flow information through
debugfs. For each I/O queue, it provides:
   - queue id (qid)
   - CPU affinity
   - TCP flow (src/dst IP and ports)

This enables userspace tools to configure:
   - IRQ affinity
   - RPS/XPS
   - ntuple steering
   - or any other scaling as deemed feasible

Together with tunning, these changes allow better alignment of:
   flow -> NIC queue -> IRQ -> CPU -> NVMe/TCP I/O worker

Improving this alignment can enhance flow-to-CPU locality, potentially
improving performance and reducing I/O latency. Performance evaluation
results comparing the baseline with the tuned configuration are
available in [3].

Thanks!

[1]: https://lore.kernel.org/all/20260807160904.2eb1b3d1@kernel.org/
[2]: https://github.com/linux-nvme/nvme-cli/pull/4140
[3]: https://lore.kernel.org/all/20260731073918.614014-1-nilay@linux.ibm.com/

Changes from v2
  - Dropped patch #1 and #2 from v2
  - Added new debugfs attribute parameter "is_visible" which could be useful
    to hide the attribute for certain configuration or transport. 
Link to v2: https://lore.kernel.org/all/20260731073918.614014-1-nilay@linux.ibm.com/

Nilay Shroff (2):
  nvme: add debugfs helpers for NVMe drivers
  nvme: expose queue information via debugfs

 drivers/nvme/host/Makefile  |   2 +-
 drivers/nvme/host/core.c    |   3 +
 drivers/nvme/host/debugfs.c | 207 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h    |  12 +++
 drivers/nvme/host/tcp.c     |  54 ++++++++++
 5 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/host/debugfs.c

-- 
2.53.0


