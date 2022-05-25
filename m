Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2715C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 25 May 2022 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=19Yk2EC/4RBS7U4lBRZi09NHU0WgGJmCkalQ4O+Ho34=; b=lu08jNhPNwaLY4iE3Qc3vmk7eq
	ai2zsi1Q+Yyo00R/h4zFJnBHfKQhi9vr7DeYDBkkmYwpDex0OjMBDZ7JGnSxUEvAB5vvVf1sao8Co
	9+KcsHbbz19ZDk+zVY3OQbD9Vl48kT6No5dVTZOYb0ueZCfx8ekLaEDBViVwWLcsK5Qnrem3VmsWZ
	nsgRkK5HW9zvyTw7DblYo9tdngQnxXOHooFIloT8YhqGiz9n75ExnKI4B969AinzgB1fQUybn/abh
	YG1OYQZbpO5Q0vh3LxH4k3jWMeprkyuzDjEYbmcE0JJTtTAEo4pWMTv5E8VNAOcFo2W0PUWD+8lul
	2tb3xigQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntoPT-00AjLD-6u; Wed, 25 May 2022 10:38:35 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntoPQ-00AjKX-7h
	for linux-nvme@lists.infradead.org; Wed, 25 May 2022 10:38:33 +0000
Received: by mail-wm1-f46.google.com with SMTP id v4-20020a1cac04000000b00397001398c0so834101wme.5
        for <linux-nvme@lists.infradead.org>; Wed, 25 May 2022 03:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=19Yk2EC/4RBS7U4lBRZi09NHU0WgGJmCkalQ4O+Ho34=;
        b=W8+fwSIl9w9SP25swKSqVyX7aBEp02+8Q96s0P1lwE6eT862YKVSK6ezbzUV5soO3E
         Gly68ceE98DZbpwmr4Q64Hq1/575tcA1OfIButIinDfX0DwRGz35zd8sw9CbJWsJfwb5
         NE1rd3+SK2TuOb8WgK/+l1/gpFeiX2ocLANcfJt9RPz7BBkL+6uC4smrQPYTGM6NEDrf
         fWkVYq+uZB27AORGjaGJWpkSW4g1R3aOIiN8VZHmCTUStmDoGKMZrZ3jSfZuNFmFnwNO
         rq2ngzlvB/c2evQumLhoBdWAkmGTmz02lqwTYB+gOm6k0DPwbMST4thP89NjYBDuGOWw
         ChUQ==
X-Gm-Message-State: AOAM531RuyPAwS1RW5DC0P778bfcYEwQ/B2EJBz90eTe/e2aNUhaqJPP
	GA9mpZhKVjo4NGfMUq1F8h4=
X-Google-Smtp-Source: ABdhPJxnMgT9qB5nMscHiWb+Zuw1tSLeozdYN44dD/4szU6vM/1MOBi4Z4pxYL2z+vGMO3tMIkkSNQ==
X-Received: by 2002:a05:600c:1d99:b0:397:5d48:e431 with SMTP id p25-20020a05600c1d9900b003975d48e431mr6212726wms.119.1653475111018;
        Wed, 25 May 2022 03:38:31 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l18-20020adffe92000000b0020d0b2de858sm1728462wrr.33.2022.05.25.03.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 03:38:29 -0700 (PDT)
Message-ID: <dc6e7c12-2dcd-c01e-f10c-430c824231b0@grimberg.me>
Date: Wed, 25 May 2022 13:38:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] nvme-tcp: handle failing req immediately for
 REQ_FAILFAST_DRIVER
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Anton Eidelman <anton@lightbitslabs.com>, linux-nvme@lists.infradead.org,
 Martin.Belanger@dell.com
References: <20220407092540.66227-1-dwagner@suse.de>
 <eef5eda6-f00f-b879-858f-80f7ce44a362@grimberg.me>
 <20220407122054.reywmgnysnhryvg2@carbon.lan>
 <129b9f99-fd4d-1920-dee8-652e774a3b57@grimberg.me>
 <20220407133806.xawe6y5v5uec4vzi@carbon.lan>
 <48363e60-d506-b1bf-cb3a-db781290f285@grimberg.me>
 <20220407135353.uupdcx2jbk37qtpx@carbon.lan>
 <20220407150155.sryxcqrv25wt3irp@carbon.lan>
 <adb47490-e13a-1c18-c6fb-23a233471796@grimberg.me>
 <20220411112217.vihnysakkzawmrvo@carbon.lan>
 <20220525075844.7qk5wn3vbiltadhw@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220525075844.7qk5wn3vbiltadhw@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220525_033832_322736_61697E9B 
X-CRM114-Status: GOOD (  13.51  )
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


>>>>> I see there is a shutdown_timeout which is 5 seconds on default. Seems
>>>>> not to trigger though.
>>>>
>>>> Obviously, the shutdown_timeout is not connected to the register
>>>> writes. So we would need something like:
>>>
>>> Looking at this, its probably not what we want...
>>
>> I agree. We just have to make sure that we fail these register
>> read/writes on transport layer and don't requeue them.
>>
>>> I've inspected the code and I don't think that we should check
>>> the return code at all, we should simply fail the request. If
>>> the io_work context is running in parallel with the the error
>>> recovery handler we have a bug that we need to fix.
>>>
>>> How about this?
>>
>> Yes this would work fine for my case.
> 
> Do you want me to post this patch or are you going to post it?

Would like to get Anton's feedback on it, will ping him to reply
soon.

