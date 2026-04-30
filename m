Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E92FF8875
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 10:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rfzowg5pY3cNJk4O5QKKJv5Zfedr0xo4mlYBHzBI+pI=; b=J4CjpcuSDHjhKNLGYYlbIZyJ0y
	CUXGD99Ska5O1VEIgOADX1E5tIq4iXmKaGbGf9qrbgS2KfdiTwjjSWdq70CkQ1FhRPyzAXhvJ1bwq
	DJ8PEFB8HfhkN8YpS6d/h4nZ4t/aUiV1LFTmEJ04p1Y1y7drVngp5ORtwdg5pNLwUQZd28UlfK6WL
	mer1UK1svLgA66Fwhi1uOUCZBE37jea5VFu3BPDBiuqFykbrWBjp61wOy2d3oA1t5YsWJwvLsXKpD
	K7QV0tkAt835ENzjMfhdrK5hfAoKLhJDZ2abqp/tOFlT2UCAR8VCI4Y3URbQQu2DIHJmOHQOA30uQ
	pXvQqeGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIP0l-00000005E01-37tW;
	Thu, 30 Apr 2026 10:52:51 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIP0j-00000005DzO-08zb
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 10:52:50 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U98OlF2036575;
	Thu, 30 Apr 2026 10:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rfzowg5pY3cNJk4O5QKKJv5Zfedr0xo4mlYBHzBI+
	pI=; b=Rr4JgYEVGbRetMDfWHs2YqAXVM75WVaVjtj+qpkhcwQo0PzW9hjDZRPfx
	dGlgo9uTRkaV5Bd/nFISXH/BYYw2swZBHr6AwOVz+O7morSuyvR0uTuEq5sgEmqo
	uTCWCrmxFvZpx0YEe1IaG6Nn6PmtMnTJ8hkAQAhueMSnRGwo7NNtnhGNlQgOJG7z
	AuButfLTUoNaX+xjeTPH0PAZ3Tg5AL8bkU8ept1XIg4MIY9aLFiwKHm40/pmBt19
	8R3a8wYFPcok1yxGoMVZ2IGKBWGetGIBkUM1TLHsAhzBNDDNERkVb5VoHKKcXNNu
	UVyUmD3idA0dm40vW6zPG9g21NVdA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jwrkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 10:52:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UAcsPu011527;
	Thu, 30 Apr 2026 10:52:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqjr3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 10:52:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63UAqfPJ32506284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 10:52:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C10F20040;
	Thu, 30 Apr 2026 10:52:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD8B720043;
	Thu, 30 Apr 2026 10:52:36 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.102.217])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 10:52:36 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCH 0/7] nvme-cli: add nvme top command for real-time monitoring
Date: Thu, 30 Apr 2026 16:22:21 +0530
Message-ID: <20260430105234.1172446-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEwOSBTYWx0ZWRfXwSQk7405M5pe
 74CFUZG9DkSXp2+9Ck+xK7a7o4bNU62fGXKv7/1PEH/xn+ZgHZHRhWNOlxCfD7Yyf2S0Toqr8gs
 2cCxZURZgLGgHEwZxFy+uSiwehFRnW9yo3sLkZe3caIteK29MMXtJ5u3rk7PG6bGUgdSEbZnVpc
 tLgztXwNU6VqM8pOLXt9jNhAdv5Q+8l131zAj2hs361QwvR78etvoaTqtK7VwLAoNk5n8DDbTQF
 3ZJ/eP3eDsAQwJwaqnfXTRUphbMz/UOsFO99xeRIkFaaBJlw/G5w7VwoIwCfRC5Wt80zrcZ+k7q
 uZd27z/MopH4bN42d/6VOFiFlC38L41n+kDHULSz6u0bMsA+IG13WXytMyXVAGEAHBgO9/yvnPl
 3IYXp46kATlEUbZcVIvyFVwmghWo3AsY6NSq2HWxn14vcnWFPNNKMNhCVjE7qNMEiwT+ExhiK8u
 kOzwPNXQUbSUhNKmO6g==
X-Proofpoint-GUID: uqLR6KwExC5Yev43MKURhQEOVfGG6CNe
X-Proofpoint-ORIG-GUID: uqLR6KwExC5Yev43MKURhQEOVfGG6CNe
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f3347d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=iq5rgAIYjDkjMfMu1QMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_035249_194363_E3A9F481 
X-CRM114-Status: GOOD (  17.92  )
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
 nvme-print-stdout.c | 1205 +++++++++++++++++++++++++++++++++++++++++++
 nvme-print.c        |    5 +
 nvme-print.h        |    5 +-
 nvme-top.c          |  345 +++++++++++++
 nvme-top.h          |   26 +
 nvme.c              |   28 +
 util/dashboard.c    |  851 ++++++++++++++++++++++++++++++
 util/dashboard.h    |   53 ++
 util/meson.build    |    3 +-
 util/sighdl.c       |   14 +-
 util/sighdl.h       |    1 +
 util/table.c        |  122 +++--
 util/table.h        |   27 +
 15 files changed, 2630 insertions(+), 57 deletions(-)
 create mode 100644 nvme-top.c
 create mode 100644 nvme-top.h
 create mode 100644 util/dashboard.c
 create mode 100644 util/dashboard.h

-- 
2.53.0


