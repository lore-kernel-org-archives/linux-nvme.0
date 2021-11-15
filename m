Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060B7C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 06:57:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7673604DC
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 06:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7673604DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DK1a7ujIVQlbAAlM8Fnoy66BN9PHul23RtfCSdKo94A=; b=mRc2DY5CsMaLxPOs/eUyq945qy
	VSU0TwSqbm/35GjFIHj1+B9XmAfeHL1nK6qtPR11a2ilBVBuWloXuLVl8CX+3HaYVMhUM8biDN9Vw
	xHPY44WBw9sdyRhJRm70iAy6M1TIKwPUpdF2N21N/WgzgcGu/JHOraF89vu2gcP3XkVnahZrjJCK6
	lfqFBH7h5mXxr1/mJ3QiYqxr3MwiAZ6xSNMJj0z2UOqWL99I/Q7MMUSrQTWI7czlG6zdaCLzUbgGC
	ABiBY4gRVpfzH0ov6tPQpxlT2M1RJY3MIo1SJq/oNIPEiM/hp8NyCPJ8WQjxgu6c7Gh9lQjQAKw7R
	gslSd9Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmVvL-00ETRq-BA; Mon, 15 Nov 2021 06:57:03 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmVvI-00ETRB-4c
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 06:57:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B65F2190C;
 Mon, 15 Nov 2021 06:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636959418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DK1a7ujIVQlbAAlM8Fnoy66BN9PHul23RtfCSdKo94A=;
 b=cunej5g5TtXbpUu1jmj8jvUVfDIJRhtuD+QJuHYRHXhEDHCm8XqjHkmVOWCLt5A8cAOohf
 1Uai6UH9EC5dBvayowCM2CIrwbN3BObXRkz4scwzIaML72JWxwUXMqaJWrSFlmmf+2FBYX
 avbOuMh60YyB/e3hKaYNLYdifofk/Us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636959418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DK1a7ujIVQlbAAlM8Fnoy66BN9PHul23RtfCSdKo94A=;
 b=TxkF6//FCXWzOWk3I4DknhwoINzoaYYrmmK3cIUYXODx7xkRPo82+E32mdD6tLRz+V5ovw
 7Tje1nsLZwZYFwBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B83213AEF;
 Mon, 15 Nov 2021 06:56:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SDHZELoEkmFMTAAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 15 Nov 2021 06:56:58 +0000
Subject: Re: [PATCH 1/6] nvmeof-tcp/001: simple test for nvmeof-tcp connection
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211112144510.98523-1-hare@suse.de>
 <20211112144510.98523-2-hare@suse.de>
 <de1a1ff4-0c1a-6642-9d94-30b3d1cb0406@grimberg.me>
 <6a8fd808-8a92-3215-597e-7e094e753a9a@suse.de>
 <2679a2d0-7786-026d-c00c-8fc02a78c7a9@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0d3e494e-aba0-0c70-4b1f-91887820ff86@suse.de>
Date: Mon, 15 Nov 2021 07:56:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2679a2d0-7786-026d-c00c-8fc02a78c7a9@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211114_225700_376751_5B9D6F42 
X-CRM114-Status: GOOD (  25.82  )
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

On 11/14/21 3:45 PM, Sagi Grimberg wrote:
> 
> 
> On 11/14/21 3:50 PM, Hannes Reinecke wrote:
>> On 11/14/21 11:31 AM, Sagi Grimberg wrote:
>>>
>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>> ---
>>>>   tests/nvmeof-tcp/001     |  55 +++++++
>>>>   tests/nvmeof-tcp/001.out |   6 +
>>>>   tests/nvmeof-tcp/rc      | 347 
>>>> +++++++++++++++++++++++++++++++++++++++
>>>
>>> Why another directory? why nvmeof-tcp? what prevents inband-auth
>>> to be tested with loop/rdma?
>>>
>> Technically, nothing.
>> But as I'll be looking into tcp in-band _encryption_ as the next step 
>> I found it logical to have a disinct directory.
> 
> It is unclear to me why the separate directory is needed. But at least
> call it something else if you must have it.
> 
>> Especially as I still fail to see the actual use-case for using 
>> in-band authentication _without_ encryption.
> 
> Not sure what you mean. For the same use-case that iscsi chap exists
> for. The secrets are pre-shared.
> 
And that's the use case I don't really get; the authentication is done 
only once during connection establishment, and then completely ignored
for the remainder of the session.

> Perhaps you can explain? My understanding is that the extension for
> nvme-tcp TLS based auth is to avoid maintaining two sets of pre-shared
> keys, i.e just maintain the TLS ones and not the dhchap ones. But maybe
> I am missing something.
> 
Yes, and no.
Technically TLS is independent from authentication, and as such you can 
'just' use encryption.
But if you want to have both there is the so-called secure 
concatenation, which allows you to use the negotiated shared key from 
authentication as PSK for TLS.

And that's where I think the real value lies for authentication; you 
precisely do _not_ have to maintain two sets of keys.

>> We could rename it to nvmeof-auth, though.
> 
> or just add it as more tests under nvme (or create a subdirectory).
> 
Sure we can. I just found it easier to create my own directory, 
especially seeing that the nvme subdir has the largest number of tests 
already.
But if you prefer I can move it under the 'nvme' directory.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

