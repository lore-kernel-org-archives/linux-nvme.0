Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B976C02182
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jan 2025 22:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QeNsc5WC6tpfZfsjMRQqubNZIHmtnuAiLEdIcZ2vvrM=; b=DBjS8oE7eFN0hT0e2c6pxIvmYx
	cnAnmsvv5e4dXB2V1xx9CU8h615p8C9x+vWkExb8I4ZQxAsvd7s2oyXAuRNFvtMiZ5CbjaDINnq15
	cy6WbBp/4pr8uGH0oXOeLppJyBQGtaIkVuH0T/X/AhbKNgiFRz5PQ17F8HkqFbatQH1w8AelwWQ1f
	yu+SYGkhv0DLuktL0IidjEo1h5UlJ+ehEcrblfAqXjTE+EtbM3OJPWOq94/SDv8uNhOCdk9hbQxtF
	OZoE7tVtV/+XmvG02SL3xX/R2qFvctPxXWROtqUhw2ErTpxVQFDgGdDC3PYxENSLle/gNeceNcAFd
	4vBqUYoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taMYW-00000008spn-1Bpo;
	Tue, 21 Jan 2025 22:17:08 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taMYS-00000008soe-2ya1
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jan 2025 22:17:07 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LJK2HH012570;
	Tue, 21 Jan 2025 22:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=QeNsc5WC6tpfZfsjMRQqubNZIHmtn
	uAiLEdIcZ2vvrM=; b=m/1ZCtV9dQtmqYmU5j0HQBvvw8OFV2r5ZD5mgvpFFjP1C
	ZPBWg45DO6a+D69KDV1w368I87H/JEonesXlPjEyRmBdVDA3qhO6N1UHC3J1g0c7
	T+bjfJ21EGQcBOg1OgyX/zCM6pTebBddeJiYvIu/j0Da5MSdaUjh9uSEs3NqyXIp
	as8Zl5SgxhqimU69ZWzF6bubINvLuXg12rGC9xYd6xYo01wvfWA3tOsLcP7+Ae5k
	WgcCrMnxg6EGgX+AfajFM9n6XxoFzAIB9uN6zCYBjyeKeplM2ZsIoMT/I9/i1iRr
	DUBkzr+yAGc2lQJtil9OVJPCsOEpFWxmyauScV7jA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qapmun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 22:17:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50LL8SjM036463;
	Tue, 21 Jan 2025 22:17:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917q44w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 22:17:02 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50LMH1Rx022589;
	Tue, 21 Jan 2025 22:17:01 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917q44vy-1;
	Tue, 21 Jan 2025 22:17:01 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, alan.adamson@oracle.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests 0/2] Add atomic write tests for scsi and nvme
Date: Tue, 21 Jan 2025 14:25:28 -0800
Message-ID: <20250121222530.2824516-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_09,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501210177
X-Proofpoint-GUID: VHGMdPPp6gssZAGfKjRmATtmP37piIrh
X-Proofpoint-ORIG-GUID: VHGMdPPp6gssZAGfKjRmATtmP37piIrh
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250121_141705_111138_7CA043DA 
X-CRM114-Status: UNSURE (   6.49  )
X-CRM114-Notice: Please train this message.
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

Add tests for atomic write support.

Tests will be delivered for scsi (using scsi_debug) and nvme.  NVMe can use the qemu-nvme
emulated device that supports Controller-based Atomic Parameters (QEMU 9.2).

The xfs_io utility delivered with the xfsprogs-devel package (version 6.12) is required by
these tests.

The Linux Kernel 6.11 (and greater) supports Atomic Writes and is required by these tests. 

