Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A887CCA0EFF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Aug 2025 08:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AIdael2vuwILg6AA56M87sTF+emCxs2PTRKiH8kBhPc=; b=4FTXYKZgLzfRV8PNToIs3+HNnO
	PsF4cKGRPvexhep93rgRXG93YbpAlqxXKWLAix2e88TNeoqMN60ZP21xIedvZeVpbjRz2HbTOTcFO
	C6XNIc4KTLaQVbtRUkjDSGfFiZwckHtDVGYCt3o72OnahUci1DCwR5+VEYfFWVujHigUP0ytkVEiY
	LO2L+q89NamlolqZpxwd4vM12hTigbBA7cKZOeRrl8kSs9n75HD8b2T6r8Pxeeifc6z1r1ZAAr8Gb
	xqnsyLScqoloUb/pbzTziNyKv0FqgJifxuNr01kWS04vZ42rs0g3P41+mLHQYnY291sg68bW3AiSa
	pnuv4xOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urBdN-0000000Ego1-0O6k;
	Wed, 27 Aug 2025 08:35:57 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urBDY-0000000EbNa-2CK7
	for linux-nvme@lists.infradead.org;
	Wed, 27 Aug 2025 08:09:17 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E47B21D1A;
	Wed, 27 Aug 2025 08:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756282153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AIdael2vuwILg6AA56M87sTF+emCxs2PTRKiH8kBhPc=;
	b=IX0rFifX8CylPN2k0f1wQDG+iZS+TdRVbtsLwh24BIOZfBvy8fnW/FHLwXO2e6ieNH7APk
	5EWUk2w84L1zOuifIVdLeJ10bgkZ8WP7CMNdUFsMtxl4Zb2+m0ai47IMfbzAhzMXHBCFex
	uUEQ23NxsHWOxn52whgE6K3RgrjvPHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756282153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AIdael2vuwILg6AA56M87sTF+emCxs2PTRKiH8kBhPc=;
	b=yf0Ep4HShL0cTbsHT0icGUSDoBBioDKCHH7mlg8GxOH5VItdvuHf2dsdJcF99ZhjMwm0Rj
	njcSmb/7w4a8M4Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756282153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AIdael2vuwILg6AA56M87sTF+emCxs2PTRKiH8kBhPc=;
	b=IX0rFifX8CylPN2k0f1wQDG+iZS+TdRVbtsLwh24BIOZfBvy8fnW/FHLwXO2e6ieNH7APk
	5EWUk2w84L1zOuifIVdLeJ10bgkZ8WP7CMNdUFsMtxl4Zb2+m0ai47IMfbzAhzMXHBCFex
	uUEQ23NxsHWOxn52whgE6K3RgrjvPHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756282153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AIdael2vuwILg6AA56M87sTF+emCxs2PTRKiH8kBhPc=;
	b=yf0Ep4HShL0cTbsHT0icGUSDoBBioDKCHH7mlg8GxOH5VItdvuHf2dsdJcF99ZhjMwm0Rj
	njcSmb/7w4a8M4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6152213310;
	Wed, 27 Aug 2025 08:09:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1115Fim9rmhMeAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 27 Aug 2025 08:09:13 +0000
Date: Wed, 27 Aug 2025 10:09:12 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com, 
	chaitanyak@nvidia.com
Subject: Re: [PATCH blktests 1/2] common/nvme: add '--no-wait-ns' argument to
 _nvme_connect_subsys()
Message-ID: <2470dd71-7109-4274-9566-0b3768f86b85@flourine.local>
References: <20250822151053.3248822-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822151053.3248822-1-yi.zhang@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_010916_712495_62051B64 
X-CRM114-Status: GOOD (  13.95  )
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

On Fri, Aug 22, 2025 at 11:10:52AM -0400, Yi Zhang wrote:
> The default behavior of _nvme_connect_subsys is just wait for the
> controller ready, but sometimes the namespace was not ready after
> _nvme_connect_subsys especially on RT kernel, it's better we can
> have namespace ready in _nvme_connect_subsys, so
> 1) re-use the the function _nvme_ns_ready to check namespace ready
> 2) add one new argument `--no-wait-ns` to skip for the cases that
> don't need wait for namespace ready
> 3) update to use "return 1" for controller failure check and "return 2"
> for namespace failure check
> 
> After this change, it will avoids the failures like below which easy to
> be reproduced on rt kernel:

I would trim the commit message, the error log doesn't seem to add a lot
of information.

Besides that, looks good. Thanks for getting this sorted out!

Reviewed-by: Daniel Wagner <dwagner@suse.de>

