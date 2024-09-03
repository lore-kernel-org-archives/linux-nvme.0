Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30C8CD3435
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 13:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WwEuxYZiNraP0FLq6cWKUmZdY0I29F+zNHPM16Rm/ZY=; b=z7ffjt6Wk7V9Fbprh71b/PChyK
	BdAZ7PN6q4QZCJkq2vorrt7v8w2B/3tHV/XzGAZVnviIn+PyCYfGHGjXoHrSVNN/r3VsXh9tqEn7T
	eGiPlbTVN86WxX2A8eeoQdwMl/OVFUp7JzFnGwaF3MqW8jr0M79NvB3Zz86vpw2x2jqj+/LtnRPH/
	nvXsqB5rR+FxC8oRZtXMF9YUgrJxaOk2IJ20Zj/Tnrv02nICOBslXfoTCl/egUJDOQ3/hfnhanUVg
	ZxKeBmQFk4ne/mFC6QqRq1K5PnMwfS2qjNjJTqAKX9RZXWxktWYGc9UkO44uVvlBokHZ+Na3ItH5/
	wV8pQ3Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slTxh-00000000Qft-3j6P;
	Tue, 03 Sep 2024 13:52:49 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slTxf-00000000QdZ-0V5d
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 13:52:48 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483Dn6Ks032605;
	Tue, 3 Sep 2024 13:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pp1; bh=WwEuxYZiNraP0
	FLq6cWKUmZdY0I29F+zNHPM16Rm/ZY=; b=IAQk+VCeURCb1ztvWHaGcJrbSWJlH
	MpDNOYW+3OH67oqRHl+Xs6KtEPtbA0iYW0QMdijuD8jiIJbYNseWvW9hjd52DHGF
	GtG4VrLyGPTfFFdFYUY3OYkH1K8/de9AO88R035OP6ueytyMmQOCtnm7tVhhDViA
	1WEKx4CWtBhCkrLxUyq26+/STftvtqOCUyuvvHne0Cye/vb0eNMkSafkjLKSYm/j
	2dyXGSDQk8jb2gkN1snrTk4OeTCltNXZu3bhh186iiEOwXP0pXhjWHr3T2Fvr7H7
	d0DuvOUnEzrTzq/9XnmB42JlDgmezAz30YlSVYSp2mvHpytqJ/8lDDf3w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btuwx0rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 13:52:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 483D86vF009162;
	Tue, 3 Sep 2024 13:52:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41cg73jne8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 13:52:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 483DqYLt42271142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Sep 2024 13:52:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06D2420040;
	Tue,  3 Sep 2024 13:52:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B10220043;
	Tue,  3 Sep 2024 13:52:32 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.179.29.238])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Sep 2024 13:52:31 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 RFC 0/1] Add visibility for native NVMe multipath using sysfs
Date: Tue,  3 Sep 2024 19:22:18 +0530
Message-ID: <20240903135228.283820-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4NQ8eAO16MIrIDis1T1NIMz8KcryxXjF
X-Proofpoint-ORIG-GUID: 4NQ8eAO16MIrIDis1T1NIMz8KcryxXjF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_065247_223404_5EAD3BF0 
X-CRM114-Status: GOOD (  22.36  )
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
native multipath I/O. 

The first version of this RFC[1] proposed using debugfs for visibility 
however the general feedback was to instead export the multipath I/O 
information using sysfs attributes and then latter parse and format those 
sysfs attributes using libnvme/nvme-cli. 

The second version of this RFC[2] uses sysfs however the sysfs attribute 
file contains multiple lines of output and the feedback was to instead
follow the principal of one value per one attribute. 

So now third version of this RFC follows the one value per one attrbiute
principal.

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

[1] https://lore.kernel.org/all/20240722093124.42581-1-nilay@linux.ibm.com/
[2] https://lore.kernel.org/all/20240809173030.2281021-2-nilay@linux.ibm.com/

Changes since v2:
	- Use one value per one sysfs attribute (Keith Busch)

Changes since v1:
    - Use sysfs to export multipath I/O information instead of debugfs

Nilay Shroff (1):
  nvme-multipath: Add sysfs attributes for showing multipath info

 drivers/nvme/host/core.c      |  3 ++
 drivers/nvme/host/multipath.c | 69 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      | 20 ++++++++--
 drivers/nvme/host/sysfs.c     | 20 ++++++++++
 4 files changed, 108 insertions(+), 4 deletions(-)

-- 
2.45.2


