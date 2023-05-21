Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F61AC7EE23
	for <linux-nvme@archiver.kernel.org>; Sun, 21 May 2023 01:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L2w83OsVlpFn7pAPig0LxFv1PaaAzp2pM0zfdrQQzs0=; b=R4z+NP+ZYJSSvra6QYDCCfbpBS
	5liGFliwSEcFF3CbXSyTG8e187jFLR25WBUi9Q2b9yQ70+SF0z9XCsxTxdIygCuYwNNxmCu0Pb7OY
	9NZKcbBVfYhkpS27d8GP/QX11NPWfzOO0HflyWe+KQgwvGnFZqoG6ex6mdONoWTyPlHL8tj5wfcQ3
	AUtJEBDOOW6Ha99fSAhi+1gS7lcyC+eeTEqYL5iyK+Q/JGxaeAKvuiN6Z0u9NYSI00bpm8Bn8gkgb
	9OakJzFjTzkMmqfwuv8ESYd1vf7XhQf29wwsDECe92zpceIwTK3KQ48usuoWMrkDK1eBCHc2NgR20
	KZOnmzcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0YBE-002lxz-0l;
	Sun, 21 May 2023 01:48:16 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0YBA-002lx5-1W
	for linux-nvme@lists.infradead.org;
	Sun, 21 May 2023 01:48:14 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6439bf89cb7so345821b3a.0
        for <linux-nvme@lists.infradead.org>; Sat, 20 May 2023 18:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684633690; x=1687225690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L2w83OsVlpFn7pAPig0LxFv1PaaAzp2pM0zfdrQQzs0=;
        b=OTUT5iVs6ET7InyC7VkbAVJir1+jgJ9NfRBC4CmVQLVjgsB5T1WWFjy0zih/pawcq1
         0DmgTPHtXTTrmZoIOeSnX5uC1B2pWoWFheDgEQ9BkYhgcntJmTB3RLVLkadA3WtW8xai
         /jA1vaDVgNEtXv5zz0CiK+E+5/Ic1pJ3E0EjrPNrdoZJNIEJgrfC7h+RlQ/8fam61GIj
         Zf7d3rD3/+QP6NTuxGO4iP7OhtQLO8ildWjYjUi1/KIfio4sV5Y1YypdYM0oZlv3N4wA
         dqFNwZQozQ71eARXJr4efHJ+PJAwrmoIXsLJQkANXjgXeby98MCB/nYsj1fmc2f86t7v
         oYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684633690; x=1687225690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2w83OsVlpFn7pAPig0LxFv1PaaAzp2pM0zfdrQQzs0=;
        b=ZKwQwvsVscmO3SJJB1aRaHAMy5G5/srnDaSDeXjfsQfidaDgzIQoTNiFpYkIBbcvap
         jsY5eGvIieeS/opM55TPPsbpz5W8Ix/ivJCP6OVcVvsCtXS5B/qfFbqkuFTy9/S1tIBm
         q3AMR1q1Qt0yoJcM/E9jrV6KgUS+/VEaVQv9Rq77iIb6cobo5OBgzDMazbmS0TeSE/JG
         sr2zndyWevNhP4H7y1VsiFrdBsjkoM6OKp2iL22NXC6nPLsPi2tOnxFlo2aW4VhPpivN
         XgA7StMPGbJTmUgbTo0f27wva3OsgCxJpr2HpNNOSSK/pXgu0eMh76B6ubH0qM1TLznQ
         +1QA==
X-Gm-Message-State: AC+VfDyiepyL+nTGNinq4BwARM1ix2s+OOsvQVGoYbgJQIOYML4HauMT
	rgKlS5094c6A01CwdZVPhTb17w==
X-Google-Smtp-Source: ACHHUZ5nJy9g0E565U96ldJavYaYzc95fUuByR1uor3i+1o1wg/Sizi2Ummi3WvL4nOUVtsM/VIBnw==
X-Received: by 2002:a17:902:c948:b0:1ae:7ba2:1a7e with SMTP id i8-20020a170902c94800b001ae7ba21a7emr7761691pla.6.1684633690173;
        Sat, 20 May 2023 18:48:10 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g8-20020a1709029f8800b001aaf6353736sm2152428plq.80.2023.05.20.18.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 May 2023 18:48:09 -0700 (PDT)
Message-ID: <d49afbae-4ce9-5c6f-a1ad-d07f14f2f2b7@kernel.dk>
Date: Sat, 20 May 2023 19:48:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvme-pci : redundancies in nvme_alloc_queue and
 nvme_init_queue
Content-Language: en-US
To: Irvin Cote <irvincoteg@gmail.com>, hch@lst.de
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <20230521000236.100402-1-irvincoteg@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230521000236.100402-1-irvincoteg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230520_184812_729236_EED14CAA 
X-CRM114-Status: GOOD (  15.13  )
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

On 5/20/23 6:02 PM, Irvin Cote wrote:
> Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
> ---
>  drivers/nvme/host/pci.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 32244582fdb0..49ae26980a0f 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1533,9 +1533,6 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
>  	nvmeq->dev = dev;
>  	spin_lock_init(&nvmeq->sq_lock);
>  	spin_lock_init(&nvmeq->cq_poll_lock);
> -	nvmeq->cq_head = 0;
> -	nvmeq->cq_phase = 1;
> -	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
>  	nvmeq->qid = qid;
>  	dev->ctrl.queue_count++;

Please put an actual commit message in here, any commit should have
an explanation of WHY the change is being made. Your subject line
is NOT enough, detail exactly why this is redundant.

From a quick look the patch does look fine, but I'm not going to
ack a patch that doesn't have a good commit message.

-- 
Jens Axboe



