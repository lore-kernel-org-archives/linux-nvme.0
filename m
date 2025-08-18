Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44713CA0EEB
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XyFYjBEQsINigb+toYzs+CWlACWY/McyFy3NU7KW3xM=; b=a3qU6RLXfsc001W92t3wY/1CJX
	qH5VUP7QU52g0WibWjtwF47hAGufT19l3nY7r5KxyjS8FkfLYwVx2Ih+0d/jqOjys2wg9Gzb6f2w3
	hDgKXyv5KrkCD4TLL/bRlFhmxa64oSwvNJPRGYP+BqMXCnWFHopuljJonmL/vkpDu/ww3KRAF9cHj
	mYVuaTWRiW6PgxyGge/ggu2UE1ElvezJNYkfm8jIB/0RaKjnMYR31SrkwcnIIHy2tYi5VIWCN74SM
	4cq99McxmuuaksNu+5aJt6H4T08q4E7nS+oOzw3txmQp5VdrXiN/Q4m5zw1pxqx2OzOZrZV4zAyXI
	78X0A++Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo06z-00000007a2m-1ci4;
	Mon, 18 Aug 2025 13:41:21 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unwNp-000000075C3-1Hkc
	for linux-nvme@lists.infradead.org;
	Mon, 18 Aug 2025 09:42:30 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8FF122125B;
	Mon, 18 Aug 2025 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755510147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyFYjBEQsINigb+toYzs+CWlACWY/McyFy3NU7KW3xM=;
	b=rEUiBJqQAGApY+hNA4dKoyK6nOQakfBR1bXm+l07+Nbnw05cFqoIzfTTfUu6RxL6emtMt9
	ZroFq4z0RoEVC0TJIowRKNkEk0AzhpIrafXG2BDGnNNzFr+xY9FrviNk8FI6z4cDcEb7yi
	o13BiO5jbCdvwCr7/+4vT/irmDmSNqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755510147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyFYjBEQsINigb+toYzs+CWlACWY/McyFy3NU7KW3xM=;
	b=nl/ZKVm24CYqUj6r56lPnkCV487TwMBFpqTJTdpTQv/zBlpHNr+YnzWa6KBAPMVhUhRm26
	eyKSrtuDBdZzLbDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755510147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyFYjBEQsINigb+toYzs+CWlACWY/McyFy3NU7KW3xM=;
	b=rEUiBJqQAGApY+hNA4dKoyK6nOQakfBR1bXm+l07+Nbnw05cFqoIzfTTfUu6RxL6emtMt9
	ZroFq4z0RoEVC0TJIowRKNkEk0AzhpIrafXG2BDGnNNzFr+xY9FrviNk8FI6z4cDcEb7yi
	o13BiO5jbCdvwCr7/+4vT/irmDmSNqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755510147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyFYjBEQsINigb+toYzs+CWlACWY/McyFy3NU7KW3xM=;
	b=nl/ZKVm24CYqUj6r56lPnkCV487TwMBFpqTJTdpTQv/zBlpHNr+YnzWa6KBAPMVhUhRm26
	eyKSrtuDBdZzLbDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D72613A55;
	Mon, 18 Aug 2025 09:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tAsqHoP1omgOPgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 18 Aug 2025 09:42:27 +0000
Message-ID: <909b62b0-f7ef-4604-9618-930ca0645861@suse.de>
Date: Mon, 18 Aug 2025 11:42:27 +0200
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
 <df8bfa36-c1a9-4398-8246-5bc31991b8c9@suse.de>
 <aJrEAia9jVk17y-j@my-developer-toolbox-latest>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aJrEAia9jVk17y-j@my-developer-toolbox-latest>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_024229_642699_FE7BBC31 
X-CRM114-Status: GOOD (  35.44  )
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

