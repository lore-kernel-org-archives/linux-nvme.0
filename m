Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407C9CA1016
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Sep 2025 06:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ZrCZ037WW08oyA93gYDOgV1aEokOz6L4cBK1pOr+zY=; b=hjVi2saSpSQZSTd5esruxquS9l
	Csm3RNvpb9OijIK6fZjLCofuVhyqmtU5vVJAkByail615aHKO5gp+7JU4mBhcoAMBVDu+E6M7b1mh
	zBwDGflYFU7NAlAPlHU7cF4J99ew+xs32K7SLSlaN4NaDr5qk1gQzEMXevOlBtFZ+lb2svIJovKRP
	0UvKHCtnzmxN+3/Udwy63cdn4E6Xyl74cTcVQDhutB3gNrTuNMgl8EmMPbeZNKGg/YAms5NwZwGiO
	1YDy1EnEjuL2R6APzIOLBNLY2rt+CA7AxdO3aLRiIEqU4PW9s01yTuKYH1003fiAIXYMMlvNfBeqa
	ZrU51F9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvV3v-0000000EtGS-2u2q;
	Mon, 08 Sep 2025 06:09:11 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvV39-0000000Esy7-2Jou
	for linux-nvme@lists.infradead.org;
	Mon, 08 Sep 2025 06:08:24 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8D4E2433F;
	Mon,  8 Sep 2025 06:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757311702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZrCZ037WW08oyA93gYDOgV1aEokOz6L4cBK1pOr+zY=;
	b=uNiUJQrDmvzZ/IgGMlVfdrA9ec7H72CiMeUJyvCJMd79vyJklKQ+8ulnQTuu3o7c0p90mq
	sNfbAUpI04XI/LsqtkZl+Xju/gZJYQN7MotNVfYblwmX3lxXWoSrMto4OZcl8P6Sdr5r22
	4QIo50eMsbTnfUg/+X29mQWWPv8xXbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757311702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZrCZ037WW08oyA93gYDOgV1aEokOz6L4cBK1pOr+zY=;
	b=RfTP7bcB/OpQVoB5IIGSDmJt0C+s5wxHInpzWE8Bj24WzOKCZpiOfSCm0oIp3+34U4gPir
	NGerp9oPknT1PKCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UGgG6xj2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zGv5b2xe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757311701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZrCZ037WW08oyA93gYDOgV1aEokOz6L4cBK1pOr+zY=;
	b=UGgG6xj20lMDgZalO55jxR5GTsFg60QOoePunodFrvBDz+moFd6ceBtaFJ0QQYw+IW+IcB
	IdQZfKyasfzRP2oAlcDSW70skg2Y6+94QAPI/9KoPLDM/VeyijuGWYhWw3AuxLT10riP7Y
	Dg4kuDngjKtSUZ12Ek2HO00yc8ayzuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757311701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZrCZ037WW08oyA93gYDOgV1aEokOz6L4cBK1pOr+zY=;
	b=zGv5b2xeQV6T0SS7gQqixOYzzhRB9McyWQoP9IrmTR8wxhGcMo/mz+aaXqxAIZQrjs6aCY
	XkV2woJOVIha7TCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FBD413946;
	Mon,  8 Sep 2025 06:08:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LzsgBtVyvmjfLAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Sep 2025 06:08:21 +0000
Message-ID: <4d3b2fed-e42c-46f0-82d2-93eca2940759@suse.de>
Date: Mon, 8 Sep 2025 08:08:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/12] scsi: Use block layer helpers to constrain queue
 affinity
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Costa Shulyupin
 <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>,
 Mel Gorman <mgorman@suse.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
 linux-scsi@vger.kernel.org, storagedev@microchip.com,
 virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com
References: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
 <20250905-isolcpus-io-queues-v8-7-885984c5daca@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250905-isolcpus-io-queues-v8-7-885984c5daca@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D8D4E2433F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250907_230823_739278_76288E63 
X-CRM114-Status: GOOD (  15.76  )
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

On 9/5/25 16:59, Daniel Wagner wrote:
> Ensure that IRQ affinity setup also respects the queue-to-CPU mapping
> constraints provided by the block layer. This allows the SCSI drivers
> to avoid assigning interrupts to CPUs that the block layer has excluded
> (e.g., isolated CPUs).
> 
> Only convert drivers which are already using the
> pci_alloc_irq_vectors_affinity with the PCI_IRQ_AFFINITY flag set.
> Because these drivers are enabled to let the IRQ core code to
> set the affinity. Also don't update qla2xxx because the nvme-fabrics
> code is not ready yet.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    | 1 +
>   drivers/scsi/megaraid/megaraid_sas_base.c | 5 ++++-
>   drivers/scsi/mpi3mr/mpi3mr_fw.c           | 6 +++++-
>   drivers/scsi/mpt3sas/mpt3sas_base.c       | 5 ++++-
>   drivers/scsi/pm8001/pm8001_init.c         | 1 +
>   5 files changed, 15 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

