Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073B1CA0EF8
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 09:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K4umqBPWmG40HLdtq8HLCaMQrM3dHtOlVZ7V0JOy4gE=; b=Blw8yfwKZsFIw5xqZQs5XSQApA
	MkViFKzlEt+twBKOlaRjoemouMdir0so5IAN3UoUO4loOsNCQ6fW3CMr8s80gd1sgIiOmShmo3qpl
	j1EX9qvhkzFMe16hxPl1OQw02CMJW611NVtJIQHLezhaQM1dSWEAQrb3KYdu1msmOvpLSv8p5L3Rz
	PfQGRNHHxS+Xehh7D2AEhiAtkMn03/DEIxLEitH4D7ki+yDiP9vZ+jb5nbefDchXLm6lbweQ8iwuh
	Q9xUaxep+t0wq6jq+kFfn4GEG/+sIbsfhfoamfcHRwBkAI+SPexriQXUBpfv97SAtaNMCk6xgBCp5
	TBFdzAVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoevD-0000000CsVA-2Rxr;
	Wed, 20 Aug 2025 09:15:55 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoeD2-0000000CkAn-0WV1
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 08:30:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A41621202;
	Wed, 20 Aug 2025 08:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755678614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4umqBPWmG40HLdtq8HLCaMQrM3dHtOlVZ7V0JOy4gE=;
	b=HxHruspCoXYxZUsyBnnV/nKQ/wFvYIusrl63Zua9p0ceINZyVAUPgOjnWThmS4cuWJp4Id
	mc7M15mOJqNfH8N2wRzKUJGPNx/qbJAyToI40pzVlvcUejyGiYLX7LwiRx/at4SR2pJRUC
	8+pUn/Z6H0a8PxSsRycXn9TtOKECoGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755678614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4umqBPWmG40HLdtq8HLCaMQrM3dHtOlVZ7V0JOy4gE=;
	b=9jZb9zTi8ZO7vr6l5N27J8YzUaGl+pXzRhjlpGPDOZMExCB2CmYaV8uc9dEwr1KdS6sBjK
	M+WHBFW6msr9pdDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HxHruspC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9jZb9zTi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755678614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4umqBPWmG40HLdtq8HLCaMQrM3dHtOlVZ7V0JOy4gE=;
	b=HxHruspCoXYxZUsyBnnV/nKQ/wFvYIusrl63Zua9p0ceINZyVAUPgOjnWThmS4cuWJp4Id
	mc7M15mOJqNfH8N2wRzKUJGPNx/qbJAyToI40pzVlvcUejyGiYLX7LwiRx/at4SR2pJRUC
	8+pUn/Z6H0a8PxSsRycXn9TtOKECoGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755678614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4umqBPWmG40HLdtq8HLCaMQrM3dHtOlVZ7V0JOy4gE=;
	b=9jZb9zTi8ZO7vr6l5N27J8YzUaGl+pXzRhjlpGPDOZMExCB2CmYaV8uc9dEwr1KdS6sBjK
	M+WHBFW6msr9pdDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EF441368B;
	Wed, 20 Aug 2025 08:30:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r5KIHpaHpWi3awAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 20 Aug 2025 08:30:14 +0000
Message-ID: <4e20561b-8b51-45c5-ad83-24b3d7ae092d@suse.de>
Date: Wed, 20 Aug 2025 10:30:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/4] nvme: extend show-topology command to add support
 for multipath
To: Daniel Wagner <dwagner@suse.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, gjoyce@ibm.com
References: <20250812125614.164445-1-nilay@linux.ibm.com>
 <20250812125614.164445-3-nilay@linux.ibm.com>
 <93be5b21-8897-44d3-a590-42ba8f1b6abb@suse.de>
 <a06660fb-821f-447e-9ea6-ef0f3372a844@linux.ibm.com>
 <ecd33303-830d-4e26-b49a-14a558725e67@suse.de>
 <4f504c94-e6da-4a33-aa12-9dcb447e7021@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <4f504c94-e6da-4a33-aa12-9dcb447e7021@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9A41621202
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_013016_312427_BE8503A6 
X-CRM114-Status: GOOD (  14.56  )
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

On 8/20/25 10:17, Daniel Wagner wrote:
> On Tue, Aug 19, 2025 at 08:15:09AM +0200, Hannes Reinecke wrote:
>>> Okay makes sense, so we'd print <numa-node> and exclude <queue-depth> if iopolicy
>>> is numa. For 'queue-depth' iopolicy, we'd print <queue-depth> and exclude <numa-node>.
>>> And for 'round-robin' iopolicy, we'd neither print <numa-node> nor <queue-depth>.
>>> I'll update this in the next patch.
>>>
>> Hmm. I'd rather have _some_ value for 'round-robin', too, as otherwise
>> the number of fields will be different (and making parsing harder).
> 
> What type of parser do you mean, a carbon based one or a computer? I
> strongly recommend to use the JSON output for the later.
> 
> I would really prefer that the default stdout is easy for a human to
> read not screen scrappers.
> 
That was my intention, too. And my prime objection was to have a
sequence of raw numbers, and requiring the user to figure out what
these numbers are for.

But really, I'm not sure if we should print out values from the various
I/O policies. For NUMA it probably makes sense, but for round-robin and
queue-depths the values are extremely volatile, so I wonder what benefit
for the user is here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

