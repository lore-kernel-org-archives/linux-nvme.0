Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E510DC3ABDD
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DmGO+NabaKpfrrkQS+LCDqhwMzhbABcI3RxnkP+9bj4=; b=YuPqnR9goj+HD9YbzmkCiaYofV
	ahiUlA8PBN7oPSDMQwjkrXCd3AW5pdGhVMJPYLEn1wzQdSjYAGqGZF6rjJrAQw7LDD/lPwMZp5BPj
	IYKx8rTfrLW1bTbvRBNGHZ7UgtKo31iho+LhDWqrMpKCWhcmie21nQctMUMGnTGMrzt1FxjpFMD8b
	T0Noz5bd+gO1VyGFpFE88wiASw+gE+zHt1vw80BxP+YQ7HIPNNNGqqaZMKuxRJ9iuCGYQ/i3+fbAZ
	0w8XMcerX4IVc6DwYS3wjIAezmo64NVqjljtwW09qN1CdXiGnRCZVUjnBhRyr30dcdMHrfV7r7aAe
	jk/p8zWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFGvT-0000000G20a-44Sc;
	Wed, 14 May 2025 18:33:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFGEV-0000000Fwws-2saD
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 May 2025 17:49:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DmGO+NabaKpfrrkQS+LCDqhwMzhbABcI3RxnkP+9bj4=; b=dWlnakb7OUWlysGsTueAy2ZYIC
	VrriExBLiL2Jq+axyRvURpPeK2k7J5mE31KU/KA0eFU2lvpKiaX+nknVHyLfqmvBCfw7ZLg25Zt+r
	56bxMmhaRo8/oYJrX2y+EKGJc4SxEJqUfL5T7eCjcDWl1O7bYsIxvOhgfldFRyEIE+gPQnVSd6AdG
	wGMHJj5t0VmI7+ZymwP5G6kopAEbQqAlU6RL3nYadzTjgDR/zkCS5IeG40F4PVvZj8eT0bMOlULCh
	Ptf2SCKnmWaMmRW6pY3YP4BMdJ+00pg9XftHMzqnk/+cuKsAFqt10B3YQa28eJXQqb/hBVSj86Yu5
	GdUDT5MQ==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uFGES-0000000HHXm-1cGA
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 17:49:30 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 130111F399;
	Wed, 14 May 2025 17:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747244966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DmGO+NabaKpfrrkQS+LCDqhwMzhbABcI3RxnkP+9bj4=;
	b=c3z0KGJTV2vnFpdTSyoUNzljvLnILUDEMaasdHw6Oy/kgmK5QP/4WAG2U5oGk/5IHTzO80
	QchKXHJ42LcNvWBb95zDXyUHEY8mFVS7vrpd/7W2cphVwkywbvRDTqjCmDLElXUJl2VEAc
	To3oJEh5ubYJIkUefzGn20v+kPsgd2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747244966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DmGO+NabaKpfrrkQS+LCDqhwMzhbABcI3RxnkP+9bj4=;
	b=k5sUYedmbXgKVYrKaS+vGV9REJF5079skawrmBEuivZnSzCWop+lC8+K9qbKY4J5EVM6hz
	OsUhOKvlfZSR4FCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747244965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DmGO+NabaKpfrrkQS+LCDqhwMzhbABcI3RxnkP+9bj4=;
	b=slKEHsveynpUG2MSh7A2qlx3v72ZYhuw7/NON85cE9u9CLH0L3QIoV+Qy0HNHySNg+6SKm
	L/EY/qawjhjhgFQIxsc3Q8KkB4VO1eYwU5v565MmjThEAK/pTrDyjMfnCIFZAei3XH3wac
	EUXiwfN9YHqXZELr5ZcFf3jdeOEpeZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747244965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DmGO+NabaKpfrrkQS+LCDqhwMzhbABcI3RxnkP+9bj4=;
	b=MN5gXTrkQKzK9YZEOjvXI5BWfonVrNqEbB2mOKVNSZWDE28CQr9myrvNbNCRc63QukAJIM
	z6O/jWSZdT7tvwAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE9A413306;
	Wed, 14 May 2025 17:49:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9B1SNqTXJGiNUwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 May 2025 17:49:24 +0000
Date: Wed, 14 May 2025 19:49:20 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Waiman Long <llong@redhat.com>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Costa Shulyupin <costa.shul@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	storagedev@microchip.com, virtualization@lists.linux.dev, 
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v6 7/9] lib/group_cpus: honor housekeeping config when
 grouping CPUs
Message-ID: <770522cc-79fd-415b-9f4e-f25f8c73194e@flourine.local>
References: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
 <20250424-isolcpus-io-queues-v6-7-9a53a870ca1f@kernel.org>
 <cd1576ee-82a3-4899-b218-2e5c5334af6e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd1576ee-82a3-4899-b218-2e5c5334af6e@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_184928_788293_A40ACB5E 
X-CRM114-Status: GOOD (  14.15  )
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

On Tue, May 06, 2025 at 02:18:32PM -0400, Waiman Long wrote:
> > +static struct cpumask *group_mask_cpus_evenly(unsigned int numgrps,
> > +					      const struct cpumask *cpu_mask,
> > +					      unsigned int *nummasks)

> > +struct cpumask *group_cpus_evenly(unsigned int numgrps,
> > +				  unsigned int *nummasks)
> > +{
> > +	if (housekeeping_enabled(HK_TYPE_IO_QUEUE)) {
> > +		return group_mask_cpus_evenly(numgrps,
> > +				housekeeping_cpumask(HK_TYPE_IO_QUEUE),
> > +				nummasks);
> > +	}
> > +
> > +	return group_possible_cpus_evenly(numgrps, nummasks);
> > +}
> 
> The group_cpus_evenly() isn't just used by block I/O. So you can't make it
> check only HK_TYPE_IO_QUEUE here. I will suggest to make it a bit more
> general and add helper function to specify the isolated cpumask the caller
> want to skip.

Okay, in this case I'd make group_mask_cpus_evenly a public interface
and drop the houskeeping bits in group_cpus_evenly.

