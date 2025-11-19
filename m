Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA01CF2594
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 07:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QA91sk6/b2FTDoND0YZC1XGKrqCPMgV24aCLfkYosS0=; b=Sjd60WmQr1wJP736MJLDglUF3E
	ZKgG5dlkM6q0QUf8usAF1dCd+ncLQWLFaZNszVy8X/DxvQpqmmYxcbD5H/AoJiaOXAodgjCAiMZT7
	16JRdIMEPBXTvUPDBikRLHb9nOXid7mv9NAUulHoBYdWwfb3YJ/9rDjM2sw5h/iZpmUAgPaIatp7o
	npjtRVbArMw2SOmwXD+Zt8GpKZKF/OSlB8EsdYvCRCkdJm2/+F9sWjds7zMcqEIIkOvCQsEdSssHO
	iFu3jj1XwFRQZuaoUvwZIvkVh/yJMlgmeH7+yPCPAGdGrEHTBfPBU46UH6dlRZcCWJWq4/jmvdhg8
	cTWFQnTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcsJ-00000002jXM-2ONP;
	Wed, 19 Nov 2025 07:45:11 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcsF-00000002jVB-17DY
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 07:45:09 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9AC4220305;
	Wed, 19 Nov 2025 07:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763538302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QA91sk6/b2FTDoND0YZC1XGKrqCPMgV24aCLfkYosS0=;
	b=JnCtVDiL8EBIWkh4ELYBurNUITrlkstjbauZoFqPwfbHFZRY9TXwECMBxNy06V2f64TTyh
	H0AeRaXE2ICYgLvZ7QJ1sTnvw3XB1Bi5FGfCxOV5sU5pOnG0HVj/0FUKimrq4fuM1Z9UVd
	FqZLktW8b21DK7tAN79lhnTCyNf3Qys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763538302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QA91sk6/b2FTDoND0YZC1XGKrqCPMgV24aCLfkYosS0=;
	b=UMGh4I0LoLn9x6rE6ekuaVzPruiIKLtBww4HUBsBC9xniZHGE+PFW3RfgABpSCqeq0A7ak
	+XHabTuFH6Jl8UBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763538302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QA91sk6/b2FTDoND0YZC1XGKrqCPMgV24aCLfkYosS0=;
	b=JnCtVDiL8EBIWkh4ELYBurNUITrlkstjbauZoFqPwfbHFZRY9TXwECMBxNy06V2f64TTyh
	H0AeRaXE2ICYgLvZ7QJ1sTnvw3XB1Bi5FGfCxOV5sU5pOnG0HVj/0FUKimrq4fuM1Z9UVd
	FqZLktW8b21DK7tAN79lhnTCyNf3Qys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763538302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QA91sk6/b2FTDoND0YZC1XGKrqCPMgV24aCLfkYosS0=;
	b=UMGh4I0LoLn9x6rE6ekuaVzPruiIKLtBww4HUBsBC9xniZHGE+PFW3RfgABpSCqeq0A7ak
	+XHabTuFH6Jl8UBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E67303EA61;
	Wed, 19 Nov 2025 07:45:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RL9JNn11HWlQbAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 19 Nov 2025 07:45:01 +0000
Message-ID: <60e86d7c-f926-4b75-96eb-dc8fd8a06ee8@suse.de>
Date: Wed, 19 Nov 2025 08:45:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] nvme: Allow reauth from sysfs
To: Alistair Francis <alistair23@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251114045850.1898865-1-alistair.francis@wdc.com>
 <20251114045850.1898865-5-alistair.francis@wdc.com>
 <e15b39ad-bfdf-4177-86b7-99c84975825e@suse.de>
 <CAKmqyKNViQjZHyftdj7anoF1Wsf9qeRZQiZ9yfM_FsJAcmx7jg@mail.gmail.com>
 <fd9c30d3-2a9f-4ddc-9d71-436034637acb@suse.de>
 <CAKmqyKMNESv2T=0pqVAqXg-5NfmTJ1qzaHAi3c9e7tCe5uF6Kw@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKMNESv2T=0pqVAqXg-5NfmTJ1qzaHAi3c9e7tCe5uF6Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_234507_472219_207DB245 
X-CRM114-Status: GOOD (  29.64  )
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

On 11/19/25 01:24, Alistair Francis wrote:
> On Tue, Nov 18, 2025 at 9:50 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 11/18/25 01:52, Alistair Francis wrote:
>>> On Fri, Nov 14, 2025 at 5:15 PM Hannes Reinecke <hare@suse.de> wrote:
[ .. ]>>>>
>>>> Hmm.
>>>> Now we are just running (re-) authentication, but that does
>>>> not affect the TLS connection (which continues to use the
>>>> original key). So you would need to reset the connection
>>>> here to re-establish a new TLS connection.
>>>
>>> Is the connection supposed to be reset? I don't see any mention of
>>> that in the spec
>>>
>> Yeah, that's a bit hard to read (as usual).
>> The base spec just claims (Fig. 733, Secure Channel Protocol Identifiers):
>>
>> 03h: This {PSK, PSK Identity} pair replaces the {PSK, PSK Identity}
>>     pair that was used to set up the TLS secure channel over which the
>>     authentication transaction is performed.
>>
>> So from that your implementation is correct, as it just replaces the
>> PSK (without actually using them). However, the TCP spec clarifies
>> (section 3.6.1.4: PSK Use):
>>
>> Once the TLS secure channel for the Admin Queue of an association
>> has been set up with a generated {PSK, PSK Identity} pair, that
>> generated {PSK, PSK Identity} pair should be replaced periodically
>> (e.g., every hour) or on demand by performing a reauthentication
>> with the SC_C field in the AUTH_Negotiate message set to REPLACETLSPSK
>> (refer to the AUTH_Negotiate Message section of the NVM Express
>> Base Specification) over the Admin Queue of that association. The most
>> recently generated PSK, if any, is the generated PSK associated with
>> that Admin Queue.
> 
> Yeah, to me "associated with" doesn't necessarily mean that we reset
> the connection to use the new PSK.
> 
But then why would we want to replace the PSK if it's not used?Which 
would be completely pointless for secure concatenation, as
for _any_ connection establishment a new PSK will be generated.

And I've checked with FMDS, the intention really was that REPLACETLSPSK
should result in the new PSK to be _used_ for existing connections.

There's now a bug for this:
https://bugzilla.nvmexpress.org/show_bug.cgi?id=638
and it should be addressed with an ECN.

>>
>> And the only way to associate a PSK with the admin queue is to use
>> it for the TLS encryption, ie re-run the TLS handshake.
>>
>> Or indeed use the KeyUpdate mechanism.
> 
> This is the part that I think is weird.
> 
> If we do need to use the new PSK, once a host issues a REPLACETLSPSK
> we have to tear down and restart the TLS connection. Which seems
> really clunky and the spec doesn't seem to mention that at all.
> 
> If the host wants to replace the TLS keys it can just issue a
> KeyUpdate, which doesn't involve tearing down the entire connection.
> So do we actually need to reset the TLS connection after a
> REPLACETLSPSK?
> 
Oh, I fully agree. KeyUpdate would be the way to go to get a seamless
PSK replacement. But not all implementations do it (currently not even
the linux kernel :-), so in the absence of that we have to reset the
queue to start a new TLS handshake.

Cheers,Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

