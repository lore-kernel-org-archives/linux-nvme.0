Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F91DD0C614
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 14:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nFeYYUPHZRDnbT4fqURQC9JajnZLedq6ltGEm4BpwbM=; b=b2SjopREMWrX5vF56GA24EDNYg
	dd1yy0bJTNiqLe2Dz39Vxw5PHUJLATZEi/xnQF7WcAV4UAGW0r/qXAkPZ6uur4pkZeDzkdde8sCiH
	OFki6v892b9anrOMlhH7/7mQ5i+RDGc3oWLsqVE/pWx0eBbi/rZ+kEw1DA/c9TvdppI9uuyDPGlVu
	rUaBEWDY4Hr3M41Z0U6xoFq9P//Y+SwCD2DxtR0EVIcUFQoLV9pZL9Z+4QwSj436sHElhRPFEB2gA
	Xzr2hvNRFrNJP6qUCSQMJA6iNeh3tDQzOE5uy+fRvIpweptn5xvL4sZtTWzmd76+Q8SaAF+H21Kki
	zUqxitGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4L5j-00000003xtA-2kqU;
	Fri, 25 Oct 2024 14:15:03 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4L1z-00000003wrh-2g8o
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 14:11:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D45521C08;
	Fri, 25 Oct 2024 14:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729865470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nFeYYUPHZRDnbT4fqURQC9JajnZLedq6ltGEm4BpwbM=;
	b=X3WNoBH6D9mFGdAut4of81xMiiIhWExgDPlISn7y/9yCVxwfrkm5JiK5ui3jsFYMaAaaDB
	S8yH/3VtQk6dLJfGfr0yHoXhQnA0t3L9YzaJW/OI3mKWrmi3ZlcSPsXcy4pVzys5GWytIw
	FioCRt0EhJcPZDQPzNYXeMZens23Eps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729865470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nFeYYUPHZRDnbT4fqURQC9JajnZLedq6ltGEm4BpwbM=;
	b=f3aj5VSHbp5/6WqeN6you7PzPlMP6I6vteMqXoRVcVSvxsltqbMsH8Sjxid/vDl2/ZXNCg
	s16wSVH2V0XCq2AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=X3WNoBH6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=f3aj5VSH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729865470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nFeYYUPHZRDnbT4fqURQC9JajnZLedq6ltGEm4BpwbM=;
	b=X3WNoBH6D9mFGdAut4of81xMiiIhWExgDPlISn7y/9yCVxwfrkm5JiK5ui3jsFYMaAaaDB
	S8yH/3VtQk6dLJfGfr0yHoXhQnA0t3L9YzaJW/OI3mKWrmi3ZlcSPsXcy4pVzys5GWytIw
	FioCRt0EhJcPZDQPzNYXeMZens23Eps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729865470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nFeYYUPHZRDnbT4fqURQC9JajnZLedq6ltGEm4BpwbM=;
	b=f3aj5VSHbp5/6WqeN6you7PzPlMP6I6vteMqXoRVcVSvxsltqbMsH8Sjxid/vDl2/ZXNCg
	s16wSVH2V0XCq2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8B32132D3;
	Fri, 25 Oct 2024 14:11:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YV+SNv2mG2cUVgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Oct 2024 14:11:09 +0000
Date: Fri, 25 Oct 2024 16:11:09 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 03/15] nvme: sanitize transport parameter in
 _create_nvmet_port()
Message-ID: <427d7965-0a97-4ad8-af46-02ef674357ef@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-4-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024010025.2216242-4-shinichiro.kawasaki@wdc.com>
X-Rspamd-Queue-Id: 0D45521C08
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_071111_851841_5E1D87B6 
X-CRM114-Status: UNSURE (   8.84  )
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

On Thu, Oct 24, 2024 at 10:00:13AM GMT, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> We need to sanitize the transport parameters in _create_nvmet_port()
> to avoid having invalid transport values when selecting a transport
> type.

Hmm, I miss the important point that this change add support for more
than one connection (ports).

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Except the commit message nitpick, looks good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>


