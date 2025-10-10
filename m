Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AA9CCD185
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Oct 2025 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vbofJ5TYVrlVEz+XdSpL9ID+J57K1M46jTnGkwllw9Q=; b=eRbb11IxR3lSh30aNTV/twEEy8
	iGcS1+It7VtV40m+sKs5JNuPnK2IV1m4xgp5wlvoXL7cD/d6RPFGsuWCS3Wkxa2Iis/CzGsYNlxRp
	pS6KRJG28UuHrO7LFvs9sdMWDKLxC/wkHlnNE4wbdzfD42GubPLvCNMkTfzw2W/4J3nB3LpG367X2
	EbgBxNFORN4cxeezZooAu10sT4UpqkHCLmPx+WbICRytN8wWU/NeZIIUBFMTIk+zjflDOESA5L6jb
	WIp8qScdxPI5EhE6jLDAguy1/2iHz5Qt7wzJF+lupMay4OGQQhygW3up3FgbStwEUImZauTmJpDMI
	XfqkrmdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7EWC-00000008jsW-064s;
	Fri, 10 Oct 2025 14:54:52 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7EW8-00000008js9-36p9
	for linux-nvme@lists.infradead.org;
	Fri, 10 Oct 2025 14:54:50 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-b62fcddfa21so1359640a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 10 Oct 2025 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760108088; x=1760712888; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vbofJ5TYVrlVEz+XdSpL9ID+J57K1M46jTnGkwllw9Q=;
        b=yNvNXeoZwLpKRkLYLsaHaqozwFc3Ovkm+ykzRUCy+2EH1rnmjEujWTuHna7016P9wq
         QgbRkq+6boutRdTyc97nNgciBwkjTwjOoChVkY2Zl1Tynf7DaG+vKVgunlox0oRrJRUt
         KD/d1T70QNvXBR+kBdcY3O1u+xB5Hm0FCrXsMcPCPK3om8RjfE6JYHRRwuFL4tnFK1ew
         7wO0w7FytbOoUHksgX+Gb+6n/Cte9mWU58VASN6OYrJP1eSyTs9sFpZFCWF+nH6QPXUj
         g1noaMAkr+YXezRYcIAb4j9bX0sXk3Wb228AshoUGomuSCkz6ILlg0DL3QJ3iYr7L0qW
         +eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108088; x=1760712888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbofJ5TYVrlVEz+XdSpL9ID+J57K1M46jTnGkwllw9Q=;
        b=CuKcBNULY66z66ehqRW1hW9l9roLjvVe3e7MgauoW+STqIom7ythuuslc5xRgbnGJa
         B7z2Eo1JAD7MDTaubv6q/b0qEJ3PYUZQz+bPu3ZxuDBznUMi98p+roXHTVGVVeIG5E/m
         YQGeHSkQgB77/p96GqZmDQWXQYxixNWYEkB2xsOuyFTbCEcPoM4oTukT/E4QMJ8HhsEy
         EBXNJt4UFqShz3Hygtpp1jlGnnIfkXwEi1lREJnFeZmcmvhJdTojAxiLQ6yFSSa4vkBl
         qy8d01LQH+yImiDbjhprsc3vDppn6N1kLGc904KEXqh5Qz9kskdbxvA2lcEPqtKvZimo
         GNEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVplwGzqHYg5h1RtGbDSnTYGc4hygMhrN/apyEveYkir6WKlzHcl9q4FrWzn7Shlv66RnvV9ywt5z+t@lists.infradead.org
X-Gm-Message-State: AOJu0YyyPBMIVoqZIgNYXtarzE9N2hi7QgWpFFxY9nQvD+mkm4s0376w
	GHsbfCT9kat2gSEWHY+1s7EYqK9BsiHcz8fIcDGtXfpO7ijaXh77KmUxA2VB39SADTs=
X-Gm-Gg: ASbGncvOHGSixIvpLX9F6LU2KO6Qz6tV5GMVOWhHrfFD9U0qR8T/UCDi206Hy0Y4v7y
	wzXOBxKHPDk8E1sJZoP2uKvZpVoV1G3EGfuBO7hxZjvKwQgpq8CULJjXEc5ZgVmkcoyBsKfC2ML
	vO3pvxndHBgT49B9fi/uzQRUtbgWhzp9jNkPYiIg9iaS6IuiHSzKXkOcjvifWuIoqiuYRXFxpNf
	kMx1h6fZ93ksZXJuSHFwFa+HhUIUYo1ToDbRi43nTUFr7ApSoxLZ2Bpq1K1LwPRqJtPs93gzMLh
	ARM5L/5Tgas8g2jeDAIQdvS7k4Ch6rawlkPkf6bHlowRPhsoi3/F1L8AZptYuy8T1gM3MKIXB3A
	lu0O1ejAEJ72wQ5ApVznhIr+bjSGNSea6MhVdx2Dxu44wI2FuX+lLR26aTzYO
X-Google-Smtp-Source: AGHT+IE2ykU3JRpPiQHMUmIjNKSKo2rlX9PQObXBs1FO64lFOyXHQeDzHA7ctCDQl2YOXgiwg7ruvg==
X-Received: by 2002:a17:903:2292:b0:24c:bc02:788b with SMTP id d9443c01a7336-290272e3debmr174061055ad.44.1760108087677;
        Fri, 10 Oct 2025 07:54:47 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29040e02648sm26130335ad.116.2025.10.10.07.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 07:54:47 -0700 (PDT)
Message-ID: <cf4e88c6-0319-4084-8311-a7ca28a78c81@kernel.dk>
Date: Fri, 10 Oct 2025 08:54:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mainline boot fail nvme/block?
To: Genes Lists <lists@sapience.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251010_075449_020402_64696327 
X-CRM114-Status: GOOD (  10.64  )
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

On 10/10/25 8:29 AM, Genes Lists wrote:
> Mainline fails to boot - 6.17.1 works fine.
> Same kernel on an older laptop without any nvme works just fine.
> 
> It seems to get stuck enumerating disks within the initramfs created by
> dracut.
> 
> Subject to bisect verification, it may have started after commit
> 
>   e1b1d03ceec343362524318c076b110066ffe305
> 
>   Merge tag 'for-6.18/block-20250929' of 
>   git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
> 
> Machine is dell xps 9320 laptop (firmware 2.23.0) with nvme
> partitioned:
> 
>     # lsblk -f
>     NAME        FSTYPE      FSVER LABEL FSAVAIL FSUSE% MOUNTPOINTS    
>     sr0
>     nvme0n1
>     ├─nvme0n1p1 vfat        FAT32 ESP   2.6G    12% /boot
>     ├─nvme0n1p2 ext4        1.0   root  77.7G    42% / 
>     └─nvme0n1p3 crypto_LUKS 2                          
>       └─home    btrfs             home  1.3T    26% /opt
>                                                     /home             
> 
> 
> 
> Will try do bisect over the weekend.

That'd be great, because there's really not much to glean from this bug
report.

-- 
Jens Axboe


