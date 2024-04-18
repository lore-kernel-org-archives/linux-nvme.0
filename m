Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D8DC4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 09:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=er8DX4GP/0zcFAH5hqRsOdPBNwI7p7EcYeTeMz68P6k=; b=tESrPSpXgJrGQLeRTsGVnC45//
	fr1vdcgfz+DACQidra5XYft5SACnjKYqtWYbtxGRnhQ2h4DLyBLzl28kBJbVvrvfzpnBriXZENCJX
	TlUvvCW2o6MRYLAg6QLvWxUDu5xW5GZbfnZgMwaEf+IKL/vhf9FF3VOrEQIjCVC9WwsrjD/EgYu9s
	nrQaypqN3JRWmSMRsZuoSYWS9k8VdlsQyqDTIXeM8ADHtct4V9wuM0FQe2nfxyEsuN/RcbuLoYOWZ
	41LBxktOf5UqENh8tuXIvSJbAQ8hRlAmayR4kecWBtBaBZsQ2A365feptAevingsF6NPwnPZBqt8Z
	RuP8A1ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxOFO-00000001egc-105m;
	Thu, 18 Apr 2024 09:40:02 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxOFK-00000001efw-2vg8
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 09:40:00 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-349a35aba9dso109903f8f.3
        for <linux-nvme@lists.infradead.org>; Thu, 18 Apr 2024 02:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433196; x=1714037996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=er8DX4GP/0zcFAH5hqRsOdPBNwI7p7EcYeTeMz68P6k=;
        b=BnKLL8jzVdHmBfAZgzyrmnBEERBphZgK6jjsTstqViNh8m1rbUaM2GFcGI80+vc1sb
         HWLORqdKzvFkqyaJwArJkZfFDcrRsePDuUIi5JdxQ5JFIbnXjpPVejCKIDaT2RdqiHk3
         x7pipBw8gMXz1g28kpr7Vel0O+OUsuULQ13dpkliUpo7jJFA5wYpWpkceROd9dNHOPmD
         mF3XXvAYfz3vwgUb3EzqC4Wr4qtWtxmkJK6et0pm8gxwFwjfjMyo4zaaga7muwC484Ax
         Ve+7Sqbfwy5U3Cc+KlQu+USDEywIFSEGOY7VyM7gfTbx3FwJLTJ0GdL17u3KAwy+Au51
         OVhA==
X-Gm-Message-State: AOJu0Yx0PLQSQxwpgGmXd3ow96rezxoM0feqSrABbPTQW0Ercl3caL8J
	7XSPkGQQ5cqEto8GnyS0wMVWhFoW5QCi7aj3CrwRSHQjR6qWwAWJ
X-Google-Smtp-Source: AGHT+IExRCYVfQBev/WP5uthvMv97mFPpVQLciU76GEJOc65YeRzt2GNkaYiVeOeVs1IAm/cYJKisw==
X-Received: by 2002:a05:600c:1d16:b0:416:b5f7:7ceb with SMTP id l22-20020a05600c1d1600b00416b5f77cebmr1549260wms.0.1713433196291;
        Thu, 18 Apr 2024 02:39:56 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c190a00b00418a9961c47sm2057311wmq.47.2024.04.18.02.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:39:56 -0700 (PDT)
Message-ID: <35a9cba8-776b-4894-9dd4-122eccb68887@grimberg.me>
Date: Thu, 18 Apr 2024 12:39:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 05/11] nvme/rc: introduce NVMET_TRTYPES
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagern@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
 <20240416103207.2754778-6-shinichiro.kawasaki@wdc.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240416103207.2754778-6-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_023958_840361_6F8B8D4B 
X-CRM114-Status: GOOD (  23.70  )
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



On 16/04/2024 13:32, Shin'ichiro Kawasaki wrote:
> Some of the test cases in nvme test group can be run under various nvme
> target transport types. The configuration parameter nvme_trtype
> specifies the transport to use. But this configuration method has two
> drawbacks. Firstly, the blktests check script needs to be invoked
> multiple times to cover multiple transport types. Secondly, the test
> cases irrelevant to the transport types are executed exactly same
> conditions in the multiple blktests runs.
>
> To avoid the drawbacks, introduce the new configuration parameter
> NVMET_TRTYPES. This parameter can take multiple transport types like:
>
>      NVMET_TRTYPES="loop tcp"
>
> Also introduce _nvmet_set_nvme_trtype() which can be called from the
> set_conditions() hook of the transport type dependent test cases.
> Blktests will repeat the test case as many as the number of elements in
> NVMET_TRTYPES, and set nvme_trtype for each test case run.

It would be nicer to keep the same name and just have it accept an array.
Not a must though.

> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   Documentation/running-tests.md | 11 ++++++++---
>   tests/nvme/rc                  | 33 ++++++++++++++++++++++++++++++++-
>   2 files changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
> index ae80860..144acd1 100644
> --- a/Documentation/running-tests.md
> +++ b/Documentation/running-tests.md
> @@ -102,8 +102,13 @@ RUN_ZONED_TESTS=1
>   
>   The NVMe tests can be additionally parameterized via environment variables.
>   
> +- NVMET_TRTYPES: 'loop' (default), 'tcp', 'rdma' and 'fc'
> +  Set up NVME target backends with the specified transport. Multiple transports
> +  can be listed with separating spaces, e.g., "loop tcp rdma". In this case, the
> +  tests are repeated to cover all of the transports specified.
>   - nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
> -  Run the tests with the given transport.
> +  Run the tests with the given transport. This parameter is still usable but
> +  replaced with NVMET_TRTYPES. Use NVMET_TRTYPES instead.
>   - nvme_img_size: '1G' (default)
>     Run the tests with given image size in bytes. 'm', 'M', 'g'
>   	and 'G' postfix are supported.
> @@ -117,11 +122,11 @@ These tests will use the siw (soft-iWARP) driver by default. The rdma_rxe
>   
>   ```sh
>   To use the siw driver:
> -nvme_trtype=rdma ./check nvme/
> +NVMET_TRTYPES=rdma ./check nvme/
>   ./check srp/
>   
>   To use the rdma_rxe driver:
> -use_rxe=1 nvme_trtype=rdma ./check nvme/
> +use_rxe=1 NVMET_TRTYPES=rdma ./check nvme/
>   use_rxe=1 ./check srp/
>   ```
>   
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 1f5ff44..34ecdde 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -18,10 +18,41 @@ def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
>   def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
>   export def_subsysnqn="blktests-subsystem-1"
>   export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> -nvme_trtype=${nvme_trtype:-"loop"}
>   nvme_img_size=${nvme_img_size:-"1G"}
>   nvme_num_iter=${nvme_num_iter:-"1000"}
>   
> +# Check consistency of NVMET_TRTYPES and nvme_trtype configurations.
> +# If neither is configured, set the default value.
> +first_call=${first_call:-1}
> +if ((first_call)); then
> +	if [[ -n $nvme_trtype ]]; then
> +		if [[ -n $NVMET_TRTYPES ]]; then
> +			echo "Both nvme_trtype and NVMET_TRTYPES are specified"
> +			exit 1
> +		fi
> +		NVMET_TRTYPES="$nvme_trtype"
> +	elif [[ -z $NVMET_TRTYPES ]]; then
> +		nvme_trtype="loop"
> +		NVMET_TRTYPES="$nvme_trtype"
> +	fi
> +	first_call=0
> +fi

It would be nice to have the string check be done at first so you don't
get any typo-related error later during the execution.

