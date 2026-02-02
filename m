Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34870E7316D
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 13:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SJopLitF7uFUacQ/Ou3XiVr+/TiDQHvyPWDBS5iGAM0=; b=uzKSndPf0aT9318gSwTx8NsWZu
	lTslM7MRsuf7wBIL+hHoARL83fRHvkTEzSCEw78f+eKzsicqVGo5FvtMP1glYsNsnmjLVupwQc6jA
	O42y2X0jzzSPg58iO20pAtMplx7/bvvUSBGiQEZN7xNpbkDoP2IezzfjroEMuuLUIFzZGvx9rd+JI
	xG/1D1McCOwOIWW1NpItqlUmmx9aG3ffO71TEKg1jPo9vHc1noeS1wOpTnYkUgOIOWxjP9IM+AIVF
	zrnC15FVdx1MGIKHKQgz2fqjiYE7VWHPhIpOsx/87aoWEGVd0EB0lCqkQF5gUr+tafODivR/e2hMI
	AWxCEphQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmu45-000000050wt-0m3M;
	Mon, 02 Feb 2026 13:34:05 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmu43-000000050w3-044T
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 13:34:04 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 611Hdf0v032144;
	Mon, 2 Feb 2026 13:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SJopLi
	tF7uFUacQ/Ou3XiVr+/TiDQHvyPWDBS5iGAM0=; b=eHTro59DNnwO12j+gK0z2R
	F+VZzFkb1WukqVLyKq9tLWXCKIiUG+E934k9pgpBMY/NkQXWG6m+1I42wPRfByui
	jS1jg2Qvty84lwqFiJ6F3lgHn27W2mJlBGBzOmqt6AkPlVF0k4yX20o6DrI4NFJr
	KAUGZrPUJZAr+r5hTeJ7+Cxva7iKjeRK164wa9ceLeyAyjHbTK6h9TpOsNl3DSoD
	3smRigjwIfPEDR6WKRoAT30io2YcDojCaJHwrIqZt/0F8WQJz5ZYKfSDiyaDOT5z
	JIfc+CRSI7D/A5FxwJayS+02HGzowia2XUoPPO+KBZsYu8IPZWRt71IsfWdcnHCw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dt0gwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 13:33:56 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 612DXtVx003304;
	Mon, 2 Feb 2026 13:33:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dt0gwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 13:33:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6129nFhf004411;
	Mon, 2 Feb 2026 13:33:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1wjjn3ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 13:33:54 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 612DXr9J24314452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Feb 2026 13:33:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FEB058059;
	Mon,  2 Feb 2026 13:33:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAC1358058;
	Mon,  2 Feb 2026 13:33:50 +0000 (GMT)
Received: from [9.109.198.179] (unknown [9.109.198.179])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Feb 2026 13:33:50 +0000 (GMT)
Message-ID: <cf426e56-d14e-413b-a846-5dd437cbf040@linux.ibm.com>
Date: Mon, 2 Feb 2026 19:03:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 2/7] nvme-multipath: add support for adaptive I/O
 policy
From: Nilay Shroff <nilay@linux.ibm.com>
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
 <c8fa5728-5ee1-4f79-b288-71edcefe135d@linux.ibm.com>
 <ccc78156-8969-486d-b1e9-3ed7f05b668d@grimberg.me>
 <6c2ed0d7-fd7d-4375-9e77-501a24494531@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <6c2ed0d7-fd7d-4375-9e77-501a24494531@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEwNSBTYWx0ZWRfX5T6P3wx7fHRP
 nNfrjpxD/oR2PL4CRs/pOtdWHAz29xSg6v9/yjpJLoxR0mtX3Gvc7edP6FJ12O2E7qx0I1oI7Ek
 fyXdqZuLyXsvNrdd5Y/oTsYhuid5S8P9qwrEmqAObNXsANDwI+k3i1BsTZHPIaOpcI03tTysb34
 mjd//Vwdk51FfW0sRGwaju+uH78PiO4725pVeiZPP9A3ACMu4ICgY38UfX9Q/s+WvnoQBGzdXnr
 HRSETVFuQDOxTeBX3EDaP3cL6AjOoo7eVjRn9F3SyO4MkdhKWsrcXA+eXGmFCFc/BCBUcnR5IV/
 OPtJQbelAkt1KLxxq6PDHqTwz2ludriviWPThS/6u7wakUVjuAW799GiCu9/TgGA8EmaLNUsoc9
 gdQTvqldPToEs5BbAXBamlG3czMYw3kP+OkK3LkxQKOd9oACVllZ6mLYWzjYkHDqm32aHYoy9ln
 Ah9cBSCQL84jcRz8dMw==
