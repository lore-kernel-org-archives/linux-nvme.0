Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCFDE8FDD6
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Dec 2025 09:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EtesdgDFigleMMAUB/dftad1jbNidy7x7WBrMqYU+YQ=; b=ENewxZYEO2mkNQblFOdW8WPkbw
	JQFoHZ6aEEulLGA+f79FrTWxQ6CCbFu8Iw/YhN7EBJQz4cL4w67F6c6y61Cyk64fA0DWRFCVrnfp5
	cmcB7nl0hD9MASg8WyEQVboquDEGfvHP73pw9EmDMO7/oN53E9aPGB8C5hgTiHfPEPK0jgRcKsZ3v
	MmOSVRmYVQSXnyLuAJbfuaH+utlfLD2LvxGrIeCIzMxiWSunzJwzDQqKaoCPjK0Mdj21UejKkDFKm
	78+FVzFsL+m67Y/Ep8T2qwo/1CgbptIq4rkpIWi+1M96OVDGecBSaMgKGRSAsbk/HO/U1KauGkLtN
	x0IwAMCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZQk7-00000001pb7-21Gs;
	Sat, 27 Dec 2025 09:37:47 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZQk4-00000001pak-1eh8
	for linux-nvme@lists.infradead.org;
	Sat, 27 Dec 2025 09:37:45 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so3656614f8f.2
        for <linux-nvme@lists.infradead.org>; Sat, 27 Dec 2025 01:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766828262; x=1767433062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtesdgDFigleMMAUB/dftad1jbNidy7x7WBrMqYU+YQ=;
        b=Pl36k7D4dT6RwEQLPbsuCZ/WjkuP61dZUwS6f5QiqJUfvYghX0FRMYSwqGGvTNRL0E
         Rf8RajIWdMn5RrraqproFwpNTbi4m0glnDkj1oWtv+ggc9zaBEW0UAnRhUQsLhJXf94C
         i7zNw3GXZRobEojWGvXo7NQCTaV1TszSVc3e97UE3LSPJJWF1ZZoAQmvs60DAjl4C8MU
         /E+2R07r7J18WAwn+aH6p2ADQ1jN4kEWK7NQ0ea5zOJWvyJYydICJsVpvhUtL08AOrwu
         99NheGJoGQ+ZIwEiJ98BA7GU7d8BUpIDY+PiyT70DKhBY6Jfoj+vmdc4EzAB9osFElKk
         CTPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV+Exjtu0ltwwUhm3wxy2TVFrDSiLIC3YtK63e4mTckFBxdl6tfTEu88O6p3KN+Oi7b9m2saueA/ME@lists.infradead.org
X-Gm-Message-State: AOJu0YzB9c4TvannFIE+eEqrs0rrZN82mmIQw5oRvR4XOKHTByKscZAq
	quy8tQw2tsABKKDqxeCK5kG/paAsu/eNW9pK2FSRlmJ+3uKKvB3BJbFH
X-Gm-Gg: AY/fxX4/o5apwZz2KoIkbj1iEkhfm8kniw4NzZ5easDfENpY+ZcgIo0aK76DjRE21n9
	EC3jjgsbEAfzqIRQo9LH5/KWpKBn2ydXyOJCI12dc/vSg3QS6x3O9hGULduLbpsHC12PDj6OMi6
	WPf7d4AfWj7jHJelI3gEUhYkI/3+ypMMRGCROr+1toipAsxcMORKWjPYHnDz6imHNPThgrUuhwH
	7UWI6B9ujHXkvMUJBF9yxwtT2B03W7dU+inStx9JPC+sybe3b+XvP8Ki43UXw5K/0TkZwI6+xvm
	feSwgzEeOJh+4fBCkOHwZLoB+mTPcuw6r2qmHZPMkOvNkzW8QkIzun+eJeYMX5u/HxqpvivlaVO
	QI+xTAdX+uLXGefepiOQTWFGvR31kcHF67IXCGto74Gm4oH/9pgRM7suSefTaQf8lfiQmANw++w
	6/I19QSwree93oVh3dYN4/vnD3TZ4LU9Aaw+3HMxcXD6U=
X-Google-Smtp-Source: AGHT+IGUfELvTcW13wYFUSp/js4H5fabk+FH/SlRYPIVa4h/s4oQ6XCc4GXqhMCllIQKnl/MhEhgWQ==
X-Received: by 2002:a05:600c:c105:b0:47d:3ffb:16c9 with SMTP id 5b1f17b1804b1-47d3ffb184amr98687885e9.23.1766828262138;
        Sat, 27 Dec 2025 01:37:42 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19346dfcsm521423535e9.1.2025.12.27.01.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 01:37:41 -0800 (PST)
Message-ID: <b98e91ef-254c-44bc-b46a-0039c66539e2@grimberg.me>
Date: Sat, 27 Dec 2025 11:37:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 2/7] nvme-multipath: add support for adaptive I/O
 policy
To: Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>,
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
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <81d9feb1-9134-464c-9c4e-393694732426@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_013744_470717_CE3B7C03 
X-CRM114-Status: GOOD (  11.88  )
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


>> Can you please run benchmarks with `blocksize_range`/`bssplit`/`cpuload`/`cpuchunks`/`cpumode` ?
> Okay, so I ran the benchmark using bssplit, cpuload, and cpumode. Below is the job
> file I used for the test, followed by the observed throughput result for reference.
>
> Job file:
> =========
>
> [global]
> time_based
> runtime=120
> group_reporting=1
>
> [cpu]
> ioengine=cpuio
> cpuload=85
> cpumode=qsort
> numjobs=32
>
> [disk]
> ioengine=io_uring
> filename=/dev/nvme1n2
> rw=<randread/randwrite/randrw>
> bssplit=4k/10:32k/10:64k/10:128k/30:256k/10:512k/30
> iodepth=32
> numjobs=32
> direct=1
>
> Throughput:
> ===========
>
>           numa          round-robin   queue-depth    adaptive
>           -----------   -----------   -----------    ---------
> READ:    1120 MiB/s    2241 MiB/s    2233 MiB/s     2215 MiB/s
> WRITE:   1107 MiB/s    1875 MiB/s    1847 MiB/s     1892 MiB/s
> RW:      R:1001 MiB/s  R:1047 MiB/s  R:1086 MiB/s   R:1112 MiB/s
>           W:999  MiB/s  W:1045 MiB/s  W:1084 MiB/s   W:1111 MiB/s
>
> When comparing the results, I did not observe a significant throughput
> difference between the queue-depth, round-robin, and adaptive policies.
> With random I/O of mixed sizes, the adaptive policy appears to average
> out the varying latency values and distribute I/O reasonably evenly
> across the active paths (assuming symmetric paths).
>
> Next I'd implement I/O size buckets and also per-numa node weight and
> then rerun tests and share the result. Lets see if these changes help
> further improve the throughput number for adaptive policy. We may then
> again review the results and discuss further.
>
> Thanks,
> --Nilay

two comments:
1. I'd make reads split slightly biased towards small block sizes, and 
writes biased towards larger block sizes
2. I'd also suggest to measure having weights calculation averaged out 
on all numa-node cores and then set percpu (such that
the datapath does not introduce serialization).

