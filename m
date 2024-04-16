Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7043FC04FF6
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 08:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EmFi9zm8B+AaZNNvDcKRHQJoPxJHJ/qB4bZefBKQMVY=; b=Ssna7KfQA6gvTPvErsZZAo/n4c
	CTEvA+PM4yatnig4y9LbCSMFEx094KASC+iMhEk10lLZxhUVFj3QZn0qXArlr1uILzkUH8mkp5zzh
	QE5AA9vUyrxvdvFD0rFQvjLm3CT48exOeOP7cUyyauIF2S1z2EwyJSAgbOzDUwfO9x+j0pG3ePtcy
	R9q8DKXhmPJhvfdhQx4fPRq44bY4puD4VqGYneMnCOHkIQyphrItU+g9FTWKvRt/cK3uQKG9rWLep
	8qyZaLNIbHejuUev0zuvgen+RxJstS5Q70WVxmmH+1b2sPTzB/8NqAStyHVxpxkkvFkxEHQcBdS0l
	i+mABHUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwdq2-0000000BNHq-0nkm;
	Tue, 16 Apr 2024 08:06:46 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwdpo-0000000BNEO-2hAQ
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 08:06:44 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43G7QNLV023080
	for <linux-nvme@lists.infradead.org>; Tue, 16 Apr 2024 08:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EmFi9zm8B+AaZNNvDcKRHQJoPxJHJ/qB4bZefBKQMVY=;
 b=F7GUc7Bz6R76lIF8EUgCjKPRnqtl+54uiMEpUWAvWkemuJuDcLVKPaVaFKb8oC7ZGnCu
 Z/lmu9D/k2LbrMqY7YCDZN3u0UmMAKtuP5EXlR9j4TqdaBecES29A6ZNVT3H0KVK9Pev
 xBj2ERxJhI8QF0CrCXOHcCX+XKa6/ONA3FwH9FhHUoNRa0mDy+sGJLj+OoZJuQ0E6gk0
 UDk2zZI2lGbwlWrEsRbWwx05AKt0hyeQCCxa7k6LD0XofwKc01G2iZALROTnwxKaQ278
 SDxFr2Z6UE0s+Jp17J1OGLQAShFZ/qt2zkysL3Vq+TLnmGMIxdFt4TPl4cCSF6Dctu69 iw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhjrngb9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 16 Apr 2024 08:06:30 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43G599ax027281
	for <linux-nvme@lists.infradead.org>; Tue, 16 Apr 2024 08:06:29 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg4ryw2ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 16 Apr 2024 08:06:29 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43G86RNU17629906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Tue, 16 Apr 2024 08:06:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFA7858065
	for <linux-nvme@lists.infradead.org>; Tue, 16 Apr 2024 08:06:26 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E08B58055
	for <linux-nvme@lists.infradead.org>; Tue, 16 Apr 2024 08:06:26 +0000 (GMT)
Received: from [9.109.198.231] (unknown [9.109.198.231])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP
	for <linux-nvme@lists.infradead.org>; Tue, 16 Apr 2024 08:06:25 +0000 (GMT)
Message-ID: <ada525e3-9b54-453e-b9c0-9c2eb484cf78@linux.ibm.com>
Date: Tue, 16 Apr 2024 13:36:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: find numa distance only if controller has valid
 numa id
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <20240413090614.678353-1-nilay@linux.ibm.com>
 <afcd5e05-f4af-40de-8d13-9bacf5fadd80@grimberg.me>
 <ffcfbe15-8e6f-422a-87cd-52c30ebf726c@linux.ibm.com>
 <81a64482-1b02-43b2-aacd-9d8ea1cea23c@grimberg.me>
 <7b188849-5c3f-45ff-9747-096ffdaff6ee@linux.ibm.com>
 <05dbae65-2cc2-40d7-9066-a83cdfdc47be@suse.de>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <05dbae65-2cc2-40d7-9066-a83cdfdc47be@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X0mjNnlJLNqCC4wSD0AQRVwqqWZMIPJE
X-Proofpoint-ORIG-GUID: X0mjNnlJLNqCC4wSD0AQRVwqqWZMIPJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_04,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404160049
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_010632_933658_B9DC3ED8 
X-CRM114-Status: GOOD (  36.88  )
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



