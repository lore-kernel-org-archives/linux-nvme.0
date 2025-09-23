Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB2ACAC5A7
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Sep 2025 09:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C9pIlTCmxl2wydP+V3SpuL/+fHU0OiCc4+UYvsl0c70=; b=HtvRqMZWRSFixZu5htTQJSbpNk
	6Ja0CbL9bvwHqGffx8yWLxzZEeL/ElX5ceIaC68R1pRSgmeVGcrUQrezAPpYUzHcxIOm8JPS0sT3T
	CWF9B2kh0W45r0Ti2N5Himwze03XJ0XjtZw75chKS1KVrwfcVpNyeLE3lWwrZC++Zub2fvX0WTRZy
	zLSQoFmyRp/xpp2LxrewKk3nSNTe/R7fobXsTHZ2+w2pELJonONS3VtRTSz5g1T8OqOAzGznfErFZ
	oRccG9M2dMAq/T6wVmsfqkcZZg6VAO6deidqMdDGBuov6siUpE/uhVcrCua+xLp+AL3wP6X8/ZtUk
	dpfnwQ8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0zP9-0000000Cx1y-3C0o;
	Tue, 23 Sep 2025 09:33:47 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0zP4-0000000Cx1X-2Yfm
	for linux-nvme@lists.infradead.org;
	Tue, 23 Sep 2025 09:33:44 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N7goTw008650;
	Tue, 23 Sep 2025 09:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C9pIlT
	Cmxl2wydP+V3SpuL/+fHU0OiCc4+UYvsl0c70=; b=llb0EbWBcBBqU/39KkM7rc
	u8PKUDFLupyefex2+/p3WLchyWed6oyWhuVY8bqXmtjxlqU0C+caVI7k3VbVguMm
	5fEpAfBV73mx1wAUe/8q58cKIAQhd+3GbPdhCgFbX00CroxxEOcqpWcsqnXL5vGs
	1Bzy9S2flF1itatoYIVlWrC5x/q5SaQEHpHb1jY/UhdkkDqwrs/Ura2ii6qBdvic
	GJ9kkVQNvV8/EMXeGSlRDMc8NKHpO4XwiPmShpqMv56AeOc/FMH8YPrCPq4n10o7
	qZH0MqnJzZykIkHVS7pJjBIF8HjhMDLQmjDtov3KMdG6EZHTZ+uFrax97NHfSaIQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyfhdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 09:33:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58N6OTSr013592;
	Tue, 23 Sep 2025 09:33:31 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a8tjadmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 09:33:31 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58N9XVX630277892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 09:33:31 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F40B15804B;
	Tue, 23 Sep 2025 09:33:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2EFD58059;
	Tue, 23 Sep 2025 09:33:27 +0000 (GMT)
Received: from [9.43.53.124] (unknown [9.43.53.124])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Sep 2025 09:33:27 +0000 (GMT)
Message-ID: <67abba19-5b81-48bf-a279-fd4c520f2d29@linux.ibm.com>
Date: Tue, 23 Sep 2025 15:03:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] nvmf-tcp: add support for retrieving adapter link
 speed
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        dwagner@suse.de, gjoyce@ibm.com
References: <20250921111234.863853-1-nilay@linux.ibm.com>
 <20250921111234.863853-5-nilay@linux.ibm.com>
 <bacb5186-b3f6-45fe-967c-0472df746b4f@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <bacb5186-b3f6-45fe-967c-0472df746b4f@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d2696c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=mqPlZM38cmXxwAIgZ60A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 793TcF3OXvlZb5FO5D4Q6cN7s0lz4J0v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfXxXEU0cpZvxOu
 trKy1z/ZdaVZD3MIydZJaIsHAm4EoEDsX6kUTXed8ppnMZUVy+1lWtxEEQdYZPgfc7sRXeOib13
 2VtnTGPvP0m3CFDHEvBZHeyLvCbPTheyebe+uy7Gm9gP6roSJB7LKQzuY2sKaa2vgbDjb07EFCV
 zdaOOWwuVRjBrDFVCuYh/my9B7zr6N9vCmJgzKW1cJilXoeg+e43TGE3y8bnYsvYsZ4gjmw6hWh
 JH5sW/FYjju0812syWI+Zen9/RKDTWhl+61rNSubIg9eSHA0dOHp0MJCC3UcdJSu4iGMkoE0C/Z
 RdyWRz7z29BOh4une7IYhPo1kE6sslU1N3mfWwF63y+8aJgyd8TAYGZyq0YLEZD5cJCFByhxnjW
 U4MYP2vw
X-Proofpoint-ORIG-GUID: 793TcF3OXvlZb5FO5D4Q6cN7s0lz4J0v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_023343_031861_F5EA9356 
X-CRM114-Status: GOOD (  25.05  )
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



On 9/22/25 1:08 PM, Hannes Reinecke wrote:
> On 9/21/25 13:12, Nilay Shroff wrote:
>> Add support for retrieving the negotiated NIC link speed (in Mbps).
>> This value can be factored into path scoring for the adaptive I/O
>> policy. For visibility and debugging, a new sysfs attribute "speed"
>> is also added under the NVMe path block device.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   drivers/nvme/host/multipath.c | 11 ++++++
>>   drivers/nvme/host/nvme.h      |  3 ++
>>   drivers/nvme/host/sysfs.c     |  5 +++
>>   drivers/nvme/host/tcp.c       | 66 +++++++++++++++++++++++++++++++++++
>>   4 files changed, 85 insertions(+)
>>
> Why not for FC? We can easily extract the link speed from there, too ...
>
Yes it's easy to get the speed for FC. I just wanted to get feedback from
the community about this idea and so didn't include it. But I will do that 
in the future patchset.
 
> But why do we need to do that? We already calculated the weighted
> average, so we _know_ the latency of each path. And then it's
> pretty much immaterial if a path runs with a given speed; if the
> latency is lower, that path is being preferred.
> Irrespective of the speed, which might be deceptive anyway as
> you'll only ever be able to retrieve the speed of the local
> link, not of the entire path.
> 
Consider a scenario with two paths: one over a high-capacity link
(e.g. 1000 Mbps) and another over a much smaller link (e.g. 10 Mbps).
If both paths report the same latency, the current formula would
assign them identical weights. But in reality, the higher-capacity
path can sustain a larger number of I/Os compared to the lower-
capacity one.

In such cases, factoring in link speed allows us to assign proportionally
higher weight to the higher-capacity path. At the same time, if that same
path exhibits higher latency, it will be penalized accordingly, ensuring
the final score balances both latency and bandwidth.

So, including link speed in the weight calculation helps capture both
dimensions—latency sensitivity and throughput capacity—leading to a more
accurate and proportional I/O distribution.

Thanks,
--Nilay

