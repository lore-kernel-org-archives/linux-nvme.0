Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DF4C4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 13:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ScAb/G98utGY/Ri5BRIKKvQo6kiX6XyD6LkBEbj7PMw=; b=pUv9VnhKm6vf6RKQVNSjAOp8LC
	Xvf2dbCqYfjXXC8sdweyvzqq2YejhBO7Te7FrDiKxH4Lzidfdog6/19/cEonMXXvHrIsok+JT+ZTI
	cGJP4JhH8bS1ui7c66708miELjmRD/t9js2df6VK9Nchox8/d5CqzbLVJRzV/etA+pxRyWobpkBbc
	4tqyODeIThvmWpdrlfoCOAIpLiUBXN5FFI3rnb1tA7xgLdtIpdNB7Hp2+lmguaD5yUwNZesd9/AGj
	lms3Hj9P0l78/y2ct6+Q70iTJEvfHNekEB2JcUKYWe6QFtyN3uJUtbB0fUaS/hZ3A8abwnjTCgzUL
	7IxYouAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p015n-008zsU-8Y; Tue, 29 Nov 2022 13:56:11 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p015j-008zqx-Uq
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 13:56:09 +0000
Received: by mail-pf1-x432.google.com with SMTP id l7so11281060pfl.7
        for <linux-nvme@lists.infradead.org>; Tue, 29 Nov 2022 05:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScAb/G98utGY/Ri5BRIKKvQo6kiX6XyD6LkBEbj7PMw=;
        b=glLiVxZ+ODnLngOEu3a8LfcfPb8IcvT3sKH15iWaap7xKRd/1pewlm6GFUrKy0I/BL
         BSnYsEpq/y9qjrKO9XTsBczR1V+gJ9VAauMUeUzHNM/xxNJRg3YGXUmlGy00SbRVoSg7
         fgsFFKEuc2uynCF/RuLN6PMzTK8wIPD9X1x2KrcrhLdbrXIi73Y86Vw+fjRiCRzEGsFw
         km0wQdzGkhEdgkYbZKIvDmZ4aMKELq6ScsIK+F+wywnTn9WDd91TUFSrGwGpbo1FjVD+
         TmfycIEU9KWSGNLz197UP04lZpqnrVAHEKHsDfPp/3itc+shfH0c/HueYUpVwoqgnaxN
         FrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScAb/G98utGY/Ri5BRIKKvQo6kiX6XyD6LkBEbj7PMw=;
        b=vpqdkiKZVqzIeXH+Ka5dh9jcCNODh5NPt6Z9kJLGhacA9zDoDx+XAzhkSbX7Qk1fCU
         2Qyr6O55sQs9swWGAC+owUfTn3AaEBs3zuHu7fRIJrNST5PuCwcBbDcukxYY4bmZ+yBW
         dvn7W2R5+H6hhzVcGuSpP5lbWn81d0skerP1kQgTuQudPtwdPx4T6XWCnjbFGKphSqyB
         IOSzcORmqlhejprauqPoRXE8H/JXbbOmQLH2yXOLBgkVv7IFjEBj/7GCrXs1iADojVSU
         R0QHcYg4rPjcDqavWqK/rpXZ8C0kYJhaKlfZgtmcthZJSslBy5YRVAjCNXpCFiJQl19k
         5aEA==
X-Gm-Message-State: ANoB5pnJG5fNqE4ujV8cPc50vKmfWN5Ok+sROIG55OJe2nhqyGXcIyfd
	xgOyu7VG1P7LXMBCpul0rSLNyLkmwS35jacb
X-Google-Smtp-Source: AA0mqf6dwR7YBNnOfHAbN4yoR/g74vSRx8Es33XgfcJh88vjkfCizuYJeROGkh/I/igM5gw3U/wVug==
X-Received: by 2002:a05:6a00:26c8:b0:574:c159:ce3b with SMTP id p8-20020a056a0026c800b00574c159ce3bmr21160653pfw.74.1669730166584;
        Tue, 29 Nov 2022 05:56:06 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x129-20020a628687000000b0056baebf23e7sm10302195pfd.141.2022.11.29.05.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:56:05 -0800 (PST)
Message-ID: <ae390dde-9041-4f0e-337f-410539727272@kernel.dk>
Date: Tue, 29 Nov 2022 06:56:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [GIT PULL] nvme updates for Linux 6.2
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y4XJPNP74KmdI8+7@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y4XJPNP74KmdI8+7@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_055608_203065_EDB37718 
X-CRM114-Status: GOOD (  15.53  )
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

On 11/29/22 1:56 AM, Christoph Hellwig wrote:
> This is just the first round, there is quite a bit more in the queue.
> 
> The following changes since commit 5626196a5ae0937368b35c3625c428a2125b0f44:
> 
>   Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.2/block (2022-11-14 12:57:50 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2022-11-29
> 
> for you to fetch changes up to 68c5444c317208f5a114f671140373f47f0a2cf6:
> 
>   nvmet: expose firmware revision to configfs (2022-11-21 08:35:58 +0100)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.2
> 
>  - support some passthrough commands without CAP_SYS_ADMIN
>    (Kanchan Joshi)
>  - refactor PCIe probing and reset (Christoph Hellwig)
>  - various fabrics authentication fixes and improvements (Sagi Grimberg)
>  - avoid fallback to sequential scan due to transient issues
>    (Uday Shankar)
>  - implement support for the DEAC bit in Write Zeroes (Christoph Hellwig)
>  - allow overriding the IEEE OUI and firmware revision in configfs for
>    nvmet (Aleksandr Miloserdov)
>  - force reconnect when number of queue changes in nvmet (Daniel Wagner)
>  - minor fixes and improvements (Uros Bizjak, Joel Granados,
>    Sagi Grimberg, Christoph Hellwig, Christophe JAILLET)
> 
> ----------------------------------------------------------------

Pulled, thanks.

-- 
Jens Axboe



