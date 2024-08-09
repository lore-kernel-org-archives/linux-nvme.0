Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6DAC3DA4A
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Aug 2024 17:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KKVQAdlLBd820cUBfpsL7J6Msuf9hs+1Y1vSSVaOMJQ=; b=5El+ArDPPngywxzN6J9crAtpt1
	pi5DIB9gq5RiF3gmMOT6aVCyPB24rgmF+97hcwJile69CFYpSsgzGx8EViExEY0LWkFWGx09VmFnT
	XDTfzQzKD6vgcL8msM23tHj7HfQ7jxVIR3T5GK2yh33dK8pAVZFYnZ/bhdV3VZ5nUZ/CU30u56qcE
	OPkamAvrrW5Vtd0ANu5ghcZFpH/AbgWVyFrPSsMSQ09UGv7ot0RsvhuEbVBRkR3H8M9p2ETzWTkP1
	Zdfg9VqVezqgS54EJjwoQZO7hfGnGT/pr6rR2X/hdlCP5dW6cePFKP4moQRJEAxh4IVtx36qp5LCd
	k4gfj9bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scTSK-0000000C4pd-3MEC;
	Fri, 09 Aug 2024 17:31:12 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scTSG-0000000C4os-0WAx
	for linux-nvme@lists.infradead.org;
	Fri, 09 Aug 2024 17:31:10 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4796G3Ln003074;
	Fri, 9 Aug 2024 17:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pp1; bh=KKVQAdlLBd820
	cUBfpsL7J6Msuf9hs+1Y1vSSVaOMJQ=; b=cts5uk8RjFa203dPWQRp4ZQjzumG6
	H0Ysh1ABV3UbNQKnoQPyLLxXD4IOHATadjuZ0I6YpkU54uaDVJ66UOsrBDIIi624
	1o5SkWtyzg/VasTpnczuYBkJjqrj0J7ED3Rwx2hvVojlAh4wLzBoUCUerdp1WhCT
	SMCMo/w8wLV5vcjmAmlYliqB9hlKWqvIka9RrPmBiFViE3Amyhi+yGp7E0fUVDUK
	chV5dPpaW/HtZl4eipM2teUB724CFaz1y0CYA/GdVwsf6IEpQlIruMnjXdEGtT+I
	/angDL2T7VgsNL1EVhqE1hciPIVIjX6cetOVv+QLBWF6F8ozKykcT0k/Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkc3j99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 17:30:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 479EZgOm018615;
	Fri, 9 Aug 2024 17:30:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40sxvumv93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 17:30:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 479HUisg55247242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 17:30:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76E8A2004E;
	Fri,  9 Aug 2024 17:30:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCB3520040;
	Fri,  9 Aug 2024 17:30:42 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.5.214])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Aug 2024 17:30:42 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [RFC PATCH v2 0/1] Add visibility for native NVMe multipath using sysfs
Date: Fri,  9 Aug 2024 22:59:56 +0530
Message-ID: <20240809173030.2281021-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZYtGCWzHw58t6bx3J3h8CafxJ_r1erdp
X-Proofpoint-ORIG-GUID: ZYtGCWzHw58t6bx3J3h8CafxJ_r1erdp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_13,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240809_103108_404311_DF4A1513 
X-CRM114-Status: GOOD (  22.67  )
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

This patch propose adding new sysfs attributes for adding visibility of
native multipath I/O. The previous version of this RFC[1] proposed using 
debugfs for visibility however the general feedback was to instead export 
the multipath I/O information using sysfs attributes and then latter parse
and format those sysfs attributes using libnvme/nvme-cli. 

As we know, NVMe native multipath supports three different io policies 
(numa, round-robin and queue-depth) for selecting I/O path, however, we 
don't have any visibility about which path is being selected by multipath
code for forwarding I/O. This RFC propose adding three new sysfs attribute 
files named "numa", "round_robin", and "queue_depth" under the namespace 
head block path /sys/block/<nvmeXnY>/multipath/. As the name suggests, 
attribute file named "numa" shall show the information about multipath I/O 
for numa poilcy, "round_robin" shall show the information about multipath 
I/O for round-robin policy and  "queue_depth" shall show the information 
about multipath I/O for queue-depth policy.

Please find below output generated with this proposed RFC patch applied on 
a system with two multi-controller PCIe NVMe disks attached to it. This 
system is also an NVMf-TCP host which is connected to an NVMf-TCP target 
over two NIC cards. This system has four numa nodes online when the below 
output was captured:

# cat /sys/devices/system/node/online 
0-3

# lscpu
<snip>
NUMA:
  NUMA node(s):           4
  NUMA node0 CPU(s):
  NUMA node1 CPU(s):      0-7
  NUMA node2 CPU(s):      8-31
  NUMA node3 CPU(s):      32-63
<snip>

Please note that numa node 0 though online, doesn't have any CPU assigned to it.

# nvme list -v 
Subsystem        Subsystem-NQN                                                                                    Controllers
---------------- ------------------------------------------------------------------------------------------------ ----------------
nvme-subsys0     nvmet_subsystem                                                                                  nvme0, nvme3
nvme-subsys2     nqn.2019-10.com.kioxia:KCM7DRUG1T92:3D60A04906N1                                                 nvme1, nvme2
nvme-subsys4     nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:S6RTNE0R900057                                     nvme4, nvme5

