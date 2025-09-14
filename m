Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65863CAC598
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Sep 2025 16:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tWnDpBVNIk8/6xOJajwpS5PW/ODB8z60GmMpvcHEyLY=; b=pzn4AYvFDUyzKpZFMd8U2rjwRy
	5la9U6nvbvHSW1jZ/ucTKX4GwfvKqX9MQ9N3d37+1rZin6mU8xQ7paIFkamBoV3icS/yNinwUnccY
	H2D5KLy+6Ysdnp75Hcw8sOL7+NsDTRESmOwi4gsnyh+zDQujHkgTbAJQSNu5RJYncXCr3uZObMGbx
	8EtQkCxAfm8J40VDAblNdb+9vK5Z1URdnh81a0XsDXjrzHQXzAPpOIVK1UsxuvPCucYcawvlitJtL
	ilpWUeUtgJvmihkat3O+VtEJe5sigBq7NwIN84f5l+iqA1hSaKTY66u/TR6lyxzML9FUlHOkz01vh
	mEIO210Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyYNn-00000008Qbk-46P7;
	Tue, 16 Sep 2025 16:18:19 +0000
Received: from flow-a5-smtp.messagingengine.com ([103.168.172.140])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxobW-00000001gXB-23ur;
	Sun, 14 Sep 2025 15:25:28 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 9FD391380371;
	Sun, 14 Sep 2025 11:25:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 14 Sep 2025 11:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757863524; x=1757870724; bh=tWnDpBVNIk
	8/6xOJajwpS5PW/ODB8z60GmMpvcHEyLY=; b=fqniaA4no7nBvtwisVO0EAziaY
	zEu1OxB2nmfd9hxQQ6FceNaEfgPI/uOeA3ZUMlixYSgDNmwiIjnghzegCeXC7ooM
	LvWC+S6IFuwyUZIiDef/lCWKT4qBsufKdFw30aP8oBZazgmYwz3BDB+ZmycSta6t
	xptfu7gQpOG7ehf9onSRjHDPp99xdgiS7wuPGm4N3NTF+9TI+D6pUYs4H+vp6SZw
	M5/GnUj+UjYiCszBHilRciH7Xg30wJ4oaajlksr0rV95z7TNExSNAABZPiumrshE
	FvdljC6vKY79xqhNPoz+sv/5ZzI32UEqoetagTR1nlRh8Hs/vE+pwru4KkFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757863524; x=1757870724; bh=tWnDpBVNIk8/6xOJajwpS5PW/ODB8z60GmM
	pvcHEyLY=; b=Vj23bhcyVMjkmI+SG5zcvx9xWXRofAidImGdIqDbcLHM0WUXLc8
	VdJ5/Ah1c+SQLupMy8hPB6g+eQtldDZoSyTcdvRRHeqbzvU0Cza12fMqqwBCwKIx
	XRXQG97RFEtAOSU5a+qagQeuIAZpU+z4/twkaZZ9fF8rbZYTKJJUunKkcHe13HsO
	taCZKYFvYUAnhVBpORJEKOyg2/M2EAShulAaGjcM8zm5gq5xLiBnzeFc2Kbds8Kl
	cjiBRbNIWFH6ATBWXfkEOIb9VhsgtBfbtq1YELEVGHuugIERRPgQ8SsFlhE1Cyyg
	dvlCSYfmupMutudH+yvoMkyjyO68z9vORGw==
X-ME-Sender: <xms:YN7GaCTuMx0f0t2jRi7MjfjequzWOeswX29HOTcvvGYGS0MYiIBHUg>
    <xme:YN7GaL6QBGhruZL6oRXxCEfZI4zo5kPWLdpjuyLcU_mz4EuO5tln9nxooV2UWTC9E
    tIpfL6jS9L3FfQQEuI>
X-ME-Received: <xmr:YN7GaLYUVdoEvMx6ZIn2invZ0We4bPduj51BqChNtRqO21phkH22Zsg10x0DzgL7UQBL86YCGWtRbrW6wbE3W7edo_aBudk-3-k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefhedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpeflrghnnhgvucfi
    rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfduue
    ffleefkeegueektdehkeejtedtffdtudejhfdvheetgfeigfeltdeufeejnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepieef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlih
    hnrghrohdrohhrghdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghlhihsshgrsehrohhsvghniiifvghighdrihhopdhrtghpthhtohepnhgvrg
    hlsehgohhmphgrrdguvghvpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtoh
    hnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhgtrghnsehmrghr
    tggrnhdrshhtpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YN7GaATZo9SilxufSz1EnUQzaOFsuTqisab9144SXip2OdtK6SNNLA>
    <xmx:YN7GaJKV9V5TpZEISgGyVcxs3hzxjRHlCRxpZ1ubu5AZbXZ1dg9h1Q>
    <xmx:YN7GaLtfn-mnCoeiXQaPsWDk9zzhoxZfBvlAx4p97b2D9kfTWnImVA>
    <xmx:YN7GaPJNXrp5QdJBPMY7CemSNwxQLBjHfnIQrKLxRmSJmLsfz5TGDQ>
    <xmx:ZN7GaF5XtQVAFSjVp-zByym9kYneBv_lXsjnvFHPMbeT2w1HFN8_DQfJ>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 11:25:19 -0400 (EDT)
