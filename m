Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466B1C02180
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 18:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gUTLsi+LIPDuraq4G8Sik5HsRMYZe4qZ4DPIn6hwyYU=; b=1oe5byFIFS8XkSqiehha/7/9+i
	L8msz1eS1zY6Z25WHHAGkdYW1lrle9xskhFkyNy0OjOt3pFKXWDuCHzFEI6l7dtwtKhWoRWNsFZ89
	JRVWFgjgCYgm9s47wuy46FBNj+WPD51dIjUAeINb/ao/BiVUCV3XecqmwPsdu3ivbe+Z0eoeH8YVh
	2m/DRtV4BUwxuwRQUWASQ4AFGgQEikkOb2UB3Dx7f6J5jCDDR4tdYV43TqeaGLHSgpIRM1ak+1uLV
	h6KZ6TgQaadS5aWVHuGeGXf5++893rGZe0A5U3/D2h4eh63XVc9lD9Qw72zc3oUmI45PcGVkl2StV
	99h+qAjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXOkJ-000000068dO-2KnU;
	Mon, 13 Jan 2025 18:01:03 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXOkG-000000068bz-1EbI
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 18:01:01 +0000
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-844d7f81dd1so166413639f.2
        for <linux-nvme@lists.infradead.org>; Mon, 13 Jan 2025 10:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736791259; x=1737396059; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gUTLsi+LIPDuraq4G8Sik5HsRMYZe4qZ4DPIn6hwyYU=;
        b=3LmshThkLAoyN94abOhtrHfyHRlcif3qkNEoWnUfiJB0OS4qxQKQm4KIeSxbfzkZdw
         mImFSAPbB+8/BwQ6/pZl5zoPj5fixi7eGZG84Q6hzjILQ8ihyoE+YeGI1RB8+ALMfjV+
         McNsw8On+81IBMCCw4R8CtixMf8fHaLSbefpdZhu9diqqthziZujEpcabkbAzUIg9VTc
         3rHwPdFK4bZvaTkUqyvgBM76ggY3QOrB/OhyT37eDrJDbYK0XlSf3peNsFCqhPdtpaPc
         ss/k5p0EN6/VUSrr69fqpRxF5k9zbO/YUfnzKMX6dZpbLm4lwF4P0pIcL9mfXPU2Ml7X
         F7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736791259; x=1737396059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUTLsi+LIPDuraq4G8Sik5HsRMYZe4qZ4DPIn6hwyYU=;
        b=pR4bh+zzZSnGgrHz+wqAV7pZbWap8Xr77lOCIEgocIEackur+e4d8KEf1OcUvm8j2w
         FHDfDshiusirnskUW+/sgqD6w24ecoiLNFEuCpQu60AKsTQQ8Ui6/FS9Tz4eSWax3aYo
         wGp8Keaozevh2gExUHHYdW3FlKzTrpKnIh0yWNcGhnpXbODGF1fpwgFeT7xYnMrctqln
         8SatG+/dH5NT95nyecK9V1tRpiFwUFOSti95bjXxLqO+MdAijorhSffj5CPa5injqn8p
         QM2vkF9nhnP6DqhrMNYXbEGcqTAj/buLn6YjCODYSscYtYEs9k6vzv5odk8WEFvjrfdr
         mwVg==
X-Gm-Message-State: AOJu0YzUs8ZxOkVmh1w/kqgIWgmXk8UW9Kdfawq2eiLPczmThTNquPWv
	v0rLbj6N2eDVsuTivOlXojm/gFRIAPsDy3Emm4/vSXCslYTYEPAx5tOKM0HtDLFUoM+tP8kjBg9
	T
X-Gm-Gg: ASbGncttLVD2p66RLa9TyUcqFdbUJoWWq6kFH2EwlwLoowdnjWrBrBY+3b1R3nxe4Ie
	t8S13FOoU/mlcCOjO9zWFMcFOk9LQ6ycX3R3dKw/19QKKOBmY3hzkQcD4FUR4cNMXNHaMGwD3ei
	mL8rdZnGIpPUPbqCejpWBjaSIl6f2zhBON9jzORRs7M70+iM3Qllrb7376ui1N1hMcdykKn5C9/
	bHkP1hqqZXLzzBoYqi0ew/K3RmANQq8jT8kJjUkKJagPt3KqXmT
X-Google-Smtp-Source: AGHT+IGfCwsS/6yayghavxjnPJcrLmPdOSof3t1EMl5GWw1DY4NkQx247jKTsg388Q5JBMqwYCe66g==
X-Received: by 2002:a05:6602:751a:b0:83d:ff89:218c with SMTP id ca18e2360f4ac-84ce00b8a80mr1958531839f.7.1736791259099;
        Mon, 13 Jan 2025 10:00:59 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b7488casm2868044173.135.2025.01.13.10.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 10:00:58 -0800 (PST)
Message-ID: <bfbf7262-b08e-4471-add7-b95af046965a@kernel.dk>
Date: Mon, 13 Jan 2025 11:00:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix bogus kzalloc() return check in
 nvme_init_effects_log()
To: Keith Busch <kbusch@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 keisuke.nishimura@inria.fr
References: <9516d209-712a-4a48-9dda-b270e80e3abb@kernel.dk>
 <Z4VPxy8G--jyYFm4@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z4VPxy8G--jyYFm4@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_100100_336898_07CBDD9E 
X-CRM114-Status: GOOD (  13.52  )
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

On 1/13/25 10:39 AM, Keith Busch wrote:
> On Mon, Jan 13, 2025 at 10:30:06AM -0700, Jens Axboe wrote:
>> nvme_init_effects_log() returns failure when kzalloc() is successful,
>> which is obviously wrong and causes failures to boot. Correct the
>> check.
>>
>> Fixes: d4a95adeabc6 ("nvme: Add error path for xa_store in nvme_init_effects")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Oops. Thanks for the fix
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> 
> Also applied to nvme-6.14, but feel free to take it directly to
> block/for-6.14.

I did, figured that was easier. And if it fails on the one test system
I tested on, guessing it'd break someone using linux-next as well. Hence
let's just shove it in and move on.

-- 
Jens Axboe


