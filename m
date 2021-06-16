Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C30CC48BE5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 16:29:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB75F61241
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 16:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB75F61241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=usa5zVff/Us2jrfC8uCVVGkGewDwXtDcpoxeKKDRjPA=; b=1m9iJzdJh+J8SKdIYpfARtFNfT
	c+6hkdpifZX8HA4NvFUc9z+REDpa/UlXm5GW5zWQRTn7/V62MeEgkkI3b4B/+S2HZT5NX+nfeyzQ4
	Iglk5eE5G8khRfI0oLuDP0VRl9uOwoaXWKTwxsgiLdhQ5vuqZak+X7RUcMyFYBTjsR/vEwAhOZDxN
	bepLdINqIMcBCWC4F6ix5TtXxzSe1K+YynytMpvSCrr0oE1nbWKvZ2Ga9WV5wS9aGBjTCFU6m3ICc
	ev2EMhiGB00v9BwJGoAbEQeQjoKgBozLbUxhPgqAdQz0RraPVXcBWzFU7WopNnnHQooxCZmQjLd/l
	ODh4wqjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltYPT-0077lV-DW; Wed, 16 Jun 2021 16:28:59 +0000
Received: from mail-pf1-f173.google.com ([209.85.210.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltYPR-0077ki-7E
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 16:28:58 +0000
Received: by mail-pf1-f173.google.com with SMTP id a127so2605140pfa.10
 for <linux-nvme@lists.infradead.org>; Wed, 16 Jun 2021 09:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H6YOLBp6XGoVIhn73MdiJ+ITAguKiFEzMg7pfQmVzaE=;
 b=o+UiqPMLeT++KArgcQMAm19xuaBp6fez0jCFIQKcqYEc1H1Qn829IpFOP0jgiFVh5w
 Zgi5CzeTzdCtb3UPBbzF95Jf4VAg5dxuSskd7PBweao9IBC3SUMG5uXKGDdJ6eUVL2jQ
 iCUwKYdVfBZbc6F7UAXo4KeKTCa23poha52GAb1tirP7poV8EDnm/M3a0vcYAPp/aNzJ
 10WsG0AYRq8NY63d/INzVa+JSI3bRbT/PgAthBwi5v1XdSftXO+H0Brbj5KHB6XpCoIs
 /5C01QzmFhR+1cDZRssuejLihuuL9VmfgUZxvarmtAdwbSWs5T1XPaNWL+zZMSI9GUCS
 QpXA==
X-Gm-Message-State: AOAM5326LYstGKSJg76iG1yLaQdRr8+beWa5ClmhiGJ7raZu6UW4ek+a
 9tmbk6IlKUNCtQiAyof5Kdk=
X-Google-Smtp-Source: ABdhPJwKpH9b2fiYFNjP0QKY5R4457RfEb628blGdhVuATYeo/xrWuXS+Grzvm0RCYC6fxyYvckMCQ==
X-Received: by 2002:aa7:8681:0:b029:2ee:10c9:17c0 with SMTP id
 d1-20020aa786810000b02902ee10c917c0mr533946pfo.56.1623860935969; 
 Wed, 16 Jun 2021 09:28:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1036:8496:ef40:673a?
 ([2601:647:4802:9070:1036:8496:ef40:673a])
 by smtp.gmail.com with ESMTPSA id w27sm2745763pfq.117.2021.06.16.09.28.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 09:28:55 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] nvme: protect against possible request reference
 after completion
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>
References: <20210519174340.1144806-1-sagi@grimberg.me>
Message-ID: <777a99bc-b7e3-ce39-cd98-ab1196aebb2e@grimberg.me>
Date: Wed, 16 Jun 2021 09:28:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519174340.1144806-1-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_092857_313749_70215598 
X-CRM114-Status: GOOD (  17.87  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Nothing in nvme protects against referencing a request after it was completed.
> For example, in case a buggy controller sends a completion twice for the same
> request, the host can access and modify a request that was already completed.
> 
> At best, this will cause a panic, but on the worst case, this can cause a silent
> data corruption if the request was already reused and executed by the time
> we reference it.
> 
> The nvme command_id is an opaque that we simply placed the request tag thus far.
> To protect against a access after completion, we introduce a generation counter
> to the upper 4-bits of the command_id that will increment every invocation and
> be validated upon the reception of a completion. This will limit the maximum
> queue depth to be effectively 4095, but we hardly ever use such long queues
> (in fabrics the maximum is already 1024).

Keith,

Did you get a chance to look at the performance impact of this patch 
set? I think we are all in agreement that this is a useful safeguard if
there is no major performance impact.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
