Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C23DCCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 16:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q7/bR8TLt4VYF2Ma3vNw8KvcQcbfgvfLzmBNooKdWMw=; b=O+yia8VB/3g7Ue/o21UgUym1xe
	f7ytjtupfNdWkgyIVwgKGi9Pmx9EaJ9cVjAT4I2VkIoZ93oGb7BRPI51A5gS7a3Bf8Jpspulc7SSW
	LXwcHpNsznbfMoLhjZ1r2lEzluNc3qea0tuA7pja13/KbBB8vyng1t4B5N9EBMpTxy8c4T6A59hro
	S+LG7RR1v3Ve+UohwQMWTfWUEcojxDLuNG6Lohk1rfBJU5cxiqQ21LUtetKOLaRy11oPSErq3TxCr
	M4p+DgBeoJD9Qq3PhJx4a0xD1LdFfeuoy8CoJNd5w7xHBPRoPCANgswv9Yt+af599WYXpqdzZ2RJX
	L9EZE9aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGKLt-0000000CEax-431c;
	Tue, 04 Nov 2025 16:57:49 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGKLp-0000000CEZV-33Lj
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 16:57:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762275459; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Q7/bR8TLt4VYF2Ma3vNw8KvcQcbfgvfLzmBNooKdWMw=;
	b=uAZfapgQCPHPX1bwz49F5GHjAClvfn6tD4nOjMC457A1LzV0QPveYq3QLIhGJHtQ+JvI9UQvINRTevkZqMQpf2xdPQoO433Y3+4KwhMXRGJKMByZDiH6Yllh8fcysGJ75UJkW243WC4WNlayLHUxOfQqdT3FPmGueDFiluVO1yI=
Received: from 30.50.185.93(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0Wrhz5Ed_1762275455 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Nov 2025 00:57:36 +0800
Message-ID: <96f9d51d-7cde-404b-a2a4-0c1b97d07be6@linux.alibaba.com>
Date: Wed, 5 Nov 2025 00:57:35 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [RFC PATCHv4 0/6] nvme-multipath: introduce adaptive I/O policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
 dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
References: <20251104104533.138481-1-nilay@linux.ibm.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20251104104533.138481-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_085746_409137_C767E245 
X-CRM114-Status: GOOD (  23.28  )
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

Hi Nilay:

Could you plz update Documentation/admin-guide/nvme-multipath.rst too?

Best Regards,

Guixin Liu

在 2025/11/4 18:45, Nilay Shroff 写道:
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
>          numa         round-robin   queue-depth  adaptive
>          -----------  -----------   -----------  ---------
> READ:   50.0 MiB/s   105 MiB/s     230 MiB/s    350 MiB/s
> WRITE:  65.9 MiB/s   125 MiB/s     385 MiB/s    446 MiB/s
> RW:     R:30.6 MiB/s R:56.5 MiB/s  R:122 MiB/s  R:175 MiB/s
>          W:30.7 MiB/s W:56.5 MiB/s  W:122 MiB/s  W:175 MiB/s
>
> This pathcset includes totla 6 patches:
> [PATCH 1/6] block: expose blk_stat_{enable,disable}_accounting()
>    - Make blk_stat APIs available to block drivers.
>    - Needed for per-path latency measurement in adaptive policy.
>
> [PATCH 2/6] nvme-multipath: add adaptive I/O policy
>    - Implement path scoring based on latency (EWMA).
>    - Distribute I/O proportionally to per-path weights.
>
> [PATCH 3/6] nvme: add generic debugfs support
>    - Introduce generic debugfs support for NVMe module
>
> [PATCH 4/6] nvme-multipath: add debugfs attribute adaptive_ewma_shift
>    - Adds a debugfs attribute to control ewma shift
>
> [PATCH 5/6] nvme-multipath: add debugfs attribute adaptive_weight_timeout
>    - Adds a debugfs attribute to control path weight calculation timeout
>
> [PATCH 6/6] nvme-multipath: add debugfs attribute adaptive_stat
>    - Add “adaptive_stat” under per-path and head debugfs directories to
>      expose adaptive policy state and statistics.
>
> As ususal, feedback and suggestions are most welcome!
>
> Thanks!
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
> Nilay Shroff (6):
>    block: expose blk_stat_{enable,disable}_accounting() to drivers
>    nvme-multipath: add support for adaptive I/O policy
>    nvme: add generic debugfs support
>    nvme-multipath: add debugfs attribute adaptive_ewma_shift
>    nvme-multipath: add debugfs attribute adaptive_weight_timeout
>    nvme-multipath: add debugfs attribute adaptive_stat
>
>   block/blk-stat.h              |   4 -
>   drivers/nvme/host/Makefile    |   2 +-
>   drivers/nvme/host/core.c      |  22 +-
>   drivers/nvme/host/debugfs.c   | 335 ++++++++++++++++++++++++++
>   drivers/nvme/host/ioctl.c     |  31 ++-
>   drivers/nvme/host/multipath.c | 430 +++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/nvme.h      |  87 ++++++-
>   drivers/nvme/host/pr.c        |   6 +-
>   drivers/nvme/host/sysfs.c     |   2 +-
>   include/linux/blk-mq.h        |   4 +
>   10 files changed, 895 insertions(+), 28 deletions(-)
>   create mode 100644 drivers/nvme/host/debugfs.c
>


