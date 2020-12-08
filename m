Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D510CC4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 00:40:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FACC238EB
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 00:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FACC238EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PK7GZjH43ROc38ourzA+Xr9O2i8EEuC1v5rXYTg8HCE=; b=FJI3g3upMLgjTcV2cyOEnnnJY
	6AEnIWXMw1SFoZ+ea3QcW+giFtV6JZSU+RZaUvFnE+SSevHuVPunYK94oBKZU4ip5BpWr/JWNCHiL
	EYLHJac8hfyY6ns8zUhWh7T/ih/f4WudJiM6ojRh1Y4xkaa5supJzpgph7ra1fkyhd+597R+hX5wU
	KKQ15xlWS2bqpJoEC3U9ESRBPLhJqnvhC8RWf7ADBK0YkXrwIicclhswf/hRO1gdkW3xfSV26exRm
	eWXGJ+t65xYL59Xd3IyHEtQz+zdl4LxtRzbvB5Fg+j/InVJbJwkHBhavuHUqJhhIds7N0i4vwJjlL
	BgWrbgpmQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmR2p-0007h6-C9; Tue, 08 Dec 2020 00:39:55 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmR2m-0007gS-Q1
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 00:39:53 +0000
Received: by mail-ot1-x344.google.com with SMTP id x13so6859003oto.8
 for <linux-nvme@lists.infradead.org>; Mon, 07 Dec 2020 16:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=U4k5wKBczYHBTO62E0uZ8Zf8NuwGQyb1owA7NqdovSM=;
 b=GkeXKtPADgX0hh+zlMBORIWKeNxE98QJlU+epcTcdDSvMp8N5U0U4Cr9+8vs6kWv6C
 hx6YdtDArg2EEAbiAXqQWqNOX6HpAPfKNp/6X9TXpzK9c6Gweb5FRH58lCmJm5GvMrty
 9TcgLtEVDDS0r/czCCSX6nBlVEKRRB4XMlXeBDbKrjQh/Ttryf9uDk76EvxB1l6oHLur
 1bP9/SEQ2/H5cKCTwbBsgrJjrO+QrqgydjeqN4V7dna3/zKX+FHDJ/jCMbxSZ8smPLp+
 UXHRy1nwc6SotPmQp6YzZpnyfa99UTfXrVR1idsRXYIfcxlbWBVLQo296UiFbb55vNJM
 zQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U4k5wKBczYHBTO62E0uZ8Zf8NuwGQyb1owA7NqdovSM=;
 b=pyEqLPJxA5jD84AWnxxsdWvYCyXRPhHfEC3uGavo7XOXSQT7EgM9OfddRfzeSrP0l0
 bLJoiaq9fHmgHpKlUB0/yXU8y1XDrtx9igLU97ccrs9Nyc6+jzRSvWy51WJypyKoL6IA
 QxDCFpgA7BGSir+OkjNWJ3HDu5DC2kOYR4wiE2uBx/1lVtbBEd5L2c9ziWd+nL3RfuKf
 88x+nZzhKQaJHhZElTPTTMkyGOXnEosPfk+f0KiYwC0kOevTYyN2mDW+GvdLEs7Or4BZ
 tvew611DEZAyeW34AZI+FRSzV37LaYqqOYnCC9CR4iAwxFUtzr0UPHIqcHiflfkldhVX
 5taA==
X-Gm-Message-State: AOAM531c1MQRA8xBYst23cdy7TgyVMr93I3neur5J+jd/rK4ZOjClYX/
 M1ks4X1jMhxV9kPEmRRyLtY=
X-Google-Smtp-Source: ABdhPJydlze5vCp7cmil/C34PNuT1u22opM6OmcgbCllRmtWcs3UCtZCUA570dmUxT0GQ5l8XVst/g==
X-Received: by 2002:a9d:2de9:: with SMTP id g96mr2368302otb.209.1607387985833; 
 Mon, 07 Dec 2020 16:39:45 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.48.134.51])
 by smtp.googlemail.com with ESMTPSA id i25sm292033oto.56.2020.12.07.16.39.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Dec 2020 16:39:45 -0800 (PST)
Subject: Re: [PATCH v1 net-next 01/15] iov_iter: Skip copy in memcpy_to_page
 if src==dst
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-2-borisp@mellanox.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <f399b37d-872b-c832-be43-c7930b487a16@gmail.com>
Date: Mon, 7 Dec 2020 17:39:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201207210649.19194-2-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_193952_909494_16EA70DA 
X-CRM114-Status: GOOD (  15.77  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 benishay@nvidia.com, linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/7/20 2:06 PM, Boris Pismenny wrote:
> When using direct data placement the NIC writes some of the payload
> directly to the destination buffer, and constructs the SKB such that it
> points to this data. As a result, the skb_copy datagram_iter call will
> attempt to copy data when it is not necessary.
> 
> This patch adds a check to avoid this copy, and a static_key to enabled
> it when TCP direct data placement is possible.
> 

Why not mark the skb as ZEROCOPY -- an Rx version of the existing
SKBTX_DEV_ZEROCOPY and skb_shared_info->tx_flags? Use that as a generic
way of indicating to the stack what is happening.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
