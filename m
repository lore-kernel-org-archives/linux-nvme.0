Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46357C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Jan 2022 08:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBMhkfOHbH/m6euCLJ/G4ubXvSIJSWQRu2S8LuDeNgc=; b=sU1Y+S9s9mdCSW8RnTbPXSkACX
	ARN9F9qNlVPYBosIimo4KkFVquOznALVuuDjzeFchrCKftGiTowGxrnthhPugjIBicueOsxjwUHqp
	iwmCuumTFftq0dVj8h/Yn/B/q2saXgQ6mxYX3YSdnzk3SgvXf0LcmzmiNfZfhdMQmn/FGi3mJqNgd
	OEfrtrA5gFoCaZdlBvUMuaQ3tjg66p0/8r2eW6pHBOl8LfOC/7swAvY11p008dxc5DTsLa0Br4wey
	aIS9Bdu6Irz7st9ZeVQBH2xOmlkP6rkJgAFF/tl8NL6O/U4Xq+//SPkheZIWNzC0+PVfJ0ONtvBKG
	+50gCDOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDjL3-004M21-4u; Sat, 29 Jan 2022 08:44:05 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDjKz-004M1I-M2
 for linux-nvme@lists.infradead.org; Sat, 29 Jan 2022 08:44:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C092E210E9;
 Sat, 29 Jan 2022 08:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643445839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xBMhkfOHbH/m6euCLJ/G4ubXvSIJSWQRu2S8LuDeNgc=;
 b=otVVrk7JpVPfDIimwm61ro80ws5tu/nYpoGHXA4WlKRmcAHyplYeGHE0h5Gq6vRAqNjfoz
 kOTY7vtO4G1jBGfE9SU6cUk1KOKWwqelJRFlI7upbxfPh7c7lZTq2HpT2jqJHoQX1XjaHI
 Y8J6K760nSO8K4+QqMri5zBqg/M7l2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643445839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xBMhkfOHbH/m6euCLJ/G4ubXvSIJSWQRu2S8LuDeNgc=;
 b=L0y0ZaBmTO14fIx6rqY1PjnDLEVbr4jP3vtA4S/agLy2sNnNr0aBU3Zh9RAfKTcKGlYaJ4
 75wSujcfHC6TKTDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3840813ACF;
 Sat, 29 Jan 2022 08:43:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xz9vC0/+9GGHOgAAMHmgww
 (envelope-from <hare@suse.de>); Sat, 29 Jan 2022 08:43:59 +0000
Message-ID: <8527332c-3126-1297-f161-f2cb818a3061@suse.de>
Date: Sat, 29 Jan 2022 09:43:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/4] nvme-fabrics: add tp8010 support
Content-Language: en-US
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Sagi Grimberg <sagi@grimberg.me>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <1ee5410f-3af6-8ca7-a860-e3fc1bc49a0e@suse.de>
 <92c36bc0-9489-ebc1-3176-fb215ccc8646@grimberg.me>
 <SJ0PR19MB45446D366BC530A5EE66339FF2219@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <12b4824b-f704-fe25-5511-012dfcdaf514@grimberg.me>
 <SJ0PR19MB4544136C4622118DBCEBFFA1F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <37587400-076b-059f-f163-fd90babde443@suse.de>
 <SJ0PR19MB45440F98F8693F571669C012F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <SJ0PR19MB45440F98F8693F571669C012F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220129_004401_921048_49A5B97D 
X-CRM114-Status: GOOD (  28.18  )
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

On 1/29/22 00:02, Belanger, Martin wrote:
> 
>> On 1/28/22 18:55, Belanger, Martin wrote:
>>>>>>> Wouldn't it make more sense to delegate explicit registration to
>>>>>>> userspace (ie libnvme/nvme-cli), and leave the kernel out of it?
>>>>>>
>>>>>> It would. There is no reason what-so-ever to place all this
>>>>>> register stuff needs to live in the kernel. We have a way to
>>>>>> passthru commands so it can and should move to userspace.
>>>>>
>>>>> I wish it could be delegated to a user-space app, and in fact that
>>>>> was my original design.
>>>>>
>>>>> Unfortunately, while testing I realized that the kernel can
>>>>> autonomously reconnect and user-space apps are completely unaware
>> of it.
>>>>>
>>>>> For example, let's say the network goes down momentarily. The kernel
>>>>> then tries to reconnect. Once it successfully reconnects it doesn't
>>>>> tell anyone about it.
>>>>
>>>> Then add a uevent on the controller device-node. From there you
>>>> should trap it and do what you need (exactly like how discovery log
>>>> change events are handled).
>>>>
>>>> BTW, I also don't understand why the host needs this reregistration
>>>> on reconnect, but that is besides the point.
>>>
>>> The fact is that when connectivity is lost and restored, we don’t know
>>> whether changes have occurred on the host (e.g. maybe the symbolic
>>> name was changed while connectivity was lost, etc.) and thus
>>> registration must be reapplied every time the host reconnects to make
>>> sure there is no stale information at the discovery controller.
>>>
>>>>
>>>>> But let's say the kernel does send a signal to user-space on a reconnect.
>>>>> What if there is no user-space app to receive this signal? I'm
>>>>> thinking of the case where one uses nvme-cli to set up persistent
>>>>> connections to discovery controllers.  In that case there is no app
>>>>> to send the explicit registration on a re-connect.
>>>>
>>>> This argument does not justify adding functionality in the kernel
>>>> that doesn't belong there. If we were to follow this argument we
>>>> would be placing everything in the kernel. If someone wants this
>>>> functionality, he/she needs to use the tools required for it to work.
>>>
>>> Ok, Hannes, Sagi, Christoph, et al. I got the message loud and clear.
>>> Explicit Registration does not belong in the kernel. And, as you
>>> suggested, the kernel needs to send a uevent when it loses
>>> connectivity and another uevent when connectivity is restored. This
>>> will allow userspace applications know when to reapply registration (if
>> needed).
>>>
>>> I'm not a uevent expert (at least how to send uevents from the kernel).
>>>   From what I read, there's only a limited set of uevents defined (i.e.
>>> add, remove, move, online, offline). The nvme driver already uses the
>>> uevents "add"  and "remove" when nvme devices are "created" and
>>> "deleted" respectively . We also have  the "change" event that is used
>>> when there's a change in the Log Pages. May I suggest that we use the
>>> "offline" and "online" events when connectivity is "lost" and "restored"
>>> respectively? Please let me know.
>>>
>>
>> I guess we already have that; cf commit f6f09c15a767 ("nvme: generate
>> uevent once a multipath namespace is operational again").
>>
>> When multipath is activated (and I guess that will be for nvme-tcp) you will
>> receive a 'change' uevent whenever a path gets reinstated.
>>
>> So that will be the time when an explicit registration will need to be reapplied.
>>
> 
> Just want to make sure I understand. When the connection is lost the kernel
> sends nothing. When the connection is restored the kernel sends a "change"
> uevent. And when the Log Pages have changed the kernel also sends a "change"
> uevent.
> 

Yes.

> It would be nice to have different events because if we use the "change"
> uevent for both "log pages have changed" and "connection has been
> restored", then the user-space app will have to send both an "explicit
> registration" and a "get log page" whenever it receives a "change" uevent.
> It won’t be able to tell what that "change" uevent is for.
> 

Au contraire.
Change events come with a full payload detailing out what the event is 
about. In the case of a 'log page changed' uevent the event points to 
the controller device, and payload is a string
'NVME_AEN=<aen number>'.
In the case of the 'path reinstated' uevent the event points to the 
block device.

So it's easy to differentiate between those two.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

