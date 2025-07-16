Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80F9C83F1B
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jul 2025 06:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0e1SUfxNlwATJ9GKQOGvJVqQtEh7kUZtHLagVZpWars=; b=3J6rUlSgsk1k/y5o//wpCbwzla
	IbqK7bANS8ZCmAgddGhKHTk/OAausShPgF/NdFYzHaooBrlQFgDWtqwq/P1RxbFkMZW+7lS3O5YWl
	GqD3GrD+XvRNFfpd50WGS3wBXeviIXRy681Hn4UxEVC8qfoMlJB1/oPrxuK9cuzTSIGRLekbO2nHc
	/OUo4+G3k0g/rpNuDQEaWaV6Gt+1y9J6F6OtnQMFIp3IE72zJZ5rxeru03SBGZYyjiJkgSkUltchh
	rmhm9rviqHECuqpFpnMngBYHsVDeBbXK96ll+oK4kjH1dnpUXnbhz9tnvk/d5bbSadvIdwMJlWIMQ
	PVGKUnCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubvZy-00000006sen-0sNm;
	Wed, 16 Jul 2025 06:25:22 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubvJ5-00000006qgN-2p5O
	for linux-nvme@lists.infradead.org;
	Wed, 16 Jul 2025 06:07:56 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B74F921245;
	Wed, 16 Jul 2025 06:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752646072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0e1SUfxNlwATJ9GKQOGvJVqQtEh7kUZtHLagVZpWars=;
	b=vl29AnZTjxlFqmmjlZ+1TUNH4G7Z1azN8kGPXqkbBNSPNo3xi6GH4CFIJFBK244MqHJhCb
	bUsLsEmHqh3RXxpNaemvRobvE6T0jhllyj8fuPbmGni+IU5B+ptbq3ZjGQ+t2U7zGVzh9K
	5+WHEdpgK5S4Ko5lMuwFIAbIoPeAT3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752646072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0e1SUfxNlwATJ9GKQOGvJVqQtEh7kUZtHLagVZpWars=;
	b=9vQ3DX3OgONEYJAfFPbfu94TxdfyQ+5S4QH7MZxgl6xpXUHvjUbCzgoF7QEVVuW0B8mZ4P
	ea90wvGE4HUhm4Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752646072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0e1SUfxNlwATJ9GKQOGvJVqQtEh7kUZtHLagVZpWars=;
	b=vl29AnZTjxlFqmmjlZ+1TUNH4G7Z1azN8kGPXqkbBNSPNo3xi6GH4CFIJFBK244MqHJhCb
	bUsLsEmHqh3RXxpNaemvRobvE6T0jhllyj8fuPbmGni+IU5B+ptbq3ZjGQ+t2U7zGVzh9K
	5+WHEdpgK5S4Ko5lMuwFIAbIoPeAT3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752646072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0e1SUfxNlwATJ9GKQOGvJVqQtEh7kUZtHLagVZpWars=;
	b=9vQ3DX3OgONEYJAfFPbfu94TxdfyQ+5S4QH7MZxgl6xpXUHvjUbCzgoF7QEVVuW0B8mZ4P
	ea90wvGE4HUhm4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53CDB138D2;
	Wed, 16 Jul 2025 06:07:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AiBAErhBd2hdZQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 16 Jul 2025 06:07:52 +0000
Message-ID: <ccb69ee6-bd5e-4585-9ccc-0c49cb30f1a9@suse.de>
Date: Wed, 16 Jul 2025 08:07:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/8] nvme: sysfs: emit the marginal path state in
 show_state()
To: Keith Busch <kbusch@kernel.org>, John Meneghini <jmeneghi@redhat.com>
Cc: Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, james.smart@broadcom.com,
 dick.kennedy@broadcom.com, njavali@marvell.com, linux-scsi@vger.kernel.org
References: <20250709211919.49100-1-bgurney@redhat.com>
 <20250709211919.49100-8-bgurney@redhat.com> <aG7pSA6TOAANYrru@kbusch-mbp>
 <35738598-0733-408c-8597-20c3599a8973@redhat.com>
 <aHa0JpsASqGuHdOA@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aHa0JpsASqGuHdOA@kbusch-mbp>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_230755_879297_3EB371BF 
X-CRM114-Status: GOOD (  28.17  )
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

On 7/15/25 22:03, Keith Busch wrote:
> On Tue, Jul 15, 2025 at 03:42:32PM -0400, John Meneghini wrote:
>> On 7/9/25 6:12 PM, Keith Busch wrote:
>>> On Wed, Jul 09, 2025 at 05:19:18PM -0400, Bryan Gurney wrote:
>>>> If a controller has received a link integrity or congestion event, and
>>>> has the NVME_CTRL_MARGINAL flag set, emit "marginal" in the state
>>>> instead of "live", to identify the marginal paths.
>>>
>>> IMO, this attribute looks more aligned to report in the ana_state
>>> instead of overriding the controller's state.
>>>
>>
>> We can't really do this because the ANA state is a documented protocol state.
>>
>> The linux controller state is purely a linux software defined state.  Unless
 >> I am wrong, there is nothing in the NVMe specification which defines
 >> the nvme_ctrl_state.>
> Totally correct.
>   
>> This is purely a linux definition and we should be able to change is any way we want.
> 
> My kneejerk reaction is against adding new controller states. We have
> state checks sprinkled about, and special states just make that more
> fragile.
>   
Yeah, controller states are not a good fit. We've seen the issues when
trying to introduce a new state for firmware update.

>> We debated adding a new NVME_CTRL_MARGINAL state to this data structure,
>>
>> enum nvme_ctrl_state {
>>          NVME_CTRL_NEW,
>>          NVME_CTRL_LIVE,
>>          NVME_CTRL_RESETTING,
>>          NVME_CTRL_CONNECTING,
>>          NVME_CTRL_DELETING,
>>          NVME_CTRL_DELETING_NOIO,
>>          NVME_CTRL_DEAD,
>> };
>>
>> If you don't like the flag we can do that. However, that doesn't seem worth the effort since Hannes has this working now with a flag.
> 
> What you're describing is a "path" state, not a controller state which
> is why I'm suggesting the "ana_state" attribute since nothing else
> represents the path fitness. If nvme can't describe this condition, then
> maybe it should?
> 
We probably could, but that feels a bit cumbersome.
Thing is, the FPIN LI (link integrity) message is just one a set of
possible messages (congestion is another, but even more are defined).
When adding a separate ANA state for that question would be raised
how the other state would fit into that.
 From a conceptual side FPIN LI really is equivalent to a flaky
path, which can happen at any time without any specific information
anyway.
Again making it questionable whether it should be specified in terms
of ANA states.

> Where does this 'FPIN LI' message originate from? The end point or
> something inbetween? If it's the endpoint (or if both sides get the same
> message?), then an ANA state to non-optimal should be possible, no? And
> we already have the infrastructure to react to changing ANA states, so
> you can transition to optimal if something gets repaired.

It's typically generated by the fabric/switch once it detects a link
integrity problem on one of the links on a given path.

As mentioned above, it really is a attempt to codify the 'flaky path'
scenario, where occasionaly errors are generated but I/O remains
possible. So it really is an overlay over the ANA states, as _any_
path might be affected.
This discussion only centered around 'optimal' paths as our path
selectors really only care about optimized paths; non-optimized
paths are not considered here.
Which might skew the view of this patchset somewhat.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

