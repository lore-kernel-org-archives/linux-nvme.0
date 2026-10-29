Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5093E606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0nbfdLH1;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=k/sZkLlR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=wgVFNeAyeNwG7V8VRvF2eR/eZbmtYB/ABRHwekkzNeI=; b=0nbfdLH1wcrXGGe2PdUJDp7E2Y
	HuzLjzV1tEglvuBkgbPwPDQNKn9h+ojtOyagalf68phiDNp7Vtc5YqMEdGnLbz7r4x0GMfVA87Zy2
	y+CwGxDvsxNtO9FUcM/JbLCh/dpf0gXb8OaEGltVSVuBJS7t2EwmnrsPgnJRf9JGrlx5NcqZfLgHg
	RqiSFxnCuQMEQT4MLGNbu7LUJcKa3hCkRLULlDSe9F03hYjRTZnEv2SHndnVWRpuZgQOPo6rQ0afn
	WC8Qy+CgvaUngxczaFPetN60mGCkkWM5PEeBkNRYpA6x2a/szBPUSia+XF8RQm51ojMdrMlSqeEgr
	P3rNWzLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRJ-00000009g0W-3Ma7;
	Thu, 29 Oct 2026 15:53:17 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRF-00000009fv2-1sn3
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:14 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCcfBQ2668822
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=wgVFNeAye
	NwG7V8VRvF2eR/eZbmtYB/ABRHwekkzNeI=; b=k/sZkLlRwWO4PxXsFxkY3sEET
	kNe0m4jnjdqea8qrDvDXMGvunNwVVvWN0SSVuJUnAMqC4JM0aVn9wBrHKqNukoxC
	D/kBbSflBXEJONI05au/g6wHghSpMUqTOXW2igKu3+cs3U4pl6wiC4Vq4Pe+IFnR
	t2Ll+cXmHxp5ZoNtchYWC7CL1n//xas5Nzc+Fq/5fO15FXpxI2Y7RTI/DIsIMRzn
	44tDcxO/QhvDZ+H321nly1IM17aw3337BqAFVocYuMRJ+u4xMfDx+XKS9PwYDsls
	0YqvjLp9gA21WVRFCUH6dqGW5MH2GGj6ubEgdHUFvnTiAcJDoplKKuJeOzzgw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hm28qjnpd-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:12 -0700 (PDT)
Received: from twshared21535.34.frc3.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:08 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id B93A12E22CE79; Thu, 29 Oct 2026 08:52:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 00/19] nvme patch pile
Date: Thu, 29 Oct 2026 08:52:33 -0700
Message-ID: <20261029155252.2332266-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX2MVPkmWJumiX
 ku/P/2g0TTAIeGLADB7vv8ZdMpo4gaFEYQZfYL9n7YVnTSX1S73Tz9xhBrh7uWz75ya2afqt79Q
 aC4NPJpT8w6vwkFz1IMO6hHAKr2assU=
X-Proofpoint-GUID: vU7epbvmKDfsAjMM2XyZk2A1he32AD5r
X-Proofpoint-ORIG-GUID: vU7epbvmKDfsAjMM2XyZk2A1he32AD5r
X-Authority-Analysis: v=2.4 cv=NudE4MdJ c=1 sm=1 tr=0 ts=6ae36be8 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8 a=BueJLc_2OIrTlkOo4JoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX2nuZ72JAOB0k
 Op5BwxbgU33QkatzkOJyOCc6y7sPOlqQMTAwcetga+me+y11CutkZ/KtslvpF65XQlQpUwzN39N
 bat7lOBIQUK7laa0W/p0a4iTa9oPp6Hv73cRoO9m7UHUETK7VUSpbfkdlgA26qDy+zgCDapcWFi
 7HdRiz03B571IAv870FqJzltRhftcOWIPv/0i9UNa6fhu1In7VMqXzNV1ZzDy+ZEHMgPN42OK+d
 53AoW+utLZKUUe25ZPMxMHGX2BOoyN2QOuuJ3Im2z+jZLWL8Qjr8ChxsiykquA7vHF5jC3dazPQ
 GpmibpW0ZfK3wdVrZ6SIOXpucoVTiHYk/oQZhT1ab3kNM9l00u9cqOzzr220lyjASW2deOKFNni
 4nnl/ZLPHCKcLTdH7XYxDmD3oVcMUfzhuoWfqKo5adeNPQmIvgEBcH/PdR2jUQD2KJoU3K2dUl7
 4MDlN+MfTUfyCVWdZFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085313_508218_D5EEA4C1 
X-CRM114-Status: GOOD (  15.09  )
X-Spam-Score: -2.8 (--)
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Busch <kbusch@kernel.org>

Jens sent a large patch series of various proposed fixes in parts of the
block stack. The original series can be found here:

  https://lore.kernel.org/linux-block/20261028164415.1262013-1-axboe@kern=
el.dk/

I want the nvme patches considered separately and applied through the
nvme subsystem tree, so this is following up on that: this series pulls
out many of the nvme patches from that series, and I'm sending this to
the linux-nvme mailing list for further visibility.

This does not include every nvme patch from the original: some proposals
have been applied already, some had duplicate or alternate fixes from
other contributors, some no longer apply, and others had feedback that
indicate rejecting the proposal for something else. But this is the
remaining patches to be considered that still cleanly apply, and
includes received reviews.

This is based on nvme-7.4 merged with block-7.4.

Chris Mason (11):
  nvmet: fix pc_ref use-after-free in preempt and abort
  nvmet: move preempt and abort work off nvmet-wq
  nvmet-rdma: treat a failed connect as a disconnect
  nvmet-rdma: disconnect only established queues
  nvmet-rdma: take a device off the list last
  nvmet-rdma: queue the release work under the mutex
  nvmet-rdma: disconnect a queue on device removal
  nvmet-rdma: reject queues larger than max_cqe
  nvmet-rdma: don't run the wait list recursively
  nvmet-rdma: fix a lost run of the wait list
  nvmet: wait only for executing I/O in preempt and abort

Josef Bacik (8):
  nvme-loop: delete the controller if a reset fails
  nvmet-tcp: ask for the TLS record type on every receive
  nvme-fabrics: reconnect if the association is gone
  nvmet-auth: keep the old keys if the new ones fail
  nvmet: accept I/O queues on the controller's port only
  nvmet: check the host NQN against the TLS PSK identity
  nvmet-tcp: let the accept work come to an end
  nvme-tcp: start error recovery when a send fails

 drivers/nvme/host/fabrics.c       |  15 +++-
 drivers/nvme/host/tcp.c           |   2 +
 drivers/nvme/target/auth.c        |  69 ++++++---------
 drivers/nvme/target/core.c        |  18 +++-
 drivers/nvme/target/fabrics-cmd.c |  33 +++++++
 drivers/nvme/target/loop.c        |   5 +-
 drivers/nvme/target/nvmet.h       |  10 ++-
 drivers/nvme/target/pr.c          | 140 +++++++++++++++++++++++-------
 drivers/nvme/target/rdma.c        | 126 ++++++++++++++++++++-------
 drivers/nvme/target/tcp.c         |  13 ++-
 10 files changed, 318 insertions(+), 113 deletions(-)

--=20
2.52.0


