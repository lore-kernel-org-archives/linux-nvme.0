Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AC6C6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 12:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zZpIXnR6BfGKRbl9KEHqRv70dkgTytr1OorJZaZXWbQ=; b=4dZYjLkNg33CYEXNg+L5YArPok
	y2xi0hlgoK7C88beJ8NZ1KTyNxDsf3Dpvlj+XVkSBpzLecRBGh7ks89YvORswjSRFDxyzMZdzoL0A
	9w9pYQUEx1aSXTYr03hYf171VVZUDqv80+KrhB1XsrXGvMmPDdC59IepGWOyOVdLpKyRSVCotzBtf
	+q6pQKsOTA0lwKqToKKmFDvd4/5QZLAqtSzfD08CpeaOgafGgLL0joXQZJg6UlQHsmNpVVWso1xkd
	spIyEjaT8NnUqbRk9D2OpQRdTaF8n9zsWku13gNDrtUTgZ+g+p3Izl6j7YsHNoeJjnP/0TX5WI9G7
	9W7Ev4nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phUqq-000BHm-1v;
	Wed, 29 Mar 2023 12:24:28 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phUqn-000BFX-1b
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 12:24:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680092665; x=1711628665;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2dcvqV87tiaXbc2Uo11d6o/I39/nMjI+zlAAi+6Vbgk=;
  b=Qwi9r4MEi4Qf5OuVEtGtgS7ABIrT9CjNJ7m1Ur3wApeai/xx742anoLJ
   mUW+1nBuBDpIPVGC/Y8aj1MwX0e+F+r3Zj1m8jG+QFMdBGzI/SGaCXDj/
   mEpyGpPzZuC6QcQljgfqRarXeUsYuDb7IVtOjQPSfAAkhlNKGc47fcgaP
   ua0ivTKy9hyzkyPKChdr5NlboBZe20SPPR0v9W/oFjIrhDSAPqfv2U1cv
   okCEuvajEeAcNKtYo3ZoygWdyRk0MShJLJWJ+po4vgyJU80Tssa/lgCUR
   KNN/3QOA3Dl+rDeqy+K5d7T+Kc62SaHRJvnJcKZkiMvwd7FjYxw9CJ27K
   A==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="226783999"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 20:24:19 +0800
IronPort-SDR: X5K+8cRuct0JKcbCXPZJ7UEoqO03nCkXg9QH2VqNreObQaX8cxVSETHXCFX/k9kC00M6rPIfCL
 gTLP96p+VnFbvqXka/GncDvDkhCyr4BjOpgpkkFpWxwxFoCf1mY18zW/BQkAHKH/EFoMLR3tTc
 3YUQARPzCghHOyQduP04r5aGz29bigbm1yrOdJE5It56fGphtqB5plTH+MetEv8FxBk/EB6fvF
 9NQjNUW73+ANHZp2kkdsK+GzV8Ed1i8UDvRkqwSR0gZdAy2/+VJ66Oaz2FeWuqH6zja+E92b4k
 mQ0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 04:40:28 -0700
IronPort-SDR: F4FwepJRX2qKONsEQKmoowCr1tFk//NuzoFw23ACqeGfI3o/ooGKRb9BG+I9pIxWgDBUiTAcJ1
 vW/vklxyuZ6CKC5adNC53mAhHk5ajAt6HkhuVpfe/z/yWJbrSla/66EcfGk5OltpOv4+cTmYuM
 jzuY34f6mQLYG4c24dXfG3Km5fNkr3ZiARfIOJRiwNO/N4A4xc571hQLL+garUlz/T6qndGmRd
 MwU9LSMnCLNgh8i222LaGLfiDu+0wEXTsiGzCJ0i9RB2tKMk5NPv6GQdbad2/RuxR85LwBLWr/
 V7s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 05:24:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pmm2B59nxz1RtVq
	for <linux-nvme@lists.infradead.org>; Wed, 29 Mar 2023 05:24:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1680092657; x=1682684658; bh=2dcvqV87tiaXbc2Uo11d6o/I39/nMjI+zlA
	Ai+6Vbgk=; b=aYJDL/Wv2IOTx8UdzJQy6vhK6Cwx6WbFawjWCYauh4DMUjt8PUN
	9x0lBBLgBT/IjyJZGV1IULqpb87tc8FlfO62FSSzocE5VAR0WX6HRUoEfOG+mAEG
	rS94t5CfBpzIdV/6jIaxzIRNmFgSzvpryU3Z3Hgv220Wql3f6LJqko6ekzg49x+7
	qeUNMP4r4fsY+rjt2ddmQ5DpVwco7it1Uwnyd0bFSBOYjcGo49ZkFsBrbmu/9pYw
	AfMs3umVUAn9mMkkU82WMd1B4ReuDbvk0vLFAQHC/dPMQD3ZYGm0zN4Yjco6S7g1
	yw6PpaghAYhqlgVGMdPjU7T3BSfmuLdDP4g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6f26v0-qTtkb for <linux-nvme@lists.infradead.org>;
	Wed, 29 Mar 2023 05:24:17 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pmm253ydnz1RtVm;
	Wed, 29 Mar 2023 05:24:13 -0700 (PDT)
