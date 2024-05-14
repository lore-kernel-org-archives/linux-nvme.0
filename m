Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A35FC04FFE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wYWPYITnciYVF7KO1ds21zpFQI7OxHzXJ/DI96Oak9k=; b=lqvy6HIGPu7zf+wptotjlDgj5E
	SSKSjRVYg2vwBToaABgZHxdEKWvXbtInBC1c4WQ6GHQ7nfNZj7FxaasWgkzvrRg54DohqksJLZ9uZ
	rHdVsFRZ2kQqcqxSZYYzazeHEH6Doa4BFc6LZ40WbX6llATH1qpgt21TEio7KU2id6TqNPcU4pCf4
	8+fV5AleLs+npu2uECu+CkUL1eZ1BGUwZCxZrbowD+XThZOkwLrr10DpERCknh2V3EJwE5lJxc4zD
	V617FL15NME/jKSosCglMgX+waU+9Hwn2MW+EVpnmGpe1v85rVmxrlV4PKfYkcqm9W/egfeytsQCj
	6X3UYV/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6u6r-0000000GKr0-0fBi;
	Tue, 14 May 2024 15:30:33 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6u6o-0000000GKqS-1fEC
	for linux-nvme@lists.infradead.org;
	Tue, 14 May 2024 15:30:32 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ece1f3c626so2459525ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 14 May 2024 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715700628; x=1716305428; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYWPYITnciYVF7KO1ds21zpFQI7OxHzXJ/DI96Oak9k=;
        b=hw2kxLh8Lm/nmDP1gnWv2ZUjfiJGVvGXxO1z15WeZ2TuGWby7lLXkrS2Zq8cVxlNOE
         13PLBtqZE6pXuhsSm7ykLFbEYFG92v2OQm1XmHfxvGSGt4rE8/qKGekze9RWkxNxbI2K
         x8x20pCxa0uoA9/OwvctDpcciRWq1js0OD9bORyEBRE2k6dzg7YqC4d8WPLaGb6fwYBe
         01wfK9XHA8IL9v3Wg6nRCh9D4kGoahvoYMHRVP6Ja+njbsHK9PHPhhWBtsbZB201Pm5t
         M9hbO1ugwmdkaXk4p/14QCQwHN8afb1kpweb5ZjFdIJBQ/DDY+eI+OOT0GbKqd6k3xig
         tQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715700628; x=1716305428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYWPYITnciYVF7KO1ds21zpFQI7OxHzXJ/DI96Oak9k=;
        b=d270Q3TShPKI3+E/4+jEIhAOnHtjvqim53sXSpPJwErfqgvqm//rnOdfV1fYt1sWpt
         DylmgHWYY7x2NC2OXR2L+gSh7ZjRyWrJOQO2KIaLVhFCqd26MN2bBn18sZevFvKOF2+1
         1Q6HpD1tV3nFURZJJU9T2MlzKyyuUzCr+z7KlIYKi6QknCl05j4J5B5IAaPA8g+mUGIL
         g+xzyZ5A6YbfQiE4fUtZGKXwphWIu0tXKRd85MF0acXl6tytOoxBvuMlUXjBlqIZsKIb
         M0H5N19F6kKmATpokN1Go3ChzjICcPITQ3JZDl1F1Ppq9lxa+WwzGYcTPD7B3XAyQcpf
         QHuA==
X-Forwarded-Encrypted: i=1; AJvYcCXz+q7iCRbcXVK9plS4v2d4W+3KJ109JAJYzn9B0IuSlwuvV8vbNmLZBbOCTL0o4C6VLKWkQstDNaRwOFbi+ius38A9EV7WhBPzBNMpwuU=
X-Gm-Message-State: AOJu0Yw43JhdbYJL2mP6jZYDOjMmuhGBbcpVFdpqTO1F22xyQM23Tf3F
	0fRH0HyUisJDAr5FiPneWJVvF8ZmySV7IZAAn4yGv6CQ6k/Dt+NZkphWgcx2aJw=
X-Google-Smtp-Source: AGHT+IFl4sIZlB/uUrWgukj4iEh829NcR+MJ4sDd35/7y0Kynb7/nmJH7yhdJO76A9IM0vUWvWr7Bw==
X-Received: by 2002:a17:902:da84:b0:1e6:626c:f373 with SMTP id d9443c01a7336-1ef433d3066mr167164355ad.0.1715700628325;
        Tue, 14 May 2024 08:30:28 -0700 (PDT)
Received: from [172.21.2.105] ([50.204.89.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c264e68sm99060955ad.302.2024.05.14.08.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 08:30:27 -0700 (PDT)
Message-ID: <35b03d8d-fac8-44b4-934d-f93ba7866ee8@kernel.dk>
Date: Tue, 14 May 2024 09:30:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.10
To: Keith Busch <kbusch@kernel.org>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org
References: <ZkN-QMZ9qE47zhFk@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZkN-QMZ9qE47zhFk@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_083030_523990_D8DE26C2 
X-CRM114-Status: GOOD (  10.51  )
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

On 5/14/24 9:07 AM, Keith Busch wrote:
> The following changes since commit 6ad0d7e0f4b68f87a98ea2b239123b7d865df86b:
> 
>   sbitmap: use READ_ONCE to access map->word (2024-04-26 07:40:28 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.10-2024-05-14
> 
> for you to fetch changes up to 54a76c8732b265aa86030134d4af6a5a3c59fe52:
> 
>   nvme-rdma, nvme-tcp: include max reconnects for reconnect logging (2024-05-07 08:50:37 -0700)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.10
> 
>  - Fabrics connection retries (Daniel, Hannes)
>  - Fabrics logging enhancements (Tokunori)
>  - RDMA delete optimization (Sagi)

Pulled, thanks.

-- 
Jens Axboe


