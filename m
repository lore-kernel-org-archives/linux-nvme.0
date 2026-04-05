Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6C2EEB577
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Apr 2026 12:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vYueGZ0CiuUgSMM8mx2US3E7rzz17gW/yaKQKaHnRGU=; b=NYwP4SvbgZz0s3WyLTgCkk9ab2
	3tyC4W9fPk5CcIJgpMaH4qCnuhf4Z6BijO0jxMt79lTHizAQTApGt0u4jojiV4FDBMoDJAoa1IzOl
	4xgcBUz3cXftoIhiqnQ52bXTn7nerDfYUUAAcB1LrX7QH+FtQ/vQvErrpKBMty2/PxY/tA/on7fxl
	ozQVWJIqgExOIRbAMP5Ekrwo9lJth+345dH0MXonMI3wqLaLOlP7PbX/Asz1T8JArpsHTovJI/g2b
	nzZQ6fZi0RGNVf+FihO1NbHdoKwffiM9UArEfQpXKaydODE3weFX5fCSlJjCZbFJxCj3sYW+bJMKr
	1EuSIQ+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9N3R-00000004DCf-0fOx;
	Sun, 05 Apr 2026 12:58:17 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9N3L-00000004DBk-3ifG
	for linux-nvme@lists.infradead.org;
	Sun, 05 Apr 2026 12:58:15 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2268D4D7AE;
	Sun,  5 Apr 2026 12:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775393887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYueGZ0CiuUgSMM8mx2US3E7rzz17gW/yaKQKaHnRGU=;
	b=QT267Gryvpkby3kN59Qub8n9Xs2nVqe3JShI6xJBcbP/zWcfN6HZlxbUMvmLYJnWmp+bpL
	XrFudSVPv3qKBa2ILSH366oLCugWw7pgo66X43KtC1tLddm4SozeyD/YXvBVnG33atQ8Ue
	jOQWlNtC1vrQrHTSVBHchGrIQHUjyv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775393887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYueGZ0CiuUgSMM8mx2US3E7rzz17gW/yaKQKaHnRGU=;
	b=WZeNipIuScsID2/RPaWA8OyLKkPN2ubiIr3l2ezHm9Ma/tldrAJikqbR3ZLGNBwQZ8lnoz
	/WWzmf9n8Lc1RNAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775393887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYueGZ0CiuUgSMM8mx2US3E7rzz17gW/yaKQKaHnRGU=;
	b=QT267Gryvpkby3kN59Qub8n9Xs2nVqe3JShI6xJBcbP/zWcfN6HZlxbUMvmLYJnWmp+bpL
	XrFudSVPv3qKBa2ILSH366oLCugWw7pgo66X43KtC1tLddm4SozeyD/YXvBVnG33atQ8Ue
	jOQWlNtC1vrQrHTSVBHchGrIQHUjyv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775393887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYueGZ0CiuUgSMM8mx2US3E7rzz17gW/yaKQKaHnRGU=;
	b=WZeNipIuScsID2/RPaWA8OyLKkPN2ubiIr3l2ezHm9Ma/tldrAJikqbR3ZLGNBwQZ8lnoz
	/WWzmf9n8Lc1RNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E29DD4A0B0;
	Sun,  5 Apr 2026 12:58:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0YY6NF5c0mllRwAAD6G6ig
	(envelope-from <hare@suse.de>); Sun, 05 Apr 2026 12:58:06 +0000
Message-ID: <4080e4d2-6a95-4d6e-ba53-e576855aac16@suse.de>
Date: Sun, 5 Apr 2026 14:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] block/nvme: exploring asynchronous durability notification
 semantics
To: Esteban Cerutti <esteban.cerutti@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <ac7eHEnFQlLN-vDy@yanara>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ac7eHEnFQlLN-vDy@yanara>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260405_055814_271629_24CA4E0E 
X-CRM114-Status: GOOD (  23.27  )
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

On 4/2/26 23:22, Esteban Cerutti wrote:
> Hi,
> 
> I would like to explore whether current NVMe completion semantics
> unnecessarily conflate execution completion with durability, and
> whether there is room for a more explicit, asynchronous durability
> notification model between host and device.
> 
> Today, a successful write completion indicates command execution,
> but not necessarily physical persistence to non-volatile media unless
> FUA or Flush is used. This forces the kernel and filesystems to assume
> worst-case durability behavior and rely on synchronous flushes and
> barriers for safety.
> 
Not necessarily. Synchronous flushes and barriers are really only
an issue for ext4 (which happens to rely on that). Other filesystems
like btrfs work happily without that.
It's more a design choice; explicit flushes guarantee global visibility,
something which you need if you have things like superblocks at fixed
positions. But if you haven't (like btrfs) than you are perfectly fine
using per-request flushes (eg to ensure the log has been written), and
then you don't need a global flush.

> The device internally knows when data is staged in volatile buffers
> versus committed to NAND (or equivalent persistent media), but this
> information is not exposed to the host.
> 
... and not available to the host.
I'm not aware of any command (or I/O completion information) which
would tell you if and when an I/O cached internally in the drive is
written to disk.

> This RFC explores a potential extension model with two components:
> 
> 1) Multi-phase completion semantics
> 
>     - Normal completion continues to signal execution.
>     - The device assigns a persistence token ID.
>     - When the data is physically committed to non-volatile media,
>       the device emits an asynchronous durability confirmation
>       referencing that token.
> 
> This would decouple execution throughput from durability
> confirmation and potentially allow filesystems to close journal
> transactions only upon confirmed persistence, without forcing
> synchronous flush fences.
> 
... or redesign your filesystem to _not_ rely on synchronous flushes.

> 2) Advisory write intent classification
> 
>     - Host-provided hints such as EPHEMERAL, STANDARD, or CRITICAL.
>     - CRITICAL writes would request immediate durability.
>     - EPHEMERAL writes could tolerate extended volatile staging.
> 
> Additionally, I am curious whether host power-state awareness
> could be relevant in such a model. For example, if the kernel
> can detect battery-backed operation or confirmed UPS
> infrastructure, it could advertise a bounded persistence
> relaxation window (e.g. guaranteed power for N ms), allowing
> the device to safely extend volatile staging within that
> window. This would be advisory and revocable, not a mandatory
> trust model.
> 
Been there, done that. Really hard to ensure.
Some RAID controllers try to do something here by not
advertising volatile cache if battery backup is not present,
but that's a really lame thing as you need to ensure that
you have enough power to keep the HDDs running after a
power outage until you have written out all data.
It's getting even harder for on-board HBAs where you have
no distinct power rails for the HDDs; you'd need to have
a battery large enough to keep the entire system running,
but that would be massively overprovisioned for 99% of the
time. And hence far too expensive.

Doubt it's worth it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

