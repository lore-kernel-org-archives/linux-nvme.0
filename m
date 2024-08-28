Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70995C5B54A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Aug 2024 14:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DBsg7GGVKQ/QWbVllvHJrQkTO3FufC9H7MdMhalgDt4=; b=vESn1vbZxbUrUBQGiq9Ehj9Qgp
	STk68HvJ/soutCUCULle5K0xs1mCDbM+wzbayWeSert2wiRYezjQ9HJ9EINxWKUVgV9dVgRi4L9pO
	F2hHm/OaJdnQNu06PhQ16VWdT48VHAUE1JtrWCX6NfSTTjjIVESbU59gzENGZvS8I0Gvb5TKR1boi
	BICmsuojsArWeUolpOPGBSfqM7l+yl4tqGYjLzWSXwXdOPu1CTAljbqT0B9jv0GmTGNW2HB3q5vNB
	7xrMuOtL3PkpQkGnYdSfgCp5g2fqJBVayJ/NAsEuykkFr3qDYwnMa8jOEUMmXCiohG6Eom5ecP6I9
	AuRwiFuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjK0s-0000000FpRY-00Sn;
	Wed, 28 Aug 2024 14:51:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjK0l-0000000FpPN-43yR
	for linux-nvme@lists.infradead.org;
	Wed, 28 Aug 2024 14:51:08 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SDsUP2024426;
	Wed, 28 Aug 2024 14:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=D
	Bsg7GGVKQ/QWbVllvHJrQkTO3FufC9H7MdMhalgDt4=; b=fRC/lX5xsOLwjM3v1
	jZlmWEe6xTmrRYijX8kjx2rs8GuhP6kquYZ6cr+Xv6SudKasZn3LyAvwpHly6QvJ
	rlqcMFjwM5PyhmEQWqkBf5k9CmFioxxCfhzZnGae2Ww8DVVmCUTljlQLXGCq2gQE
	GBHtQDuZ5h3FvVDZKpf5ESIQzKNaJXV4M/w8BOnW6Za9gm1Dsnb145md73HV29H7
	no9NGyvRPtuxCbe/H1cnheC1mnO1RM2nQDmPUsUtQSFiEp+wqdStx7CJzvYmq6Z1
	sNwCaolGiKpPlNHLo6AInvHjALxbB+liI5zgunSwuFHrmm0wwwY9aCOGhY+WN5h+
	brCbQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8pkhe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 14:50:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47SEIP9d028010;
	Wed, 28 Aug 2024 14:50:45 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417ubn819k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 14:50:45 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47SEoi3N47514016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 14:50:44 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6933C5803F;
	Wed, 28 Aug 2024 14:50:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F29958054;
	Wed, 28 Aug 2024 14:50:42 +0000 (GMT)
Received: from [9.171.81.116] (unknown [9.171.81.116])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Aug 2024 14:50:41 +0000 (GMT)
Message-ID: <a74e54ba-1734-4468-871f-e19340548708@linux.ibm.com>
Date: Wed, 28 Aug 2024 20:20:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/1] Add visibility for native NVMe multipath using
 sysfs
From: Nilay Shroff <nilay@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, dwagner@suse.de, hch@lst.de,
        sagi@grimberg.me, axboe@fb.com, gjoyce@linux.ibm.com
References: <20240809173030.2281021-1-nilay@linux.ibm.com>
 <ZrZ9WKimhqSJXGnn@kbusch-mbp>
 <5e6da341-3e2f-415b-bbd6-2aea420bf057@linux.ibm.com>
 <5a49c4e2-81e9-4fc3-81c7-c8c3db6aee1f@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <5a49c4e2-81e9-4fc3-81c7-c8c3db6aee1f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f9ZKlvfqAjS0VDYJZBRxNQ_DQVICHWyq
X-Proofpoint-GUID: f9ZKlvfqAjS0VDYJZBRxNQ_DQVICHWyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_05,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=971 bulkscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408280104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_075104_273684_8AB0191B 
X-CRM114-Status: GOOD (  23.26  )
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

Hi Keith,

A gentle ping for this RFC. It would be really helpful if you would share your feedback/comment.

