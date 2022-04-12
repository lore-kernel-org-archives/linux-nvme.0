Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECD0C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 12:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BdsjtM57ApJfkV33+jWvrDOR7WHkRgVaLOuJDaLP4G4=; b=zM4EIV3yZgSvbRZPdPKfbjs62U
	66M/04CJaoU6EsZmbcBXmXTx+u9QbCM+B3nYh2iU7JO8qxao2xNSNcZcIqKIP/OXX8zImdTZ7gybp
	7iYARr7UiqBbCHxlJtqN0Ssg3KXDMyGkVamtd5V0t4stJHGLm++BdnjZr7/yOyl0HlIzxzWC4kWHp
	iBkxZ3rgpE24hQF4H6ey84OU9yooonp/FuXthCIFQ9HR2L4TGM5h87IdgBZaS8EaG4L1Q1+WKzVL2
	WSbQm3A559kD9IioGttgZ81xiZbFaeaXx0yax9VIK4ur2++YgRUj2zCIe6w+JHn8905ttOr3fnL2f
	AQ0qfawA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neFOH-00E0U7-96; Tue, 12 Apr 2022 12:13:01 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neFK1-00Dyjq-Li
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 12:08:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 027071F856;
 Tue, 12 Apr 2022 12:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649765316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BdsjtM57ApJfkV33+jWvrDOR7WHkRgVaLOuJDaLP4G4=;
 b=oo+H/CVv5FJftTjq9qXTuwe7vp6uJYkAOPdCi16s5J0ajJTW533U83QnoHMe2hB03WslsJ
 6JZlLvV9KeOczmNpEc68L9EMCvfkPqtdgMvkUxT3pU0ZHTFOLnAnPVmYn+hjs7Or64WgRH
 y8vikm5EdujkHSJCmEpUJVOWtY71MN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649765316;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BdsjtM57ApJfkV33+jWvrDOR7WHkRgVaLOuJDaLP4G4=;
 b=lhTEhCKyT8ThP1bC8K/kfHLG1Fvd2cfTDbBSyLFGEPgF2YyJDBV0WMzBxJ5YI9bwCB0i+3
 Lfltz1teoWNHfXDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C869013A99;
 Tue, 12 Apr 2022 12:08:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qWGXMMNrVWLGcQAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 12 Apr 2022 12:08:35 +0000
Message-ID: <13db553e-817d-c8b7-50ad-a5bc38667727@suse.de>
Date: Tue, 12 Apr 2022 14:08:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220408065930.123015-1-hare@suse.de>
 <20220408065930.123015-4-hare@suse.de>
 <dddcb416-e4c8-b1d7-e893-416d819653dd@grimberg.me>
 <ff897f9c-0b7d-d745-b780-4336b0e4820e@suse.de>
 <e7ffdfcb-7617-4377-a427-080ef3eccaa4@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in the discovery
 log page
In-Reply-To: <e7ffdfcb-7617-4377-a427-080ef3eccaa4@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_050837_984742_1846E632 
X-CRM114-Status: GOOD (  29.93  )
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

On 4/12/22 12:49, Sagi Grimberg wrote:
> 
>>>> When a per-port discovery subsystem is used we should include
>>>> all configured ports in the discovery log page, not just that one
>>>> through which the controller was connected.
>>>>
>>>> - /
>>>>    o- ports
>>>>    | o- 1 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=8009]
>>>>    | | o- subsystems
>>>>    | |   o- nqn.discovery
>>>>    | o- 2 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=4420]
>>>>    | | o- subsystems
>>>>    | |   o- nqn.discovery
>>>>    | |   o- nqn.io-1
>>>>    | o- 3 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=4421]
>>>>    |   o- subsystems
>>>>    |     o- nqn.io-2
>>>>    o- subsystems
>>>>      o- nqn.discovery
>>>>      o- nqn.io-1
>>>>      | o- namespaces
>>>>      o- nqn.io-2
>>>>        o- namespaces
>>>>
>>>> A discovery on port 8009 will return information about
>>>> - nqn.discovery at port 8009
>>>> - nqn.discovery at port 4420
>>>> - nqn.io-1 at port 4420
>>>> A discovery on port 4420 will return the same information.
>>>> A discovery on port 4421 will return information about
>>>> - standard discovery subsystem on port 4421
>>>> - nqn.io-2 on port 4421
>>>
>>> This is a different functionality than supporting unique discovery
>>> NQNs.
>>>
>>
>> Yes.
>>
>>> If I want in your example to use a unique discovery subsystem but to
>>> report only on the port local I have to use two different unique
>>> discovery subsystems. Which is different than the standard discovery
>>> subsystem, why?
>>>
>> Because this was a logical step from the way I've implemented unique 
>> discovery subsystems.
>>
>> As discovery subsystems (in my implementation) are treated like 
>> 'normal' subsystems, they should be able to be linked to ports. If 
>> they are not linked we would have to implement some magic on which 
>> ports this subsystem will show up, and also making it inconsistent 
>> with all other subsystems.
> 
> They can be linked to ports, but why do they need to return subsystems
> that are attached to all ports differently from the normal discovery
> subsystem?
> 
>>> I'd submit to you that IMO unique discovery subsystems should not behave
>>> differently than the standard discovery subsystem. Please explain why
>>> do you think that unique discovery subsystems should behave differently
>>> with respect to the content of the log page.
>>>
>> Well, arguably.
>> But I haven't been able to find a good way of keeping the original 
>> behaviour _and_ support unique discovery subsystems.
>>
>> Sure, one could implement some magic variable in configfs like 
>> discovery_nqn, but that would have to be in configfs root directory, 
>> and really doesn't match up with current configfs layout.
>> One could go with your suggestion of having a discovery_subsystem 
>> entry per port, but we're back to the issue which killed my original 
>> patch:
>> How do we ensure uniqueness?
>> Each NQN here _need_ to be validated with the existing (and future) 
>> I/O subsystem NQNs, as they need to be unique. That requires a lookup 
>> over all ports and all referenced subsystems.
>> And we have to figure out if we allow for duplicated discovery NQNs; 
>> one can find arguments for either side.
>>
>> That's why I came up with this approach.
> 
> I'm just talking about the content of the log page. You are making the
> functionality of unique discovery subsystems different from the standard
> one. I'd either make the unique return subsystems attached to the
> current port like the global one, or change the standard one to return
> on all ports, or make it explicitly configurable that you can turn on
> for each discovery subsys. But making the unique and the standard behave
> inherently different is not coherent.
> 
>>
>> And that's also why this is a separate patch, as it does expand 
>> existing functionality :-)
> 
> My issue is that its causing the unique disc-susbsys behavior diverge
> from the standard one...

Ah. Okay.
That is true.

But having the default setup reflected in configfs is hard, as then you 
would need to create links from the default discovery subsystem to each 
port (on port creation!).
The current configfs design simply doesn't allow you to do that, so 
attempting something like that would break compability.

Which is the big plus for this patchset; it doesn't change the user 
interface, and nvmetcli can be used as-is.

So sure, I can have a look to expose the default discovery subsystem, 
too. But that would require a module or configfs parameter, _and_ will 
require changes to nvmetcli.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

