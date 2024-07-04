Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDBEC3271E
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jul 2024 15:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ji5MiJ1qiJff4vaoEWKaeByuLQoDukwAr6G3OZAn9BA=; b=ZjYzaUcdN2zVG2oCnuEwtJyubm
	IhCfjH+7JlaUZX/wkK8VkFLV0qU2XjqgL5WraQLPckAEkY/jIFYQNzRyLRRjHhMsS4Dhs7fLWgXUg
	MvXtJJ05QYBPN26VNAwQHO4PbvJIvUAUenysgr6B9T3XIFmSPecyO+U2QQwl1wqZDYBbStHrEU2P9
	gBHtkDLK0hx05bwZEKTqpamRvJhBoO5/Mk4fk4UkV7Vz8T90oTM8ArP31SgVTB9IxP1r9qfy1DVdN
	IsjB+pF+/B8LuEjU9kvL+PIeYEVAeW0xz0u56R4KJPb6FybXye1bjhEtj6YtBEmiMjZQTzlJXQk2o
	31icnc0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPOnS-0000000DlFP-3DAJ;
	Thu, 04 Jul 2024 15:54:58 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPOnN-0000000DlDw-2Vwi
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jul 2024 15:54:57 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 06B701F801;
	Thu,  4 Jul 2024 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720108492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ji5MiJ1qiJff4vaoEWKaeByuLQoDukwAr6G3OZAn9BA=;
	b=wvKopcAgldU+p8NcI+1Mly3smmeuOmo01FpCbAXAlyH0PP5yeQof0tFQUd29t2uOV9pLvn
	8slACLTi+JjMYYqa02yz6xYMBUzAx4SeKl+WgAKJEEfsgPxH1skyk8D3Fvfrv3zV5aeolR
	Mv+Q6/W3JOzgNXqxgtNS0aBY3vvDou4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720108492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ji5MiJ1qiJff4vaoEWKaeByuLQoDukwAr6G3OZAn9BA=;
	b=eIWuilhkk24c3jGoUF60gmr9vxL8Yhk1CYiGAmDK31DhYYXRA2drZ+HdDkiMg5+gh5SRRg
	jxI6HEvEng9JIGAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720108492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ji5MiJ1qiJff4vaoEWKaeByuLQoDukwAr6G3OZAn9BA=;
	b=wvKopcAgldU+p8NcI+1Mly3smmeuOmo01FpCbAXAlyH0PP5yeQof0tFQUd29t2uOV9pLvn
	8slACLTi+JjMYYqa02yz6xYMBUzAx4SeKl+WgAKJEEfsgPxH1skyk8D3Fvfrv3zV5aeolR
	Mv+Q6/W3JOzgNXqxgtNS0aBY3vvDou4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720108492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ji5MiJ1qiJff4vaoEWKaeByuLQoDukwAr6G3OZAn9BA=;
	b=eIWuilhkk24c3jGoUF60gmr9vxL8Yhk1CYiGAmDK31DhYYXRA2drZ+HdDkiMg5+gh5SRRg
	jxI6HEvEng9JIGAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A81A01369F;
	Thu,  4 Jul 2024 15:54:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UZA7JsvFhmYqSgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 04 Jul 2024 15:54:51 +0000
Message-ID: <b6c7fe9e-d15d-45be-912b-d9ef35c15c49@suse.de>
Date: Thu, 4 Jul 2024 17:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme-tcp: switch to 'cpu' affinity scope for unbound
 workqueues
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-5-hare@kernel.org>
 <1259766c-234e-4958-a16f-9de753a4a0b5@grimberg.me>
 <792eeb90-90ba-4750-ab22-622023967eeb@suse.de>
 <2b0dbd25-bfa5-4a0c-842b-50c27b0843a7@grimberg.me>
 <56ebc95e-8c9c-43cb-a849-a1bbdd4a98e6@suse.de>
 <ed21cca6-4d79-4edc-935b-20e342a4d352@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ed21cca6-4d79-4edc-935b-20e342a4d352@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.28 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.926];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_085454_223921_69C51E3D 
X-CRM114-Status: GOOD (  16.90  )
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

On 7/4/24 11:11, Sagi Grimberg wrote:
> 
> 
> On 7/3/24 18:50, Hannes Reinecke wrote:
[ .. ]
>>
>> As you can see, with unbound and 'cpu' affinity we are basically on par
>> with the default implementations (all tests are run with per-controller
>> workqueues, mind).
> 
> I'm puzzled that the seq vs. rand vary this much when you work against a 
> brd device.
> Are these results stable?
> 
There is quite a bit of flutter ongoing, but the overall picture doesn't 
change.

>> Running the same workload with 4 subsystems and 8 paths will run into
>> I/O timeouts for the default implementation, but perfectly succeed with
>> unbound and 'cpu' affinity.
>> So definitely an improvement there.
> 
> I tend to think that the io timeouts are caused by a bug, not by "non 
> optimized" code. io timeouts are eternity for this test, which makes me
> think we have a different issue here.

I did some latency measurements for the send and receive loop, and found 
that we are in fact starved by the receive side. The sending side is 
pretty well limited by the 'deadline' setting, but the receiving side 
has no such precaution, and I have seen per-queue receive latencies of 
over 5 milliseconds.
The worrying thing here was that only individual queues have been 
affected; most queues had the expected latency of around 50usecs, but
some really went over the top with 1000s of usecs. And these were the
queues which were generating I/O timeouts.

I have now modified the deadline method to cover both receive and 
sending side, and the results were pretty good; timeouts are gone and
even the overall performance for the 4 subsystem case has gone up.

Will be posting an updated patchset shortly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


