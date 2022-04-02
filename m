Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABEEC433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Apr 2022 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MSqxliGRmaqeBjqjXF6Gm6Q29Wo8+BU30FxXYdxfB/o=; b=xmYKbf8+GXll9SJz5c6gT2fEi+
	K41UCCoA6jDaaoDUH3BsXlzVSjoWbYIi0U/F0f8GUvE9Nf3mP+qtIqBZ+5J7lQVgcPN+cMHRJi2pZ
	bTTeH84CSVegfeLNtGS4MzFWA6ohQG+KE3kMz2Y1YXLgf2iU+O0QltZKEPBz6HTYn5iui2WHx21Bp
	4lseLrhIvy2q+woY7d+c9Ugps+IAPsh6Bs5z0LDEsf0eZrbKDCEDYBZMp5BBUUnV3HQTaUw9D5BJZ
	XIMWAb9fN3uMfvO7zmKhS2FMnlq2tc2/aYwSN1qTJpgXUHepNiDCmVrXunyq61FhPr7L1iE71cXPC
	gT0iFylw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1naedx-009FyX-Dq; Sat, 02 Apr 2022 14:22:21 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naeNR-00987j-Hn; Sat, 02 Apr 2022 14:05:20 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 9FBAD5C0138;
 Sat,  2 Apr 2022 10:05:16 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute2.internal (MEProxy); Sat, 02 Apr 2022 10:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; bh=MSqxliGRmaqeBjqjXF6Gm6Q29Wo8+B
 U30FxXYdxfB/o=; b=RrQh5Qfi3JCyrNr+6e3X7PpLV4GhgvX2rjzeGvDy4j4Rm1
 BpRjtlXvxB2l7eLKUam/VBhPVuhpbh1gG/nhh/1y4xSwURIAOLkObJdosImX0PnX
 ZNb7g0lia5HpzZfONC6Pr+AAN8HXUMb5MtqbinEHcBwXJan1F0sfgBirG/EfAbJz
 038QQnfZ8QSDsy2hYaLW72y7NDgBuXMBglNz08inr8AymgwbDOUuI0eIX775+FVB
 U1U79uLn7+wdl9DBjfnUIC4QyumLF3g1/5vrvHU1khoLTHGS2ORxCOceof8aEzHV
 IFUIxAm+tuqYtspOmqIwEIGb99tomxi2v5WOFo7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=MSqxliGRmaqeBjqjX
 F6Gm6Q29Wo8+BU30FxXYdxfB/o=; b=AiI7QD+EkZrr4ugGvlqsTu8wQNa3M5b52
 GboNbpYAZic3kbIJI6ufUy9Y43rEp/LVpYJuQAMXW5If9IhKVytbWbEphCFpi2jo
 L3dYOJW3rrZnlyk8PyIOT4az4k2e8UNqHWGa3edOfQbfR92XMQYtKVAT7zCqy7Ee
 XzGjq/GL3nDd5aj3t8UhA0rRAwXU7c5CwYKodfThs/eNJO9Rg3fcd7ulUmrbZ1Ew
 7eNIq6FnfT6fKoq+6DoeqJqd6fJRsclblgdCXkJuyMkrgMefSkxSKBISISm3fIli
 YtbTc/ODNOeoaTMThU7bbPK9maffXgUaooPD+92Tij+AtTGjFB8rg==
X-ME-Sender: <xms:HFhIYijvLTduOdyQqIhN0Wy4aWny4vAwTyc1Q8fs1O7RsgWe3u0EWA>
 <xme:HFhIYjDgQjQCjzt3eO1msXacnXLfPYol-JUQct6tFRJdInDg4z2BR4sRjslStGHNU
 SavwD-qOrjJ-uXBzNY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgjeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:HFhIYqHshJm3fX77A6bMVTI0ITdzbtdL_gjt5rutx4YuEliYyXlj_Q>
 <xmx:HFhIYrTSgNF3pL0eBWlIZ_5nUcURP0bHVZUfg3AJyjjjGtQ3nmCtzQ>
 <xmx:HFhIYvwyW4M4yeSQaQ3QU2avkYgZHAED2OTRET_EM-HvStM9NFaQdw>
 <xmx:HFhIYt5v6ero_5KclzbL_PoPODlTA8Yq0_BJlXiRyWnoBxLRE87opA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 72A7F27402C7; Sat,  2 Apr 2022 10:05:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <f944f2b4-17fe-41dc-a262-e266ac45b3ef@www.fastmail.com>
In-Reply-To: <20220402135834.GC10474@jannau.net>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev>
 <CAK8P3a27-eWP=krGQOp29krcc7bVME9=MbN6B3Rs7Q4Ran_VFw@mail.gmail.com>
 <7876eb84-9803-48dc-ab6b-27d49858e27a@www.fastmail.com>
 <20220402135834.GC10474@jannau.net>
Date: Sat, 02 Apr 2022 16:02:05 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Janne Grunau" <j@jannau.net>
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Keith Busch" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Rob Herring" <robh+dt@kernel.org>, "Marc Zyngier" <maz@kernel.org>,
 DTML <devicetree@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220402_070517_734022_32F28350 
X-CRM114-Status: GOOD (  14.72  )
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



On Sat, Apr 2, 2022, at 15:58, Janne Grunau wrote:
> On 2022-04-02 15:34:55 +0200, Sven Peter wrote:
>> 
>> 
>> On Tue, Mar 22, 2022, at 14:38, Arnd Bergmann wrote:
>> > On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:
>> >
>> >> +static int apple_nvme_sart_dma_setup(void *cookie, struct apple_rtkit_shmem *bfr,
>> >> +                                    dma_addr_t iova, size_t size)
>> >> +{
>> >> +       struct apple_nvme *anv = cookie;
>> >> +       int ret;
>> >> +
>> >> +       if (iova)
>> >> +               return -EINVAL;
>> >> +
>> >> +       bfr->buffer = dma_alloc_coherent(anv->dev, size, &iova, GFP_KERNEL);
>> >> +       if (!bfr->buffer)
>> >> +               return -ENOMEM;
>> >
>> > You pass 'iova' as an argument, but then replace it with the address
>> > returned by dma_alloc_coherent(). Can you remove the function
>> > argument?
>> 
>> Yup, will remove it.
>
> You can remove it but we will have to add it back once we submit the dcp 
> driver (display co-processor). dcp is initialized during boot and uses a 
> single pre-allocated buffer which needs to be mapped instead of 
> allocated. It seemed easier to make apple_rtkit_ops.shmem_setup() 
> omnipotent than adding a different function pointer for this case.

Or we can already pass the iova DCP sent us into bfr->iova
and this function then has the task to just "do whatever is required
so that struct apple_rtkit_shmem *bfr is usable".


Sven

