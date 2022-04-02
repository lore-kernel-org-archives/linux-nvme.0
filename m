Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B6EC433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Apr 2022 12:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fq6OlkR1JyeKwG1oXeMgLhHRDuFwunH+WFbnOc6UEYQ=; b=Ds1nvk5/hB2wvZJFIFPvb+0QEu
	0TTz9PJujUY/tKktNtqBx51KqfShEYpz86LKKuxZ9XebIBUbcUK1djiTSV1RprXJMH+4pLZ2vOm+S
	N4A9pJ8yp5GSq9FBr24COPPTOIWhMtMIAAMcIMEorYT0ZE4qEs8bDQWz5c0YHO9FcbOi8UFIRcwPI
	DvBYomOmwfzv7OrpDIlb3quPZY86xN1DBIssED4njwnRG0XJLUOxWyxAjg+qZT0onjx3pLqfNB15h
	HI3IqLDwvaISLQcF/4L1BN6WDftQG29sV7oXmE1kp6InYoXS4jJqSjrhLKG+xima2uZFFkEGDjduf
	/MdDp+/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nad5R-008jxD-Qq; Sat, 02 Apr 2022 12:42:37 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nad5E-008jtQ-0u; Sat, 02 Apr 2022 12:42:25 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 5C4A05C00F8;
 Sat,  2 Apr 2022 08:42:23 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute2.internal (MEProxy); Sat, 02 Apr 2022 08:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; bh=Fq6OlkR1JyeKwG1oXeMgLhHRDuFwun
 H+WFbnOc6UEYQ=; b=enaTxtMNAA+TV0gxVEIisr6CmEACW12Eo/0ABrfCmny2Fj
 ZIeHi2L/dAbiX4mv0TMr1vDiru2ByoRsWOLI9r1wJsu1nEGqnBm507jDGCqDOBc6
 Ad65gwSZSkwG9uGlbpaDkT0NjWQpc5mICPY/gzcUbQqTT/7AkmArZKsMvIxVBGZz
 rgRRz1DR8R2uOjt5xwKXflhoC3oSWtMF6ddLV8ea/S2qTGmKniimGf9EmZSROmot
 k17xWFuQFs9eTTuveihDIbqqbc+xlpGL7ObqDEK8LNE4DZPy0MFYZ1ZIt/lDs7A/
 srkmfdqbeBUtLTA8aSrcelQSJyb/KgHDIMZpClpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Fq6OlkR1JyeKwG1oX
 eMgLhHRDuFwunH+WFbnOc6UEYQ=; b=mELN1tGTgF9LOMsfmMVwbHxs6NqwibF84
 bE4W56hzHQ3b2wA1gx1+scSM1HK7/SUCvjQEyVMHzW8bLG0kjujcjdroD8RBG6jd
 8S8IUegVPj0IbeAcLb6KaZQKE44D0zH5z0KLsLZSi4te/hnRyDdg6Oapyzm958qy
 9uFqf73oXY5id5GC2TELZDfkQMoZ009EvSgzHqKxQepMASGyOsKGJbHcd7Fy6VFa
 eQiYspeKxoNbl7m7VnmivQoNaW12LCwU6lLlTt7p6moSIOx095VGHKxpgsMEX419
 5ZFGDN9s972nfeTgj7Myc53U3CafY8tdPI75si2rAs93MMGrsuvOA==
X-ME-Sender: <xms:rkRIYgaaBDcORLkGKrn-117x9d_DPTZmCiyIP2DhcOiE6OQO3K5x3g>
 <xme:rkRIYrYU1QiBQ5pcv6B-mE0MAvTA8CkvH7mbfznAg4dPd9UcgKYabWH8fXgfEMbXz
 pMQiY0OXBbmxNBAPe8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:rkRIYq-tfRaI5F3KUE7lG_GUqynuFAOncMffTs6TvcI0IvPX3RShKA>
 <xmx:rkRIYqqZxaEeDfxf2tQz5GAtjYIDEfnBxVvRSQ4nsNO--1PlEATq6Q>
 <xmx:rkRIYrrtLLqBhzBL73ItSwTkvbN9gSWn8F26pMuapw0PHTavrcMZFQ>
 <xmx:r0RIYkQsmEBZftHq6AuIO19kfBzZtbg2Km9lgYENm6Wa94dQdH1D4w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id DABFB27402C7; Sat,  2 Apr 2022 08:42:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <292b8bf3-80e5-49f0-86c0-b68cca335717@www.fastmail.com>
In-Reply-To: <20220324061650.GB12330@lst.de>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-8-sven@svenpeter.dev> <20220324061650.GB12330@lst.de>
Date: Sat, 02 Apr 2022 14:42:01 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "hch@lst.de" <hch@lst.de>
Cc: "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Rob Herring" <robh+dt@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 "Marc Zyngier" <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, "Jens Axboe" <axboe@kernel.dk>
Subject: Re: [PATCH 7/9] nvme-apple: Serialize command issue
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220402_054224_173973_0526716D 
X-CRM114-Status: GOOD (  10.00  )
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

On Thu, Mar 24, 2022, at 07:16, Christoph Hellwig wrote:
> On Mon, Mar 21, 2022 at 05:50:47PM +0100, Sven Peter wrote:
>> From: Jens Axboe <axboe@kernel.dk>
>> 
>> This controller shouldn't need serialization of command issue since
>> the SQ is replaced by a simple array and commands are issued by writing
>> the array index to a MMIO register.
>> Without serialization however sometimes commands are still executed
>> correctly and appear in the CQ but never trigger an interrupt.
>> 
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> [sven: added our best guess why this needs to be done]
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>
> This really should go into the previous patch.

Ok, I'll squash it (and the following two patches) into the previous one.

Sven

