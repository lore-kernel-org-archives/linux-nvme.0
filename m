Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EFCC7EE2A
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 06:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O4a8monR3tF8KOIGOp3AbckiUTMIFvbQ7an8p9i9+Zs=; b=L3UX6SbUFcerT85IwG/OAEZIaG
	ENhJte44cFlEtZkdM9QeGNtMJDI+fr6VVXbKQRpZQtbjUO65fS/EZbx4QVu1YGTAgNfjX209T00OX
	3s4unvinzUpQ4IVah6etO9Gobg+Ens1ku4Cs2J4lhstRBDMz3TLwsgN8s6buu4AS9cK76NWO04PIJ
	x4PD2C93Y37vbCSvj5GofEwcequgUkq1gJ5HU7bUv4TjmdQAfgXqHf0qLdA1SbRCgw/TYIuMB8PbC
	5BdfX0S26wY3MMxSwjb9Ty580HGZQZxa37Fe8RhT2n3g4Rm3TWVMkvCpfoYGxVTpZ6zwpXa34qF/6
	o2YJ258A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW83o-00000001KwM-3sCt;
	Mon, 30 Jun 2025 06:32:12 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW81f-00000001KlG-0rqM
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 06:30:00 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2386E2115F;
	Mon, 30 Jun 2025 06:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751264996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4a8monR3tF8KOIGOp3AbckiUTMIFvbQ7an8p9i9+Zs=;
	b=gnlWZzxRYsR9snuPxctWbr4YxmPgmEHuiFM7oI2VvnZYQ2NDI8leSkqPR+O/VNhaC43iTL
	uZLbXaHvhxJOAaAK/Hvo8zTSrNypTJq53WbOPN6EOiLmYnkuAZJTGNjNBZftvZByYKHUG4
	W7v28N0T2tx/5YqdNoqSDIBovRo9xSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751264996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4a8monR3tF8KOIGOp3AbckiUTMIFvbQ7an8p9i9+Zs=;
	b=luRU9Bn8IXGPA2rgPefjUqeEkRRlTkBo8DkYqMIVOXJbPMKyFkCvE/t2ZvUHKguJiZUWG0
	lIpUEZ9B4M3BEZDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751264996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4a8monR3tF8KOIGOp3AbckiUTMIFvbQ7an8p9i9+Zs=;
	b=gnlWZzxRYsR9snuPxctWbr4YxmPgmEHuiFM7oI2VvnZYQ2NDI8leSkqPR+O/VNhaC43iTL
	uZLbXaHvhxJOAaAK/Hvo8zTSrNypTJq53WbOPN6EOiLmYnkuAZJTGNjNBZftvZByYKHUG4
	W7v28N0T2tx/5YqdNoqSDIBovRo9xSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751264996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4a8monR3tF8KOIGOp3AbckiUTMIFvbQ7an8p9i9+Zs=;
	b=luRU9Bn8IXGPA2rgPefjUqeEkRRlTkBo8DkYqMIVOXJbPMKyFkCvE/t2ZvUHKguJiZUWG0
	lIpUEZ9B4M3BEZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F14F213A6E;
	Mon, 30 Jun 2025 06:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FeVQOOMuYmj4VwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 30 Jun 2025 06:29:55 +0000
Date: Mon, 30 Jun 2025 08:29:55 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, 
	linux-scsi@vger.kernel.org, storagedev@microchip.com, virtualization@lists.linux.dev, 
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 0/5] blk: introduce block layer helpers to calculate num
 of queues
Message-ID: <38e19482-e07d-4130-88d2-fc0a4aa5ddc8@flourine.local>
References: <20250617-isolcpus-queue-counters-v1-0-13923686b54b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617-isolcpus-queue-counters-v1-0-13923686b54b@kernel.org>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250629_232959_394643_629E68EF 
X-CRM114-Status: GOOD (  17.55  )
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

Hi Jens,

On Tue, Jun 17, 2025 at 03:43:22PM +0200, Daniel Wagner wrote:
> I am still working on the change request for the "blk: honor isolcpus
> configuration" series [1]. Teaching group_cpus_evenly to use the
> housekeeping mask depending on the context is not a trivial change.
> 
> The first part of the series has already been reviewed and doesn't
> contain any controversial changes, so let's get them processed
> independely.
> 
> [1] https://patch.msgid.link/20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org

Would you mind to route this series via your tree? There are changes in
several different trees though all the patches have been acked/reviewed
by the corresponding maintainers. Would be great to get some weeks in
'next' so that this series gets some more testing.

Thanks a lot,
Daniel

