Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF7FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 05:01:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66DF60FD8
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 05:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B66DF60FD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W5z0exFABNpBPX1hRqcH8nqG0V53/7e/1qraB3crDBc=; b=c8D4D2wgad/PHdUaq5VeefhrNC
	W2RMVwxWkNHkQmvGS2PtHEZrJqQJVTiZYlek5x6xBw7drUGCAcps+ogdBaPCGhuxdk7U503L2BARn
	VyzbFinwtgIMKJBzkTEhumve5EikO8sRAjxIIfIiy8o3Rtf5yUB8o8juoNggNgmEImjttYPEWJNEz
	A922NDEKBXhjgSz093cgp6yJTFCN0ANyTRgYPQtBu4BxW9PzlKF2iQeLw8vzHl/7RDhwRT+bimj5q
	5f9bcjvUaPa9zFELdAbGfJpKz05VmjVeKu2cLQ3zIzxgNKQCTzOnk4pH+9qU4kY2ol3WMCn4K7J56
	m+Hu4L8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mchFV-0008zH-Fz; Tue, 19 Oct 2021 05:01:17 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcdYt-00HVfa-IX
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 01:05:04 +0000
Received: by mail-io1-xd2f.google.com with SMTP id d125so18474577iof.5
 for <linux-nvme@lists.infradead.org>; Mon, 18 Oct 2021 18:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W5z0exFABNpBPX1hRqcH8nqG0V53/7e/1qraB3crDBc=;
 b=vB+wFpSQtfAUhwdXcfynbmYwp0hdBEQZvbX6X9F6PNzCrR7jlF3UU0FKlXz+m74FXo
 fYCfnp+UOHId9lQV8O9fyEh4YEI0b538At136V3n0vh4OZ/YzMev/Q7gmlb/eOGGE5cU
 0c1i9lZ2acvXLmYa878iz+lCi3R78xqn0ZDpYtIVtZNxoFJsKdSEsj9/YVhugl90Ar3H
 SoUxghi0wJ6VSD6JvL3P+s/JM6f3Wm0mmMYFgaEag1ojhi+wlEeYXumrYWwARkL2eroz
 Ue9QqS/6wvsrqGxlajrxCGxhjXwobZTI+icumh8oCIQgK1Jfr75Nwh+NZuFxcTfoqOvP
 WcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W5z0exFABNpBPX1hRqcH8nqG0V53/7e/1qraB3crDBc=;
 b=mfYTs5H4U7w2AHpz42190/DFuz4IA9KXtLXq4MYVRT9YaEHZmeagsZEWHO36urqHfZ
 dsdYyPKgBIaznwOnBgsP/eULjiFnHXtIPpAQPZOn2eQFsWdGY8D9y1PoKOSHwJ3PsD0M
 VrRuIhv6+2nmkNUGLR+FhPunzbHqb3OqGcUJ6X6cfo/Qdh3eEebToOgF3bXeHYSEMUHs
 AulposrejwDsSDlGDIgFnQ/2xJ+AhoHlTzDn129az14qIoimKFVhLpEH9Uze9meMYOST
 jw4LyHhvWtoWyaMa/Iv4nNScByyK7RzXyJEroeIs1cv3LzLQ+Tje7U33tZ7436lXHhwq
 MUpQ==
X-Gm-Message-State: AOAM532jEjwx3P+mExHNOSzCwu0aNbB8vS2BD3huOKB7khnP9LUICLES
 CTo/ZWOIejNSF6hqWiRV2yjxMQ==
X-Google-Smtp-Source: ABdhPJxThXMAcCMjPpDBYOBzNUVp6z4TAqcvNSoJJDW60phmikuRtzHD4NR4koFPUymcotmxVpLHsA==
X-Received: by 2002:a6b:102:: with SMTP id 2mr16592131iob.185.1634605499259;
 Mon, 18 Oct 2021 18:04:59 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id g13sm116963ilf.60.2021.10.18.18.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Oct 2021 18:04:58 -0700 (PDT)
Subject: Re: don't use ->bd_inode to access the block device size v3
To: Kari Argillander <kari.argillander@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>,
 Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Theodore Ts'o <tytso@mit.edu>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Kees Cook <keescook@chromium.org>, Phillip Lougher
 <phillip@squashfs.org.uk>, Jan Kara <jack@suse.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com, drbd-dev@lists.linbit.com,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
References: <20211018101130.1838532-1-hch@lst.de>
 <4a8c3a39-9cd3-5b2f-6d0f-a16e689755e6@kernel.dk>
 <20211018171843.GA3338@lst.de>
 <2f5dcf79-8419-45ff-c27c-68d43242ccfe@kernel.dk>
 <20211018174901.GA3990@lst.de>
 <e0784f3e-46c8-c90c-870b-60cc2ed7a2da@kernel.dk>
 <20211019010416.vgecxu6wnvwi7fii@kari-VirtualBox>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <81f9ad59-4c15-b265-1274-62c987ad879b@kernel.dk>
Date: Mon, 18 Oct 2021 19:04:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211019010416.vgecxu6wnvwi7fii@kari-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_180503_652464_03F1CD26 
X-CRM114-Status: GOOD (  13.74  )
X-Mailman-Approved-At: Mon, 18 Oct 2021 22:01:06 -0700
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

On 10/18/21 7:04 PM, Kari Argillander wrote:
> On Mon, Oct 18, 2021 at 11:53:08AM -0600, Jens Axboe wrote:
> 
> snip..
> 
>> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
>> index 7b0326661a1e..a967b3fb3c71 100644
>> --- a/include/linux/genhd.h
>> +++ b/include/linux/genhd.h
>> @@ -236,14 +236,14 @@ static inline sector_t get_start_sect(struct block_device *bdev)
>>  	return bdev->bd_start_sect;
>>  }
>>  
>> -static inline loff_t bdev_nr_bytes(struct block_device *bdev)
>> +static inline sector_t bdev_nr_sectors(struct block_device *bdev)
>>  {
>> -	return i_size_read(bdev->bd_inode);
>> +	return bdev->bd_nr_sectors;
>>  }
>>  
>> -static inline sector_t bdev_nr_sectors(struct block_device *bdev)
>> +static inline loff_t bdev_nr_bytes(struct block_device *bdev)
>>  {
>> -	return bdev_nr_bytes(bdev) >> SECTOR_SHIFT;
>> +	return bdev_nr_setors(bdev) << SECTOR_SHIFT;
> 
> setors -> sectors

Yep, did catch that prior.

-- 
Jens Axboe


