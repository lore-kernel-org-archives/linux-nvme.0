Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9984EE49BC
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 15:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sknt5oaH35Bug6yrN3vlwCGQAPFZ2IlWB3sYHV3cQzM=; b=QCNKhSsszYekFeZ98gmAB60JkJ
	ctFSW+bYUkKuPGWhG486uDe+YHFzNS4bCMvwk7BzqC6qdfxx42rIxf8vawnqT5hPw4Azdb10RjA7+
	TXfAiLW2l9V0KZxVWgXPyj7s8uW/SF/hPLlGyk89+i0nCr0Zd2aglf0u1Dg+cXoFT/t7cPvmPspVy
	YmxMyPD3vPJT55UUMQzce4V3wSUfd1wtVPhkTej29vFcH5hBkEbG5+VKJHyuj6gIgkJIzwFIgtWyM
	t2Jv7wMvxf1y/GRlPh2OUYxBhPc71+lkhnBE1GqCoNOeB0+P5D0LzbetMOGUKObDCRRsAs4YENCaG
	QE3RWnIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soPBd-0000000A8Ou-3sze;
	Wed, 11 Sep 2024 15:23:17 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soP8z-0000000A71F-3RsA
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 15:20:35 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-371941bbfb0so4313302f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 08:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726068032; x=1726672832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sknt5oaH35Bug6yrN3vlwCGQAPFZ2IlWB3sYHV3cQzM=;
        b=ggf8K3pFTzvy6FRSX0TF+VgcL+kMH9zC2CL7b5ZqJAd4ee5qfG+iWDnjqQlUH8FEUm
         124nMe8WlzkBAHhw2lmxGdc4Q+GG5XL2UFx19d5c0bsGdvugryYmpSmyd2yDFYOYbNQ4
         bn7pD65gkvgegeSRnBt9uKOMg8z4OcBiC8bdlwQJwRkNkBKZpWtGv6BF1lVPRm4c97DF
         IPxnUXnnaDWG7cULPqrFU3ngE7PO1EbqP2AwpV94EoMZgvnnLSlv0N3U7DE5dmxQuHpM
         0s/k+SL+GypFcTjHC3E0oCDhnzPKygxl/s8gtQ7ZZxl6vSNm5mFMhMAu/x53f8cETIw7
         vsWQ==
X-Forwarded-Encrypted: i=1; AJvYcCULb8kWhZJBRyyEk5Jx4oLBDxMOsl08Gp5T/P5EnDojnh8s6brTlXEGaMaJFgqfnPOuI41IPfkZ1bUw@lists.infradead.org
X-Gm-Message-State: AOJu0YzF0Cv9WWMaB//2j8QIA/EfdVzZLLUBwBdrCRUl1z3Z7SWnNFoP
	nnfcBbaz8Td5w+yQEoiRfxB7CD2J2Sja4cGlPWGGP/YayLMgY2qA
X-Google-Smtp-Source: AGHT+IHwZfDpkTAVvgjwGRAj3EQ+96YnYcLXY6xC4sPd/XDuPHlqlnBnvC6Y+ZSRiQ/niMwBKrz0/Q==
X-Received: by 2002:adf:cd0b:0:b0:374:be8e:7325 with SMTP id ffacd0b85a97d-3789272c93bmr10168197f8f.51.1726068031116;
        Wed, 11 Sep 2024 08:20:31 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de02esm11897845f8f.109.2024.09.11.08.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 08:20:30 -0700 (PDT)
Message-ID: <2193b894-2999-4450-a221-19045c2b3e53@grimberg.me>
Date: Wed, 11 Sep 2024 18:20:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-multipath: stuck partition scan on inaccessible
 paths
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240911124610.81615-1-hare@kernel.org>
 <20240911124610.81615-4-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240911124610.81615-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_082033_893836_CD88F4F7 
X-CRM114-Status: GOOD (  20.20  )
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




On 11/09/2024 15:46, Hannes Reinecke wrote:
> When a path is switched to 'inaccessible' during partition scan
> triggered via device_add_disk() and we only have one path the
> system will be stuck as nvme_available_path() will always return
> 'true'. So I/O will never be completed and the system is stuck
> in device_add_disk():
>
>      [<0>] folio_wait_bit_common+0x12a/0x310
>      [<0>] filemap_read_folio+0x97/0xd0
>      [<0>] do_read_cache_folio+0x108/0x390
>      [<0>] read_part_sector+0x31/0xa0
>      [<0>] read_lba+0xc5/0x160
>      [<0>] efi_partition+0xd9/0x8f0
>      [<0>] bdev_disk_changed+0x23d/0x6d0
>      [<0>] blkdev_get_whole+0x78/0xc0
>      [<0>] bdev_open+0x2c6/0x3b0
>      [<0>] bdev_file_open_by_dev+0xcb/0x120
>      [<0>] disk_scan_partitions+0x5d/0x100
>      [<0>] device_add_disk+0x402/0x420
>      [<0>] nvme_mpath_set_live+0x4f/0x1f0 [nvme_core]
>      [<0>] nvme_mpath_add_disk+0x107/0x120 [nvme_core]
>      [<0>] nvme_alloc_ns+0xac6/0xe60 [nvme_core]
>      [<0>] nvme_scan_ns+0x2dd/0x3e0 [nvme_core]
>      [<0>] nvme_scan_work+0x1a3/0x490 [nvme_core]
>
> This patch introduces a flag NVME_NSHEAD_FAIL_ON_LAST_PATH to
> cause nvme_available_path() to always return NULL, and with
> that I/O to be failed if the last path is unavailable. But
> we also need to requeue all pending I/Os whenever we have
> changed the ANA state as now even inaccessible ANA states
> influence I/O behaviour.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/multipath.c | 15 +++++++++++++++
>   drivers/nvme/host/nvme.h      |  1 +
>   2 files changed, 16 insertions(+)
>
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index f72c5a6a2d8e..0373b4043eea 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -422,6 +422,10 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>   	struct nvme_ns *ns;
>   
>   	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
> +	    return NULL;
> +
> +	if (test_bit(NVME_NSHEAD_FAIL_ON_LAST_PATH, &head->flags) &&
> +	    list_is_singular(&head->list))
>   		return NULL;

This is wrong too Hannes.

If you added a live path, and when partition scan triggers your path becomes
inaccessible, but then after anatt it becomes optimized again. You just 
ended
up without discovering partitions...

