Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F514E7719E
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 07:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ADtA9uZm1LVPpmdIJhQwcmDJ4C+ndrkV3SUBTvBLTww=; b=DzAFUF2StFpHCgSXBqL9UofwLw
	Xfo80V1fgp23a6Z5TmewdXG/cIcErHMhrvY6nn4KIBTfY01qXSahmW5Rju1wWCcvJksOZobz0bmHR
	z8cvSSNcCK3alJayI3j282DEN04Zd4xYtzv92o0W1GNE9b4asXs0mbfKRcHALFGx17y1ponN1DB8W
	VB7omcTlVciEfgTQbK+pMWp4ZXgSjKowznt2XhHzna6Z2N1slMYL/ATpl307V2xkZlzRiuTKV4W3V
	t0H1aDrYgNGvHHflaXkKZ5A9MG3vtcBiBQ1DOIgDx9rodIBGtJd3yNQysAYl5quzW1cJnB9AA9rPl
	4HKP+dog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXEb2-00000004CaE-2FvN;
	Mon, 13 Jan 2025 07:10:48 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXEb0-00000004CZq-2YeL
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 07:10:47 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE3151F365;
	Mon, 13 Jan 2025 07:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736752244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADtA9uZm1LVPpmdIJhQwcmDJ4C+ndrkV3SUBTvBLTww=;
	b=V6bHI8M+cWkkYDaQqFwCBgAVhNR+3W3TJrNYZ5pfp6wMALLYtI62MEs/7sInGtd89rXpJR
	EOALsWi6ip070qp4MxHVhrM5WHcqI8YUe0KNJv0f7vlmiXMjb0WNo7fYeXtm/HanIew+Dk
	TcISJQHrWyZjiAN4Lu2Fc/mEQOcZO6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736752244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADtA9uZm1LVPpmdIJhQwcmDJ4C+ndrkV3SUBTvBLTww=;
	b=a3V0UARbBOswwoSugDe+yFWydZ/49MU6blmqnHSVkdMdzOdk2Do8SrwaTWw3I/aAYVjPCJ
	pn0X7IQ6pkk+4FDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=V6bHI8M+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a3V0UARb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736752244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADtA9uZm1LVPpmdIJhQwcmDJ4C+ndrkV3SUBTvBLTww=;
	b=V6bHI8M+cWkkYDaQqFwCBgAVhNR+3W3TJrNYZ5pfp6wMALLYtI62MEs/7sInGtd89rXpJR
	EOALsWi6ip070qp4MxHVhrM5WHcqI8YUe0KNJv0f7vlmiXMjb0WNo7fYeXtm/HanIew+Dk
	TcISJQHrWyZjiAN4Lu2Fc/mEQOcZO6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736752244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADtA9uZm1LVPpmdIJhQwcmDJ4C+ndrkV3SUBTvBLTww=;
	b=a3V0UARbBOswwoSugDe+yFWydZ/49MU6blmqnHSVkdMdzOdk2Do8SrwaTWw3I/aAYVjPCJ
	pn0X7IQ6pkk+4FDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D345F13876;
	Mon, 13 Jan 2025 07:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aJljMXO8hGeTKgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jan 2025 07:10:43 +0000
Message-ID: <c7e13336-d9d3-4d36-84af-922d17a3999d@suse.de>
Date: Mon, 13 Jan 2025 08:10:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] scsi: use block layer helpers to calculate num of
 queues
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
 <20250110-isolcpus-io-queues-v5-4-0e4f118680b0@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250110-isolcpus-io-queues-v5-4-0e4f118680b0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AE3151F365
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_231046_800407_28AEA6DA 
X-CRM114-Status: GOOD (  13.19  )
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
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/scsi/megaraid/megaraid_sas_base.c | 15 +++++++++------
>   drivers/scsi/qla2xxx/qla_isr.c            | 10 +++++-----
>   drivers/scsi/smartpqi/smartpqi_init.c     |  5 ++---
>   3 files changed, 16 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

