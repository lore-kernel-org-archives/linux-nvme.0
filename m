Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4B9E7490F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Oct 2023 18:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gc60tErHmFLa/ojhrllX+rIN4q7yH7L/FhjXgxWfjlA=; b=yC5ZydB31+R/3OD5frSwa2sJXW
	i130vcshN8XOzcSFahcQjNczPs9P9tYOpnDhE3XKexwCHdEdmwFGTZS2I9kGdAWztWXVB5DeckKGZ
	13sDPirCco4vM2ET0vxni32D9GzPZ6enYgX0XBXlJyR8EWH6Qxc5xojPlHJH5ou9Y9EO6vA3tEDxd
	WSXRuRtP+tLSGVIN0bMYjDXYD8cbZsmeUB9VTogij+vdYPNSbfp2dc41KGlLCQsZW17wg7ciCaXkq
	w8O5BlUMmM5HqyitjOwZKQvv688EY5thAaVBwO4C1gc65brBiAFb6XaN0jfG6+AqF+wTcNd0PoXHN
	EsJYhYRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnNp4-00DE6h-2z;
	Mon, 02 Oct 2023 18:39:14 +0000
Received: from mail-yw1-f177.google.com ([209.85.128.177])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnNp1-00DE50-2M
	for linux-nvme@lists.infradead.org;
	Mon, 02 Oct 2023 18:39:13 +0000
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-59f6e6b7600so1044247b3.3
        for <linux-nvme@lists.infradead.org>; Mon, 02 Oct 2023 11:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696271945; x=1696876745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc60tErHmFLa/ojhrllX+rIN4q7yH7L/FhjXgxWfjlA=;
        b=fHkVl3iwGbWBfCPHZUYhnoP2vgwLf848O4Qb49Cl+QV6BEJwjzWpE0Q4pnieAxB+qy
         5l5OyvlmHI7VN8k9TF265DHZR2KfH5FHHHEMQgaa0RYX7KE95u4xYWKKylogE/khNO2x
         pGruUqshevzQptZcTVEncpmdBO6LMp0G2LTZ77U7Th6ny2TNcJQrVljONSfMMMaNTgST
         lErDCFYyxv5ojn3xPwPudR+gQc5oSUjdavVT0ajAbD5H7PaN1InHHKDice4w+7QggZuH
         4x8pPhQSvV9zEO27Cbr7ad6qY31xPNPLNzL1geT5+v7Rm/YRnMfqIjQNZ+JVdZj5+9vL
         nPgw==
X-Gm-Message-State: AOJu0YxXotnwP66kGfP0Qg5ES172rnob/Q/yb77Id5XEbkHai7sgiEeg
	8gevdX4YqTzqFkuaMNCd248=
X-Google-Smtp-Source: AGHT+IESVNBLm8WCa7rBouLG5qA3ZmN61xUw/sb/SYnK4ixQ5LUHtH5fDdM+JtbnGYgfpHa7GLtSKA==
X-Received: by 2002:a25:c748:0:b0:ced:6134:7606 with SMTP id w69-20020a25c748000000b00ced61347606mr10978974ybe.30.1696271944617;
        Mon, 02 Oct 2023 11:39:04 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6ad7:f663:5f97:db57? ([2620:15c:211:201:6ad7:f663:5f97:db57])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c2f1a2f6bsm19484421pge.41.2023.10.02.11.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 11:39:03 -0700 (PDT)
Message-ID: <2c929105-7c7f-43c5-a105-42d1813d0e29@acm.org>
Date: Mon, 2 Oct 2023 11:39:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, Eric Biggers <ebiggers@kernel.org>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, chandan.babu@oracle.com,
 dchinner@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu,
 jbongio@google.com, linux-api@vger.kernel.org,
 Prasad Singamsetty <prasad.singamsetty@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-4-john.g.garry@oracle.com>
 <20230929224922.GB11839@google.com>
 <b9c266d2-d5d6-4294-9a95-764641e295b4@acm.org>
 <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231002_113911_792556_AF426E09 
X-CRM114-Status: GOOD (  14.55  )
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

On 10/2/23 02:51, John Garry wrote:
> On 01/10/2023 14:23, Bart Van Assche wrote:
>> Is it even possible that stx_atomic_write_unit_min == 0? My 
>> understanding is that all Linux filesystems rely on the assumption 
>> that writing a single logical block either succeeds or does not 
>> happen, even if a power failure occurs between writing and reading 
>> a logical block.
> 
> Maybe they do rely on this, but is it particularly interesting?
> 
> BTW, I would not like to provide assurances that every storage media 
> produced writes logical blocks atomically.

Neither the SCSI SBC standard nor the NVMe standard defines a "minimum
atomic write unit". So why to introduce something in the Linux kernel
that is not defined in common storage standards?

I propose to leave out stx_atomic_write_unit_min from
struct statx and also to leave out atomic_write_unit_min_sectors from
struct queue_limits. My opinion is that we should not support block
devices in the Linux kernel that do not write logical blocks atomically.
Block devices that do not write logical blocks atomically are not
compatible with Linux kernel journaling filesystems. Additionally, I'm
not sure it's even possible to write a journaling filesystem for such 
block devices.

Thanks,

Bart.

