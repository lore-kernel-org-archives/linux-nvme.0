Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC38D59F7D
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Dec 2025 08:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8pgRWq64snSj+NtDY1NBIsf26Ul36XEu7BWtYwi1zlY=; b=vPpz4xT/T/mjSY59QCnO418BHh
	qoSpfEzws3Ecx50cY14p6gP+agWy3N1VZklb3Duuw9Uj/hTs7FdFGqpq/Q+reoEq5U3Qc7P9HSDF0
	m7cUyNoBC7gQg7zpujeKaG5FEW0G6tkAI757vKmiw6oxNH6lAIlnXvJLB63mo9QwYwswAae+YcIft
	tAjgiwt3rFC49B1xL05USZj6bbsRAqXGSJTaxxxNqeWl9NvTOcc9xVXT/5YF9FBH640Vn0RR80cBx
	7MJnyYM6HCzKDV6gXKV1uSGZ1N1ZI+LiCrPCSBMRFr6BsYvyBlCv4drtcqYfP1h2mO0zSGCUiQWR8
	V5NZvI5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUKu8-00000001WsP-20F5;
	Sat, 13 Dec 2025 08:23:04 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUKu5-00000001Ws3-3jF5
	for linux-nvme@lists.infradead.org;
	Sat, 13 Dec 2025 08:23:02 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BD6uIf2022697;
	Sat, 13 Dec 2025 08:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8pgRWq
	64snSj+NtDY1NBIsf26Ul36XEu7BWtYwi1zlY=; b=UVFZdQLumw/d1HcozpHKYx
	+4FoSSdawUVRJeSZeAF6TNweC1QlZrUsZhF3Q7grp781KOhkb8KnIM7bbikNqB3i
	WPLkYPnFkvxe5FRAD3gHtKbAYs3I3JYu1sLptfU0d8iDoiFquimBXNzziIeMRM5c
	HLwHJF8TgdpTqO1bnJm9aVApssvcL5R489/fzGLf7gBE0yKMD5MotCd1RXd4BTqC
	whtOHnSQ2Dy+Lsfg/i7PJ2cKHVuBVJtszcFDxy7fzcVm7zIKui5xYdtnK8xseqn8
	//LsXny/2yz+fy7Rp2xAbrLwgPRrSDLiD+B7cDgpBY+tdyZxfMo5PEIlBjwuxJ5g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yturq3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Dec 2025 08:22:47 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BD8Mksg013819;
	Sat, 13 Dec 2025 08:22:46 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yturq3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Dec 2025 08:22:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BD7TVVn026807;
	Sat, 13 Dec 2025 08:22:45 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw1h1qu3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Dec 2025 08:22:45 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BD8MjvC29884976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Dec 2025 08:22:45 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 389F25803F;
	Sat, 13 Dec 2025 08:22:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6267F58060;
	Sat, 13 Dec 2025 08:22:41 +0000 (GMT)
Received: from [9.111.58.7] (unknown [9.111.58.7])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Dec 2025 08:22:41 +0000 (GMT)
Message-ID: <a9200e1b-1d49-440a-bd69-20e10491dc1d@linux.ibm.com>
Date: Sat, 13 Dec 2025 13:52:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 0/7] nvme-multipath: introduce adaptive I/O policy
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, dwagner@suse.de,
        axboe@kernel.dk, kanie@linux.alibaba.com, gjoyce@ibm.com
