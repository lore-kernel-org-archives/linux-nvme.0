Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14538C5AD49
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jun 2025 15:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sTaxRHKwF+vzmXr0h8gchfeJdwPaFIf2cEMCCW/n7+A=; b=L7F5WoYdFTSYoLR4aa2V7GWxIa
	EYmxFmJH0BD3v1CA/mQr7nLGun6bMhahGyOd0JzpApfizdMKVQ8IW74xXlFzHb/AxurBdz84y/JDn
	/8ps4KPQvHG5vBqFKqOlQTZlgOry2ryHACnsPoJTWSxZd2kEhBwlRepAY0p/n8geygls0Q7xkYW2t
	oB3YvLEPf0A0yCt3DRhxHzG1psmdNujrRMEdMLAtZJU2TLjAGkajCBqz43CmPfwZlWDM5hhxVmaps
	9WXHauWdCOH93i9yF+zvWDpFfdpzNf2hEawanra9cME2vl8DqpK6iJJO4TrSpjLjjK5woBZ3g5reE
	jCpfftdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNZ3Y-00000000WWQ-2OYr;
	Fri, 06 Jun 2025 15:32:32 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNZ2j-00000000WSQ-2iR9
	for linux-nvme@lists.infradead.org;
	Fri, 06 Jun 2025 15:31:43 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1FC1C336A1;
	Fri,  6 Jun 2025 15:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749223900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTaxRHKwF+vzmXr0h8gchfeJdwPaFIf2cEMCCW/n7+A=;
	b=kdo2FLY6uImYG5myX98OBi1M5XgqczBq0Pj7pql0UDXaqgIoVf3R531K9uUlUTdyygWzO5
	GvheP0Nt5TJtxV53GFB/kbLM24NaPDSVCriNYC4BWFHwn8u/pL3Np7E4CkzXsfwML2Afgy
	LZ7AmLGGC3tuQ7Ke8oZ1dw25q54fQHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749223900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTaxRHKwF+vzmXr0h8gchfeJdwPaFIf2cEMCCW/n7+A=;
	b=0YFAcE5iTeNsslsFY3deRp4aKNCW6rXvHCWSidKaiIDLu8LWQ+TRPaCBB3vLKq7/MtpHhA
	vyDej2B7YEVbPxDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749223900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTaxRHKwF+vzmXr0h8gchfeJdwPaFIf2cEMCCW/n7+A=;
	b=kdo2FLY6uImYG5myX98OBi1M5XgqczBq0Pj7pql0UDXaqgIoVf3R531K9uUlUTdyygWzO5
	GvheP0Nt5TJtxV53GFB/kbLM24NaPDSVCriNYC4BWFHwn8u/pL3Np7E4CkzXsfwML2Afgy
	LZ7AmLGGC3tuQ7Ke8oZ1dw25q54fQHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749223900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTaxRHKwF+vzmXr0h8gchfeJdwPaFIf2cEMCCW/n7+A=;
	b=0YFAcE5iTeNsslsFY3deRp4aKNCW6rXvHCWSidKaiIDLu8LWQ+TRPaCBB3vLKq7/MtpHhA
	vyDej2B7YEVbPxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EFA31336F;
	Fri,  6 Jun 2025 15:31:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mXxgA9wJQ2g7LAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 06 Jun 2025 15:31:40 +0000
Date: Fri, 6 Jun 2025 17:31:39 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Yi Zhang <yi.zhang@redhat.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	Tomas Bzatek <tbzatek@redhat.com>
Subject: Re: blktests failures with v6.15 kernel
Message-ID: <d1e5aefd-9669-4638-9466-951e69df1176@flourine.local>
References: <2xsfqvnntjx5iiir7wghhebmnugmpfluv6ef22mghojgk6gilr@mvjscqxroqqk>
 <7cdceac2-ef72-4917-83a2-703f8f93bd64@flourine.local>
 <rcirbjhpzv6ojqc5o33cl3r6l7x72adaqp7k2uf6llgvcg5pfh@qy5ii2yfi2b2>
 <CAHj4cs8SqXUpbT49v29ugG1Q36g5KrGAHtHu6sSjiH19Ct_vJA@mail.gmail.com>
 <38a8ec1a-dbca-43f1-b0fa-79f0361bbc0b@flourine.local>
 <14194a5f-e320-45e0-8f6c-019ce3bd4dbe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14194a5f-e320-45e0-8f6c-019ce3bd4dbe@kernel.dk>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_083141_842481_26C3CF41 
X-CRM114-Status: GOOD (  11.83  )
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

On Fri, Jun 06, 2025 at 09:03:11AM -0600, Jens Axboe wrote:
> On 6/6/25 8:58 AM, Daniel Wagner wrote:
> > FWIW, the contributor for the io_uring feature, stated that it improved
> > the performance for some workloads. Though, I think the whole
> > integration is sub-optimal, as a new io_uring is created/configured for
> > each get_log_page call. So only for a large transfers there is going to
> > help.
> 
> That's crazy... What commit is that?

adee4ed1c8c8 ("ioctl: get_log_page by nvme uring cmd")

ioctl: get_log_page by nvme uring cmd
Use io_uring for fetching log pages.

This showed about a 10% performance improvement for some large log pages.


https://github.com/linux-nvme/libnvme/commit/adee4ed1c8c8

Should I rip it out? I am not really attached to it.

