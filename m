Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCA4E7719E
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 07:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OYbX/qmEoqUt7H7blkrv+2RbE6JCseGRge7shAs2s9A=; b=DD0a9nM7Cadb73LsnOf0z7FISQ
	r8vqj1Gon5gX9OcUjeBv/gvJ9y6ROWaWhIvWbjmxUz5MzT5/ft8jBWy5UpENTTjMtrAipupuchYhl
	l/5aZ3491xLJFZ84D9eU+xHiiVvusHr6y7t/3K84IQK800lidSXS/wmXEorzor7BOxRZeKilX8MUH
	PI85kmH+DDZMr6xzSuypXvBFzFFRei8xyoSX5WikDnvxnGWZ8d0oMovdxmcoh/EyLhPWMky74yp6/
	zixAA79KA6dsVnNjlEsg3RYWjug1Cldl18eHjiGOPda9wNHVlTB9euYQovAG6FbjSphA39Q25vgAD
	ZphG5YWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXEbw-00000004Ckt-2Lky;
	Mon, 13 Jan 2025 07:11:44 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXEbt-00000004Cji-3gHM
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 07:11:43 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62F062115E;
	Mon, 13 Jan 2025 07:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736752300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYbX/qmEoqUt7H7blkrv+2RbE6JCseGRge7shAs2s9A=;
	b=1VBOYfQsALUTcnGDEQyYcsP2XCJXf+yXlpGaEsDDjpeK5ksbd4FQtKVc+sgLKsb5JbgLJN
	9ETQwaOmmfoVrqY2L1qef5XJbcEPzxm/vcwE8aTMrF+wEK4uXksPTLqgyuj1bhervvZl5E
	FPbZemL+ffy3KMlLU2lKJ+axnx8faBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736752300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYbX/qmEoqUt7H7blkrv+2RbE6JCseGRge7shAs2s9A=;
	b=qEDxEnIYZfkJQraGiKUoP3PsleF3nfYBa0QwBozC/OaNKx09i5yk6XEauuK7i+Es97mwgQ
	yrpj6bttToAqCuBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1VBOYfQs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qEDxEnIY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736752300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYbX/qmEoqUt7H7blkrv+2RbE6JCseGRge7shAs2s9A=;
	b=1VBOYfQsALUTcnGDEQyYcsP2XCJXf+yXlpGaEsDDjpeK5ksbd4FQtKVc+sgLKsb5JbgLJN
	9ETQwaOmmfoVrqY2L1qef5XJbcEPzxm/vcwE8aTMrF+wEK4uXksPTLqgyuj1bhervvZl5E
	FPbZemL+ffy3KMlLU2lKJ+axnx8faBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736752300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYbX/qmEoqUt7H7blkrv+2RbE6JCseGRge7shAs2s9A=;
	b=qEDxEnIYZfkJQraGiKUoP3PsleF3nfYBa0QwBozC/OaNKx09i5yk6XEauuK7i+Es97mwgQ
	yrpj6bttToAqCuBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4D7013876;
	Mon, 13 Jan 2025 07:11:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dBGqJqu8hGfFKgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jan 2025 07:11:39 +0000
Message-ID: <a7cd43e3-fac8-4917-8dc6-e2e8ba6cc797@suse.de>
Date: Mon, 13 Jan 2025 08:11:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] virtio: blk/scsi: use block layer helpers to
 calculate num of queues
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Costa Shulyupin
 <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>,
 Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 storagedev@microchip.com, virtualization@lists.linux.dev,
 GR-QLogic-Storage-Upstream@marvell.com
References: <20250110-isolcpus-io-queues-v5-0-0e4f118680b0@kernel.org>
 <20250110-isolcpus-io-queues-v5-5-0e4f118680b0@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250110-isolcpus-io-queues-v5-5-0e4f118680b0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 62F062115E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_231142_081698_65FF3398 
X-CRM114-Status: GOOD (  14.44  )
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

On 1/10/25 17:26, Daniel Wagner wrote:
> Multiqueue devices should only allocate queues for the housekeeping CPUs
> when isolcpus=managed_irq is set. This avoids that the isolated CPUs get
> disturbed with OS workload.
> 
> Use helpers which calculates the correct number of queues which should
> be used when isolcpus is used.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/block/virtio_blk.c | 5 ++---
>   drivers/scsi/virtio_scsi.c | 1 +
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

