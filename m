Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A30E7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 07:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z99fqURCazA+OYQEZe+JtmrLWViLmhdZS8HCpmkprDo=; b=246ux0vWgz8Z1XEjZYbuje5Qxy
	cOK+2kCJOzc6CqAkcNllaNaNFCRfaFiP1pUujEI/yjlsWMxsKqL6WZgxAoPL1AkO+EVcJcMLERgs1
	DwA6kPcphBgC/EHnU9NsKGHp6dQRVX/11IvJAYGLCOgf7XFhl2kVy9faoGlxKFp241jL45F3dzXMj
	8F+AfbcEQY8x9BdQVZr/sEvG1xDwDTCPN0iMPf5/Cz2keid5aWkx+d2laKsrHusPL9ELuQ+rqg1Wg
	9NatHjkb+fmTecfHf4u9yFKD1LT3ekGKlDseghPowEJIS6W4iECcJM6+7zrK+bffvNlid6OG6UaFx
	QSQOlnZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKuI3-0000000AV0v-0BoJ;
	Tue, 10 Dec 2024 07:04:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKuHp-0000000AUzc-0mqz
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 07:04:02 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9MvfgL031336;
	Tue, 10 Dec 2024 07:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Z99fqU
	RCazA+OYQEZe+JtmrLWViLmhdZS8HCpmkprDo=; b=bXfzotCPDlrYh6ZtllljqN
	gqzT/ZFz7NVEW8Gcv1nAdMs7LTDmPFXj+IPKkCeW6TWb4vz/ThybJ6bCuZsaHFX9
	IijiKgbg+7yowmyco8Xb6d4zevPjZWPeIUlJMm42bpwaxdUnyiy9jXHudOsn60M4
	QRej2ckd7+/+5b+69O7pQcfJlOmzqgrVXY5DAW/IZTzc6M6zssKyf6sdCbYzBFx8
	fOQkEfOn929PHLhr4AMt+kPjGhxXyjX1L+uDEm78eg62x6InEh3+gNWH2YCjurLw
	5ea7bwuVyfK6g6XPPfo5QwAlgiEoQl72wc//Wgilx+XWYzA3v+GhweYPRCjuM5VQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vnjw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 07:03:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA6g3hN016911;
	Tue, 10 Dec 2024 07:03:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12y2mhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 07:03:50 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BA73oGZ64815464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 07:03:50 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C15E5807A;
	Tue, 10 Dec 2024 07:03:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 750225807B;
	Tue, 10 Dec 2024 07:03:47 +0000 (GMT)
Received: from [9.109.198.241] (unknown [9.109.198.241])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Dec 2024 07:03:47 +0000 (GMT)
Message-ID: <dd45a4d8-a6c6-4a9c-961d-4bdf251658c3@linux.ibm.com>
Date: Tue, 10 Dec 2024 12:33:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 RFC 0/3] Add visibility for native NVMe multipath using
 sysfs
From: Nilay Shroff <nilay@linux.ibm.com>
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
        Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, gjoyce@linux.ibm.com, "axboe@fb.com" <axboe@fb.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20241030104156.747675-1-nilay@linux.ibm.com>
 <10f38d85-e9ac-46b0-9a3e-dcbae26b36d8@linux.ibm.com>
 <46e833ef-5536-4528-8a13-4b79f13e1acf@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <46e833ef-5536-4528-8a13-4b79f13e1acf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XJXejP4VeiAhCY46Bl98_blhwaH75XGS
X-Proofpoint-ORIG-GUID: XJXejP4VeiAhCY46Bl98_blhwaH75XGS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_230401_241733_A1A9ABA9 
X-CRM114-Status: GOOD (  28.24  )
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

Hi Hannes, Keith, Daniel,

A gentle ping on this. This has been pending for quite some time now. 
So would you please help? I have addressed all your comments. 

Please let me know if you've any further comments.

Thanks,
--Nilay

