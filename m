Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CD6C67861
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 06:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r5m4hOXuuRRTTkcUvB4yh/QRud1FyCHMbjBu2GrsFO4=; b=K+Zk/2MZR3/5e132n02HvKAIA7
	1nuo2HXWZ9BMkd3XLDUDB86rnNfco4qMxy1urCibh+wBcjqv5Y4z5ATqMw+E+Wi9rADn1fw43lsiN
	DSi8Inne7KNycpmF+tS+g5RNijXymwwoMtMkWLuKsKDZlUzPpYA085aXTwl8vFLaCb6yqkdLEzW55
	jU9hzCO7fgGFZ7tUB/mxuHxdft6/DmygjhP+qBPPVbWtGLBFXlZi1AThOoPfjpxQFr3E21afvJloZ
	7P8YW1xKbpGsPZGxd4lCZL6CAlzVFCj48gyDSSiODj8pdUNl+wbgq9z2PJmEacVXb1v2befhFGo03
	cMli2EwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtiNW-0000000EV0U-1wqn;
	Mon, 08 Apr 2024 06:21:14 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtiNO-0000000EUzG-274R
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 06:21:12 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0E4120193;
	Mon,  8 Apr 2024 06:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712557263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5m4hOXuuRRTTkcUvB4yh/QRud1FyCHMbjBu2GrsFO4=;
	b=wDCYn7QBNCqAEZp6UguDh6Aw7HDW11d5hGMyIXudC/8ixGxpJ9OC2xt8zlMrBKAYyzUGWO
	+9J9yx33hHsUuU9ooqIEA76rXrD59//btu0UY8riiU3io7OQmU40yTnJAgQ/b3KgNHI2RC
	8C/eD2gT15AfmcwDky4zrccFDm2OtjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712557263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5m4hOXuuRRTTkcUvB4yh/QRud1FyCHMbjBu2GrsFO4=;
	b=2oDHB/gRX30a9dlsRzKnaVZ1E6wkoD+VB832xAlqlBtW072O/3Rt9xKKlCIxu1tDLJvjpq
	JkSBam+qgbHQ7qBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712557263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5m4hOXuuRRTTkcUvB4yh/QRud1FyCHMbjBu2GrsFO4=;
	b=wDCYn7QBNCqAEZp6UguDh6Aw7HDW11d5hGMyIXudC/8ixGxpJ9OC2xt8zlMrBKAYyzUGWO
	+9J9yx33hHsUuU9ooqIEA76rXrD59//btu0UY8riiU3io7OQmU40yTnJAgQ/b3KgNHI2RC
	8C/eD2gT15AfmcwDky4zrccFDm2OtjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712557263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5m4hOXuuRRTTkcUvB4yh/QRud1FyCHMbjBu2GrsFO4=;
	b=2oDHB/gRX30a9dlsRzKnaVZ1E6wkoD+VB832xAlqlBtW072O/3Rt9xKKlCIxu1tDLJvjpq
	JkSBam+qgbHQ7qBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69DFA137D4;
	Mon,  8 Apr 2024 06:21:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3tsIGM+ME2anRgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Apr 2024 06:21:03 +0000
Message-ID: <a1395ee5-fbff-47ef-9400-56b8f3a0d1f5@suse.de>
Date: Mon, 8 Apr 2024 08:21:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] nvme-fabrics: reset connection for secure
 concatenation
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-13-hare@kernel.org>
 <31c2c699-bff1-455d-a6ca-337724324150@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <31c2c699-bff1-455d-a6ca-337724324150@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_232106_764957_D8418DD2 
X-CRM114-Status: GOOD (  18.82  )
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

On 4/7/24 23:46, Sagi Grimberg wrote:
> 
> 
> On 18/03/2024 17:03, Hannes Reinecke wrote:
>> When secure concatenation is requested the connection needs to be
>> reset to enable TLS encryption on the new cnnection.
>> That implies that the original connection used for the DH-CHAP
>> negotiation really shouldn't be used, and we should reset as soon
>> as the DH-CHAP negotiation has succeeded on the admin queue.
>> The current implementation does not allow to easily skip
>> connection attempts on the I/O queues, so we connect I/O
>> queues, but disable namespace scanning on these queues.
>> With that no I/O can be issued on these queues, so we
>> can tear them down quickly without having to wait for
>> quiescing etc.
> 
> We shouldn't have to connect io queues here. The scan prevention
> is just a hack...
> 
Oh, believe me, I tried. What _should_ be possible is to create a
controller with just admin queues, and skip the io queue setup part.
But once you do that it's impossible to create io queues after reset
(which is what you'd need here).
I tried to fix this, but that ended up with a massive rewrite/reordering
of the init path. Which sure has its merits, but I deemed out of scope
for this patchset.

So I decided for this 'hack', and shelved the init path reorg for a
later patchset.

>> Once that is done we can reset the controller directly
>> after the ->create_ctrl() callback.
> 
> Why not set opts->nr_io_queues = 0 for secure concatenation and
> setting it to the original value before resetting?

See above. The io tagset is allocated in the init path _only_.
And creating of the io tagset is tied with connecting the io queues.
The reset code requires the tagset to be present; it just reconnects
the io queues.
So either you do some trickery here like skipping connecting io queues
(or, indeed, skipping namespace scanning),
or you end up with a massive reshuffling of the init code path trying
to separate tagset creation from io queue connections.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


