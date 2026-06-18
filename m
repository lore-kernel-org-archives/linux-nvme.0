Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5BACD98ED
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2026 11:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hSORGiTOOxRHGmS8bVIfjpD3EhevWFzlsonJ+Yc1aDM=; b=2hHLqP+AIe9BA9bBCIbS2kM2va
	2asmAE9sUnz9IKArgDo/mrPeingidQdA5F6b95FoWhcfxiqYdYXNeF6rHv537RxdpRO+1tzBE+ayP
	hvnCOSMsqEurVmXFAqbxx1aaPS+dAmdGS0Dbk+/WUW5qr05XgXGHu4iSOV0hYPcrG1emUdWDV1hCO
	ul0HU9Xah0+XbKGn8UsapshKtYotBi4Nlmi3bpFQNqXWHD1rVB0ckmbkhh3tUK3E8YeFqEsDhde8y
	H3Qp1UrnQkXP4sOu6rtyQwoGTcTWpwtVewmNplHTepdgK5sUhoXEd/fzIc16/4+NUXzfUk8ArlHHJ
	SFSf8qYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waApf-00000001CAx-3BhZ;
	Thu, 18 Jun 2026 11:22:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waApc-00000001CA4-24xv
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jun 2026 11:22:50 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IBIDfb3262752;
	Thu, 18 Jun 2026 11:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hSORGi
	TOOxRHGmS8bVIfjpD3EhevWFzlsonJ+Yc1aDM=; b=ksQzpgym8n6a0ehG9pBb3d
	+emFngupinQ0YN4waAcD5FLriy6ZrYbyiK1wEv0JVhXMDpoHudPQTCbam9bV0lFc
	D2VvDVUqqPzLkF7snJiRt4UMZbUW1kCzAcNBQtgWAx+K4TsxraiqX+erf3Ljpkg/
	Q7eqKmEYytv6i/ev88gM7C5mRsLR8AMdAo20b8Jqp0YAypA4acH91I9amEoC7s4X
	qCRLufl3dqhyrhqip6qu2d46R4UDlXy3tZivjIrnrbiuHy1I50IS2ZZ9z+S79+W0
	jP4O/aOo2JpVpPkg5ov0tbwc8OPOoPuH2S+MVvszCWLozCRIwbfx3raoFCkA9LoA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqvyscv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 11:22:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65IBJbRv012992;
	Thu, 18 Jun 2026 11:22:33 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1723e4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 11:22:33 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65IBMW6g6554214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 11:22:33 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A314D58059;
	Thu, 18 Jun 2026 11:22:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 524F85805D;
	Thu, 18 Jun 2026 11:22:28 +0000 (GMT)
Received: from [9.43.68.239] (unknown [9.43.68.239])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 11:22:27 +0000 (GMT)
Message-ID: <173b390e-8590-436c-8ff3-bb9d728b5e24@linux.ibm.com>
Date: Thu, 18 Jun 2026 16:52:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 0/8] nvme-multipath: introduce latency I/O policy
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
References: <20260520182112.863076-1-nilay@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260520182112.863076-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEwNSBTYWx0ZWRfX2EIIF3hl2DeP
 d5RxS+UMO3fzqX7wiApl0av92juvudVfpUdyAcQA0W3eplxpmvxM68Rckwd70p9GZtdgnaYHA9J
 ZbQy2H0q3ZeGmF9yFtbwkzTgo5KZRZw=
X-Proofpoint-GUID: sflmUD9BHAWhsJieqVDhSbWckzsjae9G
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a33d4fb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=akZNE8Rn9XHrCqbLDeIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cwuWTYQcFC3QWhxluBGMdXg8GMbHgr87
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEwNSBTYWx0ZWRfXxdkN/5QjokGK
 2CT7NKqWL1dAMsKij+BEeT7D4gkvLMuLGf+K/hD9/Tk37nvjUpJ1lBLLlpLimnelolhVkW1Xphn
 uRI/5Yfzw5LIqcLR8DJMk2OubHLumZMOtpvtlYEz5ELBwbK6bWsd780VzvVV8vIGquX+tBjjaFK
 IDPXlxfNvbX9wgKC9qYiF7fYDbjdZpj3GckYFnF0xke7D2Ib19zkqdkRmFaW3FRoooxOKKeSHL1
 qgHPRHRqGrdOFJ8MDnpxQvH7oNCOP7/WXQY8mfld6NzJQULFEbYpE2L6nRpXwB/TWBGW38D+Q0B
 iLikNS4fxim6mk7Mkxah5D0XvgAcgjPUuLggCRbyQ3euxXVco3q5cUvLYBrNSqI5+QlV8Za5n7k
 vd5JDGojKmCfJ/I+1RhHWyBpEluHKGX4cIu3eXL3jhY9QhvGc4mKaNBjkAHNK70qGGiqK/AWkhm
 ug8mW+LqeJE4ckj60HA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260618_042248_551673_FE6AD4EC 
