Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A88C36008
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 07:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9k90JjjyHbxUV1ZzVPGjdPSRo/zHPxkDnF3HfxKV6uI=; b=2FwVom9sDgwD422ynWkre02PG0
	po4cuYY/wkqhv7GABI7PIZwO3A6ufvgwXYI8Yh7vNLdZ6dkCpcGtOLgRwlnfXdzEq8yPYdVOvDyt5
	bCAr3km8qmw9qSwseuQPk0jJ/szRXTLvJOPPBvxAgJMSqEomrAcdHryNoo6ctRI/bW0a4gLUufYh6
	GL+Rl6GrKrm3DjITBkKXT/8UtCGh8M082cGOaz/yTh/brNjH4oINvdbFw+j8H+d8u21HAHftBRxI2
	LhL2OpLEsrsh7TLdJ1oxi1Wbq+PvPdoMdropUy6dT6+x4sDvtEXxhySpTgTjn+ZGRKd6kYyPTHhnO
	KClSeLkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzW7F-00000002CaI-3OJD;
	Tue, 01 Apr 2025 07:32:57 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzW7C-00000002CZw-2j3o
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 07:32:56 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9440211A2;
	Tue,  1 Apr 2025 07:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743492771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9k90JjjyHbxUV1ZzVPGjdPSRo/zHPxkDnF3HfxKV6uI=;
	b=VIU50m3/a1VUsu/gZhFVkAUEad08b1NZIHyew1lZKeP0UFzNWSJQirGqRhI30hIol2cAI1
	KdTe2H60tNJ1wrsP0m/puVhClEa0jo/4VND83b3Rvh+9nYzj9EYIiAj7wkQBRcPZMNzYko
	xL5cKZuvV8wqtiy64rLLmJGrXCZkcoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743492771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9k90JjjyHbxUV1ZzVPGjdPSRo/zHPxkDnF3HfxKV6uI=;
	b=pza6XZnKNGfqr8yJdyiEBjintaIGtRaMsTK8Thv4QY7EWY0btWuifGd9SgbmkjcAkFdsvC
	o+Jz4p16gpVJeKCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rvvAh8bP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8R2E1GMW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743492770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9k90JjjyHbxUV1ZzVPGjdPSRo/zHPxkDnF3HfxKV6uI=;
	b=rvvAh8bP1FpE78nf/Cu7jRXpQTtq3PvI0kJ0+XdUYAyj4t7aJ3EiK1ALye5i6AmslZIQnm
	H6mcndQAIDc+RsH703EA1ywDQBHHo/SwWl0ZdEypmlyIK5fb2/RgnE6VbZUYYbxroHiWjF
	mf/1aiHi1kqKdx/8/CPT3npYo3Mvmc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743492770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9k90JjjyHbxUV1ZzVPGjdPSRo/zHPxkDnF3HfxKV6uI=;
	b=8R2E1GMWpuqjVatYUxJ2HoDqxG5pH0AGjYQvjh+FzTQhVFI4FdaxgGdFruCSCwqOOzCIDV
	Awb4Tfq526soZ9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D19DE138A5;
	Tue,  1 Apr 2025 07:32:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vUy5MaKW62emVgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 01 Apr 2025 07:32:50 +0000
Date: Tue, 1 Apr 2025 09:32:50 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "wagi@kernel.org" <wagi@kernel.org>, "hch@lst.de" <hch@lst.de>, 
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH] nvme-cli: attach ns to local controller if none specified
Message-ID: <c12c169c-4b5e-425a-91e1-e9e6ad47b8e8@flourine.local>
References: <20250331190843.2431830-1-kbusch@meta.com>
 <f6567009-341e-44d4-94fd-feb92526d80d@nvidia.com>
 <Z-sBp3YQp60oS-e9@kbusch-mbp.dhcp.thefacebook.com>
 <2fbd6fdd-7977-4499-9539-3d1290506b48@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fbd6fdd-7977-4499-9539-3d1290506b48@nvidia.com>
X-Rspamd-Queue-Id: E9440211A2
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_003254_860923_28CCD1E2 
X-CRM114-Status: GOOD (  16.89  )
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

On Mon, Mar 31, 2025 at 09:16:49PM +0000, Chaitanya Kulkarni wrote:
> On 3/31/25 13:57, Keith Busch wrote:
> > On Mon, Mar 31, 2025 at 08:37:31PM +0000, Chaitanya Kulkarni wrote:
> > > if not then do we need add a version check so it will stay as backward
> > > compatible ?
> > I don't follow what you mean here. What version of what component could
> > be checked to guide this behavior?
> 
> if we can only enable this functionality for nvme-cli/libnvme for the 
> current version and any other versions after current version.

This is a new feature which is backwards compatible as I understand it.
If a user provides the -c option it still does exactly what it supposed
to do.

> In case nvme-cli or libnvme has a version below the current version, then
> it can follow the original behavior, will this work or not ?

Older version will complain, that you need to provide the controller id,
newer ones will just assume you wanted the first controller.

For extra points, this could be documented in the docs :)

