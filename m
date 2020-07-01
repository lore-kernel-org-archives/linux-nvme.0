Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DAEC433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 13:43:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C67206BE
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 13:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RAZueXeE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dYwQW22j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C67206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p/BGvOhpzNIxB8VCA300aQL1b12/D+YeRsesTHd6qCI=; b=RAZueXeE95ZW+Al1IBKJjEte6
	1vwO/X9+6Jw9dbLfeD2Q+by8SvpX+Nvgwc8svRVUiUlNVBEENFX8whTFm4ZGt4/x02m/swuieBjcm
	TcqJwd+NBvKfYPKOCxubH6CrCPjHZOXzQIuWshWRnFwWJ1n6ucFutnOLkPSaXDUCZGKPx4h/ongg8
	hER0vm2HLs3BFkA5FBbELOSOTA0zQK0F9SxwXPCgoIl1dc7OSUGY/GFmZSVM++qtqH8CZyntpVAiu
	IxozSefgPhapg5FbTJAm41jiEZLzaaqDOMyQ6O5Csxp+qvUQfAqW4zC7uc+XmJyWMUQ28SkWrtmL/
	EEc8GVlaw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqd1U-0002w2-Vz; Wed, 01 Jul 2020 13:43:37 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqd1R-0002vS-TN
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 13:43:34 +0000
Received: by mail-pj1-x1035.google.com with SMTP id cm21so1676194pjb.3
 for <linux-nvme@lists.infradead.org>; Wed, 01 Jul 2020 06:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mp3kZB+WljYlToUgRKHu/jMatrXibHPg1FspuaVdS+E=;
 b=dYwQW22jG+1U/8wxe99npchEcHOVVxkAEfKn6EBHer8enDnZPRaJ5nzspLL5jxwR7E
 8c6AvaHExACDpMcSpNKAKYnhHPOqDFAuRaNYxN8Hxrsw/QZbGOrdK0NOggJHl9AxSJgs
 BdPFufpE696CTqP0ZSQJiMeB/Vf1M790yE0S6UfvzUcW/2LK3Cll1WaQxPF72JBBNiAi
 uNmww608IStODIzkXWWB+ivDstxmDBFHqxk0XqSa0PCNUdKh4Ts6OZk4XhvUDLi977z9
 tRq/B+DQOlpjSRZ9yIK6lLqMnhcWWTEtAYB9JXJiCaKrLlWYMNjb0yZxPI5ky8TpWAqd
 O5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mp3kZB+WljYlToUgRKHu/jMatrXibHPg1FspuaVdS+E=;
 b=lUROVUzr41riuNfta92Tp/K2XzG2RfCfbUkmbnT/GUar+28cJC14GZOswut1TAKcFS
 VknpMgKJfME6hpz0dExrUwHrszdnKt1ISXicTA9ILaofKHeweFkSJoE7Vo4KdV/kBXQJ
 wszCQZWyVfJLtP9sSZZa12t5sa8xp3VyCbdSXMFVF72RTPYX5Axh/svh5SWkcI5zGWk9
 LWboD3QPsidCc1U4FQ7GVtIKio2r2XSMbUTm5tzARuAsG8P2SBeqXAuORqK9gxjY2cE8
 jiCUhVGmJR8a8/5AnL803pmhS5HxF73p9wl+z62rVZsb8aakk0e1zUEu5+zpkWR3ffvq
 oFaw==
X-Gm-Message-State: AOAM533S8zwXpIzOkawL8WUnppQXI30xUM4ym9AHEn8VRiStIZs4fLAy
 lrcHvl335k17VBSCc3Wk92Or6w==
X-Google-Smtp-Source: ABdhPJwvetMLus+odkxVKs2TAwFJf3HuNkqQjK/vuqbHNuGPdXyOvoQGErv/SGur7kel3VcwfskpPQ==
X-Received: by 2002:a17:902:690b:: with SMTP id
 j11mr14712438plk.313.1593611011686; 
 Wed, 01 Jul 2020 06:43:31 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:64c1:67b1:df51:2fa8?
 ([2605:e000:100e:8c61:64c1:67b1:df51:2fa8])
 by smtp.gmail.com with ESMTPSA id g4sm5868990pfi.68.2020.07.01.06.43.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 06:43:31 -0700 (PDT)
Subject: Re: rename ->make_request_fn and move it to the
 block_device_operations v2
To: Christoph Hellwig <hch@lst.de>
References: <20200701085947.3354405-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bffb89d5-b51a-5f5a-15f4-b891f1f053ef@kernel.dk>
Date: Wed, 1 Jul 2020 07:43:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701085947.3354405-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_094333_967784_C203C867 
X-CRM114-Status: GOOD (  13.12  )
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
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/1/20 2:59 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series moves the make_request_fn method into block_device_operations
> with the much more descriptive ->submit_bio name.  It then also gives
> generic_make_request a more descriptive name, and further optimize the
> path to issue to blk-mq, removing the need for the direct_make_request
> bypass.

Thanks, I'll try this again.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
