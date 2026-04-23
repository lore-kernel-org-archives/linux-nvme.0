Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31333F9937D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 12:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JzWAwcSqg2N/gPOfalJUwSkBJ+jo7FJXWZjvPXEvVAs=; b=XfWoQePsBfUib4QQSANuXX/km5
	iUwOIC1xwRJBkWVkmT7BTTOQ5doSISo4SBYmWd7NWWb8rKEkG6d43C/zrIjWS1fHPCDwPW2IUKam2
	oHuy0tRkpHEbMAYxWhQxeiogc+GUiHAnw3OhMUdKaWLtG7OBzUNpvJzzUdVeAmOGhU7qPo+CrBiw+
	/jUsuAH5bt2nC9h1xquD3tIGVI7F0IfMH9wLlthp96yZJRqUjkjKHb4/lZiQPt4awRwLsM8AketaA
	WJdAoSdB3aYWGEU2fl1rHYSYl+yuDHsf4ZoVHmF19UEmuKiyWtPGQ6NaY5prcsMUSAXKHQkRbOn+0
	jbVrp35g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFsof-0000000BaFl-0Tky;
	Thu, 23 Apr 2026 12:05:57 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFsoX-0000000BaDb-3FKW
	for linux-nvme@lists.infradead.org;
	Thu, 23 Apr 2026 12:05:54 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BD686A86F;
	Thu, 23 Apr 2026 12:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776945946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzWAwcSqg2N/gPOfalJUwSkBJ+jo7FJXWZjvPXEvVAs=;
	b=Y0endpVDnin4gHfzJGlCIzDR7rPJCbouSuQ5+oC4Cqiy58uj1dbZqlNhpTXjRukD0U35Ne
	4CWpM4dZAAZ5i1SFCa7GtVnKVrkD5mKpHponrg9tLr42fIquKfJ64vCF1TTIsvcxHDaSS6
	vLTOdOUOGJxnkzhiCZUkKJTD02kMQwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776945946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzWAwcSqg2N/gPOfalJUwSkBJ+jo7FJXWZjvPXEvVAs=;
	b=H1YRJXrkYTKjOau37ecG4U6hEvIvOlqIrxzAbLfpc8FMqDcn5jLzMbOV+CagqRdUWXy9za
	KrNf4+zqqLW+VdBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776945946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzWAwcSqg2N/gPOfalJUwSkBJ+jo7FJXWZjvPXEvVAs=;
	b=Y0endpVDnin4gHfzJGlCIzDR7rPJCbouSuQ5+oC4Cqiy58uj1dbZqlNhpTXjRukD0U35Ne
	4CWpM4dZAAZ5i1SFCa7GtVnKVrkD5mKpHponrg9tLr42fIquKfJ64vCF1TTIsvcxHDaSS6
	vLTOdOUOGJxnkzhiCZUkKJTD02kMQwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776945946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzWAwcSqg2N/gPOfalJUwSkBJ+jo7FJXWZjvPXEvVAs=;
	b=H1YRJXrkYTKjOau37ecG4U6hEvIvOlqIrxzAbLfpc8FMqDcn5jLzMbOV+CagqRdUWXy9za
	KrNf4+zqqLW+VdBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A826593A3;
	Thu, 23 Apr 2026 12:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yY+eDRoL6mm0VAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 23 Apr 2026 12:05:46 +0000
Message-ID: <58b7e84a-20a4-44ae-b933-b89ab0fe265a@suse.de>
Date: Thu, 23 Apr 2026 14:05:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC nvme-keyring nvme-cli] Should NVMe/TLS PSKs support the
 request_key API?
To: Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>, Maurizio Lombardi <mlombard@redhat.com>
References: <20260422231043.2689681-1-cleech@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260422231043.2689681-1-cleech@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_050549_963399_992C1FE5 
X-CRM114-Status: GOOD (  30.68  )
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

