Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4808C5B572
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2026 05:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mUZBpAHPWXAOlSRkxbZPw+INDZ90M6woE7y1PrqT8E8=; b=oY+e2YwSjO3h0rG/cck14lpDhE
	pPrWVX67Lzrz3WBl4UinZ+QBCxYDz87ssztlvDAtFEdEoNNlIUDXBearoghKc2kp+6dA8y/V3IKjE
	EXJXXGa7SHHBlvO4gM5orKCl6aE/nrMbsXomfzoaShrGLbQBp2jljqRAbTSUddMOK3aRrxLV3zZTM
	xD4AP/9ShAQ65rLyM8emaujjncQcjKi5q8lza2TMvGSG111DzezDiWC0ZUWBzCJZkf5Q59izKON0U
	m66uJ8okuGiWOm4AV2QKqSARM68yX3qdy1gw9xNfBpzTWbziFi61Urwo3+pt/+u5flAC6xJkByrSg
	CxU+fjFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyjLp-000000009iB-2HG7;
	Tue, 25 Aug 2026 05:05:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyjLm-000000009hq-2bak
	for linux-nvme@lists.infradead.org;
	Tue, 25 Aug 2026 05:05:31 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P2W0sJ2619546;
	Tue, 25 Aug 2026 05:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mUZBpA
	HPWXAOlSRkxbZPw+INDZ90M6woE7y1PrqT8E8=; b=dR2Lgjx3VOofTHE+ENYtAJ
	Q1V71cabGIaDTcaDsum8lDw49ZFtU5t3WYWF8n4fOU89A6uGq0/L6+6+ZeVpq1rc
	RIKHZUMVwYTuOh5U/ksBjY3tUsMbANs1DS2ytK4Dh5/sV0hLsJO+pXHnt//zy0bi
	dVh/YJCu1AQsW8kdBXFkQB3+ElXvMPMHKbLW9vVYqxF/F6/U3THCl891bMR7lnZQ
	XovcJvVFFVSGO9Kb0HNe1QEDjlmDR1FBwbOxr1+/pmxEM4m5HFxghx+MqXtAZUOp
	ocvu+nQ7v8GwEfJvbt6t2o1MnV6c2CcQS/kG6Lf7DDfbOWEXlTpqHtMcGn+fpFIg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726edy7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 05:05:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67P4uPkn019711;
	Tue, 25 Aug 2026 05:05:14 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy2195-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 05:05:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67P55EPH30671386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 05:05:14 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6487458052;
	Tue, 25 Aug 2026 05:05:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 443FF5805D;
	Tue, 25 Aug 2026 05:05:11 +0000 (GMT)
Received: from [9.61.86.249] (unknown [9.61.86.249])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 05:05:10 +0000 (GMT)
Message-ID: <8ecbc5aa-0a5d-4780-9c34-bf433f5e6221@linux.ibm.com>
Date: Tue, 25 Aug 2026 10:35:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] nvme-multipath: introduce latency I/O policy
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, dwagner@suse.de,
        kanie@linux.alibaba.com, jmeneghi@redhat.com, randyj@purestorage.com,
        martin.petersen@oracle.com, john.g.garry@oracle.com,
        gjoyce@linux.ibm.com
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
 <f0215fbb-0e96-48de-8c6c-dd391fcf1d56@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <f0215fbb-0e96-48de-8c6c-dd391fcf1d56@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8d228c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=2tnqnTQuJm5UQC8H4VAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA0MCBTYWx0ZWRfX2HsBPx40YB2x
 Zo+EOkY80XTCgunAx5wS5nKd3yyYyAwWFxy3ed7ICKcvp8gP2QQTfcI4yzwLMJ0famSpTDGPX+S
 wanJiF2KPsCUVe19twwXYTADTjXH8Ms=
X-Proofpoint-GUID: t2PbQujz2Cx9hHpAKhAfCJSMnF0yAXio
X-Proofpoint-ORIG-GUID: _PDaKpktGMUF0FpCZmUYKTID3PVjCcC3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA0MCBTYWx0ZWRfXwGHoBF7m51xY
 lQ3E5IUJo77BI0fQx41bSLfhhZ6cNOODiz69SAsWpYjh/UsQfKzGpxhMamhQkNrEw8Xj1yq8u1o
 obQ/JZnmR68BbyB95At4fC31dFutFtFSvaWyIvA+dYis9pdJRgrmbJF9+b4J6chJljrLwKM2Wca
 wOB6r95fkRqpVgLqEJmk65sEtEZCVa8gDPPnziJ2JGCad0wJ3f7YfnoeThvHOSjNNuDOVwXgz43
 ZHpqBQ7sszsscq5YXg4VN3Do0SR7wNWyV+uNs75dT8abWZ1TIIBvZ8ndzvPhyfg0dkxaAYFrjuF
 8CbxA79nw6T/WFoquJnQWXE5KGoG0WeLuN59apaYzWWGXeoLR/wrIF9bfLyPdw/vxpRxNbHd9WI
 ocH4PqdXu7RHuQtlSrfWW/FQ+WvcJ+1DrUV48Xpi7k0CpvwE5wwhovnPl3zM2LD9XuHbRxeiYHd
 mCBvdj9gCbWWruNfgpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250040
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_220530_790083_8D3565C2 
X-CRM114-Status: GOOD (  32.84  )
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

