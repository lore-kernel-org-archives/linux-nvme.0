Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D344ECAC592
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Sep 2025 16:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5L1JR98KhQBQKrvqju9ZiQ8N8qn4BbPPDuCBRBMhO9U=; b=FVEatJ3oT719ji+0/OwQFL3qIx
	51nyrSL8TGMPIYWAUL8pLTJW6Xyg/u+Rtxd44gu3QTNy9ardpsBwTvH2E4TcKuH1t76k+MvXh6Bod
	NMt8ZXZ4pcs42JEpNPZZe98IydhtMrvWNrBFazlpEKx3L4g8HFo3e6h8PSwTpwkD9mQv+Aqp3vPNq
	2dEi93Rr7G4dElsgK14WWyKFxNz+zOdBkdoOMLCM4EI5pmOo7AX2DHtsgFxZfOvKiYFotHoO2jog/
	+4MgDTMmsHUjs9xMf/xNUkUmilsg8XfiRbv3J682Kioc5+Cyu0rUAzVsd8+o7kuHShlDSKQzUQOUm
	FQizhekw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyYNo-00000008Qbt-1Jep;
	Tue, 16 Sep 2025 16:18:20 +0000
Received: from flow-a6-smtp.messagingengine.com ([103.168.172.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxpUD-00000001pjb-3H5i;
	Sun, 14 Sep 2025 16:21:59 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 11FD5138019E;
	Sun, 14 Sep 2025 12:21:54 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-01.internal (MEProxy); Sun, 14 Sep 2025 12:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757866914;
	 x=1757874114; bh=5L1JR98KhQBQKrvqju9ZiQ8N8qn4BbPPDuCBRBMhO9U=; b=
	bJ1q2JvWkIk0NIcxydDTdd8+j9Tb4GuITrEkcd9faxSkZ8ToQOisYTEzWJ9b6PZe
	athKO1Sdg+5MOch+GH5S++STeGIbmLAxTEg2AgotYTf7uUWHaH5/tZ1JiYuwuTjP
	C5vnUCZ+Bf2xXCspnh1zp8taziT95AFcGU2w8yFgzgusgqHcXATlXQdxHDm2rtuJ
	qDRaljpET3W+weSGlJlfj1PaF9pJuVGYCf2UYIt4swXlLgd66dn3YCLofgSOnOKq
	pHmD7IixcxO7UuxdRF4J9cGAah50kj8zZsdsC+BW8+UZRqd5jxP6UiNvqOUCoK9F
	mXcb9dZJJ1DtESLxjxD2Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757866914; x=
	1757874114; bh=5L1JR98KhQBQKrvqju9ZiQ8N8qn4BbPPDuCBRBMhO9U=; b=k
	zyqFMlcebJzXiPky0VsUjhsrWWaCvbhPEK468gUpGfEkqF6Z2nsCLSjbAusIC5Jc
	+e5SzLU6Phf/bjp6drAsjKuDH9KXT7nwXh9ih+QGU3WWtpY7O4kxGEnno1ByCCiB
	3xOw0FzVndmez1csKeQ3PXZ8cjUbfVKmMcnWbaupdNZigDLyqtprNwFg6rZH2hJ6
	KDgIJ9VaYFW2QHysHntIcZLIR0qGlOhROmsmDFyqGqWcd5Iw10a2TmDaCCo40pjb
	Ozzfd2RU5/7tgvFiaLFxSq3XOyTX+ySSM/Q7A/0tY45lFGiPqrkLbX0zc3stHpUB
	LxVPocnSDYKxNxptRDCBg==
X-ME-Sender: <xms:n-vGaMEarOrxDaVNWWp-jyJOxkbiSSTX4Fmris5E9LNfS8iiHB2HRQ>
    <xme:n-vGaFXmMtvqHbBlAhZMTNPX35pdPYytIp2bks_IEFfW3-XAIVfstCoia3Bsgqoy-
    vm1sOQqjfBquiEDdRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefhedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdflrghnnhgv
    ucfirhhunhgruhdfuceojhgrnhhnvgesjhgrnhhnrghurdhnvghtqeenucggtffrrghtth
    gvrhhnpeekleffhffhtdekffeiueeuvdfgtdeuudfgudejjeehheekvdelkeejudelfeet
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjrg
    hnnhgvsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohephedtpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhgpdhrtghpthhtoh
    eprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtohepmhhtuhhrqhhu
    vghtthgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopegrrhgvnhgusegsrhhorg
    gutghomhdrtghomhdprhgtphhtthhopehpohhvihhkodhlihhnsegtuhhtvggsihhtrdho
    rhhgpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopegrih
    hrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhhnkhhlrdhkvghrnhgvlhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehjrghsshhishhinhhghhgsrhgrrhesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:n-vGaA8vvKhEjJGsRgVJWSC4cO3kFPDGXl7UHgZx8-jp_Njcn06hZg>
    <xmx:n-vGaCCw7oB_Hq0ssQvOi210oN8xeqhc3RTAKNt-ubb9mUdzx6P94A>
    <xmx:n-vGaEwI2-MvkhH9dH9OCSao63tgjvYafnih6dMctjf5AAN83DMyNQ>
    <xmx:n-vGaLcgpFnezVQKMumizyIYgSEnaJmdEUG82tQupvpFYT4tJAAO0w>
    <xmx:ouvGaIWX0Yyyd0rLpmPqqTqvL4nS4oP2CF26ntoYAbpQLccPZb-XjsUM>
Feedback-ID: i449149f6:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 875863020073; Sun, 14 Sep 2025 12:21:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AgUUmYTZniXg
Date: Sun, 14 Sep 2025 18:21:31 +0200
From: "Janne Grunau" <janne@jannau.net>
To: "Sven Peter" <sven@kernel.org>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Neal Gompa" <neal@gompa.dev>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Hector Martin" <marcan@marcan.st>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Joerg Roedel" <joro@8bytes.org>,
 "Will Deacon" <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Mark Kettenis" <kettenis@openbsd.org>,
 "Andi Shyti" <andi.shyti@kernel.org>,
 "Jassi Brar" <jassisinghbrar@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Sasha Finkelstein" <fnkl.kernel@gmail.com>,
 "Marcel Holtmann" <marcel@holtmann.org>,
 "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "van Spriel" <arend@broadcom.com>, "Lee Jones" <lee@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 "Stephen Boyd" <sboyd@kernel.org>,
 "Wim Van Sebroeck" <wim@linux-watchdog.org>,
 "Guenter Roeck" <linux@roeck-us.net>,
 "Michael Turquette" <mturquette@baylibre.com>,
 =?UTF-8?Q?Martin_Povi=C3=85=C2=A1er?= <povik+lin@cutebit.org>,
 "Vinod Koul" <vkoul@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>,
 "Mark Brown" <broonie@kernel.org>, "Marc Zyngier" <maz@kernel.org>,
 "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Janne Grunau" <j@jannau.net>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-clk@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-nvme@lists.infradead.org
Message-Id: <175786548036.4027671.17732393166265974160.b4-ty@jananu.net>
In-Reply-To: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
Subject: Re: (subset) [PATCH 00/37] arm64: Add initial device trees for Apple M2
 Pro/Max/Ultra devices
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250914_092157_894687_234A5ECA 
X-CRM114-Status: UNSURE (   6.75  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 16 Sep 2025 09:18:17 -0700
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


On Thu, 28 Aug 2025 16:01:19 +0200, Janne Grunau wrote:
> This series adds device trees for Apple's M2 Pro, Max and Ultra based
> devices. The M2 Pro (t6020), M2 Max (t6021) and M2 Ultra (t6022) SoCs
> follow design of the t600x family so copy the structure of SoC *.dtsi
> files.
> 
> t6020 is a cut-down version of t6021, so the former just includes the
> latter and disables the missing bits.
> 
> [...]

Applied, thanks!

[02/37] dt-bindings: arm: apple: apple,pmgr: Add t6020-pmgr compatible
        commit: 27ac175609b31853a336917f9596024589989d4c
[04/37] dt-bindings: power: apple,pmgr-pwrstate: Add t6020 compatible
        commit: 9ee3fa4f1dd03ba24be886fcde82286b38378121
[05/37] dt-bindings: cpufreq: apple,cluster-cpufreq: Add t6020 compatible
        commit: 46d7b4c16ee7afc67e21c1044d22ec197e5a3498
[06/37] dt-bindings: interrupt-controller: apple,aic2: Add apple,t6020-aic compatible
        commit: d45bed97401a3b76c968ec08f0292220e32ab852
[07/37] dt-bindings: iommu: dart: Add apple,t6020-dart compatible
        commit: d248111a13852e9823300060f07fefce3ccf3c2a
[08/37] pinctrl: apple: Add "apple,t8103-pinctrl" as compatible
        commit: 100896ab413284dcf77340c114bafffb96f6fd14
[09/37] dt-bindings: pinctrl: apple,pinctrl: Add apple,t6020-pinctrl compatible
        commit: 1b70bfcc576eb8007c003f285c5834ec7cf1beba
[11/37] dt-bindings: mailbox: apple,mailbox: Add t6020 compatible
        commit: b4958f928e0d587bd35318a72bdf6a8df8387933
[12/37] dt-bindings: gpu: apple,agx: Add agx-{g14s,g14c,g14d} compatibles
        commit: 49d7ce3ca93ea90110d334f4f8ce2f68a3536475
[13/37] dt-bindings: iommu: apple,sart: Add apple,t6020-sart compatible
        commit: a93d0de2403a8b1a1686665d5808e4d1d39d5b24
[15/37] dt-bindings: nvme: apple: Add apple,t6020-nvme-ans2 compatible
        commit: 1c9e6a0db3a86bf8f99981570f81e9fb1fa33d4a
[16/37] dt-bindings: net: bcm4377-bluetooth: Add BCM4388 compatible
        commit: 2ba11087d283d00c7a99b45672d564eb1de872dc
[17/37] dt-bindings: net: bcm4329-fmac: Add BCM4388 PCI compatible
        commit: b6b8d3ffaffacdb534c2fc151014b8e7ba382a94
[19/37] dt-bindings: mfd: apple,smc: Add t6020-smc compatible
        commit: 306632217c123ef23c917c7348c32ad29599ba15
[22/37] dt-bindings: spmi: apple,spmi: Add t6020-spmi compatible
        commit: 155eb6a9838776bd217e8942e5074e3b4bdcb5ff
[24/37] dt-bindings: watchdog: apple,wdt: Add t6020-wdt compatible
        commit: bb7a2260fea3f637afafecaae9478c93211f9e8f
[26/37] dt-bindings: clock: apple,nco: Add t6020-nco compatible
        commit: c7c5be895e32299f38035b6c05fa68a7d5c57a50
[28/37] dt-bindings: dma: apple,admac: Add t6020-admac compatible
        commit: a90183490c54bf793cabb5b54b30cc40b24ce129
[30/37] ASoC: dt-bindings: apple,mca: Add t6020-mca compatible
        commit: ae45b991c9f76e8988b7d3bb4b39e4b7c73dceb7
[29/37] ASoC: apple: mca: Add "apple,t8103-mca" compatible
        commit: 186b1b4b5b3d40ea53d739aa025c3a9f8cb37f4c

Best regards,
-- 
Janne Grunau <j@jananu.net>

