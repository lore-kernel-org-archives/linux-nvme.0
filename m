Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CE7C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jan 2024 17:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uLW0pT7KV50tmxWJTneQghfWHHzZ5Z8730KEa5QXDrg=; b=DaW3wzTKKiWB+xBaVMXSK2IfPd
	h+ezZFZPADjBMdHBQqiLjz0OOY8BkNmuNCUzZCDbNuT2+yfUfdECGdDryfAL9C8qPEjpgReRaj5Kb
	xKava8nbRoIY5DXbUdfTW2QusuByVbO7uHSTApUvXHFAJ3r6HxXdvdGesRAqjUxjok7OtTuREAhPd
	jBzNJPYyJCFMTI4j3oSqOZZPgt55Eh2JFCb821dAXMiLOmnYHtUGzwJAeYS7RLeCewjgFu97MCI4F
	U1mYVlqvtWAJrvBK5mEov/m1zxWAsst+maI0P1o6bHV9tMPi+5dMz+GSQEjErc1PT/baOL9FBF+6Z
	UuHhrX3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMtbL-005m4c-2H;
	Mon, 08 Jan 2024 17:39:51 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMtbH-005m2j-32
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jan 2024 17:39:49 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E25B22200C;
	Mon,  8 Jan 2024 17:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704735582;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uLW0pT7KV50tmxWJTneQghfWHHzZ5Z8730KEa5QXDrg=;
	b=sXa8jd11TwgBsXpf2ZToeMv/bdY7G2clae2u2rMY7Feu/xbxONWz7z4TYy5QRdAjYn58+N
	00CLxMZX9svfzqxRPy2e33HeSswDfK+Ly0Nx4Y+kwenU7U2RNTq9uKkVPX3UWsZn2kzaYO
	jqNxJwY6sxNwSWHlEphc12FrG/H8QRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704735582;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uLW0pT7KV50tmxWJTneQghfWHHzZ5Z8730KEa5QXDrg=;
	b=00kTTAfMlcg6NOU15mJ26NSLIpLKh9IKr0M7yJJuuLjT2Q7eSzNWqhcDA8jVJPx8P8iAd7
	OtmrwbGLzRcmjbBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704735582;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uLW0pT7KV50tmxWJTneQghfWHHzZ5Z8730KEa5QXDrg=;
	b=sXa8jd11TwgBsXpf2ZToeMv/bdY7G2clae2u2rMY7Feu/xbxONWz7z4TYy5QRdAjYn58+N
	00CLxMZX9svfzqxRPy2e33HeSswDfK+Ly0Nx4Y+kwenU7U2RNTq9uKkVPX3UWsZn2kzaYO
	jqNxJwY6sxNwSWHlEphc12FrG/H8QRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704735582;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uLW0pT7KV50tmxWJTneQghfWHHzZ5Z8730KEa5QXDrg=;
	b=00kTTAfMlcg6NOU15mJ26NSLIpLKh9IKr0M7yJJuuLjT2Q7eSzNWqhcDA8jVJPx8P8iAd7
	OtmrwbGLzRcmjbBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD97113686;
	Mon,  8 Jan 2024 17:39:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dmYRLl4znGWsQAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 08 Jan 2024 17:39:42 +0000
Date: Mon, 8 Jan 2024 18:39:28 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <20240108173928.GB28693@twin.jikos.cz>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <20240105105736.24jep6q6cd7vsnmz@quack3>
 <20f3de31-fbb0-4d8b-8f34-aa1beba9afc9@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20f3de31-fbb0-4d8b-8f34-aa1beba9afc9@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_093948_161277_D7DAC20A 
X-CRM114-Status: GOOD (  31.72  )
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
Reply-To: dsterba@suse.cz
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jan 08, 2024 at 11:47:11AM +0000, Johannes Thumshirn wrote:
> On 05.01.24 11:57, Jan Kara wrote:
> > Hello,
> > 
> > On Thu 04-01-24 21:17:16, Matthew Wilcox wrote:
> >> This is primarily a _FILESYSTEM_ track topic.  All the work has already
> >> been done on the MM side; the FS people need to do their part.  It could
> >> be a joint session, but I'm not sure there's much for the MM people
> >> to say.
> >>
> >> There are situations where we need to allocate memory, but cannot call
> >> into the filesystem to free memory.  Generally this is because we're
> >> holding a lock or we've started a transaction, and attempting to write
> >> out dirty folios to reclaim memory would result in a deadlock.
> >>
> >> The old way to solve this problem is to specify GFP_NOFS when allocating
> >> memory.  This conveys little information about what is being protected
> >> against, and so it is hard to know when it might be safe to remove.
> >> It's also a reflex -- many filesystem authors use GFP_NOFS by default
> >> even when they could use GFP_KERNEL because there's no risk of deadlock.
> >>
> >> The new way is to use the scoped APIs -- memalloc_nofs_save() and
> >> memalloc_nofs_restore().  These should be called when we start a
> >> transaction or take a lock that would cause a GFP_KERNEL allocation to
> >> deadlock.  Then just use GFP_KERNEL as normal.  The memory allocators
> >> can see the nofs situation is in effect and will not call back into
> >> the filesystem.
> >>
> >> This results in better code within your filesystem as you don't need to
> >> pass around gfp flags as much, and can lead to better performance from
> >> the memory allocators as GFP_NOFS will not be used unnecessarily.
> >>
> >> The memalloc_nofs APIs were introduced in May 2017, but we still have
> >> over 1000 uses of GFP_NOFS in fs/ today (and 200 outside fs/, which is
> >> really sad).  This session is for filesystem developers to talk about
> >> what they need to do to fix up their own filesystem, or share stories
> >> about how they made their filesystem better by adopting the new APIs.

> 199 - btrfs

All the easy conversions to scoped nofs allocaionts have been done, the
rest requires to add saving the nofs state at the transactions tart, as
said in above. I have a wip series for that, updated every few releases
but it's intrusive and not finished for a testing run. The number of
patches is over 100, doing each conversion separately, the other generic
changes are straightforward.

It's possible to do it incrementally, there's one moster patch (300
edited lines) to add a stub parameter to transaction start,
https://lore.kernel.org/linux-btrfs/20211018173803.18353-1-dsterba@suse.com/ .
There are some counter points in the discussion if it has to be done
like that but IIRC it's not possible, I have examples why not.

