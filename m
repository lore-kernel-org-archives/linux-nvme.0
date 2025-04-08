Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B02C369A4
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 13:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aI8MuvV5QLm2JsB6qysU3m/83Mk7QZp0VppxkjcIvnQ=; b=rwVnnAx2UAoDUYT+3Cu12HF6va
	ZUkOKYzLixHESOoS4xypfFxJDqecGAJBtwkAGaQoUdiKH5KS5FPNCSBNxivMHy87ycntg9tK9T2QD
	zYUDXpV9XkoYXwCb7iM7aXtjrgqTntAzvOY7uFhmRqhYnRBlieJuB+ECe54KGXgUW1P7HtRZQRwAp
	zWZiMIHWNOlc51HF4KsGuFAJmvGIhyeP1oVq7ahr1KF4r5lbGtX+Ws3KeOqi97qPLgRvoCEFPxsgN
	VgOIWCa9Jar1RCUEx2n5anjdLmRPL52xvv1S9RZmCqWMr3MEy4NRigsXhY6wu7Zo+Oe6cBxntwrWm
	4SxkNu8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u28mM-000000046zt-16FV;
	Tue, 08 Apr 2025 13:14:14 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u27Hp-00000003sAk-3Me7
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 11:38:39 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 331572111F;
	Tue,  8 Apr 2025 11:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744112316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aI8MuvV5QLm2JsB6qysU3m/83Mk7QZp0VppxkjcIvnQ=;
	b=AYy2pcg5BIXkdePaCGWB11TdiZHWQ8RY69hasgNj/BnkUFzpqKLTzchkRFXLrLHFcsfOmZ
	NJPvNlRioQHbtrq1UdeY3P7oir//kcHtCbSxlYHyJABNrjRxdmMTdEQPHWlOoM9HuBPKjS
	CrXRu/hxguSEnnqSjpN8vOlx75uKop0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744112316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aI8MuvV5QLm2JsB6qysU3m/83Mk7QZp0VppxkjcIvnQ=;
	b=GNT5RrjHtdjM5FCI+yVjzMFuWqTppuLFNyBqGr7DZdgmprzIenwmavhVE47uDSQikqrTu5
	Bhxa4WFhBD2XsBBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744112316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aI8MuvV5QLm2JsB6qysU3m/83Mk7QZp0VppxkjcIvnQ=;
	b=AYy2pcg5BIXkdePaCGWB11TdiZHWQ8RY69hasgNj/BnkUFzpqKLTzchkRFXLrLHFcsfOmZ
	NJPvNlRioQHbtrq1UdeY3P7oir//kcHtCbSxlYHyJABNrjRxdmMTdEQPHWlOoM9HuBPKjS
	CrXRu/hxguSEnnqSjpN8vOlx75uKop0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744112316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aI8MuvV5QLm2JsB6qysU3m/83Mk7QZp0VppxkjcIvnQ=;
	b=GNT5RrjHtdjM5FCI+yVjzMFuWqTppuLFNyBqGr7DZdgmprzIenwmavhVE47uDSQikqrTu5
	Bhxa4WFhBD2XsBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2528A13A1E;
	Tue,  8 Apr 2025 11:38:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mgcTCLwK9WdfDgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 08 Apr 2025 11:38:36 +0000
Date: Tue, 8 Apr 2025 13:38:35 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, bluca@debian.org, Sagi Grimberg <sagi@grimberg.me>, 
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: nvme-cli connect regression
Message-ID: <306dfd9d-1d54-4c36-9d41-362f63f37730@flourine.local>
References: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
 <CADUfDZoa8sVX2D599k=kaWTwc7sWdbqCyOo9ov4QiJ_P_1G+rg@mail.gmail.com>
 <e5fb8a06-d427-4332-ada2-8bb121827811@flourine.local>
 <D90A8LHPMZ6O.27N5MIVWHKIE3@bsdbackstore.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D90A8LHPMZ6O.27N5MIVWHKIE3@bsdbackstore.eu>
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_043837_984935_F6C5144D 
X-CRM114-Status: GOOD (  17.55  )
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

On Mon, Apr 07, 2025 at 11:01:00AM +0200, Maurizio Lombardi wrote:
> On Mon Apr 7, 2025 at 10:34 AM CEST, Daniel Wagner wrote:
> > On Tue, Apr 01, 2025 at 02:40:54PM -0700, Caleb Sander Mateos wrote:
> >> I am not sure what an error code of EINTR means in the kernel. It
> >> looks like the kernel_recvmsg() is performed on the thread that writes
> >> to /dev/nvme-fabrics, so it's possible that there is a signal pending
> >> for the userspace thread (i.e. nvme-cli)?
> >
> > nvme-cli has only on place where signals are used (to interrupt a self
> > test). libnvme doesn't use signals at all. No idea where the signal is
> > coming from but it looks very unlikely to be from nvme-cli/libnvme.
> 
> Maybe an operation on a socket that has been closed by the other side (SIGPIPE) ?

Could be.

Anyway, no one has really said it's a stupid idea to retry when the
syscall returns EINTR, so I am going to add it to libnvme now.