X-Proofpoint-GUID: 5_Zy4lrUnhqgLOh5lSh29HCVHUCDHjhl
X-Proofpoint-ORIG-GUID: JW9asTy94XZdO_LSwTPhWjpliXTweR58
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=6980a7c4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ZdCEgcxLDoDJ6L-VpxsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=RcjFw8qnwC3rwMBoGmW7:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602020105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_053403_073545_2C8002E6 
X-CRM114-Status: GOOD (  31.74  )
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



On 1/6/26 7:46 PM, Nilay Shroff wrote:
> 
> 
> On 1/5/26 2:36 AM, Sagi Grimberg wrote:
>>
>>
>> On 04/01/2026 11:07, Nilay Shroff wrote:
>>>
>>> On 12/27/25 3:07 PM, Sagi Grimberg wrote:
>>>>>> Can you please run benchmarks with `blocksize_range`/`bssplit`/`cpuload`/`cpuchunks`/`cpumode` ?
>>>>> Okay, so I ran the benchmark using bssplit, cpuload, and cpumode. Below is the job
>>>>> file I used for the test, followed by the observed throughput result for reference.
>>>>>
>>>>> Job file:
>>>>> =========
>>>>>
>>>>> [global]
>>>>> time_based
>>>>> runtime=120
>>>>> group_reporting=1
>>>>>
>>>>> [cpu]
>>>>> ioengine=cpuio
>>>>> cpuload=85
>>>>> cpumode=qsort
>>>>> numjobs=32
>>>>>
>>>>> [disk]
>>>>> ioengine=io_uring
>>>>> filename=/dev/nvme1n2
>>>>> rw=<randread/randwrite/randrw>
>>>>> bssplit=4k/10:32k/10:64k/10:128k/30:256k/10:512k/30
>>>>> iodepth=32
>>>>> numjobs=32
>>>>> direct=1
>>>>>
>>>>> Throughput:
>>>>> ===========
>>>>>
>>>>>            numa          round-robin   queue-depth    adaptive
>>>>>            -----------   -----------   -----------    ---------
>>>>> READ:    1120 MiB/s    2241 MiB/s    2233 MiB/s     2215 MiB/s
>>>>> WRITE:   1107 MiB/s    1875 MiB/s    1847 MiB/s     1892 MiB/s
>>>>> RW:      R:1001 MiB/s  R:1047 MiB/s  R:1086 MiB/s   R:1112 MiB/s
>>>>>            W:999  MiB/s  W:1045 MiB/s  W:1084 MiB/s   W:1111 MiB/s
>>>>>
>>>>> When comparing the results, I did not observe a significant throughput
>>>>> difference between the queue-depth, round-robin, and adaptive policies.
>>>>> With random I/O of mixed sizes, the adaptive policy appears to average
>>>>> out the varying latency values and distribute I/O reasonably evenly
>>>>> across the active paths (assuming symmetric paths).
>>>>>
>>>>> Next I'd implement I/O size buckets and also per-numa node weight and
>>>>> then rerun tests and share the result. Lets see if these changes help
>>>>> further improve the throughput number for adaptive policy. We may then
>>>>> again review the results and discuss further.
>>>>>
>>>>> Thanks,
>>>>> --Nilay
>>>> two comments:
>>>> 1. I'd make reads split slightly biased towards small block sizes, and writes biased towards larger block sizes
>>>> 2. I'd also suggest to measure having weights calculation averaged out on all numa-node cores and then set percpu (such that
>>>> the datapath does not introduce serialization).
>>> Thanks for the suggestions. I ran experiments incorporating both points—
>>> biasing I/O sizes by operation type and comparing per-CPU vs per-NUMA
>>> weight calculation—using the following setup.
>>>
>>> Job file:
>>> =========
>>> [global]
>>> time_based
>>> runtime=120
>>> group_reporting=1
>>>
>>> [cpu]
>>> ioengine=cpuio
>>> cpuload=85
>>> numjobs=32
>>>
>>> [disk]
>>> ioengine=io_uring
>>> filename=/dev/nvme1n1
>>> rw=<randread/randwrite/randrw>
>>> bssplit=<based-on-I/O-pattern-type>[1]
>>> iodepth=32
>>> numjobs=32
>>> direct=1
>>> ==========
>>>
>>> [1] Block-size distributions:
>>>      randread  => bssplit = 512/30:4k/25:8k/20:16k/15:32k/10
>>>      randwrite => bssplit = 4k/10:64k/20:128k/30:256k/40
>>>      randrw    => bssplit = 512/20:4k/25:32k/25:64k/20:128k/5:256k/5
>>>
>>> Results:
>>> =======
>>>
>>> i) Symmetric paths + system load
>>>     (CPU stress using cpuload):
>>>
>>>           per-CPU   per-CPU-IO-buckets       per-NUMA   per-NUMA-IO-buckets
>>>           (MiB/s)         (MiB/s)             (MiB/s)        (MiB/s)
>>>           -------   -------------------      --------   -------------------
>>> READ:    636          621                   613           618
>>> WRITE:   1832         1847                  1840          1852
>>> RW:      R:872        R:869                 R:866         R:874
>>>           W:872        W:870                 W:867         W:876
>>>
>>> ii) Asymmetric paths + system load
>>>     (CPU stress using cpuload and iperf3 traffic for inducing network congestion):
>>>
>>>           per-CPU   per-CPU-IO-buckets       per-NUMA   per-NUMA-IO-buckets
>>>           (MiB/s)         (MiB/s)             (MiB/s)        (MiB/s)
>>>           -------   -------------------      --------   -------------------
>>> READ:    553          543                   540           533
>>> WRITE:   1705         1670                  1710          1655
>>> RW:      R:769        R:771                 R:784         R:772
>>>           W:768        W:767                 W:785         W:771
>>>
>>>
>>> Looking at the above results,
>>> - Per-CPU vs per-CPU with I/O buckets:
>>>    The per-CPU implementation already averages latency effectively across CPUs.
>>>    Introducing per-CPU I/O buckets does not provide a meaningful throughput
>>>    improvement and remains largely comparable.
>>>
>>> - Per-CPU vs per-NUMA aggregation:
>>>    Calculating or averaging weights at the NUMA level does not significantly
>>>    improve throughput over per-CPU weight calculation. Across both symmetric
>>>    and asymmetric scenarios, the results remain very close.
>>>
>>> So now based on above results and assessment, unless there are additional
>>> scenarios or metrics of interest, shall we proceed with per-CPU weight
>>> calculation for this new I/O policy?
>>
>> I think it is counter intuitive that bucketing I/O sizes does not present any advantage. Don't you?
>> Maybe the test is not good enough of a representation...
>>
> Hmm you were correct, I also thought the same but I couldn't find 
> any test which could prove the advantage using I/O buckets. Then
> today I spend some time thinking about the scenarios which could
> prove the worth using I/O buckets. After some thought I came up
> with following use case.
> 
> Size-dependent path behavior:
> 
> 1. Example:
>    Path A: good for ≤16k, bad for ≥32k
>    Path B: good for all 
> 
>    Now running mixed I/O (bssplit => 16k/75:64k/25),
> 
>    Without buckets:
>    Path B looks good; scheduler forwards more I/Os towards path B.
> 
>    With buckets:
>    small I/Os are distributed across path A and B
>    large I/Os favor path B
> 
>    So in theory, throughput shall improve with buckets.
> 
> 2. Example:
>    Path A: good for ≤16k, bad for ≥32k
>    Path B: opposite
> 
>    Without buckets:
>    latency averages cancel out
>    scheduler sees “paths are equal”
> 
>    With buckets:
>    small I/O bucket favors A
>    large I/O bucket favors B
> 
>    Again in theory, throughput shall improve with buckets.
> 
> So with the above thought, I ran another experiment and results
> are shown below:
> 
> Injecting additional delay on one path for larger packets (>=32k)
> and mixing I/Os with bssplit => 16k/75:64k/25. So with this
> test, we have,
> Path A: good for ≤16k, bad for ≥32k
> Path B: good for all  
> 
>          per-CPU   per-CPU-IO-buckets       per-NUMA   per-NUMA-IO-buckets
>          (MiB/s)         (MiB/s)             (MiB/s)        (MiB/s)
>          -------   -------------------      --------   -------------------
> READ:    550          622                   523         615
> WRITE:   726          829                   747         834
> RW:      R:324        R:381                 R: 306     R:375
>          W:323        W:381                 W: 306     W:374
> 
> So yes I/O buckets could be useful for the scenario tested 
> above. And regarding per-CPU vs per-NUMA weight calculation
> do you agree per-CPU should be good enough for this policy
> as we saw above per-NUMA doesn't help improve much performance?
> 
> 
>> Lets also test what happens with multiple clients against the same subsystem.
> Yes this is a good test to run, I will test and post result.
> 