On 11/29/24 17:49, Nilay Shroff wrote:
> Hi Hannes and Sagi,
> 
> A gentle ping on this. Did you get a chance to look through this?
> 
> Please let me know if you still have any further comments.
> 
> Thanks,
> --Nilay
> 
> On 11/12/24 10:07, Nilay Shroff wrote:
>> Hi Hannes and Sagi,
>>
>> A gentle ping... I have addressed your suggestions in this patch series. 
>> Does this now look okay to you or do you have any further suggestions/comments?
>>
>> Thanks,
>> --Nilay
>>
>> On 10/30/24 16:11, Nilay Shroff wrote:
>>> Hi,
>>>
>>> This RFC propose adding new sysfs attributes for adding visibility of
>>> nvme native multipath I/O.
>>>
>>> The changes are divided into three patches.
>>> The first patch adds visibility for round-robin io-policy.
>>> The second patch adds visibility for numa io-policy.
>>> The third patch adds the visibility for queue-depth io-policy.
>>>
>>> As we know, NVMe native multipath supports three different io policies
>>> (numa, round-robin and queue-depth) for selecting I/O path, however, we
>>> don't have any visibility about which path is being selected by multipath
>>> code for forwarding I/O. This RFC helps add that visibility by adding new
>>> sysfs attribute files named "numa_nodes" and "queue_depth" under each
>>> namespace block device path /sys/block/nvmeXcYnZ/. We also create a
>>> "multipath" sysfs directory under head disk node and then from this
>>> directory add a link to each namespace path device this head disk node
>>> points to.
>>>
>>> Please find below output generated with this proposed RFC patch applied on
>>> a system with two multi-controller PCIe NVMe disks attached to it. This
>>> system is also an NVMf-TCP host which is connected to an NVMf-TCP target
>>> over two NIC cards. This system has four numa nodes online when the below
>>> output was captured:
>>>
>>> # cat /sys/devices/system/node/online
>>> 0-3
>>>
>>> # lscpu
>>> <snip>
>>> NUMA:
>>>   NUMA node(s):           4
>>>   NUMA node0 CPU(s):
>>>   NUMA node1 CPU(s):      0-7
>>>   NUMA node2 CPU(s):      8-31
>>>   NUMA node3 CPU(s):      32-63
>>> <snip>
>>>
>>> Please note that numa node 0 though online, doesn't have any CPU
>>> currently assigned to it.
>>>
>>> # nvme list -v
>>> Subsystem        Subsystem-NQN                                                                                    Controllers
>>> ---------------- ------------------------------------------------------------------------------------------------ ----------------
>>> nvme-subsys1     nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:S6RTNE0R900057                                     nvme0, nvme1
>>> nvme-subsys3     nqn.2019-10.com.kioxia:KCM7DRUG1T92:3D60A04906N1                                                 nvme2, nvme3
>>> nvme-subsys4     nvmet_subsystem                                                                                  nvme4, nvme5
>>>
>>> Device           Cntlid SN                   MN                                       FR       TxPort Address        Slot   Subsystem    Namespaces
>>> ---------------- ------ -------------------- ---------------------------------------- -------- ------ -------------- ------ ------------ ----------------
>>> nvme0    66     S6RTNE0R900057       3.2TB NVMe Gen4 U.2 SSD III              REV.SN66 pcie   052e:78:00.0   U50EE.001.WZS000E-P3-C14-R1 nvme-subsys1 nvme1n1
>>> nvme1    65     S6RTNE0R900057       3.2TB NVMe Gen4 U.2 SSD III              REV.SN66 pcie   058e:78:00.0   U50EE.001.WZS000E-P3-C14-R2 nvme-subsys1 nvme1n1
>>> nvme2    2      3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               REV.CAS2 pcie   0524:28:00.0   U50EE.001.WZS000E-P3-C4-R1 nvme-subsys3 nvme3n1
>>> nvme3    1      3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               REV.CAS2 pcie   0584:28:00.0   U50EE.001.WZS000E-P3-C4-R2 nvme-subsys3 nvme3n1
>>> nvme4    1      a224673364d1dcb6fab9 Linux                                    6.9.0-rc tcp    traddr=20.0.0.200,trsvcid=4420,src_addr=20.0.0.100        nvme-subsys4 nvme4n1
>>> nvme5    2      a224673364d1dcb6fab9 Linux                                    6.9.0-rc tcp    traddr=10.0.0.200,trsvcid=4420,src_addr=10.0.0.100        nvme-subsys4 nvme4n1
>>>
>>> Device            Generic           NSID       Usage                      Format           Controllers
>>> ----------------- ----------------- ---------- -------------------------- ---------------- ----------------
>>> /dev/nvme1n1 /dev/ng1n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme0, nvme1
>>> /dev/nvme3n1 /dev/ng3n1   0x2          0.00   B /   5.75  GB      4 KiB +  0 B   nvme2, nvme3
>>> /dev/nvme4n1 /dev/ng4n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme4, nvme5
>>>
>>>
>>> # nvme show-topology
>>> nvme-subsys1 - NQN=nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:S6RTNE0R900057
>>>                hostnqn=nqn.2014-08.org.nvmexpress:uuid:41528538-e8ad-4eaf-84a7-9c552917d988
>>>                iopolicy=numa
>>> \
>>>  +- ns 1
>>>  \
>>>   +- nvme0 pcie 052e:78:00.0 live optimized
>>>   +- nvme1 pcie 058e:78:00.0 live optimized
>>>
>>> nvme-subsys3 - NQN=nqn.2019-10.com.kioxia:KCM7DRUG1T92:3D60A04906N1
>>>                hostnqn=nqn.2014-08.org.nvmexpress:uuid:41528538-e8ad-4eaf-84a7-9c552917d988
>>>                iopolicy=round-robin
>>> \
>>>  +- ns 2
>>>  \
>>>   +- nvme2 pcie 0524:28:00.0 live optimized
>>>   +- nvme3 pcie 0584:28:00.0 live optimized
>>>
>>> nvme-subsys4 - NQN=nvmet_subsystem
>>>                hostnqn=nqn.2014-08.org.nvmexpress:uuid:41528538-e8ad-4eaf-84a7-9c552917d988
>>>                iopolicy=queue-depth
>>> \
>>>  +- ns 1
>>>  \
>>>   +- nvme4 tcp traddr=20.0.0.200,trsvcid=4420,src_addr=20.0.0.100 live optimized
>>>   +- nvme5 tcp traddr=10.0.0.200,trsvcid=4420,src_addr=10.0.0.100 live optimized
>>>
>>> As we could see above, we've three shared namespaces created. In terms of
>>> iopolicy, we have "numa" configured for nvme-subsys1, "round-robin"
>>> configured for nvme-subsys3 and "queue-depth" configured for nvme-subsys4.
>>>
>>> Now, under each namespace "head disk node", we create a sysfs group
>>> attribute named "multipath". The "multipath" group then points to the
>>> each path this head disk node points to:
>>>
>>> # tree /sys/block/nvme1n1/multipath/
>>> /sys/block/nvme1n1/multipath/
>>> ├── nvme1c0n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme0/nvme1c0n1
>>> └── nvme1c1n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme1/nvme1c1n1
>>>
>>> # tree /sys/block/nvme3n1/multipath/
>>> /sys/block/nvme3n1/multipath/
>>> ├── nvme3c2n1 -> ../../../../../pci0524:28/0524:28:00.0/nvme/nvme2/nvme3c2n1
>>> └── nvme3c3n1 -> ../../../../../pci0584:28/0584:28:00.0/nvme/nvme3/nvme3c3n1
>>>
>>> # tree /sys/block/nvme4n1/multipath/
>>> /sys/block/nvme4n1/multipath/
>>> ├── nvme4c4n1 -> ../../../../nvme-fabrics/ctl/nvme4/nvme4c4n1
>>> └── nvme4c5n1 -> ../../../../nvme-fabrics/ctl/nvme5/nvme4c5n1
>>>
>>> One can easily infer from the above output that for the "round-robin"
>>> I/O policy, configured under nvme-subsys3, the I/O workload targeted at
>>> nvme3n1 would toggle across nvme3c2n1 and nvme3c3n1 assuming the ana state
>>> of each path is optimized (as can be seen in the output of show-topology).
>>>
>>> For numa I/O policy, configured under nvme-subsys1, the "numa_nodes"
>>> attribute file shows the numa nodes being preferred by the respective
>>> namespace path. The numa nodes value is comma delimited list of nodes or
>>> A-B range of nodes.
>>>
>>> # cat  /sys/block/nvme1n1/multipath/nvme1c0n1/numa_nodes
>>> 0-1
>>>
>>> # cat  /sys/block/nvme1n1/multipath/nvme1c1n1/numa_nodes
>>> 2-3
>>>
>>> From the above output, one can easily infer that I/O workload targeted at
>>> nvme1n1 and running on numa nodes 0 and 1 would use path nvme1c0n1.
>>> Similarly, I/O workload running on numa nodes 2 and 3 would use path
>>> nvme1c1n1.
>>>
>>> For queue-depth I/O policy, configured under nvme-subsys4, the "queue_depth"
>>> attribute file shows the number of active/in-flight I/O requests currently
>>> queued for each path.
>>>
>>> # cat  /sys/block/nvme4n1/multipath/nvme4c4n1/queue_depth
>>> 518
>>>
>>> # cat  /sys/block/nvme4n1/multipath/nvme4c5n1/queue_depth
>>> 504
>>>
>>> From the above output, one can easily infer that I/O workload targeted at
>>> nvme4n1 uses two paths nvme4c4n1 and nvme4c5n1 and the current queue depth
>>> of each path is 518 and 504 respectively.
>>>
>>> changes since v4:
>>>     - Ensure that we create sysfs link from head gendisk node to each path
>>>       device irrespective of the ANA state of the path (Hannes Reinecke)
>>>     - Split the patch into three patch series and add commentary in the
>>>       code so that it's easy to read and understand the core logic (Sagi
>>>       Grimberg)
>>>     - Don't show any output if user reads "numa_nodes" file and configured
>>>       iopolicy is anything but numa; similarly don't emit any output if user
>>>       reads "queue_depth" file and configured iopolicy is anything but
>>>       queue-depth (Sagi Grimberg)
>>>
>>> Changes since v3:
>>>     - Protect the namespace dereference code with srcu read lock (Daniel Wagner)
>>>
>>> Changes since v2:
>>>     - Use one value per one sysfs attribute (Keith Busch)
>>>
>>> Changes since v1:
>>>     - Use sysfs to export multipath I/O information instead of debugfs
>>>
>>>
>>> Nilay Shroff (3):
>>>   nvme-multipah: Add visibility for round-robin io-policy
>>>   nvme-multipath: Add visibility for numa io-policy
>>>   nvme-multipath: Add visibility for queue-depth io-policy
>>>
>>>  drivers/nvme/host/core.c      |   3 +
>>>  drivers/nvme/host/multipath.c | 120 ++++++++++++++++++++++++++++++++++
>>>  drivers/nvme/host/nvme.h      |  20 ++++--
>>>  drivers/nvme/host/sysfs.c     |  20 ++++++
>>>  4 files changed, 159 insertions(+), 4 deletions(-)
>>>

