Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAF6C0015E
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Aug 2023 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gX40rMQAaWgBzWqEjHojXs9AYynLgK+SuvL/w/s5uR8=; b=vb5oNU0KNuhnhOj6aib4IjO3Ce
	TQFkwYGRxViwSMFALrIBSTT2Ofh99fgPnYD+4pbqSYOPC9wyKxVI190u64yd2rOW/1W81g5RS9kyZ
	AMjKqX1NLFLwo7lWcZKWsXvUnlxZ/0MjKc6cCetfx1BdzCFQUSL2zh1WDkOAk9tmfApAvWw3wuCFM
	OJRA9MjPwSVNlkYKZIRtWErukkSrIUM0+qnrrD4IMM6YAMJNOLSRqkjrsuBI+IPFiRgLo85KweBGP
	BGOobf+4B8CvIKB6YZ+LX/V4EXlw8tKkUT/cXevO2ii7jt5CJvRh1QzAuz9zq8YxpMVMw/kl7C8UL
	vkEle6sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVvbR-001ohv-18;
	Tue, 15 Aug 2023 15:05:01 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVvbO-001ohE-2s
	for linux-nvme@lists.infradead.org;
	Tue, 15 Aug 2023 15:05:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 454B9218FB;
	Tue, 15 Aug 2023 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692111895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gX40rMQAaWgBzWqEjHojXs9AYynLgK+SuvL/w/s5uR8=;
	b=AwGZCyshceD92yFsUZy3GAfBVJCrm7QgEMTE0ITvIazOrjVLAYcd+pBrYP7n6EPbf4RpyO
	UX1mlyoSdmP5reTyFholEqpFBZ9pKxLaYDJoGJ5/YW0nKgBMjeUMi3UFOt6GDPiW8TADzC
	cX3KWVZ+LLINHz8e7GUAoe9WIoePm70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692111895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gX40rMQAaWgBzWqEjHojXs9AYynLgK+SuvL/w/s5uR8=;
	b=wV4tB+M0eR1RdycWinodPVUbscKXetVGTvLPuuFenlGufu3uv+NZrY/7yI+u44MiHSvvi8
	XcLfHJgjtYm0g9Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7E0D13909;
	Tue, 15 Aug 2023 15:04:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /TcINxaU22TvZgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 15 Aug 2023 15:04:54 +0000
Message-ID: <6fb98e7d-d28f-71d7-ee58-0ca7a013e8d8@suse.de>
Date: Tue, 15 Aug 2023 17:04:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 15/17] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-16-hare@suse.de>
 <cf21000c-177e-c882-ac30-fe3190748bae@grimberg.me>
 <bebf00fb-be2d-d6da-bd7f-4e610095decc@suse.de>
 <a7e01b78-52ba-9576-6d71-6d1f81aecd44@grimberg.me>
 <fdb8caf7-78cc-c39b-3dda-2d9db4128a34@suse.de>
 <ce3453f8-807b-301c-f18a-3d7a7bc0bca7@grimberg.me>
 <1eca42a4-ee8e-dff3-adb0-0f4799e4f96f@suse.de>
 <6a0e9122-87f3-b0e9-0a54-dbcc4cd9d819@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <6a0e9122-87f3-b0e9-0a54-dbcc4cd9d819@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230815_080459_090777_AA3DE74C 
X-CRM114-Status: GOOD (  12.20  )
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

On 8/15/23 15:34, Sagi Grimberg wrote:
> 
>>> How are you testing it btw?
>>
>> As outlined in the patchset description.
>> I've a target configuration running over the loopback interface.
>>
>> Will expand to have two VMs talking to each other; however, that
>> needs more fiddling with the PSK deployment.
> 
> Was referring to the timeout part. Would maybe make sense to
> run a very short timeouts to see that is behaving...

I'll see to patch it into tlshd.
I used to trigger it quite easily during development, but now that
things have stabilised of course it doesn't happen anymore.
Kinda the point, I guess :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


