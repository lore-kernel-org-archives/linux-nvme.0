Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B40C83F27
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 06:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ul1+6NYWwYXpMVWLroMFooxBv0ib2MtlKQMaDW/P09g=; b=tD4K76JKTrNWtZH5lorTulE4bg
	Gy1Qo+sw/Q2a/uP14LyDUtLToti24a0JJT9rWaHax3WObJGtARwSTTAtcC8yR4YiXAIjrl3Qg662P
	7Hr55stbjOLdaTXUuNRGi/Y9Wfg00brllVgJeWj3JQQMVcneNx3uii1UkUA9DCrem2bvb0GmEBQ4F
	LiGepBJPKtUIjTLGMNlYfICoSmIPH4leX9oRMODNP7miJ7i+XaRY6VOuCjshz6EPcXRlNK2/km2Lk
	vmJpya2ecHWC2sLIV2lCm5n0EflgqQfKAMZkHFZUvhJ3YW1Wb/C3s4xSGCoQ1xwvEFKerFc0RspRU
	+5OafA4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6hO-00000001SYB-2P1o;
	Tue, 22 Jul 2025 06:42:02 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6hL-00000001SXB-3x1n
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 06:42:01 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 89F59218E7;
	Tue, 22 Jul 2025 06:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753166516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ul1+6NYWwYXpMVWLroMFooxBv0ib2MtlKQMaDW/P09g=;
	b=N+TiJt2tcAYUg1lZSjCftJgr47LStENLeQexDgdBwIHldNvUyS3CgMKsAZLwtKs1dtNxN2
	JPVG+/Ep3VE4QGAzsLug8Wl3vhwYNVA5FtqMlssQ2BqThF7UvsXPkmXo7tbdIw6goK73Cn
	eNWGH1COV+8iQgKqRE+EuoOPAnf6Xts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753166516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ul1+6NYWwYXpMVWLroMFooxBv0ib2MtlKQMaDW/P09g=;
	b=1Drl7bWyuhbpxRC6X0WE4EuiA4eCPqV8E3aiuLJ1w+a37qsni+Oay/Ke7KUBLzJxrW2dBb
	Uxzjhdr80E9pjaCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753166516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ul1+6NYWwYXpMVWLroMFooxBv0ib2MtlKQMaDW/P09g=;
	b=N+TiJt2tcAYUg1lZSjCftJgr47LStENLeQexDgdBwIHldNvUyS3CgMKsAZLwtKs1dtNxN2
	JPVG+/Ep3VE4QGAzsLug8Wl3vhwYNVA5FtqMlssQ2BqThF7UvsXPkmXo7tbdIw6goK73Cn
	eNWGH1COV+8iQgKqRE+EuoOPAnf6Xts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753166516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ul1+6NYWwYXpMVWLroMFooxBv0ib2MtlKQMaDW/P09g=;
	b=1Drl7bWyuhbpxRC6X0WE4EuiA4eCPqV8E3aiuLJ1w+a37qsni+Oay/Ke7KUBLzJxrW2dBb
	Uxzjhdr80E9pjaCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23D92132EA;
	Tue, 22 Jul 2025 06:41:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ot60BrQyf2h9bAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Jul 2025 06:41:56 +0000
Message-ID: <4c97cc61-bb9f-4121-8681-22c9e548fe0a@suse.de>
Date: Tue, 22 Jul 2025 08:41:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/8] nvme: sysfs: emit the marginal path state in
 show_state()
To: Keith Busch <kbusch@kernel.org>
Cc: John Meneghini <jmeneghi@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 axboe@kernel.dk, james.smart@broadcom.com, dick.kennedy@broadcom.com,
 njavali@marvell.com, linux-scsi@vger.kernel.org
References: <20250709211919.49100-1-bgurney@redhat.com>
 <20250709211919.49100-8-bgurney@redhat.com> <aG7pSA6TOAANYrru@kbusch-mbp>
 <35738598-0733-408c-8597-20c3599a8973@redhat.com>
 <aHa0JpsASqGuHdOA@kbusch-mbp> <ccb69ee6-bd5e-4585-9ccc-0c49cb30f1a9@suse.de>
 <aH7-F2WxrhoCiK7O@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aH7-F2WxrhoCiK7O@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_234200_133119_75D55A2C 
X-CRM114-Status: GOOD (  20.52  )
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

On 7/22/25 04:57, Keith Busch wrote:
> On Wed, Jul 16, 2025 at 08:07:51AM +0200, Hannes Reinecke wrote:
>> On 7/15/25 22:03, Keith Busch wrote:
>>>
>>> What you're describing is a "path" state, not a controller state which
>>> is why I'm suggesting the "ana_state" attribute since nothing else
>>> represents the path fitness. If nvme can't describe this condition, then
>>> maybe it should?
>>>
>> We probably could, but that feels a bit cumbersome.
>> Thing is, the FPIN LI (link integrity) message is just one a set of
>> possible messages (congestion is another, but even more are defined).
>> When adding a separate ANA state for that question would be raised
>> how the other state would fit into that.
>>  From a conceptual side FPIN LI really is equivalent to a flaky
>> path, which can happen at any time without any specific information
>> anyway.
>> Again making it questionable whether it should be specified in terms
>> of ANA states.
> 
> I see. Re-reading ANA, it is more aligned to describing a controller as
> active/passive or primary/secondary to the backing storage access rather
> than the state of the host nexus, so I agree it's not well suited
> for an ANA state. :(
>   
>>> Where does this 'FPIN LI' message originate from? The end point or
>>> something inbetween? If it's the endpoint (or if both sides get the same
>>> message?), then an ANA state to non-optimal should be possible, no? And
>>> we already have the infrastructure to react to changing ANA states, so
>>> you can transition to optimal if something gets repaired.
>>
>> It's typically generated by the fabric/switch once it detects a link
>> integrity problem on one of the links on a given path.
>>
>> As mentioned above, it really is a attempt to codify the 'flaky path'
>> scenario, where occasionaly errors are generated but I/O remains
>> possible. So it really is an overlay over the ANA states, as _any_
>> path might be affected.
>> This discussion only centered around 'optimal' paths as our path
>> selectors really only care about optimized paths; non-optimized
>> paths are not considered here.
>> Which might skew the view of this patchset somewhat.
> 
> Okay, but can we call it "degraded" instead of "marginal"? The latter
> implies the poor quality is endemic to that path rather than a temporary
> condition.

Sure we can.
(Although technically it _is_ endemic as it won't change without
user interaction. But I digress :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

