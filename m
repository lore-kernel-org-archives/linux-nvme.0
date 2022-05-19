Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D6AC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 12:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y1GovqMPzhvut8NvuPgiE/hNGUig6FYl6qCBlK+A9N4=; b=blUtABa5BrMakOrf3LPsPA5g15
	x+WF0njbXNuIvu+HyDjtqoAmDZ7cyG2TRLUDJ3H1eDiziFcCOCXkR7EL+HrpgaX/rkpEiRaBnXkPC
	xaI2MXOx7C2004P7AArh6l20wAIEEtRR5j91RtN6D/gsuOhbsXSL580JHrKDjQQqsDI+by5ZxnrTO
	xJe7D8EnZG+S85GG4ft/BoyMkB2XVb7WapTKk/UB9vaclCyLRUPu1fuvQB1z5FuFdinU3WBQXtd3o
	4PW2U5UoR28M2BQScgMmejBTErgA5bOjiVuen7dgIK0UFma3R4FDX5eGsysDfXGz151/10J3JGUaV
	G+wmOpuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrfU1-006iR8-Nw; Thu, 19 May 2022 12:42:25 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrfTy-006iOU-D8
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 12:42:23 +0000
Received: by mail-pl1-x633.google.com with SMTP id i8so4663464plr.13
 for <linux-nvme@lists.infradead.org>; Thu, 19 May 2022 05:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=Y1GovqMPzhvut8NvuPgiE/hNGUig6FYl6qCBlK+A9N4=;
 b=vnd1gvTu/Unz1lkokq8fZ1Q1lmDQ1elM7Y8cAW4I2NJHcwmr/6cGQfK1KC21Om/YZb
 xZPPMAAMAppCEewOclP02ef2kaT91sr5GjpGPC1oL2KaA+RY9RYRhvo10SRZrLg0Sc5V
 vaupxPhIKwe/+31NpTqyGOy6FxyflJL0As91UnRvhoJNHfX2znOSRuNhsAhGqLPUIaHB
 eh9vqB8sAOYQ14KIaRZVxrao0+yuVxp5bYIqqVzVwKC84iDa7rBWQYE57KEwM9XBhm2H
 GEi+vD+qvMEClemRHMDmdfxVpU4ezocN8AOewDSY4Q9PHlTFBNQT3SkVrh3iYzK18Hiu
 yBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=Y1GovqMPzhvut8NvuPgiE/hNGUig6FYl6qCBlK+A9N4=;
 b=ZpYaSUdYCshnxecVbwoup15E6gPzWDOmy/eFLhPLdySX+SAZmY+o1VDk0dP9npyJfL
 iMDfLFzasPg/FrOnMV44iEouiWCSbT+elaUUfW54KopGa5JY9bbrjKUzod5SegCNVmhG
 9EBqQ9gsZtdTTzlniQt7UQ6DupciS2W2g0ZXJcVfpHiRkXbeSL7csnDN/t+vvL9Fwpbm
 780uug9EVyrHz7L6Zarx56DYJt1SDHwq7bkURsEt4JAM3atJZsMggOPKV2RQGYcbIuP3
 kJ8ancLXEA6iM1q/AaMDMj0ulcPk+ofK4E5ge3Q+rgep19raU+3+TTxyw75s2euu2WvH
 5PUw==
X-Gm-Message-State: AOAM533KoC64HmwSH8q4b/rzqemskxzGOgFY7QgwnDRw06ebQBU8a2Ss
 yNgbQSc+pXOHRaoegtzutbGOjw==
X-Google-Smtp-Source: ABdhPJzk1auG0FAgzrLMkSSPdvHMZ/jOsnsDFWEuJ0YYtwakff2NjTBQZTp6GUnx/7N5SdpnKo9o2A==
X-Received: by 2002:a17:902:f607:b0:161:5f47:b213 with SMTP id
 n7-20020a170902f60700b001615f47b213mr4504874plg.4.1652964140047; 
 Thu, 19 May 2022 05:42:20 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 s18-20020a634512000000b003c265b7d4f6sm3387809pga.44.2022.05.19.05.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 May 2022 05:42:19 -0700 (PDT)
Message-ID: <c2d252a1-7223-4899-e5c9-e4bb27e2fc8a@kernel.dk>
Date: Thu, 19 May 2022 06:42:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [linux-next] build fails modpost: "blkcg_get_fc_appid"
 [drivers/nvme/host/nvme-fc.ko] undefined!
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Hannes Reinecke <hare@suse.de>
Cc: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
 linux-block <linux-block@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>, sachinp@linux.vnet.com,
 mputtash@linux.vnet.com, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <86768c9d-9a9c-653b-ab99-86de3bc434d8@linux.vnet.ibm.com>
 <7b16694b-0281-d06d-7564-c4f26760a25e@kernel.dk>
 <fc5f8b96-3c93-5400-b917-a1d991cbe7c9@suse.de>
 <900f57bc-9978-9ba6-22fb-48f03fcf5011@kernel.dk>
In-Reply-To: <900f57bc-9978-9ba6-22fb-48f03fcf5011@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_054222_494140_FADF639B 
X-CRM114-Status: GOOD (  12.06  )
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

On 5/19/22 6:40 AM, Jens Axboe wrote:
> On Thu, May 19, 2022 at 6:38 AM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 5/19/22 14:14, Jens Axboe wrote:
>>> On 5/19/22 1:49 AM, Tasmiya Nalatwad wrote:
>>>> Greetings,
>>>>
>>>> linux-next build fails modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
>>>>
>>>> Console Logs :
>>>>
>>>> [console-expect]#make -j 17 -s && make modules && make modules_install && make install
>>>> make -j 17 -s && make modules && make modules_install && make install
>>>> ERROR: modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
>>>> make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
>>>> make: *** [Makefile:1914: modules] Error 2
>>>> make: *** Waiting for unfinished jobs....
>>>
>>> Christoph, can you fix this up?
>>>
>> Cannot reproduce with commit 21498d01d045c5b95b93e0a0625ae965b4330ebe.
>> Please share details.
> 
> The kerneltest bot also reported this a few days ago, you might be able
> to find the details there as that includes config etc.

Here: https://lore.kernel.org/linux-mm/202205190527.o9wVEvHI-lkp@intel.com/

-- 
Jens Axboe


