Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA376CA0EED
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OGZfAHvbSY8JyHgEl1wl2gThfaHwNzf7suY1jP1VvAE=; b=3+7dfTrfWfFlkUVB+SvBu9Ei5n
	4orNjT835P+3BihUWRxgLKGSpmgYe5tYQ0Cj7CZfgaL/ESVxbZBon1kA9XnCIZphdDX+R8WlDoC+r
	QvnXi5i8UsRbtkCTVFXe/GTQtH0RAcgDTUmu7b0JS3zHL+yiUKI8RKcjto1Lies5BMKkjSrXI0nGp
	EDB12tZKuWjbQh0scIBGrCeTQrfg6LPUbzckhO47QIAyt09qt+VytjkgJi3CHv2mkuSFhp09Dz/S6
	saPlEQJUe9kZGSv4SSTFYz7DkxEcexP73qXbeZTQoIydJiqLdgIf4r10tNJ9MsZEEOnRVio045rjP
	QDtSdBtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqx0-00000004N5J-18jb;
	Fri, 29 Aug 2025 04:42:58 +0000
Received: from flow-a7-smtp.messagingengine.com ([103.168.172.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urdDN-00000001py7-2B3X;
	Thu, 28 Aug 2025 14:02:58 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id D87C91380DEF;
	Thu, 28 Aug 2025 10:02:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 28 Aug 2025 10:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756389776;
	 x=1756396976; bh=OGZfAHvbSY8JyHgEl1wl2gThfaHwNzf7suY1jP1VvAE=; b=
	BmIxiSS2u79ypjT9YQ7vFoMethejmXc3d5rvdX7maA8ecUVcsB8b4NRY1CPuHrw6
	IFHBs9VK63t8iPA42BR2U+7vvnLgJp3RNeMh/1oLNidzUGsFBIR5AMKUAvgVWRoc
	3IYAUWp9mr7K5PprK7dnyDpNHiT+vyC9rqIU5TkHrZ6/8ywv+Z3dRE+PKSKytwcP
	lsWdg3lgB7GLnEplE1jyYy9qi5cO/e2hb1XxbqowECkxodASzzxfUuEYY0SdfWU3
	s3PwQ1QbRS+JHjxwi0TRYUlTac8r/1afaTj/kgQs7XSsu7+6Hj7oqlN6S0Q4ndXH
	LUp6PjUiYK5kSbQ74w8F7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756389776; x=
	1756396976; bh=OGZfAHvbSY8JyHgEl1wl2gThfaHwNzf7suY1jP1VvAE=; b=O
	8J9E/jxoNiOSENIr28OD9WsF7vi99QWEAZ3BUS6HlOgNQQ2WjRH6kNOsuCodTC5i
	h5WZ7rVLwd6M9VteZvMLdzaQ4zRRaGSlCjMCxV+zzQG/3YAj2y1QRnVSx0rsReTP
	LukbJSTMCXvBtYqyB47pI9co3FRifKFaJr3+AsP8gC6Q86Ei47RNUHE66oaOd26/
	Jt0pPLAtOdyF1KC7sRgkZA6tFzWjKFn2Mw6594pInmyJcHfYylTWz7CZAorTThnQ
	PcrADF1+slMoxcbXPZKisjH6d7Ab77DvERdm/t1iGA9HgJ9RvA1qsoplDpG33aH4
	BACL3405AX3Taia0CPsaQ==
X-ME-Sender: <xms:kGGwaJEkjCoRUtvdEgA8FtQ04mDvpslryNf4Xy5X4-mqm-MAUcvZNQ>
    <xme:kGGwaFy7Va1_NUwHdmEOPLi44QdhvRFDdeKnW7ZJV1JwoLSLdiPrnfeXqN_LEL2l-
    cCSMEpTQzzxD2_MGS0>
X-ME-Received: <xmr:kGGwaEF6bKaEogzYjF8EiiPlfIJt8KrdnfcvHU0hA-dL43Ug-Q9EHmEKGN959XyEsCEIS66EF-Ppg1LAX_iRI5KXJgHJVqE5zxGYlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepve
    ekkefgjeettdduueejgeeuteduffefteejudegieevuedvieffteeljeelgfeknecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeefnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohep
    ieegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhgphhiohesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshesshhiphhs
    ohhluhhtihhonhhsrdhnvghtpdhrtghpthhtohepphgvrhgvgiesphgvrhgvgidrtgiipd
    hrtghpthhtohepvhhkohhulheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqfigrthgthhguohhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    gvthhtvghnihhssehophgvnhgsshgurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprh
    gtphhtthhopehlihhnuhigqdhivdgtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kGGwaKDu5dCxYDDc2xbzsVtPzdTjQRSl0IDwVVBcn_JEBcbPzC0l3w>
    <xmx:kGGwaOnMJEGKNXgAqbzhHKy0YCSLf0Ol2i35uGUKrxC3v-7cpnuInw>
    <xmx:kGGwaMqwzCW27I9TX2ng6I9-xHGQnJhjfQggasPoPO5TzcAq2HkHmg>
    <xmx:kGGwaA41oNoaiIsMYSzTrXGKMZEbYyl38v1tWET9r-fE6aVa4pisVw>
    <xmx:kGGwaByIdlklubDRh3vFevLR3WQcNcuXxTdF3OD50myljGaCEPE16BaL>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 10:02:55 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 28 Aug 2025 16:01:46 +0200
Subject: [PATCH 27/37] dmaengine: apple-admac: Add "apple,t8103-admac"
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-dt-apple-t6020-v1-27-507ba4c4b98e@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=924; i=j@jannau.net; s=yk2024;
 h=from:subject:message-id; bh=Wx0RPczYgOK8CdqFLuZk+hLIaDjGO8awzo537j54hwE=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhowNidYMF6LFHV5u77H50aO/btFW26v3+ku16lXmZi7S+
 /syQGh3RwkLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQ3h4hSAiXgVMnyPLchwrj/OwpOqnro1
 Zqt2q6fKPfuQpVPv7+Z4Ea98M5fhv1+ESIHnrn2rdzz3dV97x8W6cVXByUe5C9n8cuybl5WnMQM A
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_070257_632958_75943EBD 
X-CRM114-Status: GOOD (  13.76  )
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
lists with the generic compatible "apple,admac" anymore [1]. Use
"apple,t8103-admac" as base compatible as it is the SoC the driver and
bindings were written for.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/dma/apple-admac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
index bd49f03742912198804a02a22e38da2c21093761..04bbd774b3b444f928986c266c53becf286daeea 100644
--- a/drivers/dma/apple-admac.c
+++ b/drivers/dma/apple-admac.c
@@ -936,6 +936,7 @@ static void admac_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id admac_of_match[] = {
+	{ .compatible = "apple,t8103-admac", },
 	{ .compatible = "apple,admac", },
 	{ }
 };

-- 
2.51.0


