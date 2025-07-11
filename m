Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF44C83F1A
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jul 2025 10:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=drrPqlvrN7nEqRHRRiM3RHqwBps46EJCmsEKgD9+IAM=; b=nAWWCIounk9/GSVaRa/Iwb71jG
	NQ9Ld/qGXkXKZXDPsgDetp49bmFTjtYyUg10+jLLxkd7ePfTo8fMj8w/nNm1/Dqv+xn8uyQ8YIuCS
	1Wd0o9Q8Ut+vozFvAIPS0p4oZOqnYYlTxZFi4XNyZE9802zAUc+ye/hdjK1AlobX4eUpQUa98205q
	t/uhlxkoTVmSxAKoYezpKk101xen0cTTV4gXktACh1aGycYcdJ/QRS0dZnsw7YVtWmBKhlTnQPoBW
	r9STFP64+6OhDJrZlzWNSqCw1DxRQt/+Eb2QHklZKULzc2nthUFu8xsGe1PjwE0P5eBcX8UnexaNg
	TU1X8vvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaAaU-0000000EQP5-2cUB;
	Fri, 11 Jul 2025 10:02:38 +0000
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua9iq-0000000EG4P-3IdG
	for linux-nvme@lists.infradead.org;
	Fri, 11 Jul 2025 09:07:14 +0000
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-32b7113ed6bso16151041fa.1
        for <linux-nvme@lists.infradead.org>; Fri, 11 Jul 2025 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752224831; x=1752829631; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=drrPqlvrN7nEqRHRRiM3RHqwBps46EJCmsEKgD9+IAM=;
        b=euQUmraFsZrqijk97/vNx7unK3DPVQ/0o4Bm5G2G8WGN15+y10AA0v2wdJ/mNlLxfQ
         HtLw7b0J3CHS8w+sxfdPVX6Ww98dfzLVjtKn2Gokp4NkxFxFdm3d+LcoPceQNeNyx6GL
         CufM0XjxYdPu6oq1C4Wg/B+danlraVNH1O6sLCa9hSZNqIuNC1JIY7XTUrMT4F0uagdf
         SvFZRuyhRvPVWiHkMcXyGEmQYQa3GbKG48jFuQiJv1n0xPlxswNf7JT2LzgbVDCEDAwg
         Nl1iDKm9HWIk9iusIsSQOaPPJw4ID7hXlqQhS18XhBNMVJAjEGZtPZMMxE3jmQcZWTTz
         wZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752224831; x=1752829631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drrPqlvrN7nEqRHRRiM3RHqwBps46EJCmsEKgD9+IAM=;
        b=pKjZPjCBnOo/s6p/yHbg+6T1Dcr26l7JgkSkGNTLghAYAG71F6lWLXG2OGscUsP0E5
         UCeiAivJKSeR4McpetP22MqOwPZWc9vrJMpi2IByey55BgziGUfRwbtrX6Wk7DMIPIvu
         z0aokhUrW95vKFl3TwADFdzX1oarHKqqw72GgOLbnc9byAb8ZpgCsTLgB3jLXGzi/bne
         qoJGqGMLP+lq3XkqdXnD8Ahr3FqFhfCxkckVy2z3zv5X/GUt+e6BAviqIak2ei2l90NM
         U24O81FRrGuZ5FVImrnGtBMmZXV9JOfTEWsPDsfbGX/NCPJRIFky9FDCvychDx4RrB+E
         dfvw==
X-Forwarded-Encrypted: i=1; AJvYcCXt1cTuUbiKZa2dEgSNcIO8l/8cn1Km2fzsuX+kd4dtrqhBSCkIiTioFr9O9lx1vtHMpwQ7twjKNfwx@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0pBEy3VkHVIMSrZC2ZXgF61tvRoV+DhSnQdXobdr6U/bk+GtQ
	Y3Tq37I1kFhdjLuJmRH2908jkwgejLXMv+WW6VzAiDIaAfpLtwWGpAQ1
X-Gm-Gg: ASbGncuVqOWt7Xrz32ibryqShzn+AMINPJFeQEWL6wUoUuP/xXOI/mMUwr1cQ6zsQdD
	Q5Li7Gbwt5msYkFGjV1atuZFx94gdsEm5smyjsXwzu9gwyW8ccsa6fF6fW9JrIugEmhFi42XTp7
	woy061jcV9PpdyCATQCBJJEiccrU9nP/lcTgx0BMJn0UfFtUpHwv/JsXFdbtLss8pcaAskgHsJf
	DqvZd7E3OMUpfB3zgyJynl0L6Mw3fjK1Pmt3kA3igRV2qFHpAlkIajUawqw9IuIkJPM9FJogQ/s
	yDAcZk0LPqdMksdDhclsq+tHEZjK2Dw4QMGeVwOMYUNO8SGjSJ5A8bD0bft8OsZKD3M4UR5q9Jk
	o5bayMqKm7gqvY9kSja3PtpuuYQeE8KtTxb4ZFg==
X-Google-Smtp-Source: AGHT+IHZI/IIgnxTd7WLW/WH+T/NiSsc0Cr50QQFVHQqbXaxpsNFHDaZQfkKSMlzB3+s5Li4oKvOoA==
X-Received: by 2002:a05:651c:411a:b0:32b:492c:5d10 with SMTP id 38308e7fff4ca-3305343e596mr4340301fa.22.1752224830459;
        Fri, 11 Jul 2025 02:07:10 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-32fab91a64csm6235321fa.111.2025.07.11.02.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 02:07:09 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:07:08 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	ben.copeland@linaro.org, leon@kernel.org, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not
 using the IOVA mapping
Message-ID: <trukrims2ubfcf7j7po4qhfpcceb2hbs3jmj3triu4jgex2ips@oqnk54qyrrtb>
References: <20250707125223.3022531-1-hch@lst.de>
 <m72dvfp7wmycwghaaa65zs5adkzylsdtnk4smp7rdfgrsdw443@ry2laobzym7d>
 <20250711083251.GA6931@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711083251.GA6931@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250711_020712_859777_95128D75 
X-CRM114-Status: GOOD (  14.35  )
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

Hi,

On 2025-07-11 10:32:51 +0200, Christoph Hellwig wrote:
> Hi Klara,
> 
> can you try the attached patch?
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6af184f2b73b..ac3b90d31380 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -745,7 +745,7 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>  		return true;
>  	if (!blk_rq_dma_map_iter_next(req, dma_dev, &iod->dma_state, iter))
>  		return false;
> -	if (dma_need_unmap(dma_dev)) {
> +	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
>  		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
>  		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
>  		iod->nr_dma_vecs++;
> @@ -763,7 +763,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
>  	unsigned int prp_len, i;
>  	__le64 *prp_list;
>  
> -	if (dma_need_unmap(nvmeq->dev->dev)) {
> +	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev->dev)) {
>  		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
>  				GFP_ATOMIC);
>  		if (!iod->dma_vecs)

Yes, this fixes it for me.

Thanks,
Tested-by: Klara Modin <klarasmodin@gmail.com>