Message-ID: <03c647ff-3c4f-a810-12c4-06a9dc62c90e@opensource.wdc.com>
Date: Wed, 29 Mar 2023 21:24:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 1/9] block: Introduce queue limits for copy-offload
 support
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, bvanassche@acm.org, hare@suse.de,
 ming.lei@redhat.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
 gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20230327084103.21601-1-anuj20.g@samsung.com>
 <CGME20230327084216epcas5p3945507ecd94688c40c29195127ddc54d@epcas5p3.samsung.com>
 <20230327084103.21601-2-anuj20.g@samsung.com>
 <e725768d-19f5-a78a-2b05-c0b189624fea@opensource.wdc.com>
 <20230329104142.GA11932@green5>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230329104142.GA11932@green5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_052425_681525_AE66D6A5 
X-CRM114-Status: GOOD (  23.83  )
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

On 3/29/23 19:41, Nitesh Shetty wrote:
>>> +What:		/sys/block/<disk>/queue/copy_max_bytes
>>> +Date:		November 2022
>>> +Contact:	linux-block@vger.kernel.org
>>> +Description:
>>> +		[RW] While 'copy_max_bytes_hw' is the hardware limit for the
>>> +		device, 'copy_max_bytes' setting is the software limit.
>>> +		Setting this value lower will make Linux issue smaller size
>>> +		copies from block layer.
>>
>> 		This is the maximum number of bytes that the block
>>                 layer will allow for a copy request. Must be smaller than
>>                 or equal to the maximum size allowed by the hardware indicated
> 
> Looks good.  Will update in next version. We took reference from discard. 
> 
>> 		by copy_max_bytes_hw. Write 0 to use the default kernel
>> 		settings.
>>
> 
> Nack, writing 0 will not set it to default value. (default value is
> copy_max_bytes = copy_max_bytes_hw)

It is trivial to make it work that way, which would match how max_sectors_kb
works. Write 0 to return copy_max_bytes being equal to the default
copy_max_bytes_hw.

The other possibility that is also interesting is "write 0 to disable copy
offload and use emulation". This one may actually be more useful.

> 
>>> +
>>> +
>>> +What:		/sys/block/<disk>/queue/copy_max_bytes_hw
>>> +Date:		November 2022
>>> +Contact:	linux-block@vger.kernel.org
>>> +Description:
>>> +		[RO] Devices that support offloading copy functionality may have
>>> +		internal limits on the number of bytes that can be offloaded
>>> +		in a single operation. The `copy_max_bytes_hw`
>>> +		parameter is set by the device driver to the maximum number of
>>> +		bytes that can be copied in a single operation. Copy
>>> +		requests issued to the device must not exceed this limit.
>>> +		A value of 0 means that the device does not
>>> +		support copy offload.
>>
>> 		[RO] This is the maximum number of kilobytes supported in a
>>                 single data copy offload operation. A value of 0 means that the
>> 		device does not support copy offload.
>>
> 
> Nack, value is in bytes. Same as discard.

Typo. I meant Bytes. Your text is too long an too convoluted, so unclear.

-- 
Damien Le Moal
Western Digital Research


