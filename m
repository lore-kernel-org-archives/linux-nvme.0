Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EC5C71136
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 19:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=25gqdr8OB8B8YYkPUeyMN7WbLBqsy7NImg1t9TKxdME=; b=UW1NHoJwz6M51JLvnS5BtfZSpg
	ydxH9n/fM4QD+VkfNMqRRdBjEXDE28Be8zPGoQGc4zkelLV3R6F5oI4yTC/h7OF1jElDCWYY1e2t3
	snnwafchgkiB0WRdMKpoE4l+NQHtTVAWGpYS72oMkhCVLs0jfKc2+nM1Opfta4KJVk5OzMa1nUNgQ
	XuAjoIZaYvvItzH66iXByZ4qTJ3Zc5kKRWLCxCt1B9Ry7epLXfAfwL9HqMDt1WAxX88p4lTBG+JQ7
	YxRWotULpiLr0ZNjuDNLB6ABWmwipkxPn2PfUPnb622+wY0sTu6CLZXW6Ji8vdMRNtT6KdQmnzwSW
	zRIhaplQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPRXb-0000000B2ya-0GzC;
	Wed, 11 Jun 2025 19:55:19 +0000
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPNLg-0000000AOIt-2zKy
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 15:26:46 +0000
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-86a55400875so603881239f.3
        for <linux-nvme@lists.infradead.org>; Wed, 11 Jun 2025 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749655604; x=1750260404; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25gqdr8OB8B8YYkPUeyMN7WbLBqsy7NImg1t9TKxdME=;
        b=FBG1PcMfXZYuK4AdAyOX7J+7/my2nLahs0Fi2cmydrnYjr8RQ2IPmkYK1IOjR4x/cP
         I5PygKDD+jsqKnR0k7bRIhdcQUL+w1Wiz9sVFle2mm2dI06uBaUfs1qsMoffnLytHJdB
         Bx/pyUbD8cvxZMIbZqWdgXn6lNgIibZXrrlUiCUnpw0KZDyPDfl62zc8QBReJZQwjiuo
         gQ2VcMQJMt9wZ+KQUHNskSPjfHbajuDOpVFuc7l1iTR0X96S2twLkjR8Sm91O249oxBB
         u1sSJEj3QYwQfZzHulWyXmD+pkuxSzxM4Jr+EdsgRTPtonTn+OS23jdEB5K0OzMz2EsU
         N6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749655604; x=1750260404;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25gqdr8OB8B8YYkPUeyMN7WbLBqsy7NImg1t9TKxdME=;
        b=BPYtnvIw0/hm+cdLOB87PV/rTFc+35+XV0An8zhneK/OmnnSurIQJ9HPP4lR1cZog0
         cj1xT81C09EpgVmsvQj0Xp/Xifj8Gg6SZSCDvBG4TbUXtpjOT/aYVAnoSLON4fTx0J99
         iRDLQ88JMW6vRnojemAIQkkdCBNk5KANB6gbNccTndftZggwAsmKVOuwuCju3swumfZz
         MHW25EmKbyZCJavWwC9n/dc5mqm3NdVJG8nyjJ8bhoQ3q2gqFqumAH2jii9/KAJi4q+o
         4wLmMIt2lBSRJqYgejxzL0z0ottByVfvV4hg47lKP6Qa5FCOIIVxbpuw45xZ3yYejyvL
         a3fg==
X-Forwarded-Encrypted: i=1; AJvYcCXByGk1HmzsGZnRgfikCqucLx5R9o5f9rgTYm7R+sQ227reBvD0YOHaxHkgMp6KyUribf2L0/j/3bwU@lists.infradead.org
X-Gm-Message-State: AOJu0YyMQNVRGXdV8MEjrsvRM1JXxFzA/Olfm7KqxZXE8Vzw4t7bC5F9
	gSma+rTl7qD8MkPp2gghGZLmMc4edN3xCqc9ZLYl+CJlT5iONWcLI/j4l16AlZYKPAo=
