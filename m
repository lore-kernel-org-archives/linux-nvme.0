Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E412C3ABD8
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 17:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PwemYqSx1joAsHvddH5vUeTn++S/Lwwkxkdrd/VN3vE=; b=kfEI8CIxLnjkoEKjZRk+Hx5+hP
	n6Xj0wcBbHy35CHGCHA/v2KLob+r+n5y+uukt7g2r3yxXKcT7h0kR6sLzOgCBMz5ub80rVveYpMGq
	+JhAMYWq917E6JttncbncUgYChZGUYZCs8ZaPLl4DpY2uDCJZOwdQoMmoOQ/PIDOLV0Qzt9Ca9o0e
	FqfF2bklLjFDysjNHNCPuhdxIwue1JUN0pfcEQHKblYE3t0dvkJU0JwBJVEGBTuUKjKixh+yq7B2v
	4qyAtDtEzUJLCOV/kV0tHIzvIcpvjHKXk6oWpp+rGwjDAzjZUMLGkerXGJ/dsc3iExdeBPrFwMNGp
	pY94EazQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFGBe-0000000Fu5q-42Mj;
	Wed, 14 May 2025 17:46:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFEf5-0000000FgZM-2W3x
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 May 2025 16:08:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PwemYqSx1joAsHvddH5vUeTn++S/Lwwkxkdrd/VN3vE=; b=OFExPvI1I510pmPs8UxaYil1Lm
	1AihZgxbA247kGjXByyYOtVuDoO0zmw3tj7LjoXAkjO18odCxLX1Zqm8X1D4W5A957Su0e+5Alz0l
	tRIGC9HdJraX8xrTbf8wk0K2gtoEqkmhcf4Kz94uhBh2fZZbhYlaE+4qP2/MWFfYKzSpBQ+oWKJ08
	3rAH/QHwRnfELCwq772E3aAIWTnnwmeBTbHBAFi7/gr+cKr1wEjQ9wJOmAhgNvt4t1t2qq+BQqvMY
	BbEgsUncdiF+9jAEnwDtvgjR0fxju/qbckWKAccPMJJFFsGqxUzIMXGq7s8JqkuDS3/H8aUv0RSIA
	JZ1/A5iQ==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uFEf2-0000000HFm9-0ijE
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 16:08:50 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64FC6211C6;
	Wed, 14 May 2025 16:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747238925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PwemYqSx1joAsHvddH5vUeTn++S/Lwwkxkdrd/VN3vE=;
	b=HP9Skt9rm7WKGVr9FhJS2qwWSQVBH16kWhzGzuXqPtnM/6MWapaWsEltEX2cHd7ywkHXvq
	0E1gGk0BDq0FfYCf0huIb9Nnnqf3kxOH2itS/Zdcz2F61nXWPZ2WD1YuyhF5cX29N06GNW
	325yGH3/h6im5SHcyN/Pr9/EpGCTqvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747238925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PwemYqSx1joAsHvddH5vUeTn++S/Lwwkxkdrd/VN3vE=;
	b=3ZEaJ1jculhnrIBINmPnOy5TNzJkzkJPwTpxmwz3MwwbjatG7zMWo8waQCnZUs40+mCAsJ
	syFDyZQ1ARf5iiAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747238925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PwemYqSx1joAsHvddH5vUeTn++S/Lwwkxkdrd/VN3vE=;
	b=HP9Skt9rm7WKGVr9FhJS2qwWSQVBH16kWhzGzuXqPtnM/6MWapaWsEltEX2cHd7ywkHXvq
	0E1gGk0BDq0FfYCf0huIb9Nnnqf3kxOH2itS/Zdcz2F61nXWPZ2WD1YuyhF5cX29N06GNW
	325yGH3/h6im5SHcyN/Pr9/EpGCTqvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747238925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PwemYqSx1joAsHvddH5vUeTn++S/Lwwkxkdrd/VN3vE=;
	b=3ZEaJ1jculhnrIBINmPnOy5TNzJkzkJPwTpxmwz3MwwbjatG7zMWo8waQCnZUs40+mCAsJ
	syFDyZQ1ARf5iiAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E58C13306;
	Wed, 14 May 2025 16:08:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1RI1Dw3AJGhoNgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 May 2025 16:08:45 +0000
Date: Wed, 14 May 2025 18:08:40 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, Daniel Wagner <wagi@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	storagedev@microchip.com, virtualization@lists.linux.dev, 
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v6 6/9] isolation: introduce io_queue isolcpus type
Message-ID: <706b08be-781c-45d6-8c16-93d6d97b4330@flourine.local>
References: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
 <20250424-isolcpus-io-queues-v6-6-9a53a870ca1f@kernel.org>
 <2db989db-4849-46a9-9bad-0b67d85d1650@suse.de>
 <dd4719dc-5ac4-44d9-bccb-e867d322864e@flourine.local>
 <aB1iolILQcvvHDE9@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB1iolILQcvvHDE9@fedora>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_170848_340662_8C704FC7 
X-CRM114-Status: GOOD (  21.51  )
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

On Fri, May 09, 2025 at 10:04:18AM +0800, Ming Lei wrote:
> > 			io_queue
> > 			  Isolate from IO queue work caused by multiqueue
> > 			  device drivers. Restrict the placement of
> > 			  queues to housekeeping CPUs only, ensuring that
> > 			  all IO work is processed by a housekeeping CPU.
> > 
> > 			  Note: When an isolated CPU issues an IO, it is
> > 			  forwarded to a housekeeping CPU. This will
> > 			  trigger a software interrupt on the completion
> > 			  path.
> > 
> > 			  Note: It is not possible to offline housekeeping
> > 			  CPUs that serve isolated CPUs.
> 
> This patch adds kernel parameter only, but not apply it at all, the above
> words just confuses everyone, so I'd suggest to not expose the kernel
> command line & document until the whole mechanism is supported.

I'll add this doc update as last patch.

> Especially 'irqaffinity=0 isolcpus=io_queue' requires the application
> to offline CPU in order, which has to be documented:
> 
> https://lore.kernel.org/all/cc5e44dd-e1dc-4f24-88d9-ce45a8b0794f@flourine.local/

Okay, so you want me to extend the above second note in this case. I'll
give it a go.

