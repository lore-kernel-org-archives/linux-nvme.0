Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AA1C25B47
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 08:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cp+D+5RyCsnYeIS7Wq6WBz9SpcPiNFHBf6Yri7JkKEU=; b=O6ItW8Jzddx1V8Q92lPp1NVEKI
	KUAAsofutPAmxKFWfJ3DnypShIPrI3bHRlqDx5D0c1jpuQBEtgG6FwJwOgPlGvMbYlwyud8Qw0rUW
	9vWSYIs4Gt057CH0P2ih/iSY5Z7PtASRg+O0+wcjRrAD5RxctF9NgQq6ET8ZtUb3UT38jZVjdkfDC
	rcUyJYM0clw226DC/SYQ0PjRsXmNDH2AKklFnUU0pGR+q0N9rrTIkbR2q9lGt8Mt/ofVsh+uDszn9
	QYsf93Fj7JdBIoP4mPHGCA4bbOGik+Eex2zA+jzxacLM0r4FvSAfSP3iupyn81cz6yIAUkPOCivx/
	068agq7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwHxR-00FuFI-1D;
	Fri, 27 Oct 2023 08:12:41 +0000
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwHxO-00FuEc-2i
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 08:12:40 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 1A8373200906;
	Fri, 27 Oct 2023 04:12:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 27 Oct 2023 04:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1698394353; x=1698480753; bh=Cp
	+D+5RyCsnYeIS7Wq6WBz9SpcPiNFHBf6Yri7JkKEU=; b=rgf1rGSPFclHJJ/RrH
	spgHgXwU0BKqBemNhJoCYD9ETgDrNariSupBCiAvkD9A4diqQ6CfK9FLfHwC+biN
	l083XTIrpvWYn6NV50hD2G9X/mkuYgBU4w8TRLEvooZslPs/irzdGE4wRlTsu/Tt
	IxssfFIphp+U1oeR0ogFCP9VQSY3Pz0BczMKV+fDRQO0KVD8OMfNCxG1CvR4/kaz
	fgLSlTUU5YLrKnOL8nYK0ueOGq1n++s9E+GCdYr7BaIyR9HPWKhaIEm7PogXbLaR
	2XIaJt/XSF8z0zCLdu82oCPu5mohnZXUs82OTjnH987J2HcfL4WAVqLKu7EZa/Ai
	9gig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698394353; x=1698480753; bh=Cp+D+5RyCsnYe
	IS7Wq6WBz9SpcPiNFHBf6Yri7JkKEU=; b=VaZnKlV5kbOBlDnonKOdDjwoDaXkX
	W9EWn8uMaRyvAO/0q9NHGhj0bW9LZXE4R73ItxUBXHoz0jXqUkwF2eujiSa4QAlD
	+4xMlICIT756GsEoAmSBEPxtW+AuvaZZXZKfbQtyYQuWxmUcogo1bnsSqNXdduvl
	XhCdigUzH90vAj59auhxr1A16dWb+c+u4ptBQg8nGUKclvicjiNUK151e9Ly0YpI
	Yg5gcWUgX7cr/vaZoGa+q8UQw9UuzkfbWMjC1bThCVDxZJKmRlHabDsLX30sGTY2
	t0ID3YfzTu0DEUB2wG4KXjJz/c2gD5nnZH2ElN96yoaFM+88ha8k92xSQ==
X-ME-Sender: <xms:8HA7ZUglnjT_LL0PMG5Uf8KNAhwgCIg9Dn8hZwux48NOkTe2PimXug>
    <xme:8HA7ZdCrKpO2Fq8K6IvMMdfa9bFSeqe7qxNAiLpSAMFUTLW_LUpFdqUnCtdBVXKQE
    m7j9_iLph0bNwxAlvk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:8HA7ZcFfqLq3UEqLm2o_UR_UuQzJbcJJJU1ktQfMutMKmIwJeK5QPQ>
    <xmx:8HA7ZVSXh6hHLIhXYxPSWf6hPpicxk1tfSc4AqQZx98CSwQwNDm9TA>
    <xmx:8HA7ZRyrZCnw5_lo2FcfEevetubwCFwYURxEWuiFkaqw1Pvg42G9OQ>
    <xmx:8XA7Zc9_F7hdLRDfh1PrOC3TfULF5lHULZF8uMCclyrKKqHc-CcD0g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AFC10B60089; Fri, 27 Oct 2023 04:12:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <468cd6c9-c541-47ea-a2bc-f6cd09155351@app.fastmail.com>
In-Reply-To: <78d1b4e3-4bce-4cbb-8ebe-8eb3f0fe9930@suse.de>
References: <20231026130804.142586-1-hare@suse.de>
 <20231026130804.142586-3-hare@suse.de>
 <b138c4c5-9b49-4338-a79a-2f77a13381e8@app.fastmail.com>
 <d497429d-a1a2-4bf4-a958-3865294d9f2e@suse.de> <20231027052118.GB7885@lst.de>
 <78d1b4e3-4bce-4cbb-8ebe-8eb3f0fe9930@suse.de>
Date: Fri, 27 Oct 2023 10:12:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hannes Reinecke" <hare@suse.de>, "Christoph Hellwig" <hch@lst.de>
Cc: "Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_011239_085128_E9827A3C 
X-CRM114-Status: GOOD (  17.46  )
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

On Fri, Oct 27, 2023, at 08:01, Hannes Reinecke wrote:
> On 10/27/23 07:21, Christoph Hellwig wrote:
>> On Thu, Oct 26, 2023 at 04:20:12PM +0200, Hannes Reinecke wrote:
>>> So we're correct in 75% of all cases :-)
>>> And before we trying to figure out some weird complex kconfig syntax
>>> to get all cases correct I prefer the easy solution.
>>> Plus it has the benefit that the keyring is avialable right from the
>>> start, so you can pre-provision keys even before nvme is loaded.
>> 
>> in the 75% of cases that don't really matter, as 99% of all setups
>> have nvme and nvmet built modular, and for that you now build code
>> into the kernel for no good reason at all.
>> 
>> FYI, what's I've done a lot in the past for such simple helper is
>> to not have a Kconfig symbol at all, but let the Makefile handle
>> it.
>> 
>> A
>> 
>> obj-$(CONFIG_MOD1)	+= mod1.o mod-common.o
>> obj-$(CONFIG_MOD2)	+= mod2.o mod-common.o
>> 
>> will actually do the right thing here without much complicated
>> boilerplate.

Right, this is what I meant referring to the usual Kconfig
or Makefile logic. The example above needs an extra conditional
here to deal with the keyring code being turned on or off
altogether in addition to being used from any combination
of built-in or modular host/target modules, but none of this
should require unusual hacks.
 
> In principle. Unfortunately I have to initialize the keyring, and that
> can be done only once.
> I see if I can come up with a different solution.

If the keyring has to be initialized first, I think the safest
way is to move it to a different initcall level, to avoid
relying on link order for the everything-built-in case. The
other cases are handled automatically once you get it to
link properly, as module load order takes care of the
all-modular case, and with the keyring built-in it also comes
before any modules.

     Arnd

