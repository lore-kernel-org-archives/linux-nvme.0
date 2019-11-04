Return-Path: <SRS0=VSZw=Y4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270BECA9EB5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 17:04:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD052080F
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 17:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DAdHueRU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wayWu9mO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD052080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kuf8y7OxyupTNEDkJQY76W29B9oxGX1gjWMir8C29Ac=; b=DAdHueRUD1tEq8
	w8fdl1F26f8+RXaLKOnluFsQC864SlaxeoO83Tts5RCxenq0cDU+GHzB0ff3+GLWQeGbOGYDKHH59
	bVrHfaXFygpjcQEY7FrYkFRJqdOdDZgmEs/iS/H8AHXmomln5aAPaZjA7cp0cVnbVCg3dGr6gH8cO
	E1BUatL3PwSZIIpDTmvoV65ukUoJbImUOjvmwW0+DAdFvzdFejAByzAIvmDoMCtMzoheS3lCpfV82
	0Ne432CHe5OmsvzREEceH21l+t+NG9fiejilG/zl3MqWySSxiF7/yrh3jOOvL1ZbNoaESWiCcSIpe
	Re/nIbrc/O6wY7/WacaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRfm0-0003vK-Hm; Mon, 04 Nov 2019 17:04:12 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRflx-0003rz-58
 for linux-nvme@lists.infradead.org; Mon, 04 Nov 2019 17:04:11 +0000
Received: by mail-io1-xd2a.google.com with SMTP id s17so19254552iol.12
 for <linux-nvme@lists.infradead.org>; Mon, 04 Nov 2019 09:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1YF1y9aIEgl9O0xTvxxUEcxXiQBuiCkE34muq77fPbE=;
 b=wayWu9mOq9ePouyA/mJsG35ASeYqd5L6+0QOdktUm4tMxaPtBlx/VMA7EvUefDmeMq
 tDWXNbxDbsMiFMSzat39ovwJlQ4sOUlN6NRLb/qPW9fZzOy85G7iss8x0xCYjdezVYe7
 /tO1qPASLAXjgLeuLZIwnRwW+Yax56X7mjJHtRkN6V2hM8n2YcrxpH+knTbKlS8bEUUp
 LomrfNdRdrL1lrR6TFxQhGKEMJ/0AgMmo1czZM8tXoasPwqUSJxLgFvmfDppn4Amg67Y
 tsCmcXPFBQftiv6b4EDA6JKr3s4I/zimUdc99feQL45nitC33XiOWoSm1P/jM8A7ginE
 kF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1YF1y9aIEgl9O0xTvxxUEcxXiQBuiCkE34muq77fPbE=;
 b=k+uHxNQ8Gy4jJAijFjC2BuGdfV4maVEneUy3340+jgKVNSFMCAPLZFImq/kNJXPtk4
 GqNg2E458RRb3dYlfVfRkNOpG2f3Y8ibynKLbmL3j2JJbOWXBvNZA6ng/Cbut3/M/Z4M
 2zWaQeJ0grnGu/GnXiaRE0aIILhDPFy2WWnz3oX5EDICgOuxUyfwghjO6li2/NWaBH2t
 1oJq39EzzHMLVpt+wBBKPekfn+TRscUAS30Avm+6KFqvrKoyBwy8kFPy1eFg35pQo/YG
 Mdr0STxHr67HB7wJlWkM/xi/T09WtLIGCtPweHKDnbtej+PNHBK1W4HB7bvS9cwQLl0L
 7Tyw==
X-Gm-Message-State: APjAAAU4Ciz8HMFZLQP0so/2zxQvfzvFktPgub6QKxl+pdkhnUWcu/YX
 SR7AheyxoFITP9oqcAE2hmDLR2Eg3XrmHA==
X-Google-Smtp-Source: APXvYqwllve90Rb76Kfc4QP15rteuvlQOQnG2XIAI3YMPZJGC1WqSFKKa99OIJSJ2uvVMK3psVTgUA==
X-Received: by 2002:a5d:9a10:: with SMTP id s16mr14517814iol.121.1572887046315; 
 Mon, 04 Nov 2019 09:04:06 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id s90sm2535212ill.40.2019.11.04.09.04.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Nov 2019 09:04:05 -0800 (PST)
Subject: Re: [GIT PULL] nvme-5.5
To: Keith Busch <kbusch@kernel.org>
References: <20191104170040.GE26808@redsun51.ssa.fujisawa.hgst.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <36883c4d-9896-fa98-78e5-5ee36f78dc07@kernel.dk>
Date: Mon, 4 Nov 2019 10:04:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104170040.GE26808@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191104_090409_228170_70109334 
X-CRM114-Status: GOOD (  12.52  )
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/4/19 10:00 AM, Keith Busch wrote:
> Hi Jens,
> 
> This is our first pull request for the upcoming 5.5 merge window.
> Nothing major on new features here: mainly syncing with spec
> updates, various code clean ups, and a few minor fixes.
> 
> This tree was based on linux-block/for-5.5/block. Please let me know if
> you prefer these to be based on the for-5.x/drivers in the future and
> I'll be sure to use that as a starting point.

Yeah, I'd prefer if it was against for-5.x/drivers going forward to keep
a cleaner separation between core and driver changes. I can just pull
these and apply them to for-5.5/drivers, not a big deal.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
