Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AD8C7619A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 06:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x3LBh7GbM/KtRzgDN8v/wdUoPQ86yqjFptu4ZXT0gZs=; b=pJ3Q3xhauW1fwL6JBRZX2+6dcm
	fsd2kwknUsz3eFnipFl/26crUT0EiAg6l4gmDh8hDSxikFmMWTWnxYj/hiX30fLLNZ01NVFndsm8x
	V3q/NQqc4xCmjA23Da9u2jyKWasGjfstUzKmthGq2ZFaVeYOSxWcxKbcMecOkzAFYg+HxAby9Ja0v
	cs7EQhSRUOpR+DLgXlBjPHfsEpTRrQNnrvxpL1+3eHbZGqzr9LlFhFBFSArnujFa1ZmR9Dmw0pM7V
	t2sWFnMKDBCx83GokakDXzQM+3dxx1cr0LpMvPfYbf7Y8KqdMOr6/0kxJcjl3u5POdb1cpVN2+7w+
	NWlRJUIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm7EI-00GYUs-1H;
	Tue, 11 Apr 2023 06:11:46 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm7EG-00GYU0-0x
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 06:11:45 +0000
Received: by mail-ej1-x629.google.com with SMTP id qb20so17121816ejc.6
        for <linux-nvme@lists.infradead.org>; Mon, 10 Apr 2023 23:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681193503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x3LBh7GbM/KtRzgDN8v/wdUoPQ86yqjFptu4ZXT0gZs=;
        b=xtCVmdoqr9s8pnzDmuFK7DyHcHsh08104vZadRbOqMX8oX3G+pzPcYiTZuyGjb1q5s
         wWRzJ0nE9IneVXnbNhlhD+8b3NDSlMmoCkEB/RMGaY+mWjN/rhxSsmxpz4NkhFWezEgl
         huM3JumsyAMCaDQSAxbsZ49K6siE41tdh9M8o0OjjGCjVQcCZZgPij/usghwrF0pKl5R
         LIYnORLV+epQf2Wo4BLgUBEJcPMBNTRq2fsVmS4mCSYIpGuDQTMm3cdBhIIcHt/FbsrC
         nDVIYjNqqfIcBirH1R9Xda1OlvRdcrGKsQyxbVjqVjTGI4lDedavmPKdHXpLW8k5k9t5
         sV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681193503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3LBh7GbM/KtRzgDN8v/wdUoPQ86yqjFptu4ZXT0gZs=;
        b=epKC+h7QOIxz+ClO5hZgMzvF8I7OUOAFg0GXLTpKD0a4b4dwBr02T65y2j5/hcq6gX
         +l+pWaZNzLKqAWt0mYzHAJVSz3Pr80kbSmI0Q7G+a0sZXi21HG3yxXOsyyYMiTt3/CPS
         RaDYV1f1B2fLHrLlErxlulmzGupOxmRSgP1ywf6kVaaJagoL/uVPdBzbOes8o2am9PFs
         XMnIfQhriB2N4YI4NRIbARaVb3zG72dbnnJ/Qbx1x6vaooXjQF2tkC6H/YT3fP7Iykv0
         rwRKNM2TB+/z7dgrRGhWVa0fTgMDEJQ6byb/7r7zTi6XSuJ8hTB3SlqzN2qiuAlfcuQE
         L0pg==
X-Gm-Message-State: AAQBX9fgEewiR7rTaoF9jQC+CXel5qTeCDmd3W40AzTW2VqPgAnzuLLQ
	MwRXubSWIGRGw+u2bZmTn2AY6w==
X-Google-Smtp-Source: AKy350YPqsV7qZusK/N83+7CscOxJxYzUdjA094vdcz/SfTlGJzvPuDCuFvWzhqNNMebKqux7Wb3Nw==
X-Received: by 2002:a17:906:f2c2:b0:93e:fa12:aa1a with SMTP id gz2-20020a170906f2c200b0093efa12aa1amr1297116ejb.1.1681193502786;
        Mon, 10 Apr 2023 23:11:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:dad2:72b7:3626:af61? ([2a02:810d:15c0:828:dad2:72b7:3626:af61])
        by smtp.gmail.com with ESMTPSA id hr15-20020a1709073f8f00b009477ba90a85sm5719974ejc.69.2023.04.10.23.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 23:11:42 -0700 (PDT)
Message-ID: <0d4d27e6-02e0-09e3-8e99-18b40880961c@linaro.org>
Date: Tue, 11 Apr 2023 08:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] nvme: host: hwmon: constify pointers to
 hwmon_channel_info
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
References: <20230407145845.79557-1-krzysztof.kozlowski@linaro.org>
 <20230411060900.GD18527@lst.de> <20230411061012.GA18624@lst.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230411061012.GA18624@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_231144_360615_91FBF21F 
X-CRM114-Status: GOOD (  12.60  )
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

On 11/04/2023 08:10, Christoph Hellwig wrote:
> On Tue, Apr 11, 2023 at 08:09:00AM +0200, Christoph Hellwig wrote:
>> Thanks,
>>
>> applied to nvme-6.4 with a trivial whitespace fix.
> 
> Actually, I've dropped this again as it causes this warning:
> 
> drivers/nvme/host/hwmon.c:221:19: warning: initialization discards ‘const’
> qualifier from pointer target type [-Wdiscarded-qualifiers]
> 
> This looks like we might need a core hwmon change first.

The dependency was described in the patch. Guenter also provided
a stable branch with the dependency:

git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const

Best regards,
Krzysztof


