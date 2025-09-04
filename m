Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAF6CA1002
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 02:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2z3DYR7+xWWVIEscz4ZRJaycpM8dB66/vijSmIfd2q0=; b=LV4kBC8aAhxHfUAWqUC4VRrSW7
	W5O/TwuA7zpo2NfBrRt299cG35C0jPLt+jV0b01gq1IyDWanjWimsJrznP8l7ZzIfNtFyaQpL8R3O
	CBtQ1uLinW5gdQHI1ZhmLhQD2BF7eh8JVGu+UTODnYw1xGxDFlrVFdKB371UQNbOa2ivvbu2C3Cpn
	EmjUX5R3kYla9ALXfY5R6CAKbHlFZNDyyew5el79HqZdiICLhZN8XZYlH2Kiv0+VUY3I9TLvnVDRS
	4bZMj5M//Z0SWIbi8hNGMsmviw3ZTvNEC+NUeXDvuzlUU/U9DeFy2bhKvkDL0TsPfj/s+fYxHhJNf
	CNO1+2vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuM6a-0000000G5hB-06Kn;
	Fri, 05 Sep 2025 02:23:12 +0000
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuJHE-0000000F7GI-05uF
	for linux-nvme@lists.infradead.org;
	Thu, 04 Sep 2025 23:22:01 +0000
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-e96c48e7101so1695552276.2
        for <linux-nvme@lists.infradead.org>; Thu, 04 Sep 2025 16:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757028119; x=1757632919; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2z3DYR7+xWWVIEscz4ZRJaycpM8dB66/vijSmIfd2q0=;
        b=swNW6JWEFfJZM9/D3Y7/+Rr7p7ERaKpVV/4SwotoQY8y6pjRUyGw9G9GrvAa0bloqw
         2LexG2EhJkTQvzDDnxZaeXjzKELhfyeTJpjU+vGAWeWpJ8uvWt/aKg0N+hCAHL0EBkhp
         A96z/ED4wgMd9D5LvnnoXQxy3G5FXSRVC0nxZ1AqEHpBs1uN0sDBDZeyABdoLivbm3c9
         4BqPU8P977dZlUsQLyUQBH9W/Nyqst7I6/iH2a33WRU+0nmjvWNCjQVd2+/gec4K5VNk
         R1c/I0DmeBBJc05PxPuieXVRDBVOtds0wonscjG1PtCi9EpxoDzNNp3vUCd7P5ypDrQr
         qVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757028119; x=1757632919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2z3DYR7+xWWVIEscz4ZRJaycpM8dB66/vijSmIfd2q0=;
        b=O3l/HcJ7nb6zE82w2ZQxVRwzcYrvPvDI78iOqVEpSQDw30kRUaGo/QYTbtmBvHqEwC
         MsvThreEgrJMcjl4fIGRRJXabe7OhaChhpOoMcKv81yi3dXy8KD0maeHdHbitZbCq+R8
         g2XJTn612iLHztxUuNmFpKfIzyYKH1NinM7hHLilIFKGF6K2qcPl6hDGLE4SYQq9kGTW
         PW6TFwbHu0KBfFZu5/QBQHmLlPvXwRXnHXIEo4yWF5E6m8rkAoTbypv/kzw4roOxeloM
         py2YYIAfI3yKsXr7kvLW2WsYwoj/BvsVT77VXDkX8zLSqsJTVfG38IHBvOQOPDptiSRK
         /siA==
X-Forwarded-Encrypted: i=1; AJvYcCVozvHaaVZQ/AtXtRAxoOk5leyrAEmIZKp5EKFcZ9ZLhK116YMVUlfN0LTDo4k+VQ1OUe1zL9qGMk6s@lists.infradead.org
X-Gm-Message-State: AOJu0YxDw3KSoC0r50ylDYAD2RACy3C4Fym4sgXpaFrgp7BeQBYGdewj
	PaGv3H0d4ub6k4em0Z3+pB5u7Muxu7jUxXEXL6ow1K4gCXBElGzaElQBSskzrlgJAbs=
X-Gm-Gg: ASbGncvTcJ3luPi5PFyU58wi46UCrPTJUTkjdH4m78/tAJTtZQScPIxH8m1Ho2a+1MS
	nCLGwlgNk2ILi9Q9LDT7byhro95hSpwp2ppiSfeeCCouvIXXyukrA6cUOxLKLPDwO7mYE4KbXl8
	gz9Kv41izQp/3hXcJSmQL1mRUzFSySXaXaE12dIgGwOeHze2r8dnUKqItvOUstDTBormKjb/j3t
	dfq6sdnl20TV8/F1Mywj0MH0NrigMBz+2yTkqWYCL8DSvQMRSMnMQorT5g/O0FdvQ/DdeCQ1TSO
	q24Ju7Q2YNNnfV19El0Jo2z+xkNZIkMC2yzhoa9xGK0ANNj8x62G7A1nS/hSpqUcQ+x84ZdEhHG
	Cr/NvCQ90jOYe6jUrN80SY3SzWujI
X-Google-Smtp-Source: AGHT+IFgvKKlym1ZWpYTNdLBeg/2Hf5YztChNEzZr0vnkHNk9DxfAjMrTDl+OboCvNtBgpROZLE7BA==
X-Received: by 2002:a05:6902:18ce:b0:e96:fac0:60bc with SMTP id 3f1490d57ef6-e98a58455f2mr20947572276.41.1757028118723;
        Thu, 04 Sep 2025 16:21:58 -0700 (PDT)
Received: from [10.0.3.24] ([50.227.229.138])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbe19ae0fsm2694267276.30.2025.09.04.16.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 16:21:58 -0700 (PDT)
Message-ID: <bc62770b-a4a1-4bcc-81da-a9589ebb5849@kernel.dk>
Date: Thu, 4 Sep 2025 17:21:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fix for 6.17
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <aLoa8Wt-yN_rSS45@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aLoa8Wt-yN_rSS45@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_162200_069312_58CB388A 
X-CRM114-Status: UNSURE (   9.83  )
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

On 9/4/25 5:04 PM, Keith Busch wrote:
> The following changes since commit 95a7c5000956f939b86d8b00b8e6b8345f4a9b65:
> 
>   bcache: change maintainer's email address (2025-08-28 10:05:37 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.17-2025-09-04
> 
> for you to fetch changes up to 7ac3c2889bc060c3f67cf44df0dbb093a835c176:
> 
>   nvme: fix PI insert on write (2025-09-02 12:21:42 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for 6.17
> 
>  - Fix protection information ref tag for device side gen/strip
>    (Christoph)
> 
> ----------------------------------------------------------------

Pulled, thanks.

-- 
Jens Axboe


