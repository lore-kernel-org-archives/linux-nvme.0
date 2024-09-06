Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BB7E6FE48
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 20:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FxtZavvF7hKlYJib3FGikYMbfvBa4WD+IYy7wW+5iFc=; b=bcDA6b2GansM0FD3CvrEDWsHgb
	J9bOmmN9/ndgYXo0h2e62vQhSoMtx4jSqRfulkQsw6Ln8UAMe7TZLsZZklnQkR1h/2Wrcn/v2oX2k
	8RuE45Z7XCjDXJkRNhWxbAZw+WHlvhMpjFWgzaC5EOx32tH1noBbBE3HnjzFtOBoRwRe16P5JTyhm
	FcrDCFAFjHrZYCmaafY6Ox3XXVlM9k1JNrW3eQhOW/YB8W7W8bFS4V/hvc9k/8omPbvN0jXrShdbz
	C0jzwAV5m8qrHmaiGkWkxtkj6xyYYhHtYaiKUfQjwu6cVrmHDbz/76N1Liy1neaFCZbcgGkOxDRT2
	OI0cN2kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smfpb-0000000DaFP-1E7J;
	Fri, 06 Sep 2024 20:45:23 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smfpY-0000000DaEv-1H4j
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 20:45:22 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so850370a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 06 Sep 2024 13:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725655519; x=1726260319; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FxtZavvF7hKlYJib3FGikYMbfvBa4WD+IYy7wW+5iFc=;
        b=nsk2cr+BUXLi4yIsWc7K36pbIyP0Ug+tKo/4DVno+RfUCA5jHn1hn9tq5Vtydh79K+
         FmS7Qb4txYGUpGnRpGryZcxuXH72vMw8qloRoW8gfAI5nxrMglZkjq5wp/i+P99IasYw
         tZeAKXm/NPoS7lCG98viLRaxlxZpgxsqPJsXlFpS3l1/m892RCRTPmkDHyI4qZ3uv/Gx
         8BY6FpYNLm43iz0/iPsmX5r7l2soxbC1nZ08rUX/cTNQacko79HatesdqplwADj66VfD
         ShkLDfSz2QwfZFEiKGZxzdCT9f2SCfIab3FJsQ1y7GEBWokucn6YR9+D0d5QWOSw/KC7
         MsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725655519; x=1726260319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxtZavvF7hKlYJib3FGikYMbfvBa4WD+IYy7wW+5iFc=;
        b=IZRXnFG+Bv1byQMAakegyBCK21Yzb7vDbT8JPm60ANiFrjxkBhezha0VAzl8Up7B8g
         9QfjtnLWH6qgp/QVAmZmD5ONrFADDrOIt9QO4yrCQTycOOwbLXGyKu/uqM15zTLHh/Ai
         b65C5O2+7aP0WccXn3FnYcyZGGqSuhXyuDAGC6+lwlnGY3m9QXfMVuDzNyJBAhx0LA4F
         0SpXj1y9SOU40ZxRTTVPK9MXpPWfsgu7ON2PIxDD1c4U/kVM02t/mZiqSBHbwiHWZ0ku
         Y3BmeAECEKI+HTDb9LxWg83UHVywB7XeqDJzRoRdCLTO7WDliUeLdyUeuqUVFFZuaagW
         zrCw==
X-Gm-Message-State: AOJu0Yz9q7zaInI07f2GqWV7hzLym9fA8obquAXUcu+6A8TE28kInZ1S
	cy3cPWrtU+k16gnEAt38dNCnY3rKpP2Te7ZSLU6ljfKYV8n4hDce6JNyjnagoH0=
X-Google-Smtp-Source: AGHT+IEQ4RzcaSVKuZWf1d5zmc+zMCGSfqdSjPJejHbgWmHz7lHKuOUoWMbSaAcuUNshBgWUX2yUyw==
X-Received: by 2002:a17:902:ccca:b0:206:9818:5431 with SMTP id d9443c01a7336-206eeb7a4f3mr62719895ad.20.1725655518676;
        Fri, 06 Sep 2024 13:45:18 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae947632sm46491775ad.63.2024.09.06.13.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 13:45:17 -0700 (PDT)
Message-ID: <f3bd7456-a85e-4006-8bfd-4978c22b7ed3@kernel.dk>
Date: Fri, 6 Sep 2024 14:45:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.12
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <Zts6EDOzCgJrkFN2@kbusch-mbp.mynextlight.net>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zts6EDOzCgJrkFN2@kbusch-mbp.mynextlight.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_134520_568466_087BEBF0 
X-CRM114-Status: GOOD (  10.06  )
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

On 9/6/24 11:21 AM, Keith Busch wrote:
> The following changes since commit b2261de75212910e2ca01fa673c8855a535d8c60:
> 
>   blk-cgroup: Remove unused declaration blkg_path() (2024-08-16 15:07:27 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.12-2024-09-06
> 
> for you to fetch changes up to 7c2fd76048e95dd267055b5f5e0a48e6e7c81fd9:
> 
>   nvme: fix metadata handling in nvme-passthrough (2024-08-30 07:50:29 -0700)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.12
> 
>  - Asynchronous namespace scanning (Stuart)
>  - TCP TLS updates (Hannes)
>  - RDMA queue controller validation (Niklas)
>  - Align field names to the spec (Anuj)
>  - Metadata support validation (Puranjay)

Pulled, thanks.

-- 
Jens Axboe


