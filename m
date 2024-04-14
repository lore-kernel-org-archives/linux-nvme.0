Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A51C4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Apr 2024 11:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/8FGEECQAyCagDmEMmGjCSfPufT26LLvNAH2OQOjUNE=; b=G1OMRTACjXalvFrvZ+CmsfAyk0
	hlK2SkoJQI09ZygIvCg5ZW3y5tdciwQ66Ga1e/6yLsMNgH0niNHFbjH4YxqWjuXetC7m8TgsJiLsN
	B1Zss8hzoc8QlESWwaMDK7jabIwXJlp7wNljNgI9YUazIylT8N+Bks+DFWaIoBIhb3iFSWPLNFd3W
	Ld1nxtmevVLrRICJSB19b++ZeLoCy782wtHSzo8Y9Gu3S7btWRMHXxfeGrPXUngYMCjYf7cGzSyAh
	N8Q2w2w2DQOx7j4DFgQioYdosToxClS/VeOvycgYt9DmR94Ji1LfZBhZAZybVsZvVPumsEfapEnzf
	S8YOG2LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvxdT-00000005JRk-25IG;
	Sun, 14 Apr 2024 11:02:59 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvxdM-00000005JQV-2dMd
	for linux-nvme@lists.infradead.org;
	Sun, 14 Apr 2024 11:02:54 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43EAbf2d022385;
	Sun, 14 Apr 2024 11:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/8FGEECQAyCagDmEMmGjCSfPufT26LLvNAH2OQOjUNE=;
 b=rGW+AVN0HeUDry0FmF8gK0yhvrldcr7J/C8KRnhtdFP0sPup7R5Se72mq+Oz0aDk1sQS
 peB3P/DBiGarf8KpYrTVKkAAKitwZvp9zVAIgGDJUgHHw9tpGzoa2fTTXU2JJpF1NWam
 UDRzjnawYovdXAzO/Mws7Pswg+qTmhi/i7ihKX+SpwcDg2nryvUOmwIjIcnj9dp4+9wZ
 UOrMIsICr22wXjAlX7YcPw8AE71t4J5s0QdIpUWLbJkJuiw4vomw0BfAMtu07YWsJe1J
 5a0bNY3FVmCvvPRzouHuiMeR8wVdfutQ0WUVLXV5TiYoK0hp3tzKuOLuc2iMSvxWnZ0U LA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfhjc9u3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 11:02:38 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43E9tVQl023582;
	Sun, 14 Apr 2024 11:02:37 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cnj169-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 11:02:37 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43EB2YpY64684392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Apr 2024 11:02:36 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 892A358051;
	Sun, 14 Apr 2024 11:02:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5075D5805A;
	Sun, 14 Apr 2024 11:02:32 +0000 (GMT)
Received: from [9.171.86.101] (unknown [9.171.86.101])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Apr 2024 11:02:31 +0000 (GMT)
Message-ID: <ffcfbe15-8e6f-422a-87cd-52c30ebf726c@linux.ibm.com>
Date: Sun, 14 Apr 2024 16:32:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: find numa distance only if controller has valid
 numa id
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, gjoyce@linux.ibm.com, axboe@fb.com
References: <20240413090614.678353-1-nilay@linux.ibm.com>
 <afcd5e05-f4af-40de-8d13-9bacf5fadd80@grimberg.me>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <afcd5e05-f4af-40de-8d13-9bacf5fadd80@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cj-L6-e83ex5aa0IPSkW_63TwwHqx61e
X-Proofpoint-ORIG-GUID: cj-L6-e83ex5aa0IPSkW_63TwwHqx61e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_01,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404140080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240414_040252_925681_B2E18D16 
X-CRM114-Status: GOOD (  28.80  )
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



