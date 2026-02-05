Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C23EC1EAF
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 12:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wVS/NnYURwLU5+TjVXzHvNHVDjSM0kCzn4efBp6k9Kk=; b=bmelLjk8YSfUmyrNA9QEdlXl2n
	8r6MrebzfJ1L0fa6bIdACGLwkwI5po1fcNGRnmfnw/ROt4KipDXOaRHm544fsp/pvqDgkFHBffZi4
	xf5gQJDjz15gbWYhkk6Zvr9gYumNv3p7bYzJs59nuu8RuieWt7eZ42/IfVL8HEoJfkoqv2Fy78NXy
	11vx3zjNJKgHFIU9e7qstxVu3I8IoRpQME2EuSQ7wR+dKRhxR9h/efm8Oe3EaNNTQD7tEqHp1dNYE
	zLsBuYGycWrlpZIHgLTLYr6H86iGidcznlKpWmrisZMe1cH8z/BUBk8KyPCAzClVdyT2ALKvhbNGm
	1x5qsMWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnymr-00000009thm-1vPG;
	Thu, 05 Feb 2026 12:48:45 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnymm-00000009tfV-1Ktv
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 12:48:41 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 61597XYo011155;
	Thu, 5 Feb 2026 12:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=wVS/NnYURwLU5+TjVXzHvNHVDjSM0kCzn4efBp6k9
	Kk=; b=grcipvCTaUdYDyBh1B+WzlKHaKETnS1b6LlD9gQhrQ21gENtuZ65p4Yws
	35rXAkMjqeh2COvQAe4tcb+I/8Zv+J2RP11uRn4rRTN5JfxSv5MuIMCwiekpf067
	ON5N1vbqNw4fb+eymX67nE2t7OM8Vz8IQxPrY0Fp//m2fcQw08vcP6ZiV/6zu80t
	zbaIdqZaqXXiJRta3LrtNstkDWDdMoVzoOvfCGnS5mEwiJquAOuOJHTEQaCxSxEO
	Nk/IAWsKtqtW4MiJAstpTMhiTtfv+cQ6hwQCIVDC7wENNUOXdzDzY8QrmZVam5Q2
	KHRJZOf4TyiNCzCRWFUQdVw9Boefw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185h3xfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:48:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6158FHUP005914;
	Thu, 5 Feb 2026 12:48:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1x9jhhdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:48:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 615CmMIc40960436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Feb 2026 12:48:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F5F02004B;
	Thu,  5 Feb 2026 12:48:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 612D520043;
	Thu,  5 Feb 2026 12:48:20 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.179])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Feb 2026 12:48:20 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 0/7] nvme: export additional diagnostic counters via sysfs
Date: Thu,  5 Feb 2026 18:17:59 +0530
Message-ID: <20260205124810.682559-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=UdxciaSN c=1 sm=1 tr=0 ts=6984919b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=y4OcVJxQ2b40wQSunWoA:9
X-Proofpoint-GUID: loHbgoXWvUR9v9aLixb4vtFy1uVUrggE
X-Proofpoint-ORIG-GUID: loHbgoXWvUR9v9aLixb4vtFy1uVUrggE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5MiBTYWx0ZWRfX+BIfaKK4FvFO
 J2SwHzyIBukwemtLQLQun/t6nTnPqCL+YGJ2QF49Z0Y7bbQkOt0Xa7v/SV64eY+JOOubpxSLqfr
 IhVgYTx6ycd2hwwUD3wZhjBelSF1HAKtyv7bjDoh5MxD10LjyL5h0XL0/oBtzZLh4KCPoFnMGl8
 iXbzVA84qb+FB1lSYayQ9TyJ/mfD+O/ASLjTQCfXIp1KpulTZ6mbFidvNHE6d5HNnv2SdV/cM8K
 OE8nwDfFlH5M2bn48XLPWyqJ2yzB+Wv7macyingk2UfbpkPlFeu1Br/kkIOKOVP1Ppalr9S5rd4
 qNhwUtkeh2Da35foPUZwFXhka10Un8svEUSRQQnpt80zswUIX7loSvQGL3a4H2LtQxwlaNSV/Tr
 2PGnw7PcH0eESiNzU/oZXnxUmWY6KhKwe9Wt6S/RoWfT+vn+B4RGS+F/Oq+/pnxpjSFx/i/Bnnt
 p/GLfy+Ro7n08dtY7Wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602050092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_044840_538911_5D81B290 
X-CRM114-Status: GOOD (  12.13  )
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

The NVMe driver encounters various events and conditions during normal
operation that are either not tracked today or not exposed to userspace
via sysfs. Lack of visibility into these events can make it difficult to
diagnose subtle issues related to controller behavior, multipath
stability, and I/O reliability.

This patchset adds several diagnostic counters that provide improved
observability into NVMe behavior. These counters are intended to help
users understand events such as transient path unavailability,
controller retries/reconnect/reset, failovers, and I/O failures. They
can also be consumed by monitoring tools such as nvme-top.

Specifically, this series proposes to export the following counters via
sysfs:
  - Command retry count
  - Multipath failover count
  - Command error count
  - I/O requeue count
  - I/O failure count
  - Controller reset event counts
  - Controller reconnect counts

The patchset consists of seven patches:
  Patch 1: Export command retry count
  Patch 2: Export multipath failover count
  Patch 3: Export command error count
  Patch 4: Export I/O requeue count
  Patch 5: Export I/O failure count
  Patch 6: Export controller reset event counts
  Patch 7: Export controller reconnect event count

Please note that this patchset doesn't make any functional change but
rather export relevant counters to user space via sysfs.

As usual, feedback/comments/suggestions are welcome!

Changes from v1:
  - Remove export of stats for admin command rerty count (Keith)
  - Use size_add() to ensure stat counters don't overflow (Keith)

Nilay Shroff (7):
  nvme: export command retry count via sysfs
  nvme: export multipath failover count via sysfs
  nvme: export command error counters via sysfs
  nvme: export I/O requeue count when no path is available via sysfs
  nvme: export I/O failure count when no path is available via sysfs
  nvme: export controller reset event count via sysfs
  nvme: export controller reconnect event count via sysfs

 drivers/nvme/host/core.c      | 15 ++++++-
 drivers/nvme/host/multipath.c | 34 +++++++++++++++
 drivers/nvme/host/nvme.h      | 11 ++++-
 drivers/nvme/host/sysfs.c     | 78 +++++++++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+), 2 deletions(-)

-- 
2.52.0


