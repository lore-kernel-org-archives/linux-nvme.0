Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D43C54E60
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Mar 2024 20:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PYRKTZr+WkXIWH/qAlNrPKT3CFUoOmxa2ERFXSZxcE0=; b=JVf1EApSsRg44VgBOFEWGO0YCS
	EwNsPxYx2qinMpEoevgZpyus5jPcDdMQ0ozuivNSFLBkQ+8Bs/qVMou8uQa7VavTsuxQlC7lOU3C7
	+nqbqNnJep5X5V6NjZATQA+ROc6BryHOpyQV5EBtRQRdzVanVpMZleFjXlIpJkTEVlaKEQS2trNxW
	1av1ae9zKCIHhNhubjI54aQrWit/1QCmSCkUy4WloggaOv4zg5A6Y9QyDG03mcJPbwigeQwicOLTU
	/m/UFwI82mmyM9TXNDVyIH1xUgboW5JslzGIvHI6xhwLzMimYHcYVOd26a9dLRkOFW9eMGT+M6WIy
	CKXgNU5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkUu5-0000000Bles-3nMs;
	Wed, 13 Mar 2024 20:08:45 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkUu2-0000000BldV-1T1K
	for linux-nvme@lists.infradead.org;
	Wed, 13 Mar 2024 20:08:44 +0000
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3663903844bso417975ab.1
        for <linux-nvme@lists.infradead.org>; Wed, 13 Mar 2024 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710360520; x=1710965320; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYRKTZr+WkXIWH/qAlNrPKT3CFUoOmxa2ERFXSZxcE0=;
        b=AQMFnNIOQ5Uu9z2CP1A8MaP50aD1Ul2XM/8yhusCcx6Q5Ptf8moiaGsj7UNrTRjMQR
         cl3aCgKvCW+OnT1HO1rPlWF2/Oyw8SMdwbrlyFtbwMKfJ9Fg96C6kt3XDkUcPm0I2/t6
         1W5HWurMGvURzb3MT1IWYZmXa2nwzowcAixgz2NqSNpiIMvzIrlm8szqEKRToZnZAt4Y
         fQ/2pYX4ISmEbTVJG4ZIff6m42gJHPKPyRq/iK00b04jSWUzoUA3MvWvtnkpbUiDz/G5
         7GYbE//Fa4AkZPt56N+d8LVYCKBl0Mts9KLCPtRd/i13efrz+KLFAWr/0XFqPPdPU67G
         l4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710360520; x=1710965320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYRKTZr+WkXIWH/qAlNrPKT3CFUoOmxa2ERFXSZxcE0=;
        b=r0EpM7vBIsngXP8X+j+5xr2h9BV6ohzYt5t2pIdKDw3GafpbI3X+g5lftui36QsRKM
         Dr82ovFGa9ZFa82DBN8j9HWIIi8WOmkviXFA8t/xpNT1U+Ewu7FDA72Otu/kETvqMv9c
         UdwfY7NHAoCFAqRT+u8ot+S6lQdvCLuouRp14BEEBJwYFkmjqcZlcR+iSGJR9QaRNPQl
         nY6UJobZHzF3q0aSGpeCed4Wq38crx7EoZksBcxUkTbaBDPVm0s9vAUM0DEyx0lfuMzT
         GwvGn4iPLx3F4FJo0PjqwPGH0fd1mGcUfQXhM8JYaDO9ibwB0eew8xAgUM9YXdaPDWzZ
         aC6A==
X-Forwarded-Encrypted: i=1; AJvYcCWZS0ytxWzoWm27XUkVorrI/wTL5bV+RtPVQSnpACkK+ZT6mGBZQ0knMx8rNHzQzvd45LuSibGWrHWyEBDnU7Sv85YkQWHMG31SLEp1sD8=
X-Gm-Message-State: AOJu0YwQD0qvcpSZYYtyXl2BDECsxWHV1zhYVyHnO7zKQj3m1VhqEzSi
	LmU4/f2hZ9FZREz42OhRtPk07spJ8MSLqIiY7lcAyD5HVjZb/LumwUDLRHJrsxI=
X-Google-Smtp-Source: AGHT+IGTEj4clyY6rU5vULjDfU20/b96kofSa2jdE2U03Aqzu4dOnkhxxtYL6A38VATDXsgzNgguhQ==
X-Received: by 2002:a6b:7804:0:b0:7c8:789b:b3d8 with SMTP id j4-20020a6b7804000000b007c8789bb3d8mr35336iom.0.1710360520411;
        Wed, 13 Mar 2024 13:08:40 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i23-20020a02cc57000000b00476e8efd3f2sm1988895jaq.155.2024.03.13.13.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 13:08:39 -0700 (PDT)
Message-ID: <fc81a1dd-8097-429c-8e96-86f2187cacb9@kernel.dk>
Date: Wed, 13 Mar 2024 14:08:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] block: move discard checks into the ioctl handler
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org
References: <20240312144532.1044427-1-hch@lst.de>
 <20240312144532.1044427-2-hch@lst.de> <ZfHI5Vr7BOU6__rv@kbusch-mbp>
 <20240313200621.GA5756@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240313200621.GA5756@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_130842_427341_AAF05688 
X-CRM114-Status: GOOD (  10.42  )
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

On 3/13/24 2:06 PM, Christoph Hellwig wrote:
> Also I'm going to wait for more comments on the approach in this
> series before resending it, but we really should get a fix in in
> the next days for this regression.

Yes please, sooner rather than later. Too much fallout this merge
window, and I've got other items that should go out soon too.

-- 
Jens Axboe


