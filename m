Return-Path: <SRS0=KsQz=E6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED0AC2D0E4
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 03:28:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EA220857
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 03:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BDunM08Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EA220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LTNCB9SxOgJKHuQvRQa1CZJey2uvgwxvzK0Xmd+epNU=; b=BDunM08YPJ7c7m08/xL2PqOou
	RQ+9zdq6DnptTvmQiBYnCKahkHzKOMDlWiiWG6Mo2CbQsmt32ofHGeR5LdqCsMQyE2k4xL2UBEMcr
	6o+RN2+Rrve3JV92nRGkSqOzL3z9bURFnK9Cme0aIDDilp14fh+P295GAFS9TDiX+5VxG6RkVCz4O
	0pb16VTr2QsAsQj/t3UwIK/XfHuR2cfRRHFGOLYCTNgmMOCfb4bi5TfrP0onSYDlmgiL53VH4YLSB
	YE+xWqjGHigDpszs8KU31MAMX/3I6uBf7FbMYD8ND4GrMXvOTIsgJERD6d6o25p3shUJJbpvM8iJ0
	i0GisI3LA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khP0M-0000nS-1g; Tue, 24 Nov 2020 03:28:34 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khP0J-0000mn-Mb
 for linux-nvme@lists.infradead.org; Tue, 24 Nov 2020 03:28:32 +0000
Received: by mail-pl1-f194.google.com with SMTP id x15so9971730pll.2
 for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2020 19:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o6xqCpcCwQxDNvNzkySXeO3yCgRU5kI353/INUpoWBA=;
 b=Y7IboH/DiMXVffgsUW6qNjsLPr+uoIBX2KRVbbIcOJDKD82RL8nDmhQKN+Y3rYjHm5
 0hfH6iS7v1hoFlE9i+qW959EfKWooJRVMliciogUZGBCPlEiGPvrD0cb7p8IiUyg8ewi
 u+4ITL3WJxRTh+x79EfQBRiB9xJXQN53HLpECw22h7mTseYXwrsjUO02Y/46iN4PDHXm
 2mb+KdbY+FSvAiNg4wdEjvrcudnNyqCzbBrI6S8tKS3AHDYAQh/skqumGqSCGIOT3Fun
 MC2zVxU1lY8dHIDTy+LjyAlRppQbLJQOM/O+f9Cvx794JGPMMHfDey+fX1ambHCrG3bZ
 CO9g==
X-Gm-Message-State: AOAM532S07Q4Fe3FEK4n3d/8sX3es6aCGZ948xz0FzeV7VC194m5Sw7h
 FQqGfQrqLcNXDxf7Oz479o0=
X-Google-Smtp-Source: ABdhPJzBxocinQ6eFQejqenY+0JGzhM9v713BTYKJWRGlvHc6HuZpoIZvQzSpVQT8kJrPHKAbOl8FQ==
X-Received: by 2002:a17:902:d346:b029:d9:d097:ed15 with SMTP id
 l6-20020a170902d346b02900d9d097ed15mr2095625plk.1.1606188510393; 
 Mon, 23 Nov 2020 19:28:30 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id 12sm826500pjn.19.2020.11.23.19.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2020 19:28:29 -0800 (PST)
Subject: Re: [PATCH blktests 3/5] tests/nvmeof-mp/012: fix the schedulers list
To: Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-4-yi.zhang@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <241aba9c-b57b-e81a-63b9-d79a3178d946@acm.org>
Date: Mon, 23 Nov 2020 19:28:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201124010427.18595-4-yi.zhang@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201123_222831_786435_F8B06E26 
X-CRM114-Status: GOOD (  13.10  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/23/20 5:04 PM, Yi Zhang wrote:
> There is no cfg scheduler and new added kyber scheduler in lastest kernel,
              ^^^
              cfq?
> so get the scheduler from sysfs

[ ... ]

>  	# Load all I/O scheduler kernel modules
>  	for m in "/lib/modules/$(uname -r)/kernel/block/"*.ko; do
> @@ -17,15 +17,17 @@ test_io_schedulers() {
>  	for mq in y n; do
>  		use_blk_mq ${mq} || return $?
>  		dev=$(get_bdev 0) || return $?
> -		for sched in noop deadline bfq cfq; do
> -			set_scheduler "$(basename "$(readlink -f "${dev}")")" $sched \
> +		dm=$(basename "$(readlink -f "${dev}")") || return $?
> +		scheds=$(sed 's/[][]//g' /sys/block/"$dm"/queue/scheduler) || return $?
> +		for sched in $scheds; do
> +			set_scheduler "$dm" "$sched" \

Similar code occurs in tests/srp/012. Please introduce a function for
retrieving the scheduler list and also update tests/srp/012.

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
