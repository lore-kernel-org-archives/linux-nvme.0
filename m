Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94004C433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Oct 2022 19:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nxYOj2DA6xvjYpi+XjW859HEQbWAzDqivFYp1R8d9jI=; b=yAEHAzoz/otq6y+5gEQCzx2kXP
	NaKhva4gptGAU7M9PdAwSk2MZsIz75edMpQbAVuK2ZHDtITil1SCLL5gWuPkCxTFts7lCIFNxRp17
	34LSXPYmhM93NsPUMB3s3CF9TcNapRafvm8MoSXdZYqjBUAQhxcAj8zv+7UiEqRcaE7WvSOkwd+YM
	HZEcU6x9jszsg1LFkTNQEdrgxip4K60pQPWSElnHo7GqvTJqtZ7/mRESNQAiMKyJT2F3Ebr4fYNU9
	Zs6inQXH0PKexaCrSG1id27jHJnmwrXwy+iwq+eX8wz5tMzNycKoFfUz0AXzJd4zFYOYX18KBru7V
	h6pzemjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogtCt-00AEvJ-R4; Fri, 07 Oct 2022 19:40:27 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogtCq-00AEuS-Nh
	for linux-nvme@lists.infradead.org; Fri, 07 Oct 2022 19:40:26 +0000
Received: by mail-pl1-x62a.google.com with SMTP id x6so5402841pll.11
        for <linux-nvme@lists.infradead.org>; Fri, 07 Oct 2022 12:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxYOj2DA6xvjYpi+XjW859HEQbWAzDqivFYp1R8d9jI=;
        b=JSokHwDczc1aciacWSkMTqECkqX12cgHLtkdL/XH+82v+aKZu5/QzJZ0ecFwGkIDRf
         Z02cviv/Imk+Sr+WfKeaA1j46Qwitv8//H6u+2lhrJ+wTSk/Q9SG0uCTQKn/WieUA1bl
         5aHFKXM21gFCcUJfrFtMuiGVnEX2ReCe1zZcVgAJh5odzpNfeoHARxNS828KG8RkAq6L
         qBnyw1Po+eQCCrrudcC22x5oBN7sTXN7VxF0qvJsS7Hf4AflJE+rEO5MLC1sXWJ/XAC3
         Yt7Dc6nVwAIh1KAhf9azIkRQJmNvjSXuldj7n2i7RWPeJIBvUCs2PEBG4zbN8VTvj5a2
         0J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxYOj2DA6xvjYpi+XjW859HEQbWAzDqivFYp1R8d9jI=;
        b=dLzuzN+cJnlsF0rIV3K4GgnT+qq48Xg4jxA7gQrBHh3BVaD+sBQ3WDPXKmZQNLTfim
         8sLQcSXa5qAJ5Wpj4x42hjDU2mO+M1z2IHj55eSkXCV9SUPAR3JPZ8IyjAgmp+5g3bDL
         v7IGNOmkvHMd8bPrRvpFDIqVr9gK9HtAWrnfHsOPyDbBy36+cE+ouIspF6hxyaoBiGz2
         ckZ9N9vCX0LTNG3NN0ktqdqzCHDku1imQVwSiGRD+lc7xvVrpVW0dCYCHkB/d1arGqRY
         QI+1cr7IK92Fl6i5O+WJEL2YOc86PjVPadvbBhIwcbUCfFtHMPVlfNpLNsAaVTINAoaY
         yenQ==
X-Gm-Message-State: ACrzQf2iNGQ7Z+fIrX4XZBwk+6LmkgFdzoZF462VOUwrMOrSSCXOPkHK
	qRhh9SUsGjvR4Pio+EhHC/dFrg==
X-Google-Smtp-Source: AMsMyM4MuAQY/zX9CazcfpxFTzbqh5ZWzm+gsv6RigMXmdLqaTceG4IiqZbKufitBzYcJnpVRQQE2w==
X-Received: by 2002:a17:90b:2705:b0:20a:b4fa:f624 with SMTP id px5-20020a17090b270500b0020ab4faf624mr6996007pjb.124.1665171620206;
        Fri, 07 Oct 2022 12:40:20 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d18-20020a170903231200b00176e6f553efsm169643plh.84.2022.10.07.12.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 12:40:19 -0700 (PDT)
Message-ID: <2a79929c-ece3-3d5d-db6c-414ec22b381e@kernel.dk>
Date: Fri, 7 Oct 2022 13:40:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH 01/21] block: add and use init tagset helper
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <20221005032257.80681-1-kch@nvidia.com>
 <20221005032257.80681-2-kch@nvidia.com>
 <6fee2d7a-7fd1-73ee-2911-87a4ed3e8769@opensource.wdc.com>
 <CAPDyKFpBpiydQn+=24CqtaH_qa3tQfN2gQSiUrHCjnLSuy4=Kg@mail.gmail.com>
 <e0ea0b0a-5077-de37-046f-62902aca93b6@acm.org>
 <a7e4fe12-64f2-3164-d675-26310ac07c9e@nvidia.com>
 <7e9ce6b2-70c8-cf85-95ab-de09090db64d@nvidia.com>
 <51f62009-777f-8958-8d28-b29e64bbff09@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <51f62009-777f-8958-8d28-b29e64bbff09@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_124025_023013_9DB19987 
X-CRM114-Status: GOOD (  14.20  )
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

On 10/6/22 12:40 PM, Bart Van Assche wrote:
> On 10/6/22 11:13, Chaitanya Kulkarni wrote:
>> I will trim down the argument list with the most common arguments
>> and keep it to max 4-5 mandatory arguments identical to what we
>> have done this for blk_next_bio() and bio_alloc_bioset() [1]
>> where mandatory arguments are part of the initialization API
>> than repeating the code all the in the tree, that creates
>> maintenance work of treewide patches.
>>
>> Also, instead of doing tree wide change in series I'll start small
>> and gradually add more patches over time.
>>
>> This definitely adds a more value to the code where code is not
>> repeated for mandatory arguments, which are way less than 9.
> 
> Hmm ... I'm not convinced that the approach outlined above will result
> in a valuable patch series. I think my objections also apply to the
> approach outlined above.

I would have to agree, I don't think this series buys us anything
really, and in several ways it actually makes it worse or creates more
of a maintenance problem going forward.

-- 
Jens Axboe



