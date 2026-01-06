Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA909C47BF2
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jan 2026 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZAaCSWvFBQcqeGINCWWNvSo8qe0GA6D7UIc5bsG8ioM=; b=zsLpAzi5mMU6JP+8RdExAAYTNg
	NPyyPp5buOcUtqINeurPai5JvvXls9X5OCa383U5M21j2softBwnFjaCgApVCXrdrmSdrsI1lxj5r
	ucpkBY+LX4PR/DHvLGFeyxFSYAxeDn0Mbuf22aDiY7dUQPE0uQtgEedhTVPvQcCSdpT8sqY5DmLmz
	6bs4ohuOyL9jnsFjcJR63Cnk61ptvqTym0m7GjgXvva+LULRhH3CtJUnGI8Ar8j428yiE/H71f7sI
	CXuPCoXn1NpgRA3+4p5oUAqy0ibomeFlGS4YThilT+O9AaC15plEqjqH5rrt24gFUBMiZF1Qc3Q6V
	Xxu2MUJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd7rg-0000000DGOT-1UAM;
	Tue, 06 Jan 2026 14:16:52 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd7rd-0000000DGO4-2HdX
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jan 2026 14:16:50 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60652Qlu008700;
	Tue, 6 Jan 2026 14:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZAaCSW
	vFBQcqeGINCWWNvSo8qe0GA6D7UIc5bsG8ioM=; b=JrJAvo4oMOKt3nimm4W96x
	9Tn5s/HNHew0IDCX62zmuLgnAqa7nCLK56xDlZPmQsv4L77WDnLeJ7fnmAcSP9TO
	nBXc5tf0o/pgkERv47gE+kKEF1A/LJ5ppY0eaS+U23ixjO6ikf2a5HhUMZ/STGU9
	sWLzh+jNN8cthNkGzuZI2nUDNKHsew9tjiwgXQ0MHVNjMom1mnMtoK4gIdK0o1nq
	1qd07PzLpgf8yL/jLhf+ahdka+QqNeecKmFZbNNKr8nbWEpfnMF/jqTpdBMtCeIr
	p5Po24Ah3EYNhPfxerhtNy3r6r2mptvh0uCXBxTE7GDmUkf11nRs2ssCx/VahYjQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu647qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 14:16:37 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 606EGanl008528;
	Tue, 6 Jan 2026 14:16:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu647qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 14:16:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 606E1c9M012572;
	Tue, 6 Jan 2026 14:16:35 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnjbhgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 14:16:35 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 606EGZ7S26346034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Jan 2026 14:16:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5493658056;
	Tue,  6 Jan 2026 14:16:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 405F558065;
	Tue,  6 Jan 2026 14:16:31 +0000 (GMT)
Received: from [9.111.89.66] (unknown [9.111.89.66])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Jan 2026 14:16:30 +0000 (GMT)
Message-ID: <6c2ed0d7-fd7d-4375-9e77-501a24494531@linux.ibm.com>
Date: Tue, 6 Jan 2026 19:46:29 +0530
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
 <81d9feb1-9134-464c-9c4e-393694732426@linux.ibm.com>
 <b98e91ef-254c-44bc-b46a-0039c66539e2@grimberg.me>
 <c8fa5728-5ee1-4f79-b288-71edcefe135d@linux.ibm.com>
 <ccc78156-8969-486d-b1e9-3ed7f05b668d@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ccc78156-8969-486d-b1e9-3ed7f05b668d@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695d1945 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=o5T_UVhpnUfgyMyaCEIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uCleTVL-Wstlr649j8Z0FeI2lE-24RFZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEyNCBTYWx0ZWRfX2v5hV1r3dUKG
 LLm2DoauW1OvU2fVRgiAoe3IM81L6x/PAdB4GkLAgARcNzanS+dkUzvXoo1pd62y++RU4h5+oRZ
 B59pwYVEOKp4J4DWSOBm8YNdAl1pYhJWxIbuZ7N6CO6oq2vahI3wsCR/ZgeF+CI6OhMOGfNG74n
 zn0NLRCDqSzMuY2PWspqUSRKqh1ArNhjK5CTGaifvl3NUVPHisCHZVudx/7vPDMEtUl3PaVzT6R
 rH3hr+2CSy1D6VpAG6K7EAiE5Z+psvYfWeIPUeoTZ4JcFebAS87HxlLbn1tgVLIt+EvuF0ZCU3M
 LlkiYnF8+E5pEbMq4mZt+qD5jobfUAUtLTpg92gWy/Op73FbP7ybtcUURVkdAAEmWnWC8A1tPPS
 LHK9fnk8EvmsQFfFBUJudr0BoOV4aoSNbYdOYeqtN0nvqIAhBom3EhLySOTvPHrHtxydS6l3od3
 V1r4fe6SF1vFYQOa/qg==
