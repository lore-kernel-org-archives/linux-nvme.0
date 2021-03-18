Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392A2C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 01:59:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E35C64E4D
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 01:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E35C64E4D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JF/s/GvAWMp+evtCTbmw5mcz6ZKTT2flp93L9loVJ1Q=; b=CVTc34pBw/zLxXfg7Ms5efTuX
	Rc2zyXGwrA1GmnfmPM+gKeK9X82jsFEpdzt/kB6/eOLGXeFgDbfbAmlpqn+VpdPIhbKzSRapKbZgd
	zy1Ivn8tlsXi0qTZTb7cCHRcPZuewDMoay2TH/Ig3HoIPtkl+XUCd6/HjhzX23PEXbOOso1H7fdgI
	d3Yf9lC3B/MshxH/agS/wJPHE3UAjS3qH7Itn3HE8qWUVphSp1p7YAaRU6ZL7VkvIo4mz/GyDtMJi
	UHlt526o51u40xHcTdQGUxzRJ/ONLqfsKPWPUe0tO9ryWeEWVrPUMvV6XbAoeAtxWMSl8RM8Ia7JZ
	ZOUtxOgWw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMhw6-004GYd-8u; Thu, 18 Mar 2021 01:58:54 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMhw1-004GXT-3t
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 01:58:51 +0000
Received: by mail-pl1-x632.google.com with SMTP id h20so484472plr.4
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 18:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=23hDjiDr6dOC6qpQTBiXHAkrBttU7LaznfUpSLfV5mE=;
 b=j/YvT6mWycCXCDGME/+oXrSDLQ5unOMr3ChK1dfLau26ExbG3SQMJmBSkMHQM9oLQP
 N017A52YqvgtolsiEfjmL/LYqzNJGXkI9HKqc7yqVmXW8chU3jFvJKDhC3lItHH6Mo3x
 oO4m5qV5rA0UmjA204xfj3k7Xao33W4kD4ZzWZ0AijL8m0E+CwiW6tMD6laA6+RZUbmd
 nQbY3x9l4kPvfbbkO75akOZu3/pWx5ORAK0CI4DoMS6DFMzgIDYMji/EOLfIGFoeRsX7
 KU7wMklpOnLPkq2iGMFmk22rgRFwtk7yLrrpsoWYaNKLn6uKOU+YUC3y7vkfUQjuNkTe
 w9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=23hDjiDr6dOC6qpQTBiXHAkrBttU7LaznfUpSLfV5mE=;
 b=SUsTjcmRpMuahCj66Uw2e+KTbSa5peapJsl/e4HTdoGStq61WEgQFYE8Yj2hL667HD
 T7nQdEZ0JQeGg3Y2nykdQEXGnH3gfh57mpAyqUTnu2BLYpfv7yXVKuUa4F9SLrGCrxX5
 jCrVea1RauJGzUr4rRjY2UvpRSwLWR9BMqc3jxgzF1XmhoA9wvQ5wAfibLstqyW7eo+F
 pLWER/vsZ120T/HO8gXjMM1RmfCZ+Yg48i9nVymX8NCX0hZIpTCO8EL2ADgXICkdRyfw
 ecYbAaIg4gYYDStziHNKTBv33xo6//B7TPy9Bpi3h/JNHx014IAM9wiDbL5MnUFlYnRj
 6k/w==
X-Gm-Message-State: AOAM5305E9ka43jA6toAoy8bKaEPOjTMU0cWZZrMMF6sFgsF6qqU/cF2
 q8sCMtnnBA4fi2xgO8/cEn26SQ==
X-Google-Smtp-Source: ABdhPJx8r1dmMYTB0XGagKLwOwWeb2T4iBlofj2quYfLLc0ruDUVcIQHHBPcdrKrf72BTXv2VPvAOg==
X-Received: by 2002:a17:902:70c5:b029:e6:cba1:5d94 with SMTP id
 l5-20020a17090270c5b02900e6cba15d94mr4444301plt.84.1616032726909; 
 Wed, 17 Mar 2021 18:58:46 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id w188sm324224pfw.177.2021.03.17.18.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Mar 2021 18:58:46 -0700 (PDT)
Subject: Re: [RFC PATCH v3 0/3] Async nvme passthrough over io_uring
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 Selvakumar S <selvakuma.s1@samsung.com>
References: <CGME20210316140229epcas5p23d68a4c9694bbf7759b5901115a4309b@epcas5p2.samsung.com>
 <20210316140126.24900-1-joshi.k@samsung.com>
 <b5476c77-813a-6416-d317-38e8537b83cb@kernel.dk>
 <CA+1E3rLOOaggA0p5wr5ndTWx42zjebCeEm5XzfOq7QcH6oP=wA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <63a127c2-e2ed-ad5f-a6d3-8d56e3e95380@kernel.dk>
Date: Wed, 17 Mar 2021 19:58:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+1E3rLOOaggA0p5wr5ndTWx42zjebCeEm5XzfOq7QcH6oP=wA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_015849_382911_310695AB 
X-CRM114-Status: GOOD (  17.24  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/17/21 3:31 AM, Kanchan Joshi wrote:
> On Tue, Mar 16, 2021 at 9:31 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 3/16/21 8:01 AM, Kanchan Joshi wrote:
>>> This series adds async passthrough capability for nvme block-dev over
>>> iouring_cmd. The patches are on top of Jens uring-cmd branch:
>>> https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-fops.v3
>>>
>>> Application is expected to allocate passthrough command structure, set
>>> it up traditionally, and pass its address via "block_uring_cmd->addr".
>>> On completion, CQE is posted with completion-status after any ioctl
>>> specific buffer/field update.
>>
>> Do you have a test app? I'd be curious to try and add support for this
>> to t/io_uring from fio just to run some perf numbers.
> 
> Yes Jens. Need to do a couple of things to make it public, will post it today.

Sounds good! I commented on 1/3, I think it can be simplified and
cleaned up quite a bit, which is great. Then let's base it on top of v4
that I posted, let me know if you run into any issues with that.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