Thanks,
--Nilay

On 8/21/24 10:52, Nilay Shroff wrote:
> Hi Keith,
> 
>>>
>>>  /sys/block/nvme0n1/multipatch/nvme0c0n1/
>>>  /sys/block/nvme0n1/multipatch/nvme0c3n1/
>>>
>>> And each directory has their attributes so they print exactly one value
>>> instead of the multi-line output. You'd know which path the output
>>> corresponds to from the file's directory.
>>>
>> Yes you were right, we need 1 value per file but I thought keeping 
>> multipath details concisely in a single file may be then easier for 
>> libnvme/nvme-cli to format and parse. 
>>
>> I also read in the sysfs documentation, "attribute file should preferably 
>> contain only one value per file. However, it is noted that it may not be 
>> efficient to contain only one value per file, so it is socially acceptable
>> to express an array of values of the same type." 
>>
>> Anyways, I believe, most of us prefer 1 value per file rule for the sysfs 
>> attributes, so how about exporting multipath details as shown below?
>>
>> Let's assume namespace head node nvmeXnY points to two different paths: 
>> nvmeXc1nY and nvmeXc3nY.
>>
>> First we create the "multipath" directory under /sys/block/nvmeXnY 
>>
>> The multipath directory would then contain two sub-directories (which are
>> the two paths pointed by namespace head node)  named nvmeXc1nY and nvmeXc3nY. 
>> In fact, these two sub-directories are actually soft link to the respective 
>> namespace block device under /sys/block
>>
>> For instance, we have a namespace head node nvme1n1 which points to two 
>> different paths: nvme1c1n1 and nvme1c3n1.
>>
>> # ls -l /sys/block/nvme1n1/multipath
>> lrwxrwxrwx. 1 root root     0 Aug 11 12:30 nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
>> lrwxrwxrwx. 1 root root     0 Aug 11 12:30 nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
>>
>> # ls -l /sys/block/
>> lrwxrwxrwx. 1 root root 0 Aug 11 12:30 nvme1c1n1 -> ../devices/pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
>> lrwxrwxrwx. 1 root root 0 Aug 11 12:30 nvme1c3n1 -> ../devices/pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
>>
>> As we see above, /sys/block/nvme1n1/multipath/nvme1c1n1 is soft link to 
>> /sys/block/nvme1c1n1 and similarly /sys/block/nvme1n1/multipath/nvme1c3n1
>> is soft link to /sys/block/nvme1c3n1. 
>>
>> For round-robin I/O policy, we could easily infer from the above output 
>> that I/O workload targeted to nvme1n1 would toggle across nvme1c1n1 and nvme1c3n1.
>>
>> We also create two new sysfs attribute files named "numa_nodes" and "queue_depth" 
>> under /sys/block/nvmeXcYnZ. 
>>
>> # cat  /sys/block/nvme1n1/multipath/nvme1c1n1/numa_nodes 
>> 0-1
>> # cat  /sys/block/nvme1n1/multipath/nvme1c3n1/numa_nodes 
>> 2-3
>>
>> For I/O policy numa, above output signifies that I/O workload targeted to nvme1n1 and
>> running on node 0 and 1 would prefer using path nvm1c1n1. Similarly, I/O workload 
>> targeted to nvme1n1 and running on node 2 and 3 would prefer using path nvme1c3n1.
>>
>> # cat /sys/block/nvme1n1/multipath/nvme1c1n1/queue_depth
>> 423
>> # cat /sys/block/nvme1n1/multipath/nvme1c3n1/queue_depth
>> 425
>>
>> For I/O policy queue-depth, above output signifies that for I/O workload targeted to nvme1n1, 
>> we have got two paths nvme1c1n1 and nvme1c3n1 and the queue_depth for each path is 423 and 425 
>> respectively.
>>
> 
> A gentle ping about the above proposed solution.
>  
> As you proposed about 1 file 1 attribute value, I reworked the proposal and would like to know if
> you have any further feedback/comment. If this looks good then shall I resend the RFC v3 with the 
> above changes incorporated?
>  
> Thanks,
> --Nilay

