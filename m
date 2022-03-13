Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4262EC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 21:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SYCLyTrnyqRVpSi3ONMvSpLdZtLUdPrIJGS99QxfQd0=; b=q1ePyoIsz5aJE89JmXOo8D73X9
	zWLeF6FNTEaf0V7CfEGWeVAEzBzm5ru9S1nyHSXQcLiWy0Ho0lJBFCeAiE5dRTMBMRWQCKDBTEkxU
	7nf5U1nuvjC25xbhFTb2RX7FBMraTDZlywn7og6d43uEIyD3mulIceunle0lXDggf6xIhDCPoBMCW
	GWWNLZK5V29AqRYjDIUJOFbwA6xLZtpTDYuWWKCs3K/8hehy0HCaC/10yrjzbOkd71HuZUs9OpCok
	E8oDtQwBIsNxBMSkdRrP85Co2h7Z9i4C+JMwMe61pkl7WwKXSZu2sT93/LFgEPDB+fMYEdkWsNNvp
	hjcA+i9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTVit-003PVS-Oo; Sun, 13 Mar 2022 21:25:55 +0000
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTViq-003PV7-He
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 21:25:53 +0000
Received: by mail-ej1-f44.google.com with SMTP id a8so29997757ejc.8
 for <linux-nvme@lists.infradead.org>; Sun, 13 Mar 2022 14:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=SYCLyTrnyqRVpSi3ONMvSpLdZtLUdPrIJGS99QxfQd0=;
 b=Myyahx0qxobMJDvaumrY8qxXFShN+3spHeN7IpGSvLbkpqMtrXf5jd562i6dEime+K
 0U1oqSqeeuSvTTZoj1VYCe80ASp/cNdIiC8YVutXFDFdEiioLRAtcVw6sq7tDsr46f7u
 KSA5s+gMB80+Mcvhd3jeHdboKx+21KkJ51vrKuTqy+/5WcfTAj6jdvEAUSHb4iRMds02
 3S4i57dpStoXKDKllmyoWbedqCS0/yhohJ32eAbdWwX+9ZGi/XOziL4zeIy90S1nl1C1
 L95SHdIpiYqB31jVIrE96v1MG61KaKtuWgTiB/SiJY4B77zJgFiATYNfmF2KlLwm4cUC
 CbtQ==
X-Gm-Message-State: AOAM5316sJLCHXw/APbqfhkdtyxJUZ15F20yzjVKeSkhNTc/ROy64Ki5
 kEYCGFDavg7U1TVLRK75vtI=
X-Google-Smtp-Source: ABdhPJy+91ZbE2Nh2Ff2OUbQJyCbSHDE1TQwYhvErnQbUFmj/Od3fEZSnIhNrmbjnH/gQ0PNS5i3fg==
X-Received: by 2002:a17:906:30d1:b0:6cf:d160:d8e4 with SMTP id
 b17-20020a17090630d100b006cfd160d8e4mr16542818ejb.265.1647206750940; 
 Sun, 13 Mar 2022 14:25:50 -0700 (PDT)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119]) by smtp.gmail.com with ESMTPSA id
 w19-20020a05640234d300b00416baf4cdcasm5508066edc.48.2022.03.13.14.25.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 14:25:50 -0700 (PDT)
Message-ID: <2cc90ad6-6422-0ef0-005e-a1ec09caf894@grimberg.me>
Date: Sun, 13 Mar 2022 23:25:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Nvmet discovery implementation. Questions and a patch / proposal.
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Mark Ruijter <mruijter@primelogic.nl>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1B761FBE-58C8-4A52-9747-42ED84A6D383@primelogic.nl>
 <5109f07b-b99d-5e3b-f5b3-410fbbbdfcd4@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <5109f07b-b99d-5e3b-f5b3-410fbbbdfcd4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_142552_617559_A9E4047C 
X-CRM114-Status: GOOD (  23.73  )
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



On 3/1/22 09:05, Hannes Reinecke wrote:
> On 2/28/22 17:39, Mark Ruijter wrote:
>>
>> The current discovery implementation only works after a subsystem has 
>> been created and has been linked to a port.
>> As a result, 'nvme discover' from an initiator will only show a 
>> discovery device after the first subsystem has
>> been exported.
>>
>> The patch that I propose adds these features:
>> A. Make discovery work immediately after the target port has been 
>> configured, without needing to configure
>>    subsystems first.
>> B. Move the discovery_nqn configuration option to the port instead of 
>> having the same configuration option
>>    duplicated in every subsystem.
>> C. Allow to enable and disable a target port without needing to unlink 
>> target subsystems.
>>
> The current nvmet discovery implementation was designed to the original 
> NVMe spec, where a discovery controller could only return informations 
> about the attached subsystems.
> But with the recent changes to the spec a discovery controller can now 
> return information about itself (ie which port it's running on), and so
> it does makes sense to have it enabled even with no subsystems attached.
> 
> But: the current implementation only has a _single_ discovery subsystem 
> (nvmet_disc_subsys), which is shared across all configured subsystems.
> And there's a filter when generating the discovery log page such that 
> only the information for the current subsystem is returned (cf 
> nvmet_execute_disc_get_log_page()).
> So in effect each subsystem has its own discovery subsystem.
> 
> Moving the discovery nqn to the port will only confuse matters, as then 
> it's quite unclear what will happen if you change the discovery 
> subsystem nqn on a per-port basis; with the current design you would
> change it for _all_ discovery subsystem ...
> 
> So if you want to do something like this, you'd need to change the 
> implementation to have a discovery subsystem per port, and also change 
> the logic in drivers/nvme/target/discovery.c such that the discovery
> subsystems will return informations for _all_ configured subsystems.
> 
> It's actually something I wanted to do, too, as I didn't like the 
> current implementation :-)

Why aren't we just creating the discovery subsystem as a static configfs
subsystems and just link it to different ports?

The port listener on first linkage is a different matter afaict, don't
see a strong argument to make the port listener without any subsystems
exported anyways... maybe if discovery log change event is being used...

