Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F25FC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 12:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hA+iuaOf01zdrBEyOlR0XqzipxbNQVtSF9dJT9o1OYk=; b=ezT1QB/kZBmIJAn4esBwDA+bMs
	0zrBLq1CuQPig0mV7WPA0dMNshCt6tEW1g8MWY39RJaOjOaleIgIOoDCrXyC4etogJJbBKjA4HhSZ
	S4ZlcbIJV8zZB8cqWjVuNBlbS+DWJPHS26B7rFvbBCRj2IDsXBvWv7B32IlKysNVWkKKJG6KjFhHx
	390vrCZXPkVw9Zw5HTBQdIjGY7hLSMB13gcFYBmP9YG/Wx4xF7zLAF7aGb/GAllyyXx6/7wnDPj2j
	K9vFv/ioZqMqLsOxV84w7fGDFL52xBTC7QWaBC/UAU0eS0UvU5qaqs0To8v9ENrfEaY/GVjGKaarm
	zE+ShATA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndt8T-008ydW-9j; Mon, 11 Apr 2022 12:27:13 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndt8P-008yc5-RB
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 12:27:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D8A91F864;
 Mon, 11 Apr 2022 12:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649680026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hA+iuaOf01zdrBEyOlR0XqzipxbNQVtSF9dJT9o1OYk=;
 b=Z7lFvl9M9J7PQJ8BLr1RRVbu+Xobd7zTAVh1B9nSIYHqd10E9FKNvcAtuyZ5AiOp6Kjfg6
 wE9FgCnfBxs5X3mNtLYNOY2Y3CN/Ic3gBUlSnsiSPJXbCVhl+QQ2GpuzoixurxxHQ0Hg4j
 u7J8YqCJM0ziBcgebbmtzHEgd9wkN/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649680026;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hA+iuaOf01zdrBEyOlR0XqzipxbNQVtSF9dJT9o1OYk=;
 b=BQloORxf93RAy+sATa7fC0+EERM/bXJ0yJKmbrH7fDxcKXFha3yhqe3D1tfk4eG8Qcf/aj
 bwodULb4aQ7ygdAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 001FF13AB5;
 Mon, 11 Apr 2022 12:27:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ArC+N5keVGIoFgAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 11 Apr 2022 12:27:05 +0000
Message-ID: <ff897f9c-0b7d-d745-b780-4336b0e4820e@suse.de>
Date: Mon, 11 Apr 2022 14:27:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220408065930.123015-1-hare@suse.de>
 <20220408065930.123015-4-hare@suse.de>
 <dddcb416-e4c8-b1d7-e893-416d819653dd@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in the discovery
 log page
In-Reply-To: <dddcb416-e4c8-b1d7-e893-416d819653dd@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_052710_064586_E0DFB404 
X-CRM114-Status: GOOD (  21.35  )
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

On 4/11/22 12:54, Sagi Grimberg wrote:
> 
>> When a per-port discovery subsystem is used we should include
>> all configured ports in the discovery log page, not just that one
>> through which the controller was connected.
>>
>> - /
>>    o- ports
>>    | o- 1 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=8009]
>>    | | o- subsystems
>>    | |   o- nqn.discovery
>>    | o- 2 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=4420]
>>    | | o- subsystems
>>    | |   o- nqn.discovery
>>    | |   o- nqn.io-1
>>    | o- 3 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=4421]
>>    |   o- subsystems
>>    |     o- nqn.io-2
>>    o- subsystems
>>      o- nqn.discovery
>>      o- nqn.io-1
>>      | o- namespaces
>>      o- nqn.io-2
>>        o- namespaces
>>
>> A discovery on port 8009 will return information about
>> - nqn.discovery at port 8009
>> - nqn.discovery at port 4420
>> - nqn.io-1 at port 4420
>> A discovery on port 4420 will return the same information.
>> A discovery on port 4421 will return information about
>> - standard discovery subsystem on port 4421
>> - nqn.io-2 on port 4421
> 
> This is a different functionality than supporting unique discovery
> NQNs.
> 

Yes.

> If I want in your example to use a unique discovery subsystem but to
> report only on the port local I have to use two different unique
> discovery subsystems. Which is different than the standard discovery
> subsystem, why?
> 
Because this was a logical step from the way I've implemented unique 
discovery subsystems.

As discovery subsystems (in my implementation) are treated like 'normal' 
subsystems, they should be able to be linked to ports. If they are not 
linked we would have to implement some magic on which ports this 
subsystem will show up, and also making it inconsistent with all other 
subsystems.

> I'd submit to you that IMO unique discovery subsystems should not behave
> differently than the standard discovery subsystem. Please explain why
> do you think that unique discovery subsystems should behave differently
> with respect to the content of the log page.
> 
Well, arguably.
But I haven't been able to find a good way of keeping the original 
behaviour _and_ support unique discovery subsystems.

Sure, one could implement some magic variable in configfs like 
discovery_nqn, but that would have to be in configfs root directory, and 
really doesn't match up with current configfs layout.
One could go with your suggestion of having a discovery_subsystem entry 
per port, but we're back to the issue which killed my original patch:
How do we ensure uniqueness?
Each NQN here _need_ to be validated with the existing (and future) I/O 
subsystem NQNs, as they need to be unique. That requires a lookup over 
all ports and all referenced subsystems.
And we have to figure out if we allow for duplicated discovery NQNs; one 
can find arguments for either side.

That's why I came up with this approach.

And that's also why this is a separate patch, as it does expand existing 
functionality :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

