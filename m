Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E96CCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 10:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rMjhk+aGsEEpedQXhsPzilwROqHBJolr6YIHF/2rFPY=; b=sF0msYSAe7D/sCSlW/fte73tMx
	3HLAJfcRynecop4LRd/iccmGNzhww7NTXI/vm9P9RCqLG79leglvMZyTa7TZZa5yP0Xww7box8O2P
	Xgedt5kFkEOpP5+9CmH1CB2Bx4JG0ffcWDlcx3GA+kY5IaX67ZfEpn6uulygH9WJ5QQXs5aKofKu6
	jK8UUdDgxIavt9hs+EoWFLoemfnkqKh+4tJtQyWLbANN3Dicsjs2MNMhzh5mwkLUA/vPtTOQOFFV/
	mF/I1H5ixRsbO55Uk+/wJnHMIGVXr1Y6BoI5BHXzvjUIvgUgLlOvbmQey/Lh39/0zypk6JoBS0AC7
	4yVLYY2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEd8-0000000Bf0v-3QYv;
	Tue, 04 Nov 2025 10:51:14 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEd5-0000000Bf07-3vSV
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 10:51:13 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDEBA21167;
	Tue,  4 Nov 2025 10:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMjhk+aGsEEpedQXhsPzilwROqHBJolr6YIHF/2rFPY=;
	b=EwvXlJXvjjjI2WSoG4ts/wPwXi1fdk88bGjhmbHqYMYADJP9SZiFDdaSf5HpL94gtOPuR6
	FS6pxD1GbclPMCqsexq2I6eWus4ZmPZLG28ouhiTMplzKBRGXIiRQpxmf6G6ACMFVOZlHZ
	CZkGscIeLjqRz/EZVWDkHKhLVq1Q26I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMjhk+aGsEEpedQXhsPzilwROqHBJolr6YIHF/2rFPY=;
	b=rUUwqsFedBomuDb8ijIQOKG7Cyd/tp3F0kMVlTTkUAgHEZuJvqpKIM8JnF1nlv6ksz6ita
	GNHIJLIhImAePVDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zjqTMwKX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="dLILKA/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMjhk+aGsEEpedQXhsPzilwROqHBJolr6YIHF/2rFPY=;
	b=zjqTMwKXdO+6iQk0ucTXOXFGYx/sGdZAqA5LP1KpbaZDRm4omMfWtJXoo3enDjMLk/9A54
	b5p3FKQQ4Pa5gtPImhW6QkqguXT71Of5XvWqaGBG2SmfI3T7IAFLZknmtUPvy83HgAXQDZ
	h/kihe/I43/nClS8Bg0ik9jx90wLLhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMjhk+aGsEEpedQXhsPzilwROqHBJolr6YIHF/2rFPY=;
	b=dLILKA/ZTkYqQ/wqXDoJl6JBFVdY0FRn64AyulU1xx9PB9NK7500Bb0qCB44tmTO17OWh5
	SJ+FmZVtIbO+rlDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D592D139A9;
	Tue,  4 Nov 2025 10:51:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /JZ2M53aCWn4bQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 10:51:09 +0000
Message-ID: <accf6ad7-047b-48d0-b626-f3ef0facd649@suse.de>
Date: Tue, 4 Nov 2025 11:51:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
To: Daniel Wagner <wagi@kernel.org>, Justin Tee <justin.tee@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
 <20251028-nvmet-fcloop-fixes-v1-1-765427148613@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-1-765427148613@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EDEBA21167
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_025112_121354_4AD3BF34 
X-CRM114-Status: GOOD (  18.61  )
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

On 10/28/25 16:26, Daniel Wagner wrote:
> nvme_fc_ctrl_put can acquire the rport lock when freeing the
> ctrl object:
> 
> nvme_fc_ctrl_put
>    nvme_fc_ctrl_free
>      spin_lock_irqsave(rport->lock)
> 
> Thus we can't hold the rport lock when calling nvme_fc_ctrl_put.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 03987f497a5b..2c0ea843ae57 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1488,7 +1488,9 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
>   		if (ret)
>   			/* leave the ctrl get reference */
>   			break;
> +		spin_unlock_irqrestore(&rport->lock, flags);
>   		nvme_fc_ctrl_put(ctrl);
> +		spin_lock_irqsave(&rport->lock, flags);
>   	}
>   
>   	spin_unlock_irqrestore(&rport->lock, flags);
> 
In theory, yes.
In practice we're getting a reference to the controller at the start
of the loop, so nvme_fc_ctrl_put() should just decrement the refcount.
But _if_ someone manages to sneak in an drop the reference while we are
within that loop then the entire logic falls apart as the controller
will be deleted and the next loop iteration will trip over an
uninitialized pointer.
So you would need to modify the loop to use
loop_for_each_entry_safe() to avoid this, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