X-Proofpoint-GUID: 4yfZLzs4WRDEsI6zMfkH3OS0fMvCyVWO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601060124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_061649_598662_C1EC770E 
X-CRM114-Status: GOOD (  24.65  )
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



On 1/5/26 2:36 AM, Sagi Grimberg wrote:
> 
> 
> On 04/01/2026 11:07, Nilay Shroff wrote:
>>
>> On 12/27/25 3:07 PM, Sagi Grimberg wrote:
>>>>> Can you please run benchmarks with `blocksize_range`/`bssplit`/`cpuload`/`cpuchunks`/`cpumode` ?
>>>> Okay, so I ran the benchmark using bssplit, cpuload, and cpumode. Below is the job
>>>> file I used for the test, followed by the observed throughput result for reference.
>>>>
>>>> Job file:
>>>> =========
>>>>
>>>> [global]
>>>> time_based
>>>> runtime=120
>>>> group_reporting=1
>>>>
>>>> [cpu]
>>>> ioengine=cpuio
>>>> cpuload=85
>>>> cpumode=qsort
>>>> numjobs=32
>>>>
>>>> [disk]
>>>> ioengine=io_uring
>>>> filename=/dev/nvme1n2
>>>> rw=<randread/randwrite/randrw>
>>>> bssplit=4k/10:32k/10:64k/10:128k/30:256k/10:512k/30
>>>> iodepth=32
>>>> numjobs=32
>>>> direct=1
>>>>
>>>> Throughput:
>>>> ===========
>>>>
>>>>            numa          round-robin   queue-depth    adaptive
>>>>            -----------   -----------   -----------    ---------
>>>> READ:    1120 MiB/s    2241 MiB/s    2233 MiB/s     2215 MiB/s
>>>> WRITE:   1107 MiB/s    1875 MiB/s    1847 MiB/s     1892 MiB/s
>>>> RW:      R:1001 MiB/s  R:1047 MiB/s  R:1086 MiB/s   R:1112 MiB/s
>>>>            W:999  MiB/s  W:1045 MiB/s  W:1084 MiB/s   W:1111 MiB/s
>>>>
>>>> When comparing the results, I did not observe a significant throughput
>>>> difference between the queue-depth, round-robin, and adaptive policies.
>>>> With random I/O of mixed sizes, the adaptive policy appears to average
>>>> out the varying latency values and distribute I/O reasonably evenly
>>>> across the active paths (assuming symmetric paths).
>>>>
>>>> Next I'd implement I/O size buckets and also per-numa node weight and
>>>> then rerun tests and share the result. Lets see if these changes help
>>>> further improve the throughput number for adaptive policy. We may then
>>>> again review the results and discuss further.
>>>>
>>>> Thanks,
>>>> --Nilay
>>> two comments:
>>> 1. I'd make reads split slightly biased towards small block sizes, and writes biased towards larger block sizes
>>> 2. I'd also suggest to measure having weights calculation averaged out on all numa-node cores and then set percpu (such that
>>> the datapath does not introduce serialization).
>> Thanks for the suggestions. I ran experiments incorporating both points—
>> biasing I/O sizes by operation type and comparing per-CPU vs per-NUMA
>> weight calculation—using the following setup.
>>
>> Job file:
>> =========
>> [global]
>> time_based
>> runtime=120
>> group_reporting=1
>>
>> [cpu]
>> ioengine=cpuio
>> cpuload=85
>> numjobs=32
>>
>> [disk]
>> ioengine=io_uring
>> filename=/dev/nvme1n1
>> rw=<randread/randwrite/randrw>
>> bssplit=<based-on-I/O-pattern-type>[1]
>> iodepth=32
>> numjobs=32
>> direct=1
>> ==========
>>
>> [1] Block-size distributions:
>>      randread  => bssplit = 512/30:4k/25:8k/20:16k/15:32k/10
>>      randwrite => bssplit = 4k/10:64k/20:128k/30:256k/40
>>      randrw    => bssplit = 512/20:4k/25:32k/25:64k/20:128k/5:256k/5
>>
>> Results:
>> =======
>>
>> i) Symmetric paths + system load
>>     (CPU stress using cpuload):
>>
>>           per-CPU   per-CPU-IO-buckets       per-NUMA   per-NUMA-IO-buckets
>>           (MiB/s)         (MiB/s)             (MiB/s)        (MiB/s)
>>           -------   -------------------      --------   -------------------
>> READ:    636          621                   613           618
>> WRITE:   1832         1847                  1840          1852
>> RW:      R:872        R:869                 R:866         R:874
>>           W:872        W:870                 W:867         W:876
>>
>> ii) Asymmetric paths + system load
>>     (CPU stress using cpuload and iperf3 traffic for inducing network congestion):
>>
>>           per-CPU   per-CPU-IO-buckets       per-NUMA   per-NUMA-IO-buckets
>>           (MiB/s)         (MiB/s)             (MiB/s)        (MiB/s)
>>           -------   -------------------      --------   -------------------
>> READ:    553          543                   540           533
>> WRITE:   1705         1670                  1710          1655
>> RW:      R:769        R:771                 R:784         R:772
>>           W:768        W:767                 W:785         W:771
>>
>>
>> Looking at the above results,
>> - Per-CPU vs per-CPU with I/O buckets:
>>    The per-CPU implementation already averages latency effectively across CPUs.
>>    Introducing per-CPU I/O buckets does not provide a meaningful throughput
>>    improvement and remains largely comparable.
>>
>> - Per-CPU vs per-NUMA aggregation:
>>    Calculating or averaging weights at the NUMA level does not significantly
>>    improve throughput over per-CPU weight calculation. Across both symmetric
>>    and asymmetric scenarios, the results remain very close.
>>
>> So now based on above results and assessment, unless there are additional
>> scenarios or metrics of interest, shall we proceed with per-CPU weight
>> calculation for this new I/O policy?
> 
> I think it is counter intuitive that bucketing I/O sizes does not present any advantage. Don't you?
> Maybe the test is not good enough of a representation...
> 
Hmm you were correct, I also thought the same but I couldn't find 
any test which could prove the advantage using I/O buckets. Then
today I spend some time thinking about the scenarios which could
prove the worth using I/O buckets. After some thought I came up
with following use case.

