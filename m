Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E528EECAAD3
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D48sKnj/LKsCTNK28yvEA0EXKe4cS0TrK7YoZpnHn6k=; b=djTQoPJj2zrzT2U8ZjFOtVFapo
	IxbCCFWy4ItBynHFN28yKuqcYU9t9l27jd+McRlg6tPZ41dtvIDDas6GWppOG4syNYItWn7I1OT5c
	b1GmQf05v1SZqjgOeLMZX6bOyMZ5I1XJPtGbwQ/4Tn70eg6Ul0eZsyiNB5g6eGDZojHpzdI+/4N6E
	Lf4JooZPdIooRvPgooMIE0YbkiihaXGIR8mULhC5V0yOsVlhUmSPHJhG6gGUuNSCY5zxRYV6fitNL
	4Tjkf8aSaKBBxpp+JTPAIcTILQHifOBhJi/srluSxUFCV1Hu0Kqnf9izeQ8eLTZ/igDHuW3V7Sbh9
	UKYXQSoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWfRv-00GtbT-Dz; Fri, 09 Sep 2022 14:57:43 +0000
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWfRs-00GtaD-8X
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 14:57:42 +0000
Received: by mail-il1-x134.google.com with SMTP id r7so923828ile.11
        for <linux-nvme@lists.infradead.org>; Fri, 09 Sep 2022 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=D48sKnj/LKsCTNK28yvEA0EXKe4cS0TrK7YoZpnHn6k=;
        b=apnB/ALlkoUnJ9RI/nc4OpmhjAcERsh7r20vKYFTO6KxRQ7jfygJ73utwV28Jj8HXA
         E3namkv9uzkN9p6plWNMG73DoyiFoyPyCfzeqJhXdPaikxKajYMy3gi8ETmXM/7KrGbG
         t6iZs1K/LZi44VqUd65TyaSAjbBHDo1bveFVtJg0vC/So7HoxS9uRh+FXfpUzyx8wPNH
         oHeGRlL0ov/uk5iTMoYat4mXqclI0CY1kqheRgwd6HVxNqrRsZkf15DBiH85ZC/bXQXV
         oN1WZHVbCwvURRT3P0JGeiekCr3qr29Bve6tYXhRDnGildVLi0a14GYo1mm+bVnXiWZR
         n1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=D48sKnj/LKsCTNK28yvEA0EXKe4cS0TrK7YoZpnHn6k=;
        b=K2mm3VBquqWO17RQr3Kc0YQp9kaAGAfgPIPE/bsyNLEQfS8GAqK0lrr7UipiWQuCaQ
         GjcrZpsT+vhzcqLmMz6ZrZix51RcNEPckUvhhmdFLIqOvajlL5MP0xBEejd8S77mNalM
         46Yr2h1ahuNUU6vtabffLpbz1XDA07qjKm+MxIZ30+rU2CV0GeS2Fn4OJV7EvPTv2B3L
         5AwT2X5ZVJUQJyOOCgB2nZUcGqXknHKHfiwiIT/tvZvLwmFbsX0QpmnNFMqh+VKQAr8b
         EB4um9QTmJFNpqN8+s2ObahEumkW07xlklvEe5YueYbQ/A93viORiC5HGBo9mpkX0dSk
         qF7g==
X-Gm-Message-State: ACgBeo3wYvNGoEBCPiUQtAp/yDo6/rekN0LT+totWe0OV941w6fNUCDc
	6hd6n/UC9AoZPnXhvhM0oRE03Q==
X-Google-Smtp-Source: AA6agR41n/NJ5TrAhPDgqPkxJUCpyKjM/PfzhOm25tfwGcngL+/5ddTXTbCQvOsdDrcD4QmHGrYQww==
X-Received: by 2002:a05:6e02:1c8c:b0:2eb:9978:5d14 with SMTP id w12-20020a056e021c8c00b002eb99785d14mr4312621ill.179.1662735457506;
        Fri, 09 Sep 2022 07:57:37 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b10-20020a026f4a000000b0035a11c14f74sm184241jae.92.2022.09.09.07.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 07:57:37 -0700 (PDT)
Message-ID: <20f1789d-3c5e-b1d0-c3dd-d6fffd12b82b@kernel.dk>
Date: Fri, 9 Sep 2022 08:57:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] nvme: restrict management ioctls to admin
Content-Language: en-US
To: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org, hch@lst.de,
 sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
References: <20220908213517.3085323-1-kbusch@fb.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220908213517.3085323-1-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_075740_539680_2A2292CF 
X-CRM114-Status: UNSURE (   8.75  )
X-CRM114-Notice: Please train this message.
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

On 9/8/22 3:35 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The passthrough commands already have this restriction, but the other
> operations do not. Require the same capabilities for all users as all of
> these operations can be disruptive.

Would it be saner to require that you have write permissions on the
opened device? Not sure this CAP_SYS_ADMIN is really necessary,
and might break existing setups as this is new.

I do agree that passthrough and sync ioctl based issue should be
consistent, though.

-- 
Jens Axboe



