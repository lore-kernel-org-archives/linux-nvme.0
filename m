Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBE0C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jgnDNASof/g3kUSSX5icXdxlDgaWwUplvsCMn1pF5vM=; b=AWy28WRHJELlXi4a9GZDLHN2mz
	b8D2l0npjcTDgPEYulpcnbvf7iP4If9IWYzIIEmx5xio4ljiePBbACQBUAGdCfykqbX1JNAunrCTH
	3e/NfJSjsrNJTtKFuYTOXU7q46Tklafj4dqgTdh4fhJfwCz4Jy5jJpcdr8fGU4CHZ38rIjLCfpseT
	SCuFSvWNrlZ5AMSLd/la3CmIZe7RkATsWRAqRe3cAGP5FUTT0Vmo0lxEkNPL7oq/5VgjRNCZl88kp
	DGb4iWSfWOd1pDbZaAee0gvoVZJX0SKfilQ/tvxN++V0lPOm/q4yUvHkVnJ72GhFTLtXHydiJGA2P
	n0hjBPJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odv6r-003lDi-MH; Thu, 29 Sep 2022 15:05:57 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odv6o-003lCA-QV
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 15:05:56 +0000
Received: by mail-pg1-x529.google.com with SMTP id 3so1716537pga.1
        for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jgnDNASof/g3kUSSX5icXdxlDgaWwUplvsCMn1pF5vM=;
        b=JKBVyObYGRAOO4ywPCjymTsySSakqkGw4waL9JKUdqf0SMohmGWuMTTBmLcYp3jchM
         qVf6VGEwYD1B2crtpCBsCnbsJhVyMY1DFCc2n+BNyBIJg6inrzcPouCwkV3waR5XR0W/
         rT3lA0gxdMhZKER49g29N1jEskq9SblBQTksO0Zb5ya6eQMq2L3nQGU+1a5Rg1aatI5A
         tYOpHtQ27ddm2/f0HOOUjWaG8K7ZYD4N8K00QzrXPLlpY5Id3khDKqI7MeHXCJStonUq
         Odsj0OmORM8Q3Q02Z2IaYLusLR7UNv0cuOHNFHgKT4VMfFuz/vcN4JN+1sNO1OReNkav
         tivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jgnDNASof/g3kUSSX5icXdxlDgaWwUplvsCMn1pF5vM=;
        b=brHJbG2s40FIjUwpH/5F56XRKo2DfgLtbxGhfqgsf+FHsiZTg5Qx/fYbAC0NsNANX/
         gx2fQTXkAOcFTKQE1HsyQyhiTlRRPLZKJDOgturQyaNgAZlG6wfc57QA9wYzXpZSaGfk
         7uLAmtBEyWEv7tdAcciLmoRPG8qf3Mvffzhco6Ipm7cQ01cdEglNd4DuL1LAOr0YYauA
         482SYAFDXld7/Wrz+BsRBaoiTFGFINmx9oBwq9LMJfb6XKyiAfrpB4Zh5rpbOkj4rxIO
         I+sHOCZeVwtDQEyEp65Q9nnzx1uM4EirovhXHJk1/fN1Mwo5Ef27hHyMDOqRi3kowP/i
         kzSg==
X-Gm-Message-State: ACrzQf0ntzMAOcUZs7YycOIiFHW2uhTBCw9QvFbXPYIzRxINx5tOvzb6
	OCo1NcNCLXLKTekHgbZ4iY5pPQ==
X-Google-Smtp-Source: AMsMyM41XNEMrU48oiar1bH4MmONyZw4Yx23PNT3LPamAbK93khCZlOEW5+ehLdXeXaxwJbhGqnvYA==
X-Received: by 2002:a63:590a:0:b0:439:6e0c:6381 with SMTP id n10-20020a63590a000000b004396e0c6381mr3317699pgb.141.1664463953462;
        Thu, 29 Sep 2022 08:05:53 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902bf4200b00178b6ccc8a0sm6027002pls.51.2022.09.29.08.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 08:05:53 -0700 (PDT)
Message-ID: <04b39974-6b55-7aca-70de-4a567f2eac8f@kernel.dk>
Date: Thu, 29 Sep 2022 09:05:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_080554_883475_305A141C 
X-CRM114-Status: GOOD (  11.14  )
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

On 9/29/22 3:59 AM, Sagi Grimberg wrote:
>> 3. Do you have some performance numbers (we're touching the fast path here) ?
> 
> This is pretty light-weight, accounting is per-cpu and only wrapped by
> preemption disable. This is a very small price to pay for what we gain.

Is it? Enabling IO stats for normal devices has a very noticeable impact
on performance at the higher end of the scale. So much so that I've
contemplated how we can make this less expensive than it currently is.

-- 
Jens Axboe

