Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2715C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 23 May 2022 09:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bxNLCPDxsf4KmuDQOamyF/4TV9C2f2azPeFqk5iLLqE=; b=epZrnC8aKvo2JCOsk+FKiwtCFW
	9FTEBNoX5yRvBuHKV05xjXG1XhyOMRIeFltHiEY7B6ndmDI1FHL4SUcrdgyqWt71VH8C4Xhz3LhP4
	r0BOMK8g5VBBTTnWAFVOHag60mSR0Y4J0xUrpmo6ZwG6o1XuZw7WCSW7VawqKaB9eZGK7R0XvFL1R
	2hHxghUm6oO4ANf+TMIqz26U14r7Nfvi2Vrmxgb383dLjpF4WT0NIPFUd+DD/fAYLoWnO4upyCvNC
	qX/JKDY0U4FCJHfVNAq83MktPFcoHhNDK2PxR6GNIcVx5C8jpqSWeC29JbPcTW3fj6wwxlackupN4
	8jw2nBbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nt4NN-002qhb-PT; Mon, 23 May 2022 09:29:21 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nt3eN-002WY2-0H
 for linux-nvme@lists.infradead.org; Mon, 23 May 2022 08:42:52 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B6C9421A1F;
 Mon, 23 May 2022 08:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1653295366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxNLCPDxsf4KmuDQOamyF/4TV9C2f2azPeFqk5iLLqE=;
 b=o9TlpAIEL+dVG/ucPgtunKxpluqwWKDmqPKlRtScAlw3HrOx2OH9jPTGG4bWhTh6JV8ekX
 df7H0Ht8cDI0nQGROvqQmRyLdvso3qEsv+mNKmAG5ImkYUHh/XTAFwM+YMyyz+kLRFpsR2
 BxxLdfRW98pzNcjLFYn5nORvogvU1so=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1653295366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxNLCPDxsf4KmuDQOamyF/4TV9C2f2azPeFqk5iLLqE=;
 b=i7ClTofkq30GIoq/1r1LKrxue5xC5MixqSCm8gyFxAMwaP81o0sZM5S8LacM5fhPTe1n0L
 /Ho79zp06myHiaCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 850CC13AF4;
 Mon, 23 May 2022 08:42:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id USbSHAZJi2JTSgAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 23 May 2022 08:42:46 +0000
Message-ID: <96a3315f-43a4-efe6-1f37-0552d66dbd85@suse.de>
Date: Mon, 23 May 2022 10:42:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220519062617.39715-1-hare@suse.de>
 <20220519062617.39715-2-hare@suse.de>
 <7827d599-7714-3947-ee24-e343e90eee6e@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/3] nvme-tcp: spurious I/O timeout under high load
In-Reply-To: <7827d599-7714-3947-ee24-e343e90eee6e@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220523_014251_295285_1FE87D3D 
X-CRM114-Status: GOOD (  23.85  )
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

On 5/20/22 11:05, Sagi Grimberg wrote:
> The patch title does not explain what the patch does, or what it
> fixes.
> 
>> When running on slow links requests might take some time
>> for be processed, and as we always allow to queue requests
>> timeout may trigger when the requests are still queued.
>> Eg sending 128M requests over 30 queues over a 1GigE link
>> will inevitably timeout before the last request could be sent.
>> So reset the timeout if the request is still being queued
>> or if it's in the process of being sent.
> 
> Maybe I'm missing something... But you are overloading so much that you
> timeout even before a command is sent out. That still does not change
> the fact that the timeout expired. Why is resetting the timer without
> taking any action the acceptable action in this case?
> 
> Is this solving a bug? The fact that you get timeouts in your test
> is somewhat expected isn't it?
> 

Yes, and no.
We happily let requests sit in the (blk-layer) queue for basically any 
amount of time.
And it's a design decision within the driver _when_ to start the timer.
My point is that starting the timer and _then_ do internal queuing is 
questionable; we might have returned BLK_STS_AGAIN (or something) when 
we found that we cannot send requests right now.
Or we might have started the timer only when the request is being sent 
to the HW.
So returning a timeout in one case but not the other is somewhat erratic.

I would argue that we should only start the timer when requests have had 
a chance to be sent to the HW; when it's still within the driver one has 
a hard time arguing why timeouts do apply on one level but not on the 
other, especially as both levels to exactly the same (to wit: queue 
commands until they can be sent).

I'm open to discussion what we should be doing when the request is in 
the process of being sent. But when it didn't have a chance to be sent 
and we just overloaded our internal queuing we shouldn't be sending 
timeouts.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