On 4/23/26 01:10, Chris Leech wrote:
> Would it be of interest to support the request_key API with NVMe/TLS
> PSKs? I think it would be an improvement, allowing PSKs to be loaded
> into the keyring as needed.
> 
Hehe. I knew someone would bring it up :-)

> Issues (if it was simple I'd just send a patch):
> 
>   - a key cannot have it's description changed
>   - request_key() creates an uninstantiated key with the description set
>   - tlshd (ktls-utils) uses the description as the PSK Identity
>   - NVMe specifies this Identity in a way that the kernel cannot know it
>     when a request_key() would be needed (it includes an encoding of the
>     key length and a digest of the source key it was derived from)
> 
That is correct.

> As nvme_keyring can't just request the key it needs, I went through a
> few ideas:
> 
>   - request a new keyring full of PSK keys
>     (requesting a keyring is explicitly blocked)
>   - have the user-space handler create a temporary keyring, put one or
>     more PSKs in it, and return the keyring serial in a "psk request key"
>     (worked, but seems unlikely to be accepted as intended use)
>   - have a request key format that expects to receive a key containing
>     one or more PSKs + identity metadata, unpack those in the kernel into
>     actual psk keys than can be used
> 
> I'm going to follow this with a _rough_ prototype of the last option in
> that list. The user-space side is a shell script, I'd replace that with
> an new nvme-cli command (but the request_key configuration does
> provide a convenient place to allow for other key storage solutions to
> hook in).
> 
> Motivation: The current solution for loading NVMe/TLS PSKs into the
> kernel keyring (70-nvmf-keys.rules in the nvme-cli repo) falls short in
> a few areas by triggering from a kmod load uevent:
> 
>   - doesn't work for the target modules
>     (that one's easy, /nvme_tcp/nvme_keyring/)
>   - doesn't work if the modules are built into the kernel
>   - doesn't work if the modules are loaded from initramfs, with more PSKs
>     and connections are configured outside of the nBFT
>   - only runs once, must load all keys and cannot help with new keys
>     (ok, nvme-cli doesn't have a command to save to a keyfile without
>      importing to the keyring first anyway)
> 
>   Biggest problem I see, requiring explicit loading of nvme_tcp before it
>   can be used with TLS:
> 
>   - The async uevent handling loses the race against the kernel when the
>     transport kmod is requested on demand.
> 
>    ┌────────┐     ┌──────────┐     ┌──────────┐     ┌──────┐
>    │ kernel │     │ nvme-cli │     │ modprobe │     │ udev │
>    └────┬───┘     └─────┬────┘     └─────┬────┘     └───┬──┘
>         │               │                │              │
>         │ connect       │                │              │
>         │◄──────────────┤                │              │
>         │               │                │              │
>         │ request kmod  │                │              │
>         ├───────────────────────────────►│              │
>         │               │                │              │
>         │ load kmod     │                │              │
>         │◄───────────────────────────────┤              │
>         │               │                │              │
>         │ uevent kmod   │                │              │
>         ├╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌►│
>         │               │                │              │
>         │ check keyring for PSK ❌       │              │
>         ├──┐            │                │              │
>         │  │            │                │              │
>         │◄─┘            │                │              │
>         │               │                │              │
>         │ connect failed ❌              │              │
>         ├──────────────►│                │              │
>         │               │                │              │
>         │               │ nvme tls --import --keyfile   │
>         │               │◄──────────────────────────────┤
>         │               │                │              │
>         │ populate .nvme keyring         │              │
>         │◄──────────────┤                │              │
>         │               │                │              │
> 
> - Chris
>
(Nice ASCII graphic, btw :-)

I know, the current model is ever so imperfect.
And relying on udev _module_ events clearly requires them
to be modules in the first place.
(Fun fact: I am rather positive that we _do_ get the module
uevents even when built in, it's just that they'll be issues
right at the start of the kernel where no udev (nor any userspace)
is available to process them ...)

But anyway; why can't we tweak nvmf-autoconnect.service to load
the keys?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

