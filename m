Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EBAE7717F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2024 04:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=72vwu0G+qHVUZ2+EwwWrNp3VSN0O2dENhZSoHxh9RYE=; b=rpzSJoiLrnwqN1Esp1HxCv3Wl+
	O7UGmMC8EEXvrFC5a3mnZAdMaiXVR0qjGky/ZP5w+AStyENii28mhqIYWtxMCLo2vIZeVBiG9Rdsv
	o3smc4wYaLZ8ucAhsUrmbJ06Ow+tz8XnNK00zi5bY20i2OXD83zm+Dbdv4hpMdf0K33bVqwVbW865
	ZxhuCHHf2mCQ/sWa5t6tKy1Fa8hJ6ZJJ6m90iJaGWTSut77wRO8e5+MrwSLor/MbDPuzjPYtnMbYn
	hT53SrhciW8Got20/JNYMYOx6egLoYGAO1Of12SNwmsD91kADZutI3r/RrYxLbZ2zaspvTQgMa+FF
	oxCATDWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLx9B-00000002fNm-2UHQ;
	Fri, 13 Dec 2024 04:19:25 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLx98-00000002fMj-2meI
	for linux-nvme@lists.infradead.org;
	Fri, 13 Dec 2024 04:19:23 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCNwIJR027606;
	Fri, 13 Dec 2024 04:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=72vwu0G+qHVUZ2+EwwWrNp3VSN0O
	2dENhZSoHxh9RYE=; b=DZqu5RsZAvKYp84JSGKNjIp/Jr2Xf96HPjoKpsensds+
	sx3x5oboQ8gddSEfFf6VUo3RSYEStqFkUbvcbJQyme9EgCc2w151MgeHbkzxfNWJ
	Z1N+CSbgXUZJRtnbuzn57LHRRNvMdGOmLkx6iB+fI17Ry8Ry5wW+NPjyGKqFAsEu
	E+5n2KUY30nXnl0itJDpHjxgFnI5WYOG09yh+0O575Nwpnr+6UoonmCsAlWFxxQl
	3gqpvzv5ALDnqH498mMGhiuH5Nmv2oEXc3q5YegNa47GUaYAyjGiYLnX55ibUER3
	ToQmgbHSEfn6+XQ4XejXO0oDDAnJnyGMrAs+TK1MUg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g9yhgtxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 04:19:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD35TPr007796;
	Fri, 13 Dec 2024 04:19:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ft11wfjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 04:19:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BD4JANb36307304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:19:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8891720040;
	Fri, 13 Dec 2024 04:19:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D035C20043;
	Fri, 13 Dec 2024 04:19:08 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 04:19:08 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: dwagner@suse.de, hare@suse.de
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        gjoyce@linux.ibm.com, linux-nvme@lists.infradead.org
Subject: [PATCHv6 RFC 0/3] Add visibility for native NVMe multipath using sysfs
Date: Fri, 13 Dec 2024 09:48:33 +0530
Message-ID: <20241213041908.1381196-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rx9yDaC0knNks5p6zumrq7Iyt7dX4PSc
X-Proofpoint-ORIG-GUID: rx9yDaC0knNks5p6zumrq7Iyt7dX4PSc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130028
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_201922_730595_A4CAB0AA 
X-CRM114-Status: GOOD (  24.59  )
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

This RFC propose adding new sysfs attributes for adding visibility of
nvme native multipath I/O.

The changes are divided into three patches.
The first patch adds visibility for round-robin io-policy.
The second patch adds visibility for numa io-policy.
The third patch adds the visibility for queue-depth io-policy.

As we know, NVMe native multipath supports three different io policies
(numa, round-robin and queue-depth) for selecting I/O path, however, we
don't have any visibility about which path is being selected by multipath
code for forwarding I/O. This RFC helps add that visibility by adding new
sysfs attribute files named "numa_nodes" and "queue_depth" under each
namespace block device path /sys/block/nvmeXcYnZ/. We also create a
"multipath" sysfs directory under head disk node and then from this
directory add a link to each namespace path device this head disk node
points to.

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

Please note that numa node 0 though online, doesn't have any CPU
currently assigned to it.

