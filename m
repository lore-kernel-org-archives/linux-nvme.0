Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CB1CD98C6
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xyBTM5aL+KwXNymamVsCi7C9fXXKbcSTf+vkiyv4+0A=; b=k+x9dAowGefzJNNyZoDKj5fdac
	L+8cdTgpgdCN+saPz1o6XWisnO8EirhzxcIvdeNpzsT39eCbnNL+NOAKQVF6U3c+9LlGsqRAnSXpk
	FrrCBFCaMPO7m8fl6ErmVUq32CpFr3Wt7nf4Po3+xhgUe/LDxPaXqAoL4Wq9PuTYgEjpNbwQ0o0Qu
	ZQl5jOtIcVqbG+ux62VgUs7/Y2sxaiusWMXmB7gfkwU29hUR6WQD3/TLfJRwH1zz/of9Xvmm/y+0J
	9a7j/VCz4tRfHemnB52t48amCTZrVlss9UCCXF3Ye1xX2e/nE9SH2Eyh5ir8QLXic5wOOnu4ShK1A
	6eJKPKuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJuy-00000007sWR-1Qz5;
	Wed, 10 Jun 2026 14:28:32 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJuu-00000007sTh-2fii
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:28:31 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ACe2gx1207171;
	Wed, 10 Jun 2026 14:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=xyBTM5aL+KwXNymamVsCi7C9fXXKbcSTf+vkiyv4+
	0A=; b=a85ZoTa6fKzB9awANvBp11kdaRyL1NKf5hf5U3Xbw0BBKknR60DbFV17+
	/zlLwxe4eN++xyly8V3C5kQbIVMJDWjqK1VgjFpAGBvuk/nuWYUwWBXxw2pnNa66
	lABG1W+NswTkdPJup0n6h04YC7x23sJiG1N5S3wtsGSuR9OPvKRF8+MGM/zVwnPl
	RP9Y4znKshOK9PBMtPMuoALImlFg44RbO3/eQZ6p2OgDShSKfuxuHOhjZ8fPU6QW
	yfNw+v6SDHHUSZ2cP7G+mKZ+9JoDP5zr1e/kTxFlzp0OI3OJnueIzb9It38w6Mfc
	r6hVaDY/6YkNYyB686xW6sIfyz/Dw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6t12a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AEJqud013374;
	Wed, 10 Jun 2026 14:28:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq7647-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AES7bx25952716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:28:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9EA52004D;
	Wed, 10 Jun 2026 14:28:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B09020040;
	Wed, 10 Jun 2026 14:28:05 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.34.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:28:05 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 00/15] Support Clang context analysis for NVMe host drivers
Date: Wed, 10 Jun 2026 19:57:20 +0530
Message-ID: <20260610142743.115898-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: GwOsUEN5_tw07dStou_Tl3wAOmvVjvLo
X-Proofpoint-GUID: b0P--E18RqqLrmQTPWgUI3eImnFZre9N
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a29747c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=XSbIBq3ZAERtOhGDojsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfX3PFpS6RYKMoQ
 wnomYaJnHZbHGNvKGOF17y/MlOlUjXVcsNQn1ES12N9TIMnKJiP/cJHaUqTzVEkpBnvU8lcI7hB
 5Pf7xxVVyVK4xu26lpzWXpQhmPE3CYjB6Rfoc+ad1Dri5oD+gq2XHzrrYZ+4tFPHfatj1SLhmu9
 6XE0bk+/R0mKJly9RE55hmaAic9Utw7rL47emL8ts5bmq94TIFlWF683bSVx7nm+DOMamO7LdTf
 qQGFg4e3Ovz4SwCyQmzWjh4uXi0tSZ6lx7HyTB1rxnWrcXfCbr9ZYb5iaEqSjxtekNTgFX2oLbw
 L1GUnG1AzZmOhwCvFJF17jkh5Ln4VtZ4gYK932RRC2dBxkVGvqLyzrddKb3Csoos/ie+y4CXJ9Q
 yN+Ax02/4Ws6KBjs6NC53O5n5cK67zdAPiSZHAYnJ77MbRnJkFy48CfRjYDE2brUe+OZeUikegB
 GUIw3+Y8UfAfR0BxjMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_072828_795002_5F3972E5 
X-CRM114-Status: GOOD (  13.44  )
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

This series adds support for Clang's context analysis to the NVMe host
drivers.

Recent work[1] by Marco Elver introduced infrastructure for lock context
analysis in the kernel, allowing Clang to verify locking requirements at
compile time through various annotations.

This series build on top of that infrastructure by annotating the NVMe
host drivers with the appropriate locking requirements and by addressing
warnings reported by the analyzer. 

The series was built and tested with LLVM/Clang 23.x and enables the
NVMe host drivers to build cleanly with CONFIG_CONTEXT_ANALYSIS enabled.

Support for the NVMe target drivers will be addressed separately.

As usual, comments/feedback/suggestions are most welcome!

Thanks!

[1] https://lore.kernel.org/lkml/20251219154418.3592607-1-elver@google.com/

Nilay Shroff (15):
  nvme: update nvme_passthru_end() signature
  nvme: add Clang context annotations for nvme_passthru_{start|stop}
  nvme: add Clang context annotations for nvme_ns_head::srcu
  nvme: add Clang context annotations for nvme_ns_head::requeue_list
  nvme: add Clang context annotations for nvme_ns_head::current_path
  nvme: add Clang context annotations for nvme_dev::shutdown_lock
  nvme: add Clang context annotations for nvme_subsystem::lock
  nvme: add Clang context annotations for nvme_ctrl::ana_lock
  nvme: add Clang context annotations for nvme_subsystems_lock
  nvme: add Clang context annotations in fabric.c
  nvme: add Clang context annotations for nvme_queue::sq_lock
  nvme: add Clang context annotations for nvme_queue::cq_poll_lock
  nvme: add Clang context annotations in rdma.c
  nvme: add Clang context annotations in tcp.c
  nvme: enable Clang context analysis support for nvme host driver

 drivers/nvme/host/Makefile    |  1 +
 drivers/nvme/host/core.c      | 23 ++++++++++++++++-----
 drivers/nvme/host/fabrics.c   |  4 ++--
 drivers/nvme/host/ioctl.c     |  2 +-
 drivers/nvme/host/multipath.c | 26 +++++++++++++++++++++---
 drivers/nvme/host/nvme.h      | 38 ++++++++++++++++++++++-------------
 drivers/nvme/host/pci.c       | 35 ++++++++++++++++++++++++--------
 drivers/nvme/host/rdma.c      | 27 +++++++++++++++----------
 drivers/nvme/host/tcp.c       | 19 +++++++++++-------
 9 files changed, 124 insertions(+), 51 deletions(-)

-- 
2.53.0


