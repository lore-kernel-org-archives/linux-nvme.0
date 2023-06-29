Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBA0EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 14:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2+V2QoP1g+tUtgNa3Zg1YUxv30ED+AV1SxmDuok5KeI=; b=rE5Pavs8AB7wBXhdc17YflnZfk
	byyWphBGUR46aWKbv7VLKtKV6oPn6SgOAqpbn4PhfFUIbju8nY+dMvdPBPEDHSh+NZoLy1Qip8D/j
	kHAh0Bv8ZA00CJ71sxVHZTJZv5u4OHG7htdlZrdv3M2R4jkdCY/5IboOkHUY8M9ryZpIRRCz71IDI
	Qij4yzxl448m08zHhSWwE5VOS0m4NtcykVZzbe3+JDTUws69+qC26ClDznSsedi1AvDZZwnjAFCXC
	oO6ZJrlDqfxsZOxjIQ5b/eVfTQUy4w2SXm/IZFPGUp1KgMbXV2r2AZMEUuxgOBROD/J19EbA2dNDA
	h7CYxt5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEsy5-001KwS-1E;
	Thu, 29 Jun 2023 14:49:57 +0000
Received: from mail-lf1-f51.google.com ([209.85.167.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEsy1-001KvT-2F
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 14:49:55 +0000
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4fb78676973so212151e87.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 Jun 2023 07:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688050190; x=1690642190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+V2QoP1g+tUtgNa3Zg1YUxv30ED+AV1SxmDuok5KeI=;
        b=UFAKA8MHaMbtusH5SAJ4/4qYnWmpSC+/D4mjlkBIuSENzVwVz0CdDq69cqBq5eprNu
         54Kr36zi0G/TpARYPQszwrfJNCEvamwRC+6Xh9hECkycXdBJ6N9wBEFuT3Zxc5mOn1la
         rLVqf7TotJArE/XlAwshtldrgEVdF9GQ6NxaIWujKzgMlS//uOtGDGkOb59l0G2ySf9z
         G6zxlDtPXPtgfkzsYWEX02o9aABo5GOQhPSUT7kP/HjNGbqNxVU6kPPtjSl+gyoZi4gb
         nO2qbMrTMaYqYeEHhvo6hiJOu120iMs33SC9YtdPIMo1hS5InY8pUWfFhWqAZ43X4nYf
         0IdA==
X-Gm-Message-State: ABy/qLan8j5V3bpwzOlj+AfQ2BMCM3yQ1YfswLKtbcXbPz3L+OU/p7EF
	OuYQsKDz5SgcZT6cPQtU7ug=
X-Google-Smtp-Source: APBJJlHFD7hzN7Y6/gs5D8g7Wgnjk2WzxoDiPG1+WoxbmItuuVfbd1xLD5VmbMR/3dURiDtF7IasRQ==
X-Received: by 2002:ac2:5499:0:b0:4fb:8cb9:7ad8 with SMTP id t25-20020ac25499000000b004fb8cb97ad8mr120263lfk.2.1688050189484;
        Thu, 29 Jun 2023 07:49:49 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c0ac600b003f9c0a7c6bcsm16709186wmr.0.2023.06.29.07.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 07:49:48 -0700 (PDT)
Message-ID: <a1b7984a-d0a0-087c-2db9-6dbb6400a2bb@grimberg.me>
Date: Thu, 29 Jun 2023 17:49:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use
 sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, David Howells <dhowells@redhat.com>,
 netdev@vger.kernel.org
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org
References: <20230620145338.1300897-1-dhowells@redhat.com>
 <20230620145338.1300897-11-dhowells@redhat.com>
 <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230629_074953_753587_7EBE3D67 
X-CRM114-Status: GOOD (  13.22  )
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


> Hi David,
> 
> David Howells <dhowells@redhat.com> writes:
>> When transmitting data, call down into TCP using a single sendmsg with
>> MSG_SPLICE_PAGES to indicate that content should be spliced rather than
>> performing several sendmsg and sendpage calls to transmit header, data
>> pages and trailer.
> 
> This series makes my kernel crash.
> 
>  From the current net-next main branch:
> 
> commit 9ae440b8fdd6772b6c007fa3d3766530a09c9045 (HEAD)
> Merge: b545a13ca9b2 b848b26c6672
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Sat Jun 24 15:50:21 2023 -0700
> 
>      Merge branch 'splice-net-switch-over-users-of-sendpage-and-remove-it'
> 
> 
> Steps to reproduce:
> 
> * connect a remote nvme null block device (nvmet) with 1 IO queue to keep
>    things simple
> * open /dev/nvme0n1 with O_RDWR|O_DIRECT|O_SYNC
> * write() a 8k buffer or 4k buffer

Most likely this also reproduces with blktests?
https://github.com/osandov/blktests

simple way to check is to run:
nvme_trtype=tcp ./check nvme

This runs nvme tests over nvme-tcp.

No need for network, disk or anything. It runs
both nvme and nvmet over the lo device..

