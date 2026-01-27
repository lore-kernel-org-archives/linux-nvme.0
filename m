Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8C0D2FECD
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jan 2026 18:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AyKrjyVPXWPvN9Dy9yAystIxEok0XJWlQy6De7Xg9xE=; b=1t3fKm6cPtxql7j/ZF3ccsp7MK
	fGv9KwB2JKX7EnSTgJplLukARtxYMXySM6sf3tacQlAOm2R7Yq5BKFWi0pwraFvE0VYADcR2ftePr
	90f0G9heU6NY0BadHpKXmQ86nZGzmNedosX1tIY9EFxhc6waf2MIN+T66r0HM+qBZ2JXOqygX/1/Y
	y27aev5wBR6lgCEQhCwmPdL/LJ7/QxLec4Q5mDbORHPgauik06ri9vHRj5InuZorv0CfZUos4YYmN
	kWNCtwqPhBX4yM41BRV9+krAIBGaPdKaOWIsHiV2/7ZNzzx8aMl4zaOMe9zJvhSNX9/3NVhdvvHuZ
	ncIBnDtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vknNF-0000000Elpv-1VNA;
	Tue, 27 Jan 2026 18:01:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vknNC-0000000ElpP-2XgN
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jan 2026 18:01:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ED1F1441D8;
	Tue, 27 Jan 2026 18:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC5EC116D0;
	Tue, 27 Jan 2026 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769536863;
	bh=tqCb+IWB4MsBS7ovL5icGy7qPouGgQ/bm47XGcZO4os=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NAv6QXrg7JTSley7H5mdv+XqUfO6Co5e2uzOAtjNwU4xk2KMAz28AI+9OFLGmu99l
	 kiArOilj7PVx4Kup+zw6pOxuj3o1T8mki62izC2KmIO1Ow0l45VAwfMtHzs1Se1LJQ
	 eqhArCty4Aupa7vtJir/POgO/ZV24wvmYZ2BB9M5srKPeZCVaTR9f3x0XLNpowzb30
	 LwOhRy/IRACaQPq9niOhaGyUHJlS1eRzkP7jb2FEMXW1c3OF19CnbEKEiiJOpsEyN9
	 Eb9t60aMvJldOjMzuqai7OkiCdDDIzUmyvzaw7rU+phdlyu/lqVlX8du3H+P3fV8dr
	 +nAxVbWRqSzwQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 72664F40086;
	Tue, 27 Jan 2026 13:01:02 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-04.internal (MEProxy); Tue, 27 Jan 2026 13:01:02 -0500
X-ME-Sender: <xms:Xv14abNU1POE5048UBPILOtqdqYyZ0NmB0Bi5goycRViJpusbg4Vvw>
    <xme:Xv14aQy2E8Bf8s1OrSild0R3o2e9pLk27AkFcZH5vCbzC-MinAly8IRr95ZTvTqSs
    R-CKGQh7DKDjcqdO18qPPJoPwU3tdiA77n4TiQ4rrEt1QbaAHJSSP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfnfgvohhn
    ucftohhmrghnohhvshhkhidfuceolhgvohhnsehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepjeevffelgfelvdfgvedvteelhefhvdffheegffekveelieevfeejteei
    leeuuedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eplhgvohhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdeftdehfeel
    keegqddvjeejleejjedvkedqlhgvohhnpeepkhgvrhhnvghlrdhorhhgsehlvghonhdrnh
    hupdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    sghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehsrghgihesghhrih
    hmsggvrhhgrdhmvgdprhgtphhtthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghp
    thhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehguhgrnhhghh
    huihhfvghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehkrghn
    ihgvsehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepohhlihhvvghrrd
    ihrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehqihhnhihu
    nhhtrghnsehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepgihlphgrnh
    hgsehlihhnuhigrdgrlhhisggrsggrrdgtohhm
X-ME-Proxy: <xmx:Xv14aUL2213F47XAMXuqXEWs1XsYMexQgEuXdseiY2vMzrvdRtpvfw>
    <xmx:Xv14aZVtPwdF_XSh5KtzwXdX6BXhjB2noMmaukrXIO0u9tHDwvAbAA>
    <xmx:Xv14aYEOPG3mvC_RMdoSLeOHSIr1i8usap3m8kRnt12L84cf88Bkiw>
    <xmx:Xv14aQ5SpFJGQX8zHawGI88mtpe30ApxnOLVcyjQyq4hOsBtvYc9Ug>
    <xmx:Xv14aWcXE331QFHDhThfCIcGT8kknzAU7eeUz3BhPyEJAh92Td_2sMgF>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4E9482CE0072; Tue, 27 Jan 2026 13:01:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: ANHFfUoI4SCB
Date: Tue, 27 Jan 2026 20:00:42 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Christoph Hellwig" <hch@lst.de>,
 "Qinyun Tan" <qinyuntan@linux.alibaba.com>, "Jens Axboe" <axboe@kernel.dk>,
 "Sagi Grimberg" <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 "Xunlei Pang" <xlpang@linux.alibaba.com>,
 "Guixin Liu" <kanie@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
 "Guanghui Feng" <guanghuifeng@linux.alibaba.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org
Message-Id: <197d75a2-4286-41fb-ab4f-9ad744885bb4@app.fastmail.com>
In-Reply-To: <aXjin6e18UxcTpQz@kbusch-mbp>
References: <20260127073344.2489873-1-qinyuntan@linux.alibaba.com>
 <20260127084807.GA342@lst.de> <20260127143143.GW13967@unreal>
 <aXjin6e18UxcTpQz@kbusch-mbp>
Subject: Re: [PATCH V1] nvme-pci: disable SR-IOV VFs on driver unbind
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_100106_691469_5AFC5E2F 
X-CRM114-Status: GOOD (  13.84  )
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



On Tue, Jan 27, 2026, at 18:06, Keith Busch wrote:
> On Tue, Jan 27, 2026 at 04:31:43PM +0200, Leon Romanovsky wrote:
>> On Tue, Jan 27, 2026 at 09:48:07AM +0100, Christoph Hellwig wrote:
>> > On Tue, Jan 27, 2026 at 03:33:44PM +0800, Qinyun Tan wrote:
>> > > The NVMe PCI driver exports the sriov_configure callback via
>> > > pci_sriov_configure_simple(), which allows userspace to enable SR-IOV
>> > > VFs through sysfs. However, when the PF driver is unbound, the driver
>> > > does not disable SR-IOV, leaving VFs orphaned in the system.
>> > 
>> > That sounds dangerous.
>> 
>> It is not. In a real SR-IOV device, VFs are created by the hardware and
>> are independent of their PF. There are several use cases where an
>> operator unbinds the PF and reuses it to improve overall device
>> utilization.
>
> If this is expected, should the warn message "driver left SR-IOV enabled
> after remove" be downgraded to 'info' level?

It is not important, no one complained about it. People who unbind PF, simply ignore this warning.

BTW, the use case which I presented is for SR-IOV handled by drivers. Maybe VFs created by NVMe are different here and they must be destroyed.

Thanks 

