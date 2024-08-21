Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B593C52D7C
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Aug 2024 13:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vHItVhGb3V+3TIQOWp9Zr4xxc39Ed99x/wzSL4dGORQ=; b=bLS5yrfAI5att3Xp0c+UUkVmZp
	7KT97RkWgPlfnsSkExxJaNO05267+bjkjzxXpgm7XTCJIJGcwb/+zX8V8zXpQoJGZgrCtcUYqcV+D
	bTsmUW/4cEXL1P7ewVUkicoR10h2MLpWAkrXVnI7eapdpajb9rZ4DQ7HMfPXzcCNC0qNVU3yrgnzx
	8RFRFzBHmXaL5kZgJFD/l44yAJyYDhICFxBqgbFRleAJyzNUw+N677Mte4vr2KAX27U+iZwbxvkZQ
	ykQHHgpX3sNB07Y35VPmgNq5UCX+T9Dwj195QP7MIUpiXY5ymMyb3DXuGagL92mlS2ZXquXrAxRef
	lXb+ycIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgldh-00000009B2A-2SGX;
	Wed, 21 Aug 2024 13:44:41 +0000
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sglde-00000009B1R-1OZA
	for linux-nvme@lists.infradead.org;
	Wed, 21 Aug 2024 13:44:40 +0000
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-39d2e4d73bcso19576125ab.1
        for <linux-nvme@lists.infradead.org>; Wed, 21 Aug 2024 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724247877; x=1724852677; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vHItVhGb3V+3TIQOWp9Zr4xxc39Ed99x/wzSL4dGORQ=;
        b=muh2mrHLoS9hiaO6zXISvBNCCxpTggWA5qvbkzls3IXh/45P8bqp9TM+yAw8tQdGvE
         4LC167oRZu+I64X0KlN7M0zvah0htZG8QSM1rdUUtNvNErLJztdKzsDATFDAIYAtlRVz
         MxB3pn4u3dHRZxZZt1FnCgaDcRCgwemA8QnH10eJMPI8W/LM382Hh2PoL+i/oKx9Lugh
         SgxhHJrPg+IEZ8+XVdeVGZ3Ludc1JbNfzY746nsffszieYEtUGkFDJtE3jw2hmB9DdQJ
         NQUvhXvlmhI3HoBpMClYugU/R4RHq7n4LmapOhBAq7kLMjk3l+NRDXcyJfcY/s4OQvJA
         jjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724247877; x=1724852677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHItVhGb3V+3TIQOWp9Zr4xxc39Ed99x/wzSL4dGORQ=;
        b=UK2L9SP46ZGvpdVgraBEPN2yEnvbNjmGZqcdWiy593cSkgmqB/2yLdcgNVKpvj8u2G
         oMMeuVufDwYZQEgII2PJkUpjG50o6ph243W+FcZVa8IKYeF5nfdz1KSAm3+KpntkIWov
         IalWAU2Er3TXwOEkxUDW1YINa3pj3cz7tbZjtBGJLQooMs/PFObhJt5hriVg38CVp4Hi
         M5WhYkefecTUIqN8ViqRGqHA3IQ5O04rbIff7QRCl14yDsLUaUIE19C2y1UqyIelO5Ee
         5UsgmvK5fKI7WrF6t6exweD5lY7ZJea2SxMB8s7mn/zJl7Ro5FDmMkwCNjo0dXdtnUey
         3x0g==
X-Forwarded-Encrypted: i=1; AJvYcCV0SRn7HJcDAcS+BttBu9MFedkl+vWLJZNB6QuzGT37BCMoYYk/Hy4+ku9dqVazm+NxVjcrZIRKUtow@lists.infradead.org
X-Gm-Message-State: AOJu0Ywh2lhXR45GrxWnXpR91+IzkH/qsSgbkFojyeTUNDakLJYd8CzQ
	Ly6uompKoEwgi8pWWjn6YVSGSJfo5UhonOLvuOrqgm908mSPzPraGX+nftMmqbA=
X-Google-Smtp-Source: AGHT+IFnCklIY6H42h6ahSt2F3WsbmONgA3Lw/ZJ+7PBoorE3+QpDfCxfT2z2k6G81kUKvx2/AqigA==
X-Received: by 2002:a05:6e02:1b0c:b0:39b:2669:4e44 with SMTP id e9e14a558f8ab-39d6c35a070mr28423255ab.8.1724247876612;
        Wed, 21 Aug 2024 06:44:36 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d1e651d9fsm50281715ab.0.2024.08.21.06.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 06:44:36 -0700 (PDT)
Message-ID: <cae13c08-78a7-46d4-8161-e2c5c7b0b8e7@kernel.dk>
Date: Wed, 21 Aug 2024 07:44:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: fix kernel crash if commands allocation fails
To: Maurizio Lombardi <mlombard@redhat.com>, sagi@grimberg.me
Cc: hch@lst.de, kch@nvidia.com, linux-nvme@lists.infradead.org, me@yawk.at
References: <20240821124026.62999-1-mlombard@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240821124026.62999-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_064438_549272_E3B1DF91 
X-CRM114-Status: GOOD (  10.44  )
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

On 8/21/24 6:40 AM, Maurizio Lombardi wrote:
> If the commands allocation fails in nvmet_tcp_alloc_cmds()
> the kernel crashes in nvmet_tcp_release_queue_work() because of
> a NULL pointer dereference.
> 
>   nvmet: failed to install queue 0 cntlid 1 ret 6
>   Unable to handle kernel NULL pointer dereference at
>          virtual address 0000000000000008
> 
> Fix the bug by setting queue->nr_cmds to zero in case
> nvmet_tcp_alloc_cmd() fails.

Please add an appropriate fixes tag.

-- 
Jens Axboe



