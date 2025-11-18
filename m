Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7498BCEBF93
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 07:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a/FvumS8RsqF+3RcJbKhQK8h4HoAvKjVffBThdh2T7A=; b=a2PBnOzgaQl8Sygaw1hPc4nbRZ
	NjxMLJDMX8+6kENghDWDXlb1Qp42aKMTJpZ6tCUXqBPx8t4h+cmbB7gJTOzqle/tx0RrKrLDUruHs
	dsdwqMbvBVJkMy2N+FGFhNElhmFaBmJ9KzYgEfrJkIg+xbqHYVJfy9o1x18YfcxzeVAeIiBxJISSI
	aDYm9j3nyJEfWn2Gx5qSfPC/JFi+lk/0gF9U83gNso6ZF/W5do6megpsNmZoptkIdHfTWLGJkz752
	KPUeb0+k4dYq4yiNDnSpuw942C45DNIPAaJ39A1zp6b4AMBI+iyKqCh6Ez4/cIeen6KwX85UIWYeH
	kTtgtx8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLFiH-0000000HWoj-423k;
	Tue, 18 Nov 2025 07:01:17 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLFiF-0000000HWo0-09cV
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 07:01:16 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 511A32116F;
	Tue, 18 Nov 2025 07:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763449271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/FvumS8RsqF+3RcJbKhQK8h4HoAvKjVffBThdh2T7A=;
	b=OlN/fAb5robpppVCccSncDPrJOMkFjpHToRABkIG++mX1AFplZIUYLPOFRzfRClvaQ6NqP
	ptIo+Gt2GctcbI8maCIURsdAV4giK+qJ8RxBfZI5JyutzD5oZKnlxqBVHdMreoarFGGcB6
	MuBSKQc3lUnE+byfbJAboJabYfm9WNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763449271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/FvumS8RsqF+3RcJbKhQK8h4HoAvKjVffBThdh2T7A=;
	b=wC5JTfzoZrDk0XcKHJC4Z8R13xpODhDUBit7Ajfcodd18z18iVsMfXuM2bvcrYP9BJCpIl
	b1gpNzkqkEvK0yBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763449271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/FvumS8RsqF+3RcJbKhQK8h4HoAvKjVffBThdh2T7A=;
	b=OlN/fAb5robpppVCccSncDPrJOMkFjpHToRABkIG++mX1AFplZIUYLPOFRzfRClvaQ6NqP
	ptIo+Gt2GctcbI8maCIURsdAV4giK+qJ8RxBfZI5JyutzD5oZKnlxqBVHdMreoarFGGcB6
	MuBSKQc3lUnE+byfbJAboJabYfm9WNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763449271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/FvumS8RsqF+3RcJbKhQK8h4HoAvKjVffBThdh2T7A=;
	b=wC5JTfzoZrDk0XcKHJC4Z8R13xpODhDUBit7Ajfcodd18z18iVsMfXuM2bvcrYP9BJCpIl
	b1gpNzkqkEvK0yBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 131443EA61;
	Tue, 18 Nov 2025 07:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yh6mArcZHGkoSAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Nov 2025 07:01:11 +0000
Message-ID: <c2b9fb9c-440d-4e41-b4e8-7428fcf9c2ca@suse.de>
Date: Tue, 18 Nov 2025 08:01:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme-fabrics: add ENOKEY to no retry criteria for
 authentication failures
To: Justin Tee <justintee8345@gmail.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: jsmart2021@gmail.com, justin.tee@broadcom.com,
 Daniel Wagner <wagi@kernel.org>
References: <20251117184343.97605-1-justintee8345@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251117184343.97605-1-justintee8345@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_230115_227979_2ED81245 
X-CRM114-Status: GOOD (  15.45  )
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

On 11/17/25 19:43, Justin Tee wrote:
> With authentication, in addition to EKEYREJECTED there is also no point in
> retrying reconnects when status is ENOKEY.  Thus, add -ENOKEY as another
> criteria to determine when to stop retries.
> 
> Cc: Daniel Wagner <wagi@kernel.org>
> Cc: Hannes Reinecke <hare@suse.de>
> Closes: https://lore.kernel.org/linux-nvme/20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org/
> Signed-off-by: Justin Tee <justintee8345@gmail.com>
> ---
>   drivers/nvme/host/fabrics.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 3d4d6d8e88c4..fb7765bf0cdf 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -594,7 +594,7 @@ bool nvmf_should_reconnect(struct nvme_ctrl *ctrl, int status)
>   	if (status > 0 && (status & NVME_STATUS_DNR))
>   		return false;
>   
> -	if (status == -EKEYREJECTED)
> +	if (status == -EKEYREJECTED || status == -ENOKEY)
>   		return false;
>   
>   	if (ctrl->opts->max_reconnects == -1 ||

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

