Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBC2C369DC
	for <linux-nvme@archiver.kernel.org>; Thu,  1 May 2025 13:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uaABwqc9FxG0muAe6duB9RUPRqrBuLHOHIHY0BVoZbI=; b=bVARon4PDD9jJc8/KfVHvYHCc1
	PWo4hTeyE8eT4TdErQb3gIFvYwCjgz2CKnMnwHa2FycKeoRLkGGTukmOMGTVbrcyLZUu86jJ3YE1/
	3NXuHhNOCfWXKsagBNXRI7nIyR6RbXAR/JlsFs1Amh16n4ychu8Eq67bDo79KwEjcR8KbvMYeq+OW
	zXJQ53xvysd7B/M1WJNEGkwTyBGgBHRGdlj1TFWzcFbQ5bq0Sn6cDq1e6kRRwrlBgjmX0XLCYjKHu
	wsEE9Iw0Rn6pMqbbW7WIJuuvejzu8DUhg2NvYFlgIHm/kaJ1DLeJ/MxG/yd+PoF5ojQnqe68k16xB
	l4Qc1+EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAUPZ-0000000FtWr-1Ld8;
	Thu, 01 May 2025 13:57:13 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAUOs-0000000FtR7-3TK2
	for linux-nvme@lists.infradead.org;
	Thu, 01 May 2025 13:56:33 +0000
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-85e751cffbeso90579739f.0
        for <linux-nvme@lists.infradead.org>; Thu, 01 May 2025 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746107789; x=1746712589; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uaABwqc9FxG0muAe6duB9RUPRqrBuLHOHIHY0BVoZbI=;
        b=hv8dYtgQ7rfXgjApDM0cjjLFN+6Enca6gY0PNuWztn6cgx+XA2TR7+b3xGVvqo88nM
         xxlhlgQxwNOwHkaGGhKEou+M5vUYbzwaExwTAGAfYL5XG9u9FztWg+IX2sG2ltDH75Vm
         zpUisO3TdjvLEHKYxtUsHgsDHr5JGzwODdGmEubBJmkXy/LQQ6omZaUt++WVqB4GSjW1
         SKU8bnUuzRd6jjFO55+cTIII4o1c1QReYuffjfEmChuvpx5oLAzNzoSqAyWYlGzUSNYr
         QXmlCffp8I7o7c5e+ysSxbv30Xlfl+JPUrcxHHCx4r8FqkoYG7Voy/Qwpp3PDoyZOTal
         kvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746107789; x=1746712589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaABwqc9FxG0muAe6duB9RUPRqrBuLHOHIHY0BVoZbI=;
        b=UbdiHXOPCYN8dOFvxyguTCf1Di48fsgwabVkrz1grBffGJb3fKEbKN5H8zoW7HTnbV
         6bQvpu9AOZJnTyNJHzAHGoVDkavpbCAsBtKvT0ccvyTd0+iq1oM44Z1h+CqdyoXHPLDu
         hcUxM7b04hCjQQvBDN/CnkNBEY5cgxUWEm5Vuq9hZqR+yP4JoLDxzEbV2oOlmoI7BcdW
         fEx46AwZmDJj6GdyMuwnfRaIj7rG/W2vOL+ftPhrzMjKRdEleECwJqcAQLqfETYHsfaS
         KtKcCuGkXYX8iSKKpLUxbuEtgV+LjQ+zm69Z02k8f9jT6GHvSQrWIdHWFkcJ0cMNgRNu
         TetQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi7k/CzpZ78X5oSfJLnr6Gzageeo0xl0sA0qvEM4LI9qznIvt6RDb1CX1Z75daOb0gMo3rQ8AxuzRD@lists.infradead.org
X-Gm-Message-State: AOJu0YyIhVtIARBGYNzdFZVCWclx4NQDkCmMemWpn+XTTfDHGOPgq9Eo
	PqEk9xl4wZgTKB7nLmZuamV622TR7n7sgLxx2JItOumbPqSmjMcxp1CYC95LQFA=
X-Gm-Gg: ASbGnctSE/OPasU5+kEPosVVtOUnsp7NWHnwGAtjAgmPoXNd5RPvJk5XRFe81fuQBUz
	ht2Z2eInUroIUA5buciM7z+rGwit0SoTSQVLBRQZZs/jwiQNIcpttkl+WrX5zsAmlVVKYZ6YW3k
	+8ntqVZAnAcjx90L+rvKU0LUHGxRcrPoAxflZjY8DqzrtaBVJFl0+M5/TjXBer/moR8VEJZhkzv
	kDmXCd1ogxfp3BDdg4dfLIsPAWW+LmsUwGpetC8u72d1KhH8yL572E9JIqw3eRCbrKkMKb7l+ZP
	iSnoHJhGZIu1x1CfiGri0U/5rPRRqcSs5GPd
X-Google-Smtp-Source: AGHT+IG/i7pQb+PvTRvTqzbDEDNfr03z7LE5aBfmX0n21LvvGc1XCxyZrk6fRkgjHYGMOifVRlXUmQ==
X-Received: by 2002:a05:6602:3586:b0:861:cb60:1e93 with SMTP id ca18e2360f4ac-86497f80ef9mr866736839f.6.1746107789590;
        Thu, 01 May 2025 06:56:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-864aa58979bsm10677339f.46.2025.05.01.06.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 06:56:28 -0700 (PDT)
Message-ID: <9e4e6afb-6b91-431c-8deb-aedf2f9e3a43@kernel.dk>
Date: Thu, 1 May 2025 07:56:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.15
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aBN4IW2wlSfRIfjU@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aBN4IW2wlSfRIfjU@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_065631_066589_5DDF0FE0 
X-CRM114-Status: GOOD (  12.81  )
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

On 5/1/25 7:33 AM, Christoph Hellwig wrote:
> The following changes since commit a584b2630b0d31f8a20e4ccb4de370b160177b8a:
> 
>   ublk: remove the check of ublk_need_req_ref() from __ublk_check_and_get_req (2025-04-29 06:01:36 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-05-01
> 
> for you to fetch changes up to 8edb86b2ed1d63cc400aecae8eb8c8114837171a:
> 
>   nvmet-auth: always free derived key data (2025-04-30 08:09:09 -0500)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.15
> 
>  - fix queue unquiesce check on PCI slot_reset (Keith Busch)
>  - fix premature queue removal and I/O failover in nvme-tcp
>    (Michael Liang)
>  - don't restore null sk_state_change (Alistair Francis)
>  - select CONFIG_TLS where needed (Alistair Francis)
>  - always free derived key data (Hannes Reinecke)
>  - more quirks (Wentao Guan)

Pulled, thanks.

-- 
Jens Axboe


