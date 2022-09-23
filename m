Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16491C6FA82
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 15:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nBzYZNxiqwS8B8wtF4j5G6kTvhawC1R2E1pDH0ol8Ww=; b=p+1LQm+A7xLOyvw+DBFVI2vJDd
	JFPjFGu0o/Bacv1rstTaV8zFX1bI7UZmIICIG+Sl2uc/FfuPOH70Grn7fjfp4fM4Ji52T5xAoKaFT
	PYdscuO3TkQOoIfb2ucwMsuz34uOHWMklqWduV56xXsQKxygUAkupOSsLiwe/howEBtLXUHSIOEhC
	uug+LEzZOBcqT1US7P155PCkPxxYJ6kF+6bFLlwUUeGqln5fpbCAK96tczqdk2sDDll8a/bnUBRwU
	0mQePVM2dsb6oohzfujGhgCT/U5EU3uflXzsWJWcWHc89D8Nc84jXwz+rGCPODK7Jktz55E1On9T/
	K4aXQNZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obkSc-004mcS-6y; Fri, 23 Sep 2022 15:19:26 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obkSZ-004mZy-7m
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 15:19:24 +0000
Received: by mail-io1-xd2f.google.com with SMTP id r134so159967iod.8
        for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 08:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=nBzYZNxiqwS8B8wtF4j5G6kTvhawC1R2E1pDH0ol8Ww=;
        b=3AqQfBjqICcqKiJzARi6Ht6xdhsQCR/4z6U3qHkqScv6uM+HA45gS2X8NBuWb3jgWz
         UD8Bgz1t4OyYKJkV3589UzKLmx/DgimVWPSEye6926Q6Qp8Vk1YQmNe82cINdpFnNtJB
         0VFuIs8p0OTxciJLSxRnQirk4BlMvqu2yCzPDFrXFfOMGRs5Vo+Ojwz/IS34FfH4a7BB
         koppDnm7VDGJoSC23AO6M0g5efy8ksMb1JoU8svDAx/JBIApYJd/PxR20rjk33p7xfaU
         xNTOplNxnzppTFfF3SHwtwm9j7du6/52Fj9zB4BpVwCqKI6JX55fYi1xHNvWUE/KHU3n
         oFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nBzYZNxiqwS8B8wtF4j5G6kTvhawC1R2E1pDH0ol8Ww=;
        b=BGOtgrNCFyIWGcW6mEpSLUAIEKG390zcwqvz8CST2AsA9HBEPtfRdgSOuG9ay//pcV
         N5kn51cqQz2Tz5edIMYTvKz1VAinLjpS2T7g9uwddyY7I6YxB4MNByj4dM01a2zKzEaA
         8JLapB6CV5h7oYGJIU/323Bn6Toz8nHkFsb2zXPd7YdjBjJLO+euUlXhLbmCXFBDp/3Z
         bQPuYmWKWhGtgrEJnXKo/qunw4LU0mQHeoRoGgkQlFIotDDyqbD+UVytzcXaIztUzJ79
         TsEyLw4DiwRSoX6HXyCUw//cJYLBVXWnPYihjZ4cb6z2+fHkCAM52Xtoj2kihdHcYrI+
         TIig==
X-Gm-Message-State: ACrzQf08wmTFau2TlZZPmI3aQPutPhJYCZMXNnQe+9NeJlYahmNVJcac
	hqDmt1/XzNeTqwZlxy8xIpa5zQ==
X-Google-Smtp-Source: AMsMyM5Tai736JME3Hle0FFNp1nDrUfTShe7bOnunKGGouTOODQqiIsYwkfT8nwAo0WOQGmx1dFrFg==
X-Received: by 2002:a05:6638:43:b0:359:543e:a7d6 with SMTP id a3-20020a056638004300b00359543ea7d6mr4886375jap.166.1663946359509;
        Fri, 23 Sep 2022 08:19:19 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j188-20020a0263c5000000b0035b0d6f3219sm3376200jac.75.2022.09.23.08.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 08:19:19 -0700 (PDT)
Message-ID: <6f7600be-d4b9-aeac-7dd1-71992a4dd5e8@kernel.dk>
Date: Fri, 23 Sep 2022 09:19:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCHSET 0/5] Enable alloc caching and batched freeing for
 passthrough
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20220922182805.96173-1-axboe@kernel.dk>
 <Yy3NyACongSfayY+@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yy3NyACongSfayY+@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_081923_285619_7043F9D2 
X-CRM114-Status: GOOD (  12.48  )
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

On 9/23/22 9:16 AM, Christoph Hellwig wrote:
> On Thu, Sep 22, 2022 at 12:28:00PM -0600, Jens Axboe wrote:
>> This is good for a 10% improvement for passthrough performance. For
>> a non-drive limited test case, passthrough IO is now more efficient
>> than the regular bdev O_DIRECT path.
> 
> How so?  If it ends up faster we are doing something wrong in the
> normal path as there should be no fundamental difference in the work
> that is being done.

There's no fundamental difference, but the bdev path is more involved
than the simple passthrough path.

-- 
Jens Axboe