Date: Sun, 14 Sep 2025 17:25:18 +0200
From: Janne Grunau <j@jannau.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,	Hector Martin <marcan@marcan.st>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,	Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,	Robin Murphy <robin.murphy@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Kettenis <kettenis@openbsd.org>,	Andi Shyti <andi.shyti@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	van Spriel <arend@broadcom.com>, Lee Jones <lee@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, iommu@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-bluetooth@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 00/37] arm64: Add initial device trees for Apple M2
 Pro/Max/Ultra devices
Message-ID: <20250914152518.GB1645557@robin.jannau.net>
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
 <CAPDyKFr3WO5nLXYWoyH13KirmfNU+sVrvhefuwC+GrpAgynBgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFr3WO5nLXYWoyH13KirmfNU+sVrvhefuwC+GrpAgynBgQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250914_082527_008285_ACF8633B 
X-CRM114-Status: GOOD (  36.90  )
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

On Thu, Sep 04, 2025 at 12:41:58PM +0200, Ulf Hansson wrote:
> On Thu, 28 Aug 2025 at 16:01, Janne Grunau <j@jannau.net> wrote:
> >
> > This series adds device trees for Apple's M2 Pro, Max and Ultra based
> > devices. The M2 Pro (t6020), M2 Max (t6021) and M2 Ultra (t6022) SoCs
> > follow design of the t600x family so copy the structure of SoC *.dtsi
> > files.
> >
> > t6020 is a cut-down version of t6021, so the former just includes the
> > latter and disables the missing bits.
> >
> > t6022 is two connected t6021 dies. The implementation seems to use
> > t6021 and disables blocks based on whether it is useful to carry
> > multiple instances. The disabled blocks are mostly on the second die.
> > MMIO addresses on the second die have a constant offset. The interrupt
> > controller is multi-die aware. This setup can be represented in the
> > device tree with two top level "soc" nodes. The MMIO offset is applied
> > via "ranges" and devices are included with preprocessor macros to make
> > the node labels unique and to specify the die number for the interrupt
> > definition.
> >
> > The devices itself are very similar to their M1 Pro, M1 Max and M1 Ultra
> > counterparts. The existing device templates are SoC agnostic so the new
> > devices can reuse them and include their t602{0,1,2}.dtsi file. The
> > minor differences in pinctrl and gpio numbers can be easily adjusted.
> >
> > With the t602x SoC family Apple introduced two new devices:
> >
> > The M2 Pro Mac mini is similar to the larger M1 and M2 Max Mac Studio. The
> > missing SDHCI card reader and two front USB3.1 type-c ports and their
> > internal USB hub can be easily deleted.
> >
> > The M2 Ultra Mac Pro (tower and rack-mount cases) differs from all other
> > devices but may share some bits with the M2 Ultra Mac Studio. The PCIe
> > implementation on the M2 Ultra in the Mac Pro differs slightly. Apple
> > calls the PCIe controller "apcie-ge" in their device tree. The
> > implementation seems to be mostly compatible with the base t6020 PCIe
> > controller. The main difference is that there is only a single port with
> > with 8 or 16 PCIe Gen4 lanes. These ports connect to a Microchip
> > Switchtec PCIe switch with 100 lanes to which all internal PCIe devices
> > and PCIe slots connect too.
> >
> > This series does not include PCIe support for the Mac Pro for two
> > reasons:
> > - the linux switchtec driver fails to probe and the downstream PCIe
> >   connections come up as PCIe Gen1
> > - some of the internal devices require PERST# and power control to come
> >   up. Since the device are connected via the PCIe switch the PCIe
> >   controller can not do this. The PCI slot pwrctrl can be utilized for
> >   power control but misses integration with PERST# as proposed in [1].
> >
> > This series depends on "[PATCH v2 0/5] Apple device tree sync from
> > downstream kernel" [2] due to the reuse of the t600x device templates
> > (patch dependencies and DT compilation) and 4 page table level support
> > in apple-dart and io-pgtable-dart [3] since the dart instances report
> > 42-bit IAS (IOMMU device attach fails without the series).
> >
> > After discussion with the devicetree maintainers we agreed to not extend
> > lists with the generic compatibles anymore [1]. Instead either the first
> > compatible SoC or t8103 is used as fallback compatible supported by the
> > drivers. t8103 is used as default since most drivers and bindings were
> > initially written for M1 based devices.
> >
> > The series adds those fallback compatibles to drivers where necessary,
> > annotates the SoC lists for generic compatibles as "do not extend" and
> > adds t6020 per-SoC compatibles.
> >
> > [1]: https://lore.kernel.org/linux-pci/20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com/
> > [2]: https://lore.kernel.org/asahi/20250823-apple-dt-sync-6-17-v2-0-6dc0daeb4786@jannau.net/
> > [3]: https://lore.kernel.org/asahi/20250821-apple-dart-4levels-v2-0-e39af79daa37@jannau.net/
> > [4]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/
> >
> > Signed-off-by: Janne Grunau <j@jannau.net>
> 
> Is it okay for me to pick up the pmdomain patches (patch3 and patch4)
> by now - or what route are you planning to get this merged through?

Sorry, I forgot to mention the merge strategy in the cover letter. I've
picking up all acked patches that are not yet picked up and we'll merge
them through the apple-soc tree.
This includes all dt-binding patches, patch4.

Feel free to pick up or ack patch3

Janne

