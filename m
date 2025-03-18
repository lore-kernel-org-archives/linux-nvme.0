Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E544C28B2F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 13:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gibNWB+WbdBuAKKlNMqlggV5EjTaStrFi2d7OCuqByI=; b=cKlVsTI+mz9GmHqqxD4iYgS+mP
	T536VAKYEnVs+wtysbPgmZhfxgn8IcYeGojVsuXFDuyxNOIFLcvrbMRCr0meg7GFWqaoVzaxuwB2X
	Y2y8jTdL3Bs622GKJJs5N7M7ZO+wJZ2Ax9HteInXYRWYb5a5xvpZGMRNq3Fm6ntsfbTGvYebd/qR5
	fqzPq342oeGWIHhReIhfRapX8RGhH8Pm3R6lXKU859XAQCYO7f109KaZobqC9f3uzIXZQx3VWF6t2
	Iv7io+Ng4evlAR7lkCybE1lvLbdLadXNkERpV/uNTsQf2yopGo+nGV0C+ERVMyJAhMT3I+zY7Hkhe
	YbMn+OBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuXJ3-000000064Nd-42WV;
	Tue, 18 Mar 2025 13:48:33 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuX9p-000000062uv-2SRu
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 13:39:02 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6078721C8A;
	Tue, 18 Mar 2025 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742305138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gibNWB+WbdBuAKKlNMqlggV5EjTaStrFi2d7OCuqByI=;
	b=ti6+d0SeW7BhmFkgW7r23+8+arYvvQLNuMn2yAaZT9tEB/cDjjDjnjOJvnxeNMWQ8Bh4JK
	m3Zdpe+9YvemIYxdUwVFzgSLzX7XwX5a1tWrhK+rWND+oNw5+u2UEHci6FdIHM83EffluB
	lcjbQvZpzGHX3LffXc6XW6X+jmJ3P18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742305138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gibNWB+WbdBuAKKlNMqlggV5EjTaStrFi2d7OCuqByI=;
	b=7hZKMF50XG8wveUdt+w2kmkMK9l75Irx0QJEAJnQt4rF8sDCwgXzg2ETjF5QLpPimUGHJq
	JF7l60AXbutZ0eCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742305137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gibNWB+WbdBuAKKlNMqlggV5EjTaStrFi2d7OCuqByI=;
	b=OdSyO4nqpjnojlVp+PHoADAXfRquM7StiM1yjO/6zCRc3BqoIm+i/V5oL/itaL4mAaBwDe
	wiWxbK9K15AEK9XmMyvpK1vHU9Hy9ZjeBVYffFPOhyf5lxoee4MusZLpdbi1BUDjKSBmJ8
	uKSRL8lSe94Dxq4aMbitXq8RLWt55BM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742305137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gibNWB+WbdBuAKKlNMqlggV5EjTaStrFi2d7OCuqByI=;
	b=VmZL08TLpu1OmzYSdIdd0l3lqVESCJ+hKvfCTeSEeCS+pBeJYlyo6vLAbpsY38PpvD5rBZ
	d5/znPsz/0qvHWCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50EAB139D2;
	Tue, 18 Mar 2025 13:38:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7x7BEnF32Wd/dAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 18 Mar 2025 13:38:57 +0000
Date: Tue, 18 Mar 2025 14:38:56 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/18] nvmet-fcloop: refactor fcloop_nport_alloc
Message-ID: <66261f08-5386-4b22-aa6f-7be1d4023fee@flourine.local>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-4-05fec0fc02f6@kernel.org>
 <a9055e3c-d36f-4706-9fdc-f4532d14adb6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9055e3c-d36f-4706-9fdc-f4532d14adb6@suse.de>
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_063901_771838_5C3EDA2B 
X-CRM114-Status: GOOD (  14.72  )
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

On Tue, Mar 18, 2025 at 12:02:48PM +0100, Hannes Reinecke wrote:
> > -	list_for_each_entry(tmplport, &fcloop_lports, lport_list) {
> > -		if (tmplport->localport->node_name == opts->wwnn &&
> > -		    tmplport->localport->port_name == opts->wwpn)
> > -			goto out_invalid_opts;
> > +		INIT_LIST_HEAD(&nport->nport_list);
> > +		nport->node_name = opts->wwnn;
> > +		nport->port_name = opts->wwpn;
> > +		refcount_set(&nport->ref, 1);
> > -		if (tmplport->localport->node_name == opts->lpwwnn &&
> > -		    tmplport->localport->port_name == opts->lpwwpn)
> > -			lport = tmplport;
> > +		spin_lock_irqsave(&fcloop_lock, flags);
> > +		list_add_tail(&nport->nport_list, &fcloop_nports);
> > +		spin_unlock_irqrestore(&fcloop_lock, flags);
> >   	}
> Hmm. I don't really like this pattern; there is a race condition
> between lookup and allocation leading to possibly duplicate entries
> on the list.

Yes, that's not a good thing.

> Lookup and allocation really need to be under the same lock.

This means the new entry has always to be allocated first and then we
either free it again or insert into the list, because it's not possible
to allocate under the spinlock. Not that beautiful but correctness wins.

