Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87822FF885E
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 09:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IuiFPrqHlhQ0SZfbNVRYoT+SsUDkyKIVRAhrhBTsXdM=; b=hzr8BzOP3FnnSSsSkDWzL9h/Ib
	v2NVWtlEq3RwFoYrzlC5DmTNOVowhf/2ArQxz7G/xVn+G8HmHEwk5XnV0zvNinS/5C4DbHwM160Ba
	aG9BUM6HBeN599hk7RmR38wutblV9MOII+eA/xaKdk/iSN3GAXLLvuIkbtDxVRBTsVisS+BRDvFS5
	r82fEgjGltbDFHpJmTrckSVccOP9P0X2awwPkELHd5caDohVFiwDIp18G4MyHsb0Pq6P5X7M7bfpr
	KlnAiYIZk2aoBC/Nin67IYaS19DBjhaxwfQwaBia7nTL8czv+IzDgbzSalU+hF8OCxsqEVcZqYnq2
	ry+KcaQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHIff-0000000GcFF-41eP;
	Mon, 27 Apr 2026 09:54:31 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHIfd-0000000GcEp-02On
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 09:54:30 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8AA66AA08;
	Mon, 27 Apr 2026 09:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777283667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuiFPrqHlhQ0SZfbNVRYoT+SsUDkyKIVRAhrhBTsXdM=;
	b=Bbj0gW6gDb+aRcxP3V7ghexi8pLcOT4/FcAl5oS9Z2Gcsy7apR6dTJj7srvxRlW1ZZ4iUY
	+wCdyYzKDMaml5YFsxIFpqRqm6hnT2RicOIhitjtBbK9SMiMrGYga9avcyqjKHvNjWky/U
	3TBUCc1eDEf3qLFKD1lJkeH1qv4scp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777283667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuiFPrqHlhQ0SZfbNVRYoT+SsUDkyKIVRAhrhBTsXdM=;
	b=UG8Z3gaxWZGadyM1usPbLJcppA4cPHS6FER5g8ao1UYV7u70IhMz8sKxz6oWIvF/RXqb6c
	f2tQ8ftdy2BSVVAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UUfoPYyd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0bxgIzkI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777283662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuiFPrqHlhQ0SZfbNVRYoT+SsUDkyKIVRAhrhBTsXdM=;
	b=UUfoPYyds3eWDLIeKYfnQuWcbXNglETbtHBsZquC2vFBwP1Kx1nkUOdWlbaowLWlo1V9RE
	F35ofqbBLnVwjAo/6SIUMFK4vxed6/vZffA/WWfz61sNKQ/gq0uDI9e9u6tjtJLo6CRzxO
	hcoGgd9nAj7qDO5o9rV02Tq3MXo/edY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777283662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuiFPrqHlhQ0SZfbNVRYoT+SsUDkyKIVRAhrhBTsXdM=;
	b=0bxgIzkIClT72qUU6JZX+ggQdevu7gICLj30avHZVDXWaqrwYhM0fz1HO+Kg3vfIA7lpDB
	PxefS8OpjjVAbPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D510A593B1;
	Mon, 27 Apr 2026 09:54:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fryUMk4y72l1cQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 Apr 2026 09:54:22 +0000
Date: Mon, 27 Apr 2026 11:54:14 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com, 
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org, mlombard@arkamax.eu, 
	mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V3 8/8] nvme-core: warn on allocating admin tag set with
 existing queue
Message-ID: <a98abadd-53e7-4871-afc9-0b838b4a66c7@flourine.local>
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-9-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410073924.61078-9-mlombard@redhat.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E8AA66AA08
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_025429_198218_27E667C6 
X-CRM114-Status: GOOD (  11.90  )
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

On Fri, Apr 10, 2026 at 09:39:24AM +0200, Maurizio Lombardi wrote:
> Currently, nvme_alloc_admin_tag_set() silently drops and releases
> the existing admin_q if it called on a controller that already
> had one (e.g., during a controller reset).
> 
> However, transport drivers should not be reallocating the admin tag
> set and queue during a reset. Dropping the old queue and allocating
> a new one destroys user-configured timeouts and may race against
> nvme_admin_timeout_store()
> 
> Since all transport drivers are now expected to preserve the admin queue
> across resets, calling nvme_alloc_admin_tag_set() when ctrl->admin_q
> is already populated is a bug.
> 
> Remove the silent cleanup and replace it with a WARN_ON_ONCE() to
> explicitly catch any transport drivers that violate this lifecycle rule

Looks good to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

