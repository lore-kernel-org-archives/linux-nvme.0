Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E3FEB64DD
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 12:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZT45U16gdzFUbmZJNoZlsPIKCISK6hy/5gm3avKqqgE=; b=R3l0p/SqIUE2qk2Gl6BR7a58Mv
	ZPusY8HI3w75wytVdfL//xcByCJnzs6eOd/jbdasDbuEdChPs1VIQHSEEl4id/pZ6pxxRuna4nbpo
	xEB1fUYURZZnkHKGU2a076PzlH5nXxKFHUGMkvUiO0wkbuRu7TrepcIpKuOjaswWDpyv03WlYEhKT
	SBKr0fUpY9ZvJniU1q0eeYuJFzP3CVIcR9sq7yU7dw17M/a1xZqJZ3UPrxCz/WuR5LPB741VLH0vX
	PihxR7eLjur00+/ahPQgYf9C1FXWwzd6HIqJfEQ5BF1e6KpdSzB0ZvLgkrRar22sq32sez3Rs8guF
	SoSM/HVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVAaQ-00F7C3-2J;
	Sun, 13 Aug 2023 12:52:50 +0000
Received: from mail-ej1-f54.google.com ([209.85.218.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVAaN-00F7BI-1u
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 12:52:48 +0000
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-99bcf3c8524so81158666b.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 05:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691931163; x=1692535963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT45U16gdzFUbmZJNoZlsPIKCISK6hy/5gm3avKqqgE=;
        b=jE0/0gzJYjJ4oDk8fOU/2210VGxtTy0avMlOl8J8ojwkRzzYTN15dbAwmmFdRPlZy6
         A8ZSxdlwJgUdtumow1RlyRls2kaN5/uc8SXn3PEbt/rXmiGh0rqWJhh6m10lMmphOI5W
         qNBgvBcUtqKqI9APJO3qXDZBNs0+w8NzUghrxbnnI/zOPTLWbwwVYTvVu6yBMl3wE+3B
         J2VPe55DL+jGmFqJa0QiPaZeYd14dMriXkkGTb9lX1Wh098qm+t5Q5R9AZRoLiDimjxz
         YSI03KLP3YnUM6WFbVniojO+YgkXD0rvJcI3YEmY1rL/SZa/j465irD4OyfwbDgTlt1b
         2r4A==
X-Gm-Message-State: AOJu0YysAx4S/WbcdogZg2/rzbceiW0RRCvNEPgEsOlqYweuDduULsFe
	q8aKGpx16d/pX8fQQ8nZyTE=
X-Google-Smtp-Source: AGHT+IFcm3cDfhzGrlgyQbPCJoPF4OBKWlw9XuBoVPPfR5PRxEXv65zVX29JnnrEYWYeUbrycrVGfg==
X-Received: by 2002:a17:906:73dc:b0:99c:55ee:1798 with SMTP id n28-20020a17090673dc00b0099c55ee1798mr5030118ejl.4.1691931163196;
        Sun, 13 Aug 2023 05:52:43 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709061c0800b0099d9b50d786sm1293862ejg.199.2023.08.13.05.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 05:52:42 -0700 (PDT)
Message-ID: <1f07b556-19ad-7aa9-82b7-d03b540809de@grimberg.me>
Date: Sun, 13 Aug 2023 15:52:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvmet-tcp: use 'spin_lock_bh' for state_lock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230810131939.129343-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230810131939.129343-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_055247_647024_74D7B8D9 
X-CRM114-Status: GOOD (  10.23  )
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

Patch looks good, but please phrase the bug in
the patch title instead of the solution.

> nvmet_tcp_schedule_release_queue() is called from socket state
> change callbacks, which may be called from an softirq context.
> So use 'spin_lock_bh' to avoid a spin lock warning.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Please add a fixes tag.

