Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F5A606A32A
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZXbHAS6s;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K8m6NCQI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=aXuRDgDDqAsSPTmM5mfSjJkryqJiUcQP3enJqplTAdE=; b=ZXbHAS6s2tF2C0vUnBIEgT93br
	ZuEhsl880wH9J4/Q98LvN3/fcVJpyjnUlI8J5o+6Vn4nxNmg7L8c6EbyoZvJBkQvHyhobKZtx8CjV
	TEpMTUTWsdRp6HW7CRD8UhxG1XoL783h9ZlPum6rSuS8q+4enKDh9+HAx5Kr7LomguoVsu9oPaSh8
	TE2UxE0c2VbX4BlJZB/wPOeRYv2J5SaTIDzlgv/9sRZnH8b9hFQyW61P5yNH4ERkB4OhnZrJFmqat
	wGDVjEv/HMCp1jYNqn/j6x/QiKwzR3WcRMSP4M3KmkKpKKXD7ME4v1dDHCzR18noKg37Vjw+hCunW
	PmL6xzIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDC-000000080qF-0ydH;
	Wed, 18 Nov 2026 07:36:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaD9-000000080p9-48IR
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:36:09 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2S0ip2431022;
	Wed, 18 Nov 2026 07:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=aXuRDgDDqAsSPTmM5mfSjJkryqJiUcQP3enJqplTA
	dE=; b=K8m6NCQI+pZUHJG/vHmEaCRXjwU711ezoaMegTl02DpfVw3pGsmh8uxUm
	YyNMg+Wpw0BOBdSvx/uBaGR2MApJuEUnRAnuf4bYigatCspV3DUak+2ynphE2qk6
	nCRJaBxl/lmp0tgVMib6V+WKJMIMXTwWNQ7taSt4DKuEEKZxVqIXh4dxPn2ySCIO
	mqNhedkbqJHCu40VwGCCmD033odIuvufKjg5dataLSVpXfCqd1A9Ssh8Pbo9dCdr
	doNOWh2pvcp4xCLoqx9L58rnIswdPRxAYxJbxkLtOcJo9fqpR00/f5ksumhsYwOv
	+k+9RY+fsZ/R2/C00iGqM17y/3A8A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rhcps-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:35:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI789uw1660697;
	Wed, 18 Nov 2026 07:35:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4r28r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:35:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7ZgPd7209436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:35:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA79320040;
	Wed, 18 Nov 2026 07:35:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A1682004E;
	Wed, 18 Nov 2026 07:35:38 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:35:37 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 00/22] nvmet: add context annotation for params in struct nvmet_ns
Date: Wed, 18 Nov 2026 13:04:41 +0530
Message-ID: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ObttFl-iy1i0-Fa1Gk9D1KqBsaK4FVzx
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afd5554 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=8e-fzG-IXBAabpp1rTEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfXzjo7P+SWumWK
 zks7j/sf36wmAv8rgWlSt2RtZjxkrWWH5s7EDYuhWSRae6+zrHm+EIxuhDlDiZHcj4/dSkvAsbt
 GnIw8be+bRBb4cMpT7TNvq09XpeYdmY=
X-Proofpoint-ORIG-GUID: W65qPcZ8fE-Ad57mcZbrswDnjBkUZlNO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX5U/daEqtxUTp
 0AOLEOvIrKDY9y43LVrXSkzUjW56prvl6D77S7gpcqR05VN1aml+jNtH95JlqY2lk6obiEy6+Jg
 HpOkAK2EcR4avO4Yhfv2XPvE7cceRkNMExsXE+X78ktr9ezfwyeQ0uTW2JNXao9cS5XwvWgCbQR
 YeQvdg1p3wQi2PrER8uWuAZFOA/YKiNiCqnsgUqk7a6q2HQmp0LZktkJ8hQ6Fhpc0rxQ/Ssn2e5
 GkxFrkSQPsna9xirl5Siqa4QC4PiSJ3TSMiZOUcQCbBUsV4CbCijMmpOBy/xIGTA9pPwjqf7gJL
 ca4/tVBtTLoWv2ijMXtPhWPdwGjdFXxovc81RbkfAh9TczG3z72zqkwuC7yq0P9HLXx17Zr9vG6
 j1Jk5LVVGHvJRSQOd/fnNT70Bd1NmrP4h1qjzMf0oiUf66X9GzmuaDrnmaz9V+S2GhIP+rfSmQQ
 R4gDULTRHrTWh5tsjmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_233608_043229_B4ABF90F 
X-CRM114-Status: GOOD (  15.59  )
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

Changes from v1:
  - Dropped patches #6/23 and #7/23, which annotated ns->nsid with
    __guarded_by(&ns->subsys->lock). Since ns->nsid is immutable during
    the lifetime of a namespace, it does not require additional
    protection (Bart Van Assche)
  - Since the Clang context analyzer cannot infer that the same lock is
    being accessed through different expressions (e.g., subsys->lock and
    ns->subsys->lock), pass subsys as an additional argument through the
    relevant function call chains and use lockdep_assert_held(&ns->subsys->lock)
    instead of __assume_ctx_lock() wherever possible (Bart Van Assche).

Link to v1: https://lore.kernel.org/all/20261109033102.982191-25-nilay@linux.ibm.com/

Nilay Shroff (22):
  nvmet: add context annotation for nvmet_ns::bdev
  nvmet: fix nvmet_ns::bdev access using nvmet_subsys::lock
  nvmet: add context annotation for nvmet_ns::file
  nvmet: add context annotation for nvmet_ns::bdev_file
  nvmet: add context annotation for nvmet_ns::readonly
  nvmet: add context annotation for nvmet_ns::blksize_shift
  nvmet: add context annotation for nvmet_ns::size
  nvmet: add context annotation for nvmet_ns::nguid
  nvmet: add context annotation for nvmet_ns::uuid
  nvmet: fix nvmet_ns::uuid access using nvmet_subsys::lock
  nvmet: add context annotation for nvmet_ns::buffered_io
  nvmet: fix nvmet_ns::buffered_io access using nvmet_subsys::lock
  nvmet: add context annotation for nvmet_ns::enabled
  nvmet: fix nvmet_ns::enable access using nvmet_subsys::lock
  nvmet: add context annotation for nvmet_ns::device_path
  nvmet: fix nvmet_ns::device_path access using nvmet_subsys::lock
  nvmet: add context annotation for PCI P2P parameters in struct
    nvmet_ns
  nvmet: fix PCI P2P parameters access using nvmet_subsys::lock
  nvmet: add context annotation for integrity params in struct nvmet_ns
  nvmet: add context annotation for nvmet_ns::csi
  nvmet: fix nvmet_ns::csi access using nvmet_subsys::lock
  nvmet: add context annotation for nvmet_ns::debugfs_dir

 drivers/nvme/target/admin-cmd.c   | 135 ++++++++++-------
 drivers/nvme/target/configfs.c    |  54 ++++++-
 drivers/nvme/target/core.c        |  88 +++++++----
 drivers/nvme/target/debugfs.h     |   6 +-
 drivers/nvme/target/io-cmd-bdev.c |  30 ++--
 drivers/nvme/target/io-cmd-file.c |  35 +++--
 drivers/nvme/target/nvmet.h       | 233 +++++++++++++++++++-----------
 drivers/nvme/target/rdma.c        |   4 +-
 drivers/nvme/target/trace.h       |   2 +-
 drivers/nvme/target/zns.c         |  46 +++---
 10 files changed, 405 insertions(+), 228 deletions(-)


base-commit: 68099cf27253a8c89d703a282d3d811446d9453b
-- 
2.53.0


