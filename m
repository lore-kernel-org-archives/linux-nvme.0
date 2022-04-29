Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD5CC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Apr 2022 16:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oc7MhINv23q9eUpEfoSWVHTHfWwn013FwuuQWldLfQY=; b=E6IgRzb8lDapLqQCH3taasfhza
	44GlNQp7pwSodHGWaGlVeGrx5acIuj8pxG/m1Z5loCdIhZXPEB0ugLUVO1OLTVIWjCJaYPaDHlZwe
	SvFZIuNyKsGEorO+88/H929wZ7nwiUfi172jXXu05QIIq4RqyWWM5Eztsdvi+YgiWYe/r6ZlTsqq8
	OU09uSk5Vj0g0CcZ6Yrn1c2Q2JLuki8EyJdbtvw6BzS2TWIfrqoRHMQj4i0ZI8hXuWlW3j/JN4WlC
	G/MxgyFuJN6tmmvtqdkgafVbdY2lVT8zfPOK2f6Pfky+7Knkjyr1QMmXNKE7EeIB/NA4Z8g6hDXSD
	fPJ9NfmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nkTde-00BzN2-4N; Fri, 29 Apr 2022 16:38:38 +0000
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nkTdS-00BzJ8-3I; Fri, 29 Apr 2022 16:38:27 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id D37725C0244;
 Fri, 29 Apr 2022 12:38:18 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute2.internal (MEProxy); Fri, 29 Apr 2022 12:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; t=1651250298; x=1651336698; bh=Oc
 7MhINv23q9eUpEfoSWVHTHfWwn013FwuuQWldLfQY=; b=dmdfvvaA9cYuHuXsml
 xQShfHDDkGH+wiVGWzgCEaU1ZOzPMFqkqTVHa2xgb/klLODkxfCJuTRbxbguziPK
 I1brMhcXxEHkoYiEgEmq7NitzNXLenOdVbRohXYVLaW/J6ts+Z3FF/FueOSsbAJN
 5SZOcyNt0OlOzs22JBO7ofo4Rm1ZytYtXZnbK1TIbwMIclG8D62gCGs8lAaUQGHJ
 wS1lvufinBKSx4hBS9Gb1MRznbp4R/B9q66J44YWsq/R5s2oIDgnyN5rLAOinTuK
 mjadG6V5wGx/iqNxjOVs9xQBWST7RgUKZuc4zYuTZwjELWTy5BPqPSNdhRS97wl8
 C/1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651250298; x=
 1651336698; bh=Oc7MhINv23q9eUpEfoSWVHTHfWwn013FwuuQWldLfQY=; b=C
 gw3yx0b3GqdlpT45mll9o8WuZFtArewOElVyTmfqR2tdWFfneCEFwoDAKFfD2DLp
 45bMKg3u9oVUNWqa2SxgxWn4V5bTxPMsEKCxwUW0TWJsJwODhvn+5O6tl4PdYRhs
 fCNvc1XzO8S5/uWcW9zHe0AWJwoHW1NxZz2mwwiLy0spqSmw0BePPnvsx1ogEJmO
 za+/wv0lIl8GoWDybW+/I43UPeQhufvhwQIp+6WplrKCEDpavw0CIcjk/Zdtm0HF
 4A4d5IYqY257rEs0kV9HarOva1JSbqQHTDrJ1CzgIxS0LDdHw2Nf3bjPEfSFgnC/
 eedSOfC21ovd6pdEMFi7g==
X-ME-Sender: <xms:ehRsYtq1muOuVSGdbRTEASbLz9t8lLhudqy85QLo8HOcpmqRNGkT1w>
 <xme:ehRsYvplL-FjdYKJLDAK4jNEvZX_8O-0LunODa4E8bfTSscDGKUJT0-eVZXsIr5N6
 uoM2K1fpi6p0FAMLtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudelgddutddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
 ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:ehRsYqNfpTxAMfNsIMvo345vOmMF9M7yKLKkAzD9W2RFuqXi0L--8A>
 <xmx:ehRsYo6WfS9Pn1IlQ5uoMHotAvCAx0LtFTCVvVSOavX1yrVrLDqMhg>
 <xmx:ehRsYs5y6DjWv9cPLp6pkSW7nHUmuz27GHpr5unj3JUIrxSkTYxD7A>
 <xmx:ehRsYsyGCInuaR8dQMSDVehskexfwPJTp0S7LeAASS2eJ34w8FIDiQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 2D8D5A6005F; Fri, 29 Apr 2022 12:38:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <be7e0eb1-c423-455f-bd89-050d52996340@www.fastmail.com>
In-Reply-To: <20220428142412.GA19708@lst.de>
References: <20220426201539.12829-1-sven@svenpeter.dev>
 <CAK8P3a1yJkegvgvzHemBd_dowvpyDmxtUnrpiHob8+hiNeO4sw@mail.gmail.com>
 <0f6ea2c3-586d-4f5a-9cee-688cd73b96b3@www.fastmail.com>
 <CAK8P3a3pPxpoOZ0hm9htBRyYc7L38F6egi-0=41tMtcLRGJ_jw@mail.gmail.com>
 <20220428142412.GA19708@lst.de>
Date: Fri, 29 Apr 2022 18:37:58 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "hch@lst.de" <hch@lst.de>, "Arnd Bergmann" <arnd@arndb.de>
Cc: "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "Marc Zyngier" <maz@kernel.org>,
 "Janne Grunau" <j@jannau.net>, DTML <devicetree@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/6] Apple M1 (Pro/Max) NVMe driver
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220429_093826_241432_32D520BD 
X-CRM114-Status: GOOD (  14.34  )
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

On Thu, Apr 28, 2022, at 16:24, hch@lst.de wrote:
> On Wed, Apr 27, 2022 at 07:39:49PM +0200, Arnd Bergmann wrote:
>> The usual trick is to have a branch with the shared patches and have
>> that pulled into every other tree that needs these, but make sure you never
>> rebase. In this case, you could have something like
>> 
>> a) rtkit driver in a shared branch (private only)
>> b) thunderbolt driver based on branch a), merged through
>>      thunderbolt/usb/pci tree (I don't know who is responsible here)
>> c) sart driver based on branch a), merged through soc tree
>> d) nvme driver based on branch c), merged through nvme tree
>> 
>> since the commit hashes are all identical, each patch only shows up in
>> the git tree once, but you get a somewhat funny history.
>
> Given that the nvme driver is just addition of new code I'm perfectly
> fine with sending it through whatever tree is most convenient.

So If I understand all this correctly either
	1) I send a pull request with rtkit+sart to Arnd/soc@ followed by
	   a pull request with the same commits + the nvme driver to
	   Christoph/nvme to make sure the commit hashes in both trees
	   are the same. 
or
	2) I send a pull request with rtkit+sart+nvme to soc@ and we
	   take the entire driver through there with Christoph's ack
	   if Arnd is fine with carrying it as well.

In either case SMC (or thunderbolt if I finish in time) can also be based
on the same rtkit commit and could go into 5.19 as well.
I don't have any preference here (not that my opinion matters much
for this decision anyway :-))


Sven

