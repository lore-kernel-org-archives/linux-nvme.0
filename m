Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC2DC25B47
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 09:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sl5LjuHS+lnQA9RapphStdwSNzRtK5vM5YNaMwVqDWw=; b=KdvVhQBqq8m7LhfHqAoJIBhhpT
	yfgVxcpWQb0FxJ2wyLd4qfOFrVEXewTMb4Exm8KD5MgcF2TEEy5Bwn/pGPnTGt5H2folMiGYJFm90
	HCiJxROoNcLtKWMHoFxFF6kliAd9DqneOdWTZPkF89ZD22zak3Jcn5qKsyj7gzzfFtTXYy2wUE228
	FGxJvgu5E6yNv0hY+6vbRYc7XX/P3YlAA9MPV5JpkxgVoe/fc2ou3Ei/I2UVTGWVZ0pa7XcBED3mF
	ZnPzohg+McxfFUavpfzJTMqCLRmM9fNfwzfBtoPLVlvy/bOENTS+xbrUp6P+VEnpd1G20317XcRkA
	GcPkmUWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwIvj-00G0QU-2o;
	Fri, 27 Oct 2023 09:14:59 +0000
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwIvg-00G0PW-26
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 09:14:58 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 983EB320091D;
	Fri, 27 Oct 2023 05:14:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 27 Oct 2023 05:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1698398086; x=1698484486; bh=sl
	5LjuHS+lnQA9RapphStdwSNzRtK5vM5YNaMwVqDWw=; b=JWuE1l6wax1DsAhGno
	cJbFj2TtNFtD1IxDrWQm5B/iLtu9Gm1HRfXeQ2UYUBQCrc+tJGmlneqkDf3N7kL8
	vozXUXwsftjzrRlcBvfGyTF1D1sSDZM+X/b3muCOM8mvmLDmiE8F3b5V5C7CRWXa
	8wuJQVQnbF4T+jAPI/rghkgQb0Vw8Gw4cyp6uqgVbS8OiWSDhyfUjvxMkVUcrjuX
	pgD6HzgwRSbAsnN/d6ZWvd5zm1+kTuf5akieezremcnBGUxmNyPkMNOCL6esQSVE
	iUZXNvRz3WerDmZW/z6WDpICPiqqUGHsq3VtTRlWof/A08sPBks3R4FMfv79GI7b
	6AkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698398086; x=1698484486; bh=sl5LjuHS+lnQA
	9RapphStdwSNzRtK5vM5YNaMwVqDWw=; b=aKVMutQtwM5an6w82vStl0MlVF7nO
	OWH5jFrDtQPICI1JTv62BtmZtUwYLwjj0CV7GzNAiFqcTLwsDlPC9lNOIKSfy05E
	YRu4ty391oGa0lLNtMrE9QgmAK7okgSWKStygh2TT7lY2XkJa3uqwGN8hGjppLZF
	eJvUEISvlGUljT5lL07TqyR1XeC0M78ENtKD8Ca72+KWZ+1LuwLWiqAkJepJMt5+
	9FsrvfXeriwnetdgBFxgCsgnmoK2aggouGjxeAL5XH5Eynuqz1hnjLDUq4RTJyhL
	jSjHcBy/krw3lwf4i7lFKBIV/bh6nfKsVPAUGIxh11iKrIGlCoaUDJTgQ==
X-ME-Sender: <xms:hX87Zd5M1Vcsc4eiNrc7TmsG-cqvoSfhPScO27Le81b6W2FjwKOkqw>
    <xme:hX87Za5Kf7GgO7h6ZtqJu40p5bytgJy9SLGZskH3IBUw0T21_LVEkGSQvs1RPzWQw
    U5Njtra1wA_a0B8ckQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:hX87ZUd4E6R_NWXE3LHQoHl52G_ChdjY3jaZhi4BDZ05ek2IPZRANQ>
    <xmx:hX87ZWJssRKHQSVYJiTkpkEN1a28cV3c7FHM4VTflzChj4NExOfmrg>
    <xmx:hX87ZRL2hn9hHpUKZo2sx9Nh4lU4jRAM2w9gXUF90sCiygm-gJ2gRw>
    <xmx:hn87ZYXzn76TKMTWQkjNWhiiD9Pjx7ZFLtHfzNFO3HJv_X9-204WEg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9D6C1B60089; Fri, 27 Oct 2023 05:14:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <869be417-2eda-4ab5-b5e3-6adae19e3356@app.fastmail.com>
In-Reply-To: <cdf931ad-626b-4efa-bc74-f4566b88e404@suse.de>
References: <20231026130804.142586-1-hare@suse.de>
 <20231026130804.142586-3-hare@suse.de>
 <b138c4c5-9b49-4338-a79a-2f77a13381e8@app.fastmail.com>
 <d497429d-a1a2-4bf4-a958-3865294d9f2e@suse.de> <20231027052118.GB7885@lst.de>
 <78d1b4e3-4bce-4cbb-8ebe-8eb3f0fe9930@suse.de>
 <468cd6c9-c541-47ea-a2bc-f6cd09155351@app.fastmail.com>
 <20231027083003.GA17042@lst.de>
 <9bd4e078-b206-48b8-b94b-bc411317bb3d@suse.de>
 <20231027085644.GA19366@lst.de>
 <cdf931ad-626b-4efa-bc74-f4566b88e404@suse.de>
Date: Fri, 27 Oct 2023 11:14:24 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hannes Reinecke" <hare@suse.de>, "Christoph Hellwig" <hch@lst.de>
Cc: "Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_021456_988489_95A6BE67 
X-CRM114-Status: GOOD (  16.58  )
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

On Fri, Oct 27, 2023, at 11:08, Hannes Reinecke wrote:
> On 10/27/23 10:56, Christoph Hellwig wrote:
>> On Fri, Oct 27, 2023 at 10:54:42AM +0200, Hannes Reinecke wrote:
>>>> I don't really mind the link order, for these cases I usually add a
>>>> comment to the Makefile so that people don't accidentally change it.
>>>
>>> Point is not that it has to be initialized first, point is it has to be
>>> initialized only _once_.
>> 
>> module_init ensure it is only initialized once except for the case where
>> the module is unloaded and reloaded, in which case you actually do need
>> to initialize it again.
>> 
> So if I do this:
>
> obj-$(CONFIG_MOD1)	+= mod1.o mod-common.o
> obj-$(CONFIG_MOD2)	+= mod2.o mod-common.o
>
> and mod-common contains a 'module_init()' and a 'module_exit()' 
> function, what happens if I load mod2 after mod1?
> And what happens if I unload mod2, but keep mod1?

In the syntax above, you get three loadable modules:
mod1.ko, mod2.ko and mod-common.ko. Loading either
mod1.ko or mod2.ko leads to mod-common.ko getting loaded
and intialized first, and it remains loaded until both
mod1 and mod2 get removed. If one of the two symbols is
set to =y, then mod-common.o becomes part of vmlinux,
gets initialized first and cannot get removed.

This is different from the invalid example

obj-$(CONFIG_MOD1)	+= mod1_module.o
obj-$(CONFIG_MOD2)	+= mod2_module.o

mod1_module-y += mod1.o mod-common.o
mod2_module-y += mod2.o mod-common.o

which is probably what you were thinking of. In this
case, we'd get two modules mod1_module.ko and mod2_module.ko,
with mod-common.o getting compiled and linked separately
into each one if they are both =m, or a single copy
linked into vmlinux if they are both =y. Kbuild now
warns if you attempt to do this, because it causes
a number of problems.

    Arnd

