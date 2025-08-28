Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E2BCA0FF6
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vmmF/PmGQDeVBHmeHb6dtX7HDk/M3JWzG/SjsW52LfU=; b=c+X3B7FE5oDMBk2oQciIIZImql
	KUqXzZaEwiPtmB93R0SzgUvRoIdYx4X1D2lsYsJ6dwhNrkmvDHz51kXWc/cKcO8Mv3WRMWr3zzfl9
	pWbwPh3gPEfF+i4IZxIwOEdyoEB4NO+o0xkrp/4pgSUy81z5N+VlsB7DgrZK7x6P1aEk3RqT5MHYv
	sgDQnDSsrBrIp7ngzykg7Pul2pI/H5uH0MedUOmk/5muVSVWsn9C8BwYzeM0eRn/WfUYHesFQnzT3
	fRADuFywN/lS61GSRiAkMKIbPMeNk4cxJK4WxcutHktKLuuZSdcrlf/h171rqsGIkg8knxhiMokQG
	85o6DeAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqwg-00000004Mbo-04aK;
	Fri, 29 Aug 2025 04:42:38 +0000
Received: from flow-a7-smtp.messagingengine.com ([103.168.172.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urdCw-00000001pns-1ZdB;
	Thu, 28 Aug 2025 14:02:31 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id C71C41380DC7;
	Thu, 28 Aug 2025 10:02:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 28 Aug 2025 10:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756389749;
	 x=1756396949; bh=vmmF/PmGQDeVBHmeHb6dtX7HDk/M3JWzG/SjsW52LfU=; b=
	wKjRpnVUpbgwRyr6K4jGm21L3xA/+rC0tF4VbWtYqnx6GfGRlKvpZNVm4hifgO07
	kRn4Z8WpXtP26YUR/UesBBDDih8CiNxWpNubBuKBSTHOIw97HhZdbcy/WNCGStKZ
	GXvArU9UGT0hV1JP2WdkMFmXQNGCiPph0tuN+K9GdlPWp+G4UeCnmFtSbcJKIuBs
	ywlRCc1Wdwzu/0e1gel0OJ/42J2t4Aj9zz/aNU2vHUnjXJPzl1gOsHDehocZM+sO
	ZZ1AMLN7XzOX+NHo9EfrkBQx43MvdlpJAQ4sjbIxVhvRj2i3vVEIai6N31Xr18fX
	zY7AzcIQbJTR4oCLbzYjWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756389749; x=
	1756396949; bh=vmmF/PmGQDeVBHmeHb6dtX7HDk/M3JWzG/SjsW52LfU=; b=K
	ZPLLhGhcRGUIhjZ4d5Df0q/yZoEUwmfTjVY6Z3YlDniNdm5uriZzPXhDOulbM4v0
	5pcD0fDNyW5tfsS6Eo+p5xuPAUUFzoAMqf7F84Lw0d3BhcgCSRCuuHKHhmL2UlYZ
	WhITMcy5UiUePr6HsT1nN+yRsoY9puf25ul+HwJTKWvynMggFlLTuXvVXzmyKQH1
	/3kNFSXAHQio/2RV2tRkTQTRfDqNqoJvhWBUDnvjRcBPlyyIxd0n/RTDsrFiKVHa
	YOz0fGOTUIWwHO4xBmH5TpISONajlwKMh/tzFZzMYQVresjFECb4Kjz+1535yoK8
	CW9IlQpZAE6ibWeTwfLyg==
X-ME-Sender: <xms:dWGwaBQzhyHSiVXbYdNK5EDxExk1ucNETB7VPIHwOfas9iodYKNoZg>
    <xme:dWGwaJnDq36kDCGJzrRqMVFiEgiVjF2GpoJphA2ZJIlPYga27Tx7PjHC_gIIW1daW
    r6telnlYycmXTxgoW0>
X-ME-Received: <xmr:dWGwaBg53axpnnzEOS5TtnCxlh-glN0idaRp6wL4NCGeTLTTyuW9JxJVbIP0sgbnTP3hIRp5FcXgj84-DiXlXa3pkiCwZ4F0H0xT4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduvddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:dWGwaAFS98wo-b-dQya4qFTmsZFPdvVlWsHRsS5Iqd6CiEmzxcV1OA>
    <xmx:dWGwaALsIlS4Jh0vrp1FOEzsTsNUrwLgw9STx-F2459QIdWtR6VfSg>
    <xmx:dWGwaOa7KzbFvxgbqOWNFy9BhjNHUBRf0N3fg-qCyJYzUsmqXKzv-Q>
    <xmx:dWGwaK0oZA6g8CVrPIpJzUmKazjRHQIQVPbo2EiwfBgkVz6RySJPVg>
    <xmx:dWGwaD6UDfymx4p7-03AS7gKXq_-cjccF99e_pVsfHKYChOIJumrK8Ng>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 10:02:28 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 28 Aug 2025 16:01:36 +0200
Subject: [PATCH 17/37] dt-bindings: net: bcm4329-fmac: Add BCM4388 PCI
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-dt-apple-t6020-v1-17-507ba4c4b98e@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=j@jannau.net; s=yk2024;
 h=from:subject:message-id; bh=FwzT9u1tZ9dJSNWWr0YbAMptH+kJ/6A4kCQ/S8irfyE=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhowNiZbvEl+dL1KPPO3WlDvt6VZ/4fJpW7XYPHbbPDgQd
 HRW19WNHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACYi8Jfhv2utWGr9rZq2n8dq
 xK7mJ0oWnl5oxPjv8pH7ils8y7y9hBkZFsisXmMWb7nb1OjJIqMpE5wjg7RWBezTqYibrpGncEi
 QGwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_070230_485910_141F4E21 
X-CRM114-Status: GOOD (  11.12  )
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

BCM4388 WiFi/BT modules are found on Apple silicon devices using
M2 Pro/Max/Ultra and later. Driver support for this module is not
submitted yet.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index 7c8100e59a6cd045837a2f602e367f3f79ced5ba..3be7576787644571e42a4145d40af9026cec61ba 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -53,6 +53,7 @@ properties:
           - pci14e4,4488  # BCM4377
           - pci14e4,4425  # BCM4378
           - pci14e4,4433  # BCM4387
+          - pci14e4,4434  # BCM4388
           - pci14e4,449d  # BCM43752
 
   reg:

-- 
2.51.0