Finally, I was able to run tests with two nvmf-tcp hosts connected
to the same nvmf-tcp target. Apologies for the delay — setting up this
topology took some time, partly due to recent non-technical infrastructure
challenges after our lab relocation.

The goal of these tests was to evaluate per-CPU vs per-NUMA weight calculation,
with and without I/O size buckets, under multi-client contention.

I ran tests (randread, randwrite and randrw) with mixed I/O (using bssplit)
and added the CPU stress on hosts using cpuload as I already did for my 
earlier tests. Please find below the test result and observation.

Workload characteristics:
=========================
- Workloads tested: randread, randwrite, randrw
- Mixed I/O sizes using bssplit
- CPU stress induced using cpuload
- Both hosts run workloads simultaneously

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
ramp-time=120

[1] Block-size distributions:
      randread  => bssplit = 512/30:4k/25:8k/20:16k/15:32k/10
      randwrite => bssplit = 4k/10:64k/20:128k/30:256k/40
      randrw    => bssplit = 512/20:4k/25:32k/25:64k/20:128k/5:256k/5

Test topology: 
==============
1. Two nvmf-tcp hosts connected to the same nvmf-tcp target
2. Each host connects to target using two symmetric paths
3. System load on each host is induced using cpuload (as shown in jobfile)
4. Both hosts run I/O workloads concurrently

