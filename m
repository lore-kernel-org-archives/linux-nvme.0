Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6944C2A069
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Jan 2026 09:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Pq+MiG1td//PD7nKEvnkfpB+Pv50p9P/vHJp97+Kds=; b=nMQf2UlQEvUfAFGCQuIQ/311ra
	JnvBl/jCkBC/4b5t0fjQlINMRfMtJ/pcO9Hg/UZtqruu5vtfFwQQnCoGMhHE4QNAXFy1dSACx2TtJ
	PawafJ7mW4dymPYaGV/d5g+WHllNtNEsFE77NisnMw6CjknQA9xSBT+8afGCpA8cxHwInP2UWXbg7
	jcvA2fKNjg5lDRAndnCZadROCAIrEo3Dy2idtW1nYaUQGK8JVybHoMXrJ76Uc8LVypGDE1xZIpckp
	ZeMhrZqCTCRltrS/nWI8w7oGa5+U4FdHUYmG4k3/E5+SHh1H3zXZ6hvlov9ZhbkyIMwYxEZl2rj3N
	UoHGq6xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcK5w-0000000A82w-1Cph;
	Sun, 04 Jan 2026 09:08:16 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcK5s-0000000A82S-2d8E
	for linux-nvme@lists.infradead.org;
	Sun, 04 Jan 2026 09:08:14 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6045Om2j016822;
	Sun, 4 Jan 2026 09:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1Pq+Mi
	G1td//PD7nKEvnkfpB+Pv50p9P/vHJp97+Kds=; b=CUwWXkcghCjqluktwhAowN
	NnVdWI5H6xOc4uYXkN681JiRA+TVmfrh7yWghgmkMc16coJGrloBaTJyaDmmFsGu
	/hJu7GRmh+HCUTzoweFAgvIN5bUxAwvuvuzL2R+QVZGsrQEEhorV+e1XwPTK20Os
	opRo56NXVzdvo3qTI7uHYVJa7NaOhYL8FfHltsi27YehNwtCIuGYLKsFHLUN30Lr
	BBV7P8cBynN3hv3zWZzNLwINMlRTNEAbtSssp83yFRuA8Ogq7j58X+FMlB4bM0nG
	195ZdT4iTtow6zq1lUUjCszsZfZdAwkZVteKW4znPqgc7S6g58dpFk5+Mh/Pwa9A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshek1mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 09:07:56 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60497tFo005954;
	Sun, 4 Jan 2026 09:07:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshek1mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 09:07:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6042gUoM012604;
	Sun, 4 Jan 2026 09:07:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnj0uem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 09:07:54 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60497siM27525842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 09:07:54 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E99158059;
	Sun,  4 Jan 2026 09:07:54 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B27BA58055;
	Sun,  4 Jan 2026 09:07:50 +0000 (GMT)
Received: from [9.111.79.230] (unknown [9.111.79.230])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 09:07:50 +0000 (GMT)
Message-ID: <c8fa5728-5ee1-4f79-b288-71edcefe135d@linux.ibm.com>
Date: Sun, 4 Jan 2026 14:37:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [RFC PATCHv5 2/7] nvme-multipath: add support for adaptive I/O
 policy
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, dwagner@suse.de, axboe@kernel.dk,
        kanie@linux.alibaba.com, gjoyce@ibm.com
References: <20251105103347.86059-1-nilay@linux.ibm.com>
 <20251105103347.86059-3-nilay@linux.ibm.com>
 <6d7c519c-122e-41a6-9f76-a3c4dedb52f5@grimberg.me>
 <abe16085-f0dd-4f82-b48c-f2eb125da2ee@linux.ibm.com>
 <7358ab3b-b04c-4451-85b0-5bb8073f7134@grimberg.me>
 <bf31f0e2-ebef-49ff-852b-fd5003eed165@linux.ibm.com>
 <afcc3e2b-0317-42c0-8968-ed771ac6af14@suse.de>
 <03a08de2-07af-43f9-8d68-f5ef6b048536@linux.ibm.com>
 <37a61dbc-7d5e-4f28-b6cf-5c5c21e9cdbb@grimberg.me>
 <81d9feb1-9134-464c-9c4e-393694732426@linux.ibm.com>
 <b98e91ef-254c-44bc-b46a-0039c66539e2@grimberg.me>
Content-Language: en-US
In-Reply-To: <b98e91ef-254c-44bc-b46a-0039c66539e2@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDA4MSBTYWx0ZWRfXxNgtITL2m1Tj
 zJZ3V/QQiQgHIfmHZ2WKU3z4crf9z5Brswk1UvkOb1HHpU/8w1T1uCMFx8Jr8sSnuYc711RZq8e
 kCptSNXhbnsNCZ8DGzvwW3SsiyQnO7Ps+P3Fw5U5ZS3DTAD6TjW5XjS0O6hmqHTv4ZoqX+ribg3
 GIz12+WAvxfZe0LJ+MLtt/VlvnfdkwkUnu27fpoB/Xv7ljqxEV/bPRQnc4GYnbWj6d1iHFQ6YHa
 gcHCM/pSBAtSHY4qBFXzgd5t6SKEkkpmemY8ByOgt68qEHdZFyvwvhtQccgRrecwIpeD82693q6
 kbWPQQ1E2UIlaDledhQ0ji9n5eg/6CGNdN7bPG0pGmdhi7NOUNFjSSLXugho4ldBRcrco8+RpP+
 Z512FfFYRtFBj5tN6lWnBk6AZV9818GsrG07Xh6apqHwkDfJjiizavQ1+yvlgm3n58b1Qmmq45y
 UL2T+sPpSstcEVcs/1Q==
