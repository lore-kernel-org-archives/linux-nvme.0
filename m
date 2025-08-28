Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D8DCA0EED
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bURsQAAakUTEkhaJubEx1UAKKyBOYc27UojVfJTZiY4=; b=Z7CRpLJzLSyebB2Uo07RM3OJDp
	b1N7s6blfW6M9VZGfP51xdm28TqG+Wur7/teV4ZjK04xv7/vg6dkG7VItmqPapk6jfb5e7U9n1EwH
	cdyNOKWeRvg4zWWvqdhnkL8v4EN/frRxVHVKt6SZPNvWE1SH7LMnql+S1JHRsWz34tLGJaDowuBBP
	xpWTQwaiZvHg4B/QHxOiTxTClNhpphACqbLt8fihmUR7tj3w+EaC07xcYqcBMQY98T38zZdDEg6K1
	Ux2wjL+VKR3PmrbSDoFx36beLs2YNKnrjXNodj3+B5LtZqZ51q6jbv7JvJb6VtMk6sNK4XHGajp0Y
	O38A9nYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqxD-00000004NRw-3GJc;
	Fri, 29 Aug 2025 04:43:11 +0000
Received: from flow-a7-smtp.messagingengine.com ([103.168.172.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urdDT-00000001q0i-0Rv8;
	Thu, 28 Aug 2025 14:03:05 +0000
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id 848B61380E07;
	Thu, 28 Aug 2025 10:03:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 28 Aug 2025 10:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756389782;
	 x=1756396982; bh=bURsQAAakUTEkhaJubEx1UAKKyBOYc27UojVfJTZiY4=; b=
	hpiBR8MncnswE8nHZndnU+d6FrOe7PqPRaG5sOI4yHRidUCuFyODPMY6sxRTmKJk
	dXVAxE03RnZZ49kWTHa81pvaV+BfimoM9E5YhMSr6ytS7ybr50Lkb1irnyj37R3x
	DPiBFJLPtizzv8pkZXRMKEW6tm8kZriMvnfWukdeCXnsnaNx1e8BinOX3LwfK6+K
	ArZ9P0SI8TPLyRl4pxB2AcvNEemHfG3i4imMhQkuKqjH2uXX/LeBOk7utFnGeZGc
	GEqUAcQllg6dI7jiGa4ea7DriTJ+kNpvafG/GKBU4phoDzz2Al34mSuDGLPcHenC
	y9IZ/1Usf42rKuH+5dbLqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756389782; x=
	1756396982; bh=bURsQAAakUTEkhaJubEx1UAKKyBOYc27UojVfJTZiY4=; b=R
	Ubzd199chBhrSuoG9Y9UrgxXfVLlad1JYjuM26tildVGdE39qtIRK+mGj+zO+GPj
	ks7YvBMD+ihxcCmRlKeRfLOvWuVpi+fZwDI8XjmByI8d06sGA1KCcgD+8TfTEPd9
	GLCEP5LnrMS+SoA+hjCVk/8yav9I89YSBKa1CgfUpQuu5z8AzqP1m26NgxdcDRcH
	gqCkcCrT2GH6Dga9L/wa7P1ncU3EINs8TkZ1jz2TckJ8UJ+TiOkRDRT3uSU/cgc8
	TZ9S3pYU/80PDciR48B+H2WtIaEHQiAFg8t+euM+H/eT7P6rD6Tfk6Q1SkYCTF00
	RIcSw6C1FKg149frcJeWA==
X-ME-Sender: <xms:lWGwaNeVX9wEHZKKykPwjK4TlfDRbhNFwZQIb9JiI3wM5LA7D7S83Q>
    <xme:lWGwaCraqXw2WFJSQk8MzfHIeq3UtuJjuUNPWtXHG9jE8lpKpAgTTBiYcsF3gCLRJ
    KfDBaHL7Pg-tS2wnoI>
X-ME-Received: <xmr:lWGwaPer0orhrg5X3ennTQRh0Ib0F5dEp_jwdZ83mbLFehkGh3q2rzfFbcX1G1b4eUNHw2Rp_P1pJwG_48PkGpTfqFbissXrTwVVVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduvdduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:lWGwaB6d2ohSfHjJgSdFwjWGPO7qFl8Y9wFXJw0ZAJmi-R5kxuMQGA>
    <xmx:lWGwaI9MQIkQCsTguLmb-J0Jfozk0ooI-NLUKfqBIzJe3_TpMyZqvw>
    <xmx:lWGwaHguOS9FXrRf4wi-NjXQBdm9OzEcRZU3cpnw6mlzTd582q2usQ>
    <xmx:lWGwaCQMJBeaKPRnJlry_DIogcB3_J_KArQdl0-z6Ut0R4dZvMRHJg>
    <xmx:lmGwaIqB7oY3MKaW91iLZf5gaRoMor-bonCS41mlNOeqJ3QiI3I0ELHc>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 10:03:00 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 28 Aug 2025 16:01:48 +0200
Subject: [PATCH 29/37] ASoC: apple: mca: Add "apple,t8103-mca" compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-dt-apple-t6020-v1-29-507ba4c4b98e@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=905; i=j@jannau.net; s=yk2024;
 h=from:subject:message-id; bh=KRBKL2ymAhzun0Pvt+/W2fLdZdIxW+dzlhG8YGU3GvU=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhowNidZhSk+SLLtzs4py1G9sX3J/SSz/Hwf/AxtXuWmud
 rXLPMjfUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCK7dRgZtiXkXbxn8VUqRdgp
 cZoUZ2hP7ISFxfEbc7QiJSbNepkYxvC/iEN3lcqbNxu83tTP7zr94t3UXYtkLXtrkm6cdVzi0fK
 FHwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_070303_280942_EABE4959 
X-CRM114-Status: GOOD (  13.62  )
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
lists with the generic compatible "apple,mca" anymore [1]. Use
"apple,t8103-mca" as base compatible as it is the SoC the driver and
bindings were written for.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Signed-off-by: Janne Grunau <j@jannau.net>
---
 sound/soc/apple/mca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index 5dd24ab90d0f052bb48f451cf009dc2e9128014d..c4dcb2b545912cd02ee219cc2d4958db5aa785ba 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -1191,6 +1191,7 @@ static void apple_mca_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id apple_mca_of_match[] = {
+	{ .compatible = "apple,t8103-mca", },
 	{ .compatible = "apple,mca", },
 	{}
 };

-- 
2.51.0