On 8/23/26 4:17 AM, Sagi Grimberg wrote:
> 
> 
> On 15/08/2026 20:34, Nilay Shroff wrote:
>> Hi,
>>
>> This series introduces a new latency I/O policy for NVMe native
>> multipath. Existing policies such as numa, round-robin, and queue-depth
>> are static and do not adapt to real-time transport performance. The numa
>> selects the path closest to the NUMA node of the current CPU, optimizing
>> memory and path locality, but ignores actual path performance. The
>> round-robin distributes I/O evenly across all paths, providing fairness
>> but not performance awareness. The queue-depth reacts to instantaneous
>> queue occupancy, avoiding heavily loaded paths, but does not account for
>> actual latency, throughput, or link speed.
>>
>> The new latency policy addresses these gaps selecting paths dynamically
>> based on measured I/O latency for both PCIe and fabrics. Latency is
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
> 
> TBH, I do not know if this measurement represent any real-life
> scenario. I do think that occasional packet drops are a real-life scenario, and
> it would be a worthy use-case to optimize for. Can you perhaps measure
> how the path selectors compare in this case?
> 

Okay so I have now measured another workload where I simulated packet loss/drops
which are occasional and compared different path selectors. In this measurement
I have a shared NVMe namespace configured which is reachable over two tcp paths.
Now to simulate the occasional packet loss/drop I have configured one of the paths
to experience occasional packet loss/drop as shown below over the period of
480 seconds:

0            120           240           360           480
|-------------|-------------|-------------|-------------|
|<--5% drop-->|<--no drop-->|<--3% drop-->|<--no drop-->|

As shown above for the first 120 seconds the path experiences 5% packet drop,
for the next 120 seconds path sees no packet drop and again for subsequent 120
seconds path experiences 3% packet drop and for the rest of the duration (during
last 120 seconds) there's no packet drop observed by the path. With this simulation,
I ran fio workload for 480 seconds leveraging direct I/O, bs=4k, iodepth=64,
numjobs=32 and ioengine=io_uring. Shown below is bw observed running fio test
using different I/O policies:

              numa     round-robin queue-depth latency
              (MiB/s)  (MiB/s)     (MiB/s)     (MiB/s)
              -------  ----------- ----------- ---------
randread:    1288     1202        1464        1642
randwrite:   1456     1493        1779        1944
randrw:      R:623    R:594       R:750       R:822
              W:623    W:594       W:750       W:822

>>
>>          numa         round-robin   queue-depth  adaptive
>>          -----------  -----------   -----------  ---------
>> READ:   50.0 MiB/s   105 MiB/s     230 MiB/s    350 MiB/s
>> WRITE:  65.9 MiB/s   125 MiB/s     385 MiB/s    446 MiB/s
>> RW:     R:30.6 MiB/s R:56.5 MiB/s  R:122 MiB/s  R:175 MiB/s
>>          W:30.7 MiB/s W:56.5 MiB/s  W:122 MiB/s  W:175 MiB/s
> 
> And I'm assuming there are zero downsides for the normal
> case?
> 
For the normal case where all paths are symmetric I saw
queue-depth, latency and round-robin policies yielding
nearly same bandwidth. However for numa policy, it depends
on CPU/numa locality.

