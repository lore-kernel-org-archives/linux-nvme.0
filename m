Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06FBC46CCD
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 23:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4tVNl501murmMsN/qXyHz+ThVtuujyLNGE9HUSAj3Qk=; b=apVP0wMXacuvVTIsMFekyhZwcu
	uIyEK0tdRIjkPcVsxi68F1lcVrc4ZtleaKa5ym2XwjEhF3tjDHMMypdMQmkWafqzB/5IB3lMqwEFt
	SUEAwld77H9wJQEBdF3PvPK8kLce9T9I2EXnhrPBz9rkH2MAJSVR4n9b6IeNMW+mgZLYZR+3e2AbX
	S3vIzXQg4prOYFVboDQFr4957LPp4wRCDzkiVRwPBZ/edHk470v8nndwfuJF5QHWRuqQcMePTdpRu
	YuJyIArs+GrT3B5353ReFDOW8Ytq78BC2LWNkmGi+no78XL7CbX+mQBDPY66KaY1kZQedUFcbQFaA
	NIwMPODw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGSAn-004OLJ-0d;
	Thu, 21 Dec 2023 23:09:49 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGSAj-004OKN-2w
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 23:09:47 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLMkIIE009506;
	Thu, 21 Dec 2023 23:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=4tVNl501murmMsN/qXyHz+ThVtuujyLNGE9HUSAj3Qk=;
 b=jL9t2eZ7jt8st6masOW9gzTvHM4KI5qdtYBwBhntHBGTJUt8f88ZTitXexoD6hbIux2f
 50MptSe57iuQu3DWquwYO0O0n+zNJwiwX1ptYI3F0DHmuu2Ft7OaL0Fkw3Wx0ysZ24j9
 hS4HBrWDJuyrLa88K5fI1/uM+GtBQdsOfW1J9n0Mtb34KE3cXSqSs4rmdgoCNeCwIt+Y
 1JuykLrL2yJxKq/N0B+DuQ8JBgLMscBXemoL0+ET9Wlca1YUoywTtkimtu7Qy2zlV5vq
 BMt+5znNK0bcZGDYKW566RaBAT6WSU3P3hTo0dYiMETsxARsODN5QNRzKjZBa33glUIP 7w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v4atx2qw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 23:09:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLM5Gx2025000;
	Thu, 21 Dec 2023 23:09:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bj6d6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 23:09:28 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BLN9RdI038754;
	Thu, 21 Dec 2023 23:09:27 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3v12bj6d5h-1;
	Thu, 21 Dec 2023 23:09:27 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [RFC 0/1] nvme: Add NVMe LBA Fault Injection
Date: Thu, 21 Dec 2023 15:10:42 -0800
Message-Id: <20231221231043.3597368-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_11,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312210177
X-Proofpoint-ORIG-GUID: 9X1jF-5BRrQXE3Dw37ABy0wTkYta6zH-
X-Proofpoint-GUID: 9X1jF-5BRrQXE3Dw37ABy0wTkYta6zH-
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_150946_131777_A5194937 
X-CRM114-Status: GOOD (  21.83  )
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

It has been requested that the NVMe fault injector be able to inject faults when accessing
specific Logical Block Addresses (LBA).  This patch is built onto the existing fault
injector to provide that ability to specify a LBA when setting up an injection fault.

If the fault injector is enabled, and the nvme driver is ready to send an IO or Admin command
to NVMe hardware, the function should_fail() is called to determine if a fault should
be injected instead of it being allowed to normally be issued.  The should_fail() function
uses the fault injector attributes: probability, times, space, and interval to determine
if a fault should be injected.  If it is determined a fault is to be injected, the request
is immediately completed using the attribute: status.  If no fault is to be injected,
the request is allowed to be issued to the hardware and completed normally.

If a LBA fault is setup, should_fail() is only called if the LBA falls within the range of
blocks of a NVMe READ or WRITE command. If it does not fall with the range, should_fail()
is not called and no fault would be injected.  If the LBA does fall within the range,
should_fail() is called to determine if a fault should be injected.

The LBA fault injector could be extended to also check command types (READ/WRITE).

Steps to setup a fault on a LBA access.

1. Setup the attributes: probability, times, and status according to
the original NVMe fault injector.

echo 100 > /sys/kernel/debug/nvme0n1/fault_inject/probability
echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/times
echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/status

2. Specify one or more LBAs: To configure a LBA, set the lba-inject-set
attribute to the LBA.

echo 0x22 > /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-set

3. Enable the LBA injector: by setting the lba-inject-enable attribute
to on.

echo on > /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-enable

To display the LBAs configured:

cat /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-show
LBA  Status
22   1

To stop injecting a fault on a LBA:

echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-clear
echo 0x22 > /sys/kernel/debug/nvme0n1/fault_inject/lba-inject-set

Alan Adamson (1):
  nvme: Add NVMe LBA Fault Injection

 .../fault-injection/nvme-fault-injection.rst  |  28 ++++
 drivers/nvme/host/core.c                      |   4 +-
 drivers/nvme/host/fault_inject.c              | 145 ++++++++++++++++--
 drivers/nvme/host/nvme.h                      |  16 +-
 4 files changed, 178 insertions(+), 15 deletions(-)

-- 
2.39.3


