Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D211C76196
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 08:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VWv0O+wen9CrWwGUvf2aOphbYQNevKi30cBAafvsgAw=; b=rwVcZQXmS26Q5NScMWEsZfCtNm
	0juRQjRdNu6NT2Ig3xCUThieZAS8bOdFbUrP/fEI7aegKbkN/jx/HHmsDU57a4u9JUTMWke9ijEk+
	4dtotZlEt5C48zPM9dyJQ4qPDAvwd9ORV+1A+NpkpmVnqPiWwBkMqDvPElqtfqiKsmOeSe3v/qZ01
	AFIHm3LX4uBWXzWtoKMrymQYdoU100sIT0uG9YChBMStkCtvXK8+54jeRqpizE/VkWEvKwJ/GbfJf
	vbKfajeAPlL2GDZKqb5/eIAQ7zijhXNqMtZ3DRkjki6TmWr9ZeRnLeaLapGU/fpv0aHpslSkmoYxe
	BeGE1JIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ph58E-00Df26-0p;
	Tue, 28 Mar 2023 08:56:42 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ph58B-00Df1c-1a
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 08:56:41 +0000
Received: by mail-wm1-f43.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so6857839wms.1
        for <linux-nvme@lists.infradead.org>; Tue, 28 Mar 2023 01:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679993798; x=1682585798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWv0O+wen9CrWwGUvf2aOphbYQNevKi30cBAafvsgAw=;
        b=MXt4IYjO7bcleXnbq9t5Ix9z07V7kft6+DW0H+MfxvPV56oJHneA/seHfh6eKaHhTI
         /Nlmh8TThXJ50SKT9+NQSOCry3UFQaDPfruIrXmrjKH5W1/v47FBCRt+YGA631wzd2lK
         GYJma6FtYwi7Bw3w19WR3pL+PEITg0j1mGknYXonahHhYk9WWcKWpSMFeUoMegSA/lyx
         YH9PO7pEMfJPv3UHFo2r9OAmrxGhDH4BDu6cUzDENSw3KrvTPejcJnuL++ZlJEp6lTOG
         JWiBrWZI1/4NdtnYK/F2DbFYNeIPffv3Uq3msIHNKqsuDs0U7gvUFd8vBS1d/zakDi+c
         p+fA==
X-Gm-Message-State: AAQBX9caixmXp8pJ8JbLMiy0ZYNUuHOIu8BF8wfjaabV5Pc1LxA17KAY
	Uoht6IQCnZmWn+0rEcgyyKo=
X-Google-Smtp-Source: AKy350YZxwmFCmXSAyRZirDBAbL8lH21XaKYlpS0Qy/S0o6IEGTthNGecwhmtNHwIJRDFvYJvIKyKA==
X-Received: by 2002:a05:600c:3503:b0:3ef:7795:e5b1 with SMTP id h3-20020a05600c350300b003ef7795e5b1mr1373744wmq.4.1679993798172;
        Tue, 28 Mar 2023 01:56:38 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id he14-20020a05600c540e00b003ef7795e5a3sm1604200wmb.20.2023.03.28.01.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 01:56:37 -0700 (PDT)
Message-ID: <88c8ad0c-cc3f-9b25-3516-e55c8a764e03@grimberg.me>
Date: Tue, 28 Mar 2023 11:56:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC v2 2/3] nvme: add error logging opt-in
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, p.raghav@samsung.com, kbusch@kernel.org
References: <20230323230316.2914077-1-alan.adamson@oracle.com>
 <20230323230316.2914077-3-alan.adamson@oracle.com>
 <20230328005735.GC21497@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230328005735.GC21497@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_015640_228017_E9D3BF8D 
X-CRM114-Status: GOOD (  13.40  )
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


>> Commit d7ac8dca938c ("nvme: quiet user passthrough command errors") disabled error
>> logging for user passthrough commands.  This commit adds the ability to opt-in
>> to passthrough error logging.
>>
>> To enable passthrough error logging:
>>          echo 1 > /sys/kernel/debug/nvme0/error-logging
>>
>> To disable passthrough error logging:
>>          echo 0 > /sys/kernel/debug/nvme0/error-logging
>>
>> By default, passthrough error logging will remain disabled.
>>
>> CONFIG_NVME_ERROR_LOGGING_DEBUG_FS needs to be enabled to
>> to enable passthrough error logging.
> 
> Any reason to do this in debugfs vs sysfs which is someting
> that we can a handle too much more easily?
> 
> Also why do we need a config option for a trivial mount of code?

I think it is because the fault_inject thing is dependent on a config.
But if we move fault injection to a debugfs init/fini we can hide
this stuff without a config option

