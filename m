Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3165FF885E
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 12:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H/EKmEnTazlJTOor9DAb3susdu/D3/dZvumSVZnddi8=; b=1hz6wMcEplcidM6bKuUInKds+c
	LWsB3bMuGWDoygKTO7bQVBKIaF+Xk96lijRlchkpWo9Q15ocAfjFi8Mu033RxUYe4OwCdNR5447tR
	/mfXdDwMs8/onTpqwsBn4st39reeD0/9QnhO15KF+vgglC8tkzEF2zmm8R1iFRQiKXLA4BpS0TCE4
	xpkheF3Ll6dOMtebovvCUJ7bhQBIjVrD3zwyMRwmfPK/wBAvM4Zd5EWR4udZtBeUsgAK6gz9S+4NG
	DW6x2z0+nhq5gsT6oPNT2v/zi4LGfU7AOW4BQzFmGAAac3qASkaxdaLGlcJo/MOkmx57xE7F6TbvC
	UWTWrDqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHKoQ-0000000GrR9-2lyw;
	Mon, 27 Apr 2026 12:11:42 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHKoO-0000000GrQp-0gbL
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 12:11:41 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R7HBHE1317126;
	Mon, 27 Apr 2026 12:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H/EKmE
	nTazlJTOor9DAb3susdu/D3/dZvumSVZnddi8=; b=YanDmcHFkwVFC/9WmmVV8r
	5vD+L7PAcrFKoSfSs4Px/4EYJE3NsovLDJZHQ4uo1FBXeNhrcP0036akdy2LoX6s
	QnT30oHNEVj1vMiPHjIZxcPgCFKgCFNVONbmSlNWZBfkzClbCeTd9ULiMtLpax25
	4AscS4GiXPcJNiCU1qEazNi4tcbNI8kMzZ7u2kL08xobIclBR86Yb2xezdSXCQW5
	vS2HBU/rNCgQw09zkypiepYG4f7mi1uJuRLyke19wYUopsPd7iqkm9QTZpMqq7AJ
	+NNtFcxsrmGl/vmiFF+ip0BSQePKZw8akSlVBjggT2U2aerq0FMuS6sSoYaV5BxQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jfpg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 12:11:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RC8iIE024193;
	Mon, 27 Apr 2026 12:11:29 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xq561m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 12:11:28 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63RCBSNd21234382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 12:11:28 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E16558059;
	Mon, 27 Apr 2026 12:11:28 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23AB758061;
	Mon, 27 Apr 2026 12:11:26 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 12:11:25 +0000 (GMT)
Message-ID: <73e02cad-22e3-44a5-a90e-fc7660daae73@linux.ibm.com>
Date: Mon, 27 Apr 2026 17:41:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] nvme-tcp: NIC topology aware I/O queue scaling
 and queue info export
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, chaitanyak@nvidia.com, gjoyce@linux.ibm.com
References: <20260420115716.3071293-1-nilay@linux.ibm.com>
 <649036dd-b99f-4f60-93f4-16979e11f520@suse.de>
 <faeb48dc-5672-465b-9650-558522dc4f65@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <faeb48dc-5672-465b-9650-558522dc4f65@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyNSBTYWx0ZWRfXylBvEyagcIPT
 S+qdAs4SgcyBAkM5a/YyXfgVOJJIDKq9EaL7jfbsV1+/v5qyipgj+HGZjd2qSlvXc41ikiqND5o
 d/clm/4519sGp02hSIFo/gqnZVfT0RSnFDWLCJWW7BHhMRqBf7XEyi7j9jJe/CUp7nPK7EIcedk
 1Wn+goWhBypVawiBsv5UQbgGA0cjEIVmiPhJo1NiXD3aA5NmPvEFyYZxbHRrv4qh1QfTx1kxdGX
 JT9sqkQjwZIEma4oN2VmNbojNotO3J2EVYkyDiV3O5f+lvIPo8yqgAJfRsnjB6L+EPqdNp78fqw
 OuO/eToc/RR92kN4zHA/sQTu5l7n8dmkbEYjqXLm3v1kTFmJ7Syc88R7w3FF2iDYiLt3NYB+qFf
 +++9W93CeIIdE/Cvs7dvpgxbyS0aDzPV2T7uk03BTIOO6mYV9BN5qxM45g4A+JJ7w/gXHNHLjjz
 0Xkp4yPZ78h52oExwVw==