Size-dependent path behavior:

1. Example:
   Path A: good for ≤16k, bad for ≥32k
   Path B: good for all 

   Now running mixed I/O (bssplit => 16k/75:64k/25),

   Without buckets:
   Path B looks good; scheduler forwards more I/Os towards path B.

   With buckets:
   small I/Os are distributed across path A and B
   large I/Os favor path B

   So in theory, throughput shall improve with buckets.

2. Example:
   Path A: good for ≤16k, bad for ≥32k
   Path B: opposite

   Without buckets:
   latency averages cancel out
   scheduler sees “paths are equal”

   With buckets:
   small I/O bucket favors A
   large I/O bucket favors B

   Again in theory, throughput shall improve with buckets.

So with the above thought, I ran another experiment and results
are shown below:

Injecting additional delay on one path for larger packets (>=32k)
and mixing I/Os with bssplit => 16k/75:64k/25. So with this
test, we have,
Path A: good for ≤16k, bad for ≥32k
Path B: good for all  

         per-CPU   per-CPU-IO-buckets       per-NUMA   per-NUMA-IO-buckets
         (MiB/s)         (MiB/s)             (MiB/s)        (MiB/s)
         -------   -------------------      --------   -------------------
READ:    550          622                   523         615
WRITE:   726          829                   747         834
RW:      R:324        R:381                 R: 306     R:375
         W:323        W:381                 W: 306     W:374

So yes I/O buckets could be useful for the scenario tested 
above. And regarding per-CPU vs per-NUMA weight calculation
do you agree per-CPU should be good enough for this policy
as we saw above per-NUMA doesn't help improve much performance?


> Lets also test what happens with multiple clients against the same subsystem.
Yes this is a good test to run, I will test and post result.

Thanks,
--Nilay

