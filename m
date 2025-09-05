Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194E1CA0FED
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 08:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m+BAVyD25FezVwTZNryOXCPxljZr03tkbPhnVekdh0Q=; b=PNWKe9lxOsouHIWWF8SrS5/tbY
	GkzQzasLX0/vEwP/kbvlsD7e6zJDyp+WC3KZQ6lPjl0nS+Vwz2Sgy4Giga4hfiC32OuImuZ09Gul4
	INAy6hYFRu2P/QT0dIAlbUwTGHciV8++WXRJP92ufrdQo1cSkaZa+zoBmx+9HypLHhBd18KT4/cbS
	WvCCN0/ClbGsKcNz+1O/WtG0y8uWy3x7xvROPhTJvKkoFixwXFZzuBHZl1Hcd6p12iOXgCnZH+3jG
	OvbKjkf8Xx0AJrqiCwFMfYegZmEy5/FfbWYWvFYRszTKOh83wJkk7Sl00ohl/stxupjV9fRZ2Zo5b
	g8Bjg+1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuSED-00000000WpR-2WOx;
	Fri, 05 Sep 2025 08:55:29 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuR4r-000000005oz-3u9c
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 07:41:47 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A39294D92A;
	Fri,  5 Sep 2025 07:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757058102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+BAVyD25FezVwTZNryOXCPxljZr03tkbPhnVekdh0Q=;
	b=MFDWFDQTxyFbha5g/xmtOkY9FdHT1TPudDjvqYwHsDk5SImSbZxn/UexebPgLDQHU8YU8d
	Ec/gXDhN2/z3m4tj5II4pl3G+w4J0GRW34tpKZA95RKBLjeOyGVXzGP9VQBMKmiOocDEtZ
	xeAKH9om4Tp7ACLeDNE8xAxEZUJQ8Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757058102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+BAVyD25FezVwTZNryOXCPxljZr03tkbPhnVekdh0Q=;
	b=d6wvA4x60pwWJ3Inxph2sEG+i20Ywu9+zBr/tJXUPI175gQzsXaSR0gHnEvoxXuMpERJG9
	XFSiqAUMRxQCGBAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MFDWFDQT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=d6wvA4x6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757058102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+BAVyD25FezVwTZNryOXCPxljZr03tkbPhnVekdh0Q=;
	b=MFDWFDQTxyFbha5g/xmtOkY9FdHT1TPudDjvqYwHsDk5SImSbZxn/UexebPgLDQHU8YU8d
	Ec/gXDhN2/z3m4tj5II4pl3G+w4J0GRW34tpKZA95RKBLjeOyGVXzGP9VQBMKmiOocDEtZ
	xeAKH9om4Tp7ACLeDNE8xAxEZUJQ8Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757058102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+BAVyD25FezVwTZNryOXCPxljZr03tkbPhnVekdh0Q=;
	b=d6wvA4x60pwWJ3Inxph2sEG+i20Ywu9+zBr/tJXUPI175gQzsXaSR0gHnEvoxXuMpERJG9
	XFSiqAUMRxQCGBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C07E13306;
	Fri,  5 Sep 2025 07:41:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4CXcITaUumiHCwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 05 Sep 2025 07:41:42 +0000
Date: Fri, 5 Sep 2025 09:41:42 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	storagedev@microchip.com, virtualization@lists.linux.dev, 
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v7 05/10] scsi: Use block layer helpers to constrain
 queue affinity
Message-ID: <71598d89-b29c-4b21-83ee-49fe9b890043@flourine.local>
References: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org>
 <20250702-isolcpus-io-queues-v7-5-557aa7eacce4@kernel.org>
 <d95de280-8cd7-4697-933a-37dc53f4c552@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d95de280-8cd7-4697-933a-37dc53f4c552@suse.de>
X-Rspamd-Queue-Id: A39294D92A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL71uuc3g3e76oxfn4mu5aogan)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_004146_260273_8A224909 
X-CRM114-Status: GOOD (  19.43  )
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

On Thu, Jul 03, 2025 at 08:43:01AM +0200, Hannes Reinecke wrote:
> >   drivers/scsi/fnic/fnic_isr.c              | 7 +++++--
> >   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    | 1 +
> >   drivers/scsi/megaraid/megaraid_sas_base.c | 5 ++++-
> >   drivers/scsi/mpi3mr/mpi3mr_fw.c           | 6 +++++-
> >   drivers/scsi/mpt3sas/mpt3sas_base.c       | 5 ++++-
> >   drivers/scsi/pm8001/pm8001_init.c         | 1 +
> >   drivers/scsi/qla2xxx/qla_isr.c            | 1 +
> >   drivers/scsi/smartpqi/smartpqi_init.c     | 7 +++++--
> >   8 files changed, 26 insertions(+), 7 deletions(-)
> >
> 
> All of these drivers are not aware of CPU hotplug, and as such
> will not be notified when the number of CPUs changes.
> But you use 'blk_mq_online_queue_affinity()' for all of these
> drivers.
> Wouldn't 'blk_mq_possible_queue_affinit()' a better choice here
> to insulate against CPU hotplug effects?
> 
> Also some drivers which are using irq affinity (eg aacraid, lpfc) are
> missing from these conversions. Why?

I've updated both drivers to use pci_alloc_irq_vectors_affinity with the
PCI_IRQ_AFFINITY flag. But then I saw this:

  dafeaf2c03e7 ("scsi: aacraid: Stop using PCI_IRQ_AFFINITY")

So we need be careful here.

In the case of lpfc (and qla2xxx), the nvme-fabrics core needs to be
updated too (gets out ouf sync with the number of queues allocated). I
already have patches for this. But I'd say we first continue with this
series before the next set of patches.

Thus I decided to drop all the driver updates which are currently not
using pci_alloc_irq_vectors_affinity and PCI_IRQ_AFFINITY. These are
supporting managed irqs thus these should be all ready for this feature.

For the rest of the drivers, I'd rather update one by one so we don't
introduce regressions (e.g. aacraid)

