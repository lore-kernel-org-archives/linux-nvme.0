Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D63AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 08:37:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E886128C
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 08:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 16E886128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FNzaO2NdNO35Q5zsds/WUeSZLRrEO0iCHweDNIy+ppA=; b=OryVxWbpFs9qf/mCDy2jMbGT9e
	A2hSaUAhSdICFBj54+nhxsg0pqb0+EWhFUqKVvd/RtEiQlssUGJZhyQbzeGwQixIcz8cMSUtBFDuD
	VzmAu2pIAj88FGC4RHs6AAw8dAK3i4YkoKmeh8s2uQFRAiLlnpNV7nDcxZn3RxeW8xTB/f2SMNlFJ
	MrdoavnZp5/jIzPNYkEkV6+Ouj0L4A9+kXsRna/CAoMh12o6gMQ+ok/MzpvJKyI4nqPrGLHukDBB1
	lT5IlGvzu+E0h35+BQ8ZfvIoVsyj4yydIXYl7d4UwvOtIQ5uQyVRk7LbIhbLfuMVnhwOIW0/Yg/GZ
	290EbQmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmXUa-00Ei7u-C5; Mon, 15 Nov 2021 08:37:32 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmXUX-00Ei6t-3n
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 08:37:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 19E1B2190C;
 Mon, 15 Nov 2021 08:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636965447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FNzaO2NdNO35Q5zsds/WUeSZLRrEO0iCHweDNIy+ppA=;
 b=MlTTR3U4xS+ibMXXKMDNdfavXb3ZNNPjGO8MFZrugCO6iuT8MqgcDpMgi4UhTwP8xe7OZs
 Cp50e/wnD8NiVT9xaPus/b7rHcco+EtYVVilVrh/d9uF1jNCO/OHwOzwmAwURiOGxBepM6
 V8CujexUZTaBhA+KxPKpMZ9/nhAkB7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636965447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FNzaO2NdNO35Q5zsds/WUeSZLRrEO0iCHweDNIy+ppA=;
 b=OczHAkvc9wvxyWNIqYiO0J2Gcd87CP9XyUsRZIXrym7U/DpMd/xeZ9JRKKvGct4VXhFKAs
 cajYtpy24/0D9iCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDB6113B69;
 Mon, 15 Nov 2021 08:37:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jDymOEYckmHybQAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 15 Nov 2021 08:37:26 +0000
Subject: Re: [PATCH 1/6] nvmeof-tcp/001: simple test for nvmeof-tcp connection
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211112144510.98523-1-hare@suse.de>
 <20211112144510.98523-2-hare@suse.de>
 <de1a1ff4-0c1a-6642-9d94-30b3d1cb0406@grimberg.me>
 <6a8fd808-8a92-3215-597e-7e094e753a9a@suse.de>
 <2679a2d0-7786-026d-c00c-8fc02a78c7a9@grimberg.me>
 <0d3e494e-aba0-0c70-4b1f-91887820ff86@suse.de>
 <8f3c6dd9-104e-8f0f-78c4-374684743cd5@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a89ebb9f-0926-e8a3-9b35-ecc1d3083642@suse.de>
Date: Mon, 15 Nov 2021 09:37:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8f3c6dd9-104e-8f0f-78c4-374684743cd5@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_003729_334440_9ADB2092 
X-CRM114-Status: GOOD (  32.28  )
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

On 11/15/21 9:12 AM, Sagi Grimberg wrote:
> 
>>> It is unclear to me why the separate directory is needed. But at least
>>> call it something else if you must have it.
>>>
>>>> Especially as I still fail to see the actual use-case for using
>>>> in-band authentication _without_ encryption.
>>>
>>> Not sure what you mean. For the same use-case that iscsi chap exists
>>> for. The secrets are pre-shared.
>>>
>> And that's the use case I don't really get; the authentication is done
>> only once during connection establishment, and then completely ignored
>> for the remainder of the session.
> 
> I have a different view on this. Authentication isn't really related to
> the datapath, but really only relevant to the queue establishment.
> 
>>
>>> Perhaps you can explain? My understanding is that the extension for
>>> nvme-tcp TLS based auth is to avoid maintaining two sets of pre-shared
>>> keys, i.e just maintain the TLS ones and not the dhchap ones. But maybe
>>> I am missing something.
>>>
>> Yes, and no.
>> Technically TLS is independent from authentication, and as such you
>> can 'just' use encryption.
>> But if you want to have both there is the so-called secure
>> concatenation, which allows you to use the negotiated shared key from
>> authentication as PSK for TLS.
> 
> Well, TLS is a longer journey for a number of reasons which I won't
> elaborate here.
> 
Quite.

>> And that's where I think the real value lies for authentication; you
>> precisely do _not_ have to maintain two sets of keys.
> 
> I can't say I completely agree with you. There are means today to
> encrypt data over the wire. Granted, it will negate possible data
> reduction gains, but still a mitigation exists.
> 
> On the other hand, today any unauthenticated host can connect to
> any fabrics controller, which is a problem. I don't think you should
> minimize the magnitude of your contribution as this is a real issue
> with nvmeof acceptance in enterprise environments.
> 
That why I always took care to state that it's _my_ view.
Security is still a rather new topic to me, and as such quite some
techniques used here (derive key (a) from key (b) which is derived from
key (c) etc) feel rather redundant to me.
So there's a bit of a learning curve ahead :-)

> I do agree that when TLS is used, it is indeed very useful to not
> have to maintain two sets of pre-shared secrets, but I don't think
> that there is no use-case for inband authentication in the absence
> of TLS.
> 

Oh, surely not. I have been assured from several parties that they want
to use authentication, so who am I to argue with them :-)
And anyway, motivation was to have a working implementation before HW
vendors have a chance to mess things up :-)

>>
>>>> We could rename it to nvmeof-auth, though.
>>>
>>> or just add it as more tests under nvme (or create a subdirectory).
>>>
>> Sure we can. I just found it easier to create my own directory,
>> especially seeing that the nvme subdir has the largest number of tests
>> already.
>> But if you prefer I can move it under the 'nvme' directory.
> 
> I think that it would definitely be an improvement, also because people
> usually run the nvme directory tests which is nice and simple, we should
> strive to keep it this way.

Okay, will be doing so.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

