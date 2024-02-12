Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E066C4829B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 07:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ly0/N2sI7GYimJbc3FVYkHBtFPCLaO0szMJ/EiRVc4E=; b=JCHfbTNF8fMxXScedxnd58t3Z7
	v20fRAljOusIn4wVuUpRY43YDEpEyYSBrpDKbchbapz7OlrkHUP7fLKfT5J+ZFGg+Mo37UgG1NGTb
	7HKAOIeKAewkrGimJtSxWw3EHxnMzMgf19VoJVY5rt5bCJzXOKboDeeLuGFWxeQ5mtWon9aNLl6nw
	3ET3jEOLAbxFVZaQ0H9msZih/EYeLwLdr6RAdr7ku/+MeFyw9LtS2q2wX9Ecx9bsI9+H7twJ2bMZR
	HPwwHlAyyv4qxSYDEmSLEMWnPIHedp76YJfOEZ41QJqbemeIRLdpZx4ELosIbHyF0CJ/sa3rS6fsW
	2e4zxMIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQhP-00000004VDU-2lpI;
	Mon, 12 Feb 2024 07:25:55 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQhL-00000004VBc-2daL
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 07:25:54 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B21A21BA6;
	Mon, 12 Feb 2024 07:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707722748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly0/N2sI7GYimJbc3FVYkHBtFPCLaO0szMJ/EiRVc4E=;
	b=b4jzCwwXJT7hBC5MnVWhX7Q/yv4WESf8k92tWy5MK+2G8qQfKkVuFWuKVJHBvOTm5RVupE
	eN6kHqoT3thDYHROCCjg9fl6mRyeUVdXLwVwg+JJtVf3fD8rhMq9XtklyD8ESoYS1YAyR4
	J7K3A+dF2vf7c/Ep2LifS1EJ2Gg6XTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707722748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly0/N2sI7GYimJbc3FVYkHBtFPCLaO0szMJ/EiRVc4E=;
	b=QZbhrGaJmZwOkg+Kq+2T+4BfrYyA6JWEjFlVT+3K3ooBZTnk+WeML5m0b0e0nK/a8M2awi
	ONI+7IyCasnu0bAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707722748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly0/N2sI7GYimJbc3FVYkHBtFPCLaO0szMJ/EiRVc4E=;
	b=b4jzCwwXJT7hBC5MnVWhX7Q/yv4WESf8k92tWy5MK+2G8qQfKkVuFWuKVJHBvOTm5RVupE
	eN6kHqoT3thDYHROCCjg9fl6mRyeUVdXLwVwg+JJtVf3fD8rhMq9XtklyD8ESoYS1YAyR4
	J7K3A+dF2vf7c/Ep2LifS1EJ2Gg6XTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707722748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly0/N2sI7GYimJbc3FVYkHBtFPCLaO0szMJ/EiRVc4E=;
	b=QZbhrGaJmZwOkg+Kq+2T+4BfrYyA6JWEjFlVT+3K3ooBZTnk+WeML5m0b0e0nK/a8M2awi
	ONI+7IyCasnu0bAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D67313985;
	Mon, 12 Feb 2024 07:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bM/9DvvHyWVxYgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Feb 2024 07:25:47 +0000
Message-ID: <57d64483-6567-479f-b063-399bed1efb72@suse.de>
Date: Mon, 12 Feb 2024 08:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] block: decouple blk_set_stacking_limits from
 blk_set_default_limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240212064609.1327143-1-hch@lst.de>
 <20240212064609.1327143-4-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240212064609.1327143-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.33 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.24)[72.91%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,lst.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_232551_840366_E156FEE1 
X-CRM114-Status: GOOD (  10.52  )
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

On 2/12/24 14:45, Christoph Hellwig wrote:
> blk_set_stacking_limits uses very little from blk_set_default_limits.
> Open code these initializations in preparation for rewriting
> blk_set_default_limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-settings.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


