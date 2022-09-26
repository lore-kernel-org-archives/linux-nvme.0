Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C82C07E9D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k+bNrBOkz7J5I/U3tfdFW68L9IU+eq1o0F5bYCHeShE=; b=mYbIV9h+6dA/j6KIaYUZxrIrxt
	JSDMr0C5bJI209U8uWGPSU6j1jSgkwYbWrhlq8J/tEnyw0G/ILN+ngHRmvTR0Oc4nc7J997w0QNXy
	+ZDNTAqZjwBLamQwxI6NHdP2hpjYlCXwk2Y8Q+gjyfptDqU42GSogCKcEIl3jswWEw3E94GMHaF60
	lp+H8U0gy/sr3TJ6bjaqIO+/dFxOxNEiDTGCOY+3Stb1+lODkgvjOXxMHKBLGw7U3cmUY8zf9DVf7
	0wyYIlPHZNKN+BN3ahEknBboxwYGWa8EMj1OctMag/FSuuUsj7wErzQU0uCCJWuDF0/WcbiLSifwP
	yydXynDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpIm-005Pju-Ar; Mon, 26 Sep 2022 14:41:44 +0000
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpIk-005Pig-OF
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 14:41:43 +0000
Received: by mail-io1-xd2e.google.com with SMTP id d8so5360699iof.11
        for <linux-nvme@lists.infradead.org>; Mon, 26 Sep 2022 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=k+bNrBOkz7J5I/U3tfdFW68L9IU+eq1o0F5bYCHeShE=;
        b=KxG6NDdhHIZwR1XoVLdH5nitEfjTRC1pvN7c3TPSSqAS6FKCFPyrabhhR1uf9InP1l
         CBcRxAEr+ICU8HvlADa07We8mBADg4dvVknQsAF4tSKII1bxdL/57CjZAAYss0W4d9c1
         DANcSEJsXWWvj8TNABwryOFXa8yHn+W2uee8AokrleMAlzz8iSTcBVdEl0oLB+Vb3zI8
         UiHljPSOXbVFXqv803pKcFSTGemLP/qW7tsJza64o2QYJvVrda1WT3Ti6VPDJwzZerrl
         3CxrPryIupCGZOP/jiZ+UuOBLT+Ztw5x50BDB5yX2xJtqqZMHs30mRYrSJnDDgNnAIVl
         F5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=k+bNrBOkz7J5I/U3tfdFW68L9IU+eq1o0F5bYCHeShE=;
        b=jZfu8WyKIf5s7R355/2XNlTLbB85+Ps+T0vbv/zIxFq7800GXBkViiWIZYxTCEGduP
         ZVW2lvAt5IcVNzgZnPv/GJe7AynSgg+NcLjCe2+88CofLJYbF273oUNMpV2e4e3A8twX
         nE8AtA34oAstYc2mACD1UEXorbuGqjyQ1mszyFzpDlj6XnwUMGN/8Syg8XSSXAYQcbXp
         g1h3+NiXfnjcjaS8mmFgHU5+apbSa8RS3G2PON96PB+iw8FhgPs3iRXW8EzdsgdzDZAh
         xyuUiJVuBmCwYceoXUNzQL0KAavHgYXDN5PelplkzCtNwcHCTB4SS6EoeKfXxfIqhnId
         tlRQ==
X-Gm-Message-State: ACrzQf1HH66W7VLoDXR+eNMp2u0F+HsfdV7fjI/RZARADWALt93AGeAW
	x/l20Ig4SlrqWRWQT0OVEm8PMg==
X-Google-Smtp-Source: AMsMyM76CCQsz6YIyMEtt6BslnsWjMtjauQWuveAF39q5APdh5N7VWcKVGqtLK9Mm/u/6W25LaMDGA==
X-Received: by 2002:a05:6602:3c1:b0:6a4:16a0:984b with SMTP id g1-20020a05660203c100b006a416a0984bmr7525590iov.125.1664203299800;
        Mon, 26 Sep 2022 07:41:39 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q48-20020a056638347000b003583a010e85sm7041438jav.94.2022.09.26.07.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 07:41:39 -0700 (PDT)
Message-ID: <69598e37-fb91-5b92-bb80-b68457a7b6f8@kernel.dk>
Date: Mon, 26 Sep 2022 08:41:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/5] nvme: split out metadata vs non metadata end_io
 uring_cmd completions
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stefan Roesch <shr@fb.com>
References: <20220922182805.96173-1-axboe@kernel.dk>
 <20220922182805.96173-5-axboe@kernel.dk> <Yy3O7wH16t6AhC3j@infradead.org>
 <d09e1645-919f-9239-f86d-a8e85a133e5c@kernel.dk>
 <YzG5/1zSdiMlMLnB@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YzG5/1zSdiMlMLnB@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_074142_820219_D04A35C9 
X-CRM114-Status: GOOD (  12.08  )
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

On 9/26/22 8:41 AM, Christoph Hellwig wrote:
> On Fri, Sep 23, 2022 at 02:52:54PM -0600, Jens Axboe wrote:
>> For both of these, how about we just simplify like below? I think
>> at that point it's useless to name them anyway.
> 
> I think this version is better than the previous one, but I'd still
> prefer a non-anonymous union.

Sure, I don't really care. What name do you want for it?

-- 
Jens Axboe



