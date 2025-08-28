Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A93CA0EED
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U7gKqxMdtrDydcP2jPP20jdBwDy6aKPtv2ZVuPHXtIc=; b=bJK0Vu/ZWmMy7qDz/C4bOf4X7U
	bDqSYYVsgfMCron4lQ7Ikdbj/LXf3WiRRRjVn378tWCaXhijutxm/75CEzYtXAZA6BD0Wm5hv/PYE
	CmwwjOs1bCG8isDkWJV8hSQgeBfndQM3UvKpftliZipceTAcP3tCAIrmMd7nkNwSl2ALgJBS5jE0T
	PRekoqk841O0pm0JjAvAKx44R8BUjd2xYLP5m6KzJuWY7rgqpwEEo3Okhb5+OU4i2art3/5m1slWV
	6KtmU1LTDVmFZC8wR03e2QZ5boKiMwXHPGA8kwahQICbUJxs7CN430h/eQUjFMIVL4Qmarlem2zwp
	nt25a6TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqwX-00000004MLN-13a6;
	Fri, 29 Aug 2025 04:42:29 +0000
Received: from flow-a7-smtp.messagingengine.com ([103.168.172.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urdCf-00000001phv-3TCi;
	Thu, 28 Aug 2025 14:02:15 +0000
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 2F66D1380D98;
	Thu, 28 Aug 2025 10:02:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 28 Aug 2025 10:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756389733;
	 x=1756396933; bh=U7gKqxMdtrDydcP2jPP20jdBwDy6aKPtv2ZVuPHXtIc=; b=
	OeZhqi9iE8npKcubLSkyEQVar1r5wmh0Zgblz1J/2t3aV1wUczoNY+IjBlo62LNT
	VGU9k4KGF2a94+4vO0otZTmUqCaYPMEGJ0ORzAHYG/JV2Dtrnez+cpj4yfqzDbuG
	DAG9w07bDon+rWnPws+Njwnu15s688dSowOE9vhJKMLrZ1pS4o5oGDDHJ8ja1q2e
	vc3gv1fj8RhPsXragyq+Zofg+pNUNbg4eavG2qOtQ2+5zGzXoSooZTes8aK7sox+
	QnZchw3GmtXWoPjvAEq80w11IPHVi+bqs9USBEGQokEqpCO5b9rCAw5JytSq+deJ
	akRahzPC2Pql9KzTSyr0Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756389733; x=
	1756396933; bh=U7gKqxMdtrDydcP2jPP20jdBwDy6aKPtv2ZVuPHXtIc=; b=G
	GoHAGu4HT4A92ktSpDNEv95zkPJP10/3brmV4SRySh7NoFTIsmVGVIf8loKcPum/
	lqzzb8CN6kwxZAwIAsbX5w87M8J7c1XWkGSGVg+iYEzHtPf9MXKJJJ8aFhqkCjRC
	EsiSLLM7lT1B/QL6hZLnjIanDAehIz0FIBRUmIjEw0FfetbZW1X76UJKrM5NZWdu
	RPkyka6EOZd1qUTeYwTYHhVCgDLLCY1BWEHlJ8ZzfMXCi0W/tgU4ILG6RfQBIpio
	rkBIB28Aiba+nhxRjfd0nc/2Ai0+6Jg4fFhHGkuRmSxS1STR1yKYUrboRwZycQ42
	QJB1JKzg16Ul2aMKBLY9g==
X-ME-Sender: <xms:ZGGwaMMBe5wrtjlrqMowlAa71gvQyA4KHyDRRlOgx0Fxhk52sY8mxw>
    <xme:ZGGwaBz-fy-jbw5lU0VPheJq2z-nhrLf89p-vINpdCv_bJzrfTiYlJOukZ-lTNb-8
    InMqtIqOmcOtPGYYGw>
X-ME-Received: <xmr:ZGGwaN_Ujy41B7IMIR_g9v3BL6C_ieXIN1Vi56VkSVYDL9nkFhMalylKebx8fAyZ26LoBsoLPN2vR950drLAPXBzBKjPrQIYFhpAtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopeeigedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugidqghhpihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhohhgrnhhnvghssehsihhpshholhhuthhiohhnshdrnhgvthdprhgtphhtthho
    pehpvghrvgigsehpvghrvgigrdgtiidprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdifrghttghhughoghesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkvghtthgvnhhishesohhpvghnsghsugdrohhrgh
    dprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgr
    ghhisehgrhhimhgsvghrghdrmhgvpdhrtghpthhtoheplhhinhhugidqihdvtgesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZGGwaLxvbKtN-JbvK4rzGAXi5NFdZjPlcn-MRscYP7OvJ6KH932ZIw>
    <xmx:ZGGwaKGWGtdG9CKx5CpKMs1ETq5kl1Bz9rPBb8Y7EcPSwxLQt3hQGw>
    <xmx:ZGGwaJk7fqkpj0vdM_mredxtS1c4LCAVfrRv67fL0gMIyP14_iq1kQ>
    <xmx:ZGGwaORZQzoju7WLIzhUszNgmKiILpRFBM8OL6vDWguMRekAHP7CZg>
    <xmx:ZWGwaNyhFZeRgLhj36fyh1iVL0iRkED0ZhnvtWiVI0n42ELVMinw1ju->
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 10:02:11 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 28 Aug 2025 16:01:30 +0200
Subject: [PATCH 11/37] dt-bindings: mailbox: apple,mailbox: Add t6020
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-dt-apple-t6020-v1-11-507ba4c4b98e@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=j@jannau.net; s=yk2024;
 h=from:subject:message-id; bh=0beSRx1TGYRMbS0GDx8p0lcatQF62rUhjowTZjIUF68=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhowNiRav5Vad5Jv/cIN6ssw2n1vpP4IfHcp98fXRGpd/E
 Xuf+mVM6ChlYRDjYpAVU2RJ0n7ZwbC6RjGm9kEYzBxWJpAhDFycAjCRx+sZGd78D6/ynCVsKLxH
 86D8HgX/ohMuDGwzTRhDp/xu/+sd/oCR4cteVQ/HAotSAXGjyHqf59Lpz29wzDWK/S//SnRP02J
 fTgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_070213_952710_0F90A8AF 
X-CRM114-Status: GOOD (  10.90  )
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

The mailbox hardware remains unchanged on M2 Pro/Max/Ultra SoCs so just
add its per-SoC compatible.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
index 474c1a0f99f34777e1bed7fc0a34f89320a93b7c..ae147bbc879fd0801b4552a0b75147d7d284aae3 100644
--- a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -31,6 +31,7 @@ properties:
               - apple,t8103-asc-mailbox
               - apple,t8112-asc-mailbox
               - apple,t6000-asc-mailbox
+              - apple,t6020-asc-mailbox
           - const: apple,asc-mailbox-v4
 
       - description:

-- 
2.51.0


