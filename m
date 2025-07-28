Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6A9C87FCF
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jul 2025 07:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UwbcK8h4ia/21i+CxKfkw0jTy/iZ/SKLDBy/roNwJsE=; b=wrEJ+5ELCyXUqgVV3cvUCoNnqp
	cvXhFMEceYs0PLbMJTW/J1NCTEeY810AcYyjzPGDztEA63zyIGcb1gzMBwjgskoL/IUk2A0L3RA/I
	iKwoE+EWrwIgxrxKj/9tMtBBW5KQs8OFbmwOP/P8pCDFkIiEV8Fgr3GoxqOEaPilQtBSB1xAph/Px
	LLj5OA10FZnoyxDuLuCU1x3UfFZwOzt0Ybb1kGe2QKVqgkHknNMifNdCKyqtDWjBZl/cvB5RlUkH3
	t9SlaNruD27zB+CRUo9TBHmTsBrmIqclBvoYZ8rNXoYARfiXgAmFBg5lQ3rnlFdnR0KktfFhJHo+p
	C9jCNOAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugIJt-0000000Dru5-3Odb;
	Mon, 28 Jul 2025 07:30:49 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugI1z-0000000Dpgb-1KHV
	for linux-nvme@lists.infradead.org;
	Mon, 28 Jul 2025 07:12:20 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD501216D6;
	Mon, 28 Jul 2025 07:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753686736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwbcK8h4ia/21i+CxKfkw0jTy/iZ/SKLDBy/roNwJsE=;
	b=dXSt42MxsxHOg2rekfRRPWQdWVHmStDv5UjiAFro9g/j7l3d2800vDcdGvb7GevB1l1d52
	oF93+QWZA0V0W5CKq5S9J2BzMmkCzg73FvdhbXDkKgBzJY2lAIR81J6cPGoIj8xBiNcHrD
	99cdkW3MZOG7o0Bh3d1gGrRrkifGMco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753686736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwbcK8h4ia/21i+CxKfkw0jTy/iZ/SKLDBy/roNwJsE=;
	b=91y1aSQIeE56N7dFYMCnis09XNUkY6Stiu4/vYBujiigL6FbM0QxCPP6vgW/o3MkiJlFV8
	j2+6T0pweoluqqCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GqXsRCrL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1H6KMxWK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753686735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwbcK8h4ia/21i+CxKfkw0jTy/iZ/SKLDBy/roNwJsE=;
	b=GqXsRCrLUlNz9afwEWSCv+JN04UHFDPvwxG8FXo3M1+pmCEiYxFL0UjaQ13gihxtQrYbO0
	3G6Yd03cDf0fDC7JZv7WciiNqCjvS7ZWBkppKDgAFllnGf6iy72k8+QQphUmql+cZlGow7
	C2bWjg4dG9tBdO2z5Wv/DPeDL2s6254=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753686735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwbcK8h4ia/21i+CxKfkw0jTy/iZ/SKLDBy/roNwJsE=;
	b=1H6KMxWK/byu4ktyxKRBmswH8vqMSFJ+L75dh+kh1i0G3JmEPPRgZvrnrSXyu6ukmoICp0
	5fQ5naZNbiDpWHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA8BD138A5;
	Mon, 28 Jul 2025 07:12:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3kxuJ88ih2g+AgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 28 Jul 2025 07:12:15 +0000
Message-ID: <df8bfa36-c1a9-4398-8246-5bc31991b8c9@suse.de>
Date: Mon, 28 Jul 2025 09:12:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libnvme: TLS PSK derivation fixes
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Prashanth Nayak <prashanth.nayak@netapp.com>,
 John Meneghini <jmeneghi@redhat.com>
References: <20250721021718.1159879-1-cleech@redhat.com>
 <20250721021718.1159879-2-cleech@redhat.com>
 <d8f4ed91-3fcb-45b9-b4d6-900382eb4ae7@suse.de>
 <aH5dbhXOS8h9gxzX@cleech-thinkpadt14sgen2i.rmtusor.csb>
 <3c3c3194-7275-4a77-9397-4c159458f2c5@suse.de>
 <aIPINwQZNxk_7FZs@cleech-thinkpadt14sgen2i.rmtusor.csb>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aIPINwQZNxk_7FZs@cleech-thinkpadt14sgen2i.rmtusor.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DD501216D6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250728_001219_520597_9687C8AE 
X-CRM114-Status: GOOD (  23.32  )
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

On 7/25/25 20:08, Chris Leech wrote:
> On Fri, Jul 25, 2025 at 11:36:20AM +0200, Hannes Reinecke wrote:
>> On 7/21/25 17:31, Chris Leech wrote:
>>> On Mon, Jul 21, 2025 at 08:36:01AM +0200, Hannes Reinecke wrote:
>>>> On 7/21/25 04:17, Chris Leech wrote:
>>>>> There are issues with the Retained and TLS PSK derivations due to the
>>>>> implementation not adhering to the RFC 8446 definition of the
>>>>> HKDF-Expand-Label function.
>>>>> ...
>>>> Hmm. I _thought_ we had it all fixed...
>>>
>>> I went into this expecting/hoping to find the problem on the spdk side,
>>> and I'd be happy to wrong here (especially if backed up by another
>>> interoperable implementor).
>>>
>>> The lack of a full example in the nvme/tcp transport spec to verify
>>> implemenatations against is kind of a bummer.
>>>
>> Okay, seems that you have been right after all.
>> I've re-read RFC 8466 and indeed you seem to be right about
>> the encoding of variable length vectors (cf RFC 8446 section 3.4).
>>
>> So I guess we need to take this patch after all.
> 
> So we're back to agreeing on the correctness of the changes?
> Honestly, I appreciate the scrutiny.
>   
Yeah, sorry. I indeed misread (or rather ignored) section 3 from the
RFC when coding the key derivation.
You are correct, and we need to prefix each string with the length.

But: this is an incompatible change. Once we integrate this patch
the keyring will end up with a _different_ derived PSK than it would
without that patch. So the _same_ PSK (in interchange format) will
result in different PSKs in the keyring, causing the handshake to
fail if the other side is not aware of that.

>> _However_: PSKs generated with after applying this patch will be
>> different than those prior to this patch.
>> Consequently there will be interop issues with existing implementations
>> (which will use the original encoding).
>>
>> I guess we would need to wait for the target implementations to be fixed
>> or introduce a flag switching to the old / compat implementation to avoid
>> interop issues.
> 
> Yes, it is a breaking change for compatibility with other out-of-spec
> implementations.  I'm hesitant to carry a flag for that, but it wouldn't
> be too much trouble to implement.
> 
> Just don't touch your keyfile?  The tls-key import/export commands are
> operating on the final derived TLS PSKs right?
> 
That might be the way out, and in fact what we should be doing.
However, the fact still remains: after this patch has been applied
one _cannot_ generate new PSKs until the other side has been updated,
too.
For linux it's easy, we can just require 'version xyz' from libnvme
and the issue is solved. But for other implementations?
There are IHVs out there who already shipped their products with TLS
enablement, and they need to be fixed, too.
And their timeline is vastly longer than ours.

So to avoid us having to synchronize against all of the others I think
it might be easier to add a 'compat' flag of sorts to generate PSKs
with the 'original' derivation algorithm, and then increase the
libnvme version number once it's in.
Then we can point the IHVs to that number so that they reference
that version once their firmware is updated.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

