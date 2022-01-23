Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD965C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Jan 2022 09:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r73NySj9/8nCcgCFp8uXDnwcvio3YoBmRC1yq9rL+cA=; b=ZhNxk4PKUoB+60bMFOrdFjJe/5
	MtEqY0VdyKZu+MW6HC8BWEuCqWER/K7kLh456FkZOjrK28Pryfq/tSOhmxih4s+uytEOeCSdku6yY
	4bp0EilXI+jrHtbw8pqwaSDbwk7bZayJY0rf6shTgL3XaD1DEsfdta+JwZz/dkNBc17hzUtqPbAPg
	2j+UVwe3RHLPZmIXIHW+VpreNdmJ8CnwhuZ92gtr4l0Nctu7n7fBbcJ/efX38c/nE8O81b/mv/0VH
	VwmZ1i//BmWYtKzeh9vtznoZgVHoc63WKidMTdu0VDxwxFjXGyPNGRKs/hFKw9BidDYXLOKQ721TZ
	kLVZI89w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBZ1I-000VzE-H9; Sun, 23 Jan 2022 09:18:44 +0000
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBZ1G-000Vye-8h
 for linux-nvme@lists.infradead.org; Sun, 23 Jan 2022 09:18:43 +0000
Received: by mail-ed1-f45.google.com with SMTP id l5so33793489edv.3
 for <linux-nvme@lists.infradead.org>; Sun, 23 Jan 2022 01:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r73NySj9/8nCcgCFp8uXDnwcvio3YoBmRC1yq9rL+cA=;
 b=HIgoesBSX1lDUOPIrf3/WxzrrtXKSOM82NRlBTH/c0OEjjTPK+/9MXyvRTWQubMo34
 3rukS8EiJskgFhkP4Z7xpUGwY1+EytIyFRUpi+LzoTuKbSfUqlpRESo62xD0cUL5P2Ba
 rZ9RyDSlBGzZpX73Wb7x3OuoSW0lccJgLwU8j7V1iv7LzUGN4d9d2tnHksEBzc8KwO5h
 l4xNn3KPZREJPqKOpkJOi3ZEfFFMSjviSeBIIlD3oQwuungUmzS4YOL8pKgi7Ow+wv72
 EHd4DE2YaFsZb0cS58VbmBurgwdi4n8nF019gaDTBgLO+OqAQBRy4SLNtDt4Ioeiapa9
 1ALw==
X-Gm-Message-State: AOAM530iQvoTnQSjFBleJ7tg0lw6StPKQOOpeU9Vp4WDNV3M7VkE9j52
 YRMvxXV2sj/WD5SKy77FPeM=
X-Google-Smtp-Source: ABdhPJxc3L3NwP+jOgmLgmZgMxDGMTB+vRA/suyimW+H4HwGnMB9F6e7KDz661oq6OBBCMZ0HF+l0Q==
X-Received: by 2002:a05:6402:6ce:: with SMTP id
 n14mr4514432edy.262.1642929520791; 
 Sun, 23 Jan 2022 01:18:40 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id f2sm3628063eja.78.2022.01.23.01.18.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jan 2022 01:18:40 -0800 (PST)
Subject: Re: [PATCH 1/3] nvmet: add helper to set ns->blkshift value
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20220119072038.3942-1-chaitanyak@nvidia.com>
 <20220119072038.3942-2-chaitanyak@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ac69fed5-c1ff-d36c-d88d-e466de3dfcb2@grimberg.me>
Date: Sun, 23 Jan 2022 11:18:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220119072038.3942-2-chaitanyak@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220123_011842_344299_E96F2997 
X-CRM114-Status: GOOD (  12.88  )
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


>   void nvmet_file_ns_disable(struct nvmet_ns *ns)
>   {
>   	if (ns->file) {
> @@ -57,17 +67,14 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>   		return ret;
>   	}
>   
> +	ret = nvmet_file_ns_set_blkshift(ns);
> +	if (ret)
> +		return ret;
> +
>   	ret = nvmet_file_ns_revalidate(ns);
>   	if (ret)
>   		goto err;
>   
> -	/*
> -	 * i_blkbits can be greater than the universally accepted upper bound,
> -	 * so make sure we export a sane namespace lba_shift.
> -	 */
> -	ns->blksize_shift = min_t(u8,
> -			file_inode(ns->file)->i_blkbits, 12);
> -

Any particular reason for the change in location?

