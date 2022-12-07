Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44378C352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vY3sTW09olG5iwk17y/KR4D0PYJv7DXQwuDqwAnD9N0=; b=xVceVYR1/CtqE6uaWkD2SWn120
	4PJCgkIE76lnmyZXU63yI5P/KYTePc3YFFR27n7rjxL7naU7yqdNneMej5CWpfF8aF2bwK53lVSyg
	cmfHsy+7i0so2DKCUSII21uP/PljVcm+WUIGAvsbtJzYyTvjN4POQzKZnfCOtzkFlqj2/4mY1BCqp
	xauAVEjACtqY8RVxA5++aq4uEf/Anu70dCRsrIK9ZPXWGNJsm67dKD1aTYBcBBrJvRoRytVyWnOeN
	+qE2UmsDeBmJJJJiqx+BhwCrLinxfwOedh7bTr9ff4vYKD34xXH2y7YTbDSz5LlWIZ/REtWCbg/7C
	ROAlaF/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2wmA-006F61-Ci; Wed, 07 Dec 2022 15:56:02 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2wm6-006F0k-U5
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 15:56:00 +0000
Received: by mail-io1-xd2b.google.com with SMTP id n188so12011025iof.8
        for <linux-nvme@lists.infradead.org>; Wed, 07 Dec 2022 07:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vY3sTW09olG5iwk17y/KR4D0PYJv7DXQwuDqwAnD9N0=;
        b=NkggO5F8DoFYdKtn1k6ejKKSlg5bK57Iwa0ddvFWyT325M6hyXtfDm1Wq0TXYtxPBA
         nwhAnxfhlCOrGL/Sr86Nl845ukAtYsvSBAY7lsJcm9zC15xloOrjhgpKLQHRjYO8BH3Y
         iTNfn4ocRb/MGgmXS76CgXifN7frB1m03xDcOLWSjW+ROzDb5QDzNZolr4nij4rIBvzf
         QgNN9NV+FmuUZzi4a5vEgH5IoGTaTy35U8nBYvJw4mrXWs4Fc5qHnnmNGmLXuETGfoqN
         ewg0fG+MeqjhmxOTaJyFzFXwKtoFwb8+7S3oOjQg9vUXIeCGK2PYQgiq1fBSbgWK9h0e
         7dnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vY3sTW09olG5iwk17y/KR4D0PYJv7DXQwuDqwAnD9N0=;
        b=kZYTzbVa1oL21mJo4r95sNWZugvvU7X1kQGb7Z8EoyTb6klrPGWRoIh0kGnuh/HNy3
         FsnqSFqzk073jntIqKJmSH0auYO6QwDw7vDfe6nNrbClxx6bp4ppQ99DT44sThirsn5E
         8R+1sa5CyhTe6Wk38ae2yQfw/QUGyBU9iN8URNbyh/YKYAI3XLMGGp3jKKs69U7PEiqp
         ahy+35tbB/FNvEfSRSe+bIWj11v682a/oRV967dSEelgo9vdKfKb6anB4cR+pPxo4a8N
         llnZMdK7rYtuqgJvlvhtT06e5ieA485GzSdRS08yoRr5zLWMZZiRvvvi+9t2Mt9C4un9
         5Esg==
X-Gm-Message-State: ANoB5pkRXCw19JrqIvxmC8iBk0wT4q9pW9ynr7CG8JzAl4He6zOIlUx4
	uOggJEXghhOaq39tPUJVhdcePQ==
X-Google-Smtp-Source: AA0mqf581SVve8KUfSOdCN+l1E4b+gi1ZlHBtixl5dJR3Q6aRCQATAq1lSIK4Ft+p/OfTVGxc59MpQ==
X-Received: by 2002:a02:7164:0:b0:38a:e96:862f with SMTP id n36-20020a027164000000b0038a0e96862fmr13427756jaf.214.1670428556311;
        Wed, 07 Dec 2022 07:55:56 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u188-20020a0223c5000000b003762308fe54sm7780959jau.93.2022.12.07.07.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 07:55:55 -0800 (PST)
Message-ID: <a3829d8a-9db5-d92d-7e41-dbc59e092e38@kernel.dk>
Date: Wed, 7 Dec 2022 08:55:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.1
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y5CeoZZcOCYaS/P9@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y5CeoZZcOCYaS/P9@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_075558_985936_270A773E 
X-CRM114-Status: GOOD (  11.25  )
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

On 12/7/22 7:09 AM, Christoph Hellwig wrote:
> The following changes since commit 899d2a05dc14733cfba6224083c6b0dd5a738590:
> 
>   nvme: fix SRCU protection of nvme_ns_head list (2022-11-30 14:37:46 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-12-07
> 
> for you to fetch changes up to 6f2d71524bcfdeb1fcbd22a4a92a5b7b161ab224:
> 
>   nvme initialize core quirks before calling nvme_init_subsystem (2022-12-06 09:05:59 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.1
> 
>  - initialize core quirks before calling nvme_init_subsystem
>    (Pankaj Raghav)
> 
> ----------------------------------------------------------------

Pulled, thanks.

-- 
Jens Axboe