X-Proofpoint-GUID: J4fY7JwYH-5tY62RETReDjWpYO56fEAz
X-Proofpoint-ORIG-GUID: 0fNFvO16SLDAC67QJGypJ523cv1jha8w
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=695a2dec cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=k5HhAvMCjMkWqej7Z0cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601040081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260104_010812_792008_84BD0C91 
X-CRM114-Status: GOOD (  17.76  )
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



On 12/27/25 3:07 PM, Sagi Grimberg wrote:
> 
>>> Can you please run benchmarks with `blocksize_range`/`bssplit`/`cpuload`/`cpuchunks`/`cpumode` ?
>> Okay, so I ran the benchmark using bssplit, cpuload, and cpumode. Below is the job
>> file I used for the test, followed by the observed throughput result for reference.
>>
>> Job file:
>> =========
>>
>> [global]
>> time_based
>> runtime=120
>> group_reporting=1
>>
>> [cpu]
>> ioengine=cpuio
>> cpuload=85
>> cpumode=qsort
>> numjobs=32
>>
>> [disk]
>> ioengine=io_uring
>> filename=/dev/nvme1n2
>> rw=<randread/randwrite/randrw>
>> bssplit=4k/10:32k/10:64k/10:128k/30:256k/10:512k/30
>> iodepth=32
>> numjobs=32
>> direct=1
>>
>> Throughput:
>> ===========
>>
>>           numa          round-robin   queue-depth    adaptive
>>           -----------   -----------   -----------    ---------
>> READ:    1120 MiB/s    2241 MiB/s    2233 MiB/s     2215 MiB/s
>> WRITE:   1107 MiB/s    1875 MiB/s    1847 MiB/s     1892 MiB/s
>> RW:      R:1001 MiB/s  R:1047 MiB/s  R:1086 MiB/s   R:1112 MiB/s
>>           W:999  MiB/s  W:1045 MiB/s  W:1084 MiB/s   W:1111 MiB/s
>>
>> When comparing the results, I did not observe a significant throughput
>> difference between the queue-depth, round-robin, and adaptive policies.
>> With random I/O of mixed sizes, the adaptive policy appears to average
>> out the varying latency values and distribute I/O reasonably evenly
>> across the active paths (assuming symmetric paths).
>>
>> Next I'd implement I/O size buckets and also per-numa node weight and
>> then rerun tests and share the result. Lets see if these changes help
>> further improve the throughput number for adaptive policy. We may then
>> again review the results and discuss further.
>>
>> Thanks,
>> --Nilay
> 
> two comments:
> 1. I'd make reads split slightly biased towards small block sizes, and writes biased towards larger block sizes
> 2. I'd also suggest to measure having weights calculation averaged out on all numa-node cores and then set percpu (such that
> the datapath does not introduce serialization).

Thanks for the suggestions. I ran experiments incorporating both points—
biasing I/O sizes by operation type and comparing per-CPU vs per-NUMA
weight calculation—using the following setup.

Job file:
=========
[global]
time_based
runtime=120
group_reporting=1

[cpu]
ioengine=cpuio
cpuload=85
numjobs=32

[disk]
ioengine=io_uring
filename=/dev/nvme1n1
rw=<randread/randwrite/randrw>
bssplit=<based-on-I/O-pattern-type>[1]
iodepth=32
numjobs=32
direct=1
==========

[1] Block-size distributions:
    randread  => bssplit = 512/30:4k/25:8k/20:16k/15:32k/10
    randwrite => bssplit = 4k/10:64k/20:128k/30:256k/40
    randrw    => bssplit = 512/20:4k/25:32k/25:64k/20:128k/5:256k/5

Results:
=======

i) Symmetric paths + system load
   (CPU stress using cpuload):

         per-CPU   per-CPU-IO-buckets       per-NUMA   per-NUMA-IO-buckets
         (MiB/s)         (MiB/s)             (MiB/s)        (MiB/s)     
         -------   -------------------      --------   -------------------
READ:    636          621                   613           618  
WRITE:   1832         1847                  1840          1852
RW:      R:872        R:869                 R:866         R:874   
         W:872        W:870                 W:867         W:876 

ii) Asymmetric paths + system load
   (CPU stress using cpuload and iperf3 traffic for inducing network congestion):

         per-CPU   per-CPU-IO-buckets       per-NUMA   per-NUMA-IO-buckets
         (MiB/s)         (MiB/s)             (MiB/s)        (MiB/s)     
         -------   -------------------      --------   -------------------
READ:    553          543                   540           533  
WRITE:   1705         1670                  1710          1655
RW:      R:769        R:771                 R:784         R:772   
         W:768        W:767                 W:785         W:771 


Looking at the above results,
- Per-CPU vs per-CPU with I/O buckets:
  The per-CPU implementation already averages latency effectively across CPUs.
  Introducing per-CPU I/O buckets does not provide a meaningful throughput
  improvement and remains largely comparable.

- Per-CPU vs per-NUMA aggregation:
  Calculating or averaging weights at the NUMA level does not significantly
  improve throughput over per-CPU weight calculation. Across both symmetric
  and asymmetric scenarios, the results remain very close.

So now based on above results and assessment, unless there are additional
scenarios or metrics of interest, shall we proceed with per-CPU weight 
calculation for this new I/O policy?

Thanks,
--Nilay

