Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D822C3DA59
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 09:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vpM+gr5WWNv9cGkrrnnxJw/x9yuJ4y6/Q/tQKCWi2QA=; b=cx0pR0qonSlpuxtDpiJIeQD99C
	PU4t3g4vJePUVmJ4033rhHP2Lf54wfwFeoCtFh28yj0yJT3PW2xPbsmsNETj3GrHjnToMBw0/Ui96
	LCdhUh4/6EcCtWD33I4eM8daJ0mx9p6u5u0PrDWx5g0HKBpvdX/4QgvWKJhEHTSWXUpZzFLZFdQgD
	soufMPZZokM5Wn4RdZ6q/bex7/xXPpwDDtMh7vxrPrTCkEyyPiLfeiEY/+Y9DjrpqQ7ljBjjCViCc
	IF8aSyi+Yo6hIvXdINbPi31J1qM6u0NRP9vQZ9L+yHeafNMvK4+RGS/bLSwAF24ytU0WLlJEvHx2X
	5gqEcMag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVpOc-000000093EM-1sqU;
	Mon, 22 Jul 2024 09:31:54 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVpOY-000000093Dh-2tF2
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 09:31:52 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M8gRH9010994;
	Mon, 22 Jul 2024 09:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=vpM+gr5WWNv9cGkrrnnxJw/x9y
	uJ4y6/Q/tQKCWi2QA=; b=BMAI/f8KaUS2WeG3+rx2nX2dVk+DuGVWYGLKscAMgY
	8utu4WHWI+zsa2mjt37+S9LEx9/jrSuxBo+NQYPH1TgSUKUWGNWJmq6rWo+9XXDB
	kW1gJmfIRKWPwz4g+7Hm7OOVrPH1UVIS8UIrJHlbWioSmPQPN9ZePQd+H1YNrxCg
	0L2k94KThbxgl/D528bwJKWHFGeatRoOoSIaH6W/HXblm5ve3h0siKFd8EbhzT4G
	q9Ft9VVGgFFpwpijXwex0qHahmRGDzrvPckA0+jPQv5T3+sQdpTuZ5ugsAjjCfWV
	XcRFJD0X7a59Xi4N8fRvfaiHFMy7ZjBXpzbP1Agf6HTw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40gr8vtqyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 09:31:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46M5m9eu006259;
	Mon, 22 Jul 2024 09:31:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gqju626y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 09:31:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46M9VSU730212608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 09:31:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 977CE2004E;
	Mon, 22 Jul 2024 09:31:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 137A720063;
	Mon, 22 Jul 2024 09:31:27 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.253])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jul 2024 09:31:26 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH RFC 0/1] Add visibility for native NVMe miltipath using debugfs
Date: Mon, 22 Jul 2024 15:01:08 +0530
Message-ID: <20240722093124.42581-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -UsqRf9Z6DKKnFFpbOTuVUyNkQAIndtW
X-Proofpoint-ORIG-GUID: -UsqRf9Z6DKKnFFpbOTuVUyNkQAIndtW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_05,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=700 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1011 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407220072
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_023150_757172_3809091E 
X-CRM114-Status: GOOD (  21.34  )
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

This patch propose adding a new debugfs file entry for NVMe native 
multipath. As we know NVMe native multipath today supports three different
io-policies (numa, round-robin and queue-depth) for selecting optimal I/O
path and forwarding data. However we don't have yet any visibility to find
the I/O path being selected by NVMe native multipath code.

IMO, it'd be nice to have this visibility information available under 
debugfs which could help a user to validate the I/O path being chosen is 
optimal for a given io policy. This patch propose adding a debugfs file 
for each head disk node on the system. The proposal is to create a file 
named "multipath" under "/sys/kernel/debug/nvmeXnY/".

Please find below output generated with this patch applied on a system 
with a multi-controller PCIe NVMe disk attached to it. This system is also
an NVMf-TCP host which is connected to NVMf-TCP target over two NIC cards. 
This system has two numa nodes online when the below output was captured:

# cat /sys/devices/system/node/online
2-3

# nvme list -v
Subsystem        Subsystem-NQN                                                                                    Controllers
---------------- ------------------------------------------------------------------------------------------------ ----------------
nvme-subsys1     nvmet_subsystem                                                                                  nvme1, nvme3
nvme-subsys2     nqn.2019-10.com.kioxia:KCM7DRUG1T92:3D60A04906N1                                                 nvme0, nvme2