>>
>> This pathcset includes totla 8 patches:
>> [PATCH 1/10] block: expose blk_stat_{enable,disable}_accounting()
>>    - Make blk_stat APIs available to block drivers.
>>    - Needed for per-path latency measurement.
>>
>> [PATCH 2/10] block: record I/O request start time for passthru request
>>    - Record I/O start time for I/O passthru requests.
>>    - This is prep patch which allows measuring I/O completion latency
>>      for passthru requests.
>>
>> [PATCH 3/10] block: support nesting for blk-mq flag QUEUE_FLAG_SAME_FORCE
>>    - Support nesting for QUEUE_FLAG_SAME_FORCE as multiple users
>>      could toggle QUEUE_FLAG_SAME_FORCE.
>>
>> [PATCH 4/10] nvme-multipath: pass I/O type to nvme_find_path()
>>    - This is the prep patch which updates nvme_find_path() signature
>> [PATCH 5/10] nvme-multipath: add latency I/O policy
>>    - Implement path scoring based on latency (EWMA).
>>    - Distribute I/O proportionally to per-path weights.
>>
>> [PATCH 6/10] nvme: add generic debugfs support
>>    - Introduce generic debugfs support for NVMe module
>>
>> [PATCH 7/10] nvme-multipath: add debugfs attribute latency_ewma_shift
>>    - Adds a debugfs attribute to control ewma shift
>>
>> [PATCH 8/10] nvme-multipath: add debugfs attribute latency_batch_timeout
>>    - Adds a debugfs attribute to control latency batch window interval
>>
>> [PATCH 9/10] nvme-multipath: add debugfs attribute latency_stat
>>    - Add “latency_stat” under per-path and head debugfs directories to
>>      expose latency policy state and statistics.
>>
>> [PATCH 10/10] nvme-multipath: add documentation for latency I/O policy
>>    - Includes documentation for latency I/O multipath policy.
>>
>> LSFMM discussion:
>> =================
>> During lsfmm 2026, it was decided to rename this I/O policy from
>> "adaptive" to "latency". This series reflects that rename.
>>
>> The discussion at lsfmm also focused extensively on the latency
>> measurement model, including whether latency should be tracked
>> per-CPU or per-NUMA, and whether separate I/O-size buckets should
>> be maintained for different request sizes.
>>
>> After detailed discussion and evaluation of throughput results, the
>> consensus was to initially measure I/O completion latency on a
>> per-CPU basis. The available performance data showed that the
>> per-CPU implementation already provides sufficient averaging across
>> CPUs while keeping the design relatively simple.
>>
>> The use of additional I/O-size buckets did not demonstrate meaningful
>> throughput improvement in the general case and would introduce extra
>> complexity into the fast path and accounting logic. As a result, the
>> consensus was to avoid I/O-size bucketing for now and keep the policy
>> focused on per-CPU latency measurement.
>>
>> If future real-world workloads demonstrate a clear benefit from
>> I/O-size-aware latency accounting, the policy can be extended later
>> to support it.
>>
>> As ususal, feedback and suggestions are most welcome!
> 
> Nilay, do we have evidence that round-robin/queue-depth are better
> for any workload? As a user, I would be very confused with the amount
> of path selectors I have available and which should I choose.

 From my experiments, when the paths are symmetric, both round-robin and
queue-depth (and for that matter latency) exhibit similar behavior, with
the workload being distributed roughly equally across the active paths.

When the paths are asymmetric, I found queue-depth to perform better than
round-robin. Queue-depth tries to steer I/O toward the less-loaded path
based on the number of in-flight I/Os on each path, whereas round-robin
continues to distribute I/O evenly across all active paths.

However, queue-depth still has a limitation in this scenario. It uses
the number of in-flight I/Os as an indirect indication of path
performance, it does not have a direct signal of the actual I/O
completion latency. For example, if one path starts experiencing packet
loss, I/O completion on that path can become significantly slower.
Queue-depth can react to this as the path accumulates more outstanding
I/Os, but it can still continue sending I/O to the degraded path as long
as its queue depth remains comparable to the healthy path. In other
words, it can reduce the amount of I/O sent to the degraded path, but it
cannot directly account for how much slower that path has become.

The latency policy uses I/O completion latency as the signal instead.
When one path becomes degraded, its observed latency increases and its
path score/weight decreases. Consequently, the policy shifts more I/O towards
the healthy path. This allows the healthy path to sustain a higher queue
depth while the degraded path receives substantially less I/O, rather
than trying to maintain a similar queue depth across both paths.

This is also reflected in the packet-loss experiment above. Round-robin
continues to distribute I/O across both paths, while queue-depth does a
better job by reacting to the increased queue occupancy of the degraded
path. The latency policy goes one step further by directly using the
increased completion latency as a signal and therefore steers more I/O
toward the healthy path, resulting in higher throughput.

So based on the results I have so far, I would characterize the existing
policies as follows: round-robin is useful when paths are symmetric and
equal distribution is desired. The queue-depth is preferable when paths are
asymmetric and queue occupancy provides a useful indication of path
load and the latency policy is intended for cases where path performance
can vary dynamically and we want the policy to adapt based on actual
observed latency.

Thanks,
--Nilay


