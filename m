Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B08CF9C71
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 06:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/nN7dQXcmynVj5CqBOqjCkdKVytiElCjGINB6Grl+rI=; b=XD/wknuJz//EdaxtrtcUYTG8Da
	TbkFo6M2679V7Hsyl8jIZCGk6WelxIWBReTPpcF9UCeL6Nw+qHDT1RVDiCoiBK5+koAJrxKtFUPnT
	GxinFfUk1BSjF8TRFr3iN4Ye1uRKvk0VSX3K1UMNXRTAak5zo8LwGponmMNyjbdH99jfsqg3UuI8d
	U07YNT53a4VpFLaZyGmZWAjfxOU2evNI0W/qikAN8Ijht3VNvvAfc86sR+XHIRoH40bcyJlbcatES
	fvc4bPaSt0uauT/sfKr3I4Epbg8zM3p/P+Tc2NIanMTdQp08wmqCFTdZNr+TYpn5lkrqOfjAadyKq
	ZDPzMSTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sszHE-00000001IfB-3oPh;
	Tue, 24 Sep 2024 06:44:00 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sszFj-00000001IKa-0Wch
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 06:42:29 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O6CdF2006140;
	Tue, 24 Sep 2024 06:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	/nN7dQXcmynVj5CqBOqjCkdKVytiElCjGINB6Grl+rI=; b=Gz8PYCaSjXEpP/cT
	q8H2E+5Oq9t3vxpDXSQ6/eMiiu736ICkWXx43rBHwxk/fxEf2W45JEPy1r74PSF3
	b8wXhmTBUG9fgiRUAEhkiz4EN94zL2+yM1kmO7x0Bg1DTG20XXQmrZE4LTl3UpuU
	k+kUzT6io0hq0S8HCwTmfq62ri7nK2L4cm/tx+NysQOh1F8F0DjDSQizJ1Nho6jO
	Hus8WTXhs8NstfNtYzFGBu/V/cxiBRCv8fda3wwEajISbgN2JAcH3K58xGRaWa8W
	PAkMM0J5f/9dBEOQYRjV3+ANsi/QDIVtzdV/6mm+BTL9/+hqXP6OVVpE+AAPSgVH
	3U+cug==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snvb0128-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 06:41:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48O2eolt012489;
	Tue, 24 Sep 2024 06:41:56 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9fptc33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 06:41:56 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48O6ftXF28967218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 06:41:55 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5038358056;
	Tue, 24 Sep 2024 06:41:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 137A75805D;
	Tue, 24 Sep 2024 06:41:53 +0000 (GMT)
Received: from [9.171.25.68] (unknown [9.171.25.68])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Sep 2024 06:41:52 +0000 (GMT)
Message-ID: <37866374-26a0-485b-82ac-bfc2c23def0b@linux.ibm.com>
Date: Tue, 24 Sep 2024 12:11:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 RFC 0/1] Add visibility for native NVMe multipath using
 sysfs
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, gjoyce@linux.ibm.com
References: <20240911062653.1060056-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240911062653.1060056-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RY5iGwiD_dL1PPH231tXZoJ9qkmtwNJD
X-Proofpoint-GUID: RY5iGwiD_dL1PPH231tXZoJ9qkmtwNJD
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_01,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240043
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240923_234227_420965_D2C29D2B 
X-CRM114-Status: GOOD (  38.90  )
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

A gentle ping about this RFC. Does it look okay or if there are any further comments? 

Thanks,
--Nilay

