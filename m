Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C0EC369D1
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 07:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MdCxCQOQ5rwrQiQPAO7hSu0uk85UoPlmtq7mewBu/Ns=; b=XouwsI0VfGiQi0k8QF55FtpYbI
	BuDoewCRXzzbaj22Tm7uZbiwVBEMBWLSmfOqRB/s+BE02gmVDSb0aGoEWNspEMmwPheqZ8XnFE+Oh
	TghiWne+UnoC7glFqidOfiQrjBEgOrEy7g2DDLu07WFA/aorfwBPT5t1r2yfASSsTTAPgNE30xE1w
	GOIPCugew4Z7LtOf7QYeSknahdkLdgcnMHgKuvyPHVP2pfKMWhm4dxfI5rsYF9T7HYgmg5Efr1/Ps
	B6okHqB8WMQE++PaIFK2xMizbeI1vk1AZNd7g3akIjtvXxnMhhwdjWT1XQtmpm2JzP+tQvU+889o5
	Kg681rnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8DXy-0000000GCIw-0cVY;
	Fri, 25 Apr 2025 07:32:30 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8DXv-0000000GCI6-28AE
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 07:32:28 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC7D8210F9;
	Fri, 25 Apr 2025 07:32:25 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A597113A79;
	Fri, 25 Apr 2025 07:32:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i4FpKIk6C2iYbwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Apr 2025 07:32:25 +0000
Date: Fri, 25 Apr 2025 09:32:16 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Costa Shulyupin <costa.shul@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	storagedev@microchip.com, virtualization@lists.linux.dev, 
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v6 6/9] isolation: introduce io_queue isolcpus type
Message-ID: <dd4719dc-5ac4-44d9-bccb-e867d322864e@flourine.local>
References: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
 <20250424-isolcpus-io-queues-v6-6-9a53a870ca1f@kernel.org>
 <2db989db-4849-46a9-9bad-0b67d85d1650@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db989db-4849-46a9-9bad-0b67d85d1650@suse.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: CC7D8210F9
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_003227_687613_2EB0BA2A 
X-CRM114-Status: GOOD (  19.32  )
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

On Fri, Apr 25, 2025 at 08:26:22AM +0200, Hannes Reinecke wrote:
> On 4/24/25 20:19, Daniel Wagner wrote:
> > Multiqueue drivers spreading IO queues on all CPUs for optimal
> > performance. The drivers are not aware of the CPU isolated requirement
> > and will spread all queues ignoring the isolcpus configuration.
> > 
> > Introduce a new isolcpus mask which allows the user to define on which
> > CPUs IO queues should be placed. This is similar to the managed_irq but
> > for drivers which do not use the managed IRQ infrastructure.
> > 
> > Signed-off-by: Daniel Wagner <wagi@kernel.org>
> > ---
> >   include/linux/sched/isolation.h | 1 +
> >   kernel/sched/isolation.c        | 7 +++++++
> >   2 files changed, 8 insertions(+)
> > 
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Just realized I forgot to also add some document on this new argument:

			io_queue
			  Isolate from IO queue work caused by multiqueue
			  device drivers. Restrict the placement of
			  queues to housekeeping CPUs only, ensuring that
			  all IO work is processed by a housekeeping CPU.

			  Note: When an isolated CPU issues an IO, it is
			  forwarded to a housekeeping CPU. This will
			  trigger a software interrupt on the completion
			  path.

			  Note: It is not possible to offline housekeeping
			  CPUs that serve isolated CPUs.

