Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738D1D2E9D6
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 10:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HMi3vZfL21EiUpE5TS5x+KSDt0VCSLsfcrOdBgbUB3w=; b=XjCNmSInwVgxR6og5r3uurxhH/
	makkquZKmRfrLXBW15OXgrP3FrLIH7IwRMCl9s1Ik6vaBe+WrOfOxIbLlR2+PTNLD60WYLhKcGKBD
	J+qlr2fH10J8BLDsqNP2VKkCpjkGhdlJkZOTyEEIF/aJ78OuqTaHCS6ZmhxtcCTIX4s3y2VPAK3JI
	NkPhFOc04Nrd4WLnIJkSsepAVBI0Pl+1VNoCfOiblS8pvCiUF42iW8JMZUm0RKlnG/mkAiF9llycm
	mGS2ZP7cBp0s2nKdE5k0fuDTYAP3sHgBOdHrBPiP5SwTqJkhLsKf79cSzEwaGepEPH9VUhdk6hJf7
	a8Ruttwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tARuZ-0000000HL6F-0RB0;
	Mon, 11 Nov 2024 10:44:47 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tARuV-0000000HL4K-0XqI
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 10:44:46 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 814541F38E;
	Mon, 11 Nov 2024 10:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731321881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HMi3vZfL21EiUpE5TS5x+KSDt0VCSLsfcrOdBgbUB3w=;
	b=qUT5nlRLwirPwGAQWK454s/6UDD/phMgEvvmRz5q59mmNFipKMObV+Vwy7Mpk6X+GMX36J
	mjcS69rxwbaLP9HsNfsYMJzZCB2zdZCXO5nDVamTYR8Zse2FhXZoFTneA+86IMC3mpSoDl
	LBFMQvVl9hM6Rw+aBOJI+1CPED60MyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731321881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HMi3vZfL21EiUpE5TS5x+KSDt0VCSLsfcrOdBgbUB3w=;
	b=79JEe+aUMCCN8iIN+SbbvmL1XWpNI4mC0O6+2/TmmiHEgkioXrDxekmJ92KaRZWR/v03K2
	k1va8wo1vPqiX8Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qUT5nlRL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=79JEe+aU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731321881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HMi3vZfL21EiUpE5TS5x+KSDt0VCSLsfcrOdBgbUB3w=;
	b=qUT5nlRLwirPwGAQWK454s/6UDD/phMgEvvmRz5q59mmNFipKMObV+Vwy7Mpk6X+GMX36J
	mjcS69rxwbaLP9HsNfsYMJzZCB2zdZCXO5nDVamTYR8Zse2FhXZoFTneA+86IMC3mpSoDl
	LBFMQvVl9hM6Rw+aBOJI+1CPED60MyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731321881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HMi3vZfL21EiUpE5TS5x+KSDt0VCSLsfcrOdBgbUB3w=;
	b=79JEe+aUMCCN8iIN+SbbvmL1XWpNI4mC0O6+2/TmmiHEgkioXrDxekmJ92KaRZWR/v03K2
	k1va8wo1vPqiX8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6722613301;
	Mon, 11 Nov 2024 10:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WTXJFhngMWctHgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 11 Nov 2024 10:44:41 +0000
Date: Mon, 11 Nov 2024 11:44:40 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 7/8] nvme: rework fcloop
Message-ID: <fb573fc2-d7e8-45df-a34e-3f72a9ff1e02@flourine.local>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
 <20241107111354.80606-8-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107111354.80606-8-shinichiro.kawasaki@wdc.com>
X-Rspamd-Queue-Id: 814541F38E
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_024443_342960_AE556D17 
X-CRM114-Status: UNSURE (   9.33  )
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

On Thu, Nov 07, 2024 at 08:13:53PM +0900, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Rework fcloop handling to create only one local port but several
> remote ports. That way we can keep the global setting for local port
> addresses and don't need to worry about passing the correct local
> port address when calling 'nvme connect'.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [Shin'ichiro: used wwnn/wwpn helper functions]
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

