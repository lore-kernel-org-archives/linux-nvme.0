Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DD1CA0EED
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d1uuzbyK+TBo4FKAGVpnZlWXc03joPgRcgcWkt54xQI=; b=0ZCgWiIcDtZB3oO7JqFtXMghR0
	9JVC4vr+Sl5SeSKMJeiUg2hW8pARGRi1A9xVYr/vAgEgMASkv1EgwgQnc3LLD0aJyCm77vFIt/5BD
	W0hqL4JJT32K6pmDeeTXeJfe4h5QF0Q5i9A7tTdTzx/kWRTomc9tSOmUO+NiNAnLEj5wGxfJAt9wz
	cLrfGqmLfLFFLpr1wKZJXBLju3ORQi3e65tGlSG1aRzZKAyh6p/7i4wAB11pJTbCAzr/YfpvD6Bkh
	iZ3pysCOp0qsgRmvH3XIVWVGlxEWrz6SBOeOX18SfBAqdH1gvP8rhSldh+WfbZUgt25Cj0jK3Wq4C
	OGUJNLEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqwb-00000004MSM-0H6r;
	Fri, 29 Aug 2025 04:42:33 +0000
Received: from flow-a7-smtp.messagingengine.com ([103.168.172.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urdCo-00000001plh-1YUJ;
	Thu, 28 Aug 2025 14:02:23 +0000
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id B45EF1380DBE;
	Thu, 28 Aug 2025 10:02:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 28 Aug 2025 10:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756389741;
	 x=1756396941; bh=d1uuzbyK+TBo4FKAGVpnZlWXc03joPgRcgcWkt54xQI=; b=
	VaHDj0PY+V+AsDh4qD25M+zhsGKWgtfDZDmedCbfP+EkCQywzgXWlXCSEVOZqjhv
	7UZDu6/4yqx3KWACwKGn5LTqKnxsBWoIjiIALvisrCm7/zS4GdUOU9F8QOqhZqr4
	52CERp0d39AmPJd9FDDN+AW75JzwtwpCvLw7mean4SYOlIFpXQVoUOPNBMh+jdEz
	D79ERgCHoJ1EgTJ2F9+G6aSnPOGIuNisCxV4zoA260iNJLDc+uc23w/RLNiTUPAe
	z2w8u8vZlTDOVQmyocuG6YW2KzUxtme3qVyz/azJd5mOmMaYtl2mh5bXR7hSIARr
	+RDkwh75QL1OIv6ORBFu3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756389741; x=
	1756396941; bh=d1uuzbyK+TBo4FKAGVpnZlWXc03joPgRcgcWkt54xQI=; b=C
	+edsKmmgQpUUdgiXz5LRMt0w28yLVSrI7MsZIsPtNCituhTpwZWvWREvhgEUux8E
	UBUPU/V3A+VmSYDz/LJL2HcEQPGPbJn85jPh9iULAwQ9ptIoydbVftX5jaoxNChL
	pGf2VdxOMZu4rsUsCRI7dK4JTkGvJpAJiPVD4IgksWwaBzebhFRxXEdNyu/l5vew
	P0GAwEdjQcjBQf4I7zxFIuQygK9qSFWSxstrpmyON8c1VbcceKab4h0+EwHlrTgx
	VtIUyVBue5/yaokYBcyDn2mVXwQyuw65vK2hiNQ8nvdPBlqYAsqTumRJxGestZ0l
	cIHYxhton2o+jvcED5jaQ==
X-ME-Sender: <xms:bWGwaJOjUfAt2gPyXzDYH-QgJmwJCaGGpCEF_YS9LWfnNJUTQi4o_g>
    <xme:bWGwaKzDA0OMFWaVfRJCxHerCzhhNRw1vEilx6gOfrXXtVKMukX1cJvIXBs5IMyW2
    dJRufB8zrpTOT8c5E0>
X-ME-Received: <xmr:bWGwaC9T6uH96i2PXR13lLZfcIcmo8wmeaNpImOLE4UvHEniBDl75tdgju-d8XMrtL141uNjsLM1QkKRUb-Yt8MTLM8hd_X1i4qFRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepve
    ekkefgjeettdduueejgeeuteduffefteejudegieevuedvieffteeljeelgfeknecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedunecurfgrrh
    grmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohep
    ieegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhgphhiohesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshesshhiphhs
    ohhluhhtihhonhhsrdhnvghtpdhrtghpthhtohepphgvrhgvgiesphgvrhgvgidrtgiipd
    hrtghpthhtohepvhhkohhulheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqfigrthgthhguohhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    gvthhtvghnihhssehophgvnhgsshgurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprh
    gtphhtthhopehlihhnuhigqdhivdgtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bWGwaMwXMChxee1x41cVZmcENyVrdN8cxsZouPfGzoov0QyiO-HTAw>
    <xmx:bWGwaHGFJ459KgUjWGFOoXpHCZ4kv4lQ07dAIJ1f4VXkCYekMANtJA>
    <xmx:bWGwaCnKTsBNdTFXQdp_hlUWzUIJOXQtsQOpCfMJzEJ8eJq_-3nYqw>
    <xmx:bWGwaDRt5Z0bkvGLPlUQu2b9W3E7SszPvHJLDA8J1WqUm92N57d-Xg>
    <xmx:bWGwaOEpaf--yyX6ZMRIBcyqRqWVh9eTLzAZ62ilQKNakq-L_QMdUoRG>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 10:02:19 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 28 Aug 2025 16:01:33 +0200
Subject: [PATCH 14/37] nvme-apple: Add "apple,t8103-nvme-ans2" as
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-dt-apple-t6020-v1-14-507ba4c4b98e@jannau.net>
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
In-Reply-To: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
  Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
  "Rafael J. Wysocki" <rafael@kernel.org>,
  Viresh Kumar <viresh.kumar@linaro.org>,
  Thomas Gleixner <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>,
  Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
  Linus Walleij <linus.walleij@linaro.org>,
  Mark Kettenis <kettenis@openbsd.org>,
 Andi Shyti <andi.shyti@kernel.org>,
  Jassi Brar <jassisinghbrar@gmail.com>,
  Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
  David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
  Sasha Finkelstein <fnkl.kernel@gmail.com>,
  Marcel Holtmann <marcel@holtmann.org>,
  Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
  Johannes Berg <johannes@sipsolutions.net>,
 van Spriel <arend@broadcom.com>,  Lee Jones <lee@kernel.org>,
  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
  Stephen Boyd <sboyd@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
  Guenter Roeck <linux@roeck-us.net>,
  Michael Turquette <mturquette@baylibre.com>,
  =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
  Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
  Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
  Ulf Hansson <ulf.hansson@linaro.org>, Keith Busch <kbusch@kernel.org>,
  Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
  Sagi Grimberg <sagi@grimberg.me>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-clk@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=987; i=j@jannau.net; s=yk2024;
 h=from:subject:message-id; bh=Jb83KxX2H7kR1o63dY79EQbQmU6FMtXfENWdCwzKWS4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhowNiZadqXLVW/17dYSM90/iZHgq4LH/1RnpqsA7RybLB
 Ckm/ursKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMBHO8wx/RW5UOcq4h897Z+b1
 dkFcZmbHiZmFYQxWMamLXq4qmr1On+G/0/STT/xviR66ueGsrL7KNjXWPxf99SodOUPr7JdPniH
 IDwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_070222_484996_868F05EF 
X-CRM114-Status: GOOD (  12.78  )
X-Mailman-Approved-At: Thu, 28 Aug 2025 21:42:14 -0700
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

After discussion with the devicetree maintainers we agreed to not extend
lists with the generic compatible "apple,nvme-ans2" anymore [1]. Add
"apple,t8103-nvme-ans2" as fallback compatible as it is the SoC the
driver and bindings were written for.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/nvme/host/apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 1286c31320e630cb012009d6b962526e0553869f..1f57a7a20715cb2370f1e72872c2e08bde44bbc8 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1626,6 +1626,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(apple_nvme_pm_ops, apple_nvme_suspend,
 				apple_nvme_resume);
 
 static const struct of_device_id apple_nvme_of_match[] = {
+	{ .compatible = "apple,t8103-nvme-ans2" },
 	{ .compatible = "apple,nvme-ans2" },
 	{},
 };

-- 
2.51.0


