Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C145FC3ABC8
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 23:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cNzZ2ljIy3jR3OzleCeocAh2sDyeHfku0kPu8kbjbek=; b=xCij+MbSi9SdeXfb8RThvhzGRy
	xfkZH7xfeSgkVG7XixTaQKe39HpHivThTs550wRdv6accKaWSKSYyCEOCM+Q2+abyauLvUkY+BK25
	TEY/YE+ia4AOBpe3W1+5fjCopmhV4BR/RkXjAiaMYJJPEjdUbG8aBpb3nFqfdsxw+HHaQWdRLRqNN
	1sAhRAkeKyoGyrKbm4eyFx0pKWs6udsdqGul71TuxtO0VrZSdGaB7PpRVQGACICTZuVr81hvX0eII
	ZsbDyfTX/at43nEdsobNiQYMF4ONojigDHxiOqXTQsuVAO4O/wzk6Xo3GjJAchTe2ukaTiUosMvDP
	mEyWiqaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCRpj-0000000DgaD-44k0;
	Tue, 06 May 2025 23:36:19 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCN3C-0000000D6fM-3ZTs
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 18:29:56 +0000
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-85e73562577so607262939f.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 11:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746556194; x=1747160994; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNzZ2ljIy3jR3OzleCeocAh2sDyeHfku0kPu8kbjbek=;
        b=zv4uvUeDZ+Z01Hc7ET8BDJa3k2SAjKRcp9LRl4e5mFVf0YG1OenmLwvqOCAG+ZDmwJ
         etuWIV8GOwZ+LAkVXF/uVGO1UscqGxtSbZm3UTisrq4M2zz77I/dlEmNvBC/SpJzDvTa
         S7zQc7iphjJMc1C/1M+mWbq7jNyCqRRgnbBU0z5HnIjtAnRVAQpQXwQ62OBwe8NKh48I
         K0b7GOF3ryY8NpqYrgCNdSBiNpsFwm3AeGO6fgdsq9EjopMS2vV8Fl8QWSifbvdrgBPO
         n+/hgNWshTk2ShRCQGI/5SuPIVd6YHIdXLivBl285QS9FS/YiJB/d44GOh84j+SF6FJx
         6XrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746556194; x=1747160994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNzZ2ljIy3jR3OzleCeocAh2sDyeHfku0kPu8kbjbek=;
        b=Vrs4RkgowaZAa7PmSPZN7xvtPf6UGcplV22mq2+2PhIZIO8vXXKgK6sJe95kASbj3i
         EfNhE648TFg4t5+jtA4JaE1oaCip2YUHEeZUzIV06AR2dqEhejLglLCu9hr7rXIFgbRh
         oMtrvDaT4l7ifT4R698xl10tBvZ/iyrqnpua9eenAVEfgtlTdEIu9qvDjlUdiP2RT+7a
         rKWnVlq+njiQh6mZcdPvZw/u9owPRmedfFNrdHp4fYlcEcAwsyp6OEI6/CDepXQPtK1z
         sdxhriR4BSSF2gE268xG2y3U0FgGw4rNMzjn37+6vvcS264CvS2PxtpcYvgXiT3pQ4OH
         jKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1E7X6hLsVtqCjB74lQACGRxHlr7eilEKe2+/fw/2vC884dvD5RMVY/mYqHGFx6DG5jtm2lMF16rRC@lists.infradead.org
X-Gm-Message-State: AOJu0Yzxh+ogyxt7A8UF4J4yoP+N7+Z3jPNKb76Pq42go+UK8SdB5MCJ
	RV61g8/YcLGaJ+G8NDzkCdQe2UGh8DdxN3nmRtUajsh7DVAXM9em7FhE4rJm4Io=
X-Gm-Gg: ASbGncvg5x9meEs1+AO98VmRZO3WxaUbErrtTyOe5V+gLrcsWn7sF3hKxvCt+XgDJp8
	ZWPK9bwkBhMStCzJ2MQfFD97Q8c924DNB2U289zSHbdk5qOJNL2IsNrjGKK9Eb+/yAn2xMl+ylI
	17vWuGpRThPk7Jtu0590LUWBtitkWEUDWu2ZwqOcvn6WJ2pH8TfKPB8ZReqameMST7yXr+5C6PE
	A6hMZ/WLEYfBdnujdQ5Wfrn56zfuWDUvs3l0VnIpga5/HhZBTGiuYDK57mfgUChjuNXMIlLUkZQ
	sAiyLSm84vmcbbpZumMtw2aYBUN+YdNvYQXP
X-Google-Smtp-Source: AGHT+IF5543Mf06skw9gEe5QHPYYK4vxTPvfD4ZAQs5Anlt5/5G5LM5fDnCBj5x6Dpzcv6QvBsJipQ==
X-Received: by 2002:a05:6602:6015:b0:864:ab75:758 with SMTP id ca18e2360f4ac-86747259fafmr88949439f.4.1746556193921;
        Tue, 06 May 2025 11:29:53 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-864aa43a9f1sm232414839f.35.2025.05.06.11.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 11:29:53 -0700 (PDT)
Message-ID: <c802fd7f-8921-4b45-ae20-ae2711573e79@kernel.dk>
Date: Tue, 6 May 2025 12:29:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix incorrect sizeof
To: Kanchan Joshi/Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Cc: csander@purestorage.com
References: <CGME20250506180545epcas5p34d4857f38b838532678728db22df6067@epcas5p3.samsung.com>
 <20250506175656.23151-1-joshi.k@samsung.com>
 <6ce9274c-db51-4ff9-9d05-9d334caf2206@kernel.dk>
 <d238e89a-3a9d-4807-9634-57fbff4168a0@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d238e89a-3a9d-4807-9634-57fbff4168a0@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_112954_895489_C33C5F86 
X-CRM114-Status: UNSURE (   8.96  )
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

On 5/6/25 12:25 PM, Kanchan Joshi/Kanchan Joshi wrote:
> On 5/6/2025 11:39 PM, Jens Axboe wrote:
>> Reported-by: Caleb Sander Mateos<csander@purestorage.com>
>>
>> ?
> 
> indeed, missed that :-(

The commit message is also very light. I know it's a basic issue, but
let's at least try to have a full description of the issue.

Can you send a v2 correcting those things?

-- 
Jens Axboe


