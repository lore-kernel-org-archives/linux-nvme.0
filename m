Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A344C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 19:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aRyUlUrPJM+o9A9+H6/I6keaAjKNOyJx56LR18+E71I=; b=cHxDEYkk0DU8hlE3E4JTKVy3t9
	JuAiw8mVTBD0rpOUk1XV6ALwBUGpXBZXimWjUnHMGsD4fIrYC+koFUbDcm/sMOkiF0cVmsDy8EMyj
	GGDL3wxBLPsjnPtmpk4UGooP8dUZ4KxUNGOKVnvjiOwEo/BjmBGos/DPXlUFcUF1uc1vK7VbRU822
	9le1DqgKKvGuwipvD46qxhayLrIbhxsz5loHpYObKBpIPQYDPzsd2adPcIxprqRrb+OB7qxDiGN7s
	7s0IqJY/OAcqE4JZ8PAPO0DqoPD+TgyK8AMduijGyu7VDpIQReXLw+UOZbVZPwDfcsKgytD1mMrWZ
	kRkViCFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onPpZ-006xkr-Uc; Tue, 25 Oct 2022 19:43:21 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onPpW-006xjW-V1
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 19:43:20 +0000
Received: by mail-il1-x12c.google.com with SMTP id 7so4540074ilg.11
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 12:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRyUlUrPJM+o9A9+H6/I6keaAjKNOyJx56LR18+E71I=;
        b=vUq0/P26IwBts+ZXvYvfj6i187bCAu0NrC94qpxQOnrc95Br86eoZWSFU3zIoq7FE1
         gAwMHJuKUM1PaTlIRVvXhMBVLYFKo4xHPRJsgooYn7DFfSifgQYMFJcczKjFr75PUcoE
         Zno4yHoNa1CqxsggDz5CWfuqFnxzDYPK0f5VW7YBP5FEFlfRhA9Ap3IrcDQjIZ2++pyx
         L2fEVrZdDTpj+yr6ki674Lg0JGjDA1KYhfElrWSW0SwUincqzOlLvd3RdkRKv3J0R47R
         aLrH3pTlUcb/QqUIOYOWYTYyuNixzeeVFFQqDEYqLU5UDSFU6Xru/6dZSOvE99I2BC18
         T3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRyUlUrPJM+o9A9+H6/I6keaAjKNOyJx56LR18+E71I=;
        b=1eN3MKt2HANq/sDaprd+0L1x7AyBjuN2qn726YvVGBzadbyYnz+hILA1RPFoIaBd2W
         x8aM6mPfKgzvWwkMknk2GtKDh0GmyeQD0Yfxq71Rys9CoBOHXsQAHj8lsLRGxo7PZy7I
         A15Ijdh7c3f3Xwyivq9QHLEmw9hYOCgFGx23FR4cuRRP0xWK5jxk9UkJbYJUQQfHAF01
         EbSDFTWcA2U+ulB/Cz11rZe4pVYO5T7b6c5UUDUNxEj+Tc9iR8O//PUiwJLapIyc0R5i
         7BhuslgfTjfwqZJSn7FjFdmO0cbsTeFm8VGSJeAOmx3z6SDzwwfWkGzHzO9qt0a40Hz2
         lzkQ==
X-Gm-Message-State: ACrzQf0Sutepwm3XlGEayNe6E/KzFGRfaEE4J7OJ1GJHUxFGeLxpuvnx
	vd9OPaixnXWGfM9kKiyeZxibig==
X-Google-Smtp-Source: AMsMyM4IIHnI7/zaCSb8UEYPywmHMsL6ICUal22yvRbACDK4BKZWAVRcJAXGVkPW4zZX2mtqnMmmew==
X-Received: by 2002:a05:6e02:152b:b0:2fc:43a:1d10 with SMTP id i11-20020a056e02152b00b002fc043a1d10mr25840278ilu.237.1666726997845;
        Tue, 25 Oct 2022 12:43:17 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e19-20020a0566380cd300b00371ef930be0sm1249326jak.1.2022.10.25.12.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 12:43:17 -0700 (PDT)
Message-ID: <fc736207-3707-722e-c0bc-e79d111ef929@kernel.dk>
Date: Tue, 25 Oct 2022 13:43:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 0/2] Granular CAP_SYS_ADMIN
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com
References: <CGME20221020071338epcas5p16d72f5d4d868b889e3a98688bc454a98@epcas5p1.samsung.com>
 <20221020070205.57366-1-joshi.k@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221020070205.57366-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_124319_026474_5E49A2C0 
X-CRM114-Status: GOOD (  10.52  )
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

On 10/20/22 1:02 AM, Kanchan Joshi wrote:
> Hi,
> 
> Patch 1 is for io-commands. It implements the shift to file-mode based
> policy.
> Patch 2 is to allow identify-namespace command. This is based on the feedback
> received during ALPSS.
> 
> @Sagi: Since patch 1 is changed a bit (changelog below), I did not
> apply the reviewed-by tag. Please take a look again.

I generally despise any kind of listing of commands, but this looks
pretty reasonable.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



