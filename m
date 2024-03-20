Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB3FC54E67
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6yo+qgVl01Qo1BF1UC4nxMuI0iLiXWCwLlUG0wpTjWA=; b=ItoQrZQbdz8VnJ88Jq/JCyCwKa
	/8Ny5EtjtV90FtRoxQqgFigTxlIMev7iE1ofvKN/SHvTWETML2Ec9uk+Fd4twZXH+qXAfs+jxSGe8
	NIgShhvvoMF8cAksXYFRzYHmCtBDiN6cEhe6uqrQZoLKw5zmTabWLpEdJLk/OAkjkOqAMUsYZHZUh
	GDPdkmuIsFRhbmqtI/e9ITMt1iRCmU2dFzBygHSqE3lBy67RA1aLBpK9m9+/V9ijmE+MPTJZBkQpj
	Zp8wvrFLUCO/Qi5B253i0ZvDl/byk1wOG7GpR65MFaNn7QFyTVOiT5NdlLhnDjFoDP07Fx5jjuMhe
	lbRZJ9CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmruA-0000000GO2q-293t;
	Wed, 20 Mar 2024 09:06:38 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmru7-0000000GO1q-37zD
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 09:06:36 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e9115d501so2049404f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 20 Mar 2024 02:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710925593; x=1711530393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yo+qgVl01Qo1BF1UC4nxMuI0iLiXWCwLlUG0wpTjWA=;
        b=PyLreZlullemoKL9TVZ5qSbl+w4GVuUvrcyxpkiev000QKmKSSp9aiJY3dmsjza4j+
         FBApLkF+cEgL8SphL8IgngXNt59IAB6qvprHlDbVlD2m0BLfF35fp1RkW+oDfNYACyn8
         gJ8cAhj6k7qHQ3pkk43aKUpV85fWMdusglmUNB/hfnsFroMw8O9jdmnG53aq3v4ApRkX
         bkAn//32Qr6tGb1ruYnth0Bc5as8exlEnxNKZMojzup2XAqjhnUTIbgcnXKmezXTG1+T
         L2F32rhWwqmcpc91odK6Z/zaZpCPWW3ZxoB78IVf8UYJWfa7+5vBPC3ohJNJYAPh4st3
         D9mg==
X-Forwarded-Encrypted: i=1; AJvYcCW95BqMbXads+uyv/H7M+/Ff6LmNHD3VlDi0bcpKzuPk92ZkjDZfm3dhvJ7br8fvmlAQ2WXSwS2NpMN77R2tyP14CzWpMRM7j8g9kg95pY=
X-Gm-Message-State: AOJu0Yyk2M9Hol16oLDPJ9xbUz0797Y5Ey/UdgnXDwZh2k2AEk8WC43z
	QvithcqiNZjFtbEQeOmoZEEY0FetqP337Fw3P1diN1AYWF3occ+l
X-Google-Smtp-Source: AGHT+IEw9+P2JdVs73otAM3hXGLxpH87fe+1tvU44C8aG9UtPwVZ6tid9SowJLGsDChZTcaXJ3kC/Q==
X-Received: by 2002:adf:c988:0:b0:33d:9e15:12bf with SMTP id f8-20020adfc988000000b0033d9e1512bfmr865963wrh.3.1710925592737;
        Wed, 20 Mar 2024 02:06:32 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d6309000000b0033e0dd83be1sm14034690wru.91.2024.03.20.02.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 02:06:32 -0700 (PDT)
Message-ID: <a1ebff42-4ddb-4e17-978c-2f02106a9d90@grimberg.me>
Date: Wed, 20 Mar 2024 11:06:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix bogus request queue reference put
Content-Language: he-IL, en-US
To: mengfanhui <mengfanhui@kylinos.cn>, Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240117065043.79192-1-mengfanhui@kylinos.cn>
 <b926d754-130d-424e-b099-001e14badc50@grimberg.me>
 <20240117143952.GA27918@lst.de>
 <c934831a-ec84-4ea4-a156-782880086ffe@kylinos.cn>
 <2db9e75c-7c17-4f1d-9328-5eb18fd86d23@grimberg.me>
 <4b9e1f54-9032-48b6-bfbb-d47a4b7857e3@kylinos.cn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <4b9e1f54-9032-48b6-bfbb-d47a4b7857e3@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_020635_873551_76833D00 
X-CRM114-Status: UNSURE (   6.73  )
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



On 20/03/2024 4:03, mengfanhui wrote:
> In this scenario. upstream should also appear.

I'd be surprised if it is,

The proposed patch was superseded by:
f165fb89b71f ("nvme-multipath: convert to blk_alloc_disk/blk_cleanup_disk")

Please verify that this exists upstream.

