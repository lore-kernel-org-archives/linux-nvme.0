Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66674CD343F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 20:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DZgvGup3y/JIgAuVPhbHCzi+ELWXCBcr5DBDyInt0DY=; b=r1EnIz4kHbzvw4rOI/xy8NrXOz
	hx5F4XO09qrT8WfauIjXKD3DamcV3lHJkl9QBCUkV3pOPRexsIhXfRDyeLFi5LMMZtkhuK8t8T0yW
	SRJHXUa/2Eo4e2xrhSM+AWbtUQE2HGbHrDKF/rCmzRGwTNJCQ/PBv9sjw85/dYmOY1neykUjHEA4v
	mQhuvMj9Ns3hgnbpiLoTVbjRbvaR+uz0J4Ys/4juZaH/W4q0+1d2twxzHB2B/NGPDl68GxpvAYW3o
	lnGgpLkTkZhoIFhxUqX7RrrvmHe9q6Eg9Lk1N8z0GuUFhVrBBz6x0+3vUeqRQoduHcjk4mweLN7TM
	TPJjJVTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMtWc-00000000J9H-12yy;
	Tue, 12 May 2026 20:16:18 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMtWZ-00000000J8O-2OsU
	for linux-nvme@lists.infradead.org;
	Tue, 12 May 2026 20:16:17 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CBNpB33179852;
	Tue, 12 May 2026 20:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=DZgvGup3y/JIgAuVPhbHCzi+ELWXCBcr5DBDyInt0
	DY=; b=Em8A+U/KDOo9d1XLI04O6gbXElCKZIAMNoO+4fyAKL9DWCZUVn8f6feE3
	96mQXklTGG22ETuEyy6JNVYxgmjMpt7vh3MZi2V1EGUZBE6oGUQI4UvJvOy3YJSY
	BKdbR1P7WUtthJyeO/i6uIjX/r7lVAkCQzAUxcXSY6FDhMC3XublRo0dWa7lmqyx
	//gWjF0vWORRZ2CPDA1OgIHtg8P28coBRcklkEia+UDbI7v3UElswyTJhYCTt5ex
	546s+WELAxrxufJMtau1n5lkNo9DS7dp1Co681y00FVWZrXVxr09rBUtXucA8V8M
	iN84z1dzuqJu4dxSVYQ7LlwDXzj2g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6mme3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 20:16:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CK9a8x026963;
	Tue, 12 May 2026 20:16:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgcref-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 20:16:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CKG37U37618102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 20:16:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A115520043;
	Tue, 12 May 2026 20:16:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C64DB20040;
	Tue, 12 May 2026 20:16:00 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.87.130.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 20:16:00 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv3 0/7] nvme-cli: add nvme top command for real-time monitoring
Date: Wed, 13 May 2026 01:45:45 +0530
Message-ID: <20260512201559.3057514-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a038a88 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=iL25xNuG2EH7w9v-qrkA:9
X-Proofpoint-GUID: yBcYOVgaxQdkd2LN74KAp-GGXRA3fADO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwNyBTYWx0ZWRfXxKuT8fnLVS8p
 kmwZd9D+4q4LOKGoogXqycMSTB24zZ7uBm2rexVpQ/y09JCWHK0wOkFfg3JfUsU2DUqwE/v1kBd
 L6dk5VtGpjqskqqzrMKI500Bvfr8NuBSHWLnJeHUGw8R8NfEd+CczMCDw4lX+akpg2a5z8+DxGI
 9mAtvmEHHa3QQ5EbIV1VaASGMVeIeBCU5/aQy1ktlTyXxUGf0Svk1snpaYJDbYONi72LkPW11ZM
 8w4s5iCfYQOMV4IL9jyZi8LIf9vyy43gN2tYSQBv4AkYINLR/PCHBhpiDlR8kZGKFxmYYVdUosJ
 0VU7J3GkaGkh0l5imFtDBtXMu9C8tvhcsM0E3je7gIe4pOksZSwe/fYOG64mWNqmFbkbEQFVLcp
 gk6culfc9LD7Cr/LSgRpLHa0C3Yb3tSKzFBUmd1whxwyvtEKa0KlF/oGVyrJGIrEFvgxTIj3WhI
 IcE2qYNlgb0S91FuFrQ==
