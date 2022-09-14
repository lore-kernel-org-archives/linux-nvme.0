Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC993ECAAD8
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Sep 2022 10:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NG/tBYKdW3eE5R+C+Bl2XIXo8xD4ho8d93dBF9Mlcvo=; b=gRvC1zSTrvcS6tG13cWl1D6L7i
	GIDCHotew7Y7++ga3I+HPZ+vJjNard0aT/vhJedM8nC2b0mgxj8Bi8ndRCqqDjRt5ZJL/ldKYkUAP
	cGgvFKz0Z8yJyuGyXbeC/NSVo5xnriD2BvdNCWNXT/y4lIUWkTcOTS82f/ZaiRCFWFB5KBUEEnR8x
	2gc6YHVf9Ebx53sEejmybxa357T7HVwNk72tglIaAwfhmXBWuCRct2G/Rcn9SJILygCvl02jM472E
	tIyRhOk/hzjT5NwKiZzSN0EJeDgG6u811+K8IkU3h9jvWzfqvylltVDM1P+TE9Mo3mn3p5ixdFK8G
	RZh7DqKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYPm6-00FFV2-1E; Wed, 14 Sep 2022 10:37:46 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYPm2-00FFOV-Tj
	for linux-nvme@lists.infradead.org; Wed, 14 Sep 2022 10:37:44 +0000
Received: by mail-wr1-f43.google.com with SMTP id t7so24949337wrm.10
        for <linux-nvme@lists.infradead.org>; Wed, 14 Sep 2022 03:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NG/tBYKdW3eE5R+C+Bl2XIXo8xD4ho8d93dBF9Mlcvo=;
        b=F5vLm1VAKMJ3f0oxJh1s5NQZRKIPyN5MOA+r4y04MmSE1+PVDcO/Lad9/ySL6KIl5T
         BgZQ2jstCYPuPZet5Ih1SbO5+pQOdi1gEl1mqu61C1rLmE+DPZ+qa3LcE05pfghbzh3d
         W9ObZ1ZB+2SlOpLMMXCBMA7MQzuZBln+FeogjxaxmkqpW2jjacCQvpedhpBtYIvPnN/u
         mmmFQERRE3y0OK/qQhOHfRaN8viEJ3HAzxaG8RYXCDLQmIRTXNZIw6DbvClRFaS4bBbz
         8iOotclT0lbEh+ZNN0F7qbTrzUC0rU4Ri6rQwMatjeiXq210Mir9itkPKne5tsYGtp46
         rDHA==
X-Gm-Message-State: ACgBeo0Fw8XM/f1XW+bo6q/qHwHGDTvJ3fMpsMr6qmZhjNZ56uSolYzn
	RncZTYJkAkAJxhY2I//5rXw=
X-Google-Smtp-Source: AA6agR7EP0j7pEOqfggaZOV7sbicE/PSXYZGEUcfLwVpr57ptpJXjkugCTGax/jds2f3MoYbfyOesw==
X-Received: by 2002:a05:6000:1ac7:b0:22a:906d:3577 with SMTP id i7-20020a0560001ac700b0022a906d3577mr8759177wry.33.1663151860348;
        Wed, 14 Sep 2022 03:37:40 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003a342933727sm18921430wmo.3.2022.09.14.03.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 03:37:39 -0700 (PDT)
Message-ID: <3b58b91d-e217-86a2-b2e4-3b0656bbe0e9@grimberg.me>
Date: Wed, 14 Sep 2022 13:37:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests v3] nvme/046: test queue count changes on
 reconnect
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220913065758.134668-1-dwagner@suse.de>
 <20220913105743.gw2gczryymhy6x5o@shindev>
 <20220913114210.gceoxlpffhaekpk7@carbon.lan>
 <20220913171049.kgim57lu5rqb7j3g@carbon.lan>
 <20220914090003.jbc5xmtfxjjssuz3@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220914090003.jbc5xmtfxjjssuz3@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220914_033742_984713_CFDCBBA1 
X-CRM114-Status: GOOD (  19.08  )
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


>>>> FYI, each blktests test case can define DMESG_FILTER not to fail with specific
>>>> keywords in dmesg. Test cases meta/011 and block/028 are reference use
>>>> cases.
>>>
>>> Ah okay, let me look into it.
>>
>> So I made the state read function a bit more robust (test if state file
>> exists) and the it turns out this made rdma happy(??) but tcp is still
>> breaking.
> 
> s/tcp/fc/
> 
> On closer inspection I see following sequence for fc:
> 
> [399664.863585] nvmet: connect request for invalid subsystem blktests-subsystem-1!
> [399664.863704] nvme nvme0: Connect Invalid Data Parameter, subsysnqn "blktests-subsystem-1"
> [399664.863758] nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (16770)
> [399664.863784] nvme nvme0: NVME-FC{0}: reconnect failure
> [399664.863837] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> 
> When the host tries to reconnect to a non existing controller (the test
> called _remove_nvmet_subsystem_from_port()) the target returns 0x4182
> (NVME_SC_DNR|NVME_SC_READ_ONLY(?)).

That is not something that the target is supposed to be doing, I have no
idea why this is sent. Perhaps this is something specific to the fc
implementation?

  So arguably fc behaves correct by
> stopping the reconnects. tcp and rdma just ignore the DNR.

DNR means do not retry the command, it says nothing about do not attempt
a future reconnect...

> If we agree that the fc behavior is the right one, then the nvmet code
> needs to be changed so that when the qid_max attribute changes it forces
> a reconnect. The trick with calling _remove_nvmet_subsystem_from_port()
> to force a reconnect is not working. And tcp/rdma needs to honor the
> DNR.

tcp/rdma honor DNR afaik.

