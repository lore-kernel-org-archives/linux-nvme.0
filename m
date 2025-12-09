Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B49D1CDC6
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Dec 2025 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U1AfXv/aATirOH/qP5720hqdzGMdQlGXGBrPWEP6Fvk=; b=Wy6/YIGSufgkvMId0gqOeTf9l9
	puncuqBLOZuKmblWTgiu3JUQwnu0yKcGDzP8I8SFZwOZ23CYYzB6ezbVQr81GUGiP3Au8g2wgI+l1
	MTY5lw5VJLSghCZBp4+JJkt96VpIy6HaZVDvKJMlYPa7t8c5+LFEs2vsuR8KZxCsYh/kcaAD/tQme
	5RmfRepDPbijocx4sjKEBIX7wRSSw9CoL4xeeDuWqa0hdDBAgBkR5hmaMAHJMkdQHdM5OohWYGwjd
	RfmO+7GKXr2mR3msFXxdezaGtupy/H0+LXEklN3/s60rkt/DEPlIVNuBCH4bxLtSodr+kFNYdM/Vx
	SS4vEUzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSyEZ-0000000EMLa-3g1p;
	Tue, 09 Dec 2025 13:58:31 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSyET-0000000EMLE-402E
	for linux-nvme@lists.infradead.org;
	Tue, 09 Dec 2025 13:58:27 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9BxFIp019682;
	Tue, 9 Dec 2025 13:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U1AfXv
	/aATirOH/qP5720hqdzGMdQlGXGBrPWEP6Fvk=; b=HoxjUo8K6K8/IJ9JkRyxVH
	+VD5u7Z3nnaFCwzx5/Rg3eaMSeq2ub/uAr2AkLvBYN8g0j/j9cLxpMiFMpuQ/uw5
	O9+l2tAB5UBKUWO3d4fkumSCnfXi4Dp8mhQbWYExBwnBaxsiibBEjwpIZVfFCS+i
	820XJqA8whnQ2ZNXlNrCnfRaokUKYdWcoDG3q/FTa+XBQh2me+/Q8TDpZz3H8Sll
	4uiSb87YylxqyIi9PhGN0B4uU1XRSu7KoeCxZMrowRL4STBbjNC2lM7l7qOv78DQ
	MEPueJjBwTt65Q3Jvi4XhxsFLibtJGFWiIUisy3XDCf6bEO+cTO7xMJxv2tFhAug
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0jw5qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 13:58:15 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B9Dp9o1001572;
	Tue, 9 Dec 2025 13:58:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0jw5qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 13:58:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9BS7Xa009026;
	Tue, 9 Dec 2025 13:58:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytmu5mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 13:58:14 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B9DwDti24642286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Dec 2025 13:58:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E46BF5805C;
	Tue,  9 Dec 2025 13:58:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C965858062;
	Tue,  9 Dec 2025 13:58:08 +0000 (GMT)
Received: from [9.111.21.133] (unknown [9.111.21.133])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Dec 2025 13:58:08 +0000 (GMT)
Message-ID: <11893d18-e66a-495c-b318-17dfc7338ec7@linux.ibm.com>
Date: Tue, 9 Dec 2025 19:26:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 0/7] nvme-multipath: introduce adaptive I/O policy
From: Nilay Shroff <nilay@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me, dwagner@suse.de,
        axboe@kernel.dk, kanie@linux.alibaba.com, gjoyce@ibm.com,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20251105103347.86059-1-nilay@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20251105103347.86059-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=69382af7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=vigRzzj9OlBjVkBATw8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wwHR0h69H4LV3O6T6znBcEfvYQ-C-zOt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfX95lXik9Ekr2W
 Ch1Q+eAVFlOJyf3DIxNIwm6pqw4olZ//0jYKxRr/U0wYgzLnNLMqp6TyFNRV5LVky84VQhB9w22
 l3QzJTSKI/Vx52ZPpdmVPPMYPvvRdMOocD18tLPXpsK2da/7Gdd15HE7vu6CfCbOp814qGLFXU3
 GALImPDIvZVZqUWlycRVRs+l9aizTkD9CJ1ijAQw29chmWIVOLLcF9lh1F1yIWJb6mx+UeNgLv6
 S+YYvPNcZGtmd4LLYBhZXN1XqQAC1XMQmkBA30v9+uvuO415PC3AJ69ksGv9LOTwVrLlmyyKMTH
 /z29cx94KBEGG8BeQo1PWW2IYq9jEquIi8jzMitsWbNvsAgYv1VyjtlP21qPdREauPYN1JLD64N
 Gv+5YStrN8GeE5wwLDV1mTJaC8IUOw==
X-Proofpoint-GUID: ZX2JyEvEJ82rkjTsIMl9kL3g7bJdFJzI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_04,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251209_055826_023964_5A171048 
X-CRM114-Status: GOOD (  30.66  )
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

Just gentle ping on this one...

It has been reviewed and ready for some time now, and I wanted to check if you
had any remaining feedback or concerns, or if you could consider pulling it
into nvme-next.

Link to the latest version for convenience:
https://lore.kernel.org/all/20251105103347.86059-1-nilay@linux.ibm.com/

Please let me know if there's anything further needed on my side.

Thanks,
--Nilay

