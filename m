Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B33C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 11:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2f4aOb+9+XXXByNx7DdOvzsuPWLWExygYpxYGMfmyrs=; b=lfJ5lpvTrcJpALKlZisKts2P36
	bphjbhexmMrPm6Dq9FBokN5I+sVvFbMhpciUcJvQxzIOdugnRq4T+K++d5xPJH1Uzp5/2GbxIhX9V
	QUpNAlrrMob0qebQiTNXp+6hkKnSL3R/ju0W2QuDNMuOcifgskqG1V6VI+u8vgRrFOH5GnVsq95Nm
	2iddgZfCEFVo0r8b+55/OG5mTSUHqvVYctjlx0u5vonanMMtdmnU6yY9eLFRXV7iC2CUIamenlnXQ
	EeNvf8q1KfxVm1i71vb6jAgqH6UMWq+9Qgn1SbXT8ns/fXn2uqCtNBAmMGja4aY+0jb0JroBUsl/5
	k4kiJefA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYnQg-008LXf-IM; Mon, 28 Mar 2022 11:20:58 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYnQd-008LVZ-Vy
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 11:20:57 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 p12-20020a05600c430c00b0038cbdf52227so8370854wme.2
 for <linux-nvme@lists.infradead.org>; Mon, 28 Mar 2022 04:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=2f4aOb+9+XXXByNx7DdOvzsuPWLWExygYpxYGMfmyrs=;
 b=yghc8BBmQ/0Ggu4Q8M1U1sGSR+ov4mmXUUYegJWTXDb8hcy6kRBjitzugi7WnI7siP
 nS22Dr6x8PEthByISeRuhVp8a/9GlnU+hJBlWTmVmaq71gVNFf4lA6+jQNuIB10Bxijf
 upPSulQzijLSZC+SdGVtrMNb3I6XautBGOQcAlt8DfHlUKv6u9NJqyi07J20XOuJmyFh
 /JQSgqODwhxPtyCoVmVB3/HoWbSgVowKzAAYfRufd5r2qxFl8XFWaflVrt/bm/yD6NOl
 pnWQsjpy5mcpUSBOYB97dSAT49g3qlt6I02W2rqJIbUoLZ7VJX0/O7YJos3bum35U2Cg
 qQjw==
X-Gm-Message-State: AOAM531fp38JA7qHyNVkbRv6S4x8w4ZWbl1wLs4LWIzRZo0S1rZxZva9
 C5Es5trsj4QM9aEjGBMo9aM/dHb+IR4=
X-Google-Smtp-Source: ABdhPJwK6p5aNwjBLAb1x/mNq8HGDbcsYkc4pqe0y6zpRsEjX2K14SfA3ENidSg8Z6kglj9+Mk1AhQ==
X-Received: by 2002:a05:600c:204:b0:38d:bad:7552 with SMTP id
 4-20020a05600c020400b0038d0bad7552mr3203330wmi.133.1648466453312; 
 Mon, 28 Mar 2022 04:20:53 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 m4-20020a7bcb84000000b00389efb7a5b4sm15015569wmi.17.2022.03.28.04.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Mar 2022 04:20:52 -0700 (PDT)
Message-ID: <887219b3-9909-e100-262a-4d112de3916e@grimberg.me>
Date: Mon, 28 Mar 2022 14:20:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 09/10] nvme/042: test bi-directional authentication
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-10-hare@suse.de>
 <ffe973a1-1856-e2e7-9695-cb2ce532de3b@grimberg.me>
 <ebae81ae-94d8-6044-1492-cc856a476290@suse.de>
 <17b0e7fa-317a-fbd5-6a04-2a76e3c7f88c@grimberg.me>
 <068a4335-74c8-e7e6-85e0-fed888f4e3fd@suse.de>
 <aa4fe38e-a099-4de5-6993-e71c37040c09@grimberg.me>
 <44056686-0361-75c4-3523-a80467c66a39@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <44056686-0361-75c4-3523-a80467c66a39@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_042056_074361_19BC5C1D 
X-CRM114-Status: UNSURE (   9.81  )
X-CRM114-Notice: Please train this message.
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


>>>>>> This test case has a weird behavior. Why isn't _nvme_connect_subsys
>>>>>> failing?
>>>>>
>>>>> Oh, but it is.
>>>>> The line 'nvme controller found' is not part of the .out file, hence
>>>>> the test will fail.
>>>>>
>>>>> Call it an obscure feature of blktests :-)
>>>>>
>>>>> But yeah, I can make it more obvious that this is the failure case.
>>>>
>>>> Hannes, my question is why isn't nvme connect not failing (i.e.
>>>> returning a non-zero status code)?
>>>>
>>> I guess it does, but we're never actually checking the return value.
>>> Let me check.
>>
>> I tested it manually, and the connect does not fail, but rather succeeds
>> and the controller is removed - which is strange.
> 
> Curious. "That shouldn't have happened (tm)".

Hannes, before I take v10 to a test drive, did you fix this particular
issue?

