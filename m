Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35F2C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 12:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sdw0udIPioOfji8kMmxA4oMI1yBA0JfzsJKPjAhtAWA=; b=UY6p74Biwi71FOUzLYjJgkLTv6
	XmqfmxUNcPfRI7akpTW6IkM34dy2O8tD3jLdPLJb4/wpn7mlintwX4uoLeW2TJ9DROyft2W+BlVca
	iZO25vLf2wi4KrE9BWASrY3jt0IeQ58TTyUw5F5x5U7xmY3nvMbWIROOZfDZhSFfNIICzeARbTIa1
	jSWzkPMCONkJunEjfncK38jjjZBA1skRgnVnJG68PwgNjv+uCrGEuRtRmGo3blOTn+7CipmFyIkoQ
	4sJuPEquKW01HDs+8B7qcng6Nd0FvcVV/Mq3AvcfKlNUuhD63SD/F1rfuk4fL9CnVqqcslTwG1p+D
	oiu3prKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrfRz-006hkU-4W; Thu, 19 May 2022 12:40:19 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrfRv-006hiM-Vp
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 12:40:17 +0000
Received: by mail-pg1-x52b.google.com with SMTP id a38so2077819pgl.9
 for <linux-nvme@lists.infradead.org>; Thu, 19 May 2022 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:from:subject:to:cc
 :references:content-language:in-reply-to:content-transfer-encoding;
 bh=Sdw0udIPioOfji8kMmxA4oMI1yBA0JfzsJKPjAhtAWA=;
 b=fo4nENJUvlgEzzuFBgAYKe8jGJnZGcjGdi+d7PZh/1eUhoJMLK+dct0fpOKT98ON7c
 ckJNtifZ9aIJAlsflqor63eM5daltNp6Lvr23K3p8icKJtNY9QFmrQAoWgfZ8Ea8XMq6
 ayDcCZJQzi/LqjlvX2q8NjZbmTzdQIGHEEaPYs1BXCkm9B5RwSYB66FYpQ3zroB8NmLq
 qVzHM6IJf12L78OWxAo/urjASdeOi2LBA56jnUcNdwA0OTcUTFWxqLhRYmLSquUagk/r
 jLvg/O3lamwOyHE+zI8z+ueGkO5WFKw9Q8dHgBpNuWYlmpfWtPsQptwy+MV4Km1KmAis
 yp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:from
 :subject:to:cc:references:content-language:in-reply-to
 :content-transfer-encoding;
 bh=Sdw0udIPioOfji8kMmxA4oMI1yBA0JfzsJKPjAhtAWA=;
 b=qmJ6+ibXr1EV0uEuhqGUDU0+T6kZROreqJJgirNBMAv9OZR8iyI7v8V1sPmNuqdgsv
 ysNNxc7TiQMe6XH7BRHpNDhZKWFet1yJj7AAceqo3Gk+/ld1dZbIiE+DQ3FyNzW5QKse
 FJa3Z3tI5wgjM4OzV6Z37kUjC1C6v2kg571BzHCjNqGuLniuS8ZPtVW/ErhvhA09Ifwx
 xpXFzvazgWGImGHqWnRp6c723tzGcAiHk+rxmIK6y6h9Mi9AOe+q4OwVpNuX7yge9rbZ
 /4m64O02Dz1AzsVDX3tyR6N0L7SWyhRsDEC/2wg0qkOtqMNapQGV2tmMmjQP80Rvdd/5
 XYfw==
X-Gm-Message-State: AOAM530t+QBJ+9m+TSyDOIAI2Ht4h1yO4sXnBY6tPlmwuq+GUkMRwVGs
 +tKoaSi+XUlnwecYbmoExiLJRg==
X-Google-Smtp-Source: ABdhPJxF82SRcAX2sgp+bKYASxaVBjIcM33UYVx0MJO9PwXKFxlJAjZ7huGY4gQ6/1VV3G74cD9VmA==
X-Received: by 2002:a63:5d22:0:b0:3f6:55cf:45aa with SMTP id
 r34-20020a635d22000000b003f655cf45aamr818358pgb.96.1652964013814; 
 Thu, 19 May 2022 05:40:13 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 r19-20020a170902c7d300b0015e8d4eb2e1sm3572512pla.299.2022.05.19.05.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 May 2022 05:40:12 -0700 (PDT)
Message-ID: <900f57bc-9978-9ba6-22fb-48f03fcf5011@kernel.dk>
Date: Thu, 19 May 2022 06:40:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [linux-next] build fails modpost: "blkcg_get_fc_appid"
 [drivers/nvme/host/nvme-fc.ko] undefined!
To: Hannes Reinecke <hare@suse.de>
Cc: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
 linux-block <linux-block@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>, sachinp@linux.vnet.com,
 mputtash@linux.vnet.com, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <86768c9d-9a9c-653b-ab99-86de3bc434d8@linux.vnet.ibm.com>
 <7b16694b-0281-d06d-7564-c4f26760a25e@kernel.dk>
 <fc5f8b96-3c93-5400-b917-a1d991cbe7c9@suse.de>
Content-Language: en-US
In-Reply-To: <fc5f8b96-3c93-5400-b917-a1d991cbe7c9@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_054016_072599_2BE96003 
X-CRM114-Status: GOOD (  12.93  )
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

On Thu, May 19, 2022 at 6:38 AM Hannes Reinecke <hare@suse.de> wrote:
>
> On 5/19/22 14:14, Jens Axboe wrote:
> > On 5/19/22 1:49 AM, Tasmiya Nalatwad wrote:
> >> Greetings,
> >>
> >> linux-next build fails modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
> >>
> >> Console Logs :
> >>
> >> [console-expect]#make -j 17 -s && make modules && make modules_install && make install
> >> make -j 17 -s && make modules && make modules_install && make install
> >> ERROR: modpost: "blkcg_get_fc_appid" [drivers/nvme/host/nvme-fc.ko] undefined!
> >> make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
> >> make: *** [Makefile:1914: modules] Error 2
> >> make: *** Waiting for unfinished jobs....
> >
> > Christoph, can you fix this up?
> >
> Cannot reproduce with commit 21498d01d045c5b95b93e0a0625ae965b4330ebe.
> Please share details.

The kerneltest bot also reported this a few days ago, you might be able
to find the details there as that includes config etc.

-- 
Jens Axboe


