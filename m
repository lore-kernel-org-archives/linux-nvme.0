Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC2CECAAD4
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WsBjD45oyqkccDUHbH5jaBbYU2odQn8a/CV/U2fhlhM=; b=EiHWH5KS0bMlPJTXZXjrv38XPO
	Ky8DGZ9+C5lQRs7Is4iCGDplWEFx3ya43eFm0rGJgS/umyD0ra9qb3J6rhOXid+S14ThxYj6r7VVz
	YRwyucVb0d83vfgxUsFByrNJEqhTCfxt0iXH1gCsJ0s0EN+0mi3IZL9TRcMiyutMJK0sP+PiXjgfm
	7tP+fcsGGB5LA1AWEE0mBKZzx2p26QyLSmOr9V7pI4jartlpSUHwMz1r4T6SObY/e2zlzwRDWPXkg
	fXjZPK167rZi47kDTjwIsxjvPFKdl5JhGXDZgVj0FW3WFoZwchAgocMUk1RrftPFxFdJykSBJWWLp
	l31m4T9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaqn-006bYp-L2; Mon, 29 Aug 2022 09:14:33 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaqj-006bTZ-3f
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:14:30 +0000
Received: by mail-wm1-f43.google.com with SMTP id r187-20020a1c44c4000000b003a84b160addso258199wma.2
        for <linux-nvme@lists.infradead.org>; Mon, 29 Aug 2022 02:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WsBjD45oyqkccDUHbH5jaBbYU2odQn8a/CV/U2fhlhM=;
        b=c7BcRSGZmJ1i3YBfar9hN0ybmg06AR1JwBcNKzQ7RwQAKkF2SaIhA2QdAKW67WMh8G
         KH9HQByBZrR/kaO3z/1ZiURoODYCR7O1JWICC2wmbW4fOEhxu30yoFCJLEB3FrkZm73+
         LHc8XIOLWcbqni8davd91Kj0HRGVaWeB5FrTsp9GzGlyMuPSU73CXxwgC127b9MGsZP8
         i44OMjJxe2jQ7UEkMg+ntDlugPviR5Z3WiVldQMJBh0CJYmbuyOTTq+Wm7UoEhCx3VeT
         mBuqA2SOSGCJJ/LCch/6lwDz6s+ysAh7oLennkEGMN8QkYLKbQ5E9f3ETwB63qHKvMly
         58Qg==
X-Gm-Message-State: ACgBeo2iXwBsJI7kmaEpF8zmfrQgHUF4bcUHmEPk0UyYx6De/3NKtGpN
	yoNFE1E5R0XLubbc2+sHuAD3AzZCid8=
X-Google-Smtp-Source: AA6agR4kLqzoD45nDRMFlWQznFjlqYE5QlhM8pL8svFFkC8BOpt3Cse/ts0B5gljvD1k0ysnkzdYTQ==
X-Received: by 2002:a05:600c:3c96:b0:3a6:59b1:5eb5 with SMTP id bg22-20020a05600c3c9600b003a659b15eb5mr6268755wmb.187.1661764466137;
        Mon, 29 Aug 2022 02:14:26 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c358d00b003a8418ee646sm5443372wmq.12.2022.08.29.02.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 02:14:23 -0700 (PDT)
Message-ID: <dfe23fad-671f-f3fc-4a99-52690b2c1bf2@grimberg.me>
Date: Mon, 29 Aug 2022 12:14:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Regression] Bug 216400 - Firmware activation starting AEN
 processing prevents further AER commands sent to the NVMe controller.
Content-Language: en-US
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Christoph Hellwig <hch@lst.de>, lixingyuan@inspur.com,
 linux-nvme@lists.infradead.org
References: <5e8c01cb-2dc1-e460-6bb2-c9861080154f@leemhuis.info>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <5e8c01cb-2dc1-e460-6bb2-c9861080154f@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_021429_267255_B6BCA338 
X-CRM114-Status: GOOD (  16.47  )
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



On 8/26/22 15:19, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported. That's why I decided to forward it by
> mail to those that afaics should handle this.
> 
> To quote from https://bugzilla.kernel.org/show_bug.cgi?id=216400 :
> 
>>   lixingyuan 2022-08-23 01:14:50 UTC
>>
>> This bug is related to these two commits:
>>
>> 1. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc2&id=4c75f877853cfa81b12374a07208e07b077f39b8
>>
>> These codes will set the controller state to NVME_CTRL_RESETTING while handling the firmware activation staring AEN
>>
>> 2. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc2&id=0fa0f99fc84e41057cbdd2efbfe91c6b2f47dd9d
>>
>> When submitting a new AER command to the controller, this code checks if the controller state is NVME_CTRL_LIVE. This caused the problem. When the firmware activation staring AEN was processed before, the controller state was already set to NVME_CTRL_RESETTING, which resulted in no new AER commands being sent to the controller.

I see.

I can modify this code to check in the drivers instead of the core.

Keith, pci does not risk submitting an async event on a freed admin
queue? if not, I can add a proper check there as well...

