Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859B0C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 11:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9i86V3EEKh3DEhgoReJtSA4wZZ8TKOEbNv6jNgKMKao=; b=Y9xgAL1hseGmni0GMGDUdq9Bq7
	7UaP7swHMKDuhsnKrccqPfzXn5rXdhqKWsq6lT9vkhjqBcCqr9nUDkYoeVzAQU1iSpEK5ulSuW1IS
	BHV/VE8HL7S0zONThKTeWY6krqrGB8zIe+2x5WPu9jWRDTqK69OdiVVCkdo+tFU1YuPXVvLa7s4E/
	8Vxc44HyZCq1ZKu5icZWK8hdlkpUhluGcbYnIdOoHU13Dg3T7/bKHQevRDWsnLLasLKY34On4eLMM
	Vtt9eedci7uORxfynpK9DDcFftjkMnI2iS33S7dzpENgpEoUSjyu/2kRP/gsEGKbKT3ASLiAZPLaJ
	a2ACXqHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU53U-008qhU-64; Tue, 15 Mar 2022 11:09:32 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU53R-008qgt-0y
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 11:09:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B9C381F397;
 Tue, 15 Mar 2022 11:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647342567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9i86V3EEKh3DEhgoReJtSA4wZZ8TKOEbNv6jNgKMKao=;
 b=sNzQCenyzLs5JZMXrQh5vOzy/7zPZPeNgQcVPj5hgzcDxjUhPB4FCpyhNAlXbFfQkQsOSd
 33qpwmYJEPNv6LPAhTOgQ2Wg3Dg4OG1vyvc+7Cs0RcyogU4ziVVuEYLF9FVzz/eVQk30P1
 KHPUGcg6PPJA+zFyIk2gUbJZJJekNwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647342567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9i86V3EEKh3DEhgoReJtSA4wZZ8TKOEbNv6jNgKMKao=;
 b=r0FLHYA2WY9TB34efDtg1r4DFbDTSHB4r9qYJHOqSMxHXIEUWwFbqfVtK0b81e7613C2C8
 YBDLsnVjCUgZjqAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB32E13B4E;
 Tue, 15 Mar 2022 11:09:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id puiIKedzMGIzLwAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 15 Mar 2022 11:09:27 +0000
Message-ID: <79067416-401e-7ee1-2de8-f67187aaecdb@suse.de>
Date: Tue, 15 Mar 2022 12:09:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de> <20220315080602.GA3082@lst.de>
 <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
 <ec115fe9-2b3f-8f31-d3b8-b85686c2788a@suse.de> <20220315094950.GA5322@lst.de>
 <b2942a7f-0d23-46e3-5ab1-31cad3ee8011@suse.de>
 <dae0fa76-2b78-16f9-a7fa-f28c1412c317@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
In-Reply-To: <dae0fa76-2b78-16f9-a7fa-f28c1412c317@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_040929_386443_271525C9 
X-CRM114-Status: GOOD (  34.62  )
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

On 3/15/22 11:49, Sagi Grimberg wrote:
> 
>>>> The core question really is: do we _want_ to expose the discovery 
>>>> subsystem
>>>> in configfs?
>>>
>>> Well, if you want a freely configurable one we kinda have to, right?
>>>
>>>> Unfortunately, exposing the discovery subsystem and trying to 
>>>> configure it
>>>> with configfs does _not_ match with the way discovery is implemented 
>>>> today.
>>>> While we currently only have a single discovery subsystem, it will only
>>>> ever return the subsystems visible from this particular port.
>>>
>>> Well.  The original Fabrics spec had this concept of that magic 
>>> discovery
>>> NQN, which implies that there is one subsystem (or many pretending to be
>>> one).  And that is what the implementation followed.  The varipus 
>>> 80?? TPs
>>> then made a complete mess off that.
>>>
>>>> Hence this rather simple approach, having the 'normal' discovery 
>>>> subsystem
>>>> exposed, and let the admin configure it accordingly.
>>>>
>>>> I can look at keeping the internal implementation, and only expose 
>>>> unique
>>>> discovery controller (ie those with a unique subsystem NQN).
>>>> That would remove the need to having the 'discovery_nqn' attribute, and
>>>> address Christophs concerns.
>>>
>>> I suspect if we want to support all the new mess from the FMDS group
>>> (and maybe we need to question the why a little more), then we should
>>> so something like:
>>>
>>>   (1) keep the existing global NQN-based discovery as-is.
>>>   (2) maybe add a per-port known to allow disabling it if people 
>>> really care
>>>   (3) allow creating additional discovery subsystems with non-default
>>>       NQNs that do not automatically get anything added to them and will
>>>       just be configured as needed through configfs
>>>
>> Yeah, that's the line I'm following.
>>
>>> But maybe first we should take a step back and figure out what 
>>> supporting
>>> TPAR8013 even buys us?
>>
>> Properly supporting persistent discovery controllers.
>>
>> The current problem we're having (on linux) is that we cannot identify 
>> discovery controllers. Each discovery controller has the same 
>> subsystem NQN, and hence that's not sufficient to identify the subsystem
>> Which resulted in linux to always create a new 'nvme_subsystem' 
>> instance when creating a new nvme discover controller.
> 
> That is the case regardless of naming... there is no multipathing with
> discovery subsystems so there will be a subsystem for every discovery
> controller...
>
Well, technically, no, but in practice there is, as one can easily 
specify more than one discovery port (to the same discovery subsystem).
And quite some target implementations do.
Discussion is probably moot anyway as multipathing would only affect 
I/O, which won't be done anyway.

>> Problem now starts when you try to use persistent discovery 
>> controllers; it's quite easy to _create_ a persistent discovery 
>> controller, but less easy to _use_ an existing one; how would you know 
>> which one to pick?
> 
> You are not supposed to "use" an existing one, the whole point of the
> persistent discovery controllers is that you don't need to worry about
> it. We already perfectly handle that with udev using the kernel of
> the uevent.
> 

And my point is that you _do_. Yes, udev does work, but only in so far 
AENs are involved. When you want to retrieve the discovery log manually 
_and_ have existing persistent discovery controllers you'll need to know 
which device to pick.

Which is getting especially interesting if you have several different 
subsystems to contend with.

>> More importantly, as linux will always create a new nvme_subsystem for 
>> each discovery controller you'll end up with several 'nvme_subsystem' 
>> instances which in fact all refer to the very same subsystem.
> 
> OK, still don't understand why that is a problem.
> 
>> nvme-cli tries to work around that problem by requiring the user to 
>> specify the device name, but that requires quite some knowledge from 
>> the admin side, and making that work in a scripted fashion is a pain.
> 
> I am not aware at all on what scripting are you referring to. But udev
> scripts are written already. Can you explain?
> 
>> So with TPAR8013 we now _have_ distinct discovery subsystems, can 
>> create unique subsystem, won't have duplicate subsystems, and can 
>> automate nvme-cli to pick the correct existing persistent discovery 
>> controller even if the user does _not_ specify the device name.
> 
> And instead specify the subsysnqn? I am not aware of this reasoning you
> are referring to at all, but I was probably absent from these
> discussions... I thought that this TP was solely related to 8010 stuff
> and also solves an issue that came up with the discovery subsystem and
> the authentication TPs.

True. authentication requires a unique NQN, and hence can't be used 
without TP8013.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

