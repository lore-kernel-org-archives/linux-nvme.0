Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15D7C44501
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 09:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y9gcUkxCkRN2ZaCCFrl4N86ehymkTSYCDoMlEuWqjAE=; b=bD5MkOT0zccc8RLYo2/GLWtMqY
	xft7NEs5b5aXXRisySJPSQBGtx/0sq0Z04ivdHqmReKTdkVbsTF3HuMYiuwIdUjrUPXK+LJf3OMtv
	3g+KJpa4zPa9OOhgdRX8+PFI6FV6EeYOKjDnpFQkfnaW9fiSNWvg9WI/h85uWZlcIRWvq7IZrta7O
	ClHi+YMsC3URWqFKS7uhC4Okezq0byINrp+HxkwlfaCJLl1xj+MVUrGVCGdX2eT9DUGvxqO30Gn24
	IT+Pev/KO+XXVhzje7gX0KHj6jYnm3AkgEVjIZVfX6d9GYd7uNCbx90W0meyX36uobuglc/m+ttan
	iFExkGKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjCyt-00000008jf3-0NFe;
	Mon, 13 Jul 2026 09:29:43 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjCyn-00000008jYB-49i0
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 09:29:39 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0975177653;
	Mon, 13 Jul 2026 09:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783934976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9gcUkxCkRN2ZaCCFrl4N86ehymkTSYCDoMlEuWqjAE=;
	b=wmWjcdrQtwWtJIeyLq2t5fcwg5iX2uJajA/r/0RMTrEjlLscL3f4QsEFByBg3/2ReeQJYt
	FdU4qmXkDN98inPHlgV1owGzGkEbXZkw2ln0WTBPPuMj5ziyiqJjnljKAyYfNY4CuX1n1a
	jLomKU0J4eYnu+ZCUTEfDTO75sA1oTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783934976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9gcUkxCkRN2ZaCCFrl4N86ehymkTSYCDoMlEuWqjAE=;
	b=+Z8PIDeglO+Dj12Ww+r+s63GWL/dREZ5YhTFEjHue5szurCi8eQEz8zyOim1Z/6XbntnUP
	y+EzIprM/3lPc5BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783934976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9gcUkxCkRN2ZaCCFrl4N86ehymkTSYCDoMlEuWqjAE=;
	b=wmWjcdrQtwWtJIeyLq2t5fcwg5iX2uJajA/r/0RMTrEjlLscL3f4QsEFByBg3/2ReeQJYt
	FdU4qmXkDN98inPHlgV1owGzGkEbXZkw2ln0WTBPPuMj5ziyiqJjnljKAyYfNY4CuX1n1a
	jLomKU0J4eYnu+ZCUTEfDTO75sA1oTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783934976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9gcUkxCkRN2ZaCCFrl4N86ehymkTSYCDoMlEuWqjAE=;
	b=+Z8PIDeglO+Dj12Ww+r+s63GWL/dREZ5YhTFEjHue5szurCi8eQEz8zyOim1Z/6XbntnUP
	y+EzIprM/3lPc5BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7312779AE;
	Mon, 13 Jul 2026 09:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U0pALP+vVGpCdwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jul 2026 09:29:35 +0000
Message-ID: <0ded62a6-b3da-4790-adf0-566ded30ee43@suse.de>
Date: Mon, 13 Jul 2026 11:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 01/17] nvme-multipath: retarget failedover bios
 from requeue work
To: Yu Kuai <yukuai@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alasdair Kergon <agk@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Zheng Gu <cengku@gmail.com>,
 Coly Li <colyli@fygo.io>, Kent Overstreet <kent.overstreet@linux.dev>,
 Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai@fygo.io>,
 Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-nvme@lists.infradead.org,
 dm-devel@lists.linux.dev, linux-bcache@vger.kernel.org
References: <20260704195124.1375075-1-yukuai@kernel.org>
 <20260704195124.1375075-2-yukuai@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260704195124.1375075-2-yukuai@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,grimberg.me,redhat.com,linux.dev,gmail.com,fygo.io,toxicpanda.com,linux.ibm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[fygo.io:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fygo.io:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_022938_184394_3AD97CDB 
X-CRM114-Status: GOOD (  23.17  )
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

On 7/4/26 9:51 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai@fygo.io>
> 
> bio_set_dev() is about to become explicitly sleepable because it can
> associate the bio with a blkg for the destination queue.  NVMe failover
> can run from request completion context, and nvme_failover_req() also holds
> head->requeue_lock with interrupts disabled while it steals bios from the
> failed request.  Calling bio_set_dev() there is not safe once the helper is
> allowed to sleep.
> 
> The requeue lock only protects head->requeue_list.  Keep the list
> manipulation under that lock, but defer retargeting to nvme_requeue_work(),
> which already drains the list from process context before resubmitting each
> bio.  The bios remain private to the requeue list until the worker pops
> them, so moving the device switch there preserves the existing retry flow
> while avoiding a sleepable helper in completion context.
> 
> Signed-off-by: Yu Kuai <yukuai@fygo.io>
> ---
>   drivers/nvme/host/multipath.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9b9a657fa330..76baa180ae1c 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -149,7 +149,6 @@ void nvme_failover_req(struct request *req)
>   	struct nvme_ns *ns = req->q->queuedata;
>   	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
>   	unsigned long flags;
> -	struct bio *bio;
>   
>   	nvme_mpath_clear_current_path(ns);
>   	atomic_long_inc(&ns->failover);
> @@ -165,8 +164,6 @@ void nvme_failover_req(struct request *req)
>   	}
>   
>   	spin_lock_irqsave(&ns->head->requeue_lock, flags);
> -	for (bio = req->bio; bio; bio = bio->bi_next)
> -		bio_set_dev(bio, ns->head->disk->part0);

If you remove this the original device remains being referenced by
the bio, so there might be a chance of some accidentally referencing
the (now invalid) bdev.
I think it might be better if you were set it to NULL here, to
signal that this bio currently has no bdev associated.

>   	blk_steal_bios(&ns->head->requeue_list, req);
>   	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
>   
> @@ -684,6 +681,7 @@ static void nvme_requeue_work(struct work_struct *work)
>   		next = bio->bi_next;
>   		bio->bi_next = NULL;
>   
> +		bio_set_dev(bio, head->disk->part0);
>   		submit_bio_noacct(bio);
>   	}
>   }

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