On 11/5/25 4:03 PM, Nilay Shroff wrote:
> Hi,
> 
> This series introduces a new adaptive I/O policy for NVMe native
> multipath. Existing policies such as numa, round-robin, and queue-depth
> are static and do not adapt to real-time transport performance. The numa
> selects the path closest to the NUMA node of the current CPU, optimizing
> memory and path locality, but ignores actual path performance. The
> round-robin distributes I/O evenly across all paths, providing fairness
> but not performance awareness. The queue-depth reacts to instantaneous
> queue occupancy, avoiding heavily loaded paths, but does not account for
> actual latency, throughput, or link speed.
> 
> The new adaptive policy addresses these gaps selecting paths dynamically
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
>         numa         round-robin   queue-depth  adaptive
>         -----------  -----------   -----------  ---------
> READ:   50.0 MiB/s   105 MiB/s     230 MiB/s    350 MiB/s
> WRITE:  65.9 MiB/s   125 MiB/s     385 MiB/s    446 MiB/s
> RW:     R:30.6 MiB/s R:56.5 MiB/s  R:122 MiB/s  R:175 MiB/s
>         W:30.7 MiB/s W:56.5 MiB/s  W:122 MiB/s  W:175 MiB/s
> 
> This pathcset includes totla 6 patches:
> [PATCH 1/7] block: expose blk_stat_{enable,disable}_accounting()
>   - Make blk_stat APIs available to block drivers.
>   - Needed for per-path latency measurement in adaptive policy.
> 
> [PATCH 2/7] nvme-multipath: add adaptive I/O policy
>   - Implement path scoring based on latency (EWMA).
>   - Distribute I/O proportionally to per-path weights.
> 
> [PATCH 3/7] nvme: add generic debugfs support
>   - Introduce generic debugfs support for NVMe module
> 
> [PATCH 4/7] nvme-multipath: add debugfs attribute adaptive_ewma_shift
>   - Adds a debugfs attribute to control ewma shift
> 
> [PATCH 5/7] nvme-multipath: add debugfs attribute adaptive_weight_timeout
>   - Adds a debugfs attribute to control path weight calculation timeout
> 
> [PATCH 6/7] nvme-multipath: add debugfs attribute adaptive_stat
>   - Add “adaptive_stat” under per-path and head debugfs directories to
>     expose adaptive policy state and statistics.
> 
> [PATCH 7/7] nvme-multipath: add documentation for adaptive I/O policy
>   - Includes documentation for adaptive I/O multipath policy.
> 
> As ususal, feedback and suggestions are most welcome!
> 
> Thanks!
> 
> Changes from v4:
>   - Added patch #7 which includes the documentation for adaptive I/O
>     policy. (Guixin Liu)
> Link to v4: https://lore.kernel.org/all/20251104104533.138481-1-nilay@linux.ibm.com/    
> 
> Changes from v3:
>   - Update the adaptive APIs name (which actually enable/disable
>     adaptive policy) to reflect the actual work it does. Also removed
>     the misleading use of "current_path" from the adaptive policy code
>     (Hannes Reinecke)
>   - Move adaptive_ewma_shift and adaptive_weight_timeout attributes from
>     sysfs to debugfs (Hannes Reinecke)
> Link to v3: https://lore.kernel.org/all/20251027092949.961287-1-nilay@linux.ibm.com/
> 
> Changes from v2:
>   - Addede a new patch to allow user to configure EWMA shift
>     through sysfs (Hannes Reinecke)
>   - Added a new patch to allow user to configure path weight
>     calculation timeout (Hannes Reinecke)
>   - Distinguish between read/write and other commands (e.g.
>     admin comamnd) and calculate path weight for other commands
>     which is separate from read/write weight. (Hannes Reinecke)
>   - Normalize per-path weight in the range from 0-128 instead
>     of 0-100 (Hannes Reinecke)
>   - Restructure and optimize adaptive I/O forwarding code to use
>     one loop instead of two (Hannes Reinecke)
> Link to v2: https://lore.kernel.org/all/20251009100608.1699550-1-nilay@linux.ibm.com/
> 
> Changes from v1:
>   - Ensure that the completion of I/O occurs on the same CPU as the
>     submitting I/O CPU (Hannes Reinecke)
>   - Remove adapter link speed from the path weight calculation
>     (Hannes Reinecke)
>   - Add adaptive I/O stat under debugfs instead of current sysfs
>     (Hannes Reinecke)
>   - Move path weight calculation to a workqueue from IO completion
>     code path
> Link to v1: https://lore.kernel.org/all/20250921111234.863853-1-nilay@linux.ibm.com/
> 
> Nilay Shroff (7):
>   block: expose blk_stat_{enable,disable}_accounting() to drivers
>   nvme-multipath: add support for adaptive I/O policy
>   nvme: add generic debugfs support
>   nvme-multipath: add debugfs attribute adaptive_ewma_shift
>   nvme-multipath: add debugfs attribute adaptive_weight_timeout
>   nvme-multipath: add debugfs attribute adaptive_stat
>   nvme-multipath: add documentation for adaptive I/O policy
> 
>  Documentation/admin-guide/nvme-multipath.rst |  19 +
>  block/blk-stat.h                             |   4 -
>  drivers/nvme/host/Makefile                   |   2 +-
>  drivers/nvme/host/core.c                     |  22 +-
>  drivers/nvme/host/debugfs.c                  | 335 +++++++++++++++
>  drivers/nvme/host/ioctl.c                    |  31 +-
>  drivers/nvme/host/multipath.c                | 430 ++++++++++++++++++-
>  drivers/nvme/host/nvme.h                     |  86 +++-
>  drivers/nvme/host/pr.c                       |   6 +-
>  drivers/nvme/host/sysfs.c                    |   2 +-
>  include/linux/blk-mq.h                       |   4 +
>  11 files changed, 913 insertions(+), 28 deletions(-)
>  create mode 100644 drivers/nvme/host/debugfs.c
> 


