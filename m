Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9F9CD37B9
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 11:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=r5ct0VF067PxS5M0Yy0Gy5tkgBBKNAyFls+FVnCR1Po=; b=n+zvlytNdp9yIKbz2vxsNgnVOV
	jyHFsYNmds3aqmNXCygErnuTnI7Elh6QknWg762KG+VrD1B8mRh55IY5pW3teDY6zaDjquTUBgMtG
	e7AhdUzwrBVIb4MyVhcVrFYFoQAijMeiATf5McMGWn96viFnAVFfkU9DdwpPUnWhchC3JmjD0zkcg
	/fka8jTfJE7tsnU06DUMyw2r32E+3R5SENFedMOWW79VJYnYS72a86wcqRRSVfC0xJ5lkRzV2JcpN
	dU4tKjlCoR2juUsDdPsN1LPGCmfKT6+or6HKrVdgHvkdGwJxht2P8UPIK/rBViP1+z54iSFRTSC2x
	kIcylVuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPF5-0000000DQ5y-2H0s;
	Mon, 11 May 2026 11:56:11 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPEz-0000000DQ3a-36H8
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 11:56:10 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ALMdmW4020845;
	Mon, 11 May 2026 11:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=r5ct0VF067PxS5M0Yy0Gy5tkgBBKNAyFls+FVnCR1
	Po=; b=Ez5QhN6UgdFIFWS6jf2dwutDWfdq3XQ3sgiIsuOXRIv+50Z+EJLNY7akf
	WsIC9Uy5k2Ki/EtNaXnbJ1FVLhf6H0FeljnrmFv/wYKPt77/dLPKhKER6U2Uqat/
	SiKD2nrNRKZqB5vvv3h6D0WKKrsYxuGUtz26mj77opka6SjBfU2maRfWY6W0r1fY
	JJxK+6dfGrZfkFviaqyzGdWHO/uGdRhojzpBLF5u2sd4GNJphYh359eDrTxq4Oe9
	7yOt25T1wvB+Bgv+UXliyzaLEQf9gBnsquJHcWoSyGQL9jQtR5kuAMehbOiRYhMl
	wT0P9j3fKkynf3I4JuRCYtj/fY7Fw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vju7fjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:56:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BBsMd5010503;
	Mon, 11 May 2026 11:56:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2f8q56ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:56:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BBtwf956754650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 11:55:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FC5E20040;
	Mon, 11 May 2026 11:55:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 678F62004B;
	Mon, 11 May 2026 11:55:56 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 11:55:56 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 0/7] nvme-cli: add nvme top command for real-time monitoring
Date: Mon, 11 May 2026 17:25:40 +0530
Message-ID: <20260511115555.2638335-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=cYbiaHDM c=1 sm=1 tr=0 ts=6a01c3d2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=iL25xNuG2EH7w9v-qrkA:9
X-Proofpoint-GUID: OvOgIsMJ_nM-t7lPBoVmzCW12vy0gqql
X-Proofpoint-ORIG-GUID: OvOgIsMJ_nM-t7lPBoVmzCW12vy0gqql
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEyOSBTYWx0ZWRfX8/B7k86mzrEp
 zNCMzfiYCa9/DH9wZkCFXmAdYTNbgqBfMK7JOJbPTZmpHFUVCNlyD6k2vBSYP2sCnCK2Zpp7j2p
 6LtDGyWNvehJRwPWSy3F9ZYhlcoEyKHHh8ZlNry/l7PfzVdC8DiRU1jFHWowFfZKcYcXTta4ixK
 P7bh30vRCyNvl3zgwYrqlg3ctNIfvlQfZHcnyPVoP4QLgL8QNV1bGP0srv25YxF1At46PRGJ9Yz
 FGWjanxWj4x+hYbLGnYkTsXV9AnK5fuJnTaIjLb/mbx+F/knZRJSKeqqol9rEDvtPm3jU9TpgJ7
 cTLrS/iGzNiZLInW1mWNdrFQYpH5qBxUituGBJ/Eh+CYG0++p47yOB4S0TIezHGfU8knuCHBmgR
 j5sXpJkFHWmGXxgI7VTBHh8gmMIzquFl84PXJQ4ukxJnWL+7SWVBHAP5Qy2nWP05b8FNxojgHaX
 GTaqF/FvsMwAPoVtqpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_045607_901233_F48CDBBC 
X-CRM114-Status: GOOD (  17.21  )
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

 meson.build         |    1 +
 nvme-builtin.h      |    1 +
 nvme-print-stdout.c | 1206 +++++++++++++++++++++++++++++++++++++++++++
 nvme-print.c        |    5 +
 nvme-print.h        |    5 +-
 nvme-top.c          |  345 +++++++++++++
 nvme-top.h          |   30 ++
 nvme.c              |   39 ++
 util/dashboard.c    |  882 +++++++++++++++++++++++++++++++
 util/dashboard.h    |   55 ++
 util/meson.build    |    3 +-
 util/sighdl.c       |   16 +-
 util/sighdl.h       |    4 +-
 util/table.c        |  124 +++--
 util/table.h        |   28 +
 15 files changed, 2684 insertions(+), 60 deletions(-)
 create mode 100644 nvme-top.c
 create mode 100644 nvme-top.h
 create mode 100644 util/dashboard.c
 create mode 100644 util/dashboard.h

-- 
2.53.0


