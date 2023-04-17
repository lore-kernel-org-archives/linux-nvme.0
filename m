Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298BBC77B76
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=veUXC3vcrjBdv6AiuUkPvBCIWe2nwhOQk6uFjfGXMug=; b=KFT9mYeUMcAABuL25ok59BrUGP
	UsQfbHEzNuPgDjRxXctBh01JronE8RpFtpcNQmLINOYsVdP/ffO/Ko4BLfeUPjGpZF2eePEzOhMkK
	p6wtMiymTIIoTlAqEv0C7SrSOzYKm6MizgT5ifiEYQDT9E7Tq6zuwZzEwR7BJTq+crso82MmxKqKa
	RBFtgNtTSgLzpdS7W+8/jMFzY/+oSt4W79M7VePrzSSItgyNIG6WDM7zzoGq2DjMtYLukkIoq4lXN
	A3KjlhZ2RU3UJ7MLyJJ9ZAiWcGxIwfvUL0pzA5joujLKczHbbsnP7y41c+2pXNc1k0A1Sr5INFh6r
	suXrkF0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poQtU-00GuZm-05;
	Mon, 17 Apr 2023 15:35:52 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poQtQ-00GuYm-31
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 15:35:50 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3500F1F86C;
	Mon, 17 Apr 2023 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681745747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veUXC3vcrjBdv6AiuUkPvBCIWe2nwhOQk6uFjfGXMug=;
	b=r3Fk2lBaeUdPAzIDPtZjqVM/lN2qCy84GAXhohc/mh1Je6pFkwMDpeycbc30JhlGjuMSMd
	melWezHuG3d9Ij8THSxSD5miUDXHaikJ2U2BOZ8eH5Ad/b62tBDp/UTvrs1ELSnx55aLuE
	NhWJWj2iA/H8eAAm9TFBYNh/ymhoprQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681745747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veUXC3vcrjBdv6AiuUkPvBCIWe2nwhOQk6uFjfGXMug=;
	b=rwYIbex1YJw4WbCE+YG8YXaLFPa2iR8zXV4LFBZlazjKqJwcV8dkBTcgCnIs48aDNGc/LU
	nj5UOl7aTQRhBwAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7F661390E;
	Mon, 17 Apr 2023 15:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id n/rdNVJnPWRtOQAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 17 Apr 2023 15:35:46 +0000
Message-ID: <cce7cbdb-0866-58ec-8bf1-d0eea7ce9fe1@suse.de>
Date: Mon, 17 Apr 2023 17:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 08/18] nvme-tcp: do not set MSG_SENDPAGE_NOTLAST
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-9-hare@suse.de>
 <36976756-b4c5-f2a5-34b8-e9731a49c477@grimberg.me>
 <654702da-246a-934c-14e4-7b179c46ed98@suse.de>
 <5df08f86-2599-6e47-2fdc-bda8d70edaf2@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <5df08f86-2599-6e47-2fdc-bda8d70edaf2@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_083549_127173_21D0AF7B 
X-CRM114-Status: GOOD (  16.57  )
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

On 4/17/23 17:28, Sagi Grimberg wrote:
> 
>>> nak from me.
>>>
>>>> MSG_SENDPAGE_NOTLAST was introduced with commit 35f9c09fe9c7
>>>> ("tcp: tcp_sendpages() should call tcp_push() once") to fix issues
>>>> with the ->sendfile() call, and the implication seems to be that
>>>> the flag should be strictly internal to sendfile.
>>>
>>> no, the use case was to allow sendpage consumers to build larger
>>> tso packets for large payloads (splice being the primary one), nvme-tcp
>>> also benefits from it (as do others), just like sendfile.
>>>
>>>> Hence we shouldn't be setting it on nvme-tcp, and anyway doing
>>>> so will cause TLS sending invalid data.
>>>
>>> That is something else. I don't recall the full details on the
>>> discussion with Jakub, but it was not my intention to strike
>>> it altogether, just remove it if !sendpage_ok.
>>>
>> But then we're running afoul with tls_sw_do_sendpage(), which uses 
>> MSG_SENDPAGE_NOTLAST as a record indicator. Forwarding 
>> MSG_SENDPAGE_NOTLAST to tls results in incorrect TLS records on the 
>> wire and a transmission stall.
>>
>> Took me days to figure that out.
>>
>> If you have a better idea, I'm all ears.
> 
> So sendfile is unsupported over kTLS? Or is there some special
> case for it in the upper layer?
> 
Dunno. Seems to work, at least according to commit d452d48b9f8b
("tls: prevent oversized sendfile() hangs by ignoring MSG_MORE")

Which is also where I got the notion about sendfile() from.
If MSG_SENDPAGE_NOTLAST is valid for non-sendfile users then
tls_sw_do_sendpage() has a bug.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


