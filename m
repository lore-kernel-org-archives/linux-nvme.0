Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F292BCA1016
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Sep 2025 06:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=33zHN0Ci2nsYAA6yJPzugyK4uZYR8sPBN6+QhEOeME8=; b=kAEoUO/i2022A4yF2yxr54bKWb
	Sk5RsrzNBIL78H2vxw+k0WzTJ4pWmiQZsIPUZnpVn0Ll+w0psrXtNnjvitsooA4Fzz3lX/RrVRZMI
	hWEo0j7HKSiOEF29hN2GvJtfAoaxolKCYdtG+F/vmUNvo2xM17XiaHEVppeY2UJVce2HeN6hr4AEa
	6ve80AL+a3J0gXbUDI0WodVHL/y60mmEmyt7tC7MFGujO+7HJAMh9afiNUf7g4PDXPu8fHZbnTyav
	eW2n3XEP3RhF5eTICDYh+puiWery4I5Ffa5sFB0vkLZ2Fvgjun3JATExVrFp5kSVDl7ul7Bhy1or5
	EiJ8WekA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvV17-0000000Es9C-2i7r;
	Mon, 08 Sep 2025 06:06:17 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvV10-0000000Es6Q-1yt5
	for linux-nvme@lists.infradead.org;
	Mon, 08 Sep 2025 06:06:13 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF40F25D0F;
	Mon,  8 Sep 2025 06:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757311566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33zHN0Ci2nsYAA6yJPzugyK4uZYR8sPBN6+QhEOeME8=;
	b=VTTm5WU3gsVyWRU3QktGMLV/6wNuTlC1GvT11zmDJzV7/10JaU3gJN9oGS7GB8KBT+dpGE
	56mNP8wZI2ZadrUFtyNlxzQmk7l2dLItE2Rw6TbXEYpqj/cRVsGVdvDNaHgM3+i9d3MxpW
	m3VwxdFJbxGTRl1sWS0PSWYTWWZ1S0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757311566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33zHN0Ci2nsYAA6yJPzugyK4uZYR8sPBN6+QhEOeME8=;
	b=1apyA0jqX6EwDS5uRd6bE48pTBzQ3FGvNFkOm6J5aco914Br93cxhN9D1G1A+iNMb+SqK5
	U8h9sxulmcNDl5Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GZ2SbxOq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4HvCLfSc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757311565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33zHN0Ci2nsYAA6yJPzugyK4uZYR8sPBN6+QhEOeME8=;
	b=GZ2SbxOqRya+/f66Rdwoc0nc6Gz++0tmpkhcQZJK9vGquUwVgfq6ZpZQjsuPmU84U6B8/1
	RdX/7/vEtdd9n77a9ypbLiIgt+W7lZS4qRukvNrYHExqhaH6VP/pOtcQhLhU5YX7OlwWxa
	wC3uEpS4iTupAIB2cpAHXiuGSUIDUfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757311565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33zHN0Ci2nsYAA6yJPzugyK4uZYR8sPBN6+QhEOeME8=;
	b=4HvCLfScqdpJvmaTSMixKtHACubY9c8sezJNuwyHjtTwciLeYslu9lj3jGbPWpM82DGgsU
	o2hBkBriWApNJiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10C2013946;
	Mon,  8 Sep 2025 06:06:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3mn3AE1yvmhSLAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Sep 2025 06:06:05 +0000
Message-ID: <8f493741-5e39-4a09-ac3a-0bf22479e88f@suse.de>
Date: Mon, 8 Sep 2025 08:06:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/12] scsi: aacraid: use block layer helpers to
 calculate num of queues
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
 <20250905-isolcpus-io-queues-v8-1-885984c5daca@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250905-isolcpus-io-queues-v8-1-885984c5daca@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CF40F25D0F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
X-CRM114-CacheID: sfid-20250907_230610_668819_805E0915 
X-CRM114-Status: GOOD (  13.14  )
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
> The calculation of the upper limit for queues does not depend solely on
> the number of online CPUs; for example, the isolcpus kernel
> command-line option must also be considered.
> 
> To account for this, the block layer provides a helper function to
> retrieve the maximum number of queues. Use it to set an appropriate
> upper queue number limit.
> 
> Fixes: 94970cfb5f10 ("scsi: use block layer helpers to calculate num of queues")
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/scsi/aacraid/comminit.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

