Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2C9C83F09
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 06:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+mXypbc+hm1gV4LXs6vEAVEpiNAdYcGIxeg4GCc0Wqs=; b=cttIfUxo8qYPrpdFcNxYq0iXGI
	Reoyibda7mD9h/4eY9KVkbzJg/sUqbde24BnHus0CuoAfijFy1rbBfKg76zwviSPkKsnbFLEO8bAo
	wK83Y7p2kfrYx67c3h54K91M8JCIicmEYJ8Sf/jfNdEcSeRYm6o9pqcu90AQqNG8xPITIpxzx7CYa
	mh4SJBJe9rvXdFa0LGvJzJVolCYRpbY9W47BDxMzDhBzi4tRZUVNke614uURH4p8gXSiu/H3LIpnu
	TGER+4AAldo4fk0syCxi4CVhgpduUZoY14mJc0SPT0CKKQTWZvNX2bfGge+84Um4qz2v1ja0yMf9p
	45BX/z9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXDo6-0000000AQoP-1b70;
	Thu, 03 Jul 2025 06:52:30 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXDez-0000000APM7-1gnZ
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 06:43:06 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D5DA1F458;
	Thu,  3 Jul 2025 06:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751524983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mXypbc+hm1gV4LXs6vEAVEpiNAdYcGIxeg4GCc0Wqs=;
	b=a9opwIbrihxmR1SRxS2ypfYhACES5CDboCEjIDD8gSFXLbjlYz3JrdIuh84mNUJx8aPTsB
	/fkMs5SpnbgJJJ/ygtm70fgqDEy5Gcl75uH5LweP7dpce4TdYBNMnRAVsAcj63Yyrmev9N
	lc5cCpNHLIe5xzlxLk6sMxd29CtHbx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751524983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mXypbc+hm1gV4LXs6vEAVEpiNAdYcGIxeg4GCc0Wqs=;
	b=SGWpyY+47OtdjPpHpdbDaOUUkEru82/GZF80wYI+h5TGKuHf0K8DMaQJknQDIhSbQ/CM5r
	v14i8dKmx2XqIiDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=a9opwIbr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SGWpyY+4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751524983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mXypbc+hm1gV4LXs6vEAVEpiNAdYcGIxeg4GCc0Wqs=;
	b=a9opwIbrihxmR1SRxS2ypfYhACES5CDboCEjIDD8gSFXLbjlYz3JrdIuh84mNUJx8aPTsB
	/fkMs5SpnbgJJJ/ygtm70fgqDEy5Gcl75uH5LweP7dpce4TdYBNMnRAVsAcj63Yyrmev9N
	lc5cCpNHLIe5xzlxLk6sMxd29CtHbx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751524983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mXypbc+hm1gV4LXs6vEAVEpiNAdYcGIxeg4GCc0Wqs=;
	b=SGWpyY+47OtdjPpHpdbDaOUUkEru82/GZF80wYI+h5TGKuHf0K8DMaQJknQDIhSbQ/CM5r
	v14i8dKmx2XqIiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96AB91368E;
	Thu,  3 Jul 2025 06:43:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h1rXInUmZmj3TAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 03 Jul 2025 06:43:01 +0000
Message-ID: <d95de280-8cd7-4697-933a-37dc53f4c552@suse.de>
Date: Thu, 3 Jul 2025 08:43:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/10] scsi: Use block layer helpers to constrain queue
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
References: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org>
 <20250702-isolcpus-io-queues-v7-5-557aa7eacce4@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250702-isolcpus-io-queues-v7-5-557aa7eacce4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 8D5DA1F458
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_234305_587660_1E444782 
X-CRM114-Status: GOOD (  13.64  )
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

On 7/2/25 18:33, Daniel Wagner wrote:
> Ensure that IRQ affinity setup also respects the queue-to-CPU mapping
> constraints provided by the block layer. This allows the SCSI drivers
> to avoid assigning interrupts to CPUs that the block layer has excluded
> (e.g., isolated CPUs).
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/scsi/fnic/fnic_isr.c              | 7 +++++--
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    | 1 +
>   drivers/scsi/megaraid/megaraid_sas_base.c | 5 ++++-
>   drivers/scsi/mpi3mr/mpi3mr_fw.c           | 6 +++++-
>   drivers/scsi/mpt3sas/mpt3sas_base.c       | 5 ++++-
>   drivers/scsi/pm8001/pm8001_init.c         | 1 +
>   drivers/scsi/qla2xxx/qla_isr.c            | 1 +
>   drivers/scsi/smartpqi/smartpqi_init.c     | 7 +++++--
>   8 files changed, 26 insertions(+), 7 deletions(-)
 >

All of these drivers are not aware of CPU hotplug, and as such
will not be notified when the number of CPUs changes.
But you use 'blk_mq_online_queue_affinity()' for all of these
drivers.
Wouldn't 'blk_mq_possible_queue_affinit()' a better choice here
to insulate against CPU hotplug effects?

Also some drivers which are using irq affinity (eg aacraid, lpfc) are
missing from these conversions. Why?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

