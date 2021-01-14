Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2DBC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 19:18:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C455523B54
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 19:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C455523B54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aL2Br9ie9sVjw9JoIzRzA9AAS75H4suOaP5CnqSH+TQ=; b=1G7I3jdp227Q43yh0pOVhFYW0
	3fpYit7M0xr9QIvSBuW4OCS7JWtJ1jB2JAEQcJ6/XPoxnon6YLnsB0iTvmyJDF4L0J4ds9ru75u7Y
	X2zx654RJDWzr+eJuC2WEN9/huz2nlSX8GdxRYKj+f+qCRTGSeZz1l2FSUPrVPvNvsdGZRg4uSRFh
	LQKQq2d8jzK5GaGY0R7FrfVAcEa1fZjosjP5MaMkV3bvSl+dlDKnXOUmbnc4KC3LdR1bUt5GEFP02
	Ngq53Wz0pZGSkAF/7BtAee1SeoMA7qMK3M+Pzt9wCTex+GtlN4GPLjXGWDDR7E1OKTQJNXRKV+yi5
	mj+pnBYDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0881-0000pY-39; Thu, 14 Jan 2021 19:17:53 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l087y-0000ou-Rp
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 19:17:51 +0000
Received: by mail-ed1-x52e.google.com with SMTP id c7so6934627edv.6
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 11:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=23yPPjHaxPNE0KQ8oCeJXs/2B0KQYJpURsDNWLZSAcw=;
 b=JP8/L5FxaJp8SIEa8lbXAMOJLRP6uOXYR+1zg4CKs2mMcKjtmd1Ju05OR1YO9KDGsc
 EHueb5Bv3XGQBGIzCBX3Jvz+G26B/f8Xp28IUN96NYmW8ciVCQw/W1N3c9OhqXAi7Qd9
 kQuv4Nt4YIEYc9+A3wYSaLDnP6feew+hrHIrChzphXSb6kJzf3VAYbHD3PlP0/PQA1Gf
 0hmoy/ni49VmWwBoXGsziVOsoFg4XTN5WDnIkVnCOcnR2nxQCNLUKWUfN+gohzh9iL0p
 6D8u+eOTQDzCvYFlnmrpinFBAoMEklm1UmM+EirqS+8kYVT1+UtMQey1b/g/XhI8+VYO
 fszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=23yPPjHaxPNE0KQ8oCeJXs/2B0KQYJpURsDNWLZSAcw=;
 b=XMEcZpCliI704BLp/L/zRiOl5VoRDSJ57OvM8eNCLddGtvhjej14jMfe17FZdjTc4C
 +cK14+8nl2WdBTeBw2xYRN8U+zcKBOow5/pOSzRirrxu6bZAznzG9m1HK4B1sWNSz3Dx
 8VpmRoL+C/MqaUjQRUj5VNlDF/rDmHgckYmIfq2+k54KRucq2zS+mbya7kBjfWUjzD00
 KxeVR6w0OX/EOBsdIXt3t3/ajXo/Mr6avr1LFG+fpBH798QqFXeOOmPoKRs/xzNXsH7o
 mULK8Wc+0ZImQjwT2VOhpkHEsLdM00u5z/Xbu0sUkZx1Y/M6Ijjx3v8X0xgpgHVzg7M9
 hzhg==
X-Gm-Message-State: AOAM533UayUkV1frp5DT9NNMrv2E3ij/ph6reyQ3wKUWVJSKrTm5qpqd
 QAmUb1T2oiUXduszd5Id4Os=
X-Google-Smtp-Source: ABdhPJxnN3T7iKOqlx2qPLp1AqWPuSAkIY+4c8+TYBZzC0CHFiyIt2kw56oSY68Gpwpehf5pzKYbqQ==
X-Received: by 2002:aa7:c543:: with SMTP id s3mr6806760edr.88.1610651867820;
 Thu, 14 Jan 2021 11:17:47 -0800 (PST)
Received: from [192.168.1.11] ([213.57.108.142])
 by smtp.gmail.com with ESMTPSA id x16sm919744ejc.22.2021.01.14.11.17.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jan 2021 11:17:47 -0800 (PST)
Subject: Re: [PATCH v1 net-next 00/15] nvme-tcp receive offloads
To: Sagi Grimberg <sagi@grimberg.me>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <69f9a7c3-e2ab-454a-2713-2e9c9dea4e47@grimberg.me>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <6b9da1e6-c4d0-7853-15fb-edf655ead33f@gmail.com>
Date: Thu, 14 Jan 2021 21:17:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <69f9a7c3-e2ab-454a-2713-2e9c9dea4e47@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_141750_918675_3A8E03E1 
X-CRM114-Status: GOOD (  16.89  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: yorayz@nvidia.com, boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 benishay@nvidia.com, netdev@vger.kernel.org, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 14/01/2021 3:27, Sagi Grimberg wrote:
> Hey Boris, sorry for some delays on my end...
> 
> I saw some long discussions on this set with David, what is
> the status here?
> 

The main purpose of this series is to address these.

> I'll take some more look into the patches, but if you
> addressed the feedback from the last iteration I don't
> expect major issues with this patch set (at least from
> nvme-tcp side).
> 
>> Changes since RFC v1:
>> =========================================
>> * Split mlx5 driver patches to several commits
>> * Fix nvme-tcp handling of recovery flows. In particular, move queue offlaod
>>    init/teardown to the start/stop functions.
> 
> I'm assuming that you tested controller resets and network hiccups
> during traffic right?
> 

Network hiccups were tested through netem packet drops and reordering.
We tested error recovery by taking the controller down and bringing it
back up while the system is quiescent and during traffic.

If you have another test in mind, please let me know.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
