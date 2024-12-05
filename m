Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821ADE77175
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P8aZGnZxlFkcvXyZZOZwpo4p6JL/B063zgulZ6MO14U=; b=It09EzuJxXShQ/W7EPdnlBG3QO
	8aNtRLwu7lVlEnGibt3iR5n1NFR6Ss42pnzjAl9BmkwjR/NJscyt06hRReKjV2klDxa8kQgjphDQO
	OzBI0VMIgXAMnw3jgbuTd9E0xvVNlK7KNRsq2YtPUmewvv+70NgY/OFOnvnAvprQ61psn5EAKgf6W
	Ca3u0nTdxefUuRNMp7+ggyU+JSsBYu/Xo0pRs1uvfcRdA2eHiG4Cn0aFj8Dp5r/I5cmKbr5cFs8Jp
	DXlYFDY8Rqw+pW9VAwZsWLdy4/9MsbVdONIwjjRpU5JRuBzM9m9OPBrNlJjPPjdZL//NQhvl70tGO
	LHTfcSUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJ9Qw-0000000FcZb-3zh8;
	Thu, 05 Dec 2024 10:50:10 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJ9OU-0000000FcGq-3BA8
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 10:47:40 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0DCE211F1;
	Thu,  5 Dec 2024 10:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733395655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8aZGnZxlFkcvXyZZOZwpo4p6JL/B063zgulZ6MO14U=;
	b=zH7Qz/luzcsOSw6qSZHAjML1s+pA13I4imENhga64uP81RU1805NExJ5xoQUTxr6xzPxPa
	BTiQsjiVZJTjbPNpyt5KL4h0Fx3nNizqd864SAW68EyPE9fobbkPnboQtgT1CiqELEM/HW
	9D8SlSQM0zELsNFuvWEH0xVOCQEGzcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733395655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8aZGnZxlFkcvXyZZOZwpo4p6JL/B063zgulZ6MO14U=;
	b=rguoIhtJZtS5kY1Rbf8aH2BGWqmFPxLpn1H8A9NZe/gn87QwEJ5Qvj79e6D3fc+vz3U4tC
	4SD/ATSq2Qjn+JCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733395655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8aZGnZxlFkcvXyZZOZwpo4p6JL/B063zgulZ6MO14U=;
	b=zH7Qz/luzcsOSw6qSZHAjML1s+pA13I4imENhga64uP81RU1805NExJ5xoQUTxr6xzPxPa
	BTiQsjiVZJTjbPNpyt5KL4h0Fx3nNizqd864SAW68EyPE9fobbkPnboQtgT1CiqELEM/HW
	9D8SlSQM0zELsNFuvWEH0xVOCQEGzcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733395655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8aZGnZxlFkcvXyZZOZwpo4p6JL/B063zgulZ6MO14U=;
	b=rguoIhtJZtS5kY1Rbf8aH2BGWqmFPxLpn1H8A9NZe/gn87QwEJ5Qvj79e6D3fc+vz3U4tC
	4SD/ATSq2Qjn+JCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 919EE132EB;
	Thu,  5 Dec 2024 10:47:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U9n9IseEUWf9GgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 05 Dec 2024 10:47:35 +0000
Date: Thu, 5 Dec 2024 11:47:31 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>, "hch@lst.de" <hch@lst.de>, 
	"kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>, 
	"axboe@kernel.dk" <axboe@kernel.dk>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCHv2 blktests 2/2] nvme: add test for writing to file-ns
 just after disabling it
Message-ID: <adbeb95d-40aa-44c3-bb63-01c0a49f5182@flourine.local>
References: <20241204114755.190660-1-nilay@linux.ibm.com>
 <20241204114755.190660-3-nilay@linux.ibm.com>
 <5178056a-4297-43ca-b15b-dfb8d9b21857@nvidia.com>
 <62addb0a-d115-4b2d-af3c-cedc41991f7c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62addb0a-d115-4b2d-af3c-cedc41991f7c@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_024738_943003_575CB5FC 
X-CRM114-Status: GOOD (  18.13  )
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

On Thu, Dec 05, 2024 at 03:10:23PM +0530, Nilay Shroff wrote:
> >> +	img="$(mktemp /tmp/blk_img_XXXXXX)"
> >> +	dd if=/dev/urandom of="$img" bs=512 count=1 status=none
> > 
> > why can't we just use the standard block device backed ns ?
> Using standard block device would also work however using the file backed block 
> device would be handy in case user doesn't have a spare standard block device 
> available which could be used for writing a random junk to it.

If I understood Chaitanya correctly, he would prefer to use the existing
helpers to setup the backend, either file or block. If so, I am also on
board with this idea, not to hard code backend into the test. We have
moved this into the helpers so that it's a test parameter.

> OK I think maybe there's a confusion, let me clarify one thing here: We're
> *not* disabling AEN functionality but only masking the ns-changed async even 
> notification from target and I believe that's perfectly legal per spec. I 
> shall update the comment added in the test case to avoid this confusion. 
> 
> > Can this be an exception for some reason ?
> > 
> > Shinichiro, Daniel any thoughts ?

I haven't really checked what the spec says on this topic. Nilay, could
you give a pointer, so I don't spend too much time trying to find the
right spot in the spec. Thanks!

> > +unsigned int ns_disable_error_inject;
> > +module_param(ns_disable_error_inject, int, 0644);
> > +MODULE_PARM_DESC(ns_disable_error_inject,
> > +                "delay xa_erase() in ns-disable path in seconds 
> > (default 0)");
> > +

Please no. This type of debugging/testing interface is hard to use IMO.
It should be in one of the psydo FS, sysfs, configfs or debugfs if
really needed.

Daniel

