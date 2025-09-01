Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0999ACA0FF0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Sep 2025 20:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RCBugcF98CI0wrGkrO2/gQGpoqK7KN+1C03Zi0E60ss=; b=OuhKn+3LhET57O3cp3qAFxvOBh
	hO+d+ReY66SQHV8L5rA4NV9mgef+DudOXSmEQVYb/yyJqKDS3/PddOcCXni83dIgP0UwKqXgLCU3q
	uVapq9rY6hXAMayxAns/slW8JTyPFleOzsA5+xIx4BBEVX8ZYtyFe6GIPD5yIWnvCshU67A6xB5vP
	nJB4NQXLyg49hyUpjcjeiUujNeKUrBJ+VwbJly/+vf8ZYry7k1yYBziZI/6icEQ5tOLAIuSEZAHgR
	miIbJIUkm5MMSz6A4aRKHic6uK+lUsE84vkk9hCJuEbWNUnFYSA4MWqHOHQoQkha7iIYcI81nZPI1
	dBZcVT/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utAi1-0000000DjdH-0MOQ;
	Mon, 01 Sep 2025 20:00:57 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut7WG-0000000DIGD-3Lv6
	for linux-nvme@lists.infradead.org;
	Mon, 01 Sep 2025 16:36:42 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99F41211A8;
	Mon,  1 Sep 2025 16:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756744594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCBugcF98CI0wrGkrO2/gQGpoqK7KN+1C03Zi0E60ss=;
	b=MMH8/ggiZBRztswYKSx2XKZVOe9MV32GaRoR5vtSTyFTN2U/eqF3CaeeNHUgT+WMdu2peO
	XDOAM5B9jv//w96sRuRObRTq3+1AUON1kP15o4Rw4akYvGd0bElkXPd70Nqdd0vg22pHC0
	86iLyGeeuGGn/65KbiTNSwpwMm5X8mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756744594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCBugcF98CI0wrGkrO2/gQGpoqK7KN+1C03Zi0E60ss=;
	b=7dA3blzhfFnSX8+mKroVKfYmTvaJoHuT85ETAYva8nfMXD1rhzMIWcZnidDu92+Bu0oD/a
	FC8ZYvyT1HyWqXDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756744593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCBugcF98CI0wrGkrO2/gQGpoqK7KN+1C03Zi0E60ss=;
	b=o5HaV+rIncplOVaMf81UozlZWESi0kLBERjpfGL9BV9pBRVGQATlVFj+ObQJLCm9Vpk89H
	UJqjsE0aeyYsl0igX2SZAUogrLCOuKd/VyXq+/93n5Q1wvYcgoE6I6uZYwt59ZzA/yaoF6
	/GgwF6YjQ1U750DHMGl9eQptQyeAj1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756744593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCBugcF98CI0wrGkrO2/gQGpoqK7KN+1C03Zi0E60ss=;
	b=zuEI0uSFRKKkUwQ8DuESqO5cZ0MGbTPOxO+qOcXBGgR1yOo7Tx3lxUobspj9NRfITVDxIl
	HsmgPVuvLwQ3CmAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BD8213A3E;
	Mon,  1 Sep 2025 16:36:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sMhDIZHLtWgheQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 01 Sep 2025 16:36:33 +0000
Date: Mon, 1 Sep 2025 18:36:29 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	kbusch@kernel.org, gjoyce@ibm.com
Subject: Re: [PATCHv2 2/4] nvme: extend show-topology command to add support
 for multipath
Message-ID: <2eeba3ca-293c-429b-8afa-c5ba401c67b6@flourine.local>
References: <20250812125614.164445-1-nilay@linux.ibm.com>
 <20250812125614.164445-3-nilay@linux.ibm.com>
 <93be5b21-8897-44d3-a590-42ba8f1b6abb@suse.de>
 <a06660fb-821f-447e-9ea6-ef0f3372a844@linux.ibm.com>
 <ecd33303-830d-4e26-b49a-14a558725e67@suse.de>
 <4f504c94-e6da-4a33-aa12-9dcb447e7021@flourine.local>
 <4e20561b-8b51-45c5-ad83-24b3d7ae092d@suse.de>
 <180fd47e-ffe6-4ef1-986e-5885afc34c01@linux.ibm.com>
 <8de91a15-3d89-4801-911a-00e45bb6a2f1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8de91a15-3d89-4801-911a-00e45bb6a2f1@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_093637_147291_5B11D8A2 
X-CRM114-Status: GOOD (  24.17  )
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

Hi Nilay,

On Mon, Sep 01, 2025 at 02:51:09PM +0530, Nilay Shroff wrote:
> Hi Daniel and Hannes,
> 
> Just a gentle ping on this one...
> 
> Do you agree with the reasoning I suggested for filtering
> columns based on iopolicy? If we all have agreement then
> I'd send out the next patchset with appropriate change.

I was waiting for Hannes input here as he was in discussion.

> >> But really, I'm not sure if we should print out values from the various
> >> I/O policies. For NUMA it probably makes sense, but for round-robin and
> >> queue-depths the values are extremely volatile, so I wonder what benefit
> >> for the user is here.
> >>
> > 
> > I think the qdepth output could still be useful. For example, if I/Os are
> > queuing up on one path (perhaps because that path is slower), then the Qdepth
> > value might help indicate something unusual or explain why one path is being
> > chosen over another.
> > 
> > That said, if we all agree that tools or scripts should ideally rely on JSON
> > output for parsing, then the tabular output could be simplified further:
> > 
> > - For numa iopolicy: print <Nodes> and exclude <Qdepth>.
> > - For queue-depth iopolicy: print <Qdepth> and exclude <Nodes>.
> > - For round-robin iopolicy: exclude both <Nodes> and <Qdepth>.

Looks reasonable to me.

> > Does this sound reasonable? Or do we still want to avoid printing 
> > <Qdepth> even for queue-depth iopolicy?

I am fine with printing the qdepth value as long it is documented what it
means. IIRC there are other tools which just show a snapshot for some
statistics.

BTW, some discussion on github regarding something like a
'monitor' feature: https://github.com/linux-nvme/nvme-cli/issues/2189
Might be something to which could be considered here as well.

Thanks,
Daniel

