Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4397BC4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Apr 2024 08:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96Om0+waDyQl6WbIl6bY94uj/oZp/fPxRE4KGqioeUs=; b=lUN6EaeOo5px7Tde95ngPILymp
	HA82WjoAc5V2C936oYaCzSPbGkx46461TXo5dSpmukXKG66hHeotM2OHB5XmXvZe52XZnDweBtT2v
	x4t7P6F9sVYtzZ61mJCsEQQ+x57m1weSmkBrWyV9QeVzDS/TGCv+RnxO1lBfanYYNOnmY0LvbQU8N
	Pzd7KyNZUBBoLmMiq/RZXPrtf79OLtZjcwY7XOit0CmK5aDZ0i+x/TeI028GkEfN2TF0jdI/hQDJu
	Vj5cV9njmmWxXq3x6+8nP954q8Sl9bcGh/tNG2aamvhbzO3lPkF1fPIThuoiIKkl6xfQfJ4S3mPT3
	qc3iC0tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s10MZ-0000000HCQe-06BC;
	Sun, 28 Apr 2024 08:58:23 +0000
Received: from mail-lj1-f171.google.com ([209.85.208.171])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s10MW-0000000HCQ9-0X85
	for linux-nvme@lists.infradead.org;
	Sun, 28 Apr 2024 08:58:21 +0000
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2dfe5e0c1a6so905871fa.1
        for <linux-nvme@lists.infradead.org>; Sun, 28 Apr 2024 01:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714294698; x=1714899498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96Om0+waDyQl6WbIl6bY94uj/oZp/fPxRE4KGqioeUs=;
        b=Nz73RDOSPWpCKMugQ2zcVbBhAl3MB9zzyhh6aiSU8CaXA6xV+rukwrg2vr1IUhfbHm
         C9H1WV6vG8uIMU0Uq3nzsrvt1mh5noP4CMt1wzc9O069BLuIdgCXj/cw672NMPJHl17z
         985yfZo+ukGjbuLBwazTy8GJp9OqQVMz5yhMsoTZOHT/PYwOibAZIxluembJrNnLRM1I
         EXr+YRkIa4CH1+sXx4ybjWHbb7vRYiZj0Dljh0sgcQ5ncFYerROhS4G6gvFtGvRpYMUQ
         tNKwu3cKpFtAUJAc+PgGBkG5DXgbq/EGHx17LYrTdUHNIeIJT9ZAeL+V0/z+NHDRQWZZ
         JJPA==
X-Gm-Message-State: AOJu0YzMW4DHtKFCuPyD9Wqzn7maDiwI4rm3i9mmEblMpGV3OwwTC1hw
	cvyUqcUaF374nR02lb7Vk0vuLI94HVgGh1dqBJMAVnAnowug19hA
X-Google-Smtp-Source: AGHT+IGb40SgdMG5/7RBbSJIB8Yrp8z8lxWupvlakG/K6+dOGI7hiPmGy6Zphzn9MYUWQx43W7fMyg==
X-Received: by 2002:a05:651c:2121:b0:2e0:243:dd61 with SMTP id a33-20020a05651c212100b002e00243dd61mr1333346ljq.4.1714294697907;
        Sun, 28 Apr 2024 01:58:17 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id q2-20020adfab02000000b00349d8717feasm26786004wrc.56.2024.04.28.01.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 01:58:17 -0700 (PDT)
Message-ID: <6b55293c-0764-4922-b329-be393c9afc81@grimberg.me>
Date: Sun, 28 Apr 2024 11:58:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 10/15] nvme/{006,008,010,012,014,019,023}:
 support NVMET_BLKDEV_TYPES
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagern@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-11-shinichiro.kawasaki@wdc.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240424075955.3604997-11-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240428_015820_208181_4640433B 
X-CRM114-Status: GOOD (  13.81  )
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



On 24/04/2024 10:59, Shin'ichiro Kawasaki wrote:
> Enable repeated test runs for the listed test cases for
> NVMET_BLKDEV_TYPES. Modify the set_conditions() hooks to call
> _set_nvme_trtype_and_nvmet_blkdev_type() instead of _set_nvmet_trtype()
> so that the test cases are repeated for listed conditions in
> NVMET_BLKDEV_TYPES and NVMET_TRTYPES.
>
> The default values of NVMET_BLKDEV_TYPES is (device file). With this
> default set up, each of the listed test cases are run twice. The second
> runs of the test cases for 'file' blkdev type do exact same test as
> other test cases nvme/007, 009, 011, 013, 015, 020 and 024.
>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   tests/nvme/006 | 2 +-
>   tests/nvme/008 | 2 +-
>   tests/nvme/010 | 2 +-
>   tests/nvme/012 | 2 +-
>   tests/nvme/014 | 2 +-
>   tests/nvme/019 | 2 +-
>   tests/nvme/023 | 2 +-
>   7 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tests/nvme/006 b/tests/nvme/006
> index ff0a9eb..c543b40 100755
> --- a/tests/nvme/006
> +++ b/tests/nvme/006
> @@ -16,7 +16,7 @@ requires() {
>   }
>   
>   set_conditions() {
> -	_set_nvme_trtype "$@"
> +	_set_nvme_trtype_and_nvmet_blkdev_type "$@"

Why not calling separate functions? having func do_a_and_b interface is 
not great.

