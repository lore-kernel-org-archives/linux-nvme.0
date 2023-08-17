Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5A9EB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 10:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CCxTGu3J6x3P2cKvWDCPKvnd5drw9N7zGQkN4aFDUEM=; b=kb5Gn0/TzaouAuNdMS1LzOrlfx
	ItQOWECpFxpS51JpEZ+JYZ1g+N8Ir6ZZhpalap4O0TdxbzdbIF2FYlF+sBHsbD63ohY4YN/iVljoh
	RknNcuYiE6SZ12dO76cUAgVbbFy9LbfPppji8dYyLWltKcF3qC6ORL5wTUhWlHJdvYTYbV9R2GLNo
	LV7WA6Omu9UQIyJnVymrz8fu76ETHRNsyW56DmocJdJJFwZpORjAa7Ksc44IKEqMImPR+/ShTGxEY
	QcEmQhpDKn+EUkh6zd8jIlLtjlZb9oQvaOpgxbySHfSKBhamotaiRSpTL/j3/qxZhzekeUnec6lU8
	69Xaii8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWaYC-006CYC-2q;
	Thu, 17 Aug 2023 10:48:24 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWaY9-006CWm-2x
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 10:48:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7897B21871;
	Thu, 17 Aug 2023 10:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692269298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCxTGu3J6x3P2cKvWDCPKvnd5drw9N7zGQkN4aFDUEM=;
	b=dLfklbn0t/HSPjDOiFwaYoUuL3RgA9VDPxXqmIktZkvk1n738QpKyNOdB2V16zjQgt5YC/
	0TX26t+O1gFPslET9ko50knffeeQfa9zrpFBXvOLd2wWS2GNkU0ROAShpPZJlyY3UAG3gU
	Lh32H1Qk8Ewq61vH/WPFhttJ37BxHVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692269298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCxTGu3J6x3P2cKvWDCPKvnd5drw9N7zGQkN4aFDUEM=;
	b=st1y5AoQe4DrfiBCWJe9Oj/Jk0tqEfDbZEAd+9fj4bwgioY2q2KRYr0kzXEVmJbDi5bGzw
	jLJko8UX+qc+n5Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FCBB1392B;
	Thu, 17 Aug 2023 10:48:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Nc/UBfL63WSOJQAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 17 Aug 2023 10:48:18 +0000
Message-ID: <69b5e07b-f16a-0a9e-bee2-28877dbecab3@suse.de>
Date: Thu, 17 Aug 2023 12:48:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH rfc 6/6] nvme-fabrics: expose support for traddr as dns
 names to userspace
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <20230724092023.708335-7-sagi@grimberg.me>
 <7d60e267-be0a-41ff-8015-d3440b6eca2c@suse.de>
 <433182d8-c57e-2e51-2692-02ac8b474bf2@grimberg.me>
 <8e72f698-af99-c8a4-a672-d51d28ee7a36@grimberg.me>
 <cc448d32-f3f1-0929-18d4-15186adeac01@suse.de>
 <b4fe7c1f-1581-bad2-9203-6f4c87d6a599@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b4fe7c1f-1581-bad2-9203-6f4c87d6a599@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_034822_096294_6B33D787 
X-CRM114-Status: GOOD (  20.46  )
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

On 8/17/23 12:37, Sagi Grimberg wrote:
> 
>> [ .. ]
>>>> So I figured that the current approach would be preferable if
>>>> we accept how to expose that for a given kernel/driver, we can
>>>> accept dns names, or we cannot.
>>>>
>>>> What do others think? Christoph? Keith? Chaitanya?
>>>
>>> Anyone has feedback here?
>>>
>>> Seems that we want this, but the question is how to expose
>>> a new format of traddr (now can be a dns name) to userspace?
>>
>> Or have a new token 'traddr_dns' (instaed of 'traddr'), which would
>> hold the dnsname instead of the ip address.
>> And reject inputs where both are set.
>> Hmm?
> 
> I listed that as an option, you should read it.
> There are some disadvantages in doing that, it needs to co-exist
> with the mandatory (today) traddr, which is now will be mandatory
> only for fc. And also now the user will need to decide a conflicting
> existing functionality in nvme-cli that today accept dns names as
> a format to traddr, but now will need a different argument for
> passing it to the kernel.
> 
> Anyway, its possible, but more complicated IMO.
> 
> Plus, I also think that it can be useful for the kernel to signal
> capabilities and support for things that are not only valid tokens.

I cross-checked with nvme-cli; there we read the list of available 
tokens upon failure to give the user a hint which arguments are 
supported by any given kernel.
So by that regard it should be fine to just add 'dns' as a parameter
here.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


