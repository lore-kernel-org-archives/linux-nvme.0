Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FD4C3064D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 07:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WFHHEkv8N9Bai32nGXrq7y2Iy0SVdznCs033vBYYBMo=; b=Ego7al6hW+GxanyEe6aFHS/7E8
	eDWzhZpzS0qOpj88qtNDrletX6hhWo+ljSpSJLT4zUriTDb22KJ0Ja3N7mpem1WY52UQrhhBx1h1l
	ncY15BKlv/pxaNJT5Bod64NpipYjVyjDdnZZZ8wMzgpxhf11EFS6a1P0jT100VHLtZLTHzw8SGfTy
	QEnPQLT17yRqV7xi+/t88IwxnloNBlQnUzX69Ak4onY20SwDTb+qRdrtieDj4f0kT8DzOVGdK3wgj
	iHkAZ4pzg4LnYytzsPpDKlC6eQSnpNT9grnuIJT1u4BTB98l026+wixQA15xlr6MKOnR9dizZrBJd
	6Sj3Bd/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOXtv-00000005rAI-2Tmb;
	Tue, 02 Jul 2024 07:26:07 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOXts-00000005r9a-1WOI
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 07:26:05 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D15F2128C;
	Tue,  2 Jul 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 394121395F;
	Tue,  2 Jul 2024 07:26:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WZlBDYmrg2bJBAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 02 Jul 2024 07:26:01 +0000
Date: Tue, 2 Jul 2024 09:25:52 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>, 
	Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>, 
	Sridhar Balaraman <sbalaraman@parallelwireless.com>, "brookxu.cn" <brookxu.cn@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
Message-ID: <irhdgxgnyz76ss7p74dnriix6llnxquowvzh3dxb7mgwd54zd7@euhdihb5spgw>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
 <ZoIPzQNEsUWOWp3f@fedora>
 <1a1a4684-a55d-4c27-8509-9bf61408872f@suse.de>
 <ZoJWXRgycA8UeYB3@fedora>
 <c797bdc1-b949-4d88-a65f-904d909755dc@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c797bdc1-b949-4d88-a65f-904d909755dc@suse.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: 4D15F2128C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_002604_569501_7C4B084E 
X-CRM114-Status: GOOD (  10.02  )
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

On Mon, Jul 01, 2024 at 10:37:46AM GMT, Hannes Reinecke wrote:
> Hmm. Guess we need to modify the grouping algorithm to group across all
> cpus, but ensure that each group consists either of all housekeeping CPUs or
> all isolated cpus.

This is what this series does, though just for the housekeeping CPUs. v1
introduces the io_queue option for isolcpus which made sure the
managed_irq behavior doesn't change.

