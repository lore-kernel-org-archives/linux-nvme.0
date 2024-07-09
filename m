Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549EDC2BD09
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jul 2024 05:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UTCK+V3PUiwaLjd0RY2gDMw8PfFbDuwnRHMswGe6FHI=; b=m/DktoHBuCWETFWvXQ0cDz1KsV
	42MprUuiQ4LDTNKCbzXDLYauaJMXns+PGVfXfcemgj23+eL2w7ConRJcyOhau2YdhyaLg5/APgrOH
	iKRxzhFUla5mMwOItPO056JeHgDS/sQniuxKXaGIiSnQ1Wc1Aw9AVOqg4DQgzABdIeoqZDaXfAkc3
	EaAfZjVF/+silBfqi+0i/YxgI0yrei/jtY/LR5KO5EC5EGPgs/0eNLqcjxoLDbs5kztsobXpZVZW7
	V92fDXdHsIKoD+28Bw416ob7URp13eSfVqvrCpoEFMNmvX+a6qAvVtzYQhrUQyFi4j69NeZ2fDf1M
	ibTkPEgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR3rN-00000005zgV-4ADE;
	Tue, 09 Jul 2024 05:57:53 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR3rK-00000005zfW-3pWU
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jul 2024 05:57:52 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-52a559e4429so707445e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 08 Jul 2024 22:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720504668; x=1721109468; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UTCK+V3PUiwaLjd0RY2gDMw8PfFbDuwnRHMswGe6FHI=;
        b=Xp9qpGw1zUZjksq++aUDBVxcWmCkg+esnw86N/AVyO9ytVZzsFdLXG1mws12/FgEE+
         SCVquE3AJ9ziQgh05svx4d00EY49irNV5qhWEG4au2eLRubiXq3W2Wpt3qIgbwKcfVCl
         ZVUwkfrqscomjHMwWeFZAefOzKktbCL0IfWDkOXcOMe+ojwREoRD+JnkTUs8KbKm/ei2
         mS5/Kb1/INJyRem0ADWDdErxleMiOFqvFYvN1cUsxbsmXdk72H8r2mK8qi4CbgnAIO6q
         /La9jUG/6YsbNph0AUVtS7pC7UArNMdABovjaQA8CIA0JovC08Jl6sZHpR5AIDHA3NJU
         efaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720504668; x=1721109468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTCK+V3PUiwaLjd0RY2gDMw8PfFbDuwnRHMswGe6FHI=;
        b=duw6J5NLXZ+mLEpVRO11aAZ9P8cwmb3+6s1ytd2xsM/ya6/BW8nDQy8bNSu3Gx5luq
         7L7T+Y8+HCvna16NPhk+01rv6vizS58qyLkWgV0DoMSv38pXQh4VucjaVDi5AXGvcRiE
         /ozF9Ktx/58tOCsPA2TOX084IuesKeYwBCg6G2FMJspC5e+Lm6N6LxVL4xXuI/mmukU2
         d8H69m9rv6SNbwr84IHBYdKzMgRJxRoxcAQDmXGAi3b6d/6o+X2m89l/gegvwyKfFufb
         QQvOodDtWcsa4XWDdFIwSVHImMP5vmpOyrtzimvirDsxcRJHjsAdR7TQVWY8k1ut2Lri
         X5Gw==
X-Gm-Message-State: AOJu0YyV3PaDp7qfjYVnhUePC0xA8ZaCTucvRlSr8WPD+DIeiccxA32d
	L5sRkFWZxHiSe9iYtoVsVfn9NsqUGdh9J+IbjPPXrSICN5NmDN+Ohx3Ny2mxMCH6DcP2usXsL8l
	6nSuHuq8W
X-Google-Smtp-Source: AGHT+IEJUfStr1hX7g8umxZPSWYsGkTXYhF2+RGGxHRSWs1VVNOJ5xIvNJpHERfyRMfZ2scupHN2Dw==
X-Received: by 2002:a05:6512:39c2:b0:52e:93d9:8f39 with SMTP id 2adb3069b0e04-52eb99d3490mr825024e87.3.1720504668328;
        Mon, 08 Jul 2024 22:57:48 -0700 (PDT)
Received: from [192.168.1.68] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb8e34568sm147856e87.55.2024.07.08.22.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 22:57:47 -0700 (PDT)
Message-ID: <528fdc07-99fd-4e64-86e5-132ba6c6cc0c@kernel.dk>
Date: Mon, 8 Jul 2024 23:57:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.11
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZoxM6r4B2bxhi_i1@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZoxM6r4B2bxhi_i1@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_225751_175004_BCD0E277 
X-CRM114-Status: GOOD (  10.92  )
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

On 7/8/24 2:32 PM, Keith Busch wrote:
> The following changes since commit 44348870de4b8f292f97b84583a298d66fbaf738:
> 
>   block: fix the blk_queue_nonrot polarity (2024-06-24 13:06:12 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.11-2024-07-08
> 
> for you to fetch changes up to 89f58f96d1e2357601c092d85b40a2109cf25ef3:
> 
>   nvmet-auth: fix nvmet_auth hash error handling (2024-07-08 10:28:16 -0700)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.11
> 
>  - Device initialization memory leak fixes (Keith)
>  - More constants defined (Weiwen)
>  - Target debugfs support (Hannes)
>  - PCIe subsystem reset enhancements (Keith)
>  - Queue-depth multipath policy (Redhat and PureStorage)
>  - Implement get_unique_id (Christoph)
>  - Authentication error fixes (Gaosheng)

Pulled, thanks.

-- 
Jens Axboe



