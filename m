Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB818E8FDA7
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Dec 2025 18:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VdyQM5gugJ/EHVm8CNzhlY2T30EKjsAQv0qVPfeQZqg=; b=FYXV63qQhgzr0Z6GemxXDlWU0V
	q40HpfuUkbbTNaByQxA00kKq2GUwBxQ5JaYWgPAozTfGdcyKUoromvkS/SMOGx2v5TjKpFRiu3r9p
	haYZbcc9KqdvoGd3FzSe9dXGGYPvzztItrWK1uNRm0VByYGdvei0KgCV94sAFbtyhniLUnSer/aYE
	v3QgE5oCvroE3/+bREf/9Zb6Dihl/TubhxQICvlv08zsPmkBZJNqZGAooPsJRnJCafwh4mfX7zoHC
	TFW8MCXPm8wvcwds6hUlJYzMmeAiEDS1SAEsUH2XTfHUrkuLNgIaeOxifdrKIIui6rxp4ujHr4OWe
	xMr0JCHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZCMh-00000001Mzf-13ux;
	Fri, 26 Dec 2025 18:16:39 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZCMe-00000001MzC-3ntC
	for linux-nvme@lists.infradead.org;
	Fri, 26 Dec 2025 18:16:38 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BQHauMP030245;
	Fri, 26 Dec 2025 18:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VdyQM5
	gugJ/EHVm8CNzhlY2T30EKjsAQv0qVPfeQZqg=; b=VVgm/MxJb6gw8dscWJO8IX
	xgnuaRrtKEU2Q5zJh3FCorLUdvkyMqvAJiSWRFhsb3UxODAWz65PHq1luJPss77b
	cvgRvX+c7HgDUWUv/pzRpfcubmyMFNAXPzF+qL51PuJEblxHREg01/Kq1FiEzjip
	RtCxacit0/asj0w+c+MW85oV0u4hMUGgSbrhkog+KVLH77PpBaAQy86ofxW21Hup
	JxjRgrC89zhdwT/bF/n/rVnhOupqXCdzmxR8RywmzcqT30lkiUhEKtK6cfNjS1wH
	6RoUI9yI3Pd+rDrjHhbjbaTF14uxnFGiTCc+bUQhUpXBIlYWpw6BeIIhYBPY80cQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5ka3s5tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Dec 2025 18:16:16 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BQIGFwD008061;
	Fri, 26 Dec 2025 18:16:15 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5ka3s5tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Dec 2025 18:16:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BQHRqFk032332;
	Fri, 26 Dec 2025 18:16:14 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b68u1gsm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Dec 2025 18:16:14 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BQIGE2Z27132524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 18:16:14 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CD7758052;
	Fri, 26 Dec 2025 18:16:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AB3C5805A;
	Fri, 26 Dec 2025 18:16:10 +0000 (GMT)
Received: from [9.87.156.104] (unknown [9.87.156.104])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Dec 2025 18:16:09 +0000 (GMT)
Message-ID: <81d9feb1-9134-464c-9c4e-393694732426@linux.ibm.com>
Date: Fri, 26 Dec 2025 23:46:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <37a61dbc-7d5e-4f28-b6cf-5c5c21e9cdbb@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ldnOyfJYxMqsXN90QsQp_TK82aYSLYfT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI2MDE2NiBTYWx0ZWRfXzKpKaS1ton7O
 g30hybweklMhZChWFZ+N8paKo4DZyKIBBaeuTz5xFkBLMLmrtCo47tFi8V9iDjLk2RgFCLCb7gD
 iof6mALpKZeaDUHUSMJsNWwyG0+NrbfvAe8tGorEKoemkm3r0GOC++65tOOkl5PTk6EUfJn5zQg
 nHop68pBy1gx7ZlOLvKoe0hPGfxUoLhWPj84r9kjIk5Uo1jFUuimu/M0DaFWF3CetG9yRLKxBTP
 NQvXBDE7pewmLvarp/q1iGG0CSD6RpiBaucEcbgFZ0E2MRMW05f/aK8Jy5CLMYZNJmoRe1QwHZF
 Qu3Ug9hR7UXinoqzUescwpf6hFx7vQYoPMQXPLzJ9chAYfI7kYrT1sBivTBdJ8tybYJx72ueslG
 wP9+BK+CYB+OinFKsAWxuSa4GjZheOFieWhjX+VJ7lZdRSsT8e8YZlLNRqlsh7QmxiLDThlYYhU
 1X1OznMPh3ZAMHhZIyg==
X-Proofpoint-ORIG-GUID: dg8ekBu4NfgNycPvxY-MvF0bPKh0pZYZ
X-Authority-Analysis: v=2.4 cv=dqHWylg4 c=1 sm=1 tr=0 ts=694ed0f0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=lB0VOkVoC3I9QY4ahuEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-26_05,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512260166
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251226_101636_989006_95997803 
X-CRM114-Status: GOOD (  34.76  )
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



