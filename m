Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F662C02181
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jan 2025 08:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WLbzK8FCFYPutcpBUpQuSnF0HqXcV7UVQKYAS62UvV4=; b=NrK0dhKwCk4xF8qng2gqzM06ke
	xiNdPnqXm8JJHtj0iiy18AgPLK7lDeODU3zikEG2VeBHy1MOtGpCqUH+MbIT6jq36hbhEbvFRpJRb
	nP7ISoHH7NZxHPrPcLH3jNMt5R0puY34iZ/NKYW/PThJsW0YL0b+cM14+YnpIfdNyp0fraGYOkyeS
	/rFqsovTjmHZZlk85qviaw15Zsa+nWcCctM1j7doLGJHgx1oq/rhG3lo0JurmHPsffOzZ6mQ14Gel
	fOSPgoLRQNWLgZoO9UauN7FnojeiqePQPrfjrwz8kwNOO15E0tqIsx1dxy9cYEDLk/af6DV6AQa6b
	8l8q754g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbyCg-0000000HGH6-09mp;
	Sun, 26 Jan 2025 08:41:14 +0000
Received: from mx3.molgen.mpg.de ([141.14.17.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbyCd-0000000HGGJ-01RZ
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jan 2025 08:41:12 +0000
Received: from [192.168.0.224] (ip5f5aef0b.dynamic.kabel-deutschland.de [95.90.239.11])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C3C3B61E64788;
	Sun, 26 Jan 2025 09:37:09 +0100 (CET)
Message-ID: <333105a9-3480-4694-93d6-0e092dda3751@molgen.mpg.de>
Date: Sun, 26 Jan 2025 09:37:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New warning `nvme nvme0: using unchecked data buffer`
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
References: <20241118155738.2737423-1-kbusch@meta.com>
 <20241118155738.2737423-4-kbusch@meta.com>
 <ed59976f-d8ef-411a-b159-0bb1c6bdfa8c@molgen.mpg.de>
 <Z03Mq9xaMXbJtm0d@kbusch-mbp.dhcp.thefacebook.com>
 <3a851b3a-dfad-4796-94cb-42ced213e901@molgen.mpg.de>
 <Z03XGL6wh1xV2zx5@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <Z03XGL6wh1xV2zx5@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250126_004111_193225_C5356664 
X-CRM114-Status: GOOD (  29.19  )
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

Dear Keith,


Am 02.12.24 um 16:49 schrieb Keith Busch:
> On Mon, Dec 02, 2024 at 04:15:03PM +0100, Paul Menzel wrote:
>> Am 02.12.24 um 16:05 schrieb Keith Busch:
>>> On Mon, Dec 02, 2024 at 08:56:03AM +0100, Paul Menzel wrote:
>>>> Am 18.11.24 um 16:57 schrieb Keith Busch:
>>>>> From: Keith Busch <kbusch@kernel.org>
>>>>>
>>>>> If the device supports SGLs, use these for all user requests. This
>>>>> format encodes the expected transfer length so it can catch short buffer
>>>>> errors in a user command, whether it occurred accidently or maliciously.
>>>>>
>>>>> For controllers that support SGL data mode, this is a viable mitigation
>>>>> to CVE-2023-6238. For controllers that don't support SGL, log a warning
>>>>
>>>> For the layman, what is this security problem?
>>>
>>> The passthrough interface can't validate buffer lengths against the
>>> command's actual payload. NVMe traditionally did not have explicit
>>> buffer sizes encoded in commands, so this only works correctly if the
>>> device and host both agree on what the implicit transfer size actually
>>> is. More recent NVMe features fixed that problem with explicit buffer
>>> sizes in the commands.
>>>
>>> Whether by accident or on purpose, user space can request a smaller
>>> buffer than the device is going to transfer into it. That will corrupt
>>> memory.
>>
>> Does the Linux kernel know the buffer size?
> 
> Not necessarily. The kernel just knows what the user requested. There
> are some commands that the kernel could validate to make sure what the
> user requested makes sense for the command it is sending, but there are
> vendor specific commands and command sets that the kernel has no idea
> how to decode, as well as new spec features always being added that
> change how to decode existing commands, so we just have to trust the
> user isn't abusing the interface.
>   
>>>>       [   14.399238] nvme nvme0: using unchecked data buffer
>>>>
>>>> What should a user do about it?
>>>
>>> Nothing for a user to do. This is an indication that the passthrough
>>> interface has been used with a device that can only use implicit
>>> transfer lengths. It's more of an indication that improper use of this
>>> interface might be the cause of memory corruption observations.
>>
>> Could it be fixed by a firmware update?
> 
> Sure, it's just a spec feature that a firmware update could enable. But
> I suspect devices supporting the feature also have hardware capabilities
> to make it faster too, so I'm not sure if implementing in firmware is
> desirable for all devices.
> 
>> I wonder if the level should be reduced then to info, or if it can be
>> elaborated. Maybe:
>>
>> The PC300 NVMe SK hynix 512GB can only use implicit transfer length.
>> Improper use might be the cause of memory corruption observations.
> 
> There was a proposal to lock the interface down to known commands, which
> I am absolutely against doing. I'm open to changing the log level or
> message text to something better, though.

Sorry for not proposing something. Linux 6.13 was released with the 
warning above. As nothing can be done about – it’s unlikely the vendor 
is going to enable it in the firmware on released devices – I propose to 
decrease the log level to info, and rephrase it:

nvme0: Using unchecked data buffer. The passthrough interface was used 
but the device can only use implicit transfer length. Improper use might 
be cause for memory corruption observations. If in doubt contact the 
hardware vendor.

It’s much longer, but helps the user to understand the situation much 
better.


Kind regards,

Paul

