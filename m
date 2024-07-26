Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8AEC3DA49
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jul 2024 06:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R4AoZW+ieoAyhFjTTvcJye669tIRCsLBnaaV2INMGss=; b=3ntTyv3JiffekzjAMKEGvS/hy4
	uEX9gtHg3sYviePLljXYz4BZD9OXy7KpMIGGoAaaHAuTu1Y5gbRfxWHCWLe0JY+7n4/aBb8mTHznH
	OdS1pyvosjMnWXfCMHekEdqlqtOqzgjh8MQWVhhEQSElxSc+4+DvSmvfCdY0Wv/lrXYC9yj/ZyiSm
	NOf9YG4Ao0LIibjg88ihdKB2FJi7CHLsswGkFqqz5yEV0ZQ6zkQ5bzKfVcoY36k+AYqoN8DxZbXWe
	dGTvadmAYX4uHIHRDuu1MPt27SjxvwM0ETltnb7aqVP5WnkmTL6Y1eZv9va1ICsSP+nkQFQV4fezq
	eTM81oTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXEGU-000000031qv-1BGQ;
	Fri, 26 Jul 2024 06:17:18 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXEGP-000000031qA-3DWV
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jul 2024 06:17:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF913219F4;
	Fri, 26 Jul 2024 06:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721974631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4AoZW+ieoAyhFjTTvcJye669tIRCsLBnaaV2INMGss=;
	b=rxuuFMU8No+SKBr9PH4x8MDfkRh1VTUg3GyJ71YqPuC1bmw6hmCNogk17nbHb9ujQTIuOz
	TQ06LiQ5mJoKDU764IbVi0pzcfqJZHqk9SSVeuC+sa4FhBYrP9Cz/Qk0iIMN0id9ucgTzH
	zWkRFRAxT4fCXvg+hjQxXhBN7jaIasg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721974631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4AoZW+ieoAyhFjTTvcJye669tIRCsLBnaaV2INMGss=;
	b=xUD16lYrw7XYxNtJHATOO1QOOT8AqQy4QT08z19XD/H10+pA6lGH2lRSHem/HxScdAgo+K
	YEBOvzA2nWEpNVDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wvNrJMST;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dYoxhtBi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721974630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4AoZW+ieoAyhFjTTvcJye669tIRCsLBnaaV2INMGss=;
	b=wvNrJMSTrSuRpmQMUDdIW0vGoEHJbBuZ9Zk9Pf39NnucZ55HhRYmqJ+YpcbnKH98HAZaH4
	bQN79va6dbFHg99qBW7OYIuAs6PaIFNbvBr3Amw43Wq7x2cJVpYpC1uUw7NLow1z663nJq
	jKnb3KapZTv0YuTPuU8F/6/0EVf63kY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721974630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4AoZW+ieoAyhFjTTvcJye669tIRCsLBnaaV2INMGss=;
	b=dYoxhtBiy3o1HmVI7eYHi69ZTXnQFbH/pJZEEG3572LD1Slv2nxGY7eFh58O01bWmswYF7
	0C5n2MEXusTXEJAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69235138A7;
	Fri, 26 Jul 2024 06:17:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y/NgF2Y/o2anDQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 26 Jul 2024 06:17:10 +0000
Message-ID: <334a583f-0cd1-41bd-9361-766a486c115a@suse.de>
Date: Fri, 26 Jul 2024 08:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] nvmet-tcp: support secure channel concatenation
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-crypto@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240722142122.128258-1-hare@kernel.org>
 <20240722142122.128258-9-hare@kernel.org>
 <20240723014854.GC2319848@google.com>
 <f69aee16-8238-48cc-986a-6d9dc7f6d933@suse.de>
 <20240725172118.GA2020@sol.localdomain>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240725172118.GA2020@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BF913219F4
X-Spamd-Result: default: False [-6.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240725_231713_981446_9A169317 
X-CRM114-Status: GOOD (  25.46  )
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

On 7/25/24 19:21, Eric Biggers wrote:
> On Thu, Jul 25, 2024 at 01:50:19PM +0200, Hannes Reinecke wrote:
>> On 7/23/24 03:48, Eric Biggers wrote:
>>> On Mon, Jul 22, 2024 at 04:21:21PM +0200, Hannes Reinecke wrote:
>>>> +	ret = nvme_auth_generate_digest(sq->ctrl->shash_id, psk, psk_len,
>>>> +					sq->ctrl->subsysnqn,
>>>> +					sq->ctrl->hostnqn, &digest);
>>>> +	if (ret) {
>>>> +		pr_warn("%s: ctrl %d qid %d failed to generate digest, error %d\n",
>>>> +			__func__, sq->ctrl->cntlid, sq->qid, ret);
>>>> +		goto out_free_psk;
>>>> +	}
>>>> +	ret = nvme_auth_derive_tls_psk(sq->ctrl->shash_id, psk, psk_len,
>>>> +				       digest, &tls_psk);
>>>> +	if (ret) {
>>>> +		pr_warn("%s: ctrl %d qid %d failed to derive TLS PSK, error %d\n",
>>>> +			__func__, sq->ctrl->cntlid, sq->qid, ret);
>>>> +		goto out_free_digest;
>>>> +	}
>>>
>>> This reuses 'psk' as both an HMAC key and as input keying material for HKDF.
>>> It's *probably* still secure, but this violates cryptographic best practices in
>>> that it reuses a key for multiple purposes.  Is this a defect in the spec?
>>>
>> This is using a digest calculated from the actual PSK key material, true.
>> You are right that with that we probably impact cryptographic
>> reliability, but that that is what the spec mandates.
> 
> How set in stone is this specification?  Is it finalized and has it been
> implemented by anyone else?  Your code didn't correctly implement the spec
> anyway, so at least you must not have done any interoperability testing.
> 
Well ... thing is, this _is_ the first implementation. Anyone else does 
interop testing against us.
The spec is pretty much set in stone here; sure we can update the spec, 
but that takes time. I can ask the primary author if he's willing to
engage in a conversation about the cryptographic implications if you are 
up to it.

>>
>> Actual reason for this modification was the need to identify the TLS PSKs
>> for each connection, _and_ support key refresh.
>>
>> We identify TLS PSKs by the combination of '<hash> <hostnqn> <subsysnqn>',
>> where '<hostnqn>' is the identification of the
>> initiator (source), and '<subsynqn>' the identification of the
>> target. But as we regenerate the PSK for each reset we are having
>> a hard time identifying the newly generated PSK by the original
>> '<hash> <hostnqn> <subsysnqn>' tuple only.
>> We cannot delete the original TLS PSK directly as it might be used
>> by other connections, so there will be a time where both PSKs
>> are valid and have to be stored in the keyring.
>>
>> And keeping a global 'revision' counter is horrible, the alternative
>> of having a per-connection instance counter is similarly unpleasant.
>>
>> Not ideal, true, so if you have better ideas I'd like to hear them.
>>
>> But thanks for your consideration. I'll be bringing them up.
>>
> 
> You are already using HKDF, so you could just use that, similar to how fscrypt
> uses HKDF to derive both its key identifiers and its actual subkeys.  HKDF can
> be used to derive both public and non-public values; there's no need to use a
> separate algorithm such as plain HMAC just because you need a public value.
> 
I will check. But at this time I fear we have to stick with this 
implementation because that's what the spec mandates.

But thanks for the review, very much appreciated.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