On 8/12/25 06:33, Chris Leech wrote:
> On Mon, Jul 28, 2025 at 09:12:15AM +0200, Hannes Reinecke wrote:
>> ...
>> But: this is an incompatible change. Once we integrate this patch
>> the keyring will end up with a _different_ derived PSK than it would
>> without that patch. So the _same_ PSK (in interchange format) will
>> result in different PSKs in the keyring, causing the handshake to
>> fail if the other side is not aware of that.
>>
>>>> _However_: PSKs generated with after applying this patch will be
>>>> different than those prior to this patch.
>>>> Consequently there will be interop issues with existing implementations
>>>> (which will use the original encoding).
>>>>
>>>> I guess we would need to wait for the target implementations to be fixed
>>>> or introduce a flag switching to the old / compat implementation to avoid
>>>> interop issues.
>>>
>>> Yes, it is a breaking change for compatibility with other out-of-spec
>>> implementations.  I'm hesitant to carry a flag for that, but it wouldn't
>>> be too much trouble to implement.
>>>
>>> Just don't touch your keyfile?  The tls-key import/export commands are
>>> operating on the final derived TLS PSKs right?
>>>
>> That might be the way out, and in fact what we should be doing.
>> However, the fact still remains: after this patch has been applied
>> one _cannot_ generate new PSKs until the other side has been updated,
>> too.
>> For linux it's easy, we can just require 'version xyz' from libnvme
>> and the issue is solved. But for other implementations?
>> There are IHVs out there who already shipped their products with TLS
>> enablement, and they need to be fixed, too.
>> And their timeline is vastly longer than ours.
>>
>> So to avoid us having to synchronize against all of the others I think
>> it might be easier to add a 'compat' flag of sorts to generate PSKs
>> with the 'original' derivation algorithm, and then increase the
>> libnvme version number once it's in.
>> Then we can point the IHVs to that number so that they reference
>> that version once their firmware is updated.
> 
> I've spent a bit of time on this, and while I don't have patches ready
> to share just yet I do think it's worth commenting on the scope of the
> change to keep the existing functionality behind a cli switch.
> 
>   libnvme:
>   - keeping both sets of key derivation functions (this is not bad)
>   - need to expose that functionality, so new exported APIs
>     (I was thinking something like a flag field over a legacy-only function)
>        - #define NVME_TLS_PSK_LEGACY (1u << 0)
>        - char *nvme_generate_tls_key_identity_2(..., unsigned int flags)
>        - long nvme_insert_tls_key_versioned_2(..., unsigned int flags)
> 
>   - support paths that load keys through nvme_fabrics_cfg [1]
>     (for nvme-cli fabrics commands that take --tls_key)
>        - add some sort of flag there, like nvme_fabrics_cfg.tls_legacy
>        - add to merge_config, nvmf_update_config, build_options,
>          supported_options, etc.
> 
>   - the JSON schema/code would need to support this for persistent
>     configurations
> 
>   nvme-cli:
>   - add a command line flag to keyring command functions
>   - convert to use of new libnvme APIs to pass flag
>         - gen_tls_key, check_tls_key
>          (I don't think nvme_tls_key does key conversions)
> 
>   - add command line flag to generic parsing into nvme_fabrics_cfg
>         - handles connect, connect-all, discover, discover-all
> 
>   - man pages, shell completions, etc.
> 
> It may be possible to keep this to just in libnvme and switch on an
> environment variable, but that sounds like just as big of a support
> nightmare as remembering to pass an option to every command.
> 
> If we don't have a resolution by then, maybe this is something we can
> resolve at ALPSS.
> 
> [1] Side note; with nvme_fabrics_cfg _not_ being allocated through
> libnvme, I don't see how the various additions there can be ABI safe. It
> looks to me like this struct alone broke ABI in libnvme 1.4, 1.8, 1.9,
> and 1.11.
> 
My thoughts are slightly different.
I do agree that we need to change the default from nvme-cli to use the
correct key derivation.
But for compat we should be using the 'tls-key' function, and add a 
'compat' flag there. That way we don't need to modify 'gen-tls-key'
or 'check-tls-key', and have a single place to handle compat issues.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

