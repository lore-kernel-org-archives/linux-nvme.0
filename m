Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042FCCD4F48
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2026 18:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=F9WfnWa0LXW5OtnfULA+d6WrSa5FdG/veRc9I2bxRuo=; b=z8eIezq0654s5NQulIU6ywHaFl
	XqmyaU4Dk4pIdaF18GbwmlQf6Xz4W1TOJmalngi4B8jTIWBWndE5Wc+UAJdQRWOoBbTf4S+BJD902
	8vqqIvH2Ffn9OX6lPkP72y1bxpV4GnYuzR7mHQIqD/zP+h7nyBBjvvoedk87BKfG7XdzWlG6nlHGa
	f+J2juA5s8ocOXCit8gxUB6bwzSZYxrD8hcyORGWUb651h8Cw9VMNIXu4gNEJ+DYP+wJJ7c/IemrL
	iVOnA8EIxOO+DjW/iRclKg/wXkU5J/HNu89HABe1A50oaspEjZNnvdzHeyGmfFKm75FrB2rc2jIc5
	sZFmQ6Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJtS-0000000BDn5-360V;
	Sat, 16 May 2026 18:37:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOJtL-0000000BDjj-48fJ
	for linux-nvme@lists.infradead.org;
	Sat, 16 May 2026 18:37:42 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64GCqBZS2332495;
	Sat, 16 May 2026 18:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=F9WfnWa0LXW5OtnfULA+d6WrSa5FdG/veRc9I2bxR
	uo=; b=ejHNpOgxVEarcVxQWxuKz0e/gio5BSL8Skt5OEmFMMYwAKfs0lU5jQLiI
	AVYATnGftXa2c4Gyb72XgXbTiI2R5Pe5pqXkgk5sBJ4OivBYeJ03WMCwLboIROtb
	JCXrCdyV9B3E9PNs+tsKrJN1NuY76G3A/D4iWy1d4BpMRbjhovuErw27igAYEYcY
	Amk6F/xD6b0MPTkTx2Kj+6JIzK7JqAoQU89LtKLWFotK7oHlmWSHJ0uFi8+KZ44h
	52GfCaCgMIheOgj0YgvGMJutnbXKueGhrSRiJ78SLaiQpWrd3SQwuAEen07OcCay
	YMTF223kiZ7tx+PwrZMsKssGwT6dA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h881ry7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:37:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64GIO97R023214;
	Sat, 16 May 2026 18:37:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5kvcrs9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:37:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64GIbLJA39846318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 May 2026 18:37:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2A8920043;
	Sat, 16 May 2026 18:37:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADC8120040;
	Sat, 16 May 2026 18:37:17 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.111.59.249])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 May 2026 18:37:17 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
        venkat88@linux.ibm.com, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv4 0/8] nvme: export additional diagnostic counters via sysfs
Date: Sun, 17 May 2026 00:06:47 +0530
Message-ID: <20260516183709.269937-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d3_btx6rZwr99OVPBV66-qNv0Rr2u3NM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE4NiBTYWx0ZWRfX32RpYm7oHLE8
 R6v7Jclrg5rqXPAIZFneTFVW0DF8w+YKmSjVMEyTUM5d5HpGmVEgmLkvqPi+Gc0+zuc2xYz4NLh
 9C3pmdPnAMVyQmdNKw+HrQdlB530wF0ifnk3liV7iN16PEGomiEqn7LwbylzgvwJEeimQGi0hNy
 4sPvzFVvfX2XR/2hhnvul7tdNrPy7oIrKn/y3hu8+xupjx7htp8Y18eJttKKZB6mjEd1R3Q4Nri
 BytSzSsE2Tb+elMo1hSQUvXEjfD/0JeAmgattZT1DGpDntON5O5zBU4+puZXxQwrXcfnNM5AaoA
 l4kRbpQ/yPbwh/L3w+MuLJrxMR8vxuRwCmxuBGFUc41rcDPaLGPmxlvsCnimh4hz5VvkYlmGJtc
 XCFsYQRDrEyI7zL0lI2/tNT/BPu/Jam7Hrnye5tCqkDIqsN62CRy+j7mRFN4jTX/FANgWs8UaR8
 cuG6F60NWjmveJkn5mQ==
X-Proofpoint-GUID: d3_btx6rZwr99OVPBV66-qNv0Rr2u3NM
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a08b967 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EeAhFhKpCHrFDLAvxyQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605160186
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_113740_146429_321AF372 
X-CRM114-Status: GOOD (  13.29  )
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

The first patch in the series adds a new diag attribute group under per-path, 
ns-head and ctrl sysfs directories so that all diagnostics counters could be  
grouped together under diag sub-directory. The subsequent patches in the series
adds diagnostics counters listed above.

Please note that this patchset doesn't make any functional change but
rather export relevant counters to user space via sysfs.

As usual, feedback/comments/suggestions are welcome!

Changes from v3:
  - To be consistent in naming, all counters are suffixed with _count
    (Keith Busch)
  - The first patch in the series creates new attribute group named
    diag and all counters are now grouped under this new sysfs
    attribute group (Keith Busch)
  - Counters are defined as atomic_long_t instead of size_t (Keith Busch)
  - Removed RB and TB tags due to above changes
Link to v3: https://lore.kernel.org/all/20260220175024.292898-1-nilay@linux.ibm.com/

Changes from v2:
  - Allow user to write to sysfs attributes so that user could
    reset stat counters, if needed (Sagi)
  - The controller reconnect counter nr_reconnects could reset
    to zero once connection is re-established, so instead of
    exposing nr_reconnects counter via sysfs introduce a new
    counter which accumulates the reconnect attempts and export 
    this accumulated counter via sysfs (Sagi)
Link to v2: https://lore.kernel.org/all/20260205124810.682559-1-nilay@linux.ibm.com/

Changes from v1:
  - Remove export of stats for admin command rerty count (Keith)
  - Use size_add() to ensure stat counters don't overflow (Keith)
Link to v1: https://lore.kernel.org/all/20260130182028.885089-1-nilay@linux.ibm.com/  

Nilay Shroff (8):
  nvme: add diag attribute group under sysfs
  nvme: export command retry count via sysfs
  nvme: export multipath failover count via sysfs
  nvme: export command error counters via sysfs
  nvme: export I/O requeue count when no path is available via sysfs
  nvme: export I/O failure count when no path is available via sysfs
  nvme: export controller reset event count via sysfs
  nvme: export controller reconnect event count via sysfs

 drivers/nvme/host/core.c      |  15 ++-
 drivers/nvme/host/fc.c        |   3 +
 drivers/nvme/host/multipath.c |  87 ++++++++++++++
 drivers/nvme/host/nvme.h      |  13 +++
 drivers/nvme/host/pci.c       |   1 +
 drivers/nvme/host/rdma.c      |   2 +
 drivers/nvme/host/sysfs.c     | 214 ++++++++++++++++++++++++++++++++++
 drivers/nvme/host/tcp.c       |   2 +
 8 files changed, 336 insertions(+), 1 deletion(-)

-- 
2.53.0