On 9/11/24 11:56, Nilay Shroff wrote:
> Hi,
> 
> This patch propose adding new sysfs attributes for adding visibility of
> native multipath I/O. 
> 
> The first version of this RFC[1] proposed using debugfs for visibility 
> however the general feedback was to instead export the multipath I/O 
> information using sysfs attributes and then latter parse and format those 
> sysfs attributes using libnvme/nvme-cli. 
> 
> The second version of this RFC[2] uses sysfs however the sysfs attribute 
> file contains multiple lines of output and the feedback was to instead
> follow the principal of one value per one attribute. 
> 
> The third version of this RFC[3] follows the one value per one attrbiute
> principal. There was a review comment about using srcu read lock while
> dereferencing the namespace for each node which is protected by the srcu
> lock.
> 
> So now the fourth version of this RFC ensures that we protect the 
> namespace dereference code with the srcu read lock.
> 
> As we know, NVMe native multipath supports three different io policies 
> (numa, round-robin and queue-depth) for selecting I/O path, however, we  
> don't have any visibility about which path is being selected by multipath
> code for forwarding I/O. This RFC helps add that visibility by adding new 
> sysfs attribute files named "numa_nodes" and "queue_depth" under each 
> namespace block device path /sys/block/nvmeXcYnZ/. We also create a 
> "multipath" sysfs directory under head disk node and then from this 
> directory add a link to each namespace path device this head disk node 
> points to.
> 
> Please find below output generated with this proposed RFC patch applied on  
> a system with two multi-controller PCIe NVMe disks attached to it. This 
> system is also an NVMf-TCP host which is connected to an NVMf-TCP target 
> over two NIC cards. This system has four numa nodes online when the below 
> output was captured:
> 
> # cat /sys/devices/system/node/online 
> 0-3
> 
> # lscpu
> <snip>
> NUMA:
>   NUMA node(s):           4
>   NUMA node0 CPU(s):
>   NUMA node1 CPU(s):      0-7
>   NUMA node2 CPU(s):      8-31
>   NUMA node3 CPU(s):      32-63
> <snip>
> 
> Please note that numa node 0 though online, doesn't have any CPU 
> currently assigned to it.
> 
> # nvme list -v 
> Subsystem        Subsystem-NQN                                                                                    Controllers
> ---------------- ------------------------------------------------------------------------------------------------ ----------------
> nvme-subsys1     nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:S6RTNE0R900057                                     nvme0, nvme1
> nvme-subsys3     nqn.2019-10.com.kioxia:KCM7DRUG1T92:3D60A04906N1                                                 nvme2, nvme3
> nvme-subsys4     nvmet_subsystem                                                                                  nvme4, nvme5
> 
> Device           Cntlid SN                   MN                                       FR       TxPort Address        Slot   Subsystem    Namespaces
> ---------------- ------ -------------------- ---------------------------------------- -------- ------ -------------- ------ ------------ ----------------
> nvme0    66     S6RTNE0R900057       3.2TB NVMe Gen4 U.2 SSD III              REV.SN66 pcie   052e:78:00.0   U50EE.001.WZS000E-P3-C14-R1 nvme-subsys1 nvme1n1
> nvme1    65     S6RTNE0R900057       3.2TB NVMe Gen4 U.2 SSD III              REV.SN66 pcie   058e:78:00.0   U50EE.001.WZS000E-P3-C14-R2 nvme-subsys1 nvme1n1
> nvme2    2      3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               REV.CAS2 pcie   0524:28:00.0   U50EE.001.WZS000E-P3-C4-R1 nvme-subsys3 nvme3n1
> nvme3    1      3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               REV.CAS2 pcie   0584:28:00.0   U50EE.001.WZS000E-P3-C4-R2 nvme-subsys3 nvme3n1
> nvme4    1      a224673364d1dcb6fab9 Linux                                    6.9.0-rc tcp    traddr=20.0.0.200,trsvcid=4420,src_addr=20.0.0.100        nvme-subsys4 nvme4n1
> nvme5    2      a224673364d1dcb6fab9 Linux                                    6.9.0-rc tcp    traddr=10.0.0.200,trsvcid=4420,src_addr=10.0.0.100        nvme-subsys4 nvme4n1
> 
> Device            Generic           NSID       Usage                      Format           Controllers
> ----------------- ----------------- ---------- -------------------------- ---------------- ----------------
> /dev/nvme1n1 /dev/ng1n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme0, nvme1
> /dev/nvme3n1 /dev/ng3n1   0x2          0.00   B /   5.75  GB      4 KiB +  0 B   nvme2, nvme3
> /dev/nvme4n1 /dev/ng4n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme4, nvme5
> 
> 
> # nvme show-topology
> nvme-subsys1 - NQN=nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:S6RTNE0R900057
>                hostnqn=nqn.2014-08.org.nvmexpress:uuid:41528538-e8ad-4eaf-84a7-9c552917d988
>                iopolicy=numa
> \
>  +- ns 1
>  \
>   +- nvme0 pcie 052e:78:00.0 live optimized
>   +- nvme1 pcie 058e:78:00.0 live optimized
> 
> nvme-subsys3 - NQN=nqn.2019-10.com.kioxia:KCM7DRUG1T92:3D60A04906N1
>                hostnqn=nqn.2014-08.org.nvmexpress:uuid:41528538-e8ad-4eaf-84a7-9c552917d988
>                iopolicy=round-robin
> \
>  +- ns 2
>  \
>   +- nvme2 pcie 0524:28:00.0 live optimized
>   +- nvme3 pcie 0584:28:00.0 live optimized
> 
> nvme-subsys4 - NQN=nvmet_subsystem
>                hostnqn=nqn.2014-08.org.nvmexpress:uuid:41528538-e8ad-4eaf-84a7-9c552917d988
>                iopolicy=queue-depth
> \
>  +- ns 1
>  \
>   +- nvme4 tcp traddr=20.0.0.200,trsvcid=4420,src_addr=20.0.0.100 live optimized
>   +- nvme5 tcp traddr=10.0.0.200,trsvcid=4420,src_addr=10.0.0.100 live optimized
> 
> As we could see above, we've three shared namespaces created. In terms of 
> iopolicy, we have "numa" configured for nvme-subsys1, "round-robin" 
> configured for nvme-subsys3 and "queue-depth" configured for nvme-subsys4.
> 
> Now, under each namespace "head disk node", we create a sysfs group
> attribute named "multipath". The "multipath" group then points to the 
> each path this head disk node points to:
> 
> # tree /sys/block/nvme1n1/multipath/
> /sys/block/nvme1n1/multipath/
> ├── nvme1c0n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme0/nvme1c0n1
> └── nvme1c1n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme1/nvme1c1n1
> 
> # tree /sys/block/nvme3n1/multipath/
> /sys/block/nvme3n1/multipath/
> ├── nvme3c2n1 -> ../../../../../pci0524:28/0524:28:00.0/nvme/nvme2/nvme3c2n1
> └── nvme3c3n1 -> ../../../../../pci0584:28/0584:28:00.0/nvme/nvme3/nvme3c3n1
> 
> # tree /sys/block/nvme4n1/multipath/
> /sys/block/nvme4n1/multipath/
> ├── nvme4c4n1 -> ../../../../nvme-fabrics/ctl/nvme4/nvme4c4n1
> └── nvme4c5n1 -> ../../../../nvme-fabrics/ctl/nvme5/nvme4c5n1
> 
> One can easily infer from the above output that for the "round-robin"
> I/O policy, configured under nvme-subsys3, the I/O workload targeted at 
> nvme3n1 would toggle across nvme3c2n1 and nvme3c3n1 assuming the ana state 
> of each path is optimized (as can be seen in the output of show-topology).
> 
> For numa I/O policy, configured under nvme-subsys1, the "numa_nodes" 
> attribute file shows the numa nodes being preferred by the respective 
> namespace path. The numa nodes value is comma delimited list of nodes or 
> A-B range of nodes.
> 
> # cat  /sys/block/nvme1n1/multipath/nvme1c0n1/numa_nodes 
> 0-1
> 
> # cat  /sys/block/nvme1n1/multipath/nvme1c1n1/numa_nodes
> 2-3
> 
> From the above output, one can easily infer that I/O workload targeted at
> nvme1n1 and running on numa nodes 0 and 1 would use path nvme1c0n1. 
> Similarly, I/O workload running on numa nodes 2 and 3 would use path 
> nvme1c1n1.
> 
> For queue-depth I/O policy, configured under nvme-subsys4, the "queue_depth" 
> attribute file shows the number of active/in-flight I/O requests currently 
> queued for each path.
> 
> # cat  /sys/block/nvme4n1/multipath/nvme4c4n1/queue_depth 
> 518
> 
> # cat  /sys/block/nvme4n1/multipath/nvme4c5n1/queue_depth
> 504
> 
> From the above output, one can easily infer that I/O workload targeted at
> nvme4n1 uses two paths nvme4c4n1 and nvme4c5n1 and the current queue depth 
> of each path is 518 and 504 respectively.
> 
> [1] https://lore.kernel.org/all/20240722093124.42581-1-nilay@linux.ibm.com/
> [2] https://lore.kernel.org/all/20240809173030.2281021-2-nilay@linux.ibm.com/
> [3] https://lore.kernel.org/all/20240903135228.283820-1-nilay@linux.ibm.com/
> 
> Changes since v3:
>     - Protect the namespace dereference code with srcu read lock (Daniel Wagner)
> 
> Changes since v2:
>     - Use one value per one sysfs attribute (Keith Busch)
> 
> Changes since v1:
>     - Use sysfs to export multipath I/O information instead of debugfs
> 
> Nilay Shroff (1):
>   nvme-multipath: Add sysfs attributes for showing multipath info
> 
>  drivers/nvme/host/core.c      |  3 ++
>  drivers/nvme/host/multipath.c | 69 +++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h      | 20 ++++++++--
>  drivers/nvme/host/sysfs.c     | 20 ++++++++++
>  4 files changed, 108 insertions(+), 4 deletions(-)
> 

