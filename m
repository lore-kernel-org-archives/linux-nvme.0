Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA3CC3601E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YtFSJRLfiz+ZS7/iNWwK6CnodJhvI/BHKt9iZYwqij4=; b=sD7+pmNsffiSW2mOEpZpx1TTHd
	pv/e/PH2UlTO4Iv1PhhEZUKbhX5YPf3GMIu3pq4KuYTzv6D/P1Ke3AXp6Woaxv0Hru2ObQNHFkoF/
	rpTkNt5fGmgxFHOvvGtQmPtQdicVI3vPeHMN8tVgZZZ55CAlNyvp9JjN2Ne2yjc7z3/j4a9MUJez5
	5vx1Bme+B+5DXTxPx3SjSqC2n0x3TvL9wsfsO4flm1cWcoFNM86WLotyLPp5jasNCRrAuAYcAbUEV
	Bz+fZ/yqNDi9Q2lnyPthoEyrSN0T0msYBCHzq175cH81X8LRB0P1XWOsovXhhNYR6zJlrqguyu2aQ
	aHD2XF6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2v2C-0000000BFex-212r;
	Thu, 10 Apr 2025 16:45:48 +0000
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2u0s-0000000B3Xk-1zhn
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 15:40:23 +0000
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3ce87d31480so4319965ab.2
        for <linux-nvme@lists.infradead.org>; Thu, 10 Apr 2025 08:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744299621; x=1744904421; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YtFSJRLfiz+ZS7/iNWwK6CnodJhvI/BHKt9iZYwqij4=;
        b=GWp0+Q1VuOD3JnDSab0Ebtgzrs7mgwmw4mB+RapZarCwC8ZmB+FvycInRHtbLlU5ku
         j5Y7fcq24tAsNAOxvdB8otWLkTRXmkEjoTi1VOqHiIouCmqUaYVgIZbKUDfhuMFU9wET
         PbHpwkJhaO+RdQWpdSl4RyVjzvV8g1scqqtHJbhfToG2kGRVdu9ujB7cT84QDCExqCFp
         AnFrH3e5fKFQHKTkk9rCvCBIv0c2K7jrFOqsHETEDFRYxAfKliWS5ISLKsv6NrtGOE0f
         qvIh6ELJd3XHOIGqs7yVt00vEYNSsYZxZSNsu/GTAHuA8pnKDIt5cpgVaptVNV38vDd/
         lS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744299621; x=1744904421;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YtFSJRLfiz+ZS7/iNWwK6CnodJhvI/BHKt9iZYwqij4=;
        b=o2elJ6dOJSi7EWSTpl5HgTZuZ/MoLGHoLl0poY/UsVHJKqzLcIWFtMGHSfyHn6EUjK
         62qfi27XFK9B6pmRhdXoCU0dLVj0TaT2QQZXihojdRDPtBLq3qmMj1poJFVyJTdwaMkY
         XA/+S+Bj/vM/A8R24pewuUbw1K87cjjI1QAmG71bmHkuFZnTbJh4OHghM9gwzz/Nxm/u
         0JI6gqZYHESe4pUBj7vx6EbrKqUWpmEzcHNSwdobXS8ZxMJ86j08y4pq1K29z1pIR1C5
         2vaB3Pi5I6qlbXGKHkqCzILT2PDksvmwOdigv0SZNswCa5c9nir4152d7Tn91A54hvHb
         WkEg==
X-Forwarded-Encrypted: i=1; AJvYcCUw9xSvuIngdF53z4jycm6xskznheAFrc4II4kmFskoSbeMCMviOA7eUdxA+459LQoVZL3axxD5hGQX@lists.infradead.org
X-Gm-Message-State: AOJu0YybfJdndR8d2B6YTMZ06KFYmhLytR8z/2P5l3E/OZ7hXuw9OdJk
	eQVJqay1GHMT6japYs+V9W803ySi2ilAhT1YKF2noALe2aOvZ+2Wi9R394YXe+M=
X-Gm-Gg: ASbGncsiAcMeIlJHU0qC/eAo6hWLP790+en/HnA3K+dQBy2eV/iipxmBydjvFttORvo
	f9x92uExK37eYtz7iM22xs4QNocbmJH+7DROa0/D50/Y+M0jpfZ9zo7Jg0SyZS79yRwrGCAgQRH
	G5Xe2VOWPeWf8mM0nF4zkKoaZuEk/WVD5FZ2AWJFfxGTRseBwppmQL0T44V0GYfPbi5jcYKakTn
	JOWTQY2eQ7gIqly43UlnT5ZXUmN1e83KmTn4pqRfqTmeM+jc/vxWZdhK/5lQokXLkgR+b8nIIss
	h9k2L3e4noxgonGgZSjGUUPUZtmCc5U8/tUf
X-Google-Smtp-Source: AGHT+IF2bNT932I4gwJmrF6Z41TjY0uWt9mh3RWMkEHxOBFXNmolae6NlhSUy9V2Sp+pGJZrzAfQNw==
X-Received: by 2002:a05:6e02:1445:b0:3d4:3d63:e070 with SMTP id e9e14a558f8ab-3d7e47747f8mr33547955ab.16.1744299621349;
        Thu, 10 Apr 2025 08:40:21 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e026d1sm790693173.94.2025.04.10.08.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 08:40:20 -0700 (PDT)
Message-ID: <bbe9bcc0-a4b0-4f47-a6c4-c5cc50b5e463@kernel.dk>
Date: Thu, 10 Apr 2025 09:40:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.15
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <Z_fdSjFqscMuzxYq@infradead.org>
 <e613a857-fba8-4e46-8879-d791d37095b0@kernel.dk>
Content-Language: en-US
In-Reply-To: <e613a857-fba8-4e46-8879-d791d37095b0@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_084022_526152_BE8739EE 
X-CRM114-Status: GOOD (  13.30  )
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

On 4/10/25 9:29 AM, Jens Axboe wrote:
> On 4/10/25 9:01 AM, Christoph Hellwig wrote:
>> The following changes since commit 72070e57b0a518ec8e562a2b68fdfc796ef5c040:
>>
>>   selftests: ublk: fix test_stripe_04 (2025-04-03 20:13:38 -0600)
>>
>> are available in the Git repository at:
>>
>>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-10
>>
>> for you to fetch changes up to 70289ae5cac4d3a39575405aaf63330486cea030:
>>
>>   nvmet-fc: put ref when assoc->del_work is already scheduled (2025-04-09 13:03:56 +0200)
>>
>> ----------------------------------------------------------------
>> nvme updates for Linux 6.15
>>
>>  - nvmet fc/fcloop refcounting fixes (Daniel Wagner)
>>  - fix missed namespace/ANA scans (Hannes Reinecke)
>>  - fix a use after free in the new TCP netns support (Kuniyuki Iwashima)
>>  - fix a NULL instead of false review in multipath (Uday Shankar)
> 
> Pulled, thanks - since this is late, it'll make the pull next week for
> -rc3.

As it turns out, it's only Thursday today, for some reason I was
thinking it was Friday - which is also why I sent out the pulls this
morning. Wishful thinking...

Anyway, I'll shove this one off tomorrow as well as per the regular
schedule.

-- 
Jens Axboe

