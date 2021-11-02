Return-Path: <SRS0=i2V4=PV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7B8C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 23:05:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8D860E8C
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 23:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B8D860E8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Duga5kaFb0FUlQ1IRUQQxBEpwHIVVkyBusQRJc73mOo=; b=ykdiD63NMl1MPDRkyenOPEscg0
	41vFYIzsoK1R330ZJ0VnPZkLpqS8M1S+gQWU5njf1KRAFdl4yroWcU96x689uHr9SU7K+SigO1DLu
	X3tL2jn74QhNLpMBjhi1fM2Hu55zQaC5Q2uVG0+g/lA99dwu9Ewo6L2mKC6dggIdsikwJSY4+35j6
	z0V7CmgM8HI6ByKnd1GS9Z6IgKH/Z6hz6nQ95vBPcqQ2ZZeXA2Iws+FQrYL/Losta+9ghk9ToHxCR
	rXy0ZC9s2ZcvIB93qweMcWclLsFgJ/iFX9+9JZvqMEUJnnhBke8UNElKxGIxP4HS52WItty5ZhIH4
	II0qWoSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mi2q1-003IJB-RA; Tue, 02 Nov 2021 23:05:05 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mi2kt-003FxS-BR
 for linux-nvme@lists.infradead.org; Tue, 02 Nov 2021 22:59:48 +0000
Received: by mail-pg1-x52e.google.com with SMTP id a9so682988pgg.7
 for <linux-nvme@lists.infradead.org>; Tue, 02 Nov 2021 15:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Duga5kaFb0FUlQ1IRUQQxBEpwHIVVkyBusQRJc73mOo=;
 b=nIsbgQ+EjMQfD/lsHhZvCOmlRzDxLNXyxziZLxOB+s8/3FD00Bmqjjuhr8jogDPaCO
 OaMc2g/77xknfFIXWe/Wq7yxgblw12DD1ODR6mfqcVFfEgXgDaBrv3PbOyV8ji+qDzAJ
 im8aLomMc06/D5yX3Xvij/Bi3xTeTglFyXP3W0ea/WZEwg98pT9UJCiL7VA/I7yobGfZ
 b1M6iqk3SRUql6ekfICQ7KKZGSyeFS1azYB366Fk5tO3Hic/HlXJgGrpcxYd9VRI5iFm
 mtwVODoWi/oW913dR5PWfBv2jieGx7JiANH88rKuxNORridq7dsambcb7jN2m6k22nwW
 3MLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Duga5kaFb0FUlQ1IRUQQxBEpwHIVVkyBusQRJc73mOo=;
 b=u+XChrPgxxn4kyDwjP6ktN8aGMgYwn3/xvXZfPnX9rpdSufZ2j7QSL5eDFG28mlClE
 EYS31wdQzkqckDdtILRWhWc/rWD3770+6LpvOlIWb+iNiryV/CdhzVHnY8TyzzDIlLIY
 pBGcQ5d8vIvox/lRAzgL6GPoxYD+xNCzPqYxXCJEVYzhj7RdiH3OzBWHiaU4M19RzHjp
 jaDx+smr/GkbzBdzog1hJxCv53+cc4O+gyTKiCIO5L3vAA7RxnPEswadNRkbgou00k0j
 nVPouXf77IQEnWzp+orH6YOQjmUNyzXwClvUDUn0nFqbRAm91q9mgK2JoV9ATh54UrQ9
 VxXQ==
X-Gm-Message-State: AOAM530dSZ+L/UwqUBCGb4LK90ytg9/gYZDNT8M7mWMmhQhy5RiGP0q+
 nSiowOnaqM39S7M7mxD4U6E=
X-Google-Smtp-Source: ABdhPJylDekw/8kahsqadviLkMtiNuTa/863LvLcv2EtOcytzneQrV/RSj58NeJYrT1sKvr9RH2ZtA==
X-Received: by 2002:a05:6a00:1906:b0:44c:b35d:71a8 with SMTP id
 y6-20020a056a00190600b0044cb35d71a8mr40421772pfi.51.1635893985752; 
 Tue, 02 Nov 2021 15:59:45 -0700 (PDT)
Received: from [10.69.44.239] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id m22sm198054pfo.176.2021.11.02.15.59.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Nov 2021 15:59:45 -0700 (PDT)
Message-ID: <f38e1b96-8c94-2a71-bd4d-7c1fe6836305@gmail.com>
Date: Tue, 2 Nov 2021 15:59:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 01/10] nvme: add connect_work attribute to nvme ctrl
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com, hare@suse.de
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
 <20211020103844.7533-2-mgurtovoy@nvidia.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20211020103844.7533-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211102_155947_470467_35003F00 
X-CRM114-Status: GOOD (  10.34  )
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

On 10/20/2021 3:38 AM, Max Gurtovoy wrote:
> This structure is duplicated for all the fabric controllers. Move it to
> common code.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/fc.c   | 23 ++++++++++++-----------
>   drivers/nvme/host/nvme.h |  1 +
>   drivers/nvme/host/rdma.c | 10 ++++------
>   drivers/nvme/host/tcp.c  |  9 ++++-----
>   4 files changed, 21 insertions(+), 22 deletions(-)

Looks good

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james

