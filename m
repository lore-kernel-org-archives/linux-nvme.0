Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F62C47077
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jan 2024 23:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MSysHGI+RMR8bCzKEh6SYULBLtKeDrTgrQbfJvOwe6w=; b=CGV8tEWP9R9WZWWFdKJMu5j0u9
	0c4eymz3iUIOuBPpddee+cuSoG/OvUoMFBku/z1CNAGsDTO+ZMeqdLBTbnol+71v73CnNt57VNWdo
	UbdZpsYxzKCu61fsLgPFwLDfTPDq5IkauqgGh2CTJC1NZFtLTvWB72pgAQuaQRfoiOMg2FvXMwF3J
	blqjNKz/+NJ2YIufJbSv1TBF+esNk8nTY8kjSqTA2gESArwlJY7+KWGM7zv+oYBoNCDTQfV9ylmoM
	l28CXxaNjUZJc4hBtIiyJIJIGHjTbF7s/dkowh+BZUzrVaXSMIY9X7zu+LZXmHM+5UnnjJbhzIRzZ
	+Z5fow5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPsp8-00DxH4-2h;
	Tue, 16 Jan 2024 23:26:26 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPsp5-00DxFy-2J
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jan 2024 23:26:25 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40GMM2rj022179;
	Tue, 16 Jan 2024 23:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=MSysHGI+RMR8bCzKEh6SYULBLtKeDrTgrQbfJvOwe6w=;
 b=gFrpyAhoQrG5TBhSR486AsDvpJryJQqq14YqpHqDz4PPctDDoVXvfcDme6Yl3deS1vIu
 1rjGXEsL8DUxSe2ct53n+QhMa75G8wH1YydKuLH4BNvUAhdW+EdgAP+jmT5IfYU9ZmLG
 feq0vX88kWhaa1303ZaPCtxwZi1L1JV/kpYGixMh9jPlCUDgyaz/WR9yzd6IQXR4menv
 m2JxSVzgd2dLbyT+VYkr4endah29WyxyJWeRYJiv71QzlbE+vlvotKh2Uup7iOstcSYV
 GeRb54xvay16q/iqkt7fSjLG6TgN6bRVia+U90fAUjVajKllh57Nkk8SwEd2HdxxCfN/ Bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkk2u69bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 23:26:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40GN1HZS019966;
	Tue, 16 Jan 2024 23:26:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy91xxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 23:26:06 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40GNQ69q000490;
	Tue, 16 Jan 2024 23:26:06 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vkgy91xwx-1;
	Tue, 16 Jan 2024 23:26:06 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [RFC 0/1] nvme: Add NVMe LBA Fault Injection
Date: Tue, 16 Jan 2024 15:27:27 -0800
Message-Id: <20240116232728.3392996-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160184
X-Proofpoint-ORIG-GUID: C7HRHYzgCoJDYRsAdeql-gV_o5260p3e
X-Proofpoint-GUID: C7HRHYzgCoJDYRsAdeql-gV_o5260p3e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_152623_755410_675F249F 
X-CRM114-Status: GOOD (  22.48  )
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

I originally submitted this just before the Holidays so many probably missed it, so
I'm reposting.

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


