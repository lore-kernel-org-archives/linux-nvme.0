Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7BFE7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 08:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=01Q64F9KTf+PicDnwbH51hugRA1VlP8bh1nrgdSZkLg=; b=fQBcoIpsFoVJy5vFknO16EQx67
	N43Iw37FaU6W4MsHXYon7NZNe2OwS+Q0tSGCp3CPvrSPf/mE9eS7zJl1iqPyO4NR4A/qaXfHKoCRl
	3ig3FpStrE+0hjopIpkhiBVHlCLPp1eiLvTQd8uS30chR6RQHTBPlgNd/XMZt52hBxrMpjHWx3cXG
	NyLCjtX1esolSZphmoQvsdK24U3/KsXXgq5pITVmnZ+uqT0nikr8aLJd2AMNvROO5oFDJNPgA3QCo
	y7CByPd2+5MhWkhoBJyapqnTHvD4JP25XC7i6khnQ8HfakCXRBICFvHS2bNMu9YY8zMachXPICCOF
	drsbpi2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNT3i-0000000CiqI-1EUL;
	Tue, 17 Dec 2024 08:36:02 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNT34-0000000CilD-1H2L
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 08:35:23 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52A6F1F395;
	Tue, 17 Dec 2024 08:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734424520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01Q64F9KTf+PicDnwbH51hugRA1VlP8bh1nrgdSZkLg=;
	b=gSibJZUteznBOl6KyxEb22KP7q8MP/I4ZTBvNW84XNDh0A7ygcQt6U25KXvv4pfSdHbonC
	KX1iB3vsDi4CcDpiBbtSk9WEJurzIK/Oyjf132E2ETVxOKQD5LPQD6Nr0GMA17w1eiemer
	ZhFasOrNUGxGtY0r/lfk4qRPVLuAQic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734424520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01Q64F9KTf+PicDnwbH51hugRA1VlP8bh1nrgdSZkLg=;
	b=llS1gONuEeSJfHjELm33FLRhC08nIDfuA9Nw/FuO7UxP7TkgaLkuqcV17wyrIdieQ56qz8
	gcOWU0KC9DhocICA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gSibJZUt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=llS1gONu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734424520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01Q64F9KTf+PicDnwbH51hugRA1VlP8bh1nrgdSZkLg=;
	b=gSibJZUteznBOl6KyxEb22KP7q8MP/I4ZTBvNW84XNDh0A7ygcQt6U25KXvv4pfSdHbonC
	KX1iB3vsDi4CcDpiBbtSk9WEJurzIK/Oyjf132E2ETVxOKQD5LPQD6Nr0GMA17w1eiemer
	ZhFasOrNUGxGtY0r/lfk4qRPVLuAQic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734424520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01Q64F9KTf+PicDnwbH51hugRA1VlP8bh1nrgdSZkLg=;
	b=llS1gONuEeSJfHjELm33FLRhC08nIDfuA9Nw/FuO7UxP7TkgaLkuqcV17wyrIdieQ56qz8
	gcOWU0KC9DhocICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30563132EA;
	Tue, 17 Dec 2024 08:35:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lu6YCcg3YWf5HQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 17 Dec 2024 08:35:20 +0000
Date: Tue, 17 Dec 2024 09:35:19 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Paul Ely <paul.ely@broadcom.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] nvme: handle connectivity loss in
 nvme_set_queue_count
Message-ID: <bef1a7ac-2614-4a70-945d-e691e9107089@flourine.local>
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
 <e89d0b3b-e4a1-4ae5-8250-c15e3a843e76@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89d0b3b-e4a1-4ae5-8250-c15e3a843e76@suse.de>
X-Rspamd-Queue-Id: 52A6F1F395
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,flourine.local:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_003522_486409_32DD7E20 
X-CRM114-Status: GOOD (  13.09  )
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

On Fri, Nov 29, 2024 at 12:10:33PM +0100, Hannes Reinecke wrote:
> > +	/*
> > +	 * It's either a kernel error or the host observed a connection
> > +	 * lost. In either case it's not possible communicate with the
> > +	 * controller and thus enter the error code path.
> > +	 */
> > +	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
> >   		return status;
> >   	/*
> > 
> Hmm. Maybe checking for NVME_SC_DNR, too?

if no one complains I'll update the check to:

	if (status < 0 || (status > 0 && (status & NVME_STATUS_DNR)) ||
	    status == NVME_SC_HOST_PATH_ERROR)
		return status;

okay?