Results:
=======
Host1:
          per-CPU   per-CPU-IO-buckets       per-NUMA   per-NUMA-IO-buckets
          (MiB/s)         (MiB/s)             (MiB/s)        (MiB/s)
          -------   -------------------      --------   -------------------
READ:      153         164			166        131
WRITE:     839         837                      889        839
RW:        R:249       R:255                    R:226      R:256
           W:247       W:254                    W:225      W:253

Host2:

          per-CPU   per-CPU-IO-buckets       per-NUMA   per-NUMA-IO-buckets
          (MiB/s)         (MiB/s)             (MiB/s)        (MiB/s)
          -------   -------------------      --------   -------------------
READ:     268          258                     279         268
WRITE:    1012         992                     880         1017
RW:       R:386        R:410                   R:401       R:405
          W:385        W:409                   W:399       W:405


From the above results, I have got the same impression as earlier while I ran the
similar tests between one nvmf-tcp host and target. Looking at the above results,

Per-CPU vs per-CPU with I/O buckets:
- The per-CPU implementation already averages latency effectively across CPUs.
- Introducing per-CPU I/O buckets does not provide a meaningful throughput 
  improvement in the general case.
- Results remain largely comparable across workloads and hosts.
- However, as shown in earlier experiments with I/O size–dependent path behavior,
  I/O buckets can provide measurable benefits in specific scenarios.

Per-CPU vs per-NUMA aggregation:
- Calculating or averaging weights at the NUMA level does not significantly improve
  throughput over per-CPU weight calculation.
- This holds true even under multi-host contention.

Based on all the tests conducted so far, including, symmetric and asymmetric paths,
CPU stress, size-dependent path behavior and multi-client access to the same target:

The results suggest that we should move forward with a per-CPU implementation using
I/O buckets. That said, I am open to any further feedback, suggestions, or additional
scenarios that might be worth evaluating.

Thanks,
--Nilay

