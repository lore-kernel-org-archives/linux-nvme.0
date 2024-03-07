Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B16C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 10:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8BATSlZ0bJzguOF/jrgBg/zqvJooUIPN3PqVoY63y+A=; b=rVeAzITkvGDMxUBC4Dx+6XH/YU
	894k+ZRhzhe+ldNSDIKUo16M7QKMi9S//ArXv2DxdhbQK4n0P47V2N887ifiBZ4ZABPYX+OF9Cjc+
	AexgbQPEjVXmf8u3dYusXr5xs1GcNdX450jhNc/9kJSERxjy+8nu0JW3xxDrdmn7t1WZt9aKxM8KL
	EuM8Hrg6jDv2w+4JQORZodkDIQFj4WC+GQKH/5U2HHA5pqafTWSazrypvq4sFTSbYzoxS3FkDg50f
	YGezMt8p6lwQxfcnB8i8AFQcn7dFJtF6KFhQg+m06tQYo/49KOXaHYeIy1IOC5Cw30xBAsqI245k1
	335wQ9ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riB7s-000000047nP-0ACZ;
	Thu, 07 Mar 2024 10:37:24 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riB7p-000000047mv-2auy
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 10:37:22 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412b30be60dso443935e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 02:37:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709807840; x=1710412640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BATSlZ0bJzguOF/jrgBg/zqvJooUIPN3PqVoY63y+A=;
        b=czHt2WMTdX8x8unZLMPxN/LC16+NhUKeI26Tspx68000+o+1JIIcD46KCMsX0W0v6Z
         27WaYYVT702J7OZQFMSLfC3K09oMu5hfSx6traNFYHjepIlj433ajVFD4ZdFjHKdHbEj
         kLvw4QRlzP9PnVuU0O1XdH6NP/3lI+7Smt2d8mN0BF+ys/ajbpqiRRLI1HYINK3IKSJo
         T0f9KipfmZ/tsGNxspxLVAY7RvLAVNpu6VJ6vEBQ2wMJZGPl+RX8u+qaxiNZdiYNT87Z
         vrjN3BcTYrQ5jtqGWHY57ZeM0EuoFg0n2pGEAxSyspfA5ew+6l+ql5qAe0y52JlUtk9+
         AL8A==
X-Forwarded-Encrypted: i=1; AJvYcCX3HBoyvbGLo6MSVwKjSqNiTl6hajTSTo4zCvfOKYCa9/KZ6f+GSJS60mhSCKfbjot5PZpXoa979d6Lj1NvRVdCHx3VVM/RvooHSAh1WJo=
X-Gm-Message-State: AOJu0YzpUnTGMbXZmlw+Bu6PM7g54nR+S4YYntxO55iPf0KGkGMVCuNN
	fxHKHK28Uyq1vAHOKl9giyxA4OwBcXXgwCEk65h3t20sCZmUpjBp
X-Google-Smtp-Source: AGHT+IFrdq6EjlPGOqtsmivLBKMRpL4WVIFnlojV12Ix1xajxOU0/7FtuZOEnedgb4LMsXdLoJF7/w==
X-Received: by 2002:adf:fb06:0:b0:33d:b387:88df with SMTP id c6-20020adffb06000000b0033db38788dfmr1066821wrr.7.1709807839805;
        Thu, 07 Mar 2024 02:37:19 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d59c7000000b0033e475940fasm7594638wry.66.2024.03.07.02.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:37:19 -0800 (PST)
Message-ID: <01935bbe-02c1-413d-aef2-a228af5cdcbb@grimberg.me>
Date: Thu, 7 Mar 2024 12:37:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme: authentication error are always non-retryable
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240226080628.21220-1-hare@kernel.org>
 <g3rnirwykldnoved2rojfkf3xrhkv4hai46m3b45kt4tzxpvyx@gqhr3v2l33ea>
 <dx2l57pk5mncqduqu7l36grz4uwlu4k6wcb6gfwaiqxt66itja@rl7kb3ittvb4>
 <99094fa7-35d4-4ae4-bf36-f3c4a346dc61@suse.de>
 <22csajx7e5g6rwwhzsn5a5sq566jsigp2oqpqb7yewkqgemshu@4nnt2lt4277x>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <22csajx7e5g6rwwhzsn5a5sq566jsigp2oqpqb7yewkqgemshu@4nnt2lt4277x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_023721_691323_8573C9C1 
X-CRM114-Status: GOOD (  13.20  )
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



On 26/02/2024 16:01, Daniel Wagner wrote:
> On Mon, Feb 26, 2024 at 11:54:13AM +0100, Hannes Reinecke wrote:
>> Maybe this?
> nvme_uninit_ctrl already puts the ref, thus the nvme_put_ctrl in
> nvme_loop_create_crtl is one too much:
>
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index de2ff7ed0657..bcda781e52f2 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -615,7 +615,6 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
>          kfree(ctrl->queues);
>   out_uninit_ctrl:
>          nvme_uninit_ctrl(&ctrl->ctrl);
> -       nvme_put_ctrl(&ctrl->ctrl);

Are you sure this does not cause a leak in some cases?