On 4/15/24 20:09, Hannes Reinecke wrote:
> On 4/15/24 11:30, Nilay Shroff wrote:
>>
>>
>> On 4/15/24 14:25, Sagi Grimberg wrote:
>>>
>>>
>>> On 14/04/2024 14:02, Nilay Shroff wrote:
>>>>
>>>> On 4/14/24 14:00, Sagi Grimberg wrote:
>>>>>
>>>>> On 13/04/2024 12:04, Nilay Shroff wrote:
>>>>>> On numa aware system where native nvme multipath is configured and
>>>>>> iopolicy is set to numa but the nvme controller numa node id is
>>>>>> undefined or -1 (NUMA_NO_NODE) then avoid calculating node distance
>>>>>> for finding optimal io path. In such case we may access numa distance
>>>>>> table with invalid index and that may potentially refer to incorrect
>>>>>> memory. So this patch ensures that if the nvme controller numa node
>>>>>> id is -1 then instead of calculating node distance for finding optimal
>>>>>> io path, we set the numa node distance of such controller to default 10
>>>>>> (LOCAL_DISTANCE).
>>>>> Patch looks ok to me, but it is not clear weather this fixes a real issue or not.
>>>>>
>>>> I think this patch does help fix a real issue. I have a numa aware system where
>>>> I have a multi port/controller NNVMe PCIe disk attached. On this system, I found
>>>> that sometimes the nvme controller numa id is set to -1 (NUMA_NO_NODE). And the
>>>> reason being, my system has processors and memory coming from one or more NUMA nodes
>>>> and the NVMe PCIe device is coming from a NUMA node which is different. For example,
>>>> we could have processors coming from node 0 and node 1, but the PCIe device coming from
>>>> node 2, and we don't have any processor coming from node 2, so there would be no way for
>>>> Linux to affinitize the PCIe device with a processor and hence while enumerating PCIe
>>>> device kernel sets the numa id of such device to -1. Later if we hotplug CPU on node 2
>>>> then kernel would assign the numa node id 2 to the PCIe device.
>>>>
>>>> For instance, I have a system with two numa nodes currently online. I also have
>>>> a multi controller NVMe PCIe disk attached to this system:
>>>>
>>>> # numactl -H
>>>> available: 2 nodes (2-3)
>>>> node 2 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
>>>> node 2 size: 15290 MB
>>>> node 2 free: 14200 MB
>>>> node 3 cpus: 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
>>>> node 3 size: 16336 MB
>>>> node 3 free: 15075 MB
>>>> node distances:
>>>> node   2   3
>>>>     2:  10  20
>>>>     3:  20  10
>>>>
>>>> As we could see above on this system I have currently numa node 2 and 3 online.
>>>> And I have CPUs coming from node 2 and 3.
>>>>
>>>> # lspci
>>>> 052e:78:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173Xa
>>>> 058e:78:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173Xa
>>>>
>>>> # nvme list -v
>>>> Subsystem        Subsystem-NQN                                                                                    Controllers
>>>> ---------------- ------------------------------------------------------------------------------------------------ ----------------
>>>> nvme-subsys3     nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:S6RTNE0R900057                                     nvme1, nvme3
>>>>
>>>> Device   SN                   MN                                       FR       TxPort Asdress        Slot   Subsystem    Namespaces
>>>> -------- -------------------- ---------------------------------------- -------- ------ -------------- ------ ------------ ----------------
>>>> nvme1    S6RTNE0R900057       3.2TB NVMe Gen4 U.2 SSD III              REV.SN66 pcie   052e:78:00.0          nvme-subsys3 nvme3n1
>>>> nvme3    S6RTNE0R900057       3.2TB NVMe Gen4 U.2 SSD III              REV.SN66 pcie   058e:78:00.0          nvme-subsys3 nvme3n1, nvme3n2
>>>>
>>>> Device       Generic      NSID       Usage                      Format           Controllers
>>>> ------------ ------------ ---------- -------------------------- ---------------- ----------------
>>>> /dev/nvme3n1 /dev/ng3n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme1, nvme3
>>>> /dev/nvme3n2 /dev/ng3n2   0x2          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme3
>>>>
>>>> # cat ./sys/devices/pci058e:78/058e:78:00.0/numa_node
>>>> 2
>>>> # cat ./sys/devices/pci052e:78/052e:78:00.0/numa_node
>>>> -1
>>>>
>>>> # cat /sys/class/nvme/nvme3/numa_node
>>>> 2
>>>> # cat /sys/class/nvme/nvme1/numa_node
>>>> -1
>>>>
>>>> As we could see above I have multi controller NVMe disk atatched to this system. This disk
>>>> has 2 controllers. However the numa node id assigned to one of the controller (nvme1) is -1.
>>>> This is because on this system, currently I don't have any processor coming from a numa node
>>>> where nvme1 controller numa node could be be affinitized.
>>>
>>> Thanks for the explanation. But what is the bug you see in this configuration? panic?
>>> suboptimal performance?
>>> which is it? it is not clear from the patch description.
>>>
>> I didn't encounter panic, however the issue here is with accessing numa distance table
>> with incorrect index.
>>
>> For calculating the distance between two nodes we invoke the function __node_distance().
>> This function would then access the numa distance table, which is typically an array with
>> valid index starting from 0. So obviously accessing this table with index of -1 would
>> deference incorrect memory location. De-referencing incorrect memory location might have
>> side effects including panic (though I didn't encounter panic). Furthermore in such a case,
>> the calculated node distance could potentially be incorrect and that might cause the nvme
>> multipath to choose a suboptimal IO path.
>>
>> This patch may not help choosing the optimal IO path (as we assume that the node distance would be
>> LOCAL_DISTANCE in case nvme controller numa node id is -1) but it ensures that we don't access the
>> invalid memory location for calculating node distance.
>>
> Hmm. One wonders: how does such a system work?
> The systems I know always have the PCI slots attached to the CPU
> sockets, so if the CPU is not present the NVMe device on that
> slot will be non-functional. In fact, it wouldn't be visible at
> all as the PCI lanes are not powered up.
> In your system the PCI lanes clearly are powered up, as the NVMe
> device shows up in the PCI enumeration.
> Which means you are running a rather different PCI configuration.
> Question now is: does the NVMe device _work_?
Yes on my system NVMe device works as expected even in case the numa node id assigned to 
NVMe controller is -1. The only side effect with such configuration is that if multipath 
is configured then we may not be able to find optimal IO path.

> If it does, shouldn't the NUMA node continue to be present (some kind of memory-less, CPU-less NUMA node ...)?
I think NUMA node to be present/online always if there's a PCI device affnitized to that numa node
is not always required. At-least on the system which I have that's not the case. In fact, there's a 
NUMA node id assigned to each PCI device in the system however during PCI enumeration kernel first 
validates whether NUMA id assigned to the PCI device is online or not. If the respective numa node 
is NOT online then the PCI enumeration code sets the numa node id of such PCI device to NUMA_NO_NODE 
(i.e. -1). 

> As a side-note, we'll need these kind of configuration anyway once
> CXL switches become available...
Please ping me if I could be of any help for your need with CXL switches..

Thanks,
--Nilay

