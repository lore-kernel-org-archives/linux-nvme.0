Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B756C021B2
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 18:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/G+22Z5klOB/BaYgo3/8FGrN8t10IpNqOIARPY7xUJY=; b=ixiLV7u0jFoAhBHx2lE2jLLoBE
	q5TkIFA1Bn7ICfsFx1TajKodydUzhdbobXubPK6442gt1SFHLUempkfHlNIVLlRifbul+WPzLm9rE
	pS0Xsm3ZLExZN0eSZzvvplifLI5p/KGjN2qlQ+YrKNrbubeIziAN2RAuuvDLsuWKGFd4594Dxro3C
	NRy6w+aM9PzXCgKqJxUkYlGzhJ9uDH5Seb/RSZc5m9bP6N3ydEfDlEX5waewkDqVS2wVGZnr1tPvs
	eNtE5so7xA2uhOIg55y2UjNC8lYCvXoj8fNF4oDh0B293fAxDyi9JxOZZBtVbHBJPWN0pHxqFhLwV
	yCWBJzGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmzsd-0000000100P-20VX;
	Tue, 25 Feb 2025 18:42:07 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmzZk-00000000uNx-2iAy
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 18:22:38 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PHtbtP008584;
	Tue, 25 Feb 2025 18:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=/G+22Z5klOB/BaYgo3/8FGrN8t10I
	pNqOIARPY7xUJY=; b=dkU0DeKsROM/mZtEf2javZx2D5KeN1Q3Io1FzZ5INlqWU
	EjOlBw66OK2reLo2njrm75c4txi/6CI3EYfXzMOzMr8yrhuq/Rk3y4spj0/utNYT
	qe/TsvY2xl5PzkeunlttnluJuzmvFxZ3sjVcNbVyJprbpFto4EBK2CQ44O0llBV6
	ZFtUTWqNL2bfoAhuIvaK/BEbPISpEohdP/F0kN9/ZVhMIkmhxTHPxvnz55bPZCpK
	x1oNSxh2YChvvMB0cH7iw5fB8wTXCdY4lj3vdmiqri+1i58iXLs95KTQKba+zHfF
	u/OaRW/9wlQ7AzkNt/U/u0j+g7gGqOSk5wVCefx8A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c2e1k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 18:22:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PHVu0r024499;
	Tue, 25 Feb 2025 18:22:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y519n6xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 18:22:33 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51PIMXe4038769;
	Tue, 25 Feb 2025 18:22:33 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44y519n6x8-1;
	Tue, 25 Feb 2025 18:22:32 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, alan.adamson@oracle.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests 0/1] common/xfs: verify xfs_io supports statx atomic write attributes
Date: Tue, 25 Feb 2025 10:31:07 -0800
Message-ID: <20250225183108.3881328-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_06,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250114
X-Proofpoint-ORIG-GUID: pffJKxOyNP69FTdj4LuhTKOWd7JakYK2
X-Proofpoint-GUID: pffJKxOyNP69FTdj4LuhTKOWd7JakYK2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_102236_801528_90F058E7 
X-CRM114-Status: GOOD (  10.31  )
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

The xfs_io utility is used to perform atomic pwritev2 and statx system calls.
The atomic pwritev2 was supported in xfs_io v6.11.0 and atomic statx was
added to v6.12.0 so _have_xfs_io_atomic_write() needs to be modified to
check for both atomic pwritev2 (-A) and atomic statx.

TEST RESULTS
============
Using xfs_io version 6.11.0:

[root@localhost blktests.x]# ./check scsi/009
scsi/*** => nvme0n1                                          [not run]
    /dev/nvme0n1 is not a SCSI device
scsi/009 => sdb (test scsi atomic writes)                    [failed]
    runtime  0.156s  ...  0.148s
    --- tests/scsi/009.out	2025-02-24 17:04:22.372544559 -0500
    +++ /root/blktests.x/results/sdb/scsi/009.out.bad	2025-02-24 17:50:33.256602965 -0500
    @@ -3,8 +3,8 @@
     TEST 2 - check scsi_debug atomic_wr_max_length is the same as sysfs atomic_write_max_bytes - pass
     TEST 3 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length - pass
     TEST 4 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran - pass
    -TEST 5 - check statx stx_atomic_write_unit_min - pass
    -TEST 6 - check statx stx_atomic_write_unit_max - pass
    +TEST 5 - check statx stx_atomic_write_unit_min - fail  - 1024
    +TEST 6 - check statx stx_atomic_write_unit_max - fail  - 524288
    ...
    (Run 'diff -u tests/scsi/009.out /root/blktests.x/results/sdb/scsi/009.out.bad' to see the entire diff)
[root@localhost blktests.x]# ./check nvme/059
nvme/059 => nvme0n1 (test atomic writes)                     [failed]
    runtime  0.035s  ...  0.036s
    --- tests/nvme/059.out	2025-02-24 17:04:22.371132656 -0500
    +++ /root/blktests.x/results/nvme0n1/nvme/059.out.bad	2025-02-24 17:50:36.383906336 -0500
    @@ -1,8 +1,8 @@
     Running nvme/059
     TEST 1 - Verify sysfs attributes - pass
     TEST 2 - Verify sysfs atomic_write_unit_max_bytes is consistent with NVMe AWUPF/NAWUPF - pass
    -TEST 3 - Verify statx is correctly reporting atomic_unit_max_bytes - pass
    -TEST 4 - Verify statx is correctly reporting atomic_unit_min_bytes - pass
    +TEST 3 - Verify statx is correctly reporting atomic_unit_max_bytes - fail  - 16384
    +TEST 4 - Verify statx is correctly reporting atomic_unit_min_bytes - fail  - 512
    ...
    (Run 'diff -u tests/nvme/059.out /root/blktests.x/results/nvme0n1/nvme/059.out.bad' to see the entire diff)
[root@localhost blktests.x]# 


Testing by czhong:
the default xfs_io version is 6.11.0 on my system,
after applied your patch:

# xfs_io -V
xfs_io version 6.11.0

# ./check scsi/009
scsi/*** => nvme1n1                                          [not run]
    /dev/nvme1n1 is not a SCSI device
scsi/009 => sdb (test scsi atomic writes)                    [not run]
    xfs_io does not support the statx atomic write fields
# ./check nvme/059
nvme/059 => nvme1n1 (test atomic writes)                     [not run]
    runtime  0.081s  ...  
    xfs_io does not support the statx atomic write fields
and then I upgrade the xfs_io to 6.13.0:

# xfs_io -V
xfs_io version 6.13.0

# ./check scsi/009
scsi/*** => nvme1n1                                          [not run]
    /dev/nvme1n1 is not a SCSI device
scsi/009 => sdb (test scsi atomic writes)                    [passed]
    runtime    ...  0.271s
]# ./check nvme/059
nvme/059 => nvme1n1 (test atomic writes)                     [passed]
    runtime    ...  0.078s
everything looks good now!!
please merge your new patch to the repo,
Thanks!

