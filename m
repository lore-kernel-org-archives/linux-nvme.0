Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21E5C25B67
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 14:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U7OS0k1KL4G+q8t+KF7kxIyDuOO/nhcjTDuI8M9m8SQ=; b=A028Zzc15O7JhQo7UUBtwf4zzu
	ASQSAEFvNjQU7zUC4WyZveq1t4AChgoGEFpPpDxVHS37pjg0+cCtDxerlUrhfAtmNolVY/N5kQmat
	vaB4T4qwV5b1tsDVzpksxdk72ZvxRBWH11vMCf7KdtYzl5REsAKyduIaAKJ2GXAlYlYN5MScZagEe
	ORM7+eG/lgAjKpjIdOQXsFCrhL6haso/vdfAFyFaPoox3rivB7ojvr2YSafydbAKBK3eZcnq2v7fe
	yooVJYmqb7BAa1foW1imIVCrIIRCyr5drS9H1j/F07wSKxM/M1Y9TLVXF66ANWjKVddkzFk6jhTaH
	vxnYyq5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw1c1-00EjKM-24;
	Thu, 26 Oct 2023 14:45:29 +0000
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qw1bw-00EjIx-2B
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 14:45:26 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 686CD5C00FD;
	Thu, 26 Oct 2023 10:45:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 26 Oct 2023 10:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1698331519; x=1698417919; bh=U7
	OS0k1KL4G+q8t+KF7kxIyDuOO/nhcjTDuI8M9m8SQ=; b=krMYq2Kv9g5beJdk1M
	kGAKAX8ApzAljPRmkiCUhXal1Pr5h8aD1yz/7Zk9o5lzedbeHybDYUUHKwuJuBXG
	usGzqZYN53sm/C9/OfjEJTDqZS7g8GXZaV7TDLXu15gGZZdSUXvO18BAv1s4/mBs
	EORdk+DFljknaK8UV/BBrobVBgNzFRsoyM93VWzxHSYUDBSuaPW3wbaXeWqSdhit
	IlqEQIVsJTy8clt0FiW3g9HfkyWYQTX+q/0Xkxzp07aVau+gDdpJ0LF/d1pAR5SQ
	tEqVum6/Ay8a1BUX1/Wirs9iJ4aRTKOEDAjlmRlu8k7KoD9jDVunNLUbxfofspBH
	4rdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698331519; x=1698417919; bh=U7OS0k1KL4G+q
	8t+KF7kxIyDuOO/nhcjTDuI8M9m8SQ=; b=afNhlHsXr80bxK1GVXHXuCiW7AfwE
	MtW+Csny1nTsesZBgprF4WHxUnP2DYJVbOBX1xpw4OmSO+H498bG3Zh2Rul6PyjX
	dTDzwxlrUNZkuQ4wgYwAcllpUNx7MSwhDsD1qofgF8qHe9Dla0FKkXMdluEOQJNo
	K2MbsIVNDBm+0T5iFUGVFOODHf7tKg5Bv6vPWgf2atl38WNcsezvIaulmNwtqDQY
	63V/e/7yGl5Tzmy1WU5IMPJFcS7JllJI5BUhib9mwoLjNKDGZfEOUYGQUwGUt5hI
	+4XsCWjUMPpTLwKTdD919eO2KZrDiCs91R6ZOBG57U5LdYlsGiRjGVzcg==
X-ME-Sender: <xms:fns6ZWfkSdCk6e94dyNAVJezg2PVNVo3ohJYGl4Gwf5CggMBk3JcCA>
    <xme:fns6ZQPmlDsGZ1L0F50nXNS_F_CjPJFhJSUF_Gxtr--xSxDqRBZ-LRgpL7jo51yCy
    -mVtzkPJgc2jpbSuLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:fns6ZXj5MMEiPs2O0xtO5yN-DAeS49Jx-lJHwyeEQD_E09UXDt9gyw>
    <xmx:fns6ZT90f5G_DAqb5_bYf7CSOR0IZe4suLlaMLTfzNXCfh0xETtmcg>
    <xmx:fns6ZSvdDH4ig3NqWKLweZ-ylv5sGTrA4R1Lux7Fq5vTtQTeq1KImQ>
    <xmx:f3s6Zb5ECKbYo7rA7lZ11LhWlI4E5OOdRWOYrgvwDTR_nSEv4pjp2Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4ACDAB60089; Thu, 26 Oct 2023 10:45:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <a79fdc2b-d6e4-4ed1-a0cb-87f7f1178f65@app.fastmail.com>
In-Reply-To: <d497429d-a1a2-4bf4-a958-3865294d9f2e@suse.de>
References: <20231026130804.142586-1-hare@suse.de>
 <20231026130804.142586-3-hare@suse.de>
 <b138c4c5-9b49-4338-a79a-2f77a13381e8@app.fastmail.com>
 <d497429d-a1a2-4bf4-a958-3865294d9f2e@suse.de>
Date: Thu, 26 Oct 2023 16:44:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hannes Reinecke" <hare@suse.de>, "Christoph Hellwig" <hch@lst.de>
Cc: "Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_074524_959849_38F57196 
X-CRM114-Status: GOOD (  16.83  )
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

On Thu, Oct 26, 2023, at 16:20, Hannes Reinecke wrote:
> On 10/26/23 15:37, Arnd Bergmann wrote:
>> On Thu, Oct 26, 2023, at 15:08, Hannes Reinecke wrote:
>>> diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
>>> index 244432e0b73d..96031016079f 100644
>>> --- a/drivers/nvme/common/Kconfig
>>> +++ b/drivers/nvme/common/Kconfig
>>> @@ -1,7 +1,7 @@
>>>   # SPDX-License-Identifier: GPL-2.0-only
>>>
>>>   config NVME_KEYRING
>>> -       tristate
>>> +       bool
>>>          select KEYS
>> 
>> I guess that's one way to address the link failure ;-)
>> 
>> It feels like cheating to force it built-in even if
>> both target and host support is in loadable module.
>> 
> Arguably.
> But the decision matrix really has only limited choices:
>
> Host Target Keyring
> n    n      n
> n    m      m
> n    y      y
> m    n      m
> m    m      m
> m    y      y
> y    n      y
> y    m      y
> y    y      y
>
> So we're correct in 75% of all cases :-)
> And before we trying to figure out some weird complex kconfig syntax
> to get all cases correct I prefer the easy solution.
> Plus it has the benefit that the keyring is avialable right from the
> start, so you can pre-provision keys even before nvme is loaded.

Your original version already had the logic for doing
this part right and always linking the "common" module
as built-in if needed. Maybe just replace the "PATCH 1/2"
with a different approach then.

My feeling is still that my v1 was the simplest solution,
but that does exactly the right thing in the end, but if
you absolutely want to keep the #if/#else block in the
header instead of the "if (IS_ENABLED())" checks, then
you could also get there by moving the bits that
are actually common (the MODULE_LICENSE, MODULE_AUTHOR,
module_init and module_exit tags) into a third file
that is always part of nvme-common.ko.

     Arnd

