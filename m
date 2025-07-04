Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4010C83F0B
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U8DGv5s4oBbf5Xmo9N6DSZCMc93Z976dlHWpEdg22kI=; b=QhrrlKCe1PdF7vfpO/7iVeCIWt
	iCiiKkCxoFytlL+QHt15kNkJaHipm74YZah6+/QoHdOtDG7DQYpiqh5Nj4kPQXKWVUg5xyKLbiXfb
	dVSAp2hKgGI3iBF0xbYFOcgISmuYHCnburY8XyMxpCQKvU3b8YrUw5UbU/WQHeDHGkjjULqqZ8QmN
	sILQjCAIvPx7oYi3bj/+RvWP+Y9h7Vo6I8lPDOOhuttLn3u/5AHeXtRAe8dj+4Zt6xnK+mPzi+/Tj
	7vWm7iZx4Ia36bjMVXz86wOr6cprdT87kyRHObsgtG/Z9Y7w3lEIUedF2Ux0NpUYoIkOVM+47fC/A
	wwwSJ7qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXeUb-0000000ECjt-2HIS;
	Fri, 04 Jul 2025 11:22:09 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXcI0-0000000Dqf4-0qsK
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 09:01:01 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E30621194;
	Fri,  4 Jul 2025 09:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751619657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8DGv5s4oBbf5Xmo9N6DSZCMc93Z976dlHWpEdg22kI=;
	b=ojI/ZgdlMnbHGxydH02at11LU07EryvjEUTW7WVdoAjLRhMLAokRomxzvHEJXtOdQVawX6
	VDIbitatw5Ywe1F4boG0x0rUykXpoytb4PwfTuEEgLmMAhHmSON49CSuq8TJIS1Z/tSIOf
	RK+NY1xW4KHOrzYcLNqbNsg0mBFN5FE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751619657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8DGv5s4oBbf5Xmo9N6DSZCMc93Z976dlHWpEdg22kI=;
	b=fV3mnSpfrnCpASP7NvSx894BJkuq1cbiSAOYFl4lMPqMSsRn+OyInOp1SEJEAK5kxGaTp4
	1EQNt2jmjNN+LiBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751619657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8DGv5s4oBbf5Xmo9N6DSZCMc93Z976dlHWpEdg22kI=;
	b=ojI/ZgdlMnbHGxydH02at11LU07EryvjEUTW7WVdoAjLRhMLAokRomxzvHEJXtOdQVawX6
	VDIbitatw5Ywe1F4boG0x0rUykXpoytb4PwfTuEEgLmMAhHmSON49CSuq8TJIS1Z/tSIOf
	RK+NY1xW4KHOrzYcLNqbNsg0mBFN5FE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751619657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8DGv5s4oBbf5Xmo9N6DSZCMc93Z976dlHWpEdg22kI=;
	b=fV3mnSpfrnCpASP7NvSx894BJkuq1cbiSAOYFl4lMPqMSsRn+OyInOp1SEJEAK5kxGaTp4
	1EQNt2jmjNN+LiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 299B013757;
	Fri,  4 Jul 2025 09:00:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id COEjCkmYZ2ibHQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 04 Jul 2025 09:00:57 +0000
Date: Fri, 4 Jul 2025 11:00:56 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	storagedev@microchip.com, virtualization@lists.linux.dev, 
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v7 08/10] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
Message-ID: <75aafd33-0aff-4cf7-872f-f110ed896213@flourine.local>
References: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org>
 <20250702-isolcpus-io-queues-v7-8-557aa7eacce4@kernel.org>
 <20250703090158.GA4757@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703090158.GA4757@lst.de>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL67935bhfdkbndpbo95z3ogoo)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_020100_390510_D7114EB0 
X-CRM114-Status: GOOD (  18.51  )
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

On Thu, Jul 03, 2025 at 11:01:58AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 02, 2025 at 06:33:58PM +0200, Daniel Wagner wrote:
> >  const struct cpumask *blk_mq_possible_queue_affinity(void)
> >  {
> > +	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
> > +		return housekeeping_cpumask(HK_TYPE_IO_QUEUE);
> > +
> >  	return cpu_possible_mask;
> >  }
> 
> I'm no expert on the housekeeping stuff, but why isn't the
> housekeeping_enabled check done in housekeeping_cpumask directly so
> that the drivers could use housekeeping_cpumask without a blk-mq
> wrapper?

Yes, housekeeping_cpumask will return cpu_possible_mask when housekeping
is disabled. Though some drivers want cpu_online_mask instead. If all
drivers would agree on one version of the mask it should allow to drop
to these helpers (maybe we the houskeeping API needs to be extended then
though)

This is also what Hannes brought up. If the number of supported hardware
queues for a device is less than cpu_possible_mask, it really makes
sense to distribute the hardware queues only between the online cpus. I
think the only two drivers which are interested in the cpu_possible_mask
are nvme-pci and virtio.

