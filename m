Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB1DC5B572
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 22:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0geLBIK6bjR4EWG6ogIHlSJMy914qgd6oU1ySgRFAKc=; b=VA8R78oZmKzgkgnT5LSSDiHPji
	83+2iMKfvJQwm6yPm/ZJgd6/qIgsy4g35Zq5vOYV4IYkhQ5stG0hW3f6a03iEZEr8Yk5ssPfFLe7g
	gZKVrARM683VdCoztqnGd79knrZkcYi1HOGxQiuX2BxJla6u67Z3dx8otgWFfRZXy/8u5t+U7Mhgq
	DCMotqgyeqfsCugPo8JiukVo0Z1lbk/16rqZccMtq3Oj3nJxZKadFHVf2iSmcefEl/sDMQkNGcDms
	ZsQtP1ZoaNpWeAp329CuarQlP558QXvjDCmcV6yEcYjwszycm50dtoquMqUg2kjy6tSPxFCzO1/5H
	UMuNQ0DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxuUt-0000000Es2I-1p0u;
	Sat, 22 Aug 2026 22:47:31 +0000
Received: from mail-ed1-f42.google.com ([209.85.208.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxuUr-0000000Es1x-0l31
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 22:47:30 +0000
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so3911302a12.0
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 15:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787438847; x=1788043647;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0geLBIK6bjR4EWG6ogIHlSJMy914qgd6oU1ySgRFAKc=;
        b=MP1K4JEa1mARqACiy7ekiXsWalaP3X1cYt54ytw48F75kFoXs+7fil76Oxqu11+SBZ
         6aMgQcox9JFY2neYsRGB5+yyrcc3oT4xHD/t7XFGPHYEguo8DtcUrhPCwSK2wWIvhHmN
         wWJ+R1a+rB6xwJ92ZAwPRCWocj1JI+RY2AtU9hs8Zz+R6sn5YkkalSMtDXTXrHDuYgCB
         K9QDPbB9xEZcnj4fnHcqEXqjrF5rrJhQnYdGUjquoge6a7KQv3yVAq0kkRTBDKDXZxjl
         KyepKEiW3kazbfMcqdR9Yh9MvovZRpRZYaCqm4yYlqojNnXOzWmBd0bvP2hDLaeK8tX4
         HGHQ==
X-Forwarded-Encrypted: i=1; AHgh+Ronmg3l2+KFvAjsgMi6Kmms4W/Ps26QxeiPFrwAp+14BhtcXlovCFcv+I2lbOij29BJVRsiwANbJfH1@lists.infradead.org
X-Gm-Message-State: AFuF++nxAWLEnYuYoFk2e7hQc3kj+P1ZKwt40wZtpevIe/e0H6XIdHYR
	kv7SOsgiDblbd4jNUatrv78BZi43bNFQAobtBAZJ1Qho2wYTL33WGyt9
X-Gm-Gg: AR+sD11NCImTLuKdXeLSA22bpye9T93ZtxALiSIjDNdRg3wmB+OnNShB7pVzBJAvGft
	g6ife/YU0QYdgrLK+82aK9dl4aokBUVQggls4uE+vpIumg1dyRjc8imtFTCoJ+7PlPcpd6VIsG8
	c+kMp+Jwjb/Zql1WWbpnDLbLNV0VA9OpGhdHBkyN0rCyAh06hSHjKn+SfvaMG2Q5/bMi2ClsQnc
	lhZMDVUkeVgWf0QqKHjGgRAOXeN+x78s/aFArunWQb8ZK8MF+vcMIOUMwzBYm2zaPr2GkozcLuH
	D5v/kGoEhBxdtZytCFIllepofD662owAr33sxFX39H/QsK91dORMVTcdaPbvYVAURsNriowjK8D
	DLUhb8D2qy2fl/frUSuWlG7ri1J8szkv9S2UJlYIbxDUnS5SdRVlSbPY1UecdFzusvvuPgp4+0W
	SfGyoSWCRGO74znQBETsuWd6OJ+FUvE01q8khdfUhrKyGN9DY5UHtqtINdc3xbPKpp4qlbTcjXQ
	Ckk8KsiIFo3XLYxHAfA3Gg=
X-Received: by 2002:a17:907:890e:b0:c24:7f65:9c8a with SMTP id a640c23a62f3a-c24926a1ae2mr953367866b.12.1787438846995;
        Sat, 22 Aug 2026 15:47:26 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496297c7dsm534549666b.20.2026.08.22.15.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 15:47:26 -0700 (PDT)
Message-ID: <f0215fbb-0e96-48de-8c6c-dd391fcf1d56@grimberg.me>
Date: Sun, 23 Aug 2026 01:47:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] nvme-multipath: introduce latency I/O policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, dwagner@suse.de,
 kanie@linux.alibaba.com, jmeneghi@redhat.com, randyj@purestorage.com,
 martin.petersen@oracle.com, john.g.garry@oracle.com, gjoyce@linux.ibm.com
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260815173502.1185929-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_154729_271479_DAB6FFBE 
X-CRM114-Status: GOOD (  25.43  )
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



On 15/08/2026 20:34, Nilay Shroff wrote:
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

TBH, I do not know if this measurement represent any real-life
scenario. I do think that occasional packet drops are a real-life 
scenario, and
it would be a worthy use-case to optimize for. Can you perhaps measure
how the path selectors compare in this case?

>
>          numa         round-robin   queue-depth  adaptive
>          -----------  -----------   -----------  ---------
> READ:   50.0 MiB/s   105 MiB/s     230 MiB/s    350 MiB/s
> WRITE:  65.9 MiB/s   125 MiB/s     385 MiB/s    446 MiB/s
> RW:     R:30.6 MiB/s R:56.5 MiB/s  R:122 MiB/s  R:175 MiB/s
>          W:30.7 MiB/s W:56.5 MiB/s  W:122 MiB/s  W:175 MiB/s

And I'm assuming there are zero downsides for the normal
case?

>
> This pathcset includes totla 8 patches:
> [PATCH 1/10] block: expose blk_stat_{enable,disable}_accounting()
>    - Make blk_stat APIs available to block drivers.
>    - Needed for per-path latency measurement.
>
> [PATCH 2/10] block: record I/O request start time for passthru request
>    - Record I/O start time for I/O passthru requests.
>    - This is prep patch which allows measuring I/O completion latency
>      for passthru requests.
>
> [PATCH 3/10] block: support nesting for blk-mq flag QUEUE_FLAG_SAME_FORCE
>    - Support nesting for QUEUE_FLAG_SAME_FORCE as multiple users
>      could toggle QUEUE_FLAG_SAME_FORCE.
>
> [PATCH 4/10] nvme-multipath: pass I/O type to nvme_find_path()
>    - This is the prep patch which updates nvme_find_path() signature
>      
> [PATCH 5/10] nvme-multipath: add latency I/O policy
>    - Implement path scoring based on latency (EWMA).
>    - Distribute I/O proportionally to per-path weights.
>
> [PATCH 6/10] nvme: add generic debugfs support
>    - Introduce generic debugfs support for NVMe module
>
> [PATCH 7/10] nvme-multipath: add debugfs attribute latency_ewma_shift
>    - Adds a debugfs attribute to control ewma shift
>
> [PATCH 8/10] nvme-multipath: add debugfs attribute latency_batch_timeout
>    - Adds a debugfs attribute to control latency batch window interval
>
> [PATCH 9/10] nvme-multipath: add debugfs attribute latency_stat
>    - Add “latency_stat” under per-path and head debugfs directories to
>      expose latency policy state and statistics.
>
> [PATCH 10/10] nvme-multipath: add documentation for latency I/O policy
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

Nilay, do we have evidence that round-robin/queue-depth are better
for any workload? As a user, I would be very confused with the amount
of path selectors I have available and which should I choose.

