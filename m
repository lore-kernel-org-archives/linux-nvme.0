Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8332EC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 13:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qHITv8pqbT7B52vltCAb+BHDefE8Isw7P2bavY/0dQQ=; b=A2pm+C+hbRxlEpipN0tOdouHPO
	RH4kpVI5W5Gl2szfmqdDKExwug2RuS2aergP+//xueOw+2mcmewAh+HA8T2xwhnjHx+A/jIMJr3Cd
	kgaevaqBCu8VU7ybBWxaYE4txKmpUsHpzns+hJbworE/PCpf0GZ4pwlFDLnc2sDdUrJH0VJJJF7hs
	kBjNtK0MUErUBqLepr46wDDQg3bWoi+KuQzqexcQOPHjMk4u4H2ewCDE3flLwMvUqumYd7ydc+0/R
	RFqYwWqikstDNdqDCws/nASG7qil5/SN3bfB8BjhMRElvhwcdQjezGpgnD2YA/xh78lC2y7QKeQD9
	WOAaEs8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol8pO-00227U-IS; Wed, 19 Oct 2022 13:09:46 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol8pM-00220S-4A
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 13:09:45 +0000
Received: by mail-wm1-f47.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so17493131wme.5
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 06:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHITv8pqbT7B52vltCAb+BHDefE8Isw7P2bavY/0dQQ=;
        b=ESqtg0YE+qkx2pgEvhZ0dpnt0rAKeABFv2u5prlZ7nUSHnZi9RSEd+G3JuyATacUKW
         3BzW1iiBEhTRg5EfJYK5Ugc3F2t1blT0pMBn8Wn1oMkyebRP7Ek65K0VPfep5xoFnRPN
         I6d4JVbOCl/eXbx5Z4ZDX/2b6x9F9m7D+OV+tiW90fpVyJmaYCunCL/m7noDv0vwZUIr
         pk+RgW6rVVVwOl7k/EYSvgbnbUAujQm8vSsywEGtyERXXCj3qadjihI2mORYWFbkex2f
         ybbkdAktynov3bTgyVw6GaR/UQmfqEaUyeP8+kQFMza2c0UK2amAu/dslhiM5SxrpwSN
         lK9Q==
X-Gm-Message-State: ACrzQf2AImEctiVcqMvd+C76Qyyh290OAIbbia5VKp8++ZKccjBjjUKi
	iuSiyyFjkyTd0JRe6aQ2yPhHO6QkZqg=
X-Google-Smtp-Source: AMsMyM5/2AU5fco6V28cHdJozPqcY4gT+RpMxKeLdT+jp+hIezamzKylwRmC0cldekkG6TJUjyHExg==
X-Received: by 2002:a7b:c851:0:b0:3c7:84d:57b with SMTP id c17-20020a7bc851000000b003c7084d057bmr1221414wml.40.1666184981588;
        Wed, 19 Oct 2022 06:09:41 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id iv13-20020a05600c548d00b003c70191f267sm3518309wmb.39.2022.10.19.06.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 06:09:41 -0700 (PDT)
Message-ID: <96978c5e-369b-a010-f9b5-6b4675836e47@grimberg.me>
Date: Wed, 19 Oct 2022 16:09:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: lockdep warning: fs_reclaim_acquire vs tcp_sendpage
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20221019075138.ff2sfahovionh72v@carbon.lan>
 <c30b24b9-e80f-9e8a-5754-caa7dc7bfe8b@grimberg.me>
 <20221019093712.2d2g36wcwwcl7zat@carbon.lan>
 <20221019113517.wv27jqp7lyskfbqb@carbon.lan>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221019113517.wv27jqp7lyskfbqb@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_060944_203444_DDD3A05F 
X-CRM114-Status: GOOD (  13.10  )
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



On 10/19/22 14:35, Daniel Wagner wrote:
> On Wed, Oct 19, 2022 at 11:37:13AM +0200, Daniel Wagner wrote:
>>>>     Possible unsafe locking scenario:
>>>>
>>>>           CPU0                    CPU1
>>>>           ----                    ----
>>>>      lock(fs_reclaim);
>>>>                                   lock(sk_lock-AF_INET-NVME);
>>>>                                   lock(fs_reclaim);
>>>>      lock(sk_lock-AF_INET-NVME);
>>>
>>> Indeed. I see the issue.
>>> kswapd is trying to swap out pages, but if someone were to delete
>>> the controller (like in this case), sock_release -> tcp_disconnect
>>> will alloc skb that may need to reclaim pages.
>>>
>>> Two questions, the stack trace suggests that you are not using
>>> nvme-mpath? is that the case?
>>
>> This is with a multipath setup. The fio settings are pushing the limits
>> of the VM (memory size) hence the kswap process kicking in.
>>
>>> Given that we fail all inflight requests before we free the socket,
>>> I don't expect for this to be truly circular...
>>>
>>> I'm assuming that we'll need the below similar to nbd/iscsi:
>>
>> Let me try this.
> 
> Still able to trigger though I figured out how I am able to
> reproduce it:
> 
>   VM 4M memory, 8 vCPUs

thats small...

What is vm.min_free_kbytes (via sysctl)?

