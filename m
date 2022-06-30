Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8EFC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 20:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9JGRYdL+NhBmDdxP0DtJXAMH0Xw0VEt3PcBHxt+iWhE=; b=GsxmeQ+ZVl4mqqo50wilKySTmJ
	8v12EI1P5xqICSBVZYHLxXcx9+nW+6qtlA0dk4lYExTT78Ff623od2lt7XaVek2E/9iH9PV5xrlSv
	NuMnOa9+LPqynjr7EBHC26Cl/NNFhdEreKta6g36hovpCNvQneaAREK6qkdNed1a4JgP5JSjbBvuw
	cZ+Pmy6UhyHTQAIdr9xJJhViZQ6K9HF58oP/ZC/ZV5JUPP1T+jIesoBXwQ3cmFqfOC5P58HPd/ggy
	fCFe4uxIE4eWoEU4B8hIdwTHf6nmUvwLiIY3ZrsMp1aluhT1ws0Oq3gpMpq7QO7jMC72pH8r9uQYA
	qHREaOGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o70aX-001Ngx-9O; Thu, 30 Jun 2022 20:16:33 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o70aT-001Nep-5U
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 20:16:31 +0000
Received: by mail-pg1-x535.google.com with SMTP id g4so399425pgc.1
        for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9JGRYdL+NhBmDdxP0DtJXAMH0Xw0VEt3PcBHxt+iWhE=;
        b=U4VwhHgWpLYbo1yfhPVQYypekxNNnEGuOM39MrAR9tkg1SltW/yMrcL+tHOb19/5Ld
         U/uBofEPFhpyT5K89997+zTpHQ5hX/fT89PzFr0/T8qk2YraR0QsVV2WyweYsSHzdhjV
         fXPtvlVryE/DgGWZfQPZ3hpc3RzzHwwHzShjd88g5TwXjZqt4w9Ii5J3G3YTOGjXeiuZ
         GQQYLgI1bEe0Y9r7QDshAARZHioszMPiKSttRie9LhXN7bxHAkakbXC6VUoUbACwDt3M
         8D5I36plM/3/cAd6huDtkkvDdPEhMsQv/Qg8JKR3nuW5rXOm2D698SlpKQEXDDAl4CjU
         QYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9JGRYdL+NhBmDdxP0DtJXAMH0Xw0VEt3PcBHxt+iWhE=;
        b=EgKv0uVDz9kQR5oPsutdUgn7oxP0hAGbGVf4+b5ts5z4U+lNCV/8TQMolJ6Q+1npxd
         VJJLR1XkK1G2ciPJaZuwkzcHVNMrxunZtNbslwL6y6VbS5LW8oEZMocSdvlogSHovZP5
         TnnGwZDMPRN6VMvoqfyRBnD1Jf5LwVFB4RA/9HSgsyWS11N74FKWKxQ1e1266UcDz3Sy
         qGrcNeJVG8tQae0LfO1Ja+RLCKtdnfmSTiOJed7Ks+gvel6ogwbMeU8dEkUVL1QpkdnZ
         FiNYyjZJ/KfW4+h+tAojuIhja0/1a7+RrwAjViL/F6BglGBVKN6e7xWOLEDWYgEiFjaU
         gyjw==
X-Gm-Message-State: AJIora82zkRB9OWO94VPBF+cVqwPgsC+jKKfdjelmBEtXyqtlOwg0L1a
	FApEhuClHINnMQdrQ9VNAQ5QHQ==
X-Google-Smtp-Source: AGRyM1vlDQn9cUzTQTt5cUwURyDkBcN61qK5SuSsmMxNNVX03FweUi2PyEwMtvC53jflfXsY/iBXKA==
X-Received: by 2002:a65:6bd6:0:b0:39d:4f85:9ecf with SMTP id e22-20020a656bd6000000b0039d4f859ecfmr9392530pgw.336.1656620187287;
        Thu, 30 Jun 2022 13:16:27 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y11-20020a63de4b000000b0040c644e82efsm13705811pgi.43.2022.06.30.13.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 13:16:26 -0700 (PDT)
Message-ID: <a0fd82a0-f0fa-c9ec-cd55-b6db6b60f326@kernel.dk>
Date: Thu, 30 Jun 2022 14:16:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <Yr39dC2Hf2/LtgXq@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yr39dC2Hf2/LtgXq@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_131629_245137_46683F84 
X-CRM114-Status: GOOD (  12.21  )
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

On 6/30/22 1:45 PM, Christoph Hellwig wrote:
> The following changes since commit fbb564a557809466c171b95f8d593a0972450ff2:
> 
>   lib/sbitmap: Fix invalid loop in __sbitmap_queue_get_batch() (2022-06-25 10:58:55 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.19-2022-06-30
> 
> for you to fetch changes up to e1c70d79346356bb1ede3f79436df80917845ab9:
> 
>   nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA IM2P33F8ABR1 (2022-06-30 08:24:33 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 5.19
> 
>  - more quirks (Lamarque Vieira Souza, Pablo Greco)
>  - fix a fabrics disconnect regression (Ruozhu Li)
>  - fix a nvmet-tcp data_digest calculation regression (Sagi Grimberg)
>  - fix nvme-tcp send failure handling (Sagi Grimberg)
>  - fix a regression with nvmet-loop and passthrough controllers
>    (Alan Adamson)

Pulled, thanks.

-- 
Jens Axboe


