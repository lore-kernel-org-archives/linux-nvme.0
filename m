Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B63CCA0EDC
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 09:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l8DcUK1DGNKV7zVjfWJXSdop3BdZBBvjO8wOS30u750=; b=Ic+KynzmDoNE39UgceSqNIB5ux
	HoPASKWU9Ywuvh+1/oXLXjIRknk3spY1PxJUo25WjW1tfHeF8gPYsnlpyM0kLCJFD3PZV8d/aAtIU
	ZaviFwGgaK7kn9BWv5JuVE3TmdLCQeyyq8EO2v1PcuN7VyM8w68hywZlkpyfFCSO1R/wkI/onm0oo
	NUimcIfLoFYKwm7wbUC03fMU1iBm/HqoEOebyij1xOBAEDS21Grssj7ku3aKtgnAM7KxrlEkXVHg8
	/xnPQwnH71JL7gmOoG0qkMazuncfMMtCmosVom+dqazK/WBouO0UQC/5ZuxTyYnZPU8QFTPagTHbK
	rX1mOhMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoesT-0000000Crpt-3gq0;
	Wed, 20 Aug 2025 09:13:05 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoe6H-0000000Cizn-2RJt
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 08:23:18 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3197C1F395;
	Wed, 20 Aug 2025 08:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755678196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8DcUK1DGNKV7zVjfWJXSdop3BdZBBvjO8wOS30u750=;
	b=uKVxag8c2t52q1yfdaWKk1cqv9vgpSbDCORuoa1kIZfIsImz4eOGCQ4PLN6TNduEyH/c6H
	NP2+SE0/d5Ofwo87psvkcfomG57h5xzezMuMA0aey1mwQNis5A3VLg4YxbjWneUK21MkAu
	He38snEgqcU8BlDjuZdlZirC2kVQRyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755678196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8DcUK1DGNKV7zVjfWJXSdop3BdZBBvjO8wOS30u750=;
	b=JO/HmsSF232dUwFzs93mxgDMjXrpN53KjNAhr36fs4S7iCcHhDY02UAObV08l6k5Gnb220
	4t2xr2f/3qZuedCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755678196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8DcUK1DGNKV7zVjfWJXSdop3BdZBBvjO8wOS30u750=;
	b=uKVxag8c2t52q1yfdaWKk1cqv9vgpSbDCORuoa1kIZfIsImz4eOGCQ4PLN6TNduEyH/c6H
	NP2+SE0/d5Ofwo87psvkcfomG57h5xzezMuMA0aey1mwQNis5A3VLg4YxbjWneUK21MkAu
	He38snEgqcU8BlDjuZdlZirC2kVQRyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755678196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8DcUK1DGNKV7zVjfWJXSdop3BdZBBvjO8wOS30u750=;
	b=JO/HmsSF232dUwFzs93mxgDMjXrpN53KjNAhr36fs4S7iCcHhDY02UAObV08l6k5Gnb220
	4t2xr2f/3qZuedCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 203C11368B;
	Wed, 20 Aug 2025 08:23:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lJHjBvSFpWgiaQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 20 Aug 2025 08:23:16 +0000
Date: Wed, 20 Aug 2025 10:23:15 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	kbusch@kernel.org, gjoyce@ibm.com
Subject: Re: [PATCHv2 3/4] nvme: add common APIs for printing tabular format
 output
Message-ID: <ddf7e643-75ad-4878-bad3-11b60dfd95ec@flourine.local>
References: <20250812125614.164445-1-nilay@linux.ibm.com>
 <20250812125614.164445-4-nilay@linux.ibm.com>
 <e99748f0-ed6e-496a-8f08-14f332f174ec@suse.de>
 <d7a65049-01e1-443d-9315-6ce8b9e9024f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7a65049-01e1-443d-9315-6ce8b9e9024f@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_012317_770253_F03F782C 
X-CRM114-Status: GOOD (  17.67  )
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

On Tue, Aug 19, 2025 at 02:26:19PM +0530, Nilay Shroff wrote:
> > Sheesh. Can o'worms.
> > 
> > Displaying a table on an ASCII terminal is black magic (check
> > manpage for ncurses ...), and I'm pretty certain that printing
> > spaces for alignment is _not_ the way to go.
> > If you really want to implement this then at the very least use
> > tabs. Ideally check with the ncurses manpage how one can display
> > a table with the correct escape characters.
> > 
> Thanks for the feedback. You're absolutely right that terminal alignment
> can get tricky, and ncurses does provide a more feature-complete way to
> handle interactive table layouts.
> 
> However, for this patch, the intent was much narrower — to make existing
> nvme-cli tabular output (e.g., nvme list, nvme list -v and nvme show-topology)
> more consistent and readable without requiring each command to manually set
> column/row widths. The current implementation just calculates the max width
> per column and pads with spaces, which works for the non-interactive, plain-text
> output we typically expect from CLI tools (including when the output is
> redirected to a file).

I agree with Nilay here. It might not be perfect solution but the
current code is producing non aligned tables (as the examples show).
And another good thing about this patch, it removes the formatting rules
from the printf statements and we only have to touch one place. After
that we could add optional ncurses support if someone fancy this to do.

Thanks,
Daniel

