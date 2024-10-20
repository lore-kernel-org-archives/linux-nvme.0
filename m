Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DECD3C92D
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 23:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ra51PlWUFtaQLGUy/r55AA8Ya2cUP4neXV/My1wliA4=; b=lj1/5G7dI69Rbd+1T3j0qCDjVe
	n1NdnD4X+m28BZORzLvPYyyN+6lw/3x/EiyUaXFGVzCC/A2sOf5LzBYXs88KLerfOMNzhxZZhrT6Z
	Wxc/UxzTI5q/zSOBE46XWlGb5MWvHLIy65DUJCw3PLnhT8YBE9jryQGpugnDbNj8YrqyCTbJvX9tQ
	zwZfeNP9LA8LOLleKYyspj3EGp7nFMnfd+q9qTEbXKblb77xn8DD8uxAqgQH/16Z+U+WNKUtDyHFU
	hVTgdE0LH6SmcJq/SEnp8BbMLjJu1fXlwJexTXw5A05J3FI2b78o61NzUkcVOefi5L4CQ2GTFXiUU
	HJpAEY7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2fQa-00000005cxO-3IM5;
	Sun, 20 Oct 2024 23:33:40 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2fQY-00000005cx0-2U0v
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 23:33:40 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43161c0068bso24325815e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 16:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729467217; x=1730072017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ra51PlWUFtaQLGUy/r55AA8Ya2cUP4neXV/My1wliA4=;
        b=XsL+qj6ivGTEQmy1Ffdp90mE9bivrQ7FyevNRybdg/m3ulXuCYuuLbg8mKVCFYpcfd
         yUCRc9k0dKNwdAn/hKSpuRKbaSRUbqWWWLzqhC+7Esr3g0ICjYz7klICY61Q+oulK4bX
         tpit3MXrp+ENOSbAbT+ktcxrVmlB7K/RShj/M3eokR2b8sn1lOWf4YA2rAXgPikyEwps
         4Dr4px0M0X6XBPQiTGMjF01eXRKQ5jHJavYJMbE3qdB307BsTEHiocHOyGSoreUz8yOM
         UvuZa0DH4UtgNs/hPnla1tGHa1e4sPbc5Avfl6f3KnHoRGh1zB8Uq40wNT22qrdF/6vV
         FTSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTAF7TOzQ4gqWcgAs6qzNDERHoD780ncjhAg4OFLy4tpjGXZGgSqb5MFwLob9Zlcuw4Sdkmrygtm23@lists.infradead.org
X-Gm-Message-State: AOJu0YwEdH8pjUcNDOY10ee1NO3k2jx0XypMmAXG8AzB6m4QfUMsxM0r
	ULk/RbxsNFOHTl0XTppLxwWC2E1HJw3efYv8Nuyl6tRegETWqtYm846PTQ==
X-Google-Smtp-Source: AGHT+IFkTk8xRLypyhaYImFfcBVO5rLrEFkAvOiA4H2Fg5ycMnBsD/Ij/Y6QzpuuF5XyxHNN1oWhog==
X-Received: by 2002:a5d:5e10:0:b0:37e:d2b7:acd5 with SMTP id ffacd0b85a97d-37ed2b7afc9mr4838362f8f.8.1729467216820;
        Sun, 20 Oct 2024 16:33:36 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9b8b9sm2799208f8f.92.2024.10.20.16.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 16:33:36 -0700 (PDT)
Message-ID: <888e247e-32c0-425a-9bb8-df4a498d5f5d@grimberg.me>
Date: Mon, 21 Oct 2024 02:33:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-multipath: simplify loop in
 nvme_update_ana_state()
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20241007100134.21104-1-hare@kernel.org>
 <20241007100134.21104-2-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241007100134.21104-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_163338_670033_E0276103 
X-CRM114-Status: GOOD (  22.50  )
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




On 07/10/2024 13:01, Hannes Reinecke wrote:
> Currently nvme_update_ana_state() iterates over all namespaces
> with the srcu lock held, and calls the 'cb' function if a
> match on the list of namespaces from the ANA log is found.
> This assumes that the iteration itself is relatively quick,
> and the namespace state itself doesn't change during iteration.
> For more complex functions (eg if the 'cb' function triggers
> mpath_set_live() which then kicks off a partition scan) the
> namespace state might change while iterating, and the rcu-protected
> area becomes really long.
> So change the loop to iterated over the entries in the ANA log,
> and call nvme_find_get_ns() on each entry.
> With that the 'cb' function is executed outside of the RCU
> protected area, and normal reference counting rules apply.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/multipath.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index f72c5a6a2d8e..61f8ae199288 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -745,7 +745,6 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
>   	u32 nr_nsids = le32_to_cpu(desc->nnsids), n = 0;
>   	unsigned *nr_change_groups = data;
>   	struct nvme_ns *ns;
> -	int srcu_idx;
>   
>   	dev_dbg(ctrl->device, "ANA group %d: %s.\n",
>   			le32_to_cpu(desc->grpid),
> @@ -757,21 +756,16 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
>   	if (!nr_nsids)
>   		return 0;
>   
> -	srcu_idx = srcu_read_lock(&ctrl->srcu);
> -	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
> +	for(n = 0; n < nr_nsids; n++) {
>   		unsigned nsid;
> -again:
> +
>   		nsid = le32_to_cpu(desc->nsids[n]);
> -		if (ns->head->ns_id < nsid)
> -			continue;
> -		if (ns->head->ns_id == nsid)
> +		ns = nvme_find_get_ns(ctrl, nsid);
> +		if (ns) {
>   			nvme_update_ns_ana_state(desc, ns);
> -		if (++n == nr_nsids)
> -			break;
> -		if (ns->head->ns_id > nsid)
> -			goto again;
> +			nvme_put_ns(ns);
> +		}
>   	}
> -	srcu_read_unlock(&ctrl->srcu, srcu_idx);

You also made the loop now n^2... which *may* be an issue for an 
environment with
a lot of namespaces. It is simpler though...

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

