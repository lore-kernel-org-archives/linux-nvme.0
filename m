Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757F8C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wWlQ9VK0DD9czemBerx4SeOis5QOOAIANjEKI2qVGtE=; b=ZDt97SzeRIWoKPpayswAcRUJET
	5WzPmFh/k/vN3VB7DJDKS8WpgywUc074htaMALof+ee9yUlZIgCKesV16Zr56ttrVoXJ326rMbFRc
	fzoZJks3tDvkhqAPuJGz2Q7jL6EDQFrtxVnKvR6Ht3FSZaAIKCs9ygjvYwQVTZ3BVC5lXKP7hALOZ
	uKAQmYeKzPgQg+WLvi7U7tYXuifmqj7Z2puXBDxH/97lQfiv+3Wm+Xv5c6heRtsmAwKW/pUTLSVpC
	UcSzZv2Y0TkWTiXtP96uw7LOwAo44rbwsug3WkglgfgJmWEM0KXNsbP7Bt1ICeTJdRIAu9JhpR+tO
	mHyRyu5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odaeM-00HIkd-17; Wed, 28 Sep 2022 17:15:10 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odacu-00HI1p-MZ
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 17:13:42 +0000
Received: by mail-pj1-x1031.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so3916242pjb.0
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wWlQ9VK0DD9czemBerx4SeOis5QOOAIANjEKI2qVGtE=;
        b=cqKovKCQW42IllwbMKlBvvUs/FTWNZj2mcCK4y8ThaGVMsyk99k64owZjUZ1wWxcQ6
         nYikmRHFfUAOgeWZGS+Nn9LoJ8ZbviC192qAAj4lWH/thexYx83hrfTITHakHOENrtxc
         zVPqhWKPDZON3vonUHsXNxB/06q2VX4xHkzzWTZ62frKoxiIVahORXc7MJfSDedHTM4s
         zRsfCkZ8dIQ5YcJrh2KGXCJbQ37RZW2Tk7wXLqPTvYW2cQ9wGtvzCEWMqM3gp84kDF5e
         3Vqks9P8ozmtfwHJhhPD3yV6cRuVrPJNwa2MleHi5Ry/pIgPG35wdEOx+1G7zOrTFGJ6
         wxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wWlQ9VK0DD9czemBerx4SeOis5QOOAIANjEKI2qVGtE=;
        b=1L+AXLaX4d/j4MRFqjgyVCDtDR21BUZRxZqTS6uczc17k5Y8w+HkXaCRZlUXVg2UDl
         z42QZcYiS4Elgx7S6QQ7nm0RQFmxjCkKuOB4lQnGn4lSMwfW4jd8TKQFPOsRaZYXFA/D
         CWKZ/EmYq19rKEUb1oZGRjMdpys7pA3by72uAE2IVNIJcvLLgSCVkk9PLicAPKqP3jUG
         mAjK+qfu5Ai3Rq4RyVAxgWE4ZX9n4vuRRxc1gXZlibJAOyRhdHe4Xeaz1wjzbjycEpr/
         owu6Idz7dk6ONsv2Wa3kh6A3B9Boird/dxeIuZm0FqgD/ra21o80BZSHfA5mdhoB2Ctl
         R6Mg==
X-Gm-Message-State: ACrzQf1l02bLMMMFAEUkPWLGBa3DH4mbKQAUqYCu1j8YxOvZoLduYOtO
	3ZWfVbu/lqTztMTOpki2oagd5w==
X-Google-Smtp-Source: AMsMyM52hwd593t/SShjlopLYj42VgkbaQcw6sT5ciMCuzKacBGMa3jiLUuF7+xtWM+y2NRNlketfA==
X-Received: by 2002:a17:90b:33d2:b0:203:15e7:1571 with SMTP id lk18-20020a17090b33d200b0020315e71571mr11445784pjb.186.1664385216734;
        Wed, 28 Sep 2022 10:13:36 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r9-20020a635d09000000b004393cb720afsm3844788pgb.38.2022.09.28.10.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:13:36 -0700 (PDT)
Message-ID: <3a8f1bbb-7430-5bb5-351f-45f46b09db5d@kernel.dk>
Date: Wed, 28 Sep 2022 11:13:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH for-next v10 0/7] Fixed-buffer for uring-cmd/passthru
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com
References: <CGME20220927174622epcas5p1685c0f97a7ee2ee13ba25f5fb58dff00@epcas5p1.samsung.com>
 <20220927173610.7794-1-joshi.k@samsung.com>
 <96154f6c-c02a-4364-c2a8-c714d79806d3@kernel.dk>
 <20220928171244.GA16907@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220928171244.GA16907@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_101340_993045_2874A546 
X-CRM114-Status: GOOD (  11.01  )
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

On 9/28/22 11:12 AM, Christoph Hellwig wrote:
> On Wed, Sep 28, 2022 at 08:28:02AM -0600, Jens Axboe wrote:
>> Christoph, are you happy with the changes at this point?
> 
> I'll look at it now.  Too much on my plate for less than 24 hour turn
> around times..

Yeah I know, I believe Kanchan is OOO for a bit from today which is
part of the reason why it got quick respins.

Thanks!

-- 
Jens Axboe



