Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF7EC369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 12:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xIYACVzH95X7MM4tbWT0wTSgKJd6vp8NHMKWqgVgJMA=; b=O+vpRlppgv1EcrSmJ/3Gax1CXV
	U9kRZBUsZgRAt4aHQqyPM9ip4VzEsoaN4A2ciX9HJDWSG3ln7MgvzfFFE3uTJ+dAYm+CLcxiEoOFd
	0QkP7pi6m1Uf24zuD3kWQL0m35jEzc8Kz8m/+vV12Qa0hoYCvbS7nkAVC85lvfzlkoeLUHQvGyPBq
	vjonRYoWYWy6qi666tdlytL0ZLSWwnqzTV54Y8R7lpKe7/rtiFqqRAH6ZRWVtCEVwpjPL1ytyMa6J
	4a8iBr0qpnKqorMc6cRCazR3yO+nVQ/mD/auZJaAtCL36N7aoz5S7TbrJ67ebTIwVYON1qKDCKBt4
	GSrVwlqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4fW4-00000005lXp-1cgN;
	Tue, 15 Apr 2025 12:35:52 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4eyA-00000005eBN-02tu
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 12:00:51 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53F4E1F385;
	Tue, 15 Apr 2025 12:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744718448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIYACVzH95X7MM4tbWT0wTSgKJd6vp8NHMKWqgVgJMA=;
	b=HIbbN4FabSCFbUCTFfy1BcdNReLGit4sWPpQUvbRUXA5d1NX5o3v+fLo2tZQYd+2tNXpnp
	8Buq0KQMipvqSGmkLIUhp19p5e9Gm7t4BlRN06tRfW8BXX8rLeYLja9tDAfr5oe5GUZ3zA
	fVQ1G4y+RWHfqm2vn66pR7T9/dJOg2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744718448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIYACVzH95X7MM4tbWT0wTSgKJd6vp8NHMKWqgVgJMA=;
	b=sLcpf5hA+SaX/LDXTmsDT4ur6R/Ns3gGP4isqUUS5egZTTR73/HJA36gVAiImTAyaEQEiw
	7nZRiW5xtP6rGjBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744718448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIYACVzH95X7MM4tbWT0wTSgKJd6vp8NHMKWqgVgJMA=;
	b=HIbbN4FabSCFbUCTFfy1BcdNReLGit4sWPpQUvbRUXA5d1NX5o3v+fLo2tZQYd+2tNXpnp
	8Buq0KQMipvqSGmkLIUhp19p5e9Gm7t4BlRN06tRfW8BXX8rLeYLja9tDAfr5oe5GUZ3zA
	fVQ1G4y+RWHfqm2vn66pR7T9/dJOg2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744718448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIYACVzH95X7MM4tbWT0wTSgKJd6vp8NHMKWqgVgJMA=;
	b=sLcpf5hA+SaX/LDXTmsDT4ur6R/Ns3gGP4isqUUS5egZTTR73/HJA36gVAiImTAyaEQEiw
	7nZRiW5xtP6rGjBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 351A0139A1;
	Tue, 15 Apr 2025 12:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gun6C3BK/md3CgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 15 Apr 2025 12:00:48 +0000
Date: Tue, 15 Apr 2025 14:00:47 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com, 
	Mohamed Khalfella <mkhalfella@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
Message-ID: <81f06615-2037-4177-b38e-d67c8e7ca95b@flourine.local>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <e8264916-ca27-4a3a-8006-a6e348282fc3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8264916-ca27-4a3a-8006-a6e348282fc3@suse.de>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_050050_195689_63FD653E 
X-CRM114-Status: GOOD (  15.12  )
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

On Tue, Apr 01, 2025 at 11:37:29AM +0200, Hannes Reinecke wrote:
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -2345,6 +2345,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
> >   	nvme_stop_keep_alive(ctrl);
> >   	flush_work(&ctrl->async_event_work);
> > +	nvme_schedule_failover(ctrl);
> >   	nvme_tcp_teardown_io_queues(ctrl, false);
> >   	/* unquiesce to fail fast pending requests */
> >   	nvme_unquiesce_io_queues(ctrl);
> > 
> Hmm. Rather not.
> 
> Why do we have to have a separate failover queue?

This RFC plays with the idea to handle the request which timeout on
ctrl level. The main point is to avoid touching every single transport.

An additional failover queue is likely to introduce new problems and
additional complexity. There is no free lunch. So I don't think it's a
good concept afterall.

And as discussed during LSFMM I think it would best to focus on factor
out the common code (the project I wanted to work on for a while...)
from the transports first and then figure out how to get the CQT, CCF
working.

> Can't we simply delay the error recovery by the cqt value?

Yes and no. As we know from our in house testing, it fixes the problem
for customers but it is not spec compliant.

