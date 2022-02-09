Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB666C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 08:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qlret34MgdjOqXHLKX4a59JN+cV+WeqzRrgxpMb9OkA=; b=1a4ifs8rPjUqdmjaQywchWno/3
	GsR7xWTob5tWbXdK6z0ehJ/wTm5Q3otmb+HJwgT69NeWgvxLDt0Rbs/ExgYSWeA/3bHcC00GaYqmF
	Yibch/eJCGqAnhwLQoFChzMOtgxGQ4NxeXmXs1My8eWXV5PEUW2KSJsEp3YAo6aq7QnJaejf8+qRX
	RqhqSC5oKv4yF2NhE2A97hkCGzt27bPz/snbwAoqNGucyt44Spm9lUg6BHqUVMwt3fWsZ5MCHBKvO
	WbfSaXWx2ywx25/M8UdSHaXBfhU3Sd5vOeHDnbsxelKFscWYOx7ifO0T86u0QqLkR8vdPbBTYKD6p
	UWO27tBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHifA-00GiP0-U8; Wed, 09 Feb 2022 08:49:20 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHif7-00GiOD-Si
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 08:49:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 93A42210F6;
 Wed,  9 Feb 2022 08:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644396556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qlret34MgdjOqXHLKX4a59JN+cV+WeqzRrgxpMb9OkA=;
 b=2INmDdrefECWfJZDH2QPx2avFXtKQlb325lhgyTuwhAYTgH89AbATEaWGkEYBBi6UW+mKE
 jrQcu3ItVc0mjgAJSZWjrzwrPCKLbD+VYBclYk1OytY9Aa0WGDo5piT6aN32S2r3f3SFJ7
 87jEtBms4Gq/PEZokyOa20jv19RRRMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644396556;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qlret34MgdjOqXHLKX4a59JN+cV+WeqzRrgxpMb9OkA=;
 b=UF3WjtdNp+nTFeHxvbScarC9hYAXyHBt8+S4aMVfTJ8On5f4kQRktLMx0jTZ89RjEhspQ7
 Afh4sUNpEswz0KDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 787E71332F;
 Wed,  9 Feb 2022 08:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SDgpHAyAA2JaLgAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 09 Feb 2022 08:49:16 +0000
Message-ID: <7bef474d-f6c4-0ecc-3a5b-44a310e2e026@suse.de>
Date: Wed, 9 Feb 2022 09:49:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nvme-multipath: add an 'ana_groups_only' module option
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20220207100005.34404-1-hare@suse.de>
 <20220209080747.GA9851@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220209080747.GA9851@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_004918_114903_53D89336 
X-CRM114-Status: GOOD (  20.56  )
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

On 2/9/22 09:07, Christoph Hellwig wrote:
> On Mon, Feb 07, 2022 at 11:00:05AM +0100, Hannes Reinecke wrote:
>> On large installations the ANA log buffer can be exceedingly large;
>> we've come across a controller with 49 ANA Group Descriptors and
>> 65536 namespaces, resulting in an ANA buffer with an order-7 allocation.
>> And this is just to validate that the namespace ID is _really_listed
>> in the log page.
>> So to avoid an overly large memory allocation we can leverage the
>> 'RGO' bit when retrieving the ANA log page, and check whether the
>> ANA group ID from the namespace is found in the ANA descriptors.
>> That cuts down the memory allocation, and provides the same result.
>> But to be on the safe side I've added a module option 'ana_groups_only'
>> to switch between modes.
> 
> How is this supposed to work?  We'll fail to see what namespaces
> the change applies to.
> 
How so?
I'm just reverting the check; instead of having the nsid listed in the 
ana log page and check for a match between the nsids we now check for a 
match between the group id in the ana log page and the ana grpid from 
the 'identify namespace' output.
So I'm still able to identify which namespace this change belongs to.

> So in doubt fix the controller config to be less broken (and say hello
> to NetApp and explain them they do not need more namespace for more
> performance), and if that fails switch to a vmalloc allocation for
> the buffer.

Curiously it was _not_ NetApp, but I'll happily explain this to the 
reporters :-)

But I'll have a look a vmalloc anyway.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

