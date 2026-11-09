Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7374606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KiMcq5m4;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IGVsDxx8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=yRd+4aXcjlk5QxSk6oTD3OWWzSrXrMB4uT538k1qplY=; b=KiMcq5m45DsKuVbeDHp5fKsadc
	1gzlvk6denEw/xZTW0nRiw1adwZPrgx8RqT6atEdcifDqymEgzpbOIb8c3iXAZI/CIojDPQiqWRU/
	hiVRZajtM6p2ZPftGxz1WXyp9JjiBGmYYorVM6NmTp1ixjZvAcWCDK6WclsqVi/JMAC0H7ikZ01+H
	A4uMTaYDRKhbb/le/L9sZjkK9P9SROl6D/usul8b+m977WdxxrAiu3+jkIwDabhMxk+veuIOQ+IcV
	Qw+R3eych5L0efnHxD6iTqO7jqeJ5ENBsPx5+aPqBL50vmR/aHPiL/dJcWfP2Onr9rlUcdEye2i1Q
	nNDYqrHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG6r-0000000HCON-1jdo;
	Mon, 09 Nov 2026 03:31:53 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG6o-0000000HCMF-05Za
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:31:51 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90i9tB1945565;
	Mon, 9 Nov 2026 03:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yRd+4aXcjlk5QxSk6oTD3OWWzSrXrMB4uT538k1qp
	lY=; b=IGVsDxx8Xrinp2SPNxuapGoxHJ2Hgpr8BPmh07H7EYvglXJB0QVUSsTH/
	u9StSUZ9fSeV8YwkjuWU+wUdvr1kCpybup5bva+VsmfOR6KuHkmxlZ0AGLUVgETn
	9Z2isTMF2VXcCct3G4jH+F/8/JjN7HfXQ6X7L6LBZ9cCzeAEAlnlHFOaLQm1jc6s
	yJtc7Cw4UdVFl623aBsVzh7hWTc5M+NaOm82poXcwAkKq+5lCA4UE2kkGPUQn2bi
	UYj5mpp6EZNnstB0aZzxYfrdcIsjJgrwrXTTGo5ezvkaP2ZACrSplTmnvazE6+82
	iF2Mta49bPaMmPFeo8aggHUyK+oTQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6jead-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:31:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93Jvxc3535212;
	Mon, 9 Nov 2026 03:31:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfajwfha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:31:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93VJLq52953478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:31:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B4E720040;
	Mon,  9 Nov 2026 03:31:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3025D20043;
	Mon,  9 Nov 2026 03:31:15 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:31:14 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 00/23] nvmet: add context annotation for params in struct nvmet_ns
Date: Mon,  9 Nov 2026 08:58:05 +0530
Message-ID: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX2B7qVUCwmcRa
 GZjj6FurztFPcZp9V3i89irb2PqnUE7xeuZlEu6M2BIrVaJ7ARDns2gaPCks6JaS9OWsVIpOEwz
 Bqd+BZtiviq3z7e8989j9Vq6ybred8U=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af13e8d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=_LJSUWdYOGHSVygU-qkA:9
X-Proofpoint-ORIG-GUID: rViuZFy369vi0gDVyOVL9k2LM_1t2Tcz
X-Proofpoint-GUID: HtFLyaKIHvbUKbllOocfdaOE5DQ5m-3a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfXxSvWZSMaL6ww
 ugXXBOTkrkltdl9112duu6VzGemy7k+Vf0awX+NLTby/swHyzmh0M1Q9OzFbFZY5XAPib1FdreR
 ky5MiQMajKeYuLcxh8rIb1gv6xx7Hivd6cNwOghodnT2BmAtbofqDPQ95l9AqXOmrnd54BOOWs2
 zUS7MGexInBlUyHjNGnv/aoEvJFGPDFQg0vMNRHJT7dKUQo5+YwpgvHmHPk3gFDhLCdtd9vNT6e
 DyduvqTUbi+NrkvijOGlMflj7LMkaWoDIVg+08mIgs6n0sEhSc/BnAYezLc414rqIprFakGEzyg
 YQr/S+8uxZ8/WO9NM8o33WLaZaL46KJi6B06o1CyRnxfeDof897yr8gqtGtprZB2ae1Hc5Q0UHT
 Q2Td+Sq42kp/zUYEquuqN0ZmfAFX64gi0jnn6RyEmyqanDT3EIweWT9ZxJPwgHoRsLDHjWcUb85
 Y7GkCMS3DthQ/UQ6OQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193150_073964_A8964F75 