X-Proofpoint-ORIG-GUID: yBcYOVgaxQdkd2LN74KAp-GGXRA3fADO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120207
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_131615_737717_B9A34167 
X-CRM114-Status: GOOD (  17.78  )
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

Monitoring NVMe devices and paths in production is currently limited to
static snapshots via nvme-cli. While this is sufficient for basic
inspection, it is not ideal for NVMe-oF (fabrics) deployments where path
conditions can change dynamically due to varying network latency,
congestion, or link failures.

In multipath environments, administrators often need continuous
visibility into path state, ANA status, queue depth, link speed, and
error counters. Today, this typically requires repeatedly invoking
commands or relying on ad-hoc tooling, making it harder to quickly
identify issues.

This patch series introduces "nvme top", a tool for real-time monitoring
of NVMe devices and fabrics paths, similar in spirit to tools such as
top or iotop. The goal is to provide a continuously updating view of
device and path health, enabling faster detection of link degradation,
multipath imbalances, and transient failures.

The series first adds the necessary building blocks for supporting a
top-like dashboard. The initial patches extend the table APIs (including
support for additional data types such as unsigned, long, float, and
double) and introduce a generic dashboard framework. The final patch
adds the nvme top command built on top of this framework.

Future work:
- Export NVMe statistics to external monitoring systems (e.g. Grafana).
- Improve topology change detection in multipath configurations. The
  current implementation relies on kobject uevents for topology change,
  but namespace path add/delete events are not exported by the kernel
  since they are associated with hidden gendisk kobjects. This may
  require explicit uevent generation from the NVMe driver for namespace
  path changes.
- Wire nvme top into an MCP pipeline and feed it to an LLM

As usual feedback, comments, and suggestions are welcome!

Changes since v2:
  - Addressed few more review comments from AI chatbot:
    https://github.com/linux-nvme/nvme-cli/pull/3350
  - Separate the nvme top code under new file named
    nvme-print-stdout-top.c (Daniel Wagner)
  - Ensure that user could terminate nvme top using Ctrl+C
    (Sagi Grimberg) 
Link to v2: https://lore.kernel.org/all/20260511115555.2638335-1-nilay@linux.ibm.com/

Changes since v1:
  - Addressed review comments from AI chatbot Copilot:
    https://github.com/linux-nvme/nvme-cli/pull/3333
Link to v1: https://lore.kernel.org/all/20260430105234.1172446-1-nilay@linux.ibm.com/ 

Nilay Shroff (7):
  nvme: add support for unsigned and long types in
    table_get_value_width()
  nvme: use table_get_value_width() in table_print_centered()
  nvme: add support for float and double types in table_print_XXX()
  nvme: allow table output to be directed to a FILE stream
  nvme: add sigaction for SIGWINCH
  nvme: add generic top-like dashboard framework
  nvme: add nvme top command

 meson.build             |    1 +
 nvme-builtin.h          |    1 +
 nvme-print-stdout-top.c | 1553 +++++++++++++++++++++++++++++++++++++++
 nvme-print-stdout.c     |   24 +-
 nvme-print.c            |    5 +
 nvme-print.h            |    7 +-
 nvme.c                  |   45 ++
 nvme.h                  |   23 +
 util/dashboard.c        |  905 +++++++++++++++++++++++
 util/dashboard.h        |   55 ++
 util/meson.build        |    3 +-
 util/sighdl.c           |   25 +-
 util/sighdl.h           |    5 +-
 util/table.c            |  124 ++--
 util/table.h            |   28 +
 15 files changed, 2724 insertions(+), 80 deletions(-)
 create mode 100644 nvme-print-stdout-top.c
 create mode 100644 util/dashboard.c
 create mode 100644 util/dashboard.h

-- 
2.53.0


