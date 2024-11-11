Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6538D2E9DD
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 11:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uWcPlsr88eWGLqYek5smcv1swc+xqNam+8/Lv8OxhXE=; b=V1BEi78YbUFs5H3oSveRGlenCW
	I33adRzi6ZqA7aZPe9/3yWMN2j3HBBntH8XfM5ShgU2JTR5zzdkA8XnPqYBXf9tV9TDUAvxGOoUV4
	uKQIIhzahpOWOQ0wxEGN7YS7re/OepuBbaVYiZk9vk4N2khVqbwjYucATPuToLF7zuLYsJHdoVJFF
	ee40gsqRBTF6FmEb52M9ZIw2pti0gbQILnp4rO+7r/X0bj6yWMvysp01LG9TX2ylg4TKNcmWrC7pJ
	cZOkJ7+Qh+qsS6T0YEv3t90Y2CmW4T2XNDWJf8h/A8Znd15LtBvX9tHyVLUcCuNopb+T45n5uCYSY
	jFk236CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tASrc-0000000HV5b-0My7;
	Mon, 11 Nov 2024 11:45:48 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tARsd-0000000HKYn-1Fb1
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 10:42:51 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9DFB3219A4;
	Mon, 11 Nov 2024 10:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731321765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uWcPlsr88eWGLqYek5smcv1swc+xqNam+8/Lv8OxhXE=;
	b=ENVt8+dK5HxgeyRGuuSSwtQPXFT8NRRxGCuWMHNbh1nDOTLqvtCL35qP25HnSG2U2GfRhi
	Wsl2lfAnoUATZXCW8E73xFpYu6q/hxHpSbO78n/+I4/UHyPo8NJoJzcalhevnf2MARZQMy
	GEkYsIaB+Fx9e8rSNKJH1eSvhWc54dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731321765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uWcPlsr88eWGLqYek5smcv1swc+xqNam+8/Lv8OxhXE=;
	b=RKB9fgZvKovKUki0f00wZNH6RECXCX7kZtzjFelvO2vOXQA3C8zHCRrAsRuugnpvhYRT+v
	RYqDfA2sR+0sZfBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ENVt8+dK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RKB9fgZv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731321765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uWcPlsr88eWGLqYek5smcv1swc+xqNam+8/Lv8OxhXE=;
	b=ENVt8+dK5HxgeyRGuuSSwtQPXFT8NRRxGCuWMHNbh1nDOTLqvtCL35qP25HnSG2U2GfRhi
	Wsl2lfAnoUATZXCW8E73xFpYu6q/hxHpSbO78n/+I4/UHyPo8NJoJzcalhevnf2MARZQMy
	GEkYsIaB+Fx9e8rSNKJH1eSvhWc54dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731321765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uWcPlsr88eWGLqYek5smcv1swc+xqNam+8/Lv8OxhXE=;
	b=RKB9fgZvKovKUki0f00wZNH6RECXCX7kZtzjFelvO2vOXQA3C8zHCRrAsRuugnpvhYRT+v
	RYqDfA2sR+0sZfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 844E113301;
	Mon, 11 Nov 2024 10:42:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sMvnHaXfMWehHQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 11 Nov 2024 10:42:45 +0000
Date: Mon, 11 Nov 2024 11:42:44 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 6/8] nvme/031: open-code helper functions
Message-ID: <724ac06f-b502-49a8-b50a-d8d7cbb850a1@flourine.local>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
 <20241107111354.80606-7-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107111354.80606-7-shinichiro.kawasaki@wdc.com>
X-Rspamd-Queue-Id: 9DFB3219A4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_024247_509056_F9C4332E 
X-CRM114-Status: UNSURE (   8.73  )
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

On Thu, Nov 07, 2024 at 08:13:52PM +0900, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> The default helper functions are doing quite some things which are unneccesary for
> this test, so open-code them to call just the required functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

This will make it impossible to use 'remote targets':

https://lore.kernel.org/linux-nvme/20240627091016.12752-1-dwagner@suse.de/