X-CRM114-Status: GOOD (  14.70  )
X-Spam-Score: -2.6 (--)
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
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series adds Clang context annotations to fields in struct nvmet_ns
that are protected by nvmet_subsys::lock.

The goal is to incrementally introduce context annotations throughout
the NVMe target code. Covering the entire nvmet subsystem in a single
series would result in a very large patchset with dozens of patches,
making focused review difficult. To keep the changes manageable, I have
split the work into multiple series, each focusing on a specific subset
of context annotations.

This series focuses on fields in struct nvmet_ns protected by
nvmet_subsys::lock. Subsequent series will expand the scope to other
structures and locks.

The patches are organized so that each field is handled incrementally:
first, a field is annotated with __guarded_by(&subsys->lock), and then
any access violations reported by the Clang context analyzer are
addressed in follow-up patches. Not every field annotation necessarily
triggers analyzer warnings. In such cases, the series simply moves on
to the next field.

This approach keeps individual patches focused and makes it easier to
review the annotations and the corresponding locking changes
independently.

As always, review feedback, comments, and suggestions are very welcome!

Nilay Shroff (23):
  nvmet: add context annotation for nvmet_ns::bdev
  nvmet: fix nvmet_ns::bdev access using nvmet_subsys::lock
  nvmet: add context annotation for nvmet_ns::file
  nvmet: add context annotation for nvmet_ns::bdev_file
  nvmet: add context annotation for nvmet_ns::readonly
  nvmet: add context annotation for nvmet_ns::nsid
  nvmet: fix nvmet_ns::nsid access using nvmet_subsys::lock
  nvmet: add context annotation for nvmet_ns::blksize_shift
  nvmet: add context annotation for nvmet_ns::size
  nvmet: add context annotation for nvmet_ns::nguid
  nvmet: add context annotation for nvmet_ns::uuid
  nvmet: fix nvmet_ns::uuid access using nvmet_subsys::lock
  nvmet: add context annotation for nvmet_ns::buffered_io
  nvmet: fix nvmet_ns::buffered_io access using nvmet_subsys::lock
  nvmet: add context annotation for nvmet_ns::enabled
  nvmet: fix access to nvmet_ns::enable using nvmet_subsys::lock
  nvmet: add context annotation for nvmet_ns::device_path
  nvmet: fix nvmet_ns::device_path access using nvmet_subsys::lock
  nvmet: add context annotation for PCI P2P parameters in struct
    nvmet_ns
  nvmet: fix PCI P2P parameters access using nvmet_subsys::lock
  nvmet: add context annotation for integrity params in struct nvmet_ns
  nvmet: add context annotation for nvmet_ns::csi
  nvmet: add context annotation for nvmet_ns::debugfs_dir

 drivers/nvme/target/admin-cmd.c   | 143 ++++++++++++------
 drivers/nvme/target/configfs.c    |  52 ++++++-
 drivers/nvme/target/core.c        |  66 +++++++--
 drivers/nvme/target/debugfs.h     |   6 +-
 drivers/nvme/target/io-cmd-bdev.c |  30 ++--
 drivers/nvme/target/io-cmd-file.c |  49 +++---
 drivers/nvme/target/nvmet.h       | 237 +++++++++++++++++++-----------
 drivers/nvme/target/rdma.c        |   4 +-
 drivers/nvme/target/trace.h       |   2 +-
 drivers/nvme/target/zns.c         |  46 +++---
 10 files changed, 431 insertions(+), 204 deletions(-)


base-commit: 687f3014afcd5826fa3d8f40b445f647b5a379b6
-- 
2.53.0


