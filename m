Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E95C00528
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 16:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wQexKwbMw/0jrCvp1mBl0Fr7yOygUHw2vHpVI3P30Jc=; b=dXlbUM2pT3By3WSWXFF9ve13+D
	ptFrp1wl5gpUuiKoL2RrOAgix6tEmohpVAXQ/VvRyY9ym+2lgPKpaSzllMGtNrpemEX9DfW5eqPg+
	yGbJ8JUHpniY0h/kWVrd0CNMbhUJiYn6PVnWT6WHfYeFJovtjQ/DOkjI6PkDLcUVGin+e47E5uFTq
	tq3cIaj4nmcrivPlcn+zkA5Br6F0Hskkw29CPqO1k++yiIz0PQe8JM3x9R0/1RptkORIMG/ga6LYP
	x9/g51wejoxJh4vcj4AJTTp5q/bsCDhSjG4NgPkvFw6t/4NTAgpaGBLGcNXdvTzPUHDmOdkDEGHQS
	Mq5O7BUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQVtp-00GaH8-2w;
	Mon, 31 Jul 2023 16:37:37 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQVtm-00GaG7-0r
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 16:37:35 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6964A1F854;
	Mon, 31 Jul 2023 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690821451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQexKwbMw/0jrCvp1mBl0Fr7yOygUHw2vHpVI3P30Jc=;
	b=tpuB/uTTqnw/VrWMQsnjA938YOn7XAj5/u+3IcT7fLm22OM7ohWxaZ46+ry10fSQKUObwo
	Ge4MK3ROhvepkY41dTJLmsFqNxdYDuCIQeKpFMSryXLhitmEgw890rFRTLH5duDYphsepO
	rDf6PGvoqoUtQ5Z+diz1gQRUJkKsZ28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690821451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQexKwbMw/0jrCvp1mBl0Fr7yOygUHw2vHpVI3P30Jc=;
	b=ez6HW3VZZe0VXx4zFKd0iYlY3rDvtmMHKka+KhRWz1XN/qKqWMvmWQIbfZJDqua7Xl4f7Q
	l1nBPC6r8NC5+rAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BBF71322C;
	Mon, 31 Jul 2023 16:37:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id yREgDUvjx2TuFwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 31 Jul 2023 16:37:31 +0000
Message-ID: <69d4239c-25b7-5d14-6140-490bb88dccb4@suse.de>
Date: Mon, 31 Jul 2023 18:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] nvme-auth: unlock mutex in one place only
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, kbusch@kernel.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20230731145106.917526-1-shiftee@posteo.net>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230731145106.917526-1-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_093734_496074_3A8DBA21 
X-CRM114-Status: GOOD (  16.17  )
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

On 7/31/23 16:51, Mark O'Donovan wrote:
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index daf5d144a8ea..e1a98647c3a2 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -758,12 +758,11 @@ static void nvme_queue_auth_work(struct work_struct *work)
>   		__func__, chap->qid);
>   	mutex_lock(&ctrl->dhchap_auth_mutex);
>   	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
> +	mutex_unlock(&ctrl->dhchap_auth_mutex);
>   	if (ret) {
> -		mutex_unlock(&ctrl->dhchap_auth_mutex);
>   		chap->error = ret;
>   		goto fail2;
>   	}
> -	mutex_unlock(&ctrl->dhchap_auth_mutex);
>   
>   	/* DH-HMAC-CHAP Step 3: send reply */
>   	dev_dbg(ctrl->device, "%s: qid %d send reply\n",
If you insist.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