X-CRM114-Status: GOOD (  40.87  )
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

A gentle ping on this series.
Would you please consider pulling it for the current merge window?
In the latest revision, I've addressed all review comments and updated
the series based on the feedback and discussions during LSFMM. If there
are any remaining concerns or if you'd like to see further changes,
please let me know and I'll be happy to address them.

Thanks,
--Nilay

On 5/20/26 11:50 PM, Nilay Shroff wrote:
> Hi,
> 
> This series introduces a new latency I/O policy for NVMe native
> multipath. Existing policies such as numa, round-robin, and queue-depth
> are static and do not adapt to real-time transport performance. The numa
> selects the path closest to the NUMA node of the current CPU, optimizing
> memory and path locality, but ignores actual path performance. The
> round-robin distributes I/O evenly across all paths, providing fairness
> but not performance awareness. The queue-depth reacts to instantaneous
> queue occupancy, avoiding heavily loaded paths, but does not account for
> actual latency, throughput, or link speed.
> 
> The new latency policy addresses these gaps selecting paths dynamically
> based on measured I/O latency for both PCIe and fabrics. Latency is
> derived by passively sampling I/O completions. Each path is assigned a
> weight proportional to its latency score, and I/Os are then forwarded
> accordingly. As condition changes (e.g. latency spikes, bandwidth
> differences), path weights are updated, automatically steering traffic
> toward better-performing paths.
> 
> Early results show reduced tail latency under mixed workloads and
> improved throughput by exploiting higher-speed links more effectively.
> For example, with NVMf/TCP using two paths (one throttled with ~30 ms
> delay), fio results with random read/write/rw workloads (direct I/O)
> showed:
> 
>          numa         round-robin   queue-depth  adaptive
>          -----------  -----------   -----------  ---------
> READ:   50.0 MiB/s   105 MiB/s     230 MiB/s    350 MiB/s
> WRITE:  65.9 MiB/s   125 MiB/s     385 MiB/s    446 MiB/s
> RW:     R:30.6 MiB/s R:56.5 MiB/s  R:122 MiB/s  R:175 MiB/s
>          W:30.7 MiB/s W:56.5 MiB/s  W:122 MiB/s  W:175 MiB/s
> 
> This pathcset includes totla 8 patches:
> [PATCH 1/8] block: expose blk_stat_{enable,disable}_accounting()
>    - Make blk_stat APIs available to block drivers.
>    - Needed for per-path latency measurement.
> 
> [PATCH 2/8] nvme-multipath: pass I/O type to nvme_find_path()
>    - This is the prep patch which updates nvme_find_path() signature
>      
> [PATCH 3/8] nvme-multipath: add latency I/O policy
>    - Implement path scoring based on latency (EWMA).
>    - Distribute I/O proportionally to per-path weights.
> 
> [PATCH 4/8] nvme: add generic debugfs support
>    - Introduce generic debugfs support for NVMe module
> 
> [PATCH 5/8] nvme-multipath: add debugfs attribute latency_ewma_shift
>    - Adds a debugfs attribute to control ewma shift
> 
> [PATCH 6/8] nvme-multipath: add debugfs attribute latency_batch_timeout
>    - Adds a debugfs attribute to control latency batch window interval
> 
> [PATCH 7/8] nvme-multipath: add debugfs attribute latency_stat
>    - Add “latency_stat” under per-path and head debugfs directories to
>      expose latency policy state and statistics.
> 
> [PATCH 8/8] nvme-multipath: add documentation for latency I/O policy
>    - Includes documentation for latency I/O multipath policy.
> 
> LSFMM discussion:
> =================
> During lsfmm 2026, it was decided to rename this I/O policy from
> "adaptive" to "latency". This series reflects that rename.
> 
> The discussion at lsfmm also focused extensively on the latency
> measurement model, including whether latency should be tracked
> per-CPU or per-NUMA, and whether separate I/O-size buckets should
> be maintained for different request sizes.
> 
> After detailed discussion and evaluation of throughput results, the
> consensus was to initially measure I/O completion latency on a
> per-CPU basis. The available performance data showed that the
> per-CPU implementation already provides sufficient averaging across
> CPUs while keeping the design relatively simple.
> 
> The use of additional I/O-size buckets did not demonstrate meaningful
> throughput improvement in the general case and would introduce extra
> complexity into the fast path and accounting logic. As a result, the
> consensus was to avoid I/O-size bucketing for now and keep the policy
> focused on per-CPU latency measurement.
> 
> If future real-world workloads demonstrate a clear benefit from
> I/O-size-aware latency accounting, the policy can be extended later
> to support it.
> 
> As ususal, feedback and suggestions are most welcome!
> 
> Thanks!
> 
> Changes from v5:
>    - Rename the policy from "adaptive" to "latency". The entire series
>      updates policy names, function names, and variable names accordingly,
>      without introducing any functional changes. (lsfmm discussion)
>    - The second patch is now splitted into two patches:
>      Patch #2: prep patch where we pass op_type to nvme_find_path()
>      Patch #3: core patch which introduces latency I/O policy
>      (Sagi)
>    - Rename ewma_update() to calc_ewma_update() (Sagi)
> Link to v5: https://lore.kernel.org/all/20251105103347.86059-1-nilay@linux.ibm.com/
> 
> Changes from v4:
>    - Added patch #7 which includes the documentation for adaptive I/O
>      policy. (Guixin Liu)
> Link to v4: https://lore.kernel.org/all/20251104104533.138481-1-nilay@linux.ibm.com/
> 
> Changes from v3:
>    - Update the adaptive APIs name (which actually enable/disable
>      adaptive policy) to reflect the actual work it does. Also removed
>      the misleading use of "current_path" from the adaptive policy code
>      (Hannes Reinecke)
>    - Move adaptive_ewma_shift and adaptive_weight_timeout attributes from
>      sysfs to debugfs (Hannes Reinecke)
> Link to v3: https://lore.kernel.org/all/20251027092949.961287-1-nilay@linux.ibm.com/
> 
> Changes from v2:
>    - Addede a new patch to allow user to configure EWMA shift
>      through sysfs (Hannes Reinecke)
>    - Added a new patch to allow user to configure path weight
>      calculation timeout (Hannes Reinecke)
>    - Distinguish between read/write and other commands (e.g.
>      admin comamnd) and calculate path weight for other commands
>      which is separate from read/write weight. (Hannes Reinecke)
>    - Normalize per-path weight in the range from 0-128 instead
>      of 0-100 (Hannes Reinecke)
>    - Restructure and optimize adaptive I/O forwarding code to use
>      one loop instead of two (Hannes Reinecke)
> Link to v2: https://lore.kernel.org/all/20251009100608.1699550-1-nilay@linux.ibm.com/
> 
> Changes from v1:
>    - Ensure that the completion of I/O occurs on the same CPU as the
>      submitting I/O CPU (Hannes Reinecke)
>    - Remove adapter link speed from the path weight calculation
>      (Hannes Reinecke)
>    - Add adaptive I/O stat under debugfs instead of current sysfs
>      (Hannes Reinecke)
>    - Move path weight calculation to a workqueue from IO completion
>      code path
> Link to v1: https://lore.kernel.org/all/20250921111234.863853-1-nilay@linux.ibm.com/
> 
> Nilay Shroff (8):
>    block: expose blk_stat_{enable,disable}_accounting() to drivers
>    nvme-multipath: pass I/O type to nvme_find_path()
>    nvme-multipath: add support for latency I/O policy
>    nvme: add generic debugfs support
>    nvme-multipath: add debugfs attribute latency_ewma_shift
>    nvme-multipath: add debugfs attribute latency_batch_timeout
>    nvme-multipath: add debugfs attribute latency_stat
>    nvme-multipath: add documentation for latency I/O policy
> 
>   Documentation/admin-guide/nvme-multipath.rst |  19 +
>   block/blk-stat.h                             |   4 -
>   drivers/nvme/host/Makefile                   |   2 +-
>   drivers/nvme/host/core.c                     |  21 +-
>   drivers/nvme/host/debugfs.c                  | 345 ++++++++++++++
>   drivers/nvme/host/ioctl.c                    |  38 +-
>   drivers/nvme/host/multipath.c                | 446 ++++++++++++++++++-
>   drivers/nvme/host/nvme.h                     |  84 +++-
>   drivers/nvme/host/pr.c                       |   6 +-
>   drivers/nvme/host/sysfs.c                    |   2 +-
>   include/linux/blk-mq.h                       |   4 +
>   11 files changed, 941 insertions(+), 30 deletions(-)
>   create mode 100644 drivers/nvme/host/debugfs.c
> 


