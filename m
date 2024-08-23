Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08433C52D7C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 06:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7mvDEGd78gLU+kGfB/BbAfJzvBNCE14Iy69YVFOxD3s=; b=YA/vEr9+9lZhxSdm2MOocC4cPZ
	hN6AoxDQvUjkA6cYdgpWdTgcINVvNcyoJ8VFXewqndGP+PBt8d+8CYJDpoTTnipHd7+smeFmH/jjS
	TxgRUBPyvvDYelSlpc2YIgnNPMMFKW5svrzCh1ybH9BR/bZSPIqkMorlsWaE5qfquz1y0oTNOznvG
	0SImZ+IXqPpZspAApya5NYnpEiuN6X1wX5lpm6rW+u+iErvdEORyznKi7Ek6GuztbpI9FLpcD34Br
	bkhdbsfG91kZNUhrwcvIcN70KNqTMa2CIpdXPqxOT1bSuwjupKRDI3RphR4nLD47fDeAkLEtOwPHn
	NzRBjC3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shO7g-0000000FWdw-0c5U;
	Fri, 23 Aug 2024 06:50:12 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shO7c-0000000FWdD-0XYd
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 06:50:09 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34F2F1F74D;
	Fri, 23 Aug 2024 06:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724395806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mvDEGd78gLU+kGfB/BbAfJzvBNCE14Iy69YVFOxD3s=;
	b=uYwRoJnjj2Mp2vx9I/F30fi8xk+ClIvClV4kS5iTk3qGLOxHL93i1zsbIcA3D7qO4+S8dh
	p+b9rteNpkKENJSKQFtJ2y/4ztbOQ1Dt3VIQEFGHMGxULxZS1AkzIw9O7mGKMcZBodVc8m
	liwbJp2X3qDYwOvxTE2As2jeyX1sjow=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=f6piUZQj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724395805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mvDEGd78gLU+kGfB/BbAfJzvBNCE14Iy69YVFOxD3s=;
	b=f6piUZQjUQ3SGAgaaduv3pxJLEWb2iEe4Rjc4ejryvHCGUGOT9tZYlGAp1vXuTvwhSpdp2
	NLpczuDacfLGmcBeIX2CE2d5d32cDTc91HWD1cIDthtahct+ZQaIxTJdnlSdbkQbYJtWP2
	/3ZfUHA0qPJB3v/tQDS5wUBZAkW2MBE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEB201333E;
	Fri, 23 Aug 2024 06:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bcydOBwxyGaTbAAAD6G6ig
	(envelope-from <mwilck@suse.com>); Fri, 23 Aug 2024 06:50:04 +0000
Message-ID: <746c53383557efde6bfa09e2bd848b553f88ff3a.camel@suse.com>
Subject: Re: [PATCH 3/3] nvme: add test for controller rescan under I/O load
From: Martin Wilck <mwilck@suse.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni
	 <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Date: Fri, 23 Aug 2024 08:50:04 +0200
In-Reply-To: <9e199fd0-5767-4a63-930a-b08e89e4e354@flourine.local>
References: <20240822193814.106111-1-mwilck@suse.com>
	 <20240822193814.106111-3-mwilck@suse.com>
	 <9e199fd0-5767-4a63-930a-b08e89e4e354@flourine.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 34F2F1F74D
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_235008_345162_32EF2479 
X-CRM114-Status: GOOD (  14.27  )
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

On Fri, 2024-08-23 at 08:45 +0200, Daniel Wagner wrote:
> On Thu, Aug 22, 2024 at 09:38:14PM GMT, Martin Wilck wrote:
> > Add a test that repeatedly rescans nvme controllers while doing IO
> > on an nvme namespace connected to these controllers. The purpose
> > of the test is to make sure that no I/O errors or data corruption
> > occurs because of the rescan operations.
>=20
> Could you elaborate why this tests is added? Does it test for a
> regression, are there any patches for this? Or is it more let's
> ensure
> this actually works?

The rationale was to test the kernel patch that I submitted yesterday:=20
https://lore.kernel.org/linux-nvme/9de89e5a-04fc-4684-8514-b86884643a5d@sus=
e.de/T/#t

Thanks,
Martin


