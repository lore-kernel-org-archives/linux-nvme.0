Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D39C3DA60
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 07:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xV3TtPvBlh7QRwDeSeoazrAzy/KRPYeb/SqFW5lXiAg=; b=uHVrjCKlTFwCszqmQr5y8GLyD3
	wJaPQNPR/d2FXpO/+gJigzQN623NmCasSMKlEEF6jeVMVqGSEM2gncBJVC45X7oPC0u5VmQ6Hy0r8
	ha4eYEGZ18FCwOLZ36xJ6U2u1c72q+Bu2sZljezB1yJG5rDV2t41U4hzGN0S5A6d+Bc0rc+lisIFL
	5YEgDsK9+y+WQ5w4xDBzOGBZZsIVlsi//7VWKqnyPzVjpty36+U/qNgZMs9JttCWq3pdE+wOU/JJb
	4pUQIQv3qaRravWMLCOiqpmC820nxZsn0Rza9Eig4NmYP8G9A49C8hZw4kf+gFuxzwv8RLP+1UQB4
	VbUjNDhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sULgb-0000000GEIN-0E39;
	Thu, 18 Jul 2024 07:36:21 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sULen-0000000GDQh-094s
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 07:34:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BCC51F8B0;
	Thu, 18 Jul 2024 07:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721288067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xV3TtPvBlh7QRwDeSeoazrAzy/KRPYeb/SqFW5lXiAg=;
	b=UiVQvFF3LJrVMLMWxtqPTevkuEuLy2x6RgpHLeEW8JOddwyqWOpaBYuAaQXCTPW5HrZsXy
	N/c8jXS39TK+D5nthVT5ZcFeksmoa0iQXIzZNB9LKveziBzbG7OXCKpWHALwAXycF7ewX5
	y4QWPuS4TVzpFNOItvNd58J5CXxrQHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721288067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xV3TtPvBlh7QRwDeSeoazrAzy/KRPYeb/SqFW5lXiAg=;
	b=2tX2HnUBzAZ2ILr9iGEc4hVa7tD//W3af/RSTWl3bEJ6UU4o1l3L7RMNinnqBj8nM1V++F
	c8G6LbQ5OS18h3Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UiVQvFF3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2tX2HnUB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721288067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xV3TtPvBlh7QRwDeSeoazrAzy/KRPYeb/SqFW5lXiAg=;
	b=UiVQvFF3LJrVMLMWxtqPTevkuEuLy2x6RgpHLeEW8JOddwyqWOpaBYuAaQXCTPW5HrZsXy
	N/c8jXS39TK+D5nthVT5ZcFeksmoa0iQXIzZNB9LKveziBzbG7OXCKpWHALwAXycF7ewX5
	y4QWPuS4TVzpFNOItvNd58J5CXxrQHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721288067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xV3TtPvBlh7QRwDeSeoazrAzy/KRPYeb/SqFW5lXiAg=;
	b=2tX2HnUBzAZ2ILr9iGEc4hVa7tD//W3af/RSTWl3bEJ6UU4o1l3L7RMNinnqBj8nM1V++F
	c8G6LbQ5OS18h3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6733F1379D;
	Thu, 18 Jul 2024 07:34:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vaL9F4PFmGYBEwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Jul 2024 07:34:27 +0000
Message-ID: <6b754a67-0f35-43a7-b650-40b26c968aa8@suse.de>
Date: Thu, 18 Jul 2024 09:34:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] nvmet-tcp: support secure channel concatenation
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-17-hare@kernel.org>
 <ee8c31e1-31fe-47e0-9c60-61d3292851e0@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ee8c31e1-31fe-47e0-9c60-61d3292851e0@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8BCC51F8B0
X-Spamd-Result: default: False [-1.50 / 50.00];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_003429_383322_EAD58E66 
X-CRM114-Status: GOOD (  11.45  )
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

On 7/18/24 00:36, Sagi Grimberg wrote:
> 
> 
> On 17/07/2024 12:10, Hannes Reinecke wrote:
>> Evaluate the SC_C flag during DH-CHAP-HMAC negotiation and insert
>> the generated PSK once negotiation has finished.
> 
> Will look in details at the patch, but first a question,
> IIRC TLS enabled ports should only allow host to connect
> over TLS. How does this change now?
> 
It didn't. We always had the possibility to set 'treq' to
'not required', which then will allow for either.

(In case you wondered: that was implemented with the last
patch to my TLS series, implementing a 'peek' on icreq to
figure out whether TLS should be started or not.)

> Plus, what does the discovery service tell hosts about such
> discovery log entries?

That's what the 'treq' bits are for; 'required' means you
have to use TLS, 'not required' means you _may_ use TLS
(ie both TLS and none-TLS connections are allowed).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


