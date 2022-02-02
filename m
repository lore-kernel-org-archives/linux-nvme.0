Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D65C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 20:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oIyPxiDfzVDRtE7UMRXVR4ajUxUuMcTHsY89cmsysY0=; b=06Dd9GDGzcv8+BIbOMa83SzoBo
	66z6fpEhJ5grWzTWK9N8E3Yj5KkAKreE0/GSyvfODZ61eUs25eBxo3KK/Zup8Byql5DOO8Y69kWOV
	hnOwTWOs32mnegvVCuK2KdTH00O8j4ArxhQ3dOORESdI3uwxGUk8NgXraQOK3etGMoo5pbFhjhRee
	0ACV0PqMCmgyhM+KVyBngnBS3pDm8Ma93Mg3nVa3pKqhrJthkEzeFFLvsWU8WqWoPhWLR202WbxcO
	UUS3XRlb8tyFHG9vpWwUFeU0XVKRYEUnh0PXh/liZkf7zTHVW7PPNmpVuZy02j7TJcFODsZGMXCVQ
	IocRvaAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFMhJ-00GruT-Rl; Wed, 02 Feb 2022 20:57:49 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFMhH-00GrtA-63
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 20:57:48 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 bg21-20020a05600c3c9500b0035283e7a012so446499wmb.0
 for <linux-nvme@lists.infradead.org>; Wed, 02 Feb 2022 12:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=oIyPxiDfzVDRtE7UMRXVR4ajUxUuMcTHsY89cmsysY0=;
 b=aj4y7hlYFKCqUZnl2gRlD+qzGQj0erHZ9h1rwuH3c2WVtDysQr7Bh26FYvkTkonrXG
 46G0NuJ1hOCkHEb3xwduFD9cpWUy90bsElk7Bmz+c1XT1AkDGPr/j2L3CVD0VtYv8YAI
 XpWDR3ur+LKDHrgrrenkLS1evOZp8vWjOLUYyHI9r8xxaB1hfNK1TOhi2cnsrfTpQD0j
 DeUIGx2R9w6rDpMHLE7+Ive4rgxUjXZK8QeMGs63QYFlvA7B1lsC3V/L9ijmK8zj6LlO
 SgUF2SO3nMQD6sdXY3FKzlPK1P12BqAEjpzJguJwycJxw/EBigzyS/M/wxgKCHCC0X+p
 CHDg==
X-Gm-Message-State: AOAM531RneqlVqZJQyu6I6/NAq0p367ncV27hJGkIELmQcFg7SgkKl4g
 x5oTTB6WyAiGlbMNGnhiHeI=
X-Google-Smtp-Source: ABdhPJy1hTjgBquVbH7T+1Pchv+xCOouM5FJq4sGB5simcA3jH1shtiSVCxikRUxKMCs36j8SgHk+A==
X-Received: by 2002:a05:600c:4e4a:: with SMTP id
 e10mr7762089wmq.113.1643835464462; 
 Wed, 02 Feb 2022 12:57:44 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id h4sm21701817wre.0.2022.02.02.12.57.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Feb 2022 12:57:43 -0800 (PST)
Message-ID: <2640b631-f8ac-ab4b-5ff1-884972f25334@grimberg.me>
Date: Wed, 2 Feb 2022 22:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF TOPIC][LSF/MM/BPF ATTEND] TLS handshake for in-kernel
 consumers
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chuck Lever III <chuck.lever@oracle.com>
References: <3a066f81-a53d-4d39-5efb-bd957443e7e2@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3a066f81-a53d-4d39-5efb-bd957443e7e2@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_125747_233783_6F4A6D0D 
X-CRM114-Status: GOOD (  20.90  )
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


> Hi all,
> 
> nvme-over-tcp has the option to utilize TLS for encrypted traffic, but 
> due to the internal design of the nvme-over-fabrics stack we cannot 
> initiate the TLS connection from userspace (as the current in-kernel TLS 
> implementation is designed).
> 
> This leaves us with two options:
> 1) Put TLS handshake into the kernel (which will be quite some
>    discussion as it's arguably a userspace configuration)
> 2) Pass an in-kernel socket to userspace and have a userspace
>    application to run the TLS handshake.
> 
> None of these options are quiet clear cut, as we will be have to put
> quite some complexity into the kernel to do full TLS handshake (if we
> were to go with option 1) or will have to design a mechanism to pass
> an in-kernel socket to userspace as we don't do that currently (if we 
> were going with option 2).
> 
> We have been discussing some ideas on how to implement option 2 
> (together with Chuck Lever and the NFS crowd), but so far haven't been 
> able to come up with a decent design.
> 
> So I would like to discuss with interested parties on how TLS handshake 
> could be facilitated, and what would be the best design options here.
> 
> The proposed configd would be an option, but then we don't have that, 
> either :-)
> 
> Required attendees:
> 
> Chuck Lever
> James Bottomley
> Sagi Grimberg

I'd be interested to discuss this.

One other item with TLS besides the handshake part is that
nfs/cifs/nvme-tcp are all tcp ulps like tls itself, which at
the currently cannot be stacked IIRC (all use sk callbacks,
including tls).

Is anyone looking into enabling stacking tcp ulps on top of tls?

