Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D97D0C614
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 14:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pNI5wiM7SHI6bj4M7XVgwuXGQeiQIR75bjT0xOjUv0c=; b=YjR8Nc8v16bvLj1bO+i5yDW/eQ
	WOIcJq4+IowxOeg6I+yFApPy95YdfAt92x01ZC0vb6gIaeDW9EhAeYRSm2yDuU2brJckqm165q+Ez
	NuMeaD+C8Tq0htmPzRmosPapHFk87ZS9GFjtg/nAgVlmGB3Qk8uozHVnLkRwTnYxzwFBFcgMGVG5p
	ElVLu2mFC3oOgAyNnkzEW+/gbT0+zbC91DomF+SwVoBY81lQopGeywZerINR1Jao21xq1S1q0ScYp
	qG0AmVGL0IPn25QD7LSBM7qFDGa7Bnz1xMLxwEjN855oadrvS/8YPknuRXOXMcGGtgVCcoE5hh1lh
	qarrHfhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4L2a-00000003x2o-25ZD;
	Fri, 25 Oct 2024 14:11:48 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Kv9-00000003vOM-2Fzp
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 14:04:10 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C25C221DB5;
	Fri, 25 Oct 2024 14:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729865045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pNI5wiM7SHI6bj4M7XVgwuXGQeiQIR75bjT0xOjUv0c=;
	b=KGFJpDl4EO2kG0uPoRuVFINxqzRth0C7alWPAeL95mx0iHY/m1pApo89KtenS2WlZTiZxc
	iqH17aZQZeo7d5TXZdm9p2YsK0NkuIBfeBv7kiQ2LQM94aqwcflDHS28e5AgNyIa+MABGK
	ZZ3eeHlKoBD3Dr+yBH7ulIKvsFcTZRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729865045;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pNI5wiM7SHI6bj4M7XVgwuXGQeiQIR75bjT0xOjUv0c=;
	b=PGsHOM8Khi1aBQHccchNNVpk3wM6GiP0qhcai26s2CPmTxDuiGwVeGWd4ZOMlASaRuMoxd
	3KLMHl3ZU+l35YBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729865045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pNI5wiM7SHI6bj4M7XVgwuXGQeiQIR75bjT0xOjUv0c=;
	b=KGFJpDl4EO2kG0uPoRuVFINxqzRth0C7alWPAeL95mx0iHY/m1pApo89KtenS2WlZTiZxc
	iqH17aZQZeo7d5TXZdm9p2YsK0NkuIBfeBv7kiQ2LQM94aqwcflDHS28e5AgNyIa+MABGK
	ZZ3eeHlKoBD3Dr+yBH7ulIKvsFcTZRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729865045;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pNI5wiM7SHI6bj4M7XVgwuXGQeiQIR75bjT0xOjUv0c=;
	b=PGsHOM8Khi1aBQHccchNNVpk3wM6GiP0qhcai26s2CPmTxDuiGwVeGWd4ZOMlASaRuMoxd
	3KLMHl3ZU+l35YBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9833132D3;
	Fri, 25 Oct 2024 14:04:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VYb9JlWlG2fBUwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Oct 2024 14:04:05 +0000
Date: Fri, 25 Oct 2024 16:04:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 01/15] nvme/038: use nvme_trtype instead of
 hardcoding
Message-ID: <e0278cc7-c39d-4977-aef5-04807d5db63f@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-2-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024010025.2216242-2-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_070407_744238_105D0405 
X-CRM114-Status: UNSURE (   8.51  )
X-CRM114-Notice: Please train this message.
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

On Thu, Oct 24, 2024 at 10:00:11AM GMT, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> There is no reason why loop is required, so switch to the default
> transport type.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

