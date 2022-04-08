Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594C2C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 05:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c+Cs1uqgmejgQkx6san3axufxDPrvyZvNp/hFk42dBs=; b=4QxKm7DvTnnHDwgKrD25y9uu6D
	ZS5gM7BX5b+VTgMUs3Cbd7UYQg0DB9Z20/Xeyyq/Xcxl1hkOUySrHVtvn0Duwun9//A/z8nE++69I
	q38XtwAXVjHeKt96MwFIfuQ8bYKgqkPS4mLh/6uBPxcQJB7PKpPafgFzaP0oqWbb3IXBI6Af09Ciq
	iDzZBaKOGalpeytwoxZf2hL0nTdjCIR8e8I/1D5raBTJUw7oii+LElDa/0+Xxc0t1pHYhnwL01DP8
	u9oJ2uY6Kmr6XSm4gwYmqzHW5sAr2Wks/FTWIf27gK53SCwoj690LrF7snvM65W0UymSya1ssJie9
	PovLqiIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nchTy-00FCNk-LE; Fri, 08 Apr 2022 05:48:30 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nchTw-00FCMg-2H
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 05:48:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 52EDE68AFE; Fri,  8 Apr 2022 07:48:25 +0200 (CEST)
Date: Fri, 8 Apr 2022 07:48:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvmet: per-port discovery subsystem
Message-ID: <20220408054825.GD32232@lst.de>
References: <20220407104808.29007-1-hare@suse.de>
 <20220407104808.29007-3-hare@suse.de> <20220407154924.GD15988@lst.de>
 <8f5bac0c-a80d-9ef5-76e7-9af9938ccd2c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f5bac0c-a80d-9ef5-76e7-9af9938ccd2c@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_224828_294360_8FD39AE5 
X-CRM114-Status: GOOD (  22.12  )
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

On Thu, Apr 07, 2022 at 07:21:17PM +0200, Hannes Reinecke wrote:
> Sure. I just didn't want to make the patches too complicated initially.
>
>>>   	down_write(&nvmet_config_sem);
>>> +	if (subsys->type == NVME_NQN_CURR &&
>>> +	    port->disc_subsys != nvmet_disc_subsys) {
>>
>> Curious, would NULL not be a better encoding for the default discovery
>> subsystem?
>>
> Hmm. Sure, could do.

Looking at the rest of the patches it might not be a very good idea
after all.  So I'll let you decide.

>> This has an extra tab indent.  But: should we even redirect from the
>> well known discovery NQN for a configured discovery subsystem here?
>> If yes at least this needs a big fat comment explaining why we do it.
>>
> Yes. This is mandated by the spec
> (section 3.1.2.3 Discovery Controller):
> If the Discovery subsystem provides a unique NQN, then that Discovery 
> subsystem shall support both the unique subsystem NQN and the well-known 
> discovery service NQN.
>
> Will be adding a comment.

Thanks!

>>> +	if (req->port->disc_subsys == nvmet_disc_subsys) {
>>> +		nvmet_format_discovery_entry(hdr, req->port,
>>> +				nvmet_disc_subsys->subsysnqn,
>>> +				traddr, NVME_NQN_CURR, numrec);
>>> +		numrec++;
>>> +	}
>>
>> Why don't we report the current discovery subsystem for if it isn't
>> the well known one?
>
> Thing is, unique discovery subsytems are just 'normal' subsystems; the only 
> thing which is different is the type.
> The static discovery subsystem OTOH is special as it's not linked to the 
> normal subsystem list and consequently doesn't show up in the 
> port->subsystem list.
> Hence the extra entry here.

Ok. Please add a comment that the unique discovery controllers will be
handled later in the loop.

