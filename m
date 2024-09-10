Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910F6ECE564
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 06:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CIMZW5k09o2h4Z0RHqJ2ShrDHaPsOwn3M3PvqR3B468=; b=ZgFmSQnjrgIry4rXlmN9Pmn/3g
	YpnPGGeuW4lLMar+57BgD2z/AT3LpPulvbDiXcoHt1jjykWZVe75DS2YGBrRcu0pQs2cjB5/UHdAy
	KnH1nvoYCN5VSP02ctEEbX1sKfRklBOwroqSKyg2ALg55lLbEh8ze3r2mTacLEt/tWExI79VbVcpY
	t2+xG8sGCuy89Q2e9KZw0M/fIlIQCu3cD1Wj+ll2iV9rtl68ofj+PN8pDwrhxKlHfXpduzPnlwLho
	gq7mYWyzwkCf6cQ9mv0+xxP8fGBKybHlCJSCVbf8TN0ZQMQjWk+RvQAbR0970DB5Ze9fbcjvjgWdV
	Ek2QruIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snucB-00000004UXM-13Vx;
	Tue, 10 Sep 2024 06:44:39 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snuc7-00000004UWq-46Qj
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 06:44:37 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A3hElw003757;
	Tue, 10 Sep 2024 06:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=C
	IMZW5k09o2h4Z0RHqJ2ShrDHaPsOwn3M3PvqR3B468=; b=ZM18/ezPhwAaK6VlK
	hlwRszqAj4j0udlltlShW1/O31R3t3+pSVUD1swi9ThTmP04HlFzXtg3n1dRRwkY
	XJQyQou/0XwjYaSzHmD6PvZ/5rqwAh+AWTKaAS+gFIa45e0XaiItuLL4T7T57U+N
	tMLgYhP+qnkSdaXpuIc21ShTgSyJaBdSckACU8KcKgtbds/PGZ7Nv/HcNPqPdgQ/
	5qQX5E6/eSPrcS2xXsWU0/SfM75XzNWEN4EXmnlQNjSSmxl88VHzMWfz5FY1pgWJ
	zmXwdP5eRTA8lcW82NstVfVQF+RXDI4o00fPEXTt7PkE9R67jG1Z8HRcN+pJ+Vmq
	x6QtA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejadxt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 06:44:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48A4rYi6019912;
	Tue, 10 Sep 2024 06:44:12 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25pt4sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 06:44:12 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48A6iC1Y19596006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 06:44:12 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F87758055;
	Tue, 10 Sep 2024 06:44:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA1A158043;
	Tue, 10 Sep 2024 06:44:09 +0000 (GMT)
Received: from [9.171.40.103] (unknown [9.171.40.103])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Sep 2024 06:44:09 +0000 (GMT)
Message-ID: <1cf163d0-9406-4605-a16e-56f75170e12b@linux.ibm.com>
Date: Tue, 10 Sep 2024 12:14:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 RFC 1/1] nvme-multipath: Add sysfs attributes for
 showing multipath info
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com, gjoyce@linux.ibm.com
References: <20240903135228.283820-1-nilay@linux.ibm.com>
 <20240903135228.283820-2-nilay@linux.ibm.com>
 <e9f36c3a-e2c6-4d95-89c8-40e8b9b3594c@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <e9f36c3a-e2c6-4d95-89c8-40e8b9b3594c@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e02IDD1DuCYOdQUcuPzqZHlJhuXpOqr5
X-Proofpoint-GUID: e02IDD1DuCYOdQUcuPzqZHlJhuXpOqr5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409100048
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_234436_263477_C3D93F6B 
X-CRM114-Status: GOOD (  23.44  )
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



On 9/9/24 18:10, Daniel Wagner wrote:
> On Tue, Sep 03, 2024 at 07:22:19PM GMT, Nilay Shroff wrote:
>> NVMe native multipath supports different IO policies for selecting I/O
>> path, however we don't have any visibility about which path is being
>> selected by multipath code for forwarding I/O.
>> This patch helps add that visibility by adding new sysfs attribute files
>> named "numa_nodes" and "queue_depth" under each namespace block device
>> path /sys/block/nvmeXcYnZ/. We also create a "multipath" sysfs directory
>> under head disk node and then from this directory add a link to each
>> namespace path device this head disk node points to.
>>
>> For instance, /sys/block/nvmeXnY/multipath/ would create a soft link to
>> each path the head disk node <nvmeXnY> points to:
>>
>> $ ls -1 /sys/block/nvme1n1/
>> nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
>> nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
>>
>> For round-robin I/O policy, we could easily infer from the above output
>> that I/O workload targeted to nvme3n1 would toggle across paths nvme1c1n1
>> and nvme1c3n1.
>>
>> For numa I/O policy, the "numa_nodes" attribute file shows the numa nodes
>> being preferred by the respective block device path. The numa nodes value
>> is comma delimited list of nodes or A-B range of nodes.
>>
>> For queue-depth I/O policy, the "queue_depth" attribute file shows the
>> number of active/in-flight I/O requests currently queued for each path.
> 
> As far I can tell, this looks good to me.
> 
>> +static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr,
>> +		char *buf)
>> +{
>> +	int node;
>> +	nodemask_t numa_nodes;
>> +	struct nvme_ns *current_ns;
>> +	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
>> +	struct nvme_ns_head *head = ns->head;
>> +
>> +	nodes_clear(numa_nodes);
>> +
>> +	for_each_node(node) {
>> +		current_ns = srcu_dereference(head->current_path[node],
>> +				&head->srcu);
> 
> Don't you need to use srcu_read_lock() first?
Yeah I overlooked it. You're right, I need to use srcu_read_lock(). I will 
update it in the next revision of the patch.

> 
>> +		if (ns == current_ns)
>> +			node_set(node, numa_nodes);
> 
> And if ns matches current_ns can't you break the loop?
I think no. Here we map each numa node preferred for a namespace path.
So for instance, if the current_ns (nvmeXcYnZ) path  is preferred for I/O 
workload running on numa nodes i and j then we accordingly set the
respective node values (i and j) in the nodemask (numa_nodes) which is a 
bitmap. 

So in practice, when we cat this file,
# cat  /sys/block/nvme1n1/multipath/nvme1c0n1/numa_nodes 
0-1

we get the output node 0 and 1. That implies that I/O workload targeted to 
/dev/nvme1n1 and running on numa node 0 or 1 would prefer using the path 
nvme1c0n1. 

And similarly, when we cat this file,
# cat  /sys/block/nvme1n1/multipath/nvme1c1n1/numa_nodes
2-3

we get the output node 2 and 3. That implies that I/O workload targeted to 
/dev/nvme1n1 and running on numa node 2 or 3 would prefer using the path 
nvme1c1n1. 

Hope that clarifies. Let me know if you still think this doesn't make sense.

> 
> Thanks,
> Daniel

Thanks,
--Nilay