Device           Cntlid SN                   MN                                       FR       TxPort Address        Slot   Subsystem    Namespaces
---------------- ------ -------------------- ---------------------------------------- -------- ------ -------------- ------ ------------ ----------------
nvme0    2      3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               REV.CAS2 pcie   0524:28:00.0   U50EE.001.WZS000E-P3-C4-R1 nvme-subsys2 nvme2n2
nvme2    1      3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               REV.CAS2 pcie   0584:28:00.0   U50EE.001.WZS000E-P3-C4-R2 nvme-subsys2 nvme2n2
nvme1    1      a224673364d1dcb6fab9 Linux                                    6.9.0    tcp    traddr=10.0.0.200,trsvcid=4420,src_addr=10.0.0.100        nvme-subsys1 nvme1n1
nvme3    2      a224673364d1dcb6fab9 Linux                                    6.9.0    tcp    traddr=20.0.0.200,trsvcid=4420,src_addr=20.0.0.100        nvme-subsys1 nvme1n1

Device            Generic           NSID       Usage                      Format           Controllers
----------------- ----------------- ---------- -------------------------- ---------------- ----------------
/dev/nvme1n1 /dev/ng1n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme1, nvme3
/dev/nvme2n2 /dev/ng2n2   0x2          0.00   B /   5.75  GB      4 KiB +  0 B   nvme0, nvme2


# cat /sys/class/nvme-subsystem/nvme-subsys2/iopolicy
numa

# cat /sys/kernel/debug/block/nvme2n2/multipath
io-policy: numa
io-path:
--------
node  current-path  ctrl    ana-state
2     nvme2c2n2     nvme2   optimized
3     nvme2c0n2     nvme0   optimized

The above output shows that current selected iopolicy is numa. And when we 
have workload running I/O on numa node 2, accessing namespace "nvme2n2", 
it uses path nvme2c2n2 and controller nvme2 for forwarding data. Moreover
the current ana-state for this path is optimized. Similarly, for I/O 
workload running on numa node 3 would use path nvme2c0n2 and controller
nvme0.

Now changing the iopolicy to round-robin,

# echo "round-robin" > /sys/class/nvme-subsystem/nvme-subsys2/iopolicy

# cat /sys/kernel/debug/block/nvme2n2/multipath
io-policy: round-robin
io-path:
--------
node  rr-path       ctrl    ana-state
2     nvme2c2n2     nvme2   optimized
2     nvme2c0n2     nvme0   optimized
3     nvme2c2n2     nvme2   optimized
3     nvme2c0n2     nvme0   optimized

The above output shows that current selected iopolicy is round-robin, and
when we have I/O workload running on numa node 2, accessing namespace 
"nvme2n2", the I/O path would toggle between nvme2c2n2/nvme2 and 
nvme2c0n2/nvme0. And the same is true for I/O workload running on node 3. 
Both I/O paths are currently optimized.

The namespace "nvme1n1" is accessible over fabric(NVMf-TCP).

# cat /sys/kernel/debug/block/nvme1n1/multipath
io-policy: queue-depth
io-path:
--------
node  path          ctrl    qdepth      ana-state
2     nvme1c1n1     nvme1   1328        optimized
2     nvme1c3n1     nvme3   1324        optimized
3     nvme1c1n1     nvme1   1328        optimized
3     nvme1c3n1     nvme3   1324        optimized

The above output was captured while I/O was running and accessing 
namespace nvme1n1. From the above output, we see that iopolicy is set to 
"queue-depth". When we have I/O workload running on numa node 2, accessing
namespace "nvme1n1", the I/O path nvme1c1n1/nvme1 has queue depth of 1328 
and another I/O path nvme1c3n1/nvme3 has queue depth of 1324. Both paths 
are optimized and seems that both paths are equally utilized for 
forwarding I/O. The same could be said for workload running on numa 
node 3.

Nilay Shroff (1):
  nvme-multipath: Add debugfs entry for showing multipath info

 drivers/nvme/host/multipath.c | 92 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 93 insertions(+)

-- 
2.45.2