# nvme list -v
Subsystem        Subsystem-NQN                                                                                    Controllers
---------------- ------------------------------------------------------------------------------------------------ ----------------
nvme-subsys1     nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:S6RTNE0R900057                                     nvme0, nvme1
nvme-subsys3     nqn.2019-10.com.kioxia:KCM7DRUG1T92:3D60A04906N1                                                 nvme2, nvme3
nvme-subsys4     nvmet_subsystem                                                                                  nvme4, nvme5

Device           Cntlid SN                   MN                                       FR       TxPort Address        Slot   Subsystem    Namespaces
---------------- ------ -------------------- ---------------------------------------- -------- ------ -------------- ------ ------------ ----------------
nvme0    66     S6RTNE0R900057       3.2TB NVMe Gen4 U.2 SSD III              REV.SN66 pcie   052e:78:00.0   U50EE.001.WZS000E-P3-C14-R1 nvme-subsys1 nvme1n1
nvme1    65     S6RTNE0R900057       3.2TB NVMe Gen4 U.2 SSD III              REV.SN66 pcie   058e:78:00.0   U50EE.001.WZS000E-P3-C14-R2 nvme-subsys1 nvme1n1
nvme2    2      3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               REV.CAS2 pcie   0524:28:00.0   U50EE.001.WZS000E-P3-C4-R1 nvme-subsys3 nvme3n1
nvme3    1      3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               REV.CAS2 pcie   0584:28:00.0   U50EE.001.WZS000E-P3-C4-R2 nvme-subsys3 nvme3n1
nvme4    1      a224673364d1dcb6fab9 Linux                                    6.9.0-rc tcp    traddr=20.0.0.200,trsvcid=4420,src_addr=20.0.0.100        nvme-subsys4 nvme4n1
nvme5    2      a224673364d1dcb6fab9 Linux                                    6.9.0-rc tcp    traddr=10.0.0.200,trsvcid=4420,src_addr=10.0.0.100        nvme-subsys4 nvme4n1

Device            Generic           NSID       Usage                      Format           Controllers
----------------- ----------------- ---------- -------------------------- ---------------- ----------------
/dev/nvme1n1 /dev/ng1n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme0, nvme1
/dev/nvme3n1 /dev/ng3n1   0x2          0.00   B /   5.75  GB      4 KiB +  0 B   nvme2, nvme3
/dev/nvme4n1 /dev/ng4n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme4, nvme5


# nvme show-topology
nvme-subsys1 - NQN=nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:S6RTNE0R900057
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:41528538-e8ad-4eaf-84a7-9c552917d988
               iopolicy=numa
\
 +- ns 1
 \
  +- nvme0 pcie 052e:78:00.0 live optimized
  +- nvme1 pcie 058e:78:00.0 live optimized

nvme-subsys3 - NQN=nqn.2019-10.com.kioxia:KCM7DRUG1T92:3D60A04906N1
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:41528538-e8ad-4eaf-84a7-9c552917d988
               iopolicy=round-robin
\
 +- ns 2
 \
  +- nvme2 pcie 0524:28:00.0 live optimized
  +- nvme3 pcie 0584:28:00.0 live optimized

nvme-subsys4 - NQN=nvmet_subsystem
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:41528538-e8ad-4eaf-84a7-9c552917d988
               iopolicy=queue-depth
\
 +- ns 1
 \
  +- nvme4 tcp traddr=20.0.0.200,trsvcid=4420,src_addr=20.0.0.100 live optimized
  +- nvme5 tcp traddr=10.0.0.200,trsvcid=4420,src_addr=10.0.0.100 live optimized

As we could see above, we've three shared namespaces created. In terms of
iopolicy, we have "numa" configured for nvme-subsys1, "round-robin"
configured for nvme-subsys3 and "queue-depth" configured for nvme-subsys4.

Now, under each namespace "head disk node", we create a sysfs group
attribute named "multipath". The "multipath" group then points to the
each path this head disk node points to:

# tree /sys/block/nvme1n1/multipath/
/sys/block/nvme1n1/multipath/
├── nvme1c0n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme0/nvme1c0n1
└── nvme1c1n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme1/nvme1c1n1

