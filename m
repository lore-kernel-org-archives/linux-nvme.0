Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46957C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 23 May 2022 16:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yrsenOxrXy9nMdACylnr+sX53uxoGGENf9+HOtweCr8=; b=M0fXjhL2QGjM4UEgHHkf//UKZZ
	jnJ65iifpaB1+d9UXQL/cNxV6w+7i5LPcv4orHcSKoC30Auk6/rflYqdkTY7z/tJi1+WOiqeLqaQc
	CzO28HxMm7wNY8abAlHP5Kj9kElE2HZXahu5USHpyrGytCB4wXvCrK1FixYjeKMEcWlfT53m/mzCW
	YI2LZwIA5vC2PHeY78cl1PtDeXeu1yWJDrCuGHoqN/NNQARh0P+9pzEwYF95G4NLf7vFade22oo7n
	+dSpx+11kgTVvBJKATrYnSTd2kzaA7mpPexNZEk1ERAPLKBwQ3Rn7CjUhNYdBjgh+L1YkC5JX/QY6
	Rw062pTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntAav-0057xm-8T; Mon, 23 May 2022 16:07:45 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntAas-0057wU-PR
 for linux-nvme@lists.infradead.org; Mon, 23 May 2022 16:07:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD4CB21AE4;
 Mon, 23 May 2022 16:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1653322058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yrsenOxrXy9nMdACylnr+sX53uxoGGENf9+HOtweCr8=;
 b=u7xwGUeq7iG+BzzshlnNDbaFRvqhK1lzfl6RuelwLIqEIuEfaXzjCbPIxYKEdVrAZ9HgzQ
 72sYm/5MxW1w6qh2KDNT67Q0n4g+CkrtGd/FZqZPyFckcdmx4vmNx3ud3CQQI5xUnsoE67
 zJHVgywcl5eLyM1htshr9/KdPeDh+sY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1653322058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yrsenOxrXy9nMdACylnr+sX53uxoGGENf9+HOtweCr8=;
 b=TZLN498Bfxpb3cgdAnAaCahoRJZLpgNscK2pmK4Orqwm4h5rzHTBoLRDOcyD6cqNMXpqi9
 OlU6O+O+1XapMkCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6999139F5;
 Mon, 23 May 2022 16:07:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zxh5Mkmxi2L3KAAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 23 May 2022 16:07:37 +0000
Message-ID: <919bfaa2-a35d-052a-1d35-9fdd8faa0d3f@suse.de>
Date: Mon, 23 May 2022 18:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/3] nvme-tcp: spurious I/O timeout under high load
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220519062617.39715-1-hare@suse.de>
 <20220519062617.39715-2-hare@suse.de>
 <7827d599-7714-3947-ee24-e343e90eee6e@grimberg.me>
 <96a3315f-43a4-efe6-1f37-0552d66dbd85@suse.de>
 <96722b37-f943-c3e4-ee6a-440f65e8afca@grimberg.me>
 <e749bb3e-2ff7-23f5-9f5f-974c986845b6@suse.de>
 <7ec792e3-5110-2272-b6fe-1a976c8c054f@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <7ec792e3-5110-2272-b6fe-1a976c8c054f@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220523_090743_015169_F80107A3 
X-CRM114-Status: GOOD (  21.57  )
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

On 5/23/22 17:05, Sagi Grimberg wrote:
> 
[ .. ]
>>>> I'm open to discussion what we should be doing when the request is 
>>>> in the process of being sent. But when it didn't have a chance to be 
>>>> sent and we just overloaded our internal queuing we shouldn't be 
>>>> sending timeouts.
>>>
>>> As mentioned above, what happens if that same reporter opens another bug
>>> that the same phenomenon happens with soft-iwarp? What would you tell
>>> him/her?
>>
>> Nope. It's a HW appliance. Not a chance to change that.
> 
> It was just a theoretical question.
> 
> Do note that I'm not against solving a problem for anyone, I'm just
> questioning if increasing the io_timeout to be unbound in case the
> network is congested, is the right solution for everyone instead of
> a particular case that can easily be solved with udev to make the
> io_timeout to be as high as needed.
> 
> One can argue that this patchset is making nvme-tcp to basically
> ignore the device io_timeout in certain cases.

Oh, yes, sure, that will happen.
What I'm actually arguing is the imprecise difference between 
BLK_STS_AGAIN / BLK_STS_RESOURCE as a return value from ->queue_rq()
and command timeouts in case of resource constraints on the driver 
implementing ->queue_rq().

If there is a resource constrain driver is free to return 
BLK_STS_RESOURCE (in which case you wouldn't see a timeout) or accept 
the request (in which case there will be a timeout).

I could live with a timeout if that would just result in the command 
being retried. But in the case of nvme it results in a connection reset 
to boot, making customers really nervous that their system is broken.

And having a workload which can generate connection resets feels like a 
DoS attack to me; applications shouldn't be able to do that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

