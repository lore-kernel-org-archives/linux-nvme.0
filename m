Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C92606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YVF36rvJ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eL6yy/B3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8KguGUmv;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eL6yy/B3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8KguGUmv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cVdkjZcu7zAJ6PrpW5zx6rDzwJZVY4gtOGIBtdWuyS4=; b=YVF36rvJQ99htb
	+UCF2TFBxflq27oSzvm1SKe+YuMkFwMiQenBZ45r2sQzlR/JNIIvdXfacXzgttduhddSRwuvlGzCG
	D8TJ0D3Sp2lMkqVWJxCo0jf9jrnLLhlJ0LpHJbFBpFKjprjgq947Bom0iIxVNeDHKMcI87P9oPhvc
	VVs/tE92W4TkufSnfkbspt3kv8U98I2utU2bog33iWCezEkd89Uc8XY1MTg2a7XJK09SgIiUuuyHu
	IYexpJSo2XpWIV3SejdhxpFlbNeH+Jqr9JUajCbkSyS/lxY+RW56R2PPfONiK5yZCmciWonBO3Bj4
	SnnYyHeLu89Jxd7yj79A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSra6-00000001UUn-2SbZ;
	Mon, 16 Nov 2026 07:56:50 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSra2-00000001UTC-44kh
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 07:56:49 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 070471FCC4;
	Mon, 16 Nov 2026 07:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794815805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVdkjZcu7zAJ6PrpW5zx6rDzwJZVY4gtOGIBtdWuyS4=;
	b=eL6yy/B3nPL99EfpS49lqxZW6V0Ihz3XF/9NsyRgGsPDUgiWD9HDOot/dgkSTFrgSKzkER
	Otgb05yfneG0Sw0+obNuE37uy7r379hoC1sBnh+i+W1aKwab6e8bYgBO7cqugy12ZgTRXd
	exhhWt+Ztv1bahV7MNDYLMsUmE4cRKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794815805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVdkjZcu7zAJ6PrpW5zx6rDzwJZVY4gtOGIBtdWuyS4=;
	b=8KguGUmvtR/AG+4GjQsHSYf3J1dL3Ax/9rldNahF7n9a+Vm/ZfrttVZd/DLKUxbRkxFaAW
	4RApqb979WWpABBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794815805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVdkjZcu7zAJ6PrpW5zx6rDzwJZVY4gtOGIBtdWuyS4=;
	b=eL6yy/B3nPL99EfpS49lqxZW6V0Ihz3XF/9NsyRgGsPDUgiWD9HDOot/dgkSTFrgSKzkER
	Otgb05yfneG0Sw0+obNuE37uy7r379hoC1sBnh+i+W1aKwab6e8bYgBO7cqugy12ZgTRXd
	exhhWt+Ztv1bahV7MNDYLMsUmE4cRKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794815805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVdkjZcu7zAJ6PrpW5zx6rDzwJZVY4gtOGIBtdWuyS4=;
	b=8KguGUmvtR/AG+4GjQsHSYf3J1dL3Ax/9rldNahF7n9a+Vm/ZfrttVZd/DLKUxbRkxFaAW
	4RApqb979WWpABBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACA591334C;
	Mon, 16 Nov 2026 07:56:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5zhYIDy3+monRgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 16 Nov 2026 07:56:44 +0000
Message-ID: <ad4bfa86-97a7-4fd3-8feb-eb17643f2499@suse.de>
Date: Mon, 16 Nov 2026 08:56:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvmet: Synchronize the TLS key debugfs read with admin
 queue teardown
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261116075447.1713255-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261116075447.1713255-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,alibaba.com:email,suse.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_235647_163405_D94E82A9 
X-CRM114-Status: GOOD (  24.94  )
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

On 11/16/26 8:54 AM, Guixin Liu wrote:
> nvmet_ctrl_tls_key_show() dereferences ctrl->sqs[0] and its tls_key
> without any synchronization.  The admin queue may not be installed
> yet or be destroyed concurrently, and nvmet_sq_put_tls_key() can drop
> the key reference while a reader is looking at it, leading to NULL or
> use-after-free dereferences.
> 
> Take the admin queue's percpu reference for the duration of the read
> so the queue cannot be torn down, and use ctrl->lock to serialize with
> nvmet_sq_put_tls_key() so the key cannot be dropped mid-read.
> 
> Fixes: 316dabe6089fe ("nvmet: add tls_concat and tls_key debugfs entries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> 
> Changes since v2:
> - Take the admin queue's percpu reference during the read and use
>    ctrl->lock to serialize with nvmet_sq_put_tls_key(), so the queue
>    and its key cannot go away mid-read (Christoph Hellwig)
> Link: https://lore.kernel.org/all/20261029034306.3626274-1-kanie@linux.alibaba.com/
> 
> Changes since v1:
> - Simply return 0 when the admin queue is absent in
>    nvmet_queue_tls_keyid() instead of dereferencing it, covering the
>    not-yet-created and already-destroyed windows (Hannes Reinecke)
> Link: https://lore.kernel.org/all/20261028064417.548948-1-kanie@linux.alibaba.com/
>   drivers/nvme/target/debugfs.c | 15 +++++++++++++--
>   drivers/nvme/target/nvmet.h   |  4 ++++
>   2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
> index e85fe1d4c9f8..cc451e25ea1d 100644
> --- a/drivers/nvme/target/debugfs.c
> +++ b/drivers/nvme/target/debugfs.c
> @@ -136,8 +136,19 @@ NVMET_DEBUGFS_ATTR(nvmet_ctrl_host_traddr);
>   static int nvmet_ctrl_tls_key_show(struct seq_file *m, void *p)
>   {
>   	struct nvmet_ctrl *ctrl = m->private;
> -	key_serial_t keyid = nvmet_queue_tls_keyid(ctrl->sqs[0]);
> -
> +	struct nvmet_sq *sq = ctrl->sqs[0];
> +	key_serial_t keyid = 0;
> +
> +	/*
> +	 * Pin the admin queue against teardown, and serialize with
> +	 * nvmet_sq_put_tls_key() so the key cannot be dropped mid-read.
> +	 */
> +	if (sq && percpu_ref_tryget_live(&sq->ref)) {
> +		mutex_lock(&ctrl->lock);
> +		keyid = nvmet_queue_tls_keyid(sq);
> +		mutex_unlock(&ctrl->lock);
> +		percpu_ref_put(&sq->ref);
> +	}
>   	seq_printf(m, "%08x\n", keyid);
>   	return 0;
>   }
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index e315f1c24e73..24df9e4a1e1c 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -957,13 +957,17 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
>   #ifdef CONFIG_NVME_TARGET_TCP_TLS
>   static inline key_serial_t nvmet_queue_tls_keyid(struct nvmet_sq *sq)
>   {
> +	if (!sq)
> +		return 0;
>   	return sq->tls_key ? key_serial(sq->tls_key) : 0;
>   }
>   static inline void nvmet_sq_put_tls_key(struct nvmet_sq *sq)
>   {
>   	if (sq->tls_key) {
> +		mutex_lock(&sq->ctrl->lock);
>   		key_put(sq->tls_key);
>   		sq->tls_key = NULL;
> +		mutex_unlock(&sq->ctrl->lock);
>   	}
>   }
>   #else

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

