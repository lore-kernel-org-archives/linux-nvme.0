Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED405FED2DE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2026 06:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=juHbSYpKLzTzFDfiRtIKpFDsbTP2/VInswTgfov0mlI=; b=nFSkKFYWv1jgp74ChhS6FAy6nW
	NJ8jlUtQa99ulKLMlvNyglfEOVgShlmuqldWG7nnRk9cU/nE0OK/wxgFTU2GW7dSFJIj3DPa3ye48
	NYNpJPpTaCB7ofmalB1aBO3h+BgS4pNrqz0noEi0nnKYUaJFzfbnD+i7HLu+caamhiC8YjY/ajMSF
	09HwvqyM2mLpd3gkE4F/IKV7+fMUrAUbTbtbOQg9yXRw3LP4yt4DidT43JXhwx5PWCZR+juiyz2aX
	3cU3Qlt3mHxTRATNG4xa978IIwIGTkXxsgfjJ+LbOtaxzG6ohFSoX7wbgUTUUFid0EDoQjOkK6jNj
	DAuWFlIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0ZzP-0000000DVBx-06at;
	Thu, 12 Mar 2026 06:57:47 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0ZzL-0000000DV9T-4Ben
	for linux-nvme@lists.infradead.org;
	Thu, 12 Mar 2026 06:57:45 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6DA864D336;
	Thu, 12 Mar 2026 06:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773298660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juHbSYpKLzTzFDfiRtIKpFDsbTP2/VInswTgfov0mlI=;
	b=gPK8hQMH26fQxSxT6OsKYW3Nyce4f7lvGaQ1FCk36Vj7npojadYjDn4Fq4dh5SlPQsWKQp
	fbJvvikpt+JXZRlFXWNqs8Yn0uYEYnJ6ezZ8mckfnop2HUmjVfzwMHxoy6ABslSBKg6TxH
	ulWAgc8WH4+lU1hnFYCEH/W+mW5MMLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773298660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juHbSYpKLzTzFDfiRtIKpFDsbTP2/VInswTgfov0mlI=;
	b=mh6365TruDvsvv7sLLvfcx4AwZjYy52afMf6aaLFuDW25ej1cCu50QRKfsahdpB9JHVmCu
	13BcT1cGuo+sDZAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gPK8hQMH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mh6365Tr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773298660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juHbSYpKLzTzFDfiRtIKpFDsbTP2/VInswTgfov0mlI=;
	b=gPK8hQMH26fQxSxT6OsKYW3Nyce4f7lvGaQ1FCk36Vj7npojadYjDn4Fq4dh5SlPQsWKQp
	fbJvvikpt+JXZRlFXWNqs8Yn0uYEYnJ6ezZ8mckfnop2HUmjVfzwMHxoy6ABslSBKg6TxH
	ulWAgc8WH4+lU1hnFYCEH/W+mW5MMLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773298660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juHbSYpKLzTzFDfiRtIKpFDsbTP2/VInswTgfov0mlI=;
	b=mh6365TruDvsvv7sLLvfcx4AwZjYy52afMf6aaLFuDW25ej1cCu50QRKfsahdpB9JHVmCu
	13BcT1cGuo+sDZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 231893FE3D;
	Thu, 12 Mar 2026 06:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fDL4BuRjsmljCQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 12 Mar 2026 06:57:40 +0000
Message-ID: <c60d58ae-84c6-49a1-b850-e23e12e7be45@suse.de>
Date: Thu, 12 Mar 2026 07:57:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-auth: Hash DH shared secret to create session key
To: Chris Leech <cleech@redhat.com>, Martin George <martinus.gpy@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Eric Biggers <ebiggers@kernel.org>
References: <20260311012116.2504291-1-cleech@redhat.com>
 <2fbad8b9c5e100bf04854b20b3790578fb724f89.camel@gmail.com>
 <20260311-flirt-autograph-39692a66b23a@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260311-flirt-autograph-39692a66b23a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: 6DA864D336
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_235744_209094_1EAF4234 
X-CRM114-Status: GOOD (  16.88  )
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

On 3/11/26 17:44, Chris Leech wrote:
> On Wed, Mar 11, 2026 at 09:17:49PM +0530, Martin George wrote:
>> On Tue, 2026-03-10 at 18:21 -0700, Chris Leech wrote:
>>> When using secure channel concatenation with bidirectional
>>> authentication, this results in hashing the DH value three times:
>>> twice
>>> for augmented challenge calculations and once during PSK generation.
>>>
>>
>> But secure channel concatenation is supported only with unidirectional
>> auth and not really with bidirectional auth, isn't it? As per NVMe base
>> spec 2.1, section 8.3.4.5.9 Generated PSK for TLS:
>>   
>> "The host may request secure channel concatenation with the TLS
>> protocol by setting the SC_C field in the AUTH_Negotiate message to
>> NEWTLSPSK while performing only unidirectional authentication. In this
>> case the host shall still send a challenge value C2 to the controller
>> and clear the sequence number S2 to 0h to indicate that controller
>> authentication is not requested."
> 
> I believe this is specifying how secure channel concatenation can work
> "while performing only unidirectional authentication", not that it's
> only allowed with unidirectional. It's a special case where C2 is sent
> in Reply without expecting an R2 value in Success1 or to send Success2.
> 
> It would be counterproductive to forbid the host from authenticating the
> controller when a secure channel is desired.
> 

Yeah, I do agree. After careful re-reading I agree with Chris; the 
quoted sentence is at the end of the section describing secure
concatenation, so it really is a clarification how to handle secure
concatenation if unidirectional authentication is employed.

We might go to fmds for clarification, though.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

