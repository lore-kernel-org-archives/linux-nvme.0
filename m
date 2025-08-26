Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE62CCA0EFA
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Aug 2025 02:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L55ghXavB7aUxNG5PA1sPhB/vRGawzBq7VnALhEDHzc=; b=A47zFQJncf8lp83O3NFhtQkoHd
	p6TQCTxOMBfYQEyq96bgAkAdpeyFvHGbjUIP4ZO5QvIu8qZWr9mTWgeaGu5pCyeKPKz/AmknVkGsu
	NguaXjBc1pf8qlN+HWakUWSnWRgG2cLFOKIwik7MJmEjuV0hmhsilsFcBq4WHrSmx6M0dz84WBQEm
	qwl4QxpYxw0NeH0vM5jmzJ5vBvB+JZ2lAlM4m2t9JzX5RCkIxRURCBGSOQZ4Jjb/gCMlbgNat3mZf
	Ys+Ao1aIzQMLagw9GgGrCtreahmCrl1OaaykX2xsQ5GjIQ+jR7MtU4afPg+495H+U9G+OHK9qIIOZ
	Ic7Cl3Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqjVr-0000000AMpU-01JP;
	Tue, 26 Aug 2025 02:34:19 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqjVo-0000000AMoZ-1HUm
	for linux-nvme@lists.infradead.org;
	Tue, 26 Aug 2025 02:34:17 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q1JHw0011249;
	Tue, 26 Aug 2025 02:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=L55ghXavB7aUxNG5PA1sPhB/vRGawzBq7VnALhEDHzc=; b=
	R7nOcg5L1tVTtgFMkaLATquCttoxStHozvXe+GYZs6wKv+iDcX2Yesi53qZzbiZM
	jDyvMk5ycAU4m2KDlGWB7uZouNI+DOHCxBkbT5i91Jfi3wtNLgzrOTzQDHk7w8No
	Ii7FNKElx6ZHRvqVFgOZ1nY5Ff3dq3wZ3abEiju/LqGQ2Y0HdillCDF6g2ExqRJ6
	QjAdpk5E16k8Ro2BhKOXN3NY+2/ONmhSmonGYHUYlB9vdexnrSbCht4tUPCRm1CP
	DoyoQd5YPO8EvFtRyyTaHcURuVmhx6RvEohf2MiFdsMcyPOFf1+UJ7ZTouk/s35V
	EshNYUOtwbxVY5Sz0qPC1Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48r8twa8uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 02:34:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q0YrXX012168;
	Tue, 26 Aug 2025 02:34:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q438xc25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 02:34:03 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57Q2Y2s0010861;
	Tue, 26 Aug 2025 02:34:02 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48q438xc0n-1;
	Tue, 26 Aug 2025 02:34:02 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, Bryan Gurney <bgurney@redhat.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        james.smart@broadcom.com, njavali@marvell.com,
        linux-scsi@vger.kernel.org, hare@suse.de,
        linux-hardening@vger.kernel.org, kees@kernel.org,
        gustavoars@kernel.org, jmeneghi@redhat.com, emilne@redhat.com
Subject: Re: (subset) [PATCH v9 0/8] nvme-fc: FPIN link integrity handling
Date: Mon, 25 Aug 2025 22:33:53 -0400
Message-ID: <175613417235.1984137.13827666752970522478.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813200744.17975-1-bgurney@redhat.com>
References: <20250813200744.17975-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=949 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508260021
X-Proofpoint-ORIG-GUID: ryuEKCCrvsMKSxHKhpmLuXYOt4OckGpO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDE4NCBTYWx0ZWRfX5cvgzmOQStbf
 ikmyFU3/QlCSCFA/K9hI4BUtIgCIl0uplZ5fhMjKvXH22QxY9QTmBCjGWE7fpC8zvUFnijs00kP
 Y+zMT8n4F3KNyqBLSFm9J1OKIhrpyDrmZ97ieNak1LWw4L+FGjWd1kHsYQDjKeoumIOqUqZgqwQ
 HpCjOoza7KrFp9/ubqGPaO0QBkPlPDpYS1wI35tlELaDscdrnWKX9ET/8sVicebkORMQjVEm9XV
 VYqDxLAP3QD3yhKHeFh5OHjOfyuBUrMDkzoa4rYZsocv1+Censc9F/L1DQhBgdawRBzHgOEqGV0
 T/7o74TX2K/XqokshlqA6DK0dy7ZQJRq4DTn9m4qwnMpvxdJhsv5C1wwecW35vm4pGl4ZWCVlal
 OgNILNp/NUyx2jHAMCreTcVZGUG6AQ==
X-Proofpoint-GUID: ryuEKCCrvsMKSxHKhpmLuXYOt4OckGpO
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=68ad1d1c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=4R7AhlzvliZDtLbOosoA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_193416_343355_EED2585E 
X-CRM114-Status: GOOD (  14.30  )
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

On Wed, 13 Aug 2025 16:07:35 -0400, Bryan Gurney wrote:

> FPIN LI (link integrity) messages are received when the attached
> fabric detects hardware errors. In response to these messages I/O
> should be directed away from the affected ports, and only used
> if the 'optimized' paths are unavailable.
> Upon port reset the paths should be put back in service as the
> affected hardware might have been replaced.
> This patch adds a new controller flag 'NVME_CTRL_MARGINAL'
> which will be checked during multipath path selection, causing the
> path to be skipped when checking for 'optimized' paths. If no
> optimized paths are available the 'marginal' paths are considered
> for path selection alongside the 'non-optimized' paths.
> It also introduces a new nvme-fc callback 'nvme_fc_fpin_rcv()' to
> evaluate the FPIN LI TLV payload and set the 'marginal' state on
> all affected rports.
> 
> [...]

Applied to 6.18/scsi-queue, thanks!

[9/9] scsi: qla2xxx: Fix memcpy field-spanning write issue
      https://git.kernel.org/mkp/scsi/c/6f4b10226b6b

-- 
Martin K. Petersen

