Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6790C5AD4C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Nov 2023 06:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/6WiKh+BjmdjXgEeTZ2JO9etMpJThQQYsX1jFQdOsOo=; b=CJ3MGxRbyZYnngGc1iDbSrDEhV
	xuKfhyNRKxABXO+DYsfdmQ5iNV9u3y0ltFD+V3/AX88p/KjKjguaRoxhahdkvi6ZLTy2GpYEi7Nkh
	RDQEbYZS4/VJDFg2ghw+Oer5vIdAY1m+SQNmxTv4b+cJ4wtC8y8Ve6qHzjsXYX5H00WgnaRR3L808
	BJGTye2/8HCIx8mf053YR9RBzMxe0ltVT26xXin6dUuSSToc77wGf5wQFbiiw5b9/+wO223qMDu2/
	ImY+K9ERtVYlh1OLUI5VfJA+x88lHyVq1T858QvVmhKGBDZB3THxZpqkV4ukDosdY/lPpNELl/NSb
	jT44K66Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r639r-003tlU-16;
	Thu, 23 Nov 2023 06:25:51 +0000
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r639o-003tjP-19
	for linux-nvme@lists.infradead.org;
	Thu, 23 Nov 2023 06:25:50 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id ED13A5C0162;
	Thu, 23 Nov 2023 01:25:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 23 Nov 2023 01:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1700720740; x=1700807140; bh=/6
	WiKh+BjmdjXgEeTZ2JO9etMpJThQQYsX1jFQdOsOo=; b=4hrkdbgSg3UCa9qwM3
	q/pxx10fKttOlC11umZccw6vL+w7As257e9kAF9zbTxjSl+TsUFK881HwT91dt+K
	Ferxb4dxDOQrhJyH6yesSDN69VLZWO+grxZhfbXO39sIQrHh3iKcLtnSEuFlNqqG
	tEB5q06UxsU+z/+doVhO79DiRFHWe41BbPtgH6Tj/dclh5d2cSllQ4K3Q/L7J4Yj
	D4lgjHEfgS8qFCL/g+JwRYyz+uUswcay5DPrPcTdfA2t2+aXCpg0TFV82H/6Gi1R
	3ZOAtH9mZDzsMJkC83E44ZVBlYloqZ7jUpJFo/BzsR5jV/95lzUjfEh9sgPQsY4Y
	9I2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700720740; x=1700807140; bh=/6WiKh+BjmdjX
	gEeTZ2JO9etMpJThQQYsX1jFQdOsOo=; b=fjWeuEwEa+pCOU5mE/9NDjRE2Da/e
	J5Rn+G5bg+QmDQoab3/1IZtKa9R+c3d5PT6vUF6WXAIYwUP0FV9GcmoyE4HYtzgM
	M4muRjbNnQB/8obisWZO8Rfp+ACAsQqeWInPCZ+Zq3oa1IU9rFLR0uhhTLKyGx4E
	Wf56VsNBXeL4xYM/bQy4L2qRGOxMqfKiZUIddMtWwuiaNSnL3ENzH5lVb2R9EhHW
	S0g3WtfTD1MI3J4YMFHoVL2esNslDDodwYAvDn5e/Iyg5WjXbvYX8LmZpFkhQez0
	nZMB7lJ/9Mt+jlfkAoRnD0kNuSFap3+PMe8yZUzDzwtwnwjXfYrxpuUSQ==
X-ME-Sender: <xms:ZPBeZffSV2Tsn9FnExJq4DEqDLZuSexON6Bu7CfX_33uQC8N7Oh-UQ>
    <xme:ZPBeZVPZmJbMIY5ThGYVdUU2PvXjhZQSt-Nuq1Zg-kRKqvgfYbcNA4mI5XmD31Q1w
    gCjqWLbK5-XMdT7VmE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehvddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ZPBeZYhyObxWcSetOpSyArW4zgov8PrcQ4q7v66qrREMPT1OHaSxqw>
    <xmx:ZPBeZQ9gn4tRp0Ce7IHahAHWDbKL7mJfpHvjOIaycYlpAK3H36jD2w>
    <xmx:ZPBeZbskQW8-rR8bnl-wR-LdwGLAgThSyWZQp1OZxUnIcpmg07CGXA>
    <xmx:ZPBeZRUEbXz7S3I0scUZzeHzmkSu1BDpTcVOdo2lLoK2ujW2tQ5axA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 66535B60089; Thu, 23 Nov 2023 01:25:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <a9ef56fa-725f-4d18-b408-ce0ba13c2d6e@app.fastmail.com>
In-Reply-To: <ca200ed6-a70e-401e-b862-f690368e0266@kernel.dk>
References: <20231122224719.4042108-1-arnd@kernel.org>
 <ca200ed6-a70e-401e-b862-f690368e0266@kernel.dk>
Date: Thu, 23 Nov 2023 07:25:13 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jens Axboe" <axboe@kernel.dk>, "Arnd Bergmann" <arnd@kernel.org>,
 linux-nvme@lists.infradead.org
Cc: "Keith Busch" <kbusch@kernel.org>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, "Chaitanya Kulkarni" <kch@nvidia.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] nvme link failure fixes
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_222548_840300_70AF5E1B 
X-CRM114-Status: GOOD (  14.50  )
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

On Thu, Nov 23, 2023, at 02:42, Jens Axboe wrote:
> On 11/22/23 3:47 PM, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> There are still a couple of link failures that I tried to address
>> with a previous patch. I've split up the missing bits into smaller
>> patches and tried to explain the bugs in more detail.
>> 
>> With these applied, randconfig builds work again. Please either
>> merge them or treat them as bug reports and find a different fix,
>> I won't do another version.
>
> Applied, but had to hand-apply hunk 9 of patch 3 due to a previous
> attempt at this:
>
> commit 23441536b63677cb2ed9b1637d8ca70315e44bd0
> Author: Hannes Reinecke <hare@suse.de>
> Date:   Tue Nov 14 14:18:21 2023 +0100
>
>     nvme-tcp: only evaluate 'tls' option if TLS is selected

Ok, thanks for merging my changes! The commit from Hannes
is what I had in my v1 for this, and it was a correct fix
as well, my patch 3/3 was just a more elaborate way to do
the same thing that I did since Hannes did not like my
version at first.

The 23441536b6 commit was not in linux-next yesterday, so
it looks like our patches crossed paths on the same day.

     Arnd

