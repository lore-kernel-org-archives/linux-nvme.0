Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55A3C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 06:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sm53Z3L17Zu+ow15vuobEJghvq7U3t4LFtEUPD1JM3w=; b=ZIIoY4SY2NFZgFARxUKaoJYGvC
	0w36/C1Ps3Ry5rC6dVUwcfjcLGeotW+NfwA9FHMJGUANXLm6maOmm1gh5+VnSVgwixdd/volEfEKS
	hmL3iEw1DHLYeJeCC0QV8NY52SOABm6Xj7gKF2Ud6GVzVO/L4LvT/huKCIQ+PEw4y5DFkyj3qGn2M
	yiTuMqnT14ZZhHG+jGdZO22/QPctb/I5EnDZ2azis59AklThCDnugiJyBFwTHogA1W1evTF1OPPgJ
	wwrjlqLpuGBd+OQPVaXXVsU1yDFLgPwuNHNgkmp2dsjr3IaRuWptZlq/0yLAdFay/9wWyeD3OG5tP
	pogVfJLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrXtY-00000009xKg-1d6N;
	Tue, 02 Apr 2024 06:45:20 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrXtV-00000009xI6-1JM9
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 06:45:18 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-29de4e12d12so3541518a91.3
        for <linux-nvme@lists.infradead.org>; Mon, 01 Apr 2024 23:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712040310; x=1712645110; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sm53Z3L17Zu+ow15vuobEJghvq7U3t4LFtEUPD1JM3w=;
        b=KQL3oP+W9U40R8fdQiDNU0CHtQqVvBMH+BZ/t3xLL6qJKawMMMUvjDBAu7K7dRwuaT
         D4uE6Wfe3pLbbExLiLu4HrGrWCWAgqQO25oh9XjigBHVPOFE3cNNi3c8dFKzA4JANxVy
         MxU+1esiGYuybOwxXbmYau6vxgxS00MUGmUcnkKo2CH4zSpVHHJ02t2qHRjhn2Vc91fh
         Sz63IUjz47dGoas2vYpRwqLXM/Wi88fwaeLeplj/M8shG1t1mXxEXBQgX4pXKltl+L+8
         NwXTRFCaOTIp1GabZeLFgcKOBZ3SwByAn4q3mb4/0Vc94h23VN0jxOHgczcAAs5MHmJW
         yJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712040310; x=1712645110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sm53Z3L17Zu+ow15vuobEJghvq7U3t4LFtEUPD1JM3w=;
        b=UoWzEj6BTgwAOy4tHD630mNhD2+MH+faPAck62qm/y11jwmR6irWG9eWp8I9fDn03E
         Ks1+JDh2pIeK4Dq6bc/vw0SJ98JqAYRNnu4OiG8NlDZbOtx3TV3WZashHe7gVfWout1z
         tXOZrDILxgJNa0TnWVngrZZtBr9P1mC1rUblTjgTr+cH5BWyof2GA3j9ucDmVuILLhFi
         PpA5JDicJR8G6r1e1734ZrT/jOZmzSiGcc2qEveyZMrJXRNJ4wuB/pfl3kmfCAs+jebA
         KkRsvV/9IFR51VnaOKCiOf6+YMH2gyWCtCCW/IAOkJFA1VAkrzR9LZqaoXBDp6WE4Eo4
         agYg==
X-Forwarded-Encrypted: i=1; AJvYcCWlv1j/GDl2ErKG4xBKa03yrHwMDlnPz8w4Qs6JREgTXDrbASTTSmhHDbol+jysPFxPKGnv6KUSQI4KC363IDzOk4zKS36ATTR0d+etvrU=
X-Gm-Message-State: AOJu0Yxq54cmdLxApE+R6ISwLFe52S2gJek6C7Y7QnzIo7DIowbjbmZh
	UDYMdmM4PUnR4RK1WO+IN+Y+0SzkHZ0tuvqjtI/a4On34qXM+LHATr/QgS+6
X-Google-Smtp-Source: AGHT+IFF93BCBK3FIDpFKuTXhn9tbpLReSTK3uggz3k0H38wO0A6ivGxtP9jVEkKk5ulOQtfh0hUQg==
X-Received: by 2002:a17:90b:4c4c:b0:2a2:6d6e:1057 with SMTP id np12-20020a17090b4c4c00b002a26d6e1057mr24949pjb.7.1712040310359;
        Mon, 01 Apr 2024 23:45:10 -0700 (PDT)
Received: from ?IPV6:2600:8802:3800:75a0:2378:fa3f:c6b3:24d1? ([2600:8802:3800:75a0:2378:fa3f:c6b3:24d1])
        by smtp.gmail.com with ESMTPSA id l20-20020a17090a409400b0029b2e5bc1b9sm10925785pjg.23.2024.04.01.23.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 23:45:10 -0700 (PDT)
Message-ID: <3e159b10-170b-4c67-80ca-b833b712d91e@gmail.com>
Date: Mon, 1 Apr 2024 23:45:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/30] nvmet: zns: Do not reference the gendisk
 conv_zones_bitmap
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-21-dlemoal@kernel.org>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20240328004409.594888-21-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240401_234517_386470_B9DDEFDA 
X-CRM114-Status: UNSURE (   8.36  )
X-CRM114-Notice: Please train this message.
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

On 3/27/24 17:43, Damien Le Moal wrote:
> The gendisk conventional zone bitmap is going away. So to check for the
> presence of conventional zones on a zoned target device, always use
> report zones.
> 
> Signed-off-by: Damien Le Moal<dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke<hare@suse.de>
> Reviewed-by: Christoph Hellwig<hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



