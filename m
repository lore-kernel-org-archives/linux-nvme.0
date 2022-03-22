Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F064C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k6P4FFNgGYaIhI6qrpGSR/nwunzZHhxLCQeacSs6KWE=; b=cBlro7Wnoi7Aad7z7GF2hmAKp6
	SEAPZNSkie7tKqV5QQcT3W3VsepOxKdknZEMMzA2kUkS2Zur3tlSXE4bt/f6myFh3PWLBI/DJfp2J
	aF0fuRxdS2IfhsMmAHlsNG29U+7bSzv2pQ4QmzgIlZ/OOr/PUYVsJCpBBrpeQGg+nXUj+L7pzFTbM
	79CdY8ZBCEeUVp62XswE1EjFwucmGVl60Ci3AhRVFjK/v5l51I7PANQ0j+VEXNzitlHPY3pJE40Zb
	POgEnvEg3ni24qQgvpHf1NgEHCAcEJhzBY2KOPwRyUFHEXdr9DsEadwx8sy7SusksBjXCyxasxqjt
	tf1tdzwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWiHd-00BjT4-NJ; Tue, 22 Mar 2022 17:27:01 +0000
Received: from rosenzweig.io ([138.197.143.207])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWiHR-00BjQc-G6; Tue, 22 Mar 2022 17:26:50 +0000
Received: by rosenzweig.io (Postfix, from userid 1000)
 id 0990F41E2F; Tue, 22 Mar 2022 17:26:46 +0000 (UTC)
Date: Tue, 22 Mar 2022 17:26:45 +0000
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Rob Herring <robh+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Marc Zyngier <maz@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/9] Apple M1 (Pro/Max) NVMe driver
Message-ID: <YjoG1UqPhJaKbTPX@rosenzweig.io>
References: <20220321165049.35985-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321165049.35985-1-sven@svenpeter.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_102649_614770_1E0BA4E0 
X-CRM114-Status: GOOD (  10.18  )
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

> The driver itself has been successfully used by multiple people as
> their daily driver for weeks at this point and no major issues have
> been reported.

FWIW, various versions of your NVMe code have been my daily driver for
development since late 2021 now, along with the display driver based on
your RTKit library here. I'm not qualified to judge code quality or
fitness for mainline, but I can testify that it's functional.

(Not a formal T-b since I haven't tested this exact version of the patch
series, though.)