X-Gm-Gg: ASbGncuBrx4E9axv0NDoqkcve4YY90orFD9s7XY0U9VKXts1FSKVXLYpTML9ju2+lPI
	ZrX0h/Bc276lMlMzBjM/Cel/CLtUmPdEkuIhpYpkTeGnDu0brLVkwltQO5cRVCN1iD+oDJPkSpD
	ITIs+7QLelG2cvxdZcpWMPHp8cqfcJjHNb4GFOL0NhShG4ThP+ypyisUaVzItQZmvr9E04mx9ft
	F9rAm0yP4xwtaAgyxrieYOBESS9rf3KG8cXPB/FHNS0Q5tJn1i9Eymb5c+gm+5jGWKdidGEZsq1
	z5ROnpV6imZwo4F/k7PA8zGdo1zeilrtLzNM9PEbnb053n5woGKGXRM+6Q==
X-Google-Smtp-Source: AGHT+IHaxfT+O57Vn8979jdX84yGSFMet3prL9YRAAW17QgstqoINM/JBUR9h2E/1+qlZME9XacRsQ==
X-Received: by 2002:a05:6602:36ce:b0:85a:e279:1ed6 with SMTP id ca18e2360f4ac-875bc472084mr439890139f.11.1749655603849;
        Wed, 11 Jun 2025 08:26:43 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875bc5b4294sm44276539f.14.2025.06.11.08.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 08:26:43 -0700 (PDT)
Message-ID: <afb8792b-a78d-4886-bf9a-23121510dec5@kernel.dk>
Date: Wed, 11 Jun 2025 09:26:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "block: don't reorder requests in
 blk_add_rq_to_plug"
To: Ming Lei <ming.lei@redhat.com>,
 Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Cc: stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Hagar Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20250611121626.7252-1-abuehaze@amazon.com>
 <aEmcZLGtQFWMDDXZ@fedora>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <aEmcZLGtQFWMDDXZ@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_082644_756332_B4155A39 
X-CRM114-Status: GOOD (  13.44  )
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

On 6/11/25 9:10 AM, Ming Lei wrote:
> On Wed, Jun 11, 2025 at 12:14:54PM +0000, Hazem Mohamed Abuelfotoh wrote:
>> This reverts commit e70c301faece15b618e54b613b1fd6ece3dd05b4.
>>
>> Commit <e70c301faece> ("block: don't reorder requests in
>> blk_add_rq_to_plug") reversed how requests are stored in the blk_plug
>> list, this had significant impact on bio merging with requests exist on
>> the plug list. This impact has been reported in [1] and could easily be
>> reproducible using 4k randwrite fio benchmark on an NVME based SSD without
>> having any filesystem on the disk.
>>
>> My benchmark is:
>>
>>     fio --time_based --name=benchmark --size=50G --rw=randwrite \
>> 	--runtime=60 --filename="/dev/nvme1n1" --ioengine=psync \
>> 	--randrepeat=0 --iodepth=1 --fsync=64 --invalidate=1 \
>> 	--verify=0 --verify_fatal=0 --blocksize=4k --numjobs=4 \
>> 	--group_reporting
>>
>> On 1.9TiB SSD(180K Max IOPS) attached to i3.16xlarge AWS EC2 instance.
>>
>> Kernel        |  fio (B.W MiB/sec)  | I/O size (iostat)
>> --------------+---------------------+--------------------
>> 6.15.1        |   362               |  2KiB
>> 6.15.1+revert |   660 (+82%)        |  4KiB
>> --------------+---------------------+--------------------
> 
> I just run one quick test in my test VM, but can't reproduce it.
> 
> Also be curious, why does writeback produce so many 2KiB bios?

I was pondering that too, sounds like a misconfiguration of sorts. But
even without that, in a quick synthetic test here locally, I do see a
lot of missed merges that is solved with the alternative patch I sent
out. I strongly suspect it'll fix this issue too.

-- 
Jens Axboe

