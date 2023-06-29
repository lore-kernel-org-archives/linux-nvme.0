Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29215EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 17:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cKJ9DhjvqOBp2CVGYQWoLrEARGd6+E4wYs71rV2g1z4=; b=JHKEgyS/gUYnOzmrxhmkUtaWcB
	F1M189pkdXUh6cocQsIiwz2RJM4+HIHqYlLL74QIFf3sRRmoEkQtpDZgULxN+COxMqyoGWbsNQCwA
	xGD2GmQio5nM4LZo17JBF3JSvWXez2KZp1ca8yL1khXWhtNk2x2lVIaHnS9ppgHmeArq2bGMZ0OLv
	sA9FO89QIAlXhNWoDSEmlzs+irmt8b1AQc1FVZbYRfMjKJaEoXCQrsdpz7GFLtgCdCzUiyXXEESzs
	dqemn1ngu/ZqGFc31go/Uc9VKCvTKnZa8ELeat2/ZuYU8DAdsys09XJ7hWCpTRqwi7nLzUUrPiJ+m
	XLFmb+MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEvQe-001dYJ-2j;
	Thu, 29 Jun 2023 17:27:36 +0000
Received: from mail-pl1-f175.google.com ([209.85.214.175])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEvQc-001dXD-2H
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 17:27:36 +0000
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b7fef01fe4so7607995ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 Jun 2023 10:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688059652; x=1690651652;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKJ9DhjvqOBp2CVGYQWoLrEARGd6+E4wYs71rV2g1z4=;
        b=aT25YnSyrpaLPqdMOtoOtIYFy3IPKaebIPgA2VgB331WNIYPspOEM5nGn8Winu3xaI
         /n8gDx8Apbd5y0VRruh9PR0mKWGwVGhTg5DAU1LSGIbsOMM97/NNLaRDlY8VImawr9jV
         Ezvo7SA8Z2IOM/CCWYZBoNKN4fUiC1QFQ1oNe/R7xXM6FqMjgUE8tBE1RLvEAn8j3uw4
         0gMk+J65lIaxvuCtlTfNIcLF+nGYaaxxCbMUomSKRNsxlAZnNVT9Drjfvilp8Ve61OzQ
         qBrEzcFe8svqE+ap7herX1FT3ZnyCB6NPWqxkP6HhR80MRm0tEXV7Hp0h72nhP4uyHZG
         beUg==
X-Gm-Message-State: AC+VfDzDHNv/zaoagLVxBH6KvLfhtx+1P4g0He8GSC2M4iKo9tjTPEkf
	gAPu3jaoruqUKJbZx7whEEU=
X-Google-Smtp-Source: ACHHUZ5WIfd9BXaEMUY2N1uIJDb8Arth8vDZjzTiDG4DJBtYdm1ulp797OdTSCnJEY17cSbyJaFO8Q==
X-Received: by 2002:a17:902:c3c6:b0:1b5:5aa0:cfd9 with SMTP id j6-20020a170902c3c600b001b55aa0cfd9mr12671795plj.48.1688059651889;
        Thu, 29 Jun 2023 10:27:31 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a601:6da1:e847:d4b1? ([2620:15c:211:201:a601:6da1:e847:d4b1])
        by smtp.gmail.com with ESMTPSA id jm23-20020a17090304d700b001b51b3e84cesm9411237plb.166.2023.06.29.10.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 10:27:31 -0700 (PDT)
Message-ID: <3d467dc4-ef32-3b5e-ad3d-127381b596c9@acm.org>
Date: Thu, 29 Jun 2023 10:27:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] Improve checks in blk_revalidate_disk_zones()
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>
References: <20230629062602.234913-1-dlemoal@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230629062602.234913-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230629_102734_746027_A3F43363 
X-CRM114-Status: GOOD (  14.89  )
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

On 6/28/23 23:25, Damien Le Moal wrote:
> This series slightly modifies the 4 block device drivers that support
> zoned block devices to ensure that they all call
> blk_revalidate_disk_zones() with the zone size and max zone append
> limits set. This is done in the first 4 patches.
> 
> With these changes, the last patch improves blk_revalidate_disk_zones()
> to better check a zoned device zones and the device limits.

This patch series changes a lot of code without making it very clear what
the advantages of this patch series are. The cover letter says "better
check" without explaining what is improved. The description of patch 5/5
says "the zone checks implemented in blk_revalidate_zone_cb() can be
improved" without explaining what is improved.

More information about what has been improved and why these improvements
are considered useful would be welcome.

Thanks,

Bart.


