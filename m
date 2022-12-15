Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF12EC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Dec 2022 09:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RUZ5HMAlAZQMk82K90Nqt99HcB95qtCNaxWWEneKUQ4=; b=r+72Pc/6MXGJXR
	kZxO66KsdJTieIytbhJJu0Mwr8XO/sSIds8s6cxZqopEU18zAGYKuaYX4uqQxKQiAq7+ilWsx3fLN
	f2bEZy3Sf4Zgmf/ZikuJTwUZuWbqlcRupKySUFLaeUBF55Gqgw5iG8l5GB0d8gGrp6EOGbd30Obne
	/omIX5UI0voPH9HC8nf8GL0WlKZBAnulegNRl2B6r4OnsfeiaPHYAEj/BUF1ndS65P9BYLXlyGAgK
	so1Bc+D/dnik6UqGerM7FRMdtDk+jm5CWYi9liwx4QCpoTVvcJ5oBWslcsWTyxq3/ekVhb+iH2Ogz
	oEJnznqCmKCfaw3+AlZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5kDP-00834M-Hk; Thu, 15 Dec 2022 09:07:43 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5kDM-0082zV-0P
	for linux-nvme@lists.infradead.org; Thu, 15 Dec 2022 09:07:41 +0000
Received: by mail-pj1-x1035.google.com with SMTP id o12so9793112pjo.4
        for <linux-nvme@lists.infradead.org>; Thu, 15 Dec 2022 01:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RUZ5HMAlAZQMk82K90Nqt99HcB95qtCNaxWWEneKUQ4=;
        b=ISs+Bj5+xmGRf2Cr/UxmO6kTv8P8wn0VLgAXxAGqNZHt4VWXoqc1BRMhM1ikvIY4fJ
         UG8ChjPqf4xQWSAQDPekx2FPy1pjljYw33Q71JsOh4jovtUs2GThzcrzByT6dxUd7/zt
         Z3q+opC7bLs+lSO8VoBTu699x+UrXHBXfeUZDwljnSQFktV5x/opI7wLIPizEI7Ihyg6
         DxAUCihed1ztbXlmnDHtlj9n+UWs3byctNJRqCp2FnEmAuk/j/ObmHx6jjYhdfegUEV5
         QTqSnS8xkFT4320/+u6+kRPU5L8pne8sDVlJpnFAiwywagI5b2Ry/fQEzKrMlPB361Sd
         jKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUZ5HMAlAZQMk82K90Nqt99HcB95qtCNaxWWEneKUQ4=;
        b=wtnjvgpmns/BSzbD28U+w7+MFhXjf98BGnnemKp0BTpw2iIxzIGWEsPrwXQArOgmI2
         NrsyNYGPVpFjEgMtqeIMEMNyh9Xn2dLe8v/EiiUsmAJTAxSteT2v77p2Em0LM83lXoxw
         drTgJLfn+YztrSTgWwD9TMLTQb2gIG0QwiksMkKgmgNGrLrE5WIbvWA+3kR1DzX1S0PL
         XmJL8R3xE8BXz/y6VcXGSnI1R2rO9t+21MYujGF7tnd3aHzRSwzZ2Oobnfjgwz/j/9oO
         gTidA70rqw7nr9O3F+S45QnYD/CxyPAw560gFpl9ky8FT+iF9TUnnWLMjCYPXoP4CcDJ
         yfDA==
X-Gm-Message-State: ANoB5pnLTzQg2fp3piCNCnrrLeJBcR01Vu7zHyVseeMmFNoJhFj3bsPh
	DxtBzpjAF9ne7dBoTsux85E=
X-Google-Smtp-Source: AA0mqf4k60QOhu59SuEiZ5kFLQOfPUamLfAv3AC4wJbDzPCFQJP/Ewq3+nWxYRyEwkSPs8DTqog0HQ==
X-Received: by 2002:a17:902:ec02:b0:189:c429:f615 with SMTP id l2-20020a170902ec0200b00189c429f615mr29960781pld.1.1671095256971;
        Thu, 15 Dec 2022 01:07:36 -0800 (PST)
Received: from [192.168.0.23] (q014251.dynamic.ppp.asahi-net.or.jp. [203.181.14.251])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b00182a9c27acfsm3240800plg.227.2022.12.15.01.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 01:07:36 -0800 (PST)
Message-ID: <d4c4eea9-e573-df0c-cca5-536bcff6c0a9@gmail.com>
Date: Thu, 15 Dec 2022 18:07:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source drive
 corruption observed
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
 sagi@grimberg.me, jfhart085@gmail.com
References: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com>
 <20221215082344.GB3816@lst.de>
From: "J. Hart" <jfhart085@gmail.com>
In-Reply-To: <20221215082344.GB3816@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_010740_109161_3BFD01E9 
X-CRM114-Status: GOOD (  19.65  )
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
Reply-To: jfhart085@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/15/22 5:23 PM, Christoph Hellwig wrote:
>>
>> dmesg reports the following:
> 
> nvme0 is the destination driver I guess?

That is correct.  The device /dev/nvme0n1p3 is the destination partition 
on the NVME drive, and was mounted at /mnt/root_new.

>> [Dec14 19:24] nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting
> 
> Can you enable CONFIG_NVME_VERBOSE_ERRORS so that we can see what
> commands are hanging?

I will do this and run the requisite testing right away.  I'll reply 
with the results as soon as I have them.

>> I have also observed file system corruption on the source drive of the
>> transfer.  I would not normally think this to be related, except that after
>> the first time I observed it, I made certain that I corrected the file
>> content before any additional attempts, but have seen this again after
>> every attempt.  The modification dates and file sizes did not change, but
>> the file content on the source drive did.  I confirmed this using the
>> "diff" utility, and again using a rsync dry run with the check sum test
>> enabled.

I should also note that I did a third test using md5sum and confirmed 
that the sums obtained thereby were different.

> Ok, that's really odd.  The only way I could think of that happening
> is if the driver does stay DMAs, which would be really grave.

My apologies....I am not sure what is meant by "stay DMAs".  Is there 
something I can look for here ?

> Do you have CONFIG_INTEL_IOMMU and CONFIG_INTEL_IOMMU_DEFAULT_ON enabled?
> If not, it would be good to enable those to see if the iommu catches
> any stray DMAs.

I will enable these as well and reply with the test results.  Thanks 
very much for your generous assistance.

J. Hart

