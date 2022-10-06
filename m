Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604AFC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Oct 2022 20:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4+49kAz483R2cgmcQRLlDOuDtqu8HKLE/F4zg1kqYy8=; b=pcoKpKq4qvuQtMREqstbkTdPvp
	zSDyH6GEf8H7Kz8xiqvnEM/Hawwa667+Qn/ZKTCC5KGlHI02SoAY6fhtkjF6QC11FOB0swjxu0MJ0
	h85zqfmS+PosXJ5JymE9HAABv/moeSQPZj638OTvTVLup11jETHU9MvQpjgxxaLvz3NVxQH+hR99P
	kc4wyv4ggV/+qA7VpZPg7oOYp87kwJRRz7j8FJsCveEyb8nrWHzXxaZK3YluFOd29SmxbUw0lQDyD
	dM8UsCgh1NsBTK68LwWfHx9McDgeMPyiqto6MG13pqdfen1rb1pUGs5Qb8DOE/KSyJ/W4tPwEQjlP
	h+vOA+8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogXHB-004ylj-LE; Thu, 06 Oct 2022 20:15:25 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogXH9-004yir-5c
	for linux-nvme@lists.infradead.org; Thu, 06 Oct 2022 20:15:24 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d12so503435qtp.3
        for <linux-nvme@lists.infradead.org>; Thu, 06 Oct 2022 13:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4+49kAz483R2cgmcQRLlDOuDtqu8HKLE/F4zg1kqYy8=;
        b=oQJnjutHPsBxnRFwIzc0O5lLipfVMwmbupH3L5V7zjaSqTqeJAhJHcLGNDPxqpcENR
         vCvLBWgg6xeLwsD7ROF9mzWIvB+v/0hL1e1dqwFfCibdB08tlH037++N1CG0wFx24aNR
         baZS5ezS48I1ChjCkyyXTiWzqS8YTFGEUONrc4MeSNqeLunC935ipDkIKxvHvhwfBBqt
         gVaT6AFXVmjSkYTS6ZqrgQm4WZOLi6ELzeEGuC2S+e1KgOUDG+8PXbSvPWJwG8sn6OfC
         yhd1gEJbCDhvXY58Xwvpg85g6YMM+cmOBifO40mFj791GS/SAzVfrHs+KwtgWnjW6F8G
         MeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4+49kAz483R2cgmcQRLlDOuDtqu8HKLE/F4zg1kqYy8=;
        b=3ksqBzMJprD4JpJr9LdRDFwDRJT0N5P/RaHOj4ElxGzqSq0qOrvQnS20b8+mVW9xcf
         rMQV3vSUoUW4Oqh+9nqBBidUlKq+0VnbaQnkU6G014rKlglOx04sFnh2v+ejbaorND5H
         AND2mdht0eagSBHMhD+AgPIbcCxNgOgLKDKMszJWORivqeqT+my/YvAplk1Vcr/thxa+
         Ky/8p7i/nHWEyDpteYY5IJfc+nilK6UCJOUEiGfPQfUdkOny4siNEPbu0GKX4YCoK38c
         foEB4LXUIqhocsow/ms0WbbdM6/W3Tw7kdOqFrWbkkXC3kotTnkbrc7bhWqzQ5jOumsP
         L4HQ==
X-Gm-Message-State: ACrzQf2N47QO4OnktPV1Xzw11KWFpRZZKmV6zOn2SjYLUtbpb0pEgn5k
	uUA9ofvXdoe529L+Y/P4/jg=
X-Google-Smtp-Source: AMsMyM41ZpO06TbfpAF1OvQBxtkVorHsXVdj+MEI+dOubumLS+Qs5tdIXdddXn3y0kmBHvD+6ztpMw==
X-Received: by 2002:a05:622a:1182:b0:35c:c062:ec0a with SMTP id m2-20020a05622a118200b0035cc062ec0amr1735394qtk.654.1665087320201;
        Thu, 06 Oct 2022 13:15:20 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm48817qko.23.2022.10.06.13.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 13:15:19 -0700 (PDT)
Message-ID: <7872e4c7-54cc-08d6-e7a5-3510c3875e1d@gmail.com>
Date: Thu, 6 Oct 2022 13:15:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue changes
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Cc: "Knight, Frederick" <Frederick.Knight@netapp.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "hare@suse.de" <hare@suse.de>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
 <20220928090243.c4ctbj2frydwsfav@carbon.lan>
 <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
 <20220928135053.s6h6xr3llhp6riwr@carbon.lan>
 <b121c092-cecc-b891-be3c-b32c2a3e611d@grimberg.me>
 <20221005181510.zu7vcwjtltcal2zi@carbon.lan>
 <74eb192e-13aa-5043-3016-5ce0d7ca2688@grimberg.me>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <74eb192e-13aa-5043-3016-5ce0d7ca2688@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221006_131523_246420_04403E84 
X-CRM114-Status: GOOD (  22.10  )
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

On 10/6/2022 4:37 AM, Sagi Grimberg wrote:
> 
>>>> As far I can tell, what's is missing from a testing point of view is 
>>>> the
>>>> ability to fail requests without the DNR bit set or the ability to tell
>>>> the host to reconnect. Obviously, an AEN would be nice for this but I
>>>> don't know if this is reason enough to extend the spec.
>>>
>>> Looking into the code, its the connect that fails on invalid parameter
>>> with a DNR, because the host is attempting to connect to a subsystems
>>> that does not exist on the port (because it was taken offline for
>>> maintenance reasons).
>>>
>>> So I guess it is valid to allow queue change without removing it from
>>> the port, but that does not change the fundamental question on DNR.
>>> If the host sees a DNR error on connect, my interpretation is that the
>>> host should not retry the connect command itself, but it shouldn't imply
>>> anything on tearing down the controller and giving up on it completely,
>>> forever.
>>
>> Okay, let me try to avoid the DNR discussion for now and propose
>> something else? What about adding a 'enable' attribute to the subsys?
>>
>> The snipped below does the trick. Though There is no explicit
>> synchronization between host and target, so it's possible the host
>> doesn't notice that the subsystem toggled enabled and updated the number
>> queues. But not sure if it's worth to address this, it feels a bit
>> over-engineered.
> 
> I think that for the matter of this patch, you can keep force reconnect.
> 
> But I still think we need to be consistent with the different transports
> on how we interperet controller returning DNR...
> 

I agree - behavior should be the same regardless of transport.  DNR is 
pretty specific in its definition - "If the same command is re-submitted 
to any controller in the NVM subsystem, then that re-submitted command 
is expected to fail"

But, what we forget is "the command" is actually "command X with fields 
set this way".  If we change the fields, it may actually succeed.

So if we're re-issuing Connect in the same way without any changing 
values, we're better off not reconencting.   But if Connect changes, 
we're back to ground 0.

-- james


