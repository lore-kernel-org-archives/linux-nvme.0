Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF535C61D97
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Nov 2023 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iD5y/AXHXy7IEN3o2PczmJZ8Uo+vDaHTC3ZVRWIsVdU=; b=4083qh8TH9zSg6H0kROt09p6Hg
	tLse2WA9GWiNXksSlDP3DwG2PgUPBZa0VFOTHNCGL4PWwE8ACRvt3w48h8BCQP8K69488sT6WPi/k
	DrqWbakyHUsmFjAzFCpCoQOsg4R6SCJk6gHhYNwt79//YcaI4pVA/rHdNAFQud/NQjNu3mJ94WZdm
	hZ0jrGNTRwUfznQZygniSDcBXapU8lT3aXMmsYWpzQ/kTtlv40jtoXbxQ0LB4op5RmSohVQz+GWRT
	mtduDEwXNKzmmn3q3l6tt5kKaOGo/ZJV99BssfCbv/pDOyKK1S/Dt1pYTBF8k/eXz4ZU5BFER9lo6
	pUGFKAaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5qtR-002duW-0O;
	Wed, 22 Nov 2023 17:20:05 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5qtN-002dtW-3D
	for linux-nvme@lists.infradead.org;
	Wed, 22 Nov 2023 17:20:04 +0000
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35c1649e01fso560655ab.1
        for <linux-nvme@lists.infradead.org>; Wed, 22 Nov 2023 09:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700673600; x=1701278400; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iD5y/AXHXy7IEN3o2PczmJZ8Uo+vDaHTC3ZVRWIsVdU=;
        b=sFmZu5RfW3DX65YhXuraF99BEmmKWgVQX6mUe5VeFGrler0G5AaS8fRtbUm5zW0k6N
         vbIPI1mKuqqg1u+KJRd4/JfS/LKZFiXbrnJRlvlsFXb5XaDGA8BbrnbI7dhXjp7n70jK
         LZbMyV/AOvPXpVwXKhgYCkOO0kfPPUGDkmufNOUxI9inWTfHWisDPqWqFGS1Y49c22oT
         AjJ89bpvLB4SDjY21NC4ORNlwsjRx5IuIrFFcUDouyYoZlIrIl9X6zBXFlxIj5hJta+H
         FWX9abNWb6eix1MuaXt8ayiD9e2iRmJu8NW2xJyS5zZ+GonTWPVxB4m41pFbn7ivGH/G
         NdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673600; x=1701278400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iD5y/AXHXy7IEN3o2PczmJZ8Uo+vDaHTC3ZVRWIsVdU=;
        b=NXoR04RDB5B9h/I4OBaaWF4zVDdIPTtAhAmz94XE+oyxqNccnw1+JK1BWleqW7V09D
         gK/vGL8ZrGBFuQzxqnCWF77Jiq0v+zfU3g7O76WtB7uijASDe4yMpLoYnOmhJNY1qHke
         Ie8aymYscAwniSTm+9VhsfdD203/PUYY+a4xV8qdh5VrqY/2KI0Tz2ahd8H+mxOEbngm
         G71GS7YAr4La17vjcNfR5f4K2ScKzv6J9LUsew02dKSZZwerIlr67FuDRy0Brg9lZcAz
         5XWzf+AoG35OC4ngJ/L7ixE3zQ87gJ5lI/5vhROC+80izx2vbx56yDJA+RBOuv4Qsr6x
         eBeQ==
X-Gm-Message-State: AOJu0YyCx+h7RKsAaVpcVFlAKdLYWPPqWoiE/Pp3TTxuzmMLxkFQhWbH
	jIkBFmLqyhXGGtI5UQQCT3dFWQ2Dlxk4p2h91wXSHA==
X-Google-Smtp-Source: AGHT+IFSAX5XCj9oK4qoOcZd1G9HOsPtECdIMJW9lwmWhqQoYzNjhl/92cSkGsU00WO3deKdID/OYg==
X-Received: by 2002:a92:c0c2:0:b0:359:4db7:102a with SMTP id t2-20020a92c0c2000000b003594db7102amr3298014ilf.0.1700673599778;
        Wed, 22 Nov 2023 09:19:59 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bd4-20020a056e02300400b003576e122389sm17429ilb.24.2023.11.22.09.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 09:19:59 -0800 (PST)
Message-ID: <e93e4c2f-94ee-4b76-a017-a6e4112c7283@kernel.dk>
Date: Wed, 22 Nov 2023 10:19:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for 6.7
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
References: <ZV4sDByrMVX696n1@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZV4sDByrMVX696n1@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_092002_227527_0ADBEBD8 
X-CRM114-Status: UNSURE (   9.00  )
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

On 11/22/23 9:27 AM, Keith Busch wrote:
> The following changes since commit 37d9486874ec925fa298bcd7ba628a9b206e812f:
> 
>   Merge tag 'nvme-6.7-2023-11-8' of git://git.infradead.org/nvme into block-6.7 (2023-11-08 09:19:16 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.7-2023-11-22
> 
> for you to fetch changes up to 3af755a46881c32fecaecfdeaf3a8f0a869deca5:
> 
>   nvme: move nvme_stop_keep_alive() back to original position (2023-11-22 08:07:02 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.7
> 
>  - TCP TLS fixes (Hannes)
>  - Authentifaction fixes (Mark, Hannes)
>  - Properly terminate target names (Christoph)

Pulled, thanks.

-- 
Jens Axboe



