Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E240EC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 23 May 2022 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TIdTbTeN1cOIxQYU/2ocG9YRcAOC4CL4sPwksPnpWrs=; b=tPWUlAFuaV7tT9zBaPlpiFgCtm
	fR8/izg7sd08jKHCtp5iTRBy4aAzJHjrjU0K1oAqWdmc931eLUOJWbgI6xBT9DYooAnIJ8lU8p2lW
	cXwaFeOVYHFBtMT9s6CT4cXfUrXR9mbHhq5nyLi2CMei5j7KFjJDvdTWruXMeg9KGhwx/RQ815h/z
	NR+tz2IVKDJWCHCadtH+ihFJjOTQsbX4VuEMQ+CqLr78zXGpFjQhssY0pu8xpY/0SGRGn7MaaQeub
	jFwZc6wUCQ3I8x49iCBVFYWvFtw73iQ7pjoREe7nuXSHDs5IEeH2ZXJlj/ju68iTlMkg1tDIJDDEh
	wtccLYeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nt8cz-004cMI-UR; Mon, 23 May 2022 14:01:45 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nt8cv-004cK9-S1
 for linux-nvme@lists.infradead.org; Mon, 23 May 2022 14:01:43 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BAA3F1F923;
 Mon, 23 May 2022 14:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1653314499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIdTbTeN1cOIxQYU/2ocG9YRcAOC4CL4sPwksPnpWrs=;
 b=R6SOUh72aJ9OOa7Eam7tiH6JgdNoakTBi5OY+cez3/BBAxF5yCVTjSCyNZsQC7qWbiZ6Rz
 hCv9+TfD24hd+2ZqXVjhqJ2InLPmf4mFM18eJd43n/Gk2doapV7ciNV98WpoxpB3LFoG71
 rquC+nlsS7qDj7iCogqV5noEu4ugMQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1653314499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIdTbTeN1cOIxQYU/2ocG9YRcAOC4CL4sPwksPnpWrs=;
 b=7ez5R1VorGCyTiEE7rLOKotodsyVLSggiUhuayS566E9fzvgcRZ+wgmvtsX2C71d6vvuFY
 9q6KOGlSHFcssMBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 491F1139F5;
 Mon, 23 May 2022 14:01:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mJeNDcOTi2KUawAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 23 May 2022 14:01:39 +0000
Message-ID: <e749bb3e-2ff7-23f5-9f5f-974c986845b6@suse.de>
Date: Mon, 23 May 2022 16:01:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220519062617.39715-1-hare@suse.de>
 <20220519062617.39715-2-hare@suse.de>
 <7827d599-7714-3947-ee24-e343e90eee6e@grimberg.me>
 <96a3315f-43a4-efe6-1f37-0552d66dbd85@suse.de>
 <96722b37-f943-c3e4-ee6a-440f65e8afca@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/3] nvme-tcp: spurious I/O timeout under high load
In-Reply-To: <96722b37-f943-c3e4-ee6a-440f65e8afca@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220523_070142_131874_0EAC4C58 
X-CRM114-Status: GOOD (  34.66  )
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

On 5/23/22 15:36, Sagi Grimberg wrote:
> 
>>> The patch title does not explain what the patch does, or what it
>>> fixes.
>>>
>>>> When running on slow links requests might take some time
>>>> for be processed, and as we always allow to queue requests
>>>> timeout may trigger when the requests are still queued.
>>>> Eg sending 128M requests over 30 queues over a 1GigE link
>>>> will inevitably timeout before the last request could be sent.
>>>> So reset the timeout if the request is still being queued
>>>> or if it's in the process of being sent.
>>>
>>> Maybe I'm missing something... But you are overloading so much that you
>>> timeout even before a command is sent out. That still does not change
>>> the fact that the timeout expired. Why is resetting the timer without
>>> taking any action the acceptable action in this case?
>>>
>>> Is this solving a bug? The fact that you get timeouts in your test
>>> is somewhat expected isn't it?
>>>
>>
>> Yes, and no.
>> We happily let requests sit in the (blk-layer) queue for basically any 
>> amount of time.
>> And it's a design decision within the driver _when_ to start the timer.
> 
> Is it? isn't it supposed to start when the request is queued?
> 
Queued where?

>> My point is that starting the timer and _then_ do internal queuing is 
>> questionable; we might have returned BLK_STS_AGAIN (or something) when 
>> we found that we cannot send requests right now.
>> Or we might have started the timer only when the request is being sent 
>> to the HW.
> 
> It is not sent to the HW, it is sent down the TCP stack. But it is not
> any different than posting the request to a hw queue on a pci/rdma/fc
> device. The device has some context that process the queue and sends
> it to the wire, in nvme-tcp that context is io_work.
> 
>> So returning a timeout in one case but not the other is somewhat erratic.
> 
> What is the difference than posting a work request to an rdma nic on
> a congested network? an imaginary 1Gb rdma nic :)
> 
> Or maybe lets ask it differently, what happens if you run this test
> on the same nic, but with soft-iwarp/soft-roce interface on top of it?
> 
I can't really tell, as I haven't tried.
Can give it a go, though.

>> I would argue that we should only start the timer when requests have 
>> had a chance to be sent to the HW; when it's still within the driver 
>> one has a hard time arguing why timeouts do apply on one level but not 
>> on the other, especially as both levels to exactly the same (to wit: 
>> queue commands until they can be sent).
> 
> I look at this differently, the way I see it, is that nvme-tcp is
> exactly like nvme-rdma/nvme-fc but also implements context executing the
> command, in software. So in my mind, it is mixing different layers.
> 
Hmm. Yes, of course one could take this stance.
Especially given the NVMe-oF notion of 'transport'.

Sadly it's hard to reproduce this with other transports, as they 
inevitably only run on HW fast enough to not directly exhibit this 
problem (FC is now on 8G min, and IB probably on at least 10G).

The issue arises when running a fio test with a variable size
(4M - 128M), which works on other transports like FC.
For TCP we're running into the said timeouts, but adding things like 
blk-cgroup or rq-qos make the issue go away.

So question naturally would be why we need a traffic shaper on TCP, but 
not on FC.

>> I'm open to discussion what we should be doing when the request is in 
>> the process of being sent. But when it didn't have a chance to be sent 
>> and we just overloaded our internal queuing we shouldn't be sending 
>> timeouts.
> 
> As mentioned above, what happens if that same reporter opens another bug
> that the same phenomenon happens with soft-iwarp? What would you tell
> him/her?

Nope. It's a HW appliance. Not a chance to change that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

