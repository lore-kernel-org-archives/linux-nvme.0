Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A695EC74A5B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 15:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6FI5sEbkUhApVcE0IJUt2azvk0Blp5zEnwZxVcHOd68=; b=Y83eYRN89wlQzYQgckrbXiXCSc
	etSqh/FSdkpzC5AUXh/wE+n5fNOxtYJWjLHrgt8ZVRouPCsQBtRl5inNaWXxk+Ovv/H5NANNQh/9h
	w+u3LJXRxhCtMRYD36eyZsnBVgXDaHPc9J/MK5/BVU1+jAZZwNBzkkJEEnCZogIcl7A9vKFJtdpE8
	gD5SyFuZO1iGHsxuMMw7BZuElS7qA1Qzx3TDSXkaDNenRST3VojopWT5MVxsdsz9fEBpK/SH4PGgC
	+z8pRB6r8r5+vrmWL9PjnCKc+IS7ldGK7hfNgoJ0MshyvgixaKiel9Pmicduy4x6AOmKNHtsC9VDQ
	AU4Xd4Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phXxQ-000qRh-2t;
	Wed, 29 Mar 2023 15:43:28 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phXxO-000qPl-0i
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 15:43:27 +0000
Received: by mail-wm1-f52.google.com with SMTP id s13so9199836wmr.4
        for <linux-nvme@lists.infradead.org>; Wed, 29 Mar 2023 08:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104603; x=1682696603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FI5sEbkUhApVcE0IJUt2azvk0Blp5zEnwZxVcHOd68=;
        b=3Wg4zH24GoTEhqG4Ygxk0d/n8ZkyHOdQhzkC77QkxrKMwk6tLsRWLtaW961hRhLn0+
         oaeDECpMm02VmeYZ/xgJHAxH991VXTKDcVnZrU4b47SL0GzXxan/2ZwvEpCewgpUUms6
         S/Kl9hkQtLbt0n68IhXM9Ly1HeHLEtfkxYmJeBo4IlN5dNVjUjc/4onfNhtzq88N/bH3
         vbmuNr1hfE6rUH/TOketiUm9T5SilhCW3/Hvpoilr0g2V2itDgv0Jtll4MlKkNPKI4/O
         MgqrdEVgJNqozeqPNcXc+p4m6ENwYijtJw1OIA3K/74/IVuxhY/8afESFDcBaIb9NSiY
         VOiw==
X-Gm-Message-State: AO0yUKVePlrpm8ds2k54KAN6ZnfiKp9rXxeITex7W7wpz6HsQ8GpYium
	bQEuNWYsz7gthb4xTW64nP73lvXx/Bo=
X-Google-Smtp-Source: AK7set/vSWjzqBbAoi9V89BLrD/KBoaZX2t6vdyrtIC2wXSVHJqWNuWBoiPoLjJ2EodLr1FsK7Q6ig==
X-Received: by 2002:a05:600c:1550:b0:3ed:d2ae:9adb with SMTP id f16-20020a05600c155000b003edd2ae9adbmr17593443wmg.0.1680104603467;
        Wed, 29 Mar 2023 08:43:23 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c191300b003ee1acdaf95sm2794562wmq.36.2023.03.29.08.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 08:43:23 -0700 (PDT)
Message-ID: <5fb6ae09-6174-e619-3923-dc33aa580336@grimberg.me>
Date: Wed, 29 Mar 2023 18:43:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 05/18] net/tls: implement ->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-6-hare@suse.de>
 <d177a5d6-3f76-4eee-0cc5-2c6d995c2e8a@grimberg.me>
 <d97fa181-077a-6183-bdd2-17ad51b0fbc9@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d97fa181-077a-6183-bdd2-17ad51b0fbc9@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_084326_261111_00D2E971 
X-CRM114-Status: GOOD (  11.58  )
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


>>> Implement ->read_sock() function for use with nvme-tcp.
>>
>> Nice.
>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> Cc: Boris Pismenny <boris.pismenny@gmail.com>
>>
>> Would be great to see a tls_device implementation as well.
> 
> Sheesh. But first we would need to update the tls_device implementation 
> to TLS 1.3:

;)

The comment was for the nvidia folks..

> int tls_set_device_offload(struct sock *sk, struct tls_context *ctx)
> [ .. ]
>          crypto_info = &ctx->crypto_send.info;
>          if (crypto_info->version != TLS_1_2_VERSION) {
>                  rc = -EOPNOTSUPP;
>                  goto release_netdev;
>          }
> 
> which I'd rather defer to Boris or whoever maintains the hardware

