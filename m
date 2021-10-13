Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DE8C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 13:33:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9580610E6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 13:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D9580610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OBYoKSd/HIB9JlpZhHEJyedLsizg2HzBalX0qhVLb2c=; b=sw+iN20vefnoo58CQBF5jz7rKV
	HfcsQstSS/uT6LaAn5AzNzzzJt0BO2CdmTO9r3kLlv6qNUcdjvBzBxQXJ6ingUTxb38FpLebD6ecy
	E8NEk1Ux6h8YT6iAFX5XXdlELhKf0/ATz+Pyq5evrggnLNLlJrZverWQWbOtbBgbhQnqRr1A06yrg
	fscgAqpy3j0r0ZzIPOcsKcHrFDMuOSFwI008B3LDsQ8Gi0fGK3MlsBgFp/N51hveAPIYzvQU8OoyF
	U5S4h8Q31X1mvP7KWM6UPO96HDRkSVFmHgN/dKVyIcfvtBR5xiBoc3ODoJb5RTXJKi5YQdK4oINjD
	sppVZbQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maeND-00Gv3A-Td; Wed, 13 Oct 2021 13:32:47 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maabV-00Flvr-C5; Wed, 13 Oct 2021 09:31:18 +0000
Received: by mail-ed1-x533.google.com with SMTP id d3so7569131edp.3;
 Wed, 13 Oct 2021 02:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jSDv3nCwYvRWF60PFzYmVFtCqi6n+8kG/qLGRQcEwXY=;
 b=XDrKXspyEQaSQYdqJnWhS/O0wblIXJrWl9pE6svv7KjgrDGVXul7dxFR95SMikNbI8
 dPBwNGXnMZrq9ECfkN9qd8qudIplcKbKQ02+dvBybldEqKgGTDn4o+Q+1yZvLDbQTpxH
 j0F3JAFmKpiVLRpHTHEBPzaDyzHphlM3B0d+/j7Ro7xiITFiea8XjX1E/h70+j8E07xJ
 iueofrb4NiJyC6FBpvAD+REiiIZXBpKUegBHgRICkLNGzc50RGa+mMfC0qBppipcUZ0O
 0MOGnuc/w5sEpIO1qpW0KnLTEIw6dv//T71InSxwu/1xkmLMW6ESgvB/ttIEAHR+9lRU
 du6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jSDv3nCwYvRWF60PFzYmVFtCqi6n+8kG/qLGRQcEwXY=;
 b=5XfbENM468wE12j4z7t8pGGIl6UrxUmZBqbxUvG1PK9xjuEfzPmC/omX1owJZh32sV
 AsNKeQ/qIOR6RYcex8sV/p4dzaqykdv+ycLHtzTVmqv269nMvuY8TvY6HThKw3ff0WHB
 KLZD2uABo4BKGi6jFmEvhCB0zEkT4oBazvSKL7Dbo/RF1pGxjIzp5TAONRovj0weIqJr
 eK6RPl1IMcsFJbVBAouEgD//Sk4uannI2MZpDkJiSs53iwRIT4SUxED19QuI1CDmPXCF
 jnKPECIi9rTmWaySoQ7BoAP0eg9imdASB42eWJdIIwimq9ZBwMHUJuaA1goLr5sWkI/K
 zIMQ==
X-Gm-Message-State: AOAM531gNK7T7v4XT+B9We1TleSwbMfdt4eVQx4mbHMxwSEGfqBtZPew
 riTannzDDB9/78vC8bab8lU=
X-Google-Smtp-Source: ABdhPJzWnNPujm70ssX25zhSqx1K1lXHECTOGOjBrmNCExix4poiHSM5QToDrvQz8D7ttpAXJOx3mg==
X-Received: by 2002:a05:6402:51d0:: with SMTP id
 r16mr7954872edd.353.1634117473882; 
 Wed, 13 Oct 2021 02:31:13 -0700 (PDT)
Received: from [192.168.178.40] (ipbcc061e7.dynamic.kabel-deutschland.de.
 [188.192.97.231])
 by smtp.gmail.com with ESMTPSA id p7sm7639013edr.6.2021.10.13.02.31.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Oct 2021 02:31:13 -0700 (PDT)
Subject: Re: [PATCH 07/29] target/iblock: use bdev_nr_sectors instead of open
 coding it
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
 Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Theodore Ts'o <tytso@mit.edu>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Kees Cook <keescook@chromium.org>, Phillip Lougher
 <phillip@squashfs.org.uk>, Jan Kara <jack@suse.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com, drbd-dev@lists.linbit.com,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
 reiserfs-devel@vger.kernel.org
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-8-hch@lst.de>
From: Bodo Stroesser <bostroesser@gmail.com>
Message-ID: <3babe7ca-cf08-fd19-6793-39f6d78bca12@gmail.com>
Date: Wed, 13 Oct 2021 11:31:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211013051042.1065752-8-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_023117_476592_C5775115 
X-CRM114-Status: GOOD (  19.78  )
X-Mailman-Approved-At: Wed, 13 Oct 2021 06:24:27 -0700
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 13.10.21 07:10, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/target/target_core_iblock.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
> index 31df20abe141f..ab7f5678ebc44 100644
> --- a/drivers/target/target_core_iblock.c
> +++ b/drivers/target/target_core_iblock.c
> @@ -232,8 +232,9 @@ static unsigned long long iblock_emulate_read_cap_with_block_size(
>   	struct block_device *bd,
>   	struct request_queue *q)
>   {
> -	unsigned long long blocks_long = (div_u64(i_size_read(bd->bd_inode),
> -					bdev_logical_block_size(bd)) - 1);
> +	loff_t size = bdev_nr_sectors(bd) << SECTOR_SHIFT;
> +	unsigned long long blocks_long =
> +		div_u64(size, bdev_logical_block_size(bd)) - 1;
>   	u32 block_size = bdev_logical_block_size(bd);

To enhance readability, would it make sense to shift the new lines
behind "u32 block_size = ...", so block_size can be used in div_u64
instead of using bdev_logical_block_size twice?

>   
>   	if (block_size == dev->dev_attrib.block_size)
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
