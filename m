Return-Path: <SRS0=aJh0=5X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672E6C2D0EC
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2020 20:37:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229A62074B
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2020 20:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QAmG65mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229A62074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qT2fhANa9D8n4aW1eDuiH0pU3xML4R/+Q04tH48BHvw=; b=QAmG65mx2dGyt9uNnmwPRgRmo
	rhyiQiSeTQyU4V9rYtVWNCWsxnTr22JtcCVZfI0nv6gtJ9h38n2c8J/zRQNZTw0higlYc12JbUjjY
	kvESorbpuVaCCs/9oEzW9fr88ENIUUsVDCdfUKC8hFP04OTGYWaABhvGhFW4xEl1YdW8NUt53QuVC
	tpLWBV8ppaHvYzKpaWPJCidABISSbBho3pMe1sK6oQIjozezF+T1kWxB9/BAzhNqrV8j/MZCiLg6j
	+URMk8IhpMGjiBTmjSolZX5GGlovI+NPKqCVHhYp7tdayJT9+nwpbzmgsqI5DLlacLGkOw7Bzo5tx
	e5xEKTr8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jLuyZ-0003x4-LD; Tue, 07 Apr 2020 20:37:39 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLuyW-0003w7-Tv
 for linux-nvme@lists.infradead.org; Tue, 07 Apr 2020 20:37:38 +0000
Received: by mail-wr1-f44.google.com with SMTP id c15so5353495wro.11
 for <linux-nvme@lists.infradead.org>; Tue, 07 Apr 2020 13:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ONeyxRlprvxUT74lOePPfOeEtQcvdPUyPGRH0vuvtLY=;
 b=Zje3iMh9f+fNo9rkFz7ho4Gnip0tWVtXaPxqlpEaO3dC6Qs5ZYMz0Z2DblvrFgmShC
 RHu5hpVHYZl9asdG31LZyNbuk7oJR+VNJGPtY1u4eGRyXcVvawJaimOp6/Q3yd208zap
 PnFJlsjvhcxsZaVJPTRiBiBY8PUFpFFcItgxRpAe0BKyGAyQpaFKgF/wR94GVIPBCW1K
 rI0dULIeFNm09DT3tYVklqglNZB+mF2lXDRFHecjYL4ssO9E/a+/F0u5xV9sNj30EHU0
 QmZemfzYuxm+9VLEBvmb1Oys4Z1w6BThG+toHWrh+l4/to7c1xPA3LvFQBt88PYFf9XE
 rv2A==
X-Gm-Message-State: AGi0Pubm6nybKYyzOqJz9xfGQYXV0ZLQEIJJvpcmZmO3NHwXWY5uXeCV
 /9DMprynUXXFPaECy9smu6cZTs4g
X-Google-Smtp-Source: APiQypJPYEErceQ+aFZ6nm3IcqUaYd6j3lmtjv7SFJAxoWzQaMdfeVMFc0kPxPlxKAvOmMHNqPeNzw==
X-Received: by 2002:a5d:4305:: with SMTP id h5mr4387705wrq.69.1586291855169;
 Tue, 07 Apr 2020 13:37:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8f:36a3:3e4a:9e?
 ([2601:647:4802:9070:8f:36a3:3e4a:9e])
 by smtp.gmail.com with ESMTPSA id y7sm1723037wmb.43.2020.04.07.13.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 13:37:34 -0700 (PDT)
Subject: Re: [PATCHv2] nvme: define constants for identification values
To: Keith Busch <kbusch@kernel.org>
References: <20200403175346.1571822-1-kbusch@kernel.org>
 <20200404070437.GA14423@lst.de> <20200404170742.GA53042@C02WT3WMHTD6>
 <20200407172559.GA6876@lst.de>
 <bb8608c9-c523-c9d4-83fa-9c3fac627604@grimberg.me>
 <20200407181623.GA3843@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1df1433c-fb24-5719-f426-89b321e50b78@grimberg.me>
Date: Tue, 7 Apr 2020 13:37:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200407181623.GA3843@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200407_133736_958965_73BAA9A2 
X-CRM114-Status: GOOD (  16.01  )
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>>>> Improve code readability by defining the specification's constants that
>>>>>> the driver is using when decoding identification payloads.
>>>>>>
>>>>>> Signed-off-by: Keith Busch <kbusch@kernel.org>
>>>>>
>>>>> I can't say I find this an improvement - the bit values allow you
>>>>> to jump straight to the spec, while the names need a translation
>>>>> (either to the actual bit or the spec name without underscores and co
>>>>> first).
>>>>
>>>> Named constants tell us what they are inline with the code that's
>>>> using it. You can make sense of the code just by reading the code,
>>>> no additional docs or code comments required.
>>>
>>> Sometimes they do, but especially for nvme they often don't.  Anyway,
>>> I'd like to hear from Sagi and/or Jens to see if we have more people
>>> who like this or don't instead of just us two having different
>>> preferences.
>>
>> Personally, I'm in Christoph's camp, especially when the names include
>> words like CMIC or NMIC etc... These are cryptic unless you are familiar
>> with the spec and the NVMe language. I often find it easier to have
>> the bits.
>>
>> But, I'm also often asked about constants and their meaning, so I'd be
>> in favor of adding some descriptive names. But if the point here is to
>> save the code reader a trip to the spec, then we should probably add
>> some documentation explaining some of the somewhat cryptic acronyms we
>> have in NVMe.
> 
> It's not just saving a trip to the spec. There's a benefit to naming
> things when browsing the code: you can cscope named constants easier
> grepping patterns to find all occurances.
> 
> The driver isn't so big that locating something is too difficult right
> now, so I'm not really concerned either way.

I'm fine with this change if it makes it more convenient for people.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
