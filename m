Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C79C433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Apr 2022 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e72bX3p4b48wpbYJ/u6Hs+Uz3FIweLzhnqtPOQPMPjM=; b=KGpDIuTQegVwPLNqbTcZ3xnt2+
	ZJ9F8jEunD88PGMol9uANZekdcBOgV8uaEJWqvyGw9qIX+gTsvUce+KM9qQ7nKKq3z/UpgdE1Aoyk
	h/wl1FgaaearSkxIOmMLyulT0pjnZ/T68e9fLNRPab9bEo+B88Jjtv5TSvPAImUmb/fK5CdzkobcQ
	TGGBNsPqW/rDQ9tNT+okrTiNwwR9EJsZcrA98qdjhosRiTncvdIJODZCxqkSg3PYrxAoinD5sozp4
	7j8gZwWQUB73k1ZX2PkEhrkrBd7c5FVCbL0pKPzSgSV85pCFd7w8AtNPoBtT2Kja7iHcvsrQPZ9nz
	hTMWsB9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nadKv-008nQO-9d; Sat, 02 Apr 2022 12:58:37 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nadKi-008nL8-1F; Sat, 02 Apr 2022 12:58:25 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 5F01D5C0143;
 Sat,  2 Apr 2022 08:58:23 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute2.internal (MEProxy); Sat, 02 Apr 2022 08:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; bh=e72bX3p4b48wpbYJ/u6Hs+Uz3FIweL
 zhnqtPOQPMPjM=; b=SJwtH7IQ/BxZxuwom9tizbP2N+RQW8uL17YE5OF//JiVVe
 cLilGzTSKohekRmUXFU7VltAHtTqKkz8im8q3zbV84T9C3rRJmWoNYbCXaEoen4a
 fnimMZXOFjcNTwZXn9lOaMSPGAfOYpCZYRYd5eHIbDRvLUgfr7GBHaQ/vvMTgASj
 0CliNzPO/ASRsjOkKgVxgR4zp3rlUKVmSJbW2nZu3d8YQFqpZyrarYwn5CRfx6Vc
 WbFiI4WX3yKNfFv42LIHwUGymAeSTmIl8R2beeqUhEOVoj2N2W0N8HpyWhUeH1Cg
 Vfe1PdCMDiwlK53Yd3cPTNUT8ZDSs3FkLlsSFaTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=e72bX3p4b48wpbYJ/
 u6Hs+Uz3FIweLzhnqtPOQPMPjM=; b=k8hPoDsiwXAQxi3pWhyRQKJznH3xEShQZ
 IYwqTWouxkaiOeQ3ChYl8nP7gse1DKbNsPbHB58UuZXvX2A8ucrc9nPPCr5Bl62U
 fJLcnqNutSRDtEZT5DgFBmMULg94wAzIRGybaq6U4LvTKmbuo+xAwWHsys5EbffY
 GKrVZPTMURcJwqsXQ0S9FY/OKawTIovSdfV4NCT1yCZ15vgfsRBqGaTG//BFXKOW
 6Fngvo0HVyLCWI0goaBd2NClyho2p0nkl3e0JepihUOqgIOJa3CJMfxhy7VILHSQ
 M188UTqKwN6/E4s2cVc0IN64t9dkWplYohDeaV8ScgvKqwIYVNSkw==
X-ME-Sender: <xms:b0hIYklJIM0pX0JCJbnUbgE9TXJFFEoKY8FYPh4i3B_7xKssGG3ukQ>
 <xme:b0hIYj3m2H0a6GkAiIVaW1HiXktpnzt59XqO6FdnRcifGJInw8kZAvPOzNlDd6gU7
 zWZknAfDUDX7XG0Ixo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:b0hIYiou0ZEGp6VP7aorJi682Sz8P-MSYgSoI1ZDF98DcJKTqz7Ohg>
 <xmx:b0hIYgnQJUVedkTs5RTHn7YwpiTpx_fwKJQA4SxMqxHXVd4PkBCB1A>
 <xmx:b0hIYi1ukTyTo3BRzPeTX1Cx4OmVtRInRnvwpdN4lBprihjaZRrIiQ>
 <xmx:b0hIYrvlk-Do-LciSK47g_WhX_h0Jq8Wnf3rg7-OUfZYgFomO4a5kg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 2514527402C7; Sat,  2 Apr 2022 08:58:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <076879ce-242e-4c24-9052-003de63d3f63@www.fastmail.com>
In-Reply-To: <YkYbubNBD+J2XUCg@robh.at.kernel.org>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-2-sven@svenpeter.dev>
 <YkYbubNBD+J2XUCg@robh.at.kernel.org>
Date: Sat, 02 Apr 2022 14:58:01 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Rob Herring" <robh@kernel.org>
Cc: "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, "Arnd Bergmann" <arnd@arndb.de>,
 "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "Marc Zyngier" <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] dt-bindings: soc: apple: Add Apple SART
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220402_055824_197109_F889B9B4 
X-CRM114-Status: UNSURE (   8.47  )
X-CRM114-Notice: Please train this message.
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

On Thu, Mar 31, 2022, at 23:23, Rob Herring wrote:
> On Mon, Mar 21, 2022 at 05:50:41PM +0100, Sven Peter wrote:
>> Apple SoCs such as the M1 come with a simple DMA address filter called
>> SART. Unlike a real IOMMU no pagetables can be configured but instead
>> DMA transactions can be allowed for up to 16 paddr regions.
>> 
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>>  .../bindings/soc/apple/apple,sart.yaml        | 52 +++++++++++++++++++
>
> Close enough to an IOMMU in terms of its purpose, so put in 
> bindings/iommu/

Ok, will put it there. I guess I can also use iommu for the node name
then, e.g.

    iommu@7bc50000 {
      compatible = "apple,t8103-sart";
      reg = <0x7bc50000 0x4000>;
    };


Thanks,


Sven

