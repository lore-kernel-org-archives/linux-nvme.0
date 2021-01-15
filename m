Return-Path: <SRS0=b72z=GS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751CEC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 02:48:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926A923AF8
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 02:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926A923AF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EdvKFDQ+MsjxLgcGJMQCz/4BFOrhy91obEIJ7Go6lLk=; b=2RC54L8kSND6qOyXc5JEi4IGF
	+suZeQE+ucya7ygAj1fIwa6UAuLDVUEN8LIlpmJZZ2kFe9WLpluqExDpVtS1JcqlrpjLuNHlDhUYe
	Eu+1Rt86jDoN573ITfClEP7mk1d8FUjpxdJH/VRYWd4oNADvGqemPERsxcVAUDa5hCBb8z8iv7qrV
	VAzHW6/EQ0JiKBfyZx59F9d6pD80iZEptnYMWVNd/CBe8I6nOVoO57RkG9VnR5TMpy9+2flIOKbkh
	vsyXkBzywitREFr3l5z7gG7+MuvuG45k9fy9j5TkdZpL/wAJ+PNRp3jKKD5pu3k9hqKq5d2J+UYfi
	ZZyPa1iFw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0F9u-0001Qj-8U; Fri, 15 Jan 2021 02:48:18 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0F9p-0001Pr-Ac
 for linux-nvme@lists.infradead.org; Fri, 15 Jan 2021 02:48:14 +0000
Received: by mail-pf1-x42f.google.com with SMTP id h186so4588746pfe.0
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 18:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VBUZdcggrTG32P70SFIDXvoYqHmBkktzAy9HqU8P20g=;
 b=zhWnq/wpGQOBbp7JBCtwNzJ5XhZDwUJ1MenpPxAtUzWvCWF3V+HjQ3GxzvNexjW5ca
 mN2s/LaqNo+jPY58w3jmS/MGibwqLFWxS9HR7nks3nMrzGdSSFGmSWxSXjhM3f/obA8b
 5AJV+B/0bljBqfYryGpi6T8m1FjRM3Q2THp/LigqFjSM4+tFBYJf18ccpvM7skvBf8lN
 DkygQtzV72g2Teb2hdsAxajPRqHK6TY3zNUp4hDHRFX70fqrz/inBRIx0Kv6EJ55qYXS
 JvzPLSugDEfJmEah69osuAxt2+w1JPBl2pi5X3aUTa51iBP2QXdmlD/xhQaVLza0YtGi
 B4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VBUZdcggrTG32P70SFIDXvoYqHmBkktzAy9HqU8P20g=;
 b=Sh4K92RW25HZGxGgv3V89TpEImTanIPINFdNOOtVnu1A+9/M6u+9l2qAjfroH5Fexo
 BWvwyj4N7kOyM2GD503g+vHvo1gwZVa3FVU10B9M3vcQkajaflWq+IEYBXZEJON5dYW6
 f09nRGVwWLIF6IQ+/z3wlBjX5rfN6kc20OVQkc1EKcF0koSoJN07voP0v2clLb4YOcgR
 CBQApXpOHZhicb7XMAhoevNXAZu0ziE1iRh6+4oNSE4XNGMHQgPgqnyBA6H6MVfRT53T
 4a8oZPu8guv1LQfKevar/q5qTvUaIzGifOc8gZh9L9fi3C6R21KuyNremQ5DaZN6XVoz
 3DGA==
X-Gm-Message-State: AOAM530O28vcru4CK/rlMbhMzS14dh2H2KZA6+jH8+211r3maZpKZlry
 9HBoxsXHb9fdswbSX5qSAltTLjmCHQE8bA==
X-Google-Smtp-Source: ABdhPJykHopNnFQdYPjpD7UAHWaAKrFP1nGCIiWR4dYmrTxCAJAL8habRAohWA9rp1F1wQHbJlEJRg==
X-Received: by 2002:a65:430b:: with SMTP id j11mr10208273pgq.130.1610678889371; 
 Thu, 14 Jan 2021 18:48:09 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id z13sm6747135pjz.42.2021.01.14.18.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jan 2021 18:48:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 5.11
To: Christoph Hellwig <hch@infradead.org>
References: <YACbrIes4r8Qa1mA@infradead.org>
Message-ID: <ac34b82a-1391-7ba9-834c-daabaf65d125@kernel.dk>
Date: Thu, 14 Jan 2021 19:48:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YACbrIes4r8Qa1mA@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_214813_494362_42ABD5F1 
X-CRM114-Status: GOOD (  13.15  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block <linux-block@vger.kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Linux NVMe <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 14, 2021 at 12:30 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> The following changes since commit 5342fd4255021ef0c4ce7be52eea1c4ebda11c63:
>
>   bcache: set bcache device into read-only mode for BCH_FEATURE_INCOMPAT_OBSO_LARGE_BUCKET (2021-01-09 09:21:03 -0700)
>
> are available in the Git repository at:
>
>   git://git.infradead.org/nvme.git tags/nvme-5.11-2021-01-14

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
