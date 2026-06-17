Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED653CD98F0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2026 11:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WacAquq6gO/KhKHWdg4ZVYk8gtuSntZ9gSFvjcBPkS4=; b=WZ/caWYmX+0pbXHem7SGxPwHeG
	Ne53JlTQCgSLd9iOD5OutLietP4pLaXE2A5D5RBoYXfGz70lppU3oOkITboekouGeygCD06V2KI8V
	bI+418v8JOYjh9KC9a2rOGIgVbafE84cxDysI1N+f7ZHSkXOL1oPeoVBzYl1MmG4E5njK9eVyPqNz
	jw+A2VGm9YDeTigu2gjJ/uL/jR9FGoyfOWC0z4IiSQLXRDL3SmUD1bLGDi/33ANJGNSEkpd6tmyUA
	MaDVB06Dkd8fswz0uP37TYPinBtn1Xh6T1BXg8dhOjpOsjE6Tt3eTNCxSzFBbr11Cr2xu1c0NVVln
	onB6g/fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZohE-0000000HFna-2n7v;
	Wed, 17 Jun 2026 11:44:40 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZohC-0000000HFmo-1W8Q
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jun 2026 11:44:39 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6982F6B54A;
	Wed, 17 Jun 2026 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781696674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WacAquq6gO/KhKHWdg4ZVYk8gtuSntZ9gSFvjcBPkS4=;
	b=w2yQJ1BuY2PY6rN0V0HArggIDXDlqjK+qnDmMYq2F6TBIChN8lee3VCiWudO+op5jfOHBl
	9m9Ei27gNx/9rPMpwptr/IkwmFm09L2hUqcZ5AKjV2JWN/SosjGyQnmbpRkh/ayTKXGiQ9
	ToMVeWSa7686S+TfHvzzmitNNOfPeZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781696674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WacAquq6gO/KhKHWdg4ZVYk8gtuSntZ9gSFvjcBPkS4=;
	b=E2ZRbe94P2C/OWlpe5Bztjq05DIVF2tYLBHDCMGEk9KVjTGIflqhquvEbnc21pOYlw5adZ
	qPPuk7FAYVgKlNCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w2yQJ1Bu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=E2ZRbe94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781696674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WacAquq6gO/KhKHWdg4ZVYk8gtuSntZ9gSFvjcBPkS4=;
	b=w2yQJ1BuY2PY6rN0V0HArggIDXDlqjK+qnDmMYq2F6TBIChN8lee3VCiWudO+op5jfOHBl
	9m9Ei27gNx/9rPMpwptr/IkwmFm09L2hUqcZ5AKjV2JWN/SosjGyQnmbpRkh/ayTKXGiQ9
	ToMVeWSa7686S+TfHvzzmitNNOfPeZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781696674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WacAquq6gO/KhKHWdg4ZVYk8gtuSntZ9gSFvjcBPkS4=;
	b=E2ZRbe94P2C/OWlpe5Bztjq05DIVF2tYLBHDCMGEk9KVjTGIflqhquvEbnc21pOYlw5adZ
	qPPuk7FAYVgKlNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A5D0779AB;
	Wed, 17 Jun 2026 11:44:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oYIfDaKIMmqLcwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 17 Jun 2026 11:44:34 +0000
Message-ID: <e11f4194-049a-4c84-b1fd-59611ba8cb44@suse.de>
Date: Wed, 17 Jun 2026 13:44:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] nvmet: make configfs setup namespace aware
To: Christian Brauner <brauner@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andreas Hindborg <a.hindborg@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260613111437.101763-1-hare@kernel.org>
 <20260613111437.101763-9-hare@kernel.org>
 <20260617-kaufpreis-zugang-raven-4b0129e8462f@brauner>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260617-kaufpreis-zugang-raven-4b0129e8462f@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6982F6B54A
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_044438_565894_21FC185E 
X-CRM114-Status: UNSURE (   9.64  )
X-CRM114-Notice: Please train this message.
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

On 6/17/26 13:17, Christian Brauner wrote:
> On Sat, Jun 13, 2026 at 01:14:37PM +0200, Hannes Reinecke wrote:
>> Implement 'fill_subsystem' and 'clear_subsystem' callbacks to make
>> nvmet configfs namespace aware.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
> 
> What tree is this all based on? I can't apply it at all which makes this
> kind of change rather difficult to review meaningfully..

As per recommendation from Andreas Hindborg it's based on top of
Al Viros configfs cleanups.

I'll rebase it to current linux HEAD.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

