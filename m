Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59360C77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 22:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TTdHYZiyhUIZRmQ86+NSUVyJw5qozVR7VPPXjKj67Y4=; b=Hue9oV2x65VSbj9tJqS1NV8AMt
	gnKCIdhA7+bWgvgKnC3n3PGnqDoQrOUIi4xTuHUwM4HWjUDxOAa0vGi3kYifVjIUIBULzA7X8wW0N
	gKSl2hCckEFOCMwCAdUKl3jft+jGZq4JZwNmrAqP4OcaaXvqMk69cV7CgiYk7iyDXN7531+qxVBQ5
	StZu/iA2LQqdlXdqqbsU2f4oUzzX80w9jwwGdiv0MvHe2hyJJYuVqk7QrgTqQ05x8TazlTZY3NBf3
	qcUs67KnOJPN5mnQKx92yfZkXlIlZzIWxyojsy7n70aLc9VHGfSO1VXEXUr87i7nvfaSVFub5cK7R
	lvxafzvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psAT9-007jcc-0k;
	Thu, 27 Apr 2023 22:52:07 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psAT6-007jbg-1H
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 22:52:06 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-517f1d5645aso1488820a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 27 Apr 2023 15:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682635921; x=1685227921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTdHYZiyhUIZRmQ86+NSUVyJw5qozVR7VPPXjKj67Y4=;
        b=JXiF8hOcwzfAHwUQA05RmKlam4Gq9TcWWIHPSYwfF4h8fVYDtA0TZgR32Tv2XUlpFw
         PLXqKZiRDqeLV88nGuUuRJlBxS4y/7RwELvEtywsXIHzJXwbyIk2yrnLSKRZJpy4h01L
         yR2He/tHYADcwZTl5rCm0WqeYG7VAa9VwUBDdxrMSA/RSYl1sW+EouaFmbULzzl/qxZS
         AGDGHCPg/i/xc9ncVV1cRgAgmUu8yX/G15Glocbipoc8kY7EEC1MtaG4NvqVV4PMnOdE
         vhol51SGDucaBp/8XmiXf9dawk7O7uAa+rBBDXNKI9Yksg25dcA3E4a3b9Kooml2Y84Q
         WdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682635921; x=1685227921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTdHYZiyhUIZRmQ86+NSUVyJw5qozVR7VPPXjKj67Y4=;
        b=c0iBN0Wr2ACOKvWrNkrethBWw/yKW6+RiW6j9g6Dt/hY93x4vQBTv6esH8ms8zM9Ee
         pU78M2PnHxfCDtGyVSQYUfDUXqL4/hwGdf/JvnfjQUuZKUrwZjhBWYzI2eYu+FEfUara
         rqFpBpvVJxU9FmaKUah4386V95dCCzR31+MHt1ht2mFv1ZnZ+Oq6gsP7Cj1GREC2cgsH
         3JYDbgTG3ehE8yrzINdhdkqlflfmCLRsycvVRTSR9DDvQre8l/PzCeG1ZK/sY4ASkesd
         cynJb+F9hdo0ezEfIIu8LPSpcJ5kxV90ENF+2d74nrZQ1+MwROyrWYJPw8u7mWjlaPI4
         0TYg==
X-Gm-Message-State: AC+VfDwGxRsgiWyAQwQ8tQqME8fLf2UX0DV6I5Iacx+LHprYu6ST9i7b
	wUDsBvoTvRgJQ/pU2RURy4lFyg==
X-Google-Smtp-Source: ACHHUZ6abgkT7mDxxsZEoKOx5wECXIfK1pUTWL3FPCvuM6eUUIYkUzZIt/mIHvWkr5a9RmBDZpwcdQ==
X-Received: by 2002:a17:902:ea10:b0:1a9:1b4:9fdd with SMTP id s16-20020a170902ea1000b001a901b49fddmr646043plg.2.1682635921395;
        Thu, 27 Apr 2023 15:52:01 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r21-20020a170902ea5500b001a988a71617sm5380578plg.192.2023.04.27.15.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 15:52:00 -0700 (PDT)
Message-ID: <f9b06711-6d3c-2271-b2eb-13ab4e8ec040@kernel.dk>
Date: Thu, 27 Apr 2023 16:51:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_155205_063944_050121BD 
X-CRM114-Status: GOOD (  12.89  )
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

On 4/27/23 1:47 PM, Christophe JAILLET wrote:
> Group some variables based on their sizes to reduce holes.
> On x86_64, this shrinks the size of 'struct nvmet_ns' from 520 to 512
> bytes.
> 
> When such a structure is allocated in nvmet_ns_alloc(), because of the way
> memory allocation works, when 520 bytes were requested, 1024 bytes were
> allocated.
> 
> So, on x86_64, this change saves 512 bytes per allocation.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> More aggressive grouping could be done to be more future proof, but the
> way the struct nvmet_ns is written suggest that some fields should be
> kept together. So keep grouping as-is.

I think you did the right thing, that move doesn't matter and it brings
it to pow-of-2 or less and that is really what matters. So looks fine to
me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



