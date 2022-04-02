Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D9CC433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Apr 2022 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y1pNt6PbQq/iJYPmL7yMI8jf3fJuglb9qUR19wJJ148=; b=B2R2KylsKHKL9UN/btN7V02aI1
	2zHrSP1NlRNpiUFw3v98zXuSOitYwA3N0LLPZbONw0FbNwjHfghnyeyYscmcHSSGowuhGm9XtDF9+
	0hOJTLIZcRWeuVqQigNwp4B1B0SKj4C2TXbQjAtOd7btbPTek7wqexLcLLezoqmQe/PALgftEuwGm
	TUbm42rL9j6RhgTLQXHFoIsP0jYT7L3q5F22wl583jazFet0ciHUyKSKkhxh+O1xMsJNAykIDeSnW
	njkAr/Rto5XSI/km9LHP62CST0BKD1sxcM7svltuBRP2algTuNtA1EV0I+oEb4JneIBDcc/tK0Lwg
	LWV7SZLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nadDN-008lbj-R4; Sat, 02 Apr 2022 12:50:49 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nadDB-008lYF-0M; Sat, 02 Apr 2022 12:50:38 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 4BEE35C017E;
 Sat,  2 Apr 2022 08:50:36 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute2.internal (MEProxy); Sat, 02 Apr 2022 08:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; bh=Y1pNt6PbQq/iJYPmL7yMI8jf3fJugl
 b9qUR19wJJ148=; b=iaCZSK69ePVp7bMOqYIDGZoL4AHA9sUJDRKNQc0DoTth1W
 LZb5eMJFRB5piKS179iFm/sugO2oVhoV0EsNHL1CMTp9HSdMsYa48Wx0r5OEmud+
 MpgeX6MOPIr/p/fFVYG/w/+tLKkSUP1hFLOZ2pnZZyg6VG/tB0cc4gPl28ViWUsM
 1ZQOUYYpDhJvH2RpvQU/RJJOFu/roiLzFKUqM2mlXsnvV1jbliUF10r8wMgq9TwJ
 2lqrondZFCfoydQn7l5KVVfEKYNqNFxnek6bZ6gi8ctMmzJIcoQSiG4jqVMw38uQ
 3JjsG53IxqjrCTn9YvT4rs8xNN21YqSFeqoVAXVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Y1pNt6PbQq/iJYPmL
 7yMI8jf3fJuglb9qUR19wJJ148=; b=EfezHODWjQoLGvYfef8qipuFCCzxh+yjX
 e1IzNlJ4FuTuYDOBvuVitGdZDtRprYQOHvy58L/hsBc9G5WW3tu/Pg5vlY62dm0U
 XtfAlfuDUbJrlQFo5VGL49Dsd9daQ6uzY3fsajzxO3NDXzIUYgJcgqXH2Dt6upT2
 3TGLpSOwUKZE4lAq2nBJQ9YMV3sKouH2EZt+tEIgblviPwU213mCVD6fBaUQFynE
 h1ZJRLBLEHVy5Ir2ju5F08Z2Or/PNa60jZXEFJ1hIP6VgZiV2oIM2R6tuT4WkSgG
 +Q7mLxxnavZ/Sk6lCQo48upz+1prRoCw/CUacumePBqhM4UpKf6Vg==
X-ME-Sender: <xms:m0ZIYhquHVUjFKFZEfE6zc0u0p8u1skNYeTFTlE0qE_-7MAt9MtSmA>
 <xme:m0ZIYjqZ_DsMK9yjtGsQbnKy-gYr-WE--1T_eccyNLaM1zesmi7VZJSr8KfuKoX_l
 IsvD6LQFKAV9ljsBTY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgheekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:m0ZIYuOxDwE-Jv62Fe4VGQQAlDncEoEIqvn7DY9cr6N9ebENYt1YTQ>
 <xmx:m0ZIYs4bqKm9Uc3TuVFjo7--tXBiON95zqNszBIpPwlkwXJZb19VzQ>
 <xmx:m0ZIYg6vusdJA1ndGWff5HCLo6ioQ1xMiDSOXMcqxLhNt1h8rRFX8Q>
 <xmx:nEZIYtwgg06tkaCAIVY3WM-xobiIrGPzPdFqZlJ5voe8OUG8qd3wFQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id BC37F27402C7; Sat,  2 Apr 2022 08:50:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <c81cda8a-fb2e-4ecf-a49e-93b8fa0d1bd2@www.fastmail.com>
In-Reply-To: <YjoGH2JYd7cvx844@rosenzweig.io>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev> <YjoGH2JYd7cvx844@rosenzweig.io>
Date: Sat, 02 Apr 2022 14:50:15 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc: "Hector Martin" <marcan@marcan.st>, "Rob Herring" <robh+dt@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>, "Keith Busch" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "Marc Zyngier" <maz@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220402_055037_176674_0F259D78 
X-CRM114-Status: GOOD (  12.28  )
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



On Tue, Mar 22, 2022, at 18:23, Alyssa Rosenzweig wrote:
>> +enum { APPLE_RTKIT_PWR_STATE_OFF = 0x00,
>> +	APPLE_RTKIT_PWR_STATE_SLEEP = 0x01,
>> +	APPLE_RTKIT_PWR_STATE_GATED = 0x02,
>> +	APPLE_RTKIT_PWR_STATE_QUIESCED = 0x10,
>> +	APPLE_RTKIT_PWR_STATE_ON = 0x20,
>> +};
>
> It would be great to get comments added explaining what these states
> are. It's not obvious how off/sleep/gated/quiesced differ, and it's not
> obvious from the code (doesn't look like GATED is used here at all?).
> Are these Apple names or r/e'd names or a mix?

Good point. They come from XNU's serial output, I'll add comments
for those where I know exactly what they do. I'll also remove GATED
for now since that's not used yet.

>
>> +	if (!rtk->syslog_buffer.size) {
>> +		rtk_warn(
>> +			"received syslog message but syslog_buffer.size is zero");
>> +		goto done;
>> +	}
>> +	if (!rtk->syslog_buffer.buffer && !rtk->syslog_buffer.iomem) {
>> +		rtk_warn("received syslog message but no syslog_buffer.buffer or syslog_buffer.iomem");
>> +		goto done;
>> +	}
>
> Nit: Wrapping is inconsistent between these two warns.

Will fix it while getting rid of the rtk_ macros.

Sven

