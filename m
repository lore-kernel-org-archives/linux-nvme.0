Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FE0C27C4F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 06:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3tfX5tiJZsH1uIItuRiPycHAkawcZY4G245vsmcwEcM=; b=huOeKp1WYyTNdvistOca0k3/im
	52hQ+a0x4G3INq1D/2121VFQhxVSC60tpT488Tzvls2csTlD0EedyCM1eEkoF/Dgj4peal1Xu6L/+
	JUB2bq/tsUOXBAXxvdcljmIT1rJGKOvELm5eum9FM/ZeNr0/RX1hRyd0I188qXrsADEUFQLOqVoGi
	RFTSQzsscupRY69k25Zd5KmMzPUH5qklEUenirYy6YWoH2O3ituMAUy5FQqj+x9gvYbUfIqsQRb9O
	L/aGuKCZpZrHoWMHWmWc01Ky79eeAxxwV03nZe9k3wOPL9aNr8AApscRNC1MN77bMqL9/mmosZlJo
	4sLtgHoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJSIr-0000000DnaG-1kPn;
	Tue, 18 Jun 2024 06:26:49 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJSIj-0000000DnXE-1Hqx
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 06:26:46 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B5DA227A2;
	Tue, 18 Jun 2024 06:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718691998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3tfX5tiJZsH1uIItuRiPycHAkawcZY4G245vsmcwEcM=;
	b=Va/xqwodyVllk0jjTYOcPyrmLhuZeqSn2inhTZr+CzHfhWkxcc4fcgtq2D3M0Tw6vWZhz5
	kexBKf4IPHQjeyczWG7MaSkm/k5Ahz5OBtNsbYGVIWzPdrpgnJCJ+OVRxY6iewbvi1qv/U
	6MXxhQITnDsl7kTvut390fTrFPWIYWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718691998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3tfX5tiJZsH1uIItuRiPycHAkawcZY4G245vsmcwEcM=;
	b=I39Jev6EpvEKA2c0PSUfrB7GqCUxq1jmpteZz4MFo64a5Ts8fM80TKKahzcqAPMEAo+CkG
	fXyX/Yr2TQrroCCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718691998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3tfX5tiJZsH1uIItuRiPycHAkawcZY4G245vsmcwEcM=;
	b=Va/xqwodyVllk0jjTYOcPyrmLhuZeqSn2inhTZr+CzHfhWkxcc4fcgtq2D3M0Tw6vWZhz5
	kexBKf4IPHQjeyczWG7MaSkm/k5Ahz5OBtNsbYGVIWzPdrpgnJCJ+OVRxY6iewbvi1qv/U
	6MXxhQITnDsl7kTvut390fTrFPWIYWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718691998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3tfX5tiJZsH1uIItuRiPycHAkawcZY4G245vsmcwEcM=;
	b=I39Jev6EpvEKA2c0PSUfrB7GqCUxq1jmpteZz4MFo64a5Ts8fM80TKKahzcqAPMEAo+CkG
	fXyX/Yr2TQrroCCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 288E01369F;
	Tue, 18 Jun 2024 06:26:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3sOaCZ4ocWadXgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 18 Jun 2024 06:26:38 +0000
Date: Tue, 18 Jun 2024 08:26:37 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Ofir Gal <ofir.gal@volumez.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] md: add regression test for "md/md-bitmap: fix
 writing non bitmap pages"
Message-ID: <tu77vp6rzu6spahkzost65igv22bmg24x5l5npgyljwdekbn45@hsswq7akbdpo>
References: <20240613123019.3983399-1-ofir.gal@volumez.com>
 <cnaunh75p4p45e4hgdaeaqry6whwdc2pqatil5v3oxjitwobda@p2oqftzlwv2r>
 <34ee55e8-a23c-4e7e-b897-cfbcc8337136@volumez.com>
 <zbeftlk6oti6uh5wx6m5ijvlvjv3xpxoqa6pj6mlasdr32eqfm@vyc5i3gyyj3s>
 <1f245507-fc7d-4361-8f65-0015fe0de239@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f245507-fc7d-4361-8f65-0015fe0de239@nvidia.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_232641_527797_D3413077 
X-CRM114-Status: GOOD (  15.66  )
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

On Tue, Jun 18, 2024 at 04:41:22AM GMT, Chaitanya Kulkarni wrote:
> On 6/17/2024 6:24 PM, Shinichiro Kawasaki wrote:
> >> nvme-tcp is used as the network device, I'm not sure it's related to
> >> the nvme test group. What do you think?
> > I see... The bug is in md sub-system, then it's the better to have the new test
> > case in the new md test group. To avoid the cross reference, the nvmet related
> > helper functions should move from tests/nvme/rc to common/nvmet, so that this
> > test/md/001 can refer them. This will be another separated, preparation patch.
> > 
> > To nvme experts: If you have comments on this, please chime in.
> 
> no cross references please, above suggestion seems reasonable, however
> I'd like to see actual prep patch before I comment further ..

Splitting the host from the target code in rc kind makes sense to me. I
am fine with moving the nvmet code to common.

