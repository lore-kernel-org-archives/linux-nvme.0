Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D18BE7BDB8
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Feb 2026 12:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J3fd7dLITM7yY9eEmNCCHUGJL+2wK7zwHt4EEYrc7x4=; b=fku7XXBcbTjUUGRDTCt+JnvCKg
	RGFwM0nzmH1C1cGzuxwKtUmSFoyhCAhgehaA6n3e4PAphutA4U3z+UP439JvDQsMtc+7O+HHOttsz
	7HJt4a2BCdACZRL82DasEfMzEC3ymAI2oz9RcgUv1vfKLoOpCsO0euPdCAFj0s63AnFn4cZ2FC2l3
	X1hA1Po5b75d7MWUVWk/fyyHtUDM2LFrvwu8xOu5rTo0zwSPreIHJNpc2oN2qSNbj4zLoxbHsBEd4
	4zbYmqSXkaQoBqC4YPkGvD94A0E059tPHC10yXcxKcTVvjOXIyDnt6d0+XdQBK5GAeyvcWoOvcbFd
	YMYO88Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vry7Q-00000006YkS-35Ha;
	Mon, 16 Feb 2026 12:54:28 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vry7K-00000006Yjm-34t4
	for linux-nvme@lists.infradead.org;
	Mon, 16 Feb 2026 12:54:24 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9008E3E6FE;
	Mon, 16 Feb 2026 12:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771246460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3fd7dLITM7yY9eEmNCCHUGJL+2wK7zwHt4EEYrc7x4=;
	b=pkeotwz7ZQhEZRJz2kCWtqmm5AB3EHaMwYpUMwe35t1q7Hc9RNc73gy2TuJJf2aRdBiikX
	0oaeiJrDCLAlhCO+7IY1EeR7w+we1PeAXKBVyXwTcewDSQK6rg3+hTm0W8sqWJhp3Bn9Cd
	QKApWxFglx005te6IhvM6lP129+eP1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771246460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3fd7dLITM7yY9eEmNCCHUGJL+2wK7zwHt4EEYrc7x4=;
	b=w8f09PkqJOqzOXXhLNBfctI6uPF5HrPsFAw/MZT1NyyoVBZ7DtvkD5a8QMzpHuGtGDZ/sE
	QcxE/DGp1VPTIiBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pkeotwz7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=w8f09Pkq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771246460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3fd7dLITM7yY9eEmNCCHUGJL+2wK7zwHt4EEYrc7x4=;
	b=pkeotwz7ZQhEZRJz2kCWtqmm5AB3EHaMwYpUMwe35t1q7Hc9RNc73gy2TuJJf2aRdBiikX
	0oaeiJrDCLAlhCO+7IY1EeR7w+we1PeAXKBVyXwTcewDSQK6rg3+hTm0W8sqWJhp3Bn9Cd
	QKApWxFglx005te6IhvM6lP129+eP1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771246460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3fd7dLITM7yY9eEmNCCHUGJL+2wK7zwHt4EEYrc7x4=;
	b=w8f09PkqJOqzOXXhLNBfctI6uPF5HrPsFAw/MZT1NyyoVBZ7DtvkD5a8QMzpHuGtGDZ/sE
	QcxE/DGp1VPTIiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 405903EA62;
	Mon, 16 Feb 2026 12:54:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /RKcC3wTk2mFSQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 16 Feb 2026 12:54:20 +0000
Message-ID: <9d6cf4f9-37d8-4704-bcc1-0b849ad28955@suse.de>
Date: Mon, 16 Feb 2026 13:54:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/21] nvme: Update CCR completion wait timeout to
 consider CQT
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <jsmart833426@gmail.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-19-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260214042753.4073668-19-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9008E3E6FE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260216_045423_089270_607C99B8 
X-CRM114-Status: GOOD (  17.77  )
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

On 2/14/26 05:25, Mohamed Khalfella wrote:
> TP8028 Rapid Path Failure Recovery does not define how much time the
> host should wait for CCR operation to complete. It is reasonable to
> assume that CCR operation can take up to ctrl->cqt. Update wait time for
> CCR operation to be max(ctrl->cqt, ctrl->kato).
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0680d05900c1..ff479c0263ab 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -631,7 +631,7 @@ static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
>   	if (result & 0x01) /* Immediate Reset Successful */
>   		goto out;
>   
> -	tmo = secs_to_jiffies(ictrl->kato);
> +	tmo = msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
>   	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
>   		ret = -ETIMEDOUT;
>   		goto out;

That is not my understanding. I was under the impression that CQT is the 
_additional_ time a controller requires to clear out outstanding
commands once it detected a loss of communication (ie _after_ KATO).
Which would mean we have to wait for up to
(ctrl->kato * 1000) + ctrl->cqt.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

