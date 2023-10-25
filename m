Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115E5C0032E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w7RyCQrB+zKd7hfiqxDJtnBR45Rjfb60bVn4zJQUjfU=; b=I+LbimRUAEJrHLPL9TLPV/N+em
	A8WSNdrTxvZ64vHreEey5kJxm/pV8gxsp8OHCNx9Y/rMfFicE3Tzd6eNgDdQ0O8SvjVvhF5aUA3wk
	EZ85Bxz2fY6xLCNynh4ym1TDHpiW37IggZtwonBRQrgIpD/PqwFpCDqt8r9U4vQck/th2duiLzy7X
	bLVyF2bFK/mvyRbF0i8MTPOMSVvqIHZMrFLWZRK7hLO6d2p0jDQ+aVgpBeCpb1ULRMk5O2gRebmb5
	Z/CUlNe2YUWXKXg7L/alxPN0mqLDjCv9prGPWL/2VB6Vjei8B8HSfEYCg17lrSepQzesrhzg657RT
	HKrot3YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvfv3-00CdHK-2a;
	Wed, 25 Oct 2023 15:35:41 +0000
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvfv0-00CdGr-2g
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 15:35:40 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 3EEBF5C03AF;
	Wed, 25 Oct 2023 11:35:33 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 25 Oct 2023 11:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1698248133; x=1698334533; bh=w7
	RyCQrB+zKd7hfiqxDJtnBR45Rjfb60bVn4zJQUjfU=; b=GIpgeMUhg9m3RZex4l
	GTMyiJjarZkUJDl5qcBF/rrTN9YWR955hk7dEeNOYvp9BSG3DPKnR7bdqx7wF3ZJ
	KFNo5IhoRrM5JJrhL2E874yw53K71woZfwA2GH1VmMj/B1U/Wo3kZ6xenVP2XqDh
	VA20mFATi21BG7/z+KEGmIwLe2QSDcCoOaQmMAtZVx7EmylBoXmvBWmIpQOalU0W
	7BB7GtuTIjPAghFRkKto0buvfnVr8nj0ThqAXNUJ2jdHZPMjwSfRPHQms2KD2//q
	AgAKjHGfIYUuliRTL5vwOvl/r6GEuWKZZjiUpMdep4t0aIUxH9Ya0ulV1R4CxsJ9
	GwmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698248133; x=1698334533; bh=w7RyCQrB+zKd7
	hfiqxDJtnBR45Rjfb60bVn4zJQUjfU=; b=Aa9ayUgLFuUlP0eQC74pvjGWeSE+a
	yY/fRSnon0/RdSj5U99lWzUUTYhfN3G3xEYHBcCl/tWchx4oAp3colbBpRNcDYZV
	EPraJdgx9N7r0wx4BdKDbtBzDYHsm9DHG66PLN0ehpFWqlkMorfL+mt+XdMNMQqn
	dFyOyEMU+UWbAmNr2T4KAGV8DyLoIh3bZkHomxkbuTmpR8WtxG4kwzKal70I/zO2
	bf0hEl1rEqgzBEsZ9h37wOkyfDSNpga5lx5WoKcb7so1uqkcrYUqlIcSxsOf2hmr
	tSbSCV0DUJb7NnPKSCoMPPMqYhv9V7jVWYlr7kleiAFOVqL0GWio/UcVw==
X-ME-Sender: <xms:xDU5Ze7zyBtxzTjU5sFEV_4211XsqXlEzra9bMVhBtC7SqxeoOeXow>
    <xme:xDU5ZX7MFevbF8VuhFGR3pWRDg8SV3mQ34Q4318v5spnGXsQj7KuQmd-NinO1uOxV
    0LMNdgW8A-IO2deIY4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:xDU5ZdediW02RSB35rlk7asgYoKk5USDr5M7zIQn_r7Yzu4rNbKumQ>
    <xmx:xDU5ZbLKfoDS-JrF9q3ZgpPK6n9bx5uIAEMdx2jEYz9_YxgzaRLbFg>
    <xmx:xDU5ZSL-cxSCi4hpNtQp2Jxgq7re3O1OOl0MbJYXL-FyFybKXlVY3Q>
    <xmx:xTU5ZZXtf0PWcjpS6mS0UP0zUKc21VHza2GGU8m0Ivkpy-vvPMJ0Lw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7C494B6008D; Wed, 25 Oct 2023 11:35:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <8fad2dc6-3c1a-40c6-8067-ed9bb8ad7532@app.fastmail.com>
In-Reply-To: <08007889-a2ed-4d71-8eb2-4731fd012f7f@suse.de>
References: <20231025081253.113738-1-hare@suse.de>
 <20231025081253.113738-3-hare@suse.de>
 <2d945ecf-6313-488e-bed4-26d87df0f61e@app.fastmail.com>
 <4591215b-6ffa-4a74-8966-3ad0a3b9c239@suse.de>
 <24b5d8da-3804-4761-b480-69f1b5577fc0@app.fastmail.com>
 <08007889-a2ed-4d71-8eb2-4731fd012f7f@suse.de>
Date: Wed, 25 Oct 2023 17:35:12 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hannes Reinecke" <hare@suse.de>, "Christoph Hellwig" <hch@lst.de>
Cc: "Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_083539_135761_5F814DBD 
X-CRM114-Status: GOOD (  13.72  )
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

On Wed, Oct 25, 2023, at 17:00, Hannes Reinecke wrote:
> On 10/25/23 14:16, Arnd Bergmann wrote:
>> On Wed, Oct 25, 2023, at 11:11, Hannes Reinecke wrote:
>>> On 10/25/23 10:20, Arnd Bergmann wrote:
>
> 'IS_REACHABLE' is the keyword here; if we use that in nvme-keyring.h
> things are resolved.
>
> Will be sending an updated patch.

Please don't use IS_REACHABLE(), it's almost never the right
solution, even if it avoids this particular build failure,
it tends to cause hard to debug problems when features that
are enabled as modules end up not working correctly.

I still think my original patch or a variation of it is
the best option since it keys the usage of the module
directly on whether the caller actually wants to use it.

Another option would be to use Kconfig or Makefile logic
to force it to be built-in if at least one of the two
callers is built-in and at least one of them tries to
use it.

     Arnd

