Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A233DC00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 18:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LWFc53dfp5h/b6bNyb2pxE66S6PtnhMkOByF8PUpAeI=; b=LEhmDskHfMv5UvX1oqAR3nlz4L
	/EQUaIq2gdPaN/4qElF2iWdCweLocWoaGYBwKG9SxPxozQRJvOEFUNs7TNQOmnXLmAhDqycd46AAe
	jRzCeIKAZtw8/xuP8I8+jDzqtpzHW95b3EVRu65GC4P9tjHrp+kX8GVp/ZgBUt8YF8xYFr2yrzf81
	DV8uBt6I4bf8elVeNJj6kTxiuc17U8i2rUVjULRaIQ7ZPKPb8c7QUQ5OHdSCNp0qQ87rrwzBP10Uw
	uk3d91APVY21UXmYHE1uNjc0TvJ3i4B8Sau9mSs9tb9sXUllb4ofLLG7kUN2yeIYE5h0FMoRq8z84
	Yg6FwSeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIa1G-008pHs-Mz; Mon, 01 Aug 2022 18:19:58 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIa1B-008p1r-45
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 18:19:54 +0000
Received: by mail-pf1-x42e.google.com with SMTP id u133so4702678pfc.10
        for <linux-nvme@lists.infradead.org>; Mon, 01 Aug 2022 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LWFc53dfp5h/b6bNyb2pxE66S6PtnhMkOByF8PUpAeI=;
        b=i196U5cWd2PQ9N4Na/CHEAg46nppJAydeyKRBJUU60n/gPMAz3uHrHu9ai1ZvWcQsd
         tY5YF+qdj+WjJZY2jVeNBGe3tqAfmj9Y/QqV77V25kmsKh0TslXFV5uNgVY2jrhiF3HY
         iNRwUSHoeRpCnt13HnfdRDuoeE6FF1pBkF0tMOd+f5fecWn17ipzgWWjKl2DUVzYwI11
         cq+cV1vJdnnVu2lGkknYyFzUjmIYVRyTiH7yRIu+dIMUeieIIX7rjfhtwidRS6DF4gA5
         yI4tWDc/8DlF3PFp87W3Rx8cLhCUxs1nv6LQq/RReB5k81sCqGlKk/W6qEWAI1Aes+KN
         bGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LWFc53dfp5h/b6bNyb2pxE66S6PtnhMkOByF8PUpAeI=;
        b=7Qu+w7TLcmeFJ/PdeSJBgRpVxUqu65RKtTXQsGeXXCSbC0pz/mu9bHLtrUWC/Hc9tQ
         YM7rFP7Xh2DprR3uKU2uX1nMN++unwPZ1tIjKEGkq2v3vmXu5IKBewFPx+F1Q/k/4QbX
         GB2LpSh9dXtGEQ2HaocvbA2d+LtLPWBfOdS7gm30TFhUz7EDru2Qg1zg9mfgbmGFHSOC
         rQ6idJg6mGRHDZxhANDZVsLDTajy7x5XUR4SBPKaSrwBaIQpJkt5rHWQtU8XFZZoND0U
         76TU+XMYDA8eEuE0cOqgy0SRXPhz+h5fZdagMOUlWDJfrXmB09WkwJNimGuhWGcN75fA
         qSWw==
X-Gm-Message-State: AJIora8YhKTeHkCcrG5tnBmEc9cLS71NmPjZe7axWqQN83SQpcl2zBme
	T+sVjyo+Sziqg4ti8Sr1cikZ29y9Xm4zzw==
X-Google-Smtp-Source: AGRyM1t4DXdjUTx48DPhDWOvLU5j3wj7P62t42f2cXH1AUi6+ZuCJDNl661QjWsqFye1GdmT9GIwCg==
X-Received: by 2002:a05:6a00:10d3:b0:4fe:5d:75c8 with SMTP id d19-20020a056a0010d300b004fe005d75c8mr17858440pfu.6.1659377986810;
        Mon, 01 Aug 2022 11:19:46 -0700 (PDT)
Received: from google.com ([2620:15c:211:202:8c46:3487:778c:aadb])
        by smtp.gmail.com with ESMTPSA id cp17-20020a17090afb9100b001ef9659d711sm9152277pjb.48.2022.08.01.11.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 11:19:46 -0700 (PDT)
Date: Mon, 1 Aug 2022 11:19:39 -0700
From: Justin Stitt <justinstitt@google.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux@roeck-us.net, hare@suse.de,
	sagi@grimberg.me
Subject: Re: [PATCH] nvmet: fix a format specifier in
 nvmet_auth_ctrl_exponential
Message-ID: <YugWEHx+Myhtfv7v@google.com>
References: <20220718050356.227647-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718050356.227647-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_111953_299294_8586BC30 
X-CRM114-Status: GOOD (  20.58  )
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

On Mon, Jul 18, 2022 at 07:03:56AM +0200, Christoph Hellwig wrote:
> dh_keysize is a size_t, use the proper format specifier for printing it.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/target/auth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index b41c7bbcc4366..cf690df347758 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -488,7 +488,7 @@ int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
>  		return -ENOKEY;
>  	}
>  	if (buf_size != ctrl->dh_keysize) {
> -		pr_warn("ctrl %d DH public key size mismatch, need %lu is %d\n",
> +		pr_warn("ctrl %d DH public key size mismatch, need %zu is %d\n",
>  			ctrl->cntlid, ctrl->dh_keysize, buf_size);
>  		ret = -EINVAL;
>  	} else {
> -- 
> 2.30.2
> 
> 
> 
This patch runs parallel to our efforts to re-enable -Wformat.
See here: https://lore.kernel.org/all/20220720232332.2720091-1-justinstitt@google.com/

Hopefully this patch gets picked up by a maintainer so that Masahiro can
stage a clean PR re-enabling the -Wformat warning.

Reviewed-by: Justin Stitt <justinstitt@google.com>

