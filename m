Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD34E7719E
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 07:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ulSOiBud7NT55dZGFodvslB3QoYPMq3us4a4P0xo/9w=; b=xEfNGBNquZ2tKJzYjFQ09E9xpk
	i5yq0NvMVMMcPntCAuaNNv9HCKQ1pEwqrDyZule0juYRLZOTM0mSk0FyQidRS5wOdW7EyjQ/Dklb9
	LdQDcFrwMRMm7LpKsfVXpjirOATddrO3O1Z13u19W5iCMNorpSksuspvRHILx5g42B3PNhZwlAu2K
	tEig8mC1+ky6zSWKGyAhSWzla41nAZNIcDnSEJPgAFVJHXNTShPBPFwvEfH7DUc0EVax4D7xhPXSy
	OQvKvtKtkVdfx7LC2WjbtosSsDYns8QAY75xu4szNHAAB3nlcXktG8JwVldO7Dl8aWbb/k/HodIab
	YQNfmlNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXEf3-00000004DfI-1gl2;
	Mon, 13 Jan 2025 07:14:57 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXEf1-00000004DeU-0WnU
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 07:14:56 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CAA4B1F37C;
	Mon, 13 Jan 2025 07:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736752493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulSOiBud7NT55dZGFodvslB3QoYPMq3us4a4P0xo/9w=;
	b=YNjI3iRuZGnkcJRRaMBS9ZxtpB2ALnq1LeZFTiHzBrCfEXPD4Zh1KETt9CjYqDDiBrnA0g
	T+5WG/S1U9x8ErgV1suJsAzcaFAHHlP82XorW4DVGBYX7P9LViUQDNleo+CkClW7WFlTWq
	O5glpKn+WW9y9W0ofO9zz8hy7C0x7vM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736752493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulSOiBud7NT55dZGFodvslB3QoYPMq3us4a4P0xo/9w=;
	b=5jlek5/O7OhTnwC5/nUCb1Xs3Hm7G+mNUKkmVbx8QlbVwuZJq3Tvj0JHWKvDvtIgGYS5Pz
	u/eVQOvJfy8+1iCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736752493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulSOiBud7NT55dZGFodvslB3QoYPMq3us4a4P0xo/9w=;
	b=YNjI3iRuZGnkcJRRaMBS9ZxtpB2ALnq1LeZFTiHzBrCfEXPD4Zh1KETt9CjYqDDiBrnA0g
	T+5WG/S1U9x8ErgV1suJsAzcaFAHHlP82XorW4DVGBYX7P9LViUQDNleo+CkClW7WFlTWq
	O5glpKn+WW9y9W0ofO9zz8hy7C0x7vM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736752493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulSOiBud7NT55dZGFodvslB3QoYPMq3us4a4P0xo/9w=;
	b=5jlek5/O7OhTnwC5/nUCb1Xs3Hm7G+mNUKkmVbx8QlbVwuZJq3Tvj0JHWKvDvtIgGYS5Pz
	u/eVQOvJfy8+1iCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16DDB13310;
	Mon, 13 Jan 2025 07:14:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vwHxA229hGd3KwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jan 2025 07:14:53 +0000
Message-ID: <d75ccb2a-17b7-46f1-b370-c97896878b23@suse.de>
Date: Mon, 13 Jan 2025 08:14:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] doc: update managed_irq documentation
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
 <20250110-isolcpus-io-queues-v5-9-0e4f118680b0@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250110-isolcpus-io-queues-v5-9-0e4f118680b0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLtwh1cu5tij3fa8finjukruks)];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_231455_308997_50CCA515 
X-CRM114-Status: GOOD (  12.49  )
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
> The managed_irq documentation is a bit difficult to understand. Rephrase
> the current text and add the latest changes how managed_irq CPU sets are
> handled.
> 
> Isolated CPUs and housekeeping CPUs are grouped into sets and the
> possibility of stalls if all housekeeping CPUs are offlined in a set.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 46 +++++++++++++------------
>   1 file changed, 24 insertions(+), 22 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

