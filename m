Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACF5C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 06:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7xkKcmgPw3ZDovZ7l1hSJonyW+RZ1pCvaQQGsB3RSRU=; b=Bz0stCCINvA5RhCon98L8a7H2h
	kkZJdElSElRoNzFFCV2t1TNVjscjK7tQFLkE+Gnj+yyE+OYjlv3ZjPW0owm1xQkE8dDfi8ZWEL7PF
	LGoFmNfgyOSsVAGbGVQK297Ovt/JdsBik/TcuMLviIYOdo+zlT8LemSvi3qwEv++P+/1CGNcByfGE
	cQRPxERLsLFy2xYTci2bVaXPx7y1bTqXzuoSRtjmp+PmabR65gCtRe+bDm0rCg7Z8KStmn/fK0tnb
	ygyPt+NxztAhSCqJjuEHhSj04CseIKjjG5tUj3F3p6+StxR14wvefPuKZ4ePX+Wh8Cc+ZMAH1sxYB
	uIFKZ/Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDKE0-00BCWR-77; Mon, 18 Jul 2022 06:27:24 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDKDx-00BCUs-Pd
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 06:27:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1203D37299;
	Mon, 18 Jul 2022 06:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658125637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xkKcmgPw3ZDovZ7l1hSJonyW+RZ1pCvaQQGsB3RSRU=;
	b=vySa+EvABzS92f4UDOWiC8xZs73v18L29T0Kq1lDBlS+Qopt+pJKbj7joRCPINlM3gIcjY
	waiXwNesyoVv8Zt4+8sHiP5Kf94zYvVavkAfAyU5PiB4FcP7zfii12ka4JcAJeBIqc7BEQ
	QIOr4BGzr6knSihdqSRyaai7wtqyM+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658125637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xkKcmgPw3ZDovZ7l1hSJonyW+RZ1pCvaQQGsB3RSRU=;
	b=3YdS9SDeDbt3DwHj+OFigtSxR8fxWd81QrhV8ubna5jcSytP/px28GbAw1OJNMTVSI9lPA
	XIfK+wdRu+WUggBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6CF813754;
	Mon, 18 Jul 2022 06:27:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id fIP5NkT91GIZWwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 18 Jul 2022 06:27:16 +0000
Message-ID: <8ffbd659-f8db-97f3-b4b7-ce63b1499677@suse.de>
Date: Mon, 18 Jul 2022 08:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmet: fix a format specifier in
 nvmet_auth_ctrl_exponential
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc: linux@roeck-us.net, sagi@grimberg.me
References: <20220718050356.227647-1-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220718050356.227647-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220717_232722_024857_27D06CC0 
X-CRM114-Status: GOOD (  16.44  )
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

On 7/18/22 07:03, Christoph Hellwig wrote:
> dh_keysize is a size_t, use the proper format specifier for printing it.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/target/auth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index b41c7bbcc4366..cf690df347758 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -488,7 +488,7 @@ int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
>   		return -ENOKEY;
>   	}
>   	if (buf_size != ctrl->dh_keysize) {
> -		pr_warn("ctrl %d DH public key size mismatch, need %lu is %d\n",
> +		pr_warn("ctrl %d DH public key size mismatch, need %zu is %d\n",
>   			ctrl->cntlid, ctrl->dh_keysize, buf_size);
>   		ret = -EINVAL;
>   	} else {

Reviewed-by: Hannes Reinecke <hare@sues.de>

Cheers,

Hannes

