Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAFBC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 15:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eSa2bWV9LGHkjnuUMJ/I8mVLxiJrfxl78vNPN3SzrsM=; b=WpyqNDWo9R5XWk7O5Nuoe3PJ/S
	N8t8FC6u1ujSL9lefHHcz1QMYO8eewedxAAsCmE4vIyuNObOhg6Xgf8wR87lCUJ0UCZVikhJVHPoM
	D5FhRZlUDly3yAztZ/quG21hsoc7c29BWEmg35AN2oEXWZMbq3c4hDkVs0m99Udr12NS9LJBOKKmr
	xp0QBMacgr+lZ43CHwsFj7MFMpMbajQZ6PVCbVm0yfjGrhQGgUOocJxXelTz9Y9eH4QXv1UQ2OYv4
	jqBQ6OvHVzVqRv6qNqvUPeC+LNAFrjzM5OI/MIB7kAlNm32wohmw77yP4fVVYDMHfoCjQJHGFL71p
	V3uz9nFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHohH-000X0P-Do; Wed, 09 Feb 2022 15:15:55 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHohA-000Wzz-RY
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 15:15:50 +0000
Received: by mail-wr1-f45.google.com with SMTP id o24so1967658wro.3
 for <linux-nvme@lists.infradead.org>; Wed, 09 Feb 2022 07:15:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=eSa2bWV9LGHkjnuUMJ/I8mVLxiJrfxl78vNPN3SzrsM=;
 b=eq9BwHk567Re9QlTuwt/q7ffhKy2gcNWjJgGg6zHuZYw8yNegVln3qLT8klFdiaJ/q
 wZVfhDdt30Alk8rxzBxnizErOaQF0jwt6TiHBOD2bMFn267ZQ+Y4ACUIjXZLOBc+Eu7D
 G5ejiXGW+5ZiLBLCK36l/y4nm018+mBgEAgJ+i4Tpxi+7yCsGzz8N4v2CfeFd2xZcAAC
 2wiBGwFtte9s75WyNE8u+AXCK7T6EGK3mw2kdqNaFe8Lle6XGSTNiX13QutEfav3xVeH
 qRs5tA7aUlVdkm0sX3lJmayKZWkbHOWvdVWtGVJBljIaof29kvzorm2JlGukZfSa1yvM
 dj0A==
X-Gm-Message-State: AOAM530RMDEr9QSbx4mK/gvKMP6pVSrQQFUrrkwBvfy/oNHAXbuxVit8
 vsQ4ABUAkNfZ9C9ydc9gAGo=
X-Google-Smtp-Source: ABdhPJyEplmqaAKNRJne7LP2A2tUuLWc7T9RKhE5qhtwQcs0+cfIRZi3ohPiUKxXZxpjmmiov+RI1A==
X-Received: by 2002:adf:bbc8:: with SMTP id z8mr2463611wrg.476.1644419745712; 
 Wed, 09 Feb 2022 07:15:45 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id b11sm5266870wmq.46.2022.02.09.07.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Feb 2022 07:15:45 -0800 (PST)
Message-ID: <b209fe09-9c8f-a206-537a-ee96d15d57b0@grimberg.me>
Date: Wed, 9 Feb 2022 17:15:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] nvme: add vectored-io support for user-passthru
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
 axboe@kernel.dk, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, joshiiitr@gmail.com
References: <CGME20220202103751epcas5p4914ecb890c2977eebe711ed7296940ba@epcas5p4.samsung.com>
 <20220202103252.2103-1-joshi.k@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220202103252.2103-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_071548_925012_F9C67550 
X-CRM114-Status: UNSURE (   8.20  )
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


> @@ -278,6 +293,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>   	}
>   
>   	return status;
> +

Slipped a newline here,

Other than that looks good to me
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

