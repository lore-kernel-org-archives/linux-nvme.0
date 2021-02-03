Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320AEC433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 08:56:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD30B64DD9
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 08:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD30B64DD9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tcLBArAAFINhw5Ov4QfGKHtXVB1zl2selVSsvp+Aryo=; b=nEW0xr8qVlyTskgXW4hPLp6cq
	T75Dl/mRa2QHPc1Gv2oOVuYu9T5jGVG4KBmW6OJqMBX7sHCs5BOlt3yulWd5OoC596IwXpe8ZW0Mi
	hFxUDN40ibiCPjUCzlBDiI4rGral8A9F9OwMIb0OL5KyIjIrdeCn4VQ6NtnZGChYKsiJeQc36/nLL
	kMyoxCNf1n31rABTAhRpnC0VOZch17ADzGU9Da6EHIo+jMTmQXo2dmWh4kvRRVhJWOfkp3hjJEc1/
	SnakGeb0IUp/LC2G6lZPsap6wBwkOWG54n9OQ8QecSlynNKAUx5rpKmxZL4p1WpNbGQWOHUpkOwik
	xe5t+hidA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7Dxw-0000ZB-Ly; Wed, 03 Feb 2021 08:56:48 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7Dxt-0000YV-JV
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 08:56:46 +0000
Received: by mail-wm1-f44.google.com with SMTP id 190so4691800wmz.0
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 00:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qRDMPPpE6Q0BZsDXBuCzb37H2VewHWoPubkDh6Tm0Ak=;
 b=OavipUhytN7lEyrJYoE6PNTZT611TNcVhd+f+8vWGjMDfN5oLETgANVkbT3dcGZqjb
 2Wxo/SIKn27qSAnckAcMS0qjOrG89j2lD9MMVoH7liY2YXmml2pwrKJNbpEwffrkXpzX
 3csjs8EpW17iIyDYi2cjveeadN4ADItDwk5ZoBVYnDsNAz3g7e3iW8E0bBARUBVFoC/j
 iOL/Z4velspMVe6f2zEh5aKh06SW7jArtHOJ5lmzK5xEPAoN+13Lv8300g55wXsQiLQs
 tPvv6o4SRBCFsi7VNLEG43S/muyOgm6kxrgdYjXFlXRPRC2Ar7Put6bn2G7jhUk8gyiR
 MXjg==
X-Gm-Message-State: AOAM533nRASqccy6Lp7HIxUXvucYFr198eu+zuxAxbbOwwRqepFOAvoe
 h3GW5TyHSwND/z5wR5dhdR8=
X-Google-Smtp-Source: ABdhPJx2ARjyWIx1QP1gDjMCDFN2nXVrSB4da8n9sQfc67KWntpJplt7teI4c26GLv8D4A4I0LaaUA==
X-Received: by 2002:a1c:4303:: with SMTP id q3mr1792240wma.3.1612342603121;
 Wed, 03 Feb 2021 00:56:43 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:819b:e1e8:19a6:9008?
 ([2601:647:4802:9070:819b:e1e8:19a6:9008])
 by smtp.gmail.com with ESMTPSA id b4sm2421732wrn.12.2021.02.03.00.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 00:56:42 -0800 (PST)
Subject: Re: [PATCH v3 net-next 07/21] nvme-tcp: Add DDP data-path
To: Or Gerlitz <gerlitz.or@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, axboe@fb.com
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-8-borisp@mellanox.com> <20210201173744.GC12960@lst.de>
 <CAJ3xEMhninJE5zw7=QFL4gBVkH=1tAmQHyq7tKMqcSJ_KkDsWQ@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <80074375-2d37-d9b9-afbe-1f3d1db4a41f@grimberg.me>
Date: Wed, 3 Feb 2021 00:56:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAJ3xEMhninJE5zw7=QFL4gBVkH=1tAmQHyq7tKMqcSJ_KkDsWQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_035645_671130_750CBAA5 
X-CRM114-Status: GOOD (  14.18  )
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
Cc: smalin@marvell.com, David Ahern <dsahern@gmail.com>,
 Boris Pismenny <borisp@mellanox.com>, Ben Ben-Ishay <benishay@mellanox.com>,
 boris.pismenny@gmail.com, yorayz@nvidia.com, Yoray Zack <yorayz@mellanox.com>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux Netdev List <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Or Gerlitz <ogerlitz@mellanox.com>, benishay@nvidia.com,
 Saeed Mahameed <saeedm@nvidia.com>, David Miller <davem@davemloft.net>,
 Or Gerlitz <ogerlitz@nvidia.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Given how much ddp code there is can you split it into a separate file?
> 
> mmm, do we need to check the preferences or get to a consensus among
> the maintainers for that one?

Not sure if moving it would be better here. Given that the ddp code is
working directly on nvme-tcp structs we'll need a new shared header
file..

Its possible to do, but I'm not sure the end result will be better..


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
