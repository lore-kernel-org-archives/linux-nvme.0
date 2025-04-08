Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32174C369A5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 13:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yI5TQ8MQOsaoL6zAKnewx+cz+JcP6GX8vdKltnm/AbE=; b=kEvtyOCl0BSR3uXsEl6rcWL5JZ
	O0i9nakUPvhvxVeMHZ9zeRAlQPV6mCqFwu5O6w5jMC+j4TwonJC4VIRSqnUr8vBnya/1clgl20X0b
	hhdok74L6dvDjRuuHhyE40JrUy+NOazXLBNZVIST/e49rx8xqDtYKZf6oIxxwg1gVYG31GKcGm2/E
	4VYlU6LHsg/dfsm5wENtJSftCBGFpxieVIPyKGnIH8QOBhFBrg+WGXQTUTbZpvsWHTuzJOlIMY74Z
	zGM6/8MTid9F8YvjnZ8bI5zJVulfbdoWCjL+0ztahtN7FJ0DtBS9kJG6gPh+aE9V50plSUHN+zNXe
	tWF7m5Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u28mZ-000000047Pu-1A3m;
	Tue, 08 Apr 2025 13:14:27 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u27RM-00000003tas-2yKT
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 11:48:29 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E19031F38D;
	Tue,  8 Apr 2025 11:48:25 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD84513A1E;
	Tue,  8 Apr 2025 11:48:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1mWeMQkN9WePEQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 08 Apr 2025 11:48:25 +0000
Message-ID: <74e3bb7d-444d-41bc-aa18-a820e748b32c@suse.de>
Date: Tue, 8 Apr 2025 13:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tree: add attribute numa_nodes for NVMe path object
To: Daniel Wagner <dwagner@suse.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
References: <20250405130255.448345-1-nilay@linux.ibm.com>
 <20250405130255.448345-4-nilay@linux.ibm.com>
 <1f88256a-f36f-4a34-96e2-53d2b6da7764@flourine.local>
 <4db3b302-3a07-4e82-aa5c-c63c55de2c6f@linux.ibm.com>
 <89bce70c-8eac-4dee-a5ca-4aa52fa5687f@flourine.local>
 <fd2407c9-e180-4785-a71f-944ea40edfe3@linux.ibm.com>
 <9b957880-ec3b-4b22-a923-f5b91dee9b76@flourine.local>
 <72649ea2-35c8-4c97-a3af-3f1c38bf7303@suse.de>
 <cb240c7d-ce29-4c7d-a205-13466d5b749f@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <cb240c7d-ce29-4c7d-a205-13466d5b749f@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: E19031F38D
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_044828_888740_DC210C30 
X-CRM114-Status: GOOD (  15.74  )
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

On 4/8/25 13:42, Daniel Wagner wrote:
> On Tue, Apr 08, 2025 at 07:58:40AM +0200, Hannes Reinecke wrote:
>> On 4/7/25 17:19, Daniel Wagner wrote:
>>> On Mon, Apr 07, 2025 at 07:49:41PM +0530, Nilay Shroff wrote:
>>>> Both approaches — either adding a no-cache flag or introducing dedicated
>>>> __no_cached APIs — would work. However, in my opinion, we should aim to
>>>> use a consistent method across both libnvme 1.x and 2.x versions.
>>>
>>> There will be a lot of API changes for 2.x to address all the silly
>>> mistakes. That's way it will be a major version change.
>>>
>>>> As we discussed during LSFMM, if we plan to implement an "nvme top" command,
>>>> we would need non-cached versions of these APIs even for nvme-cli.
>>>
>>> Yes, that is why I brought up this discussion. For such a command we
>>> would need non cached versions. And I realize that we would need this
>>> feature also for other commands. So it's not just the queue depth which
>>> changes. Maybe we should just not try to add this feature to 1.x and
>>> rather start the 2.x project.
>>>
>>>> So, using the same mechanism for both versions makes sense. Otherwise,
>>>> we’d also have to maintain different logic in nvme top depending on
>>>> the libnvme version, which adds unnecessary complexity.
>>>
>>> I don't see a big problem here. Either use the 1.x or 2.x.
>>
>> Why don't we make this option as non-cached by default?
>> In the end, there is limited usability in having it cached.
> 
> Sure, this is also fine. I suppose there will be some more conversion
> from cached to non-cached necessary for the 'nvme top' feature.

And I dimly remember I did some of this work already during the python
binding work (where some attributes changed during the lifetime of the
tree). Not sure what happened to that, though.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

