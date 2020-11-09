Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFD2C2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 10:29:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34CF3207BC
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 10:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mLBbTYT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CF3207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1QlJmPf3uYajwZVzqHEEgBkgaEjvvljXLdaNeu7zStk=; b=mLBbTYT/wn6swsmA2fDA2171R
	0ufHo+htcm4UqpwkXztCf173Ua5Rpv2FxJYfquveZfyMe8TPnj0HcAWzEbJFXPzdzGh3BXRBTCuOd
	QUVAtwZ+zmmUxX73Y7KuQsvD3gkLwwaBFS1enlR+hOMwoLpDIj13ZNZTAhCultE83pANZiS0AsmGY
	ERy9+KpVNU7k35uYed9PNW9mTHYqKBg+tPs5GrbxNVj3kNy6wUP5UC62sjELmrXrJK21X5KO8HEdP
	yHHk312pCKmRY07KVOFGkuACTFzWEXrWfHfUf6iSQ8/a+o+WrXPIwkx2vtzAoxIcwTvtIJl4+4FiS
	9XgNcZLqQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kc4Qp-0007H2-6V; Mon, 09 Nov 2020 10:29:51 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kc4Ql-0007Gf-Gg
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 10:29:49 +0000
Received: by mail-pl1-f194.google.com with SMTP id t22so4508539plr.9
 for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2020 02:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G0/T837reAr7wHIPGdXVacb8I/U05abYUoDDuUcFAfM=;
 b=PAux0vTSRkZQDQiohYPSLrpwBQ82q8xHGln0y+wklxKPZX7EgN2mk3g+Dk36MGt0Zc
 DB5OB6wcty2sdwYxy+F1X5be7flwyRhu4qYZONxRllYvec3jmaCRTETxBZMgMXVKO2ow
 l7x0leBZbAX676ppkTn/71DWGrVNH5FHZtBNqDlx5UzyUmg4Cq+pDDCcnw9Fe9P2e4Xs
 0U+SZ+A39+Jd6nvz2drs828GWAWdXsPi8niLUXfdBAb05hGODiRj9e4DOVfkp8mYkMqI
 nuGbfveHja18rXs3kHbqv06Z5z3ymvMDIfmm88hSdeTskLHCUurqdoQh9u8npunU4U59
 NEpg==
X-Gm-Message-State: AOAM530jAZaqYv5fckrcWtlrqnBKysPGmC+Dsro/wcdGDF8QD0oCAxFz
 L4gnwC+YxZOI3A70X+uTgHU=
X-Google-Smtp-Source: ABdhPJwvx8mUepzb8ljYCz96+YCsCTuwdWah5eZYteGeYHdy81B5uNDDDbo0Pz0MVpCxeEGjB5ZKlQ==
X-Received: by 2002:a17:902:bd4c:b029:d6:ec35:755b with SMTP id
 b12-20020a170902bd4cb02900d6ec35755bmr11859034plx.47.1604917779394; 
 Mon, 09 Nov 2020 02:29:39 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:d1f9:34d6:950b:391f?
 ([2601:647:4802:9070:d1f9:34d6:950b:391f])
 by smtp.gmail.com with ESMTPSA id q18sm10639639pfs.150.2020.11.09.02.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 02:29:38 -0800 (PST)
Subject: Re: [PATCH] nvme: revert commit 1293477f4f32 as it is breaking
 BLKROSET
To: Christoph Hellwig <hch@lst.de>
References: <20201106171835.38236-1-sagi@grimberg.me>
 <20201106175949.GA7529@lst.de>
 <443079c6-2dd0-f52d-4b2f-f7f9dec2792d@grimberg.me>
 <20201109085221.GA27483@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ae3624f1-c566-c473-e5bb-cef4f8d7e10f@grimberg.me>
Date: Mon, 9 Nov 2020 02:29:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201109085221.GA27483@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_052947_624775_52C1A8DD 
X-CRM114-Status: GOOD (  17.62  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Just dropping the else part is probably enough for now, although
>>> as a follow on we should probably add a "hard read-only" state to
>>> the block layer.
>>
>> Removing the else would have an incorrect behavior. I think its better
>> to not support it (until we support it correctly) than to support it
>> incorrectly.
> 
> I strongly disagree.  When we see a write protected namespaces doing a
> set_disk_ro is the right thing to do to prevent folks from writing to
> it and getting bogged up in tons of warnings.   I think that use case
> is much more important than the corner case of clearing it later.

OK, I can send a v2 removing the clear.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