On 4/14/24 14:00, Sagi Grimberg wrote:
> 
> 
> On 13/04/2024 12:04, Nilay Shroff wrote:
>> On numa aware system where native nvme multipath is configured and
>> iopolicy is set to numa but the nvme controller numa node id is
>> undefined or -1 (NUMA_NO_NODE) then avoid calculating node distance
>> for finding optimal io path. In such case we may access numa distance
>> table with invalid index and that may potentially refer to incorrect
>> memory. So this patch ensures that if the nvme controller numa node
>> id is -1 then instead of calculating node distance for finding optimal
>> io path, we set the numa node distance of such controller to default 10
>> (LOCAL_DISTANCE).
> 
> Patch looks ok to me, but it is not clear weather this fixes a real issue or not.
> 
I think this patch does help fix a real issue. I have a numa aware system where
I have a multi port/controller NNVMe PCIe disk attached. On this system, I found  
that sometimes the nvme controller numa id is set to -1 (NUMA_NO_NODE). And the 
reason being, my system has processors and memory coming from one or more NUMA nodes 
and the NVMe PCIe device is coming from a NUMA node which is different. For example, 
we could have processors coming from node 0 and node 1, but the PCIe device coming from 
node 2, and we don't have any processor coming from node 2, so there would be no way for
Linux to affinitize the PCIe device with a processor and hence while enumerating PCIe 
device kernel sets the numa id of such device to -1. Later if we hotplug CPU on node 2
then kernel would assign the numa node id 2 to the PCIe device.

For instance, I have a system with two numa nodes currently online. I also have
a multi controller NVMe PCIe disk attached to this system:

# numactl -H 
available: 2 nodes (2-3)
node 2 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
node 2 size: 15290 MB
node 2 free: 14200 MB
node 3 cpus: 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
node 3 size: 16336 MB
node 3 free: 15075 MB
node distances:
node   2   3 
  2:  10  20 
  3:  20  10 

As we could see above on this system I have currently numa node 2 and 3 online.
And I have CPUs coming from node 2 and 3.

# lspci 
052e:78:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173Xa
058e:78:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173Xa 

# nvme list -v
Subsystem        Subsystem-NQN                                                                                    Controllers
---------------- ------------------------------------------------------------------------------------------------ ----------------
nvme-subsys3     nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:S6RTNE0R900057                                     nvme1, nvme3

Device   SN                   MN                                       FR       TxPort Asdress        Slot   Subsystem    Namespaces      
-------- -------------------- ---------------------------------------- -------- ------ -------------- ------ ------------ ----------------
nvme1    S6RTNE0R900057       3.2TB NVMe Gen4 U.2 SSD III              REV.SN66 pcie   052e:78:00.0          nvme-subsys3 nvme3n1
nvme3    S6RTNE0R900057       3.2TB NVMe Gen4 U.2 SSD III              REV.SN66 pcie   058e:78:00.0          nvme-subsys3 nvme3n1, nvme3n2

Device       Generic      NSID       Usage                      Format           Controllers     
------------ ------------ ---------- -------------------------- ---------------- ----------------
/dev/nvme3n1 /dev/ng3n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme1, nvme3
/dev/nvme3n2 /dev/ng3n2   0x2          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme3

# cat ./sys/devices/pci058e:78/058e:78:00.0/numa_node
2
# cat ./sys/devices/pci052e:78/052e:78:00.0/numa_node
-1

# cat /sys/class/nvme/nvme3/numa_node 
2
# cat /sys/class/nvme/nvme1/numa_node 
-1  

As we could see above I have multi controller NVMe disk atatched to this system. This disk 
has 2 controllers. However the numa node id assigned to one of the controller (nvme1) is -1. 
This is because on this system, currently I don't have any processor coming from a numa node 
where nvme1 controller numa node could be be affinitized. 

Thanks,
--Nilay

>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   drivers/nvme/host/multipath.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 5397fb428b24..4c73a8038978 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -240,17 +240,19 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
>>     static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
>>   {
>> -    int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
>> +    int found_distance = INT_MAX, fallback_distance = INT_MAX;
>>       struct nvme_ns *found = NULL, *fallback = NULL, *ns;
>>         list_for_each_entry_rcu(ns, &head->list, siblings) {
>> +        int distance = LOCAL_DISTANCE;
>> +
>>           if (nvme_path_is_disabled(ns))
>>               continue;
>>   -        if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
>> -            distance = node_distance(node, ns->ctrl->numa_node);
>> -        else
>> -            distance = LOCAL_DISTANCE;
>> +        if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA) {
>> +            if (ns->ctrl->numa_node != NUMA_NO_NODE)
>> +                distance = node_distance(node, ns->ctrl->numa_node);
>> +        }
>>             switch (ns->ana_state) {
>>           case NVME_ANA_OPTIMIZED:
> 

