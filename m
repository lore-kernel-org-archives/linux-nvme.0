Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79E0C8303D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 10:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ekBlNVVd5BWSYFIgjqQoE6SrY7z90AKUGm9nA4AlaBA=; b=alAszVjF3L9eVJyMhT0FB2DTYP
	Hye8dkyUi0UZu5Sq74l7K/oW5lydF2f//kKCPB5hKI57CGkkZ/cbKGKzexGDwAhS7yp7QXxSTWKde
	AnjsWCqjJ43lIi3ttLPyJgw3qesDVr1K86obTQAM3kvAIGK00dzhrql+HuYItirLh2xsLBAVWV6tY
	Ue4+oSVfDokW8LD16HcV2EVG46YOfMFJtFkPeSfm/60GqOl9dtBw2Wa+1ZT5fx/uaxCUkA5/oK87t
	f4MU2o5nnfsiBX4OLgEii0BXIK3AVyLcPKEhacqi1H3mgseBQOSxXukfPq9iz+D9qtfS7L+1dL9T1
	afpYJnLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXe3z-0000000E82y-39la;
	Fri, 04 Jul 2025 10:54:39 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXcr6-0000000DwuZ-0pVb
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 09:37:17 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68FFD1F38A;
	Fri,  4 Jul 2025 09:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751621834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekBlNVVd5BWSYFIgjqQoE6SrY7z90AKUGm9nA4AlaBA=;
	b=d7LLuBozyvt0UmZ/0dHI6gw2gLOxlUtxZK1CHleSZohhSwLM32fbGWYIIRIgIrMXIv/+Z3
	1pbzaEv1Ux4CL+vE1V1VWrvc/5XK7z01AdkMMd1VaD46Sak3aIAW0QJZ0SMmAD+6iRn/sg
	HqoAqhAunfgAS6ir47eRXPzzeofRz+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751621834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekBlNVVd5BWSYFIgjqQoE6SrY7z90AKUGm9nA4AlaBA=;
	b=uwbLtNAp0WDeizI4MkZOTyJ6ajYGyMwu4acyMYvelEpxTNHKp0Oe8+GLl+3vcYBifXFrGk
	NWyFzdl7LcM75JDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751621834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekBlNVVd5BWSYFIgjqQoE6SrY7z90AKUGm9nA4AlaBA=;
	b=d7LLuBozyvt0UmZ/0dHI6gw2gLOxlUtxZK1CHleSZohhSwLM32fbGWYIIRIgIrMXIv/+Z3
	1pbzaEv1Ux4CL+vE1V1VWrvc/5XK7z01AdkMMd1VaD46Sak3aIAW0QJZ0SMmAD+6iRn/sg
	HqoAqhAunfgAS6ir47eRXPzzeofRz+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751621834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekBlNVVd5BWSYFIgjqQoE6SrY7z90AKUGm9nA4AlaBA=;
	b=uwbLtNAp0WDeizI4MkZOTyJ6ajYGyMwu4acyMYvelEpxTNHKp0Oe8+GLl+3vcYBifXFrGk
	NWyFzdl7LcM75JDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4018213757;
	Fri,  4 Jul 2025 09:37:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KFlRD8qgZ2jZKAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 04 Jul 2025 09:37:14 +0000
Date: Fri, 4 Jul 2025 11:37:09 +0200
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
Message-ID: <2e7576e4-442f-4000-817d-6253374f5818@flourine.local>
References: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org>
 <20250702-isolcpus-io-queues-v7-5-557aa7eacce4@kernel.org>
 <d95de280-8cd7-4697-933a-37dc53f4c552@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d95de280-8cd7-4697-933a-37dc53f4c552@suse.de>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_023716_383341_E4DEBBB1 
X-CRM114-Status: GOOD (  16.94  )
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
> All of these drivers are not aware of CPU hotplug, and as such
> will not be notified when the number of CPUs changes.

Ah, this explains this part.

> But you use 'blk_mq_online_queue_affinity()' for all of these
> drivers.

All these drivers are also using blk_mq_num_online_queue. When I only
used cpu_possible_mask the resulting mapping was not usable.

> Wouldn't 'blk_mq_possible_queue_affinit()' a better choice here
> to insulate against CPU hotplug effects?

With this mask the queues will be distributed to all possible CPUs and
some of the hardware queues could be assigned to offline CPUs. I think
this would work but the question is, is this okay to leave some of the
perfomance on the road?

I am not against this, just saying it would change the existing
behavior.

> Also some drivers which are using irq affinity (eg aacraid, lpfc) are
> missing from these conversions. Why?

I was not aware of aacraid. I started to work on lpfc and well let's put
it this way, it's complicated. lpfc needs a lot of work to make it
isolcpus aware.

