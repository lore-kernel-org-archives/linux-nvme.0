Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487BBC433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Apr 2022 13:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=36fwwX5mmUYNyjISmlYXoRKFgt3R6w97RvAOP2q5fsk=; b=rG0FhzR2Zd0aIICctdWyaQtVRt
	vkLbA9BaSMjWpH5PTSAC7RE6Fje+iYXkaH7+Vog/h1+c7bK9AHcQ+epmcU7KqsK/d/uCQu1qCon9H
	qaDhzjKPqiwUSaMVQmSN4kIaZYkS1loyUwj3a9W5dC4gi+lW3C94ZRAC+JmcNJKw68b3BRtW0XjsU
	Ar8IAz7sqm/zBBcDMA89rOK8srFsZddIIN+3OWO9KRtutsGjk5a/sCrm0tL6hE7tZNuIaex1nuVB9
	U1sjEdZ+nmEf3rnst33ph1NnVdB5cr7p5n02laolo/2RKpvbyZbVT2aUP0LzZmIS8nE9TFBG7D14Z
	0ZdWynHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1naeGG-0094gG-1W; Sat, 02 Apr 2022 13:57:52 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naeAn-0091PK-D5; Sat, 02 Apr 2022 13:52:15 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id A1AE15C0134;
 Sat,  2 Apr 2022 09:52:07 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute2.internal (MEProxy); Sat, 02 Apr 2022 09:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; bh=36fwwX5mmUYNyjISmlYXoRKFgt3R6w
 97RvAOP2q5fsk=; b=cUuNLTeleWise7MZASHJ6IlX3UrczALRQUBOL1BW44dcB2
 L/hBCFQzjUgFkI9YqLYga/ly177jgVktTyqjtfhewMAiryhg65zq55hpeD+Pt/OH
 JMFS3mC3zYsCY2upAgsfavDFVpj83O+E07vR7kBevcL/eSlE1kbQ4jtjVM2WAb2F
 x2YV4Seny+grOxRam/rHgj5PVunayPjSg1J12QgAUNNKygxXUu2TQkD9J0T0nL2k
 xNBEp5bC2Cr6DXEWjbVKZPAwDo+/S9ni2RVTgWxq/1flzVCbDWdsRvzsfDaE4Cxn
 QnMRT4VSZyKmsK/QUScRKcw3inEl9YH0lrUhLPEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=36fwwX5mmUYNyjISm
 lYXoRKFgt3R6w97RvAOP2q5fsk=; b=GvG9PTvkcxsekkVWwznmRdAMG6kL6aZJt
 gz7Oj6sR2KsFuYv9U5eZiCEBgdkT5vS5PIXm2UOWj2LLsdlSacHYX8Cf2zpExWy/
 6GH6oqgh/2jUKfEF3kB1NMp94hDL9A+J7iXMUsrt75RamS7aNCwjxpZctiHb0LIB
 kChPDXX7uEpXHLpe/x4MCYvhxL2FJjG98lmge2cmpwSyAa79nOETxLap4PhUnz3I
 dAYo+Nro40Ho4tGTGJlLVHVJ2cJ+/XIpda6gF6a+uK+g6rXmkFmbj2sib5DYuwVn
 LS22iLUAV8WsfGXocy0dxG7fepmHa7if98HmdNlEWaE+jpl5y6zSw==
X-ME-Sender: <xms:B1VIYhbXhwgAwvuFM98GzEnfsKQ8dOS8fkOyDHTC7tHUnZy21Bgmfg>
 <xme:B1VIYoZ0UlFGyHRWzEXrl7z_lkV3G5Dhhx9JhJqRggHwXMete47OPkpWmZkZhX7gB
 1UbW2O-nazEwz_ANUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgjeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:B1VIYj9ZtEtZ8CJowLn1UGImgyOPA2vXPYCg6e1--eZh_ja1dxtDrw>
 <xmx:B1VIYvoF8HAClmGI5-AakZMlbIiLdiuX64qGf6zqY7pBG0eGuoS94g>
 <xmx:B1VIYsrrTEbnpKYofNmYthJAmnf4GKZH2mwBkNT1O7prrUAbRNuW4Q>
 <xmx:B1VIYhSN9niLA87i-9d7f3ECFqVW5QH8kRaYbZ0X2B41PvY0MeQmeQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 0E83027402C7; Sat,  2 Apr 2022 09:52:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <35f5fdbf-faac-457b-a225-35d7141f6b2e@www.fastmail.com>
In-Reply-To: <5eed58a1-ee56-8aee-e73b-76b162d59873@kernel.org>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
 <5eed58a1-ee56-8aee-e73b-76b162d59873@kernel.org>
Date: Sat, 02 Apr 2022 15:51:46 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Rob Herring" <robh+dt@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "Marc Zyngier" <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220402_065213_887019_C735D017 
X-CRM114-Status: GOOD (  20.27  )
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

On Wed, Mar 23, 2022, at 12:19, Krzysztof Kozlowski wrote:
> On 21/03/2022 17:50, Sven Peter wrote:
>> Apple SoCs such as the M1 come with multiple embedded co-processors
>> running proprietary firmware. Communication with those is established
>> over a simple mailbox using the RTKit IPC protocol.
>> 
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>>  drivers/soc/apple/Kconfig          |  13 +
>>  drivers/soc/apple/Makefile         |   3 +
>>  drivers/soc/apple/rtkit-crashlog.c | 147 +++++
>>  drivers/soc/apple/rtkit-internal.h |  76 +++
>>  drivers/soc/apple/rtkit.c          | 842 +++++++++++++++++++++++++++++
>>  include/linux/soc/apple/rtkit.h    | 203 +++++++
>>  6 files changed, 1284 insertions(+)
>
> Isn't this some implementation of a mailbox? If so, it should be in
> drivers/mailbox. Please don't put all stuff in soc/apple, that's not how
> Linux is organized. To drivers/soc usually we put drivers which do not
> fit regular subsystems.
>

I put this into soc/apple because I don't think it fits within the mailbox
framework very well.
(It actually uses the mailbox framework for the actual communication
with the hardware with a driver that's already upstream.)

Essentially, the mailbox subsystem provides a common API to send and
receive messages over indepedent hardware channels and devicetree bindings
to describe the relationship between those channels and other drivers.

One of the features that doesn't really fit is that we need to be able
to start, shutdown and re-start these co-processors. The NVMe driver
actually doesn't need to send/receive any messages except those required
to setup the common syslog/crashlog/etc. interfaces.
The mailbox framework would have to be extended to support these specific
use cases.

Another thing that doesn't fit is the memory management: These co-processors
sometimes need shared memory buffers to e.g. send syslog messages.
They always request these buffers with an IPC message but then there are
different possibilities:

	- For some processor the DMA API can just be used and an IOVA must be
	  sent back. For NVMe these buffers must additionally be allowed in this
	  SART address filter.
	- At least one other processor (SMC) does not request such buffers but
	  instead just sends a pointer into MMIO space and the buffer must be
	  accessed using readl/writel. This MMIO memory region is used for
	  both the common buffers (syslog etc.) and for the actual shared buffers
	  used for communication, such that the resource would have to be shared
	  across drivers.
	- And yet another coprocessor (for the display controller) requests some
	  buffers with an already existing IOVA that than need to be mapped
	  specifically inside the IOMMU.

Each of these co-processors also provides a single function and most
of them don't even have different endpoints. And even those that do (DCP) will
just become a single driver since all those endpoints are very much related.

While it's not impossible to do all that by extending and forcing this into the
mailbox framework at lest I think that it doesn't fit very well and would just
create unneccesarry impedance.


Best,


Sven

