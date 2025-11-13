Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101C4CD98D0
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 20:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R3yi+cLMsc/L6sR5rN3U9sVi/JaSUtT0gxwfSLY7z+8=; b=OY2bZgP+cJSNKVoWIlRzUnrn+g
	6uobcdJQ/DdKC7xQprh62iQLeszV2nD/c2cktHsIIYbHcfiLZOx8PAS1ssz2z1kPT90FDaxEucsms
	OX1HjowL4B0S7ee7k+dS0EOZD4DEEXDluNtuOfhjux9iRzHClT66fMUqyWy6KpfvfZCgiJCBqAkHh
	/Qe3AjEf5qvc984Q1Uk20nDNsB+hODHIp3UHQHoCiDEBNwzZHHyB4MRsH4qS7sBiSZl4MpYVsflaH
	cssAHxl4dzu6KP1BTOYH4STQREGprQwEhVrmVW5p7AAlx/7AhBaXEtOHYJMOqNTBhFg36XO1+C94u
	ItvKYnug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJdhN-0000000B4JX-2Q12;
	Thu, 13 Nov 2025 20:13:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJdhL-0000000B4JF-0szb
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 20:13:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C4C7343B5C
	for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 20:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78623C4CEF5;
	Thu, 13 Nov 2025 20:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763064817;
	bh=R3yi+cLMsc/L6sR5rN3U9sVi/JaSUtT0gxwfSLY7z+8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MM9a8K+C2agMp+gYd55xxl0uRpc/VDT53ay/Ie4CGKDi3pLKYGnZ4pOyu+HyWLf7e
	 /qNVLeF4SIowLXNMdHILC140sSygao38VmaQh1HWFNJhrdd87eT+ZO6Rl6jcT/YUa9
	 iYOiHr4ZPWXwd5kMmt/DowCDjevoF4hsWclCVRa58jO7dhWRS/PSYqmKRMWg0tqJQN
	 Qv3mH7VTUH8phRmBXeMmv1aW6Pltrorb9r4PeV16vpAwLtO36+lcvEgPvG8cO7IqOK
	 lDbGUzn6Y4VEzpWRLljjlB4XvYeUvg36Bc2k8Syism+MKlvE4V8sffXSKhZfAGXa8k
	 Wb9tDmK79LcbQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9B937F40078;
	Thu, 13 Nov 2025 15:13:36 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-04.internal (MEProxy); Thu, 13 Nov 2025 15:13:36 -0500
X-ME-Sender: <xms:8DsWabLpHErX5_FxkX26uPnf_E4VqNMGjHBXt23VH6JmN9Rf6CQqMQ>
    <xme:8DsWaZ9A7C8g4QT56wYvRZ_dHN9HnPDTd-0aSze-YUqhE6_56QlEQMM-AW8rXsMxe
    AS207WZ9EOL2dG7c2zxW_6AAvykADk3smAjLKaWHO5gikrYH4Xs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfnfgvohhn
    ucftohhmrghnohhvshhkhidfuceolhgvohhnsehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepjeevffelgfelvdfgvedvteelhefhvdffheegffekveelieevfeejteei
    leeuuedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eplhgvohhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdeftdehfeel
    keegqddvjeejleejjedvkedqlhgvohhnpeepkhgvrhhnvghlrdhorhhgsehlvghonhdrnh
    hupdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehs
    rghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopegrgigsohgvsehkvghrnhgvlh
    drughkpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhnvhhmvgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtph
    htthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehlihhnuhigqdgslhhotghksehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8DsWaYCitHph3b6ZiMTFx3ZcBcEe49wdStjLVOZ-GSMxVIyCgJODEw>
    <xmx:8DsWaXfudOpE5Z5fKbcvMDAO96mfLGejjqQRgPYmhzKFGrHYFsbrBQ>
    <xmx:8DsWaXOQpV52RhRmcpBDxzFURalbL1PeEkiC_sA76UerqHCAjuaqug>
    <xmx:8DsWaXJhiBiYJXEapqMynX2DwPEI7mL7_GWe5RBNKD2WYcV4Per5Pw>
    <xmx:8DsWaXLnbYtNaBAmi3Dwrs77dzp0Hw8oMhalS_098UsWnTXB-NAzwEol>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 67D4C2CE0067; Thu, 13 Nov 2025 15:13:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AaNBfhOYEQos
Date: Thu, 13 Nov 2025 22:13:16 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Message-Id: <c745d717-fcd5-48a5-b640-af5697be6049@app.fastmail.com>
In-Reply-To: <aRY5nCvNnQk4mMCT@kbusch-mbp>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
 <20251113195008.GA111768@unreal> <aRY5nCvNnQk4mMCT@kbusch-mbp>
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P DMA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_121339_293583_49415DF2 
X-CRM114-Status: UNSURE (   8.58  )
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



On Thu, Nov 13, 2025, at 22:03, Keith Busch wrote:
> On Thu, Nov 13, 2025 at 09:50:08PM +0200, Leon Romanovsky wrote:
>> Can you please squash this fixup instead?
>
> I think you should change pci_p2pdma_state() to always initialize the
> map type instead of making the caller do it.

Yes, i just was afraid to add another subsystem into the mix.

