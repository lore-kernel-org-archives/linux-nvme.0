Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C20C25B75
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 10:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MVk/4EEpBvKzztOeU3Ci3II6Ly6K/GW4yF+3YCbBL2g=; b=zNOZFo568BxqXQgVmMFOISKtbo
	NTCcLOGD+VBQa2c7tv06zTJp909lifgm0vmUXLqEsO6kqwbNGIvoHv0joAekhWiQvIjslJZfh83DF
	nKdU9uSgOQu5LFN09x4B4x+cfsvBOk+IU8j69rupeZhwynmyGS1jn1TB9rMyH7nfsrefIHB6ewK3N
	wCbbAfBkKZgZnvT9U0tGV7Js9yBkmXlsNiQlDHM6aNQ1Km/Bp3nf5mniUyKUNyQ+exewo7VhHPHCf
	7Awyhqrp4jnu6+IoYzEd4ADuXRR5IQt9YGzQhKZGBAv6Ouiv0ht6Itkq8KVvXZePGYLssEPYrqkYD
	YrjBzJWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9MP6-0000000H03t-125i;
	Tue, 21 May 2024 10:07:32 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9MP1-0000000H02u-4BAF
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 10:07:31 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-354c28d4e2aso65955f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 21 May 2024 03:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716286045; x=1716890845;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVk/4EEpBvKzztOeU3Ci3II6Ly6K/GW4yF+3YCbBL2g=;
        b=KOUbJungR8mQHqtnBzqBDArze+LErM9ysmdpvwA/AQgXBUdbjwnjFyuqK3Sb3acGRm
         eCgPC9LMFHrMIj27lfdHgkKWpPbHxAWcN9HKSi0DRdnSRuSCoFXZZSKkjTlgzy2C+aMT
         ia3dVtyk9fVPizkcf6sv4UPe8gKAhTz1gmMzoCcpvVh6ibOk7WZBZCxB1xOXHJV7imvV
         Y7fWbfxArTk90Eowx7zaL8wPd8tBv9H5znqdYsLTMaHw7i2HwBj/bxPjEEGlSvGyMnk6
         MBkxKBO0GmIeC0WgJGEM/Uec+l3vGOEFN4Pt+PDGO0GheoG+e4YVBavT+uMeq/ZtNL1x
         2z/Q==
X-Gm-Message-State: AOJu0Ywhw53/f1J3hYELIYktHc5LEl1hiXL0FE30rPDnFX0WYWreqW2S
	+KEYsQS4lb/KfdKMWo5oMWFKe09qcZAroQH1PzufAuHZGgO/ICWF82V7Pw==
X-Google-Smtp-Source: AGHT+IE0IcFXw5JvalTue0UVUFQ2gJOxRFdBEhGE0VT6of90aHTVCl17LJM4+IRna3mTcjwU572/9w==
X-Received: by 2002:adf:eed1:0:b0:34d:7201:460a with SMTP id ffacd0b85a97d-3504a10f308mr21484462f8f.0.1716286044680;
        Tue, 21 May 2024 03:07:24 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351b79e8e6bsm23844400f8f.65.2024.05.21.03.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 03:07:24 -0700 (PDT)
Message-ID: <ecb4dc5f-df4d-4c49-94ba-3fb8c3818fcd@grimberg.me>
Date: Tue, 21 May 2024 13:07:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme: add regression test for concurrently
 enable/disable nvmet ns
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20240521085623.87681-1-sagi@grimberg.me>
Content-Language: he-IL, en-US
In-Reply-To: <20240521085623.87681-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_030728_076107_8FBFCF05 
X-CRM114-Status: GOOD (  16.01  )
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

Forgot to CC Shinichiro...

On 21/05/2024 11:56, Sagi Grimberg wrote:
> Reproduce a hang in nvmet when concurrently disabling/enabling
> an nvmet namespace.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   tests/nvme/051     | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>   tests/nvme/051.out |  2 ++
>   2 files changed, 50 insertions(+)
>   create mode 100755 tests/nvme/051
>   create mode 100644 tests/nvme/051.out
>
> diff --git a/tests/nvme/051 b/tests/nvme/051
> new file mode 100755
> index 000000000000..ddc097310dd7
> --- /dev/null
> +++ b/tests/nvme/051
> @@ -0,0 +1,48 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Sagi Grimberg
> +#
> +# Regression test for kernel hang when enabling/disabling nvmet
> +# namespace concurrently
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="test nvmet concurrent ns enable/disable"
> +QUICK=1
> +
> +requires() {
> +	_nvme_requires
> +	_require_nvme_trtype_is_fabrics
> +}
> +
> +set_conditions() {
> +	_set_nvme_trtype "$@"
> +}
> +
> +ns_enable_disable_loop() {
> +	local ns="$1"
> +	local iterations=200
> +	for ((i = 1; i <= ${iterations}; i++)); do
> +		echo 0 > $ns/enable
> +		echo 1 > $ns/enable
> +	done
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	_nvmet_target_setup
> +	ns="${NVMET_CFS}subsystems/${def_subsysnqn}/namespaces/1"
> +
> +	# fire off two enable/disable loops concurrently and wait
> +	# for them to complete...
> +	ns_enable_disable_loop $ns &
> +	ns_enable_disable_loop $ns &
> +	wait
> +
> +	_nvmet_target_cleanup
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/051.out b/tests/nvme/051.out
> new file mode 100644
> index 000000000000..156f0687aab2
> --- /dev/null
> +++ b/tests/nvme/051.out
> @@ -0,0 +1,2 @@
> +Running nvme/051
> +Test complete


