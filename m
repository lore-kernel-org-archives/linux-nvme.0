Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4167C3DA4A
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jul 2024 14:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B4gLEWOhBBZePEATRyF+n476aoTs9cAAFkncKCl7z20=; b=V3Wh1CeEXgxPd+RFuhkCwlmRnQ
	P0lF4vZ1CqXZasxsi8Y/TuG8WGkucRk1snc/rTERuUmOOWAuKk63Gwi0vYHiQDXICcbOct2ht7RM0
	hdoqPB9VNqMiIaEediWkopXRzIhn/VzIpbWQODEayfM6k00ozJsNVRhSj5gAny16d5l1NsxzXy9B4
	DIk0OIXUgbuMpwzO16DjWjgRN52NTFB2EEhUlNRgu+xGwud9+0qrrfkDXhM84yjdNUvHPmf5ve6hg
	uSr0lmux/naJ+YnljHS9uGoSImvsKuroGyuuF8yz9lJOxJfeoOUMneuGmoufJjMQUEvYB3qZQgkNb
	FL6ZRLFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXLaq-000000045hs-3OPy;
	Fri, 26 Jul 2024 14:06:48 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXLam-000000045gb-3SWU
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jul 2024 14:06:47 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-70d2357df99so13244b3a.1
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jul 2024 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722002802; x=1722607602; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4gLEWOhBBZePEATRyF+n476aoTs9cAAFkncKCl7z20=;
        b=yiLv8w8jIIi9D19tEtHafk975PqTpNEGY0G0RhK5TLltLPpC6oRBB5HCzG936hi4kB
         tA42Srjt0SxS9lPeDND5/s3U0B6LNcVy8edvC2ABAky5t4OJSWEWlM2/g/46AqYEN+CU
         WFNm97FoaAXMQt8kxmRHRtRUMF4GHkdGYKJ2jAO5CBz4+ZjgzeEStw8gXt7t6I/I2Wmn
         +ANk6DDNcpCGStMACqw1FvolQm96DK5baj5PDSPMhP9Bh+Eeekfq0iIU4ucy3++ZWE8t
         4L/NpdmhAwoOcSGBlxNTCQI592WtSsgU8i5kYwicaqaNCDnTI2SZhW0kBXNcflqpl9p9
         d7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722002802; x=1722607602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4gLEWOhBBZePEATRyF+n476aoTs9cAAFkncKCl7z20=;
        b=ZRAI+EMlOmHkKNLXeW/YV3HsoN01BmB8i7e8fCYJqybp2p476+9m4aPdOuuHiEpFya
         g/ML5O2H1b2fFgm5eSGmGWO4eL7wT/ZkhRApYZnDRkjHOjY1heit3ktRLm5aVIsY30e5
         fGXqSazaig2ObWmzJdnwbY3rNIMBndkvwpKQ7wj1ecO4aS+3X7krAsYgQPM8DW81mo9r
         v9IEWaV4LvZ1GVWZJwQOKInPG9QKLpQyO7Xk5iAuhcE2U8i3C1+2I2DvHabT+GDaCxXD
         hh5RsBdukPa3ooNcxzLolE6dnNJ9117lRaPibCw8mxrjGeQwxZGihS8LWCWr+8Y3XIG6
         vMCA==
X-Gm-Message-State: AOJu0YwLBRVFsg0S42NtyWFYS4NPRUzPD4ZC1uzvCEH2xeOzDx1UoxPx
	GfGJuMl+cfGaEJ053q6w7bIpmk54t5EP7/60v21LQvyxxqxJWp2SLoMPUasyBjg=
X-Google-Smtp-Source: AGHT+IE6/yUZk21dRlHhgwICETo7e5nBX9BT2u97DMyRWcg3C7/Pu6wEYdRRAVALGm8LDXJjsKO3CQ==
X-Received: by 2002:a05:6a21:9218:b0:1c3:c1d0:227 with SMTP id adf61e73a8af0-1c4774d95b0mr3771615637.8.1722002802544;
        Fri, 26 Jul 2024 07:06:42 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f7d6b09dsm2810572a12.10.2024.07.26.07.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 07:06:41 -0700 (PDT)
Message-ID: <c8a2b6ac-2488-44b5-b332-3a5b92ae80a1@kernel.dk>
Date: Fri, 26 Jul 2024 08:06:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.11
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZqOs77uDJQGEFHf2@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZqOs77uDJQGEFHf2@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240726_070645_022534_3B8AF7F8 
X-CRM114-Status: GOOD (  10.12  )
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

On 7/26/24 8:04 AM, Keith Busch wrote:
> The following changes since commit 8e64d2356cbc800b4cd0e3e614797f76bcf0cdb8:
> 
>   s390/dasd: fix error checks in dasd_copy_pair_store() (2024-07-15 10:57:39 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.11-2024-07-26
> 
> for you to fetch changes up to c31fad1470389666ac7169fe43aa65bf5b7e2cfd:
> 
>   nvme-pci: add missing condition check for existence of mapped data (2024-07-25 07:20:54 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.11
> 
>  - Fix request without payloads cleanup  (Leon)
>  - Use new protection information format (Francis)
>  - Improved debug message for lost pci link (Bart)
>  - Another apst quirk (Wang)
>  - Use appropriate sysfs api for printing chars (Markus)

Pulled, thanks.

-- 
Jens Axboe



