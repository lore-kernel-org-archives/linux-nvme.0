Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B05EB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jun 2023 16:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=USMBdRT6x+ec25pHkFR/BKb0s+Tq00JvCoTRn4D4sGs=; b=xjjxJqpe6MbRiRG8Ff1NBvRCZm
	33TRUcgfuPjxDq0UkW39PXMy9B/DfJ0mWMbI/EVP1E9Gc5uOAXkA58pN9XL6eKBpPVX+eCdtZNKnu
	2nYc0wtafqDlmbuPK6FAi1mlcZZ0d9ZXQ8CKcOhSTVutGlqwDdok4rHI/utQuioVeenmA2x1haoIt
	EdONfHW6DZvVcm1a83lFpm/whwLyDgowMafj8botI7w09rb+FhqjxjR/bO+iZw1Pn3KdhRo0N3WRe
	V7U2zsv65mXfFWKrjnUVC/TYl70/SlcWWUyJ08FS4lcmL2Eo0BiKdelPrtSGciI75+9IZKXftPocf
	/AgwHzJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qAC0N-0013Lf-30;
	Fri, 16 Jun 2023 16:08:55 +0000
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qAC0K-0013K6-0v
	for linux-nvme@lists.infradead.org;
	Fri, 16 Jun 2023 16:08:54 +0000
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3420d8ad7feso235045ab.0
        for <linux-nvme@lists.infradead.org>; Fri, 16 Jun 2023 09:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686931729; x=1689523729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=USMBdRT6x+ec25pHkFR/BKb0s+Tq00JvCoTRn4D4sGs=;
        b=Qsrx+2F2Lfh0FRqcqUyX1hTOKKJ2LYvZynSG2elB+xwnJezHIRtLbslevJ9m0mpj4V
         uC8nkpYDo1WXz+sotemCnhobADPENHdvFaIp7JJ7qRBLqtaGQYmOd86e0gseHqin4Jve
         Sp/d9pg3fjUtkUmo+40c6Esx/oD41POSOeJghMZNq/5ciR7T60pj7aU81WobuDaLqzNY
         C59FWR47Q2E3BF8eBizcrbsTDHXbLg58TW8ni5Gvsi6XUWlHOqUPe6IQ6SUUl0KPDiDY
         fcTZTXxusKpVeEju8nyAIRH1ZM/nKqi2UhEwNMry8Q+jBtclwWsa1gVgeagCC8mKv6pB
         h1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686931729; x=1689523729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USMBdRT6x+ec25pHkFR/BKb0s+Tq00JvCoTRn4D4sGs=;
        b=gdQofoXQqE0v71h5QmPHiF2nzWvc7rn7oJW1Tz2c7FF/VZcVBqPT5GuBspWSVXU07z
         ckJAQk3F4eHlK3ErlZAPEtVQxVLBthcfPIinNQQvMQTTVphDzInniuUnuePCoEECcFbc
         0ZbiYTBvZHvTQjNcsKLJn+uLYuo8k7hzq/aCyzF3DqnZ/QZGiEDDRSUDTl/MeWW8AIZN
         p7X9VVrFKmU/5T7rCX2wBkzvcjGcMiLpae6NbJht4+ohsjikgHudXito8t76CU7debrz
         XiPZGkobFdPVG77uidw6VwYU1aZPbIpkMh4aMOUiV0y5CYscS/jOzXwcZDZ1iRbLLHOg
         IUBQ==
X-Gm-Message-State: AC+VfDxk2kZEa4leGz9zcCNYp/fMUwSy/aG96f1dUu/GxqU8NJJwS+8U
	eD744/NebOfXb6q6sRgwcO8g2UjdgMnjVb4ZdHU=
X-Google-Smtp-Source: ACHHUZ6G9rbA+b6Wfz1DyaLA8ALfoKn3tApHKqZ+xhxHajFfj0WDJ0/PZzgZAgq7AAQiW5UXqjgapw==
X-Received: by 2002:a05:6602:1508:b0:777:b51c:6058 with SMTP id g8-20020a056602150800b00777b51c6058mr3884896iow.2.1686931728948;
        Fri, 16 Jun 2023 09:08:48 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m1-20020a02c881000000b0041f5e495cfcsm6363675jao.88.2023.06.16.09.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:08:48 -0700 (PDT)
Message-ID: <5ec7a2a4-9bc4-621f-3118-054e4d841d61@kernel.dk>
Date: Fri, 16 Jun 2023 10:08:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [GIT PULL] nvme-6.5 updates
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com
References: <ZIyC1vvj9ZX7RkHq@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZIyC1vvj9ZX7RkHq@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230616_090852_327699_D7C98DC0 
X-CRM114-Status: GOOD (  12.82  )
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

On 6/16/23 9:42?AM, Keith Busch wrote:
> This is our first pull request for the 6.5 merge window. There will be a
> minor conflict when merging to Linus' tree, and the resolution is to
> simply delete the entire conflicting block.
> 
> The following changes since commit 4f1731df60f9033669f024d06ae26a6301260b55:
> 
>   blk-mq: fix potential io hang by wrong 'wake_batch' (2023-06-12 09:55:53 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.5-2023-06-16
> 
> for you to fetch changes up to 1c606f7f056b266a84482d5522d35bbbbed062db:
> 
>   nvme: forward port sysfs delete fix (2023-06-16 08:15:57 -0700)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.5
> 
>  - Various cleanups all around (Irvin, Chaitanya, Christophe)
>  - Better struct packing (Christophe JAILLET)
>  - Reduce controller error logs for optional commands (Keith)
>  - Support for >=64KiB block sizes (Daniel Gomez)
>  - Fabrics fixes and code organization (Max, Chaitanya, Daniel Wagner)

Pulled, thanks.

-- 
Jens Axboe


