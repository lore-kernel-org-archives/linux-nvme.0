Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DABBCA1012
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Sep 2025 08:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZCAVkUl3rOi06K+4aKAXqP1rz8JgjsvKhOoQBsverCE=; b=3QdAZd1Un82tlVEDaAa+KX6fv/
	xu9i3zcdOk0EKqJklwPab1Qwg517v5HhOU1dMGACWpS73xz2OJhWQXHi18AnLI2ALZBrxVsLCF+FT
	N+sPC9jV+su5XiDAaB9UuClyq5nwow2B2YW+8DKM/1JTkcZpfRtPvanDoqPRPB4b5BwWZdC9DY3cD
	dVrlU772er7vZYEpxhqkqcoIXQKluprfl7I6C/sK6FKl8wx8rBm+hwpsZAqiCrL3hIiecjAuZNGyV
	+PxmC0ShPnhxshS5Fu7Z4MWjn1XowR2cGK95vn/UMEgcgaeJd2E3wLCT+ovWopTFO/TgjHAW91wQs
	ALKBA+mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuo3P-00000007C1p-2msj;
	Sat, 06 Sep 2025 08:13:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuo0a-00000007BsK-3Dyb;
	Sat, 06 Sep 2025 08:10:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 99587446E9;
	Sat,  6 Sep 2025 08:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBDFC4CEE7;
	Sat,  6 Sep 2025 08:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757146251;
	bh=cwPk6T3fU2IyG+AYF8QYuidB4vOjI0tVcpBFG7S39rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKcXWMmj+SwlIU1GzFq8oGy5jgkkN17Uj4Hff5l9S2IVzbrPSPFYHuXjC5JuEo27j
	 Y2B29lJ8waYDU63qj4rxD3ZGvwPFJL+wsuWuKva/z6fmmOY3izAgdYxQGymJ6nubwr
	 QwsgF3t7rKBJE3i0+yp314MQ9Jw+fh69USW5yn3orTcbGVen/0szcZDM+Z9DhnoFPe
	 c81VjlZ84X+7b1jVcrC4h2S24HKSq2u5nGodK9yC4x+NuvCJYrlC79BXRSzUfd6gJr
	 aLmpCilGHesAV8kg406u0E/QMxzxM86UqXunzWFzSjV0eSdxGIAq1XHExGVuFtCiru
	 IuJSvEmMbAUGQ==
From: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v5 0/4] Add support ANS2 NVMe on Apple A11
Date: Sat,  6 Sep 2025 10:10:43 +0200
Message-Id: <175714604478.14736.9361483258492179321.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250826-t8015-nvme-v5-0-caee6ab00144@gmail.com>
References: <20250826-t8015-nvme-v5-0-caee6ab00144@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250906_011052_831462_98FAE261 
X-CRM114-Status: UNSURE (   9.87  )
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

On Tue, 26 Aug 2025 20:09:11 +0800, Nick Chan wrote:
> Apple A11 SoC comes with an NVMe controller that is similar to the
> NVMe controller in M1, but less customized. Notably, it does not
> have NVMMU or Linear SQ.
> 
> The controller is wired to an older variant of the SART address filter,
> and uses an older variant of ASC mailbox, so add support for them too.
> 
> [...]

Applied to git@github.com:AsahiLinux/linux.git (apple-soc/drivers-6.18), thanks!

[1/4] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
      https://github.com/AsahiLinux/linux/commit/1dd8daf1cd49
[2/4] nvme: apple: Add Apple A11 support
      https://github.com/AsahiLinux/linux/commit/04d8ecf37b5e

Applied to git@github.com:AsahiLinux/linux.git (apple-soc/dt-6.18), thanks!

[3/4] arm64: dts: apple: t8015: Fix PCIE power domains dependencies
      https://github.com/AsahiLinux/linux/commit/55a1ed25fa8b
[4/4] arm64: dts: apple: t8015: Add NVMe nodes
      https://github.com/AsahiLinux/linux/commit/eef7336dc6c1

Best regards,
-- 
Sven Peter <sven@kernel.org>


