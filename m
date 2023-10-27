Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2F5C25B67
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 09:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D+R3d9PrexLe3gHqXe8BjIbJjsmG22nyj6pAcb2QmK0=; b=MmTHrqGMg7gWEb6xe/TB5npTJN
	cQ/S5k3tphuYNyyUWn1zUh6jHH7oxu+5T5VwIVq6QjDZatPeCi4OO7AU5JDlgjy+iW6HlnFZRb9Gm
	2h/JBzafQFQxKGlRxjgQ0MDOe+yfMr0nFTswOoXOOH4+0li5SglBMH+akj6J/gCF/vIIVqrP5By8N
	PjUFO+0TgBqPablWfDgT/O4aMRtpMyaLlioUYxeNENGimSt3PNfmen2yIvldAfsJ5LDfR1M+V1E+i
	5hcVI+0rV8rTf5fSSECG+ght/4iMxB/n8v1HvrWnPR5bRFrB/H8QFT7Fq3i5utzSnJnke2ibv6VoO
	o86ktACA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwJAx-00G20i-2J;
	Fri, 27 Oct 2023 09:30:43 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwJAt-00G1zz-2p
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 09:30:41 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99357737980so291198166b.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 Oct 2023 02:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698399036; x=1699003836; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+R3d9PrexLe3gHqXe8BjIbJjsmG22nyj6pAcb2QmK0=;
        b=zDtr0MXurQVUYWmJTyFPxm/Cjz/XTuVWaI7WOwzdjtVT2RV362Jf/TVsnw4HaC6S/3
         36pHlkGg9f6fKLGivaeuh5IDOOXccIG1QtrZuDrlI4gw+yaQIxjYFPVpEvCcRg/ESFYg
         gbB9JXAy2v02NMzNbUJMpqS6CoM/weEH1d9sL6WgqA2WagwTyEJcXvu/CAZPsCMMczSY
         JIH0TTzSYqAAtz9ZHrXoRQQEG6D7xYsJzx+4hq1wipiP421KF4MjW1tvbCDMuJrg51Fw
         xTpvCo66I/I/aqoz1Ah5+KumaCrcpdERpcC29uatxURI+BcZ6BC4RUNDgju2hSUqSJfA
         ZGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698399036; x=1699003836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+R3d9PrexLe3gHqXe8BjIbJjsmG22nyj6pAcb2QmK0=;
        b=evU/bDr5lEmiA3Tal9HRw3ntBxFrKJLMOfYh4HAppaGGpitS/PKuo0yWCMzmePTuCC
         OAqkx6CW44DxITxyCeys+kQ1+FVIsXd23nd1UczFJ/tQi2oEvsy7/XwK9kHkQY7wpbAt
         5yEngXejYKxmzieT6d6jbjbbPWexGrCaIP9xgbOfrAiiipjwR2oPkCrYv6zxWq2neh5J
         ggwhjXKB5+fJqLQBWxv975+kGDD9N8+vpTrU+KKYk2bU5wsuRRjyWm9k2Ycb+jKO2Z60
         IT4GtsGrx2clMd0uJHGEckw40oht8jWzcvXVcxrfVfGfnCa6hwrJlGUTcnlRRZvS8vlz
         I9RA==
X-Gm-Message-State: AOJu0YwQ4LSCjc+z14eob8WQjqPMliW6m7yuGzy0BqkwSE7TLBVnLjnS
	sy4U7rQroPsRvyNPM5lxUyXw0g==
X-Google-Smtp-Source: AGHT+IEXfxosY9UYBFT7kn60Eflg4n2RBNYMz4ANNEgx8PXX5eWKIPHrJn4fvTbfhq/x/o1xRx7BJw==
X-Received: by 2002:a17:906:fe04:b0:9c3:cd12:1925 with SMTP id wy4-20020a170906fe0400b009c3cd121925mr1743870ejb.58.1698399035904;
        Fri, 27 Oct 2023 02:30:35 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ov6-20020a170906fc0600b00992e14af9c3sm912509ejb.143.2023.10.27.02.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 02:30:35 -0700 (PDT)
Date: Fri, 27 Oct 2023 11:30:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
	smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
	yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
	imagedong@tencent.com, ast@kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH v17 01/20] net: Introduce direct data placement tcp
 offload
Message-ID: <ZTuDOhYzp4FeCZaA@nanopsycho>
References: <20231024125445.2632-1-aaptel@nvidia.com>
 <20231024125445.2632-2-aaptel@nvidia.com>
 <ZTfSOv0F7licIO6Y@nanopsycho>
 <253jzr8juvl.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253jzr8juvl.fsf@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_023039_910100_F600800F 
X-CRM114-Status: GOOD (  11.31  )
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

Fri, Oct 27, 2023 at 11:07:58AM CEST, aaptel@nvidia.com wrote:
>Jiri Pirko <jiri@resnulli.us> writes:
>>>@@ -2134,6 +2146,9 @@ struct net_device {
>>>       netdev_features_t       mpls_features;
>>>       netdev_features_t       gso_partial_features;
>>>
>>>+#ifdef CONFIG_ULP_DDP
>>>+      struct ulp_ddp_netdev_caps ulp_ddp_caps;
>>
>> Why can't you have this inside the driver? You have set_caps/get_stats
>> ops. Try to avoid netdev struct pollution.
>
>Ok, we will move ulp_ddp_caps to the driver and add a get_caps() operation.
>
>>>+struct netlink_ulp_ddp_stats {
>> There is nothing "netlink" about this. Just stats. Exposed over netlink,
>> yes, but that does not need the prefix.
>
>Ok, we will remove the netlink prefix.
>
>>>+enum {
>>>+      ULP_DDP_C_NVME_TCP_BIT,
>>>+      ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
>>>+
>>>+      /*
>>>+       * add capabilities above and keep in sync with
>>>+       * Documentation/netlink/specs/ulp_ddp.yaml
>>
>> Wait what? Why do you need this at all? Just use the uapi enum.
>
>The generated enum does not define a "count" (ULP_DDP_C_COUNT) which we
>need to know how big the bitfield should be. Maybe the code generator
>can be patched to add a #define with the number of values in the enum?

Yeah. One way or another, don't duplicate the uapi enums.

