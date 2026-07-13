Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A290DC43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 12:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C36HAj+x+mp8P9xaHvqfdcJTAdupzNdpiK+LlnAHLaI=; b=upModdK/RoBdxD+Zx1QUAB6Ps6
	SmB2Bs56comiD9ekVWG0xC7qJgaKDzOhNwYKDHRpHor1TpT3IHX6JK6kbelL+hjEJv1NQga8Of5gf
	EYxFO0HwA5mvnbpi7uTDS7dTDaNsmS2hppEs20Voxr1Ae99/3deObhBo/LT+ft34iRVqbnz0m4BVC
	SSaQEg0oKE2w0K9mwU01Lqe86OlGMQZ/RXRPaYwD0IieTl5YA68wXa74vIqPBosI6gkTFtulYXKjM
	6v70ApBE605pdi5J8Q7XnP50pRSet/28Vivrss3kdrOLoC+VA0MqE1Sm3JL5wkgJIj8NhH69xvGC/
	dyfkypOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFZy-00000009AiA-3CAM;
	Mon, 13 Jul 2026 12:16:10 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFZv-00000009AhD-0rRR
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 12:16:09 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F37387789F;
	Mon, 13 Jul 2026 12:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783944964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C36HAj+x+mp8P9xaHvqfdcJTAdupzNdpiK+LlnAHLaI=;
	b=Y4tFMnWZ6oNwDQNMP5t7rOH6SEjFaCyHxrKe3WSGmeQWmh1K/sITDqCnEBi58Sj+/65ib/
	gRjA861MFPeQJSFWkwPGNaV7n69ZVLCKKB5TNpk3eZx1WOUZ6kWFVIRT4/7Flnwcwxduv/
	xv7fiMWSPnpF3qhNssakNHmXcWZXjQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783944964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C36HAj+x+mp8P9xaHvqfdcJTAdupzNdpiK+LlnAHLaI=;
	b=sjkBG6MuPC/w0IwAU3mdUUx3A68jEhSkr2D/bV4icTjhAfHpLKi0BewbO8oMGwkmA6ozwK
	KULCNPrI5dy1VCAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783944964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C36HAj+x+mp8P9xaHvqfdcJTAdupzNdpiK+LlnAHLaI=;
	b=Y4tFMnWZ6oNwDQNMP5t7rOH6SEjFaCyHxrKe3WSGmeQWmh1K/sITDqCnEBi58Sj+/65ib/
	gRjA861MFPeQJSFWkwPGNaV7n69ZVLCKKB5TNpk3eZx1WOUZ6kWFVIRT4/7Flnwcwxduv/
	xv7fiMWSPnpF3qhNssakNHmXcWZXjQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783944964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C36HAj+x+mp8P9xaHvqfdcJTAdupzNdpiK+LlnAHLaI=;
	b=sjkBG6MuPC/w0IwAU3mdUUx3A68jEhSkr2D/bV4icTjhAfHpLKi0BewbO8oMGwkmA6ozwK
	KULCNPrI5dy1VCAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC0D1779AE;
	Mon, 13 Jul 2026 12:16:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F4EGNAPXVGp4JAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 13 Jul 2026 12:16:03 +0000
Date: Mon, 13 Jul 2026 14:16:03 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>, 
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvmetcli: store DHCHAP attributes
Message-ID: <2b897a12-e265-40c5-8e48-b546cd606940@flourine.local>
References: <20260713104657.121217-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713104657.121217-1-hare@kernel.org>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_051607_392258_0ECCD9E5 
X-CRM114-Status: GOOD (  14.39  )
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

Hi Hannes,

On Mon, Jul 13, 2026 at 12:46:57PM +0200, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> The DHCHAP authentication is stored under hosts/, and are starting
> with 'dhchap_'. So add a 'dhchap' attribute group for the host object
> to correctly save and restore DHCHAP values.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  nvmet/nvme.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/nvmet/nvme.py b/nvmet/nvme.py
> index faf1eb2..80d3953 100644
> --- a/nvmet/nvme.py
> +++ b/nvmet/nvme.py
> @@ -1013,6 +1013,7 @@ class Host(CFSNode):
>          '''
>          super(Host, self).__init__()
>  
> +        self.attr_groups = ['dhchap']

Would you mind also extend the test case?

Thanks,
Daniel

