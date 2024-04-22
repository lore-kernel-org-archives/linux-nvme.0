Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C38C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Apr 2024 08:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yg23E5IvW6VVteK0P5TIP4rEOLrHYZFijpWWkpYHnp4=; b=g/Q/3+jFeHlv96c4cd3KnSte0X
	vszDGiNcsv1EWL5FbSUBeu4vn0PlhtDsH6+lo7CfWZY49WmbbY6K/WNp8EuHQXCte9vBhNVmGhVxN
	Lw364HTep2dfZ2Zczs2XBNYXseIFI3aFoyVbx8CrQwO5uxiVRlOtXa5onLPVeQwYOXywSY3dn+Xjx
	lE+tEWrnZJ2wKoXImCUhRiGB749jXYx8L9SpO3Dx54O4JNLES3h1+s8aOHRlEbDrsGrWoe+wgpol2
	y8Wahx5eJpqQOolhRza/h+/1TIkEsf0118g+1b4fMUTWomNr3FDpJrzp1my4H+znkXl9qNghISPk9
	c4rFq0Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryp1a-0000000CeFU-3ETL;
	Mon, 22 Apr 2024 08:27:42 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryp1W-0000000CeCl-1hlv
	for linux-nvme@lists.infradead.org;
	Mon, 22 Apr 2024 08:27:41 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BDA65CCA1;
	Mon, 22 Apr 2024 08:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713774454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yg23E5IvW6VVteK0P5TIP4rEOLrHYZFijpWWkpYHnp4=;
	b=tXIBBkLfXURx7rxnCsscBn1i+msusCoBIigK6Pzr7ehaPitZm3uMu2c++Co+CxzHnkVQon
	mQcIDDeXF253NkbhHE5wgEU0FaXDhBALBzLYDD07MZ2So2pbqmuriJr6g84pi1qeGSGn9f
	xJlhGfkvUzqFOTXnLaSWj7bJILHMrAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713774454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yg23E5IvW6VVteK0P5TIP4rEOLrHYZFijpWWkpYHnp4=;
	b=9LPmCsG0wra1azWvYgBlgXA6TD60Mx/MnlHIFzT62J/idq7wU26lMwD+0IWXt/UYQFLY6H
	FCRoFXK45Rv6FuDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713774454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yg23E5IvW6VVteK0P5TIP4rEOLrHYZFijpWWkpYHnp4=;
	b=tXIBBkLfXURx7rxnCsscBn1i+msusCoBIigK6Pzr7ehaPitZm3uMu2c++Co+CxzHnkVQon
	mQcIDDeXF253NkbhHE5wgEU0FaXDhBALBzLYDD07MZ2So2pbqmuriJr6g84pi1qeGSGn9f
	xJlhGfkvUzqFOTXnLaSWj7bJILHMrAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713774454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yg23E5IvW6VVteK0P5TIP4rEOLrHYZFijpWWkpYHnp4=;
	b=9LPmCsG0wra1azWvYgBlgXA6TD60Mx/MnlHIFzT62J/idq7wU26lMwD+0IWXt/UYQFLY6H
	FCRoFXK45Rv6FuDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 255A913894;
	Mon, 22 Apr 2024 08:27:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xcsWCXYfJmaXfAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 22 Apr 2024 08:27:34 +0000
Date: Mon, 22 Apr 2024 10:27:28 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, Ming Lei <ming.lei@redhat.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [bug report] blktests nvme/tcp nvme/014 failed due to Read/Flush
 timeout
Message-ID: <akehibl3xhwd5dt7euvljib5uyqkxk2efhka3kt6b6jcuyffmw@gpnfo6dikdzf>
References: <CAHj4cs_9XT6Ky4=LTy4SZ5AVfhAUec2k52b81-OKqzsDubobmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs_9XT6Ky4=LTy4SZ5AVfhAUec2k52b81-OKqzsDubobmw@mail.gmail.com>
X-Spamd-Result: default: False [-3.72 / 50.00];
	BAYES_HAM(-2.93)[99.68%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_012738_639958_0A0F4A34 
X-CRM114-Status: GOOD (  12.01  )
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

On Mon, Apr 22, 2024 at 12:55:33PM +0800, Yi Zhang wrote:
> I found nvme/014 failed[1] on one of my servers, seems it was due to
> Read/Flush timeout during the test[2], I tried to add sync operation
> after the dd operation[3] and the failure can be fixed now and no
> timeout from dmesg, could anyone help check if it's one test issue or
> nvme/tcp stack issue, thanks.

From your log I'd say the sync command is just timing out too early. The
write operations are just too slow. Not really sure what the test is
suppose to test here. Should it test if the flush works or if the flush
is flushing any pending I/O? In the first case, the sync would be the
right fix. In the second case I suppose we would need to consider how
log it takes to flush pending I/Os and extend the timeout accordingly?

Thoughs?