On 12/25/25 6:15 PM, Sagi Grimberg wrote:
> 
> 
> On 23/12/2025 16:50, Nilay Shroff wrote:
>> [...]
>>>>> I am not sure that normalizing to 512 blocks is a good proxy. I think that large IO will
>>>>> have much lower amortized latency per 512 block. which could create an false bias
>>>>> to place a high weight on a path, if that path happened to host large I/Os no?
>>>>>
>>>> Hmm, I think yes, good point, I think for nvme over fabrics this could be true.
>>>>
>>> Although technically we are then measure two different things (IO latency vs block latency). But yeah, block latency might be better
>>> suited for the normal case; I do wonder, though, if for high-speed
>>> links we do see a difference as the data transfer time is getting
>>> really fast...
>>>
>> For a high speed/bandwidth NIC card the transfer speed would be very fast,
>> though I think for a very large I/O size, we would see a higer latency due
>> to tcp segmentation and re-assembly.
>>
>> On my nvmf-tcp testbed, I do see the latency differences as shown below
>> for varying I/O size (captured for random-read direct I/O workload):
>> I/O-size    Avg-latency(usec)
>>   512            12113
>>   1k             10058
>>   2k             11246
>>   4k             12458
>>   8k             12189
>>   16k            11617
>>   32k            17686
>>   64k            28504
>>   128k           59013
>>   256k           118984
>>   512k           233428
>>   1M             460000
>>
>> As can be seen, for smaller block sizes (512B–16K), latency remains relatively
>> stable in the ~10–12 ms range. Starting at 32K and more noticeably at 64K and
>> above, latency increases significantly and roughly doubles with each step in
>> block size. Based on this data, I propose using coarse-grained I/O size buckets
>> to preserve latency characteristics while avoiding excessive fragmentation of
>> statistics. The suggested bucket layout is as follows:
>>
>> Bucket        block-size-range
>> small        512B-32k
>> medium        32k-64k
>> large-64k    64k-128k
>> large-128k    128k-256k
>> large-256k    256k-512k
>> large-512k    512k-1M
>> very-large    >=1M
>>
>> In this model,
>> - A single small bucket captures latency for I/O sizes where latency remains
>>    largely uniform.
>> - A medium bucket captures the transition region.
>> - Separate large buckets preserve the rapidly increasing latency behavior
>>    observed for larger block sizes.
>> - A very-large bucket handles any I/O beyond 1M.
>>
>> This approach allows the adaptive policy to retain meaningful latency distinctions across
>> I/O size regimes while keeping the number of buckets manageable and statistically stable,
>> make sense?
> 
> Yes
> 
>>
>>> [ .. ]
>>>>>> I understand your concern about whether it really makes sense to keep this
>>>>>> per-cpu-per-ns, and I see your point that you would prefer maintaining the
>>>>>> stat per-hctx instead of per-CPU.
>>>>>>
>>>>>> However, as mentioned earlier, during path selection we cannot reliably map an
>>>>>> I/O to a specific hctx, so using per-hctx statistics becomes problematic in
>>>>>> practice. On the other hand, maintaining the metrics per-CPU has an additional
>>>>>> advantage: on a NUMA-aware system, the measured I/O latency naturally reflects
>>>>>> the NUMA distance between the workload’s CPU and the I/O controller. This means
>>>>>> that on multi-node systems, the policy can automatically favor I/O paths/controllers
>>>>>> that are local/near to the CPU issuing the request, which may lead to better
>>>>>> latency characteristics.
>>>>> With this I tend to agree. but per-cpu has lots of other churns IMO.
>>>>> Maybe the answer is that paths weights are maintained per NUMA node?
>>>>> then accessing these weights in the fast-path is still cheap enough?
>>>> That’s a fair point, and I agree that per-CPU accounting can introduce additional
>>>> variability. However, moving to per-NUMA path weights would implicitly narrow the
>>>> scope of what we are trying to measure, as it would largely exclude components of
>>>> end-to-end latency that arise from scheduler behavior and application-level scheduling
>>>> effects. As discussed earlier, the intent of the adaptive policy is to capture the
>>>> actual I/O cost observed by the workload, which includes not only path and controller
>>>> locality but also fabric, stack, and scheduling effects. From that perspective, IMO,
>>>> maintaining per-CPU path weights remains a better fit for the stated goal. It also
>>>> offers a dual advantage: naturally reflecting NUMA locality on a per-CPU basis while
>>>> preserving a true end-to-end view of path latency, agreed?
>>>>
>>> Well, for fabrics you can easily have several paths connected to the same NUMA node (like in the classical 'two initiator ports cross-connected to two target ports', resulting in four paths in total.
>>> But two of these paths will always be on the same NUMA node).
>>> So that doesn't work out.
>>>
>>>> I conducted an experiment on my NVMe-oF TCP testbed while simultaneously running
>>>> iperf3 TCP traffic to introduce both CPU and network load alongside fio. The
>>>> host system has 32 cpus, so iperf3 was configured with 32 parallel TCP streams.
>>>> And fio was configured with numjobs=32, iodepth=32, bs=4K, direct I/O, and
>>>> ioengine=io_uring. Below are the aggregated throughput results observed under
>>>> different NVMe multipath I/O policies:
>>>>
>>>>           numa         round-robin   queue-depth  adaptive
>>>>           -----------  -----------   -----------  ---------
>>>> READ:   61.1 MiB/s   87.2 MiB/s    93.1 MiB/s   107 MiB/s
>>>> WRITE:  95.8 MiB/s   138 MiB/s     159 MiB/s    179 MiB/s
>>>> RW:     R:29.8 MiB/s R:53.1 MiB/s  R:58.8 MiB/s R:66.6 MiB/s
>>>>           W:29.6 MiB/s W:52.7 MiB/s  W:58.2 MiB/s W:65.9 MiB/s
>>>>
>>>> These results show that under combined CPU and network stress, the adaptive I/O policy
>>>> consistently delivers higher throughput across read, write, and mixed workloads when
>>>> comapred against existing policies.
>>>>    
>>> And that is probably the best argument; we should put it under stress with various scenarios. I must admit I am _really_ in favour of this
>>> iopolicy, as it would be able to handle any temporary issues on the fabric (or backend) without the need of additional signalling.
>>> Talk to me about FPIN ...
>>>
>> I ran additional experiments on the NVMe-oF TCP testbed. The host has 32 cpus so fio
>> was configured with numjobs=32, iodepth=32, bs=4K, direct I/O, and ioengine=io_uring.
>> Below are the aggregated throughput results observed under different NVMe multipath
>> I/O policies.
>>
>> i) Stressing all 32 cpus using stress-ng
>>
>> All 32 CPUs were stressed using:
>> # stress-ng --cpu 0 --cpu-method all -t 60m
>>
>>           numa          round-robin   queue-depth  adaptive
>>           -----------   -----------   -----------  ---------
>> READ:    159 MiB/s     193 MiB/s     215 MiB/s    255 MiB/s
>> WRITE:   188 MiB/s     186 MiB/s     195 MiB/s    199 MiB/s
>> RW:      R:83.4 MiB/s  R:101 MiB/s   R:104 MiB/s  R: 111 MiB/s
>>           W:83.3 MiB/s  W:101 MiB/s   W:105 MiB/s  W: 112 MiB/s
>>
>> ii) Symmetric paths (No CPU stress and no induced network load):
>>
>>           numa          round-robin   queue-depth   adaptive
>>           -----------   -----------   -----------   ---------
>> READ:    171 MiB/s     298 MiB/s     320 MiB/s     348 MiB/s
>> WRITE:   229 MiB/s     419 MiB/s     442 MiB/s     460 MiB/s
>> RW:     R: 93.0 MiB/s  R: 166 MiB/s  R: 171 MiB/s  R: 179 MiB/s
>>          W: 94.2 MiB/s  W: 168 MiB/s  W: 168 MiB/s  W: 178 MiB/s
>>
>> These results show that the adaptive I/O policy consistently delivers higher
>> throughput under CPU stress and asymmetric path conditions. In case of symmetric
>> paths the adaptive policy achieves throughput comparable to—or slightly
>> better than—existing policies.
> 
> I still think that accounting uncorrelated latency is the best approach here.
> 
> My intuition tells me that:
> 1. averaging latencies over numa-node
> 2. calculating weights
> 3. distribute new weights per-cpu in the numa-node
> 
> Is a better approach. It is hard to evaluate without adding some randomness.
> 
> Can you please run benchmarks with `blocksize_range`/`bssplit`/`cpuload`/`cpuchunks`/`cpumode` ?

