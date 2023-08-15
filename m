Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11211C001B0
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Aug 2023 06:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z4odYFRAf0mnDRB+A3xq3whLMLph3njV54CRH8KxPF4=; b=1amWI00BfOQgyc64zIzWRCy5WM
	c05lx9mOW6LIb57mhkkvF1OLK6MMj0r3ckwYRE/RZ9K3pyuQsqxj3ZdZBjZpzGk/FJ01aM+zEHN+D
	vjmfktX81ZryXD/BDJcDGOEiTVjK+eioi+khgyK1t7FDTFwkfEzh4eIkT8IjOpmwb3w4e0b1jVj6T
	IFV3jPztO7J7XOTdozv7/T0UQxRB+Civ4dVnwakzscgYfr0f4pQd2ilqh/81fTKvZRcJ/QRgrnOUL
	7vIw9OAQF5KXz8h2KcN6+5+bMQ6MCWRg0N0SmVt4+wnG/KrCKrR3+UFzlMOAkeAmysB6AKCVCxQMH
	4z8/qzaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVnQ5-000zF2-30;
	Tue, 15 Aug 2023 06:20:45 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVnQ2-000zEK-2I
	for linux-nvme@lists.infradead.org;
	Tue, 15 Aug 2023 06:20:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D20A21992;
	Tue, 15 Aug 2023 06:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692080440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4odYFRAf0mnDRB+A3xq3whLMLph3njV54CRH8KxPF4=;
	b=vtEdqnfwK1QK9BePGHYn84vHHipyqL5S7qBma2OZxEY26dTyYVQyIAJSFETIGuvdqoTBgB
	+7gl4sOME0NQUdgSuTOoqOUtQO86y+FgvG2exbb7BjV7G1d27GeLrcHok7xU8Y/GqTCoCG
	pJo2GdLTyY6w+OaAiO9AEBi7vv1s0Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692080440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4odYFRAf0mnDRB+A3xq3whLMLph3njV54CRH8KxPF4=;
	b=IHpYArTeoTlWy1IjvBeSPc/oq4civzCxSId3lkeuOXzifiQjrbDs1Jv3bDhD/eDw/Wn5tT
	gAuz7w/ZDp6DzjDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 329DC1353E;
	Tue, 15 Aug 2023 06:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id SOMnCzgZ22SnagAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 15 Aug 2023 06:20:40 +0000
Message-ID: <92692ffe-a83a-00a0-553a-7e7a1aa5e23a@suse.de>
Date: Tue, 15 Aug 2023 08:20:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 17/17] nvmet-tcp: peek icreq before starting TLS
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-18-hare@suse.de>
 <304bc2f7-5f77-6e08-bcdb-f382233f611b@grimberg.me>
 <f9ebbd9d-31be-8e2c-f8a2-1f5b95a83344@suse.de>
 <b9ec8b98-dcde-1d89-9431-4799240f0c80@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b9ec8b98-dcde-1d89-9431-4799240f0c80@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_232042_891841_834AAF75 
X-CRM114-Status: GOOD (  15.92  )
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

On 8/14/23 21:05, Sagi Grimberg wrote:
> 
> 
> On 8/14/23 16:18, Hannes Reinecke wrote:
>> On 8/14/23 14:11, Sagi Grimberg wrote:
>>>
>>>> Incoming connection might be either 'normal' NVMe-TCP connections
>>>> starting with icreq or TLS handshakes. To ensure that 'normal'
>>>> connections can still be handled we need to peek the first packet
>>>> and only start TLS handshake if it's not an icreq.
>>>
>>> That depends if we want to do that.
>>> Why should we let so called normal connections if tls1.3 is
>>> enabled?
>>
>> Because of the TREQ setting.
>> TREQ can be 'not specified, 'required', or 'not required'.
>> Consequently when TSAS is set to 'tls1.3', and TREQ to 'not required' 
>> the initiator can choose whether he wants to do TLS.
>>
>> And we don't need this weird 'select TREQ required' when TLS is active;
>> never particularly liked that one.
> 
> The guideline should be that treq 'not required' should be the explicit
> setting in tls and not the other way around. We should be strict by
> default and permissive only if the user explicitly chose it, and log
> a warning in the log.

Whatever you say. I'll modify the patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