# tree /sys/block/nvme3n1/multipath/
/sys/block/nvme3n1/multipath/
├── nvme3c2n1 -> ../../../../../pci0524:28/0524:28:00.0/nvme/nvme2/nvme3c2n1
└── nvme3c3n1 -> ../../../../../pci0584:28/0584:28:00.0/nvme/nvme3/nvme3c3n1

# tree /sys/block/nvme4n1/multipath/
/sys/block/nvme4n1/multipath/
├── nvme4c4n1 -> ../../../../nvme-fabrics/ctl/nvme4/nvme4c4n1
└── nvme4c5n1 -> ../../../../nvme-fabrics/ctl/nvme5/nvme4c5n1

One can easily infer from the above output that for the "round-robin"
I/O policy, configured under nvme-subsys3, the I/O workload targeted at
nvme3n1 would toggle across nvme3c2n1 and nvme3c3n1 assuming the ana state
of each path is optimized (as can be seen in the output of show-topology).

For numa I/O policy, configured under nvme-subsys1, the "numa_nodes"
attribute file shows the numa nodes being preferred by the respective
namespace path. The numa nodes value is comma delimited list of nodes or
A-B range of nodes.

# cat  /sys/block/nvme1n1/multipath/nvme1c0n1/numa_nodes
0-1

# cat  /sys/block/nvme1n1/multipath/nvme1c1n1/numa_nodes
2-3

From the above output, one can easily infer that I/O workload targeted at
nvme1n1 and running on numa nodes 0 and 1 would use path nvme1c0n1.
Similarly, I/O workload running on numa nodes 2 and 3 would use path
nvme1c1n1.

For queue-depth I/O policy, configured under nvme-subsys4, the "queue_depth"
attribute file shows the number of active/in-flight I/O requests currently
queued for each path.

# cat  /sys/block/nvme4n1/multipath/nvme4c4n1/queue_depth
518

# cat  /sys/block/nvme4n1/multipath/nvme4c5n1/queue_depth
504

From the above output, one can easily infer that I/O workload targeted at
nvme4n1 uses two paths nvme4c4n1 and nvme4c5n1 and the current queue depth
of each path is 518 and 504 respectively.

Changes since v5:
    - Fix typo in the subject line of the first patch in the series (Danied
      Wagner)
    - Link to v5: https://lore.kernel.org/all/20241030104156.747675-1-nilay@linux.ibm.com/  
changes since v4:
    - Ensure that we create sysfs link from head gendisk node to each path
      device irrespective of the ANA state of the path (Hannes Reinecke)
    - Split the patch into three patch series and add commentary in the
      code so that it's easy to read and understand the core logic (Sagi
      Grimberg)
    - Don't show any output if user reads "numa_nodes" file and configured
      iopolicy is anything but numa; similarly don't emit any output if user
      reads "queue_depth" file and configured iopolicy is anything but
      queue-depth (Sagi Grimberg)
    - Link to v4: https://lore.kernel.org/all/20240911062653.1060056-1-nilay@linux.ibm.com/	  

Changes since v3:
    - Protect the namespace dereference code with srcu read lock (Daniel Wagner)
    - Link to v3: https://lore.kernel.org/all/20240903135228.283820-1-nilay@linux.ibm.com/	

Changes since v2:
    - Use one value per one sysfs attribute (Keith Busch)
    - Link to v2: https://lore.kernel.org/all/20240809173030.2281021-1-nilay@linux.ibm.com/	

Changes since v1:
    - Use sysfs to export multipath I/O information instead of debugfs
    - Link to v1: https://lore.kernel.org/all/20240722093124.42581-1-nilay@linux.ibm.com/	

Nilay Shroff (3):
  nvme-multipath: Add visibility for round-robin io-policy
  nvme-multipath: Add visibility for numa io-policy
  nvme-multipath: Add visibility for queue-depth io-policy

 drivers/nvme/host/core.c      |   3 +
 drivers/nvme/host/multipath.c | 120 ++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  20 ++++--
 drivers/nvme/host/sysfs.c     |  20 ++++++
 4 files changed, 159 insertions(+), 4 deletions(-)

-- 
2.45.2