Okay, so I ran the benchmark using bssplit, cpuload, and cpumode. Below is the job
file I used for the test, followed by the observed throughput result for reference.

Job file:
=========

[global]
time_based
runtime=120
group_reporting=1

[cpu]
ioengine=cpuio
cpuload=85
cpumode=qsort
numjobs=32

[disk]
ioengine=io_uring
filename=/dev/nvme1n2
rw=<randread/randwrite/randrw>
bssplit=4k/10:32k/10:64k/10:128k/30:256k/10:512k/30
iodepth=32
numjobs=32
direct=1

Throughput:
===========

         numa          round-robin   queue-depth    adaptive
         -----------   -----------   -----------    ---------
READ:    1120 MiB/s    2241 MiB/s    2233 MiB/s     2215 MiB/s
WRITE:   1107 MiB/s    1875 MiB/s    1847 MiB/s     1892 MiB/s
RW:      R:1001 MiB/s  R:1047 MiB/s  R:1086 MiB/s   R:1112 MiB/s
         W:999  MiB/s  W:1045 MiB/s  W:1084 MiB/s   W:1111 MiB/s

When comparing the results, I did not observe a significant throughput
difference between the queue-depth, round-robin, and adaptive policies.
With random I/O of mixed sizes, the adaptive policy appears to average
out the varying latency values and distribute I/O reasonably evenly
across the active paths (assuming symmetric paths).

Next I'd implement I/O size buckets and also per-numa node weight and
then rerun tests and share the result. Lets see if these changes help
further improve the throughput number for adaptive policy. We may then
again review the results and discuss further.

Thanks,
--Nilay