X-Proofpoint-GUID: 0NjsQ6aNM9K2H-ZupitgVSUAshcTcpsM
X-Proofpoint-ORIG-GUID: 0NjsQ6aNM9K2H-ZupitgVSUAshcTcpsM
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69ef5271 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=H3GjO7N-Ywwhl7QugdoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_051140_377712_42E5C26B 
X-CRM114-Status: GOOD (  23.30  )
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

On 4/25/26 4:00 AM, Sagi Grimberg wrote:
> 
> 
> On 22/04/2026 14:10, Hannes Reinecke wrote:
>> On 4/20/26 13:49, Nilay Shroff wrote:
>>> Hi,
>>>
>>> The NVMe/TCP host driver currently provisions I/O queues primarily based
>>> on CPU availability rather than the capabilities and topology of the
>>> underlying network interface.
>>>
>>> On modern systems with many CPUs but fewer NIC hardware queues, this can
>>> lead to multiple NVMe/TCP I/O workers contending for the same TX/RX queue,
>>> resulting in increased lock contention, cacheline bouncing, and degraded
>>> throughput.
>>>
>>> This RFC proposes a set of changes to better align NVMe/TCP I/O queues
>>> with NIC queue resources, and to expose queue/flow information to enable
>>> more effective system-level tuning.
>>>
>>> Key ideas
>>> ---------
>>>
>>> 1. Scale NVMe/TCP I/O queues based on NIC queue count
>>>     Instead of relying solely on CPU count, limit the number of I/O workers
>>>     to:
>>>         min(num_online_cpus, netdev->real_num_{tx,rx}_queues)
>>>
>>> 2. Improve CPU locality
>>>     Align NVMe/TCP I/O workers with CPUs associated with NIC IRQ affinity
>>>     to reduce cross-CPU traffic and improve cache locality.
>>>
>>> 3. Expose queue and flow information via debugfs
>>>     Export per-I/O queue information including:
>>>         - queue id (qid)
>>>         - CPU affinity
>>>         - TCP flow (src/dst IP and ports)
>>>
>>>     This enables userspace tools to configure:
>>>         - IRQ affinity
>>>         - RPS/XPS
>>>         - ntuple steering
>>>         - or any other scaling as deemed feasible
>>>
>>> 4. Provide infrastructure for extensible debugfs support in NVMe
>>>
>>> Together, these changes allow better alignment of:
>>>      flow -> NIC queue -> IRQ -> CPU -> NVMe/TCP I/O worker
>>>
>>> Performance Evaluation
>>> ----------------------
>>> Tests were conducted using fio over NVMe/TCP with the following parameters:
>>>      ioengine=io_uring
>>>      direct=1
>>>      bs=4k
>>>      numjobs=<#nic-queues>
>>>      iodepth=64
>>> System:
>>>      CPUs: 72
>>>      NIC: 100G mlx5
>>>
>>> Two configurations were evaluated.
>>>
>>> Scenario 1: NIC queues < CPU count
>>> ----------------------------------
>>> - CPUs: 72
>>> - NIC queues: 32
>>>
>>>                  Baseline        Patched        Patched + tuning
>>> randread        3141 MB/s       3228 MB/s      7509 MB/s
>>>                  (767k IOPS)     (788k IOPS)    (1833k IOPS)
>>>
>>> randwrite       4510 MB/s       6172 MB/s      7518 MB/s
>>>                  (1101k IOPS)    (1507k IOPS)   (1836k IOPS)
>>>
>>> randrw (read)   2156 MB/s       2560 MB/s      3932 MB/s
>>>                  (526k IOPS)     (625k IOPS)    (960k IOPS)
>>>
>>> randrw (write)  2155 MB/s       2560 MB/s      3932 MB/s
>>>                  (526k IOPS)     (625k IOPS)    (960k IOPS)
>>>
>>> Observation:
>>> When CPU count exceeds NIC queue count, the baseline configuration
>>> suffers from queue contention. The proposed changes provide modest
>>> improvements on their own, and when combined with queue-aware tuning
>>> (IRQ affinity, ntuple steering, and CPU alignment), enable up to
>>> ~1.5x–2.5x throughput improvement.
>>>
>>> Scenario 2: NIC queues == CPU count
>>> -----------------------------------
>>>
>>> - CPUs: 72
>>> - NIC queues: 72
>>>
>>>                  Baseline                Patched + tuning
>>> randread        4310 MB/s               7987 MB/s
>>>                  (1052k IOPS)            (1950k IOPS)
>>>
>>> randwrite       7947 MB/s               7972 MB/s
>>>                  (1940k IOPS)            (1946k IOPS)
>>>
>>> randrw (read)   3583 MB/s               4030 MB/s
>>>                  (875k IOPS)             (984k IOPS)
>>>
>>> randrw (write)  3583 MB/s               4029 MB/s
>>>                  (875k IOPS)             (984k IOPS)
>>>
>>> Observation:
>>> When NIC queues are already aligned with CPU count, the baseline performs
>>> well. The proposed changes maintain write performance (no regression) and
>>> still improve read and mixed workloads due to better flow-to-CPU locality.
>>>
>>> Notes on tuning
>>> ---------------
>>> The "patched + tuning" configuration includes:
>>>      - aligning NVMe/TCP I/O workers with NIC queue count
>>>      - IRQ affinity configuration per RX queue
>>>      - ntuple-based flow steering
>>>      - CPU/queue affinity alignment
>>>
>>> These tuning steps are enabled by the queue/flow information exposed through
>>> this patchset.
>>>
>>> Discussion
>>> ----------
>>> This RFC aims to start discussion around:
>>>    - Whether NVMe/TCP queue scaling should consider NIC queue topology
>>>    - How best to expose queue/flow information to userspace
>>>    - The role of userspace vs kernel in steering decisions
>>>
>>> As usual, feedback/comment/suggestions are most welcome!
>>>
>>> Reference to LSF/MM/BPF abstarct: https://lore.kernel.org/all/5db8ce78-0dfa-4dcb-bf71-5fb9c8f463e5@linux.ibm.com/
>>>
>>
>> Weelll ... we have been debating this back and forth over recent years:
>> Should we check for hardware limitations for NVMe-over-Fabrics or not?
>>
>> Initially it sounds appealing, and in fact I've worked on several attempts myself. But in the end there are far more things which need
>> to be considered:
>> -> For networking, number of queues is not really telling us anything.
>>    Most NICs have distinct RX and TX queues, and the number (of both!)
>>    varies quite dramatically.
>> -> The number of queues does _not_ indicate that all queues are used
>>    simultaneously. That is down to things like RSS and friends.
>>    I gave a stab at configuring _that_ but it's patently horrible
>>    trying to out-guess things for yourself.
>> -> It'll only work if you run directly on the NIC. As soon as there
>>    is anything in between (qemu? Tunnelling?) you are out of luck.
>>
>> So yeah, we should have a discussion here.
> 
> TBH, I don't think that this is very useful. I mentioned some areas on why on patch #1
> 
> But the main reason is that I think that the majority the gains that you are showing
> is the tuning - which is somewhat unrelated to the driver, and TBH, I doubt anyone
> will actually do in reality.

Even without additional tuning, aligning the NVMe/TCP I/O workers with
CPU and NIC queue locality already provides measurable performance
benefits (primarily visible in random write workloads, as shown in
Scenario 1).

The additional gains come from system-level tuning (e.g., XPS/RPS/RSS),
which further improves utilization of NIC queues and CPU locality.
However, the patch enables this tuning by exposing queue/flow
information and establishing better default alignment.

While such tuning may not be applied in all deployments, IMO, it should be
commonly used in performance-sensitive environments where users aim to
fully utilize available NIC and CPU resources.

Thanks,
--Nilay