References: <20251105103347.86059-1-nilay@linux.ibm.com>
 <052ee37c-675f-4611-afa4-62788d220f1b@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <052ee37c-675f-4611-afa4-62788d220f1b@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX7kgQbU9Fzy/i
 0IM4XkAAM0CkeD56Jfj+s2jlO4M11u0FrEk7wUdohdkq6P/ssqeaS12o0WBafESr50oXZ8MKv0J
 2QsmY35f1iSMVfJHJCkfqscpMz2ebr7jeA0I1p5CsBarb/uMe4iU592J4B3CAzrZK3Ysp6W0NCF
 A4+7DL0pGcUGZU0K50ATBf2eXIBm+o682CzA/QGn+Q/cPfVURwbZc+VvL6noy0Zpo3fZtlgDBbQ
 dVI0Y6cRPuTnfp2xkepD9dBcccyAbzTHHb2iMiv56bIQdGOOIV4c/v3/d4zWW48GbXtRMlNBb6p
 +0LO3BZzYHhTIQG/zATWv43FcGgE25XhQaqwDv25S1TCLbIX/ESsZHCWIRgkcHWKrLQg06GN7q5
 ixQSXqrQE4uamSuShOo/3irkIQMkuQ==
X-Proofpoint-ORIG-GUID: shIEDVSFlTXPxSqLcJNllXzoeTrRdbDb
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=693d2257 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=h6x_8Uou6RI9jsn2wvYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VHAjzdlQNlbIiYa9sp6_RXQ9DUd9CRKN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-13_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251213_002301_965077_E6BCB06F 
X-CRM114-Status: GOOD (  17.62  )
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



On 12/12/25 5:38 PM, Sagi Grimberg wrote:
> 
> 
> On 05/11/2025 12:33, Nilay Shroff wrote:
>> Hi,
>>
>> This series introduces a new adaptive I/O policy for NVMe native
>> multipath. Existing policies such as numa, round-robin, and queue-depth
>> are static and do not adapt to real-time transport performance.
> 
> It can be argued that queue-depth is a proxy of latency.
> 
>>   The numa
>> selects the path closest to the NUMA node of the current CPU, optimizing
>> memory and path locality, but ignores actual path performance. The
>> round-robin distributes I/O evenly across all paths, providing fairness
>> but not performance awareness. The queue-depth reacts to instantaneous
>> queue occupancy, avoiding heavily loaded paths, but does not account for
>> actual latency, throughput, or link speed.
>>
>> The new adaptive policy addresses these gaps selecting paths dynamically
>> based on measured I/O latency for both PCIe and fabrics.
> 
> Adaptive is not a good name. Maybe weighted-latency of wplat (weighted path latency)
> or something like that.
> 
Yeah I also talked to Hannes about this and he suggest naming it either "weighed-latency"
or "ewma-latency". What do you prefer? 

>>   Latency is
>> derived by passively sampling I/O completions. Each path is assigned a
>> weight proportional to its latency score, and I/Os are then forwarded
>> accordingly. As condition changes (e.g. latency spikes, bandwidth
>> differences), path weights are updated, automatically steering traffic
>> toward better-performing paths.
>>
>> Early results show reduced tail latency under mixed workloads and
>> improved throughput by exploiting higher-speed links more effectively.
>> For example, with NVMf/TCP using two paths (one throttled with ~30 ms
>> delay), fio results with random read/write/rw workloads (direct I/O)
>> showed:
>>
>>          numa         round-robin   queue-depth  adaptive
>>          -----------  -----------   -----------  ---------
>> READ:   50.0 MiB/s   105 MiB/s     230 MiB/s    350 MiB/s
>> WRITE:  65.9 MiB/s   125 MiB/s     385 MiB/s    446 MiB/s
>> RW:     R:30.6 MiB/s R:56.5 MiB/s  R:122 MiB/s  R:175 MiB/s
>>          W:30.7 MiB/s W:56.5 MiB/s  W:122 MiB/s  W:175 MiB/s
> 
> Seems like a nice gain.
> Can you please test for the normal symmetric paths case? Would like
> to see the trade-off...
Yes, I've already tested that. I currently don’t have access to the system,
but based on my earlier runs, the performance for the symmetric-path case
was noticeably better than in the NUMA scenario, and roughly in the same
(or slightly better) range as the round-robin/qdepth I/O policy. I will 
share those numbers later once I get the access.

Thanks,
--Nilay  


