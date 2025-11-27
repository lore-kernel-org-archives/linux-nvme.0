Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33DCD116F6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 18:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UXwOJqPQn7tI1KgWPuA2BrBC2jrBW1HxngC1Xi1a91I=; b=fvLWgDkQC8DdkxSGfrHKFLmGdL
	XYRmVZcH2lTNkuwe5yrLfRiCQHcOCZ6ivk7T589qa8N/GDzod27weW52Jj6b4Nd3suzlQ2aWTn+p4
	5QQ9gT+PrbbLO65TgDvhp+MEj9lw2VhWoNwk3BT0unOhfMSOXKynbbmLYJvT0ELbiHDa8EO0C8G8Y
	oP5JYOBtJllxpaV/FzW9f9BNQ/WYjqPwVnoqdcWzYRTsS3H25YbwKzjEupBGj2OwbvzSJppBOcb1R
	S638/tJ0mvhEAJT43gbVp/2p2E01jjXLOMap86b0S2OvPlw4uvZ87TxNtUlw7zYJBhT+ND9xCQCqP
	bMVxoN1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOgLX-0000000H2kn-3ecV;
	Thu, 27 Nov 2025 18:03:59 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOgLR-0000000H2kH-34Qz
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 18:03:54 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9A23336A4;
	Thu, 27 Nov 2025 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764266632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXwOJqPQn7tI1KgWPuA2BrBC2jrBW1HxngC1Xi1a91I=;
	b=mQi2lsqh49h6oESXXOAmMchwCcvTGOaqPhGefxY1VXOWHqV3ZOa7ZPoz++rgeEU8nweFqY
	Ohzo1aFNxFthLYyB/ZiisFZvL8Xetd9WG2IFscr9YA4qcszHc42Dh32b+Ru1VjK57dN3eb
	aHqu1uKKfrjhNVitLqbJf118D08xfYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764266632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXwOJqPQn7tI1KgWPuA2BrBC2jrBW1HxngC1Xi1a91I=;
	b=JImYMuvYdKON4oiSf/wJxQ6gUJ34OLb5icpD9AekipxqnZyMqM+Hld71rnwAToJJgzBxsz
	thk5AALAGdXLtcDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764266631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXwOJqPQn7tI1KgWPuA2BrBC2jrBW1HxngC1Xi1a91I=;
	b=ZJg3kSoCn20Hr4CNrS49ssji512WmJLHCX/RuUJWGL4JjpWqKqjoDDTZBYGSCNBz539QKY
	4dhcd5lhU3u5BAFGTAgBrdWYNWXliOqUvwZPLZEKHhxCs8Bjhje9+2lltHoKxNotjS6cMR
	NywImEGgiEv75/Er6HYPI0ZNvDrzKHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764266631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXwOJqPQn7tI1KgWPuA2BrBC2jrBW1HxngC1Xi1a91I=;
	b=fUi6AXHsPl8Gf5n9ra0dzrJz5N3bY89LF/LDJ5umaV3nbGJRPOVGSa9MnGQKnZ+vnGdlh8
	Ppl9VkI5IPTuXVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81C593EA63;
	Thu, 27 Nov 2025 18:03:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RH4QHoeSKGnhXgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Nov 2025 18:03:51 +0000
Message-ID: <4eb8b77a-6553-42ec-ab85-a1cddb7d8f23@suse.de>
Date: Thu, 27 Nov 2025 19:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] scsi: sd: reject invalid pr_read_keys() num_keys
 values
To: Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Christoph Hellwig <hch@lst.de>, Mike Christie <michael.christie@oracle.com>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
References: <20251127155424.617569-1-stefanha@redhat.com>
 <20251127155424.617569-2-stefanha@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251127155424.617569-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_100353_916343_BA1197AF 
X-CRM114-Status: GOOD (  10.97  )
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

On 11/27/25 16:54, Stefan Hajnoczi wrote:
> The pr_read_keys() interface has a u32 num_keys parameter. The SCSI
> PERSISTENT RESERVE IN command has a maximum READ KEYS service action
> size of 65536 bytes. Reject num_keys values that are too large to fit
> into the SCSI command.
> 
> This will become important when pr_read_keys() is exposed to untrusted
> userspace via an <linux/pr.h> ioctl.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   drivers/scsi/sd.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

