Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB71CC6FD1F
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Mar 2024 21:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8mmuXfxqAGob0U9v+vaAkablmgwKdRtFtFZl+vh9Eh0=; b=JOkW3GSMDs4cpwZqH4xn3lluWi
	MYlKSr+3qv7SEn6v+P7KieAxs3NorJtgqiT48q/M+qjENxT3G7BjfswQ58H2c1Pyf3EPTVXiM6ect
	PkuFaeV9Yia8gJe0f/H1/KQGWwJh8lioyG+F13L9kr98poGiWQRi79PtxvLnZowdftj7NFXfLH88M
	MLOmGlIfzv9fG5C5N8JiphxDydLBMCEqnbLdBLK3x7v0KS4JYOOAScuXOVY+j0r3RGsV6Hg170XAc
	Z25aO8c3cVZBsjw6zNEXSGysiClZpqVul9bvrEHdq15KKUIT7fxjrdKYJv8itWFjdneMN26FrHWx3
	AaNdahDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqJsd-000000024aJ-0njq;
	Fri, 29 Mar 2024 21:35:19 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqJsZ-000000024Zq-48b5
	for linux-nvme@lists.infradead.org;
	Fri, 29 Mar 2024 21:35:17 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V5twz1KmkzlgVnN;
	Fri, 29 Mar 2024 21:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711748112; x=1714340113; bh=8mmuXfxqAGob0U9v+vaAkabl
	mgwKdRtFtFZl+vh9Eh0=; b=lmK85EaCDIoKCLNiWhIl2IcvXJq+g8ZjH+4SamGh
	V6XDFuPUZ9ShkFZzsHgg2AXlfYMN7opRw9uk+f7xdv7QbQQl5Xy+hkHTqcn2spg8
	8DYZiqY5TjFxWDUkUbDuCreFPZp4tnFFq4NM5/ShYext/XQW2whEmufi8xWL1P/W
	BnmJShz/gpdkT9SmXvzzyIKLk/i1KigJt9qrZJNlKWw3fShZY3Vi+3wqVYhli59j
	44qv0L2RsmAewAXpQLBzDUThpfdLJBxXAfkHde7fXE6FSj0il++CkBXB1a+aUfn4
	5x1jGsQQDHgjz3yosAlV8aI17ZhqU74qynY+vG4kUMfAbg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GpA9PQ9iA98h; Fri, 29 Mar 2024 21:35:12 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V5tws56cjzlgTGW;
	Fri, 29 Mar 2024 21:35:09 +0000 (UTC)
Message-ID: <20897217-2eae-44f8-9873-43d8898ecf43@acm.org>
Date: Fri, 29 Mar 2024 14:35:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/30] null_blk: Introduce zone_append_max_sectors
 attribute
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-19-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-19-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_143516_103140_8EE8E3EE 
X-CRM114-Status: GOOD (  10.49  )
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

On 3/27/24 5:43 PM, Damien Le Moal wrote:
> @@ -1953,7 +1961,7 @@ static int null_add_dev(struct nullb_device *dev)
>   
>   	rv = add_disk(nullb->disk);
>   	if (rv)
> -		goto out_ida_free;
> +		goto out_cleanup_zone;
>   

The above change is unrelated to the introduction of
zone_append_max_sectors and hence should not be in this patch.
Additionally, the order of cleanup actions in the error path seems
wrong to me. null_init_zoned_dev() is called before blk_mq_alloc_disk().
Hence, the put_disk() call in the error path should occur before the
null_free_zoned_dev() call.

Thanks,

Bart.

