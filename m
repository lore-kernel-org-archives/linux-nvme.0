Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A08D0C614
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 14:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lFgXMQvBnjs6wzXaQx7BjJTQorm/hUobf7i4t8mM0MY=; b=crJFsZ/0tJOmH6QQ1QZw6Q0iUY
	OTA98IzOqs+HoEoia6UjaetzoEax4Q6w21kI9AaRi7qSk9l14RmJYgGmEc9GSw4IgIKbh75RWfE3q
	wSIgPVA8sExqNF5TELctAub6fkqTi7LKsmnX1cgARfAr/zbb10w+5pYsy+MGZL11J0G1BB/IFb4yt
	oURAUrS+Q2ZHo1FgDUAVt7pnkRQcfk6/w/7GWFOv3azDiWjpAwSWTyfbotNKwGMht4IBNnMSRiiH4
	sFOCobcLalag7yjD4b0MTBFiBPN1d79Z7J91bdjOOTJ3xy15//HfiJ2bge+Cxrg9s8kTICP+TG4AU
	wN8zoIOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4L2v-00000003xBs-3P3E;
	Fri, 25 Oct 2024 14:12:09 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4KwT-00000003vhU-1XaN
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 14:05:33 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D830F21DA8;
	Fri, 25 Oct 2024 14:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729865128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFgXMQvBnjs6wzXaQx7BjJTQorm/hUobf7i4t8mM0MY=;
	b=1Q2zTBxPfHojfbRKDzw+pZRedDueCcbz7zQso7E/uGdOA2hv0DTbh4A2UBdsoStgLxFqGM
	1BAj+LBR0vMx4QK2QtczHhzhB8Q6QwtzEBLPO0l8MLPuijxrByIA2cdWTCkDxywv9yuaul
	yRnHxCeACvDpVId135jWTU1qbvmU2UM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729865128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFgXMQvBnjs6wzXaQx7BjJTQorm/hUobf7i4t8mM0MY=;
	b=r+1VO/B0P/utvhD5e90fqWpsWSPIZF0bUsEyy6+BCrpNVZX7lK3ZmbyiaXFPNLxXfngLiF
	uS7Niil0mGL+QwDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JWkDHgoC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9OGdvZDJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729865127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFgXMQvBnjs6wzXaQx7BjJTQorm/hUobf7i4t8mM0MY=;
	b=JWkDHgoCPQeYOP6E+UMZwf9jhZbeaKDWOv6k3A2uEIVSWdbmyD/2JY8clL+qNhRDEqLeY6
	0gBBFj5iA6gsanfVaGKHvvrNxJKA1GiI9wAYI5SmoipxC97U0sLjJ6LXWqEZQzZOQg+ix5
	1uoczoFEkBPxSuyYUJeqPWh+BsbzHyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729865127;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFgXMQvBnjs6wzXaQx7BjJTQorm/hUobf7i4t8mM0MY=;
	b=9OGdvZDJ8BXPTHdQlmUXV/zGvIfAawJeiZ/nC9o1FDgRgM+Nghq4dYty2kq0yqWVLP32Q+
	g2e8oje6sVSQotCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEFE2132D3;
	Fri, 25 Oct 2024 14:05:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z/1dLKelG2c7VAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Oct 2024 14:05:27 +0000
Date: Fri, 25 Oct 2024 16:05:27 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 02/15] nvme, md/001: make trtype argument to
 _create_nvmet_port() optional
Message-ID: <a80a69de-3a2d-47a5-95a4-8334345d8c49@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-3-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024010025.2216242-3-shinichiro.kawasaki@wdc.com>
X-Rspamd-Queue-Id: D830F21DA8
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_070529_579814_E016FF6A 
X-CRM114-Status: UNSURE (   8.33  )
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

On Thu, Oct 24, 2024 at 10:00:12AM GMT, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> All invocations are using 'nvme_trtype' as argument to
> _create_nvmet_ports(), so we can also make it optional and default
> to nvme_trtype.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

