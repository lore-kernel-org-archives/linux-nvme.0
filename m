Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370BCC48BF6
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Feb 2024 16:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ayae1/Dl2JY5+QF2s2Tz2p7jf/zrEWQKH1SFJP1RTko=; b=BKkxENl463145h65daC19y5R5L
	WpHzWMLrbeSD6xkWXUrvEUmmrdTNAFVFmVwcUGUnAzppbeiIrC8yosIwnP5EyspZ7l/7cFalTLmJH
	lAaL38/mun5HlMXh95Ic12dp92vdvRQlgM/p7hPQ85+peafRVIJSwteTdVnT9RwSaqK0gqkc2r4RY
	XKJeaulHWOkDvbsYenQPVIyGJbSXo8J4ZhrOakVrwiSPlNf3bwAqSuL+PxwRyk7PZG8GrrZpdzZCR
	kw2GVmtIMgkKSnv9/g4b9RIOAMFhFpjGcDWYZhspo5uvoZ+xGpj93eopDtTY2Kn/JgYbRWEggRUbf
	N0b1qFGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1redzF-00000001hRl-3exc;
	Mon, 26 Feb 2024 16:37:53 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1redz5-00000001hPj-1KDE
	for linux-nvme@lists.infradead.org;
	Mon, 26 Feb 2024 16:37:51 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6751A225DD;
	Mon, 26 Feb 2024 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708965461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayae1/Dl2JY5+QF2s2Tz2p7jf/zrEWQKH1SFJP1RTko=;
	b=LE84tmZQIZFdloMirtgUgMiQRG1QjTHi2uC4MzBUOwWAxAUETlM5XgDwCt492OagHr+Gnd
	ECjBbKp3GOS6SNsVbzR4k50HaoCNgmyYlB1l77HUjlynSd0ncwCzlsCfX6MtcYO31pIyoE
	RvyKbKuYLyyngmsPd1gkG2m0V3dvmfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708965461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayae1/Dl2JY5+QF2s2Tz2p7jf/zrEWQKH1SFJP1RTko=;
	b=LkXzuWmtnYx98bsGMm+5RANGRVpooB2NGSmpPwPZxIhRePZ6Qeo3zj+2dBdLZzOne7NES7
	Oog7S3tOtKzVdYDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708965461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayae1/Dl2JY5+QF2s2Tz2p7jf/zrEWQKH1SFJP1RTko=;
	b=LE84tmZQIZFdloMirtgUgMiQRG1QjTHi2uC4MzBUOwWAxAUETlM5XgDwCt492OagHr+Gnd
	ECjBbKp3GOS6SNsVbzR4k50HaoCNgmyYlB1l77HUjlynSd0ncwCzlsCfX6MtcYO31pIyoE
	RvyKbKuYLyyngmsPd1gkG2m0V3dvmfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708965461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayae1/Dl2JY5+QF2s2Tz2p7jf/zrEWQKH1SFJP1RTko=;
	b=LkXzuWmtnYx98bsGMm+5RANGRVpooB2NGSmpPwPZxIhRePZ6Qeo3zj+2dBdLZzOne7NES7
	Oog7S3tOtKzVdYDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 570EF1329E;
	Mon, 26 Feb 2024 16:37:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OFFTFFW+3GUZfwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 26 Feb 2024 16:37:41 +0000
Date: Mon, 26 Feb 2024 17:35:26 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: add 'static' suffix for user-specified TLS keys
Message-ID: <hm7yy2s6z4thaoytpwz6hx3gp7hvpdur4bhglyrnf7khqxqjpq@3n36hpna2265>
References: <20240226122449.46976-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226122449.46976-1-hare@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LE84tmZQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LkXzuWmt
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.86 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.85)[94.10%]
X-Rspamd-Queue-Id: 6751A225DD
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_083746_634513_49FDEFCC 
X-CRM114-Status: GOOD (  10.89  )
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

On Mon, Feb 26, 2024 at 01:24:49PM +0100, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> If the user specifies a specific TLS key via the '--tls_key'
> option to nvme-cli we should be adding a ';static' suffix
> to the 'tls_key' sysfs attribute to signal that this is a
> user-specific key, and not one auto-selected during TLS
> protocol negotiation.

Isn't this conflicting the one value per sysfs entry rule?

