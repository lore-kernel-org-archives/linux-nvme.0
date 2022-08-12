Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D449C00140
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Aug 2022 06:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R2Y/VPNNdSOrerjD17V92rdsSG/Bx0aU3vNZ4vyzUAU=; b=CuzCm/9xU2si1j+CmxnzUpm2CZ
	RBK62XmQmE4crBFj9MIwAcphIZ/ARAUWpGaTYEzUtXg1zOqcW7Y4fH3YHQrfRxXCtESxSxI7uKE8p
	AqfOtmyUB5jyefh0DNszrAdgg/JtDXjc1AyQ5eB7xKeHMS4SdnzBjN0v9bC8AG3/xaeByVO/+FWx3
	YucYheFFrY/1Sym5b8GDi4DIIFXdytrhxIi9PHF/wnaEwaeEQeVP7IzzUrNuDZTwzWbu+rC39OyWr
	uInUOKDtgBK+KG8pVY7d66rIdEbqZf3hs+qeUT5vMKvNbSatBTAWWNMdLtHF9TfqSm8RSwHerYeb6
	u8d8jn4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMNkK-00G7Ex-8F; Fri, 12 Aug 2022 06:02:12 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMNkH-00G77q-GX
	for linux-nvme@lists.infradead.org; Fri, 12 Aug 2022 06:02:10 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B29561FA42;
	Fri, 12 Aug 2022 06:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1660284118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2Y/VPNNdSOrerjD17V92rdsSG/Bx0aU3vNZ4vyzUAU=;
	b=CpQCtNBMGNbXSLcL9uUQz/jDUjmc4xtnpmIUUEbkt8FyqV3PhTnIY+ZkJJxFDm5eWn09sD
	S5AzjJZUkzeLVjvI/MWyY8TUt1hzTZaN5ZDrTaYUf06Z6Rob45mRtzvQkS1jdI8NY/hC6o
	rTSeLI3IZC5RD+tkyxcBgKMHSkOuSh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1660284118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2Y/VPNNdSOrerjD17V92rdsSG/Bx0aU3vNZ4vyzUAU=;
	b=XgqmdG0HkhULkQUXY+AZOBCaJOh4OelLGfJBeo/665HnTJD0phvcJjhbf/CuA0uub5bwPQ
	kSuUKp6hK1rHvCDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24F3613305;
	Fri, 12 Aug 2022 06:01:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8Q35Btbs9WKCZAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 12 Aug 2022 06:01:58 +0000
Message-ID: <454bc9b1-3c32-9947-85cc-bf43a56e6aa1@suse.de>
Date: Fri, 12 Aug 2022 08:01:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] nvmet-auth: clean up with done_kfree
Content-Language: en-US
To: Jackie Liu <liu.yun@linux.dev>, sagi@grimberg.me
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kch@nvidia.com
References: <20220812031231.3386953-1-liu.yun@linux.dev>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220812031231.3386953-1-liu.yun@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_230209_719778_F0E3233E 
X-CRM114-Status: GOOD (  14.74  )
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

On 8/12/22 05:12, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> Jump directly to done_kfree to release d, which is consistent with the
> code style behind.
> 
> Reported-by: Genjian Zhang <zhanggenjian@kylinos.cn>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index c851814d6cb0..17c19614b929 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -229,10 +229,8 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>   	}
>   
>   	status = nvmet_copy_from_sgl(req, 0, d, tl);
> -	if (status) {
> -		kfree(d);
> -		goto done;
> -	}
> +	if (status)
> +		goto done_kfree;
>   
>   	data = d;
>   	pr_debug("%s: ctrl %d qid %d type %d id %d step %x\n", __func__,

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

