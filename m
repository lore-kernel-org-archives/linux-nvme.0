Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C14CC1B087
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 07:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LURQLperLP55U0sbtjSQUw4tyMa6MQux+BoFVADvCww=; b=0GgPd6BsHA4oXmD2d8Xcs+F76d
	EQ0BPdOVCpDylkXhx5LHn6HD83FQ7768sAjhf+ubjdpvPoEM1zpORTF13qUcVYEpijXfyGgcKpvnv
	DjguH5ugV920Mr8oHoxkSW3we33cZDbYjZpXZ3fHfJ8h/GE17jTPpd7xZm9qva566emz0AVaZYCp1
	JE6yg4fSouKasXXq/iGxJJ7YWng7zGa2lCGGu9O88nrDEN08/uL6nunymFpiCj1jOTLwQE+qul5lx
	K7B4sWCOQY2vcSIo4RmuiXEQvAntArEsonkpOAe0tCZiLR58ccOIG7+mpesBGnT0WMP+c80L/AF2R
	Mqoc5qGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnYHd-00000006Y2E-3FIT;
	Thu, 27 Feb 2025 07:26:13 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnYHa-00000006Y11-3c8N
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 07:26:12 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BE281F38A;
	Thu, 27 Feb 2025 07:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740641167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LURQLperLP55U0sbtjSQUw4tyMa6MQux+BoFVADvCww=;
	b=Y6+h/DGhKq4QBaucrHPSs3iv19vkbXuL1aqCsCHJHecjOCmE6RHybHzS7Ji2ce/1vJY2Z4
	zMe+rOXj8V/HsybIoVZPnH7y6ibGTgGIxKOIY3yKgoPG6jye70OzxSXl/wYrxabqWRl7j4
	jRdsNqZYA+gxV2vK2mo0RLQQk/lz/jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740641167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LURQLperLP55U0sbtjSQUw4tyMa6MQux+BoFVADvCww=;
	b=36uObA9PWDU+akuVqhzAc85eyqB5sYvm4FrIHYkXsTQz8Z75tvvmpO4EN+qZsDIV+fvTTY
	Cb9OEQjI/nMl5+Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740641166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LURQLperLP55U0sbtjSQUw4tyMa6MQux+BoFVADvCww=;
	b=Ucnq0XgCQbSlnzK6jDqk0I5C0L7G71Gi9yh2f8k9S4zNqlDvtI4vzC5WZc5s/HDx+9eno4
	7nFfHbYDkPYKcM197oUEO2eseW9173/vzjOOcpXDoBCFffyaK6SlYotnDSihL+Rohn1L6r
	yMJrEeFlz9jdrKAGL+0wLT6hCCyRsiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740641166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LURQLperLP55U0sbtjSQUw4tyMa6MQux+BoFVADvCww=;
	b=04slfiWbJx5RmzDoR3i9HqueZGJXj5bwAMvHR8v0kuWsr8R6D4xv2OqX1oqUgut/DaJOwN
	pSJlBZTv72eWULDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C09913888;
	Thu, 27 Feb 2025 07:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UX7bDI4TwGcOagAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Feb 2025 07:26:06 +0000
Message-ID: <7ccc3a88-b92c-45b8-bbfd-af98ab439be7@suse.de>
Date: Thu, 27 Feb 2025 08:26:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: switch to using the crc32c library
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226062841.60688-1-ebiggers@kernel.org>
 <03dad20d-1293-47d1-a55d-8430fcefc0bb@suse.de>
 <20250226190122.GA3949421@google.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226190122.GA3949421@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.987];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_232611_091420_D8BDFF19 
X-CRM114-Status: GOOD (  18.63  )
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

On 2/26/25 20:01, Eric Biggers wrote:
> On Wed, Feb 26, 2025 at 10:37:55AM +0100, Hannes Reinecke wrote:
>> ... and it also eliminates a sporadic crash which we've seen
>> where 'snd_hash' wasn't initialized when sending PDUs.
>> Thanks for doing this!
> 
> I'm not sure how that could have happened, since the ahash was allocated when
> 'if (queue->hdr_digest || queue->data_digest)' which seemed to match the
> conditions for when it was used.  But yeah, it's certainly nice to not have the
> pointless allocation to worry about.
> 
>> (Note to self: check the nvme-tls code for crc32c usage ...)
> 
> I have patches for nvme-tls almost ready too.  Just been taking my time since
> I've been updating all other users of "crc32" and "crc32c" in the kernel too.
> And I need to decide what to do about skb_copy_and_hash_datagram_iter().
> 
If it were me I would _love_ to switch the nvme-tcp recv patch over to 
recvmsg and kill the ->read_sock() implementation.
->read_sock uses a completely different codepath in tls_sw, and nvme is
the only user of that. So there's a fair chance that we might miss any
improvements or fixes.

Plus we currently have no good way of handling TLS records from 
->read_sock(), which is something we might want to do in the future.

So if we had an equivalent for skb_copy_and_hash_iter() for recvmsg()
I could revisit my original patchset and work on getting ->read_sock()
replaced.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