Device           Cntlid SN                   MN                                       FR       TxPort Address        Slot   Subsystem    Namespaces      
---------------- ------ -------------------- ---------------------------------------- -------- ------ -------------- ------ ------------ ----------------
nvme0    1      a224673364d1dcb6fab9 Linux                                    6.9.0-rc tcp    traddr=20.0.0.200,trsvcid=4420,src_addr=20.0.0.100        nvme-subsys0 nvme0n1
nvme1    2      3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               REV.CAS2 pcie   0524:28:00.0   U50EE.001.WZS000E-P3-C4-R1 nvme-subsys2 nvme2n2
nvme2    1      3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               REV.CAS2 pcie   0584:28:00.0   U50EE.001.WZS000E-P3-C4-R2 nvme-subsys2 nvme2n2
nvme3    2      a224673364d1dcb6fab9 Linux                                    6.9.0-rc tcp    traddr=10.0.0.200,trsvcid=4420,src_addr=10.0.0.100        nvme-subsys0 nvme0n1
nvme4    65     S6RTNE0R900057       3.2TB NVMe Gen4 U.2 SSD III              REV.SN66 pcie   058e:78:00.0   U50EE.001.WZS000E-P3-C14-R2 nvme-subsys4 nvme4n1
nvme5    66     S6RTNE0R900057       3.2TB NVMe Gen4 U.2 SSD III              REV.SN66 pcie   052e:78:00.0   U50EE.001.WZS000E-P3-C14-R1 nvme-subsys4 nvme4n1

Device            Generic           NSID       Usage                      Format           Controllers     
----------------- ----------------- ---------- -------------------------- ---------------- ----------------
/dev/nvme0n1 /dev/ng0n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme0, nvme3
/dev/nvme2n2 /dev/ng2n2   0x2          0.00   B /   5.75  GB      4 KiB +  0 B   nvme1, nvme2
/dev/nvme4n1 /dev/ng4n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme4, nvme5

As we could see above, we've three shared namespaces created and for each 
shared namespace there's a head disk node created. In terms of iopolicy, 
we have "queue-depth" configured for nvme-subsys0, "numa" configured 
for nvme-subsys2 and "round-robin" configured for nvme-subsys4.

# cat /sys/class/nvme-subsystem/nvme-subsys0/iopolicy
queue-depth
# cat /sys/class/nvme-subsystem/nvme-subsys2/iopolicy
numa
# cat /sys/class/nvme-subsystem/nvme-subsys4/iopolicy
round-robin

Now, under each "namespace head disk node", we create sysfs attributes 
"numa", "round-robin" and "queue-depth" as shown below. 

# tree /sys/block/nvme0n1/multipath/
/sys/block/nvme0n1/multipath/
├── numa
├── queue_depth
└── round_robin

0 directories, 3 files

# tree /sys/block/nvme2n2/multipath/
/sys/block/nvme2n2/multipath/
├── numa
├── queue_depth
└── round_robin

0 directories, 3 files

# tree /sys/block/nvme4n1/multipath/
/sys/block/nvme4n1/multipath/
├── numa
├── queue_depth
└── round_robin

0 directories, 3 files

The mutlipath I/O information for each of the above head disk node and 
it's respective iopolicy is then respresented as below.

# cat /sys/block/nvme0n1/multipath/queue_depth 
nvme0c0n1 423
nvme0c3n1 425

In the above output, we print the multipath I/O information about the 
queue_depth iopolicy as the head disk node "nvme0n1" is defined under 
nvme-subsys0 which has queue-depth iopolicy configured. For queue-depth 
iopolicy, it doesn't matter on which numa node IO workload is running. So 
we print each I/O path once and its respective current queue depth.

# cat /sys/block/nvme2n2/multipath/numa 
node1: nvme2c1n2
node2: nvme2c2n2
node3: nvme2c2n2

In the above output, we print the multipath I/O information about the numa 
iopolicy as the head disk node "nvme2n2" is defined under nvme-subsys2 
which has numa iopolicy configured. For numa iopolicy, we print the 
preferred I/O path for each numa node.

# cat /sys/block/nvme4n1/multipath/round_robin 
node1: nvme4c4n1 nvme4c5n1 
node2: nvme4c4n1 nvme4c5n1 
node3: nvme4c5n1 nvme4c4n1 

In the above output, we print the multipath I/O information about the 
round-robin iopolicy as the head disk node "nvme4n1" is defined under 
nvme-subsys4 which has round-robin iopolicy configured. For round-robin 
iopolicy, we print the per node I/O paths in round-robin fashion.

Please note that we don't print ana_state information in the above output 
because that could be retrieved from another sysfs attribute per I/O path. 
Also we don't print I/O controller in the output because that can be also 
easily made up from the respective I/O path. For instance, I/O path 
nvme4c5n1 is accessible from controller nvme5. 

IMO, once we have above information exported through sysfs, we shall be 
able to easily parse it in libnvme/nvme-cli and use it to further extend 
the output of nvme show-topology command or add a new nvme-cli command.

[1] https://lore.kernel.org/all/20240722093124.42581-1-nilay@linux.ibm.com/

Changes since v1:
    - Use sysfs to export multipath I/O information instead of debugfs
	 
Nilay Shroff (1):
  nvme-multipath: Add sysfs attributes for showing multipath info

 drivers/nvme/host/multipath.c |   2 +-
 drivers/nvme/host/nvme.h      |   1 +
 drivers/nvme/host/sysfs.c     | 108 ++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 1 deletion(-)

-- 
2.45.2


