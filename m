Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C9DC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 16:00:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC9D6108E
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 16:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7DC9D6108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=svenpeter.dev
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+9okPNCY7c0iPL46QaHcJMhQKUbnJf17L10cc5EA9z8=; b=m+m1ICJuEMSATD
	zkwEF6WgjeYyubS2LlB4BMPYn/TWo3JpmMbDUOQuqxkjQHJhrapjUYgY55PcbBgcb6kpCkDzpF4Gg
	uSztJR11rHJ92yPjOB8bULvD95XXTSbeePFVQNWh8bROeDbNG3B/PF97ZEm+zZZDC9LTzuUr6fcnW
	w5TSqVg0qoacnOUVMdLyEzJ11AHkUpvsstNz6Lhn7bJvrPoH5I8nJLLsEcKtXdz9rM2Jkacc6MIZI
	/t+5gU4/Stna3w0oUEx7u+qaDBV0RSkRIRt24cZkvpxH8QPZzfBaN5LTkQdCw9gRCrv41TwurCdUz
	2HKgNNKw6KhjMiv/ulpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUt32-003IUZ-RI; Mon, 27 Sep 2021 16:00:08 +0000
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUt30-003ITb-4x
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 16:00:07 +0000
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 294B35C00CA;
 Mon, 27 Sep 2021 12:00:03 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Mon, 27 Sep 2021 12:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=eh67QKmwClsy9IbTfPVdRQKHeIBl
 iV9TgpWJWy117KM=; b=K5CtSsMuBalnM6897s2eWHVH9+hZcDmaCXhYWOHPxRRG
 hG5CybuXTAIOPbaWS+Jryw1bah/jpa9UUPzGp5Vnu56I948lGsZn/zYUFT9ppky2
 K656rntCxEuGqbl+4affBOynqoM/rhxpdvue8LXAouC3/TH6keZ3Mp/8umTE6mfy
 LP0kDYweLMUomZFliYQRPSkIbTvWNHq7Kyt7kLpBU7Usq/DYC9pjvUR9zs8g+rfB
 39+Y4PfNT9VuJxCNq9M+Nxb85faJKbL59yWr1bmJ1yVDAeiKmCN3t1S4X5TPSOTg
 EmzRk54G5XvIc0CV0FwyTfQ2rzhIwJXiebpl2I7Hug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=eh67QK
 mwClsy9IbTfPVdRQKHeIBliV9TgpWJWy117KM=; b=kyA9yX+AEkSljXFw9pRcxE
 UHbrB1t6fKm/QXy2Poa4DXkGxuAOB0jIjEIfqlvJQZZpC5mMPTHSBpB6oQ8LDdkL
 UZT4eVVCUYXk0vDp9nt75y73E44g7kcBXECJB4yw0Inyc3TUeR8WB27S0hdeIgnk
 dRyM6nU26lFwNeKnaxjbjO3BAE+RBsu2+uNeNcsxAsu1EbisnOSozc/7BE1HNQZf
 xLnwLDqPU812yrbwoZ1BZuaNd4eTsRda83bS1zK0KizunOxNXJOR3gQPnaASa+2I
 kqq+oE2X4+gsaIvcocs0QmebB4lcFflMsRwATDrSq8cSwWs8RgInEqa3QejC8cig
 ==
X-ME-Sender: <xms:gupRYVT7mbB1KpWpLfvV9MDC1IAb1-T0Lc_pf9ZB7hMo2zyanvg7xQ>
 <xme:gupRYeyWw1pgTVtF5Bmt24gbjxybhrR6WGOC65e3vkKDKql45vIwpp5ibN57pWTiE
 WrEdrmbCUE5Vyz-Y-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejkedgleefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpeevvdegveduvdevvdfgleefgeeivdegheeiuedtleevvdeiveevleejfeev
 tdelheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdgu
 vghv
X-ME-Proxy: <xmx:g-pRYa2izx8oz269K0ptP8BtFb83UgSimjKy1ZSBE3i7_b4OSQCvwA>
 <xmx:g-pRYdAd71ku9TzKiPFWFZuA_MHkMn2r5sWwikC8BXsp1qq1aLMIoA>
 <xmx:g-pRYehVnDf1J45dhJ5pHifrMaPjhOX22RRRHnuReg7VmxLzjMHniQ>
 <xmx:g-pRYQYmFX7JxWafUYA75r0__EwdLFfdXmxSwE9CjchbVf6-M8MuYA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id DC14651C0062; Mon, 27 Sep 2021 12:00:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <df160284-55cb-4642-abc5-65f6aa61b48d@www.fastmail.com>
In-Reply-To: <20210927154306.387437-1-kbusch@kernel.org>
References: <20210927154306.387437-1-kbusch@kernel.org>
Date: Mon, 27 Sep 2021 17:59:40 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Keith Busch" <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk,
 "Orlando Chamberlain" <redecorating@protonmail.com>,
 "Aditya Garg" <gargaditya08@live.com>
Subject: Re: [PATCHv2] nvme: add command id quirk for apple controllers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_090006_363288_C3E0E807 
X-CRM114-Status: GOOD (  12.81  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On Mon, Sep 27, 2021, at 17:43, Keith Busch wrote:
> Some apple controllers use the command id as an index to implementation
> specific data structures and will fail if the value is out of bounds.
> The nvme driver's recently introduced command sequence number breaks
> this controller.
>
> Provide a quirk so these spec incompliant controllers can function as
> before. The driver will not have the ability to detect bad completions
> when this quirk is used, but we weren't previously checking this anyway.
>
> The quirk bit was selected so that it can readily apply to stable.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=214509
> Cc: Sven Peter <sven@svenpeter.dev>
> Reported-by: Orlando Chamberlain <redecorating@protonmail.com>
> Reported-by: Aditya Garg <gargaditya08@live.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2: fixed logical bug checking the quirk setting
>
>  drivers/nvme/host/core.c | 4 +++-
>  drivers/nvme/host/nvme.h | 6 ++++++
>  drivers/nvme/host/pci.c  | 3 ++-
>  3 files changed, 11 insertions(+), 2 deletions(-)

Looks good to me, on the M1 with my out-of-tree driver:

Tested-by: Sven Peter <sven@svenpeter.dev>



Thanks,


Sven

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
