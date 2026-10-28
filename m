Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CA4606A338
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Eil0kOuZ;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GoY9PkXM;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bEZnjkBA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GoY9PkXM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bEZnjkBA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Gho3PZEf8WuLrYaivI8Wt6MNCsUe7MyQ3jBoEaUo3Nw=; b=Eil0kOuZHu/POh
	re/to0YgZ8/a0TNN49+UtChEJSvLjtz7BEOiVfgDcnP83qAsxMVK9A63GKmqs0TrnDquAkgVrDTjQ
	moxuw8Lw50pDQb1zLq9NCZ4T/xxYaQw3OS5nrQ4921NwgP49frlCXd1kJ0rI20GpP41wwOEnF7u8D
	0VImjcKjq+Ly4onJbSqbiBUoqr25tua2anjl8SyoquJFZb0U398/5xjSwCgR8D7n7ZOXfx3qQt9a8
	jdJ6sbieVV6zSmcCLrpOMhZvKjTK/+R/WJEXEVl32x0GHGZzXKtdfESYTPVjHph5gmvODNT+tZDrP
	62sWAiYuFEKa0QzeQkSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLyJq-00000006Tzq-4AVN;
	Wed, 28 Oct 2026 07:43:34 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLyJo-00000006TzJ-2hjf
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 07:43:33 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5D832205D;
	Wed, 28 Oct 2026 07:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793173410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gho3PZEf8WuLrYaivI8Wt6MNCsUe7MyQ3jBoEaUo3Nw=;
	b=GoY9PkXMWmm7iG2gxsBFzkVhvaZ3tNFzKTyp5igM9fJj4eyJDRqAwFZ6r+XGjkqWAaBBpd
	X+kQRGVesQl4u9nnSveak0AYKLpkI1ztK58vNhkbQLpVSgUWFeAfLCv5R+lGC8h/QMgd+2
	8tSMMWwEUGjTNAaS7l9DVEE33VLvzFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793173410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gho3PZEf8WuLrYaivI8Wt6MNCsUe7MyQ3jBoEaUo3Nw=;
	b=bEZnjkBALyyAkNHaU+ryew4YODUR6LhHvRzeywQRUbvVicjJnE2GAR6UhLDw/hGRwU8T16
	A0FGaSPGX+nax5DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793173410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gho3PZEf8WuLrYaivI8Wt6MNCsUe7MyQ3jBoEaUo3Nw=;
	b=GoY9PkXMWmm7iG2gxsBFzkVhvaZ3tNFzKTyp5igM9fJj4eyJDRqAwFZ6r+XGjkqWAaBBpd
	X+kQRGVesQl4u9nnSveak0AYKLpkI1ztK58vNhkbQLpVSgUWFeAfLCv5R+lGC8h/QMgd+2
	8tSMMWwEUGjTNAaS7l9DVEE33VLvzFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793173410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gho3PZEf8WuLrYaivI8Wt6MNCsUe7MyQ3jBoEaUo3Nw=;
	b=bEZnjkBALyyAkNHaU+ryew4YODUR6LhHvRzeywQRUbvVicjJnE2GAR6UhLDw/hGRwU8T16
	A0FGaSPGX+nax5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 570591321C;
	Wed, 28 Oct 2026 07:43:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V51MBqKn4WriTwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 28 Oct 2026 07:43:30 +0000
Message-ID: <9882b058-20a5-42cc-97b5-b0dcfc0360b7@suse.de>
Date: Wed, 28 Oct 2026 08:43:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: Finish the blk plug when integrity allocation
 fails
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261028064436.550665-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028064436.550665-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,alibaba.com:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_004332_832894_EBB28985 
X-CRM114-Status: GOOD (  17.13  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 7:44 AM, Guixin Liu wrote:
> nvmet_bdev_execute_rw() starts a plug before building the bios, but
> the two error exits taken when nvmet_bdev_alloc_bip() fails return
> without calling blk_finish_plug().  current->plug is left pointing
> at the stack frame of the returned function, so the next
> blk_flush_plug() walks a stale list.
> 
> Route both failures through a common exit that finishes the plug.
> 
> Fixes: c6e3f13398123 ("nvmet: add metadata support for block devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/target/io-cmd-bdev.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index f2d9e8901df4e..4b7483bc9cc31 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -316,7 +316,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>   							  &prot_miter);
>   				if (unlikely(rc)) {
>   					bio_io_error(bio);
> -					return;
> +					goto out_plug;
>   				}
>   			}
>   
> @@ -336,11 +336,12 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>   		rc = nvmet_bdev_alloc_bip(req, bio, &prot_miter);
>   		if (unlikely(rc)) {
>   			bio_io_error(bio);
> -			return;
> +			goto out_plug;
>   		}
>   	}
>   
>   	submit_bio(bio);
> +out_plug:
>   	blk_finish_plug(&plug);
>   }
>   
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

