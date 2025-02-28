Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339AEC19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 07:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hMhfRxvqIxKZMaQZi3hmHrhrCs+pyqYO7m7E4eS+VBs=; b=4OqCO6+20PRZjC2GZzVw5ppeU3
	2Vuy0r3V6dTxVias4Re42yTE0ibkKq++Q8XWg5gtHTl5VUxw0xH/I4Er5hou0+ToaGFSDwxy6wfjz
	PwZ1OA0WWjqH94xq+Ja3LQcs7+1sAFdE7LqZiakaMPfFh0fK+5Kkl15DHSvbgVFHExrhEauQmH7s9
	OOConm7kXjdg6YIhpltg3YaOvp2nh3LXhG2+zJ3ZCOEM5iO53mO9r/IpBXZFVlJQws7Neu98ib+8O
	pSSMhZkkuQShDrDDSB1jbSC1TkU2lr/pGIVhXUGEMztyMDsLXXqyhZdObDb0IILhNjdKXaL3VWavw
	rF2XTbdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnvG3-0000000A470-0TLA;
	Fri, 28 Feb 2025 07:58:07 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnvEy-0000000A3w2-2hbs
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 07:57:01 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0B75C2116F;
	Fri, 28 Feb 2025 07:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740729419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMhfRxvqIxKZMaQZi3hmHrhrCs+pyqYO7m7E4eS+VBs=;
	b=UAZFwBtzHSBKCPtNx7WHhO16JG5xF871Dgorzgjj0w8p4FRTsaATlE/P2h3j6giFJLHg0B
	rhahqIkCoSAEq+9dXSBKtYMsAx4m2eiBBMV/Ho9xCLV+vF/gHwzfBsK4MXaGML0/T9L8zj
	DkgwsAGJFyY5hexDsD2sgml5KjqwFPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740729419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMhfRxvqIxKZMaQZi3hmHrhrCs+pyqYO7m7E4eS+VBs=;
	b=XtbLek288T5w9IO4MIJcSfmiX2k8M8x9cjE2u8pWYPlML4RxBCb63mpouktiobGF+hQJi+
	X6pX5jXg5sfOMUCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740729419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMhfRxvqIxKZMaQZi3hmHrhrCs+pyqYO7m7E4eS+VBs=;
	b=UAZFwBtzHSBKCPtNx7WHhO16JG5xF871Dgorzgjj0w8p4FRTsaATlE/P2h3j6giFJLHg0B
	rhahqIkCoSAEq+9dXSBKtYMsAx4m2eiBBMV/Ho9xCLV+vF/gHwzfBsK4MXaGML0/T9L8zj
	DkgwsAGJFyY5hexDsD2sgml5KjqwFPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740729419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMhfRxvqIxKZMaQZi3hmHrhrCs+pyqYO7m7E4eS+VBs=;
	b=XtbLek288T5w9IO4MIJcSfmiX2k8M8x9cjE2u8pWYPlML4RxBCb63mpouktiobGF+hQJi+
	X6pX5jXg5sfOMUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E58BE13888;
	Fri, 28 Feb 2025 07:56:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vjwUN0pswWfGLgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 28 Feb 2025 07:56:58 +0000
Date: Fri, 28 Feb 2025 08:56:58 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] nvmet-fcloop: refactor fcloop_nport_alloc
Message-ID: <0e41c69f-32f0-4c19-8d52-04d767acbaed@flourine.local>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-3-c0bd83d43e6a@kernel.org>
 <fd877a93-8630-4180-a591-5916e18cda72@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd877a93-8630-4180-a591-5916e18cda72@suse.de>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_235700_838421_819CF2FB 
X-CRM114-Status: GOOD (  16.35  )
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

On Fri, Feb 28, 2025 at 08:11:11AM +0100, Hannes Reinecke wrote:
> > +	nport = fcloop_nport_lookup(opts->wwnn, opts->wwpn);
> > +	if (nport && ((remoteport && nport->rport) ||
> > +		      (!remoteport && nport->tport))) {
> > +		/* invalid configuration */
> > +		goto out_put_nport;
> > +	}
> > -	spin_lock_irqsave(&fcloop_lock, flags);
> > +	if (!nport) {
> > +		nport = kzalloc(sizeof(*nport), GFP_KERNEL);
> > +		if (!nport)
> > +			goto out_free_opts;
> > -	list_for_each_entry(tmplport, &fcloop_lports, lport_list) {
> > -		if (tmplport->localport->node_name == opts->wwnn &&
> > -		    tmplport->localport->port_name == opts->wwpn)
> > -			goto out_invalid_opts;
> > +		INIT_LIST_HEAD(&nport->nport_list);
> > +		nport->node_name = opts->wwnn;
> > +		nport->port_name = opts->wwpn;
> > +		kref_init(&nport->ref);
> > -		if (tmplport->localport->node_name == opts->lpwwnn &&
> > -		    tmplport->localport->port_name == opts->lpwwpn)
> > -			lport = tmplport;
> > +		spin_lock_irqsave(&fcloop_lock, flags);
> > +		list_add_tail(&nport->nport_list, &fcloop_nports);
> > +		spin_unlock_irqrestore(&fcloop_lock, flags);
> 
> Don't you need to check here if an 'nport' with the same node_name and
> port_name is already present?

There is the existing check which filters out some of the duplicates
(the check is there to allow setting up the target or the remote port
first, so the order doesn't matter), though I am not sure if it would
catch all duplicates. I don't mind adding this, but I'd say it would be
better in a separate patch. I tried to refactor this code without
changing anything else.

