Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099B0CA0FED
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Aug 2025 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sCHdVBP82vl/Q8/t8oiVI3Ka3czm+9Qa54VBPIyNgrE=; b=nHKUObWPqFULBIwB380NX9LBAu
	RtaFHRtKULUTygSQ8VQhRr72iT75Kak6ejbIt4gb7SN3i33w6U9t7w+zHhrnnoyWqup90KzilR9Cy
	5kCZd9M9oLYOf0ks4dRTB9D7edf7Q3q+Pwr0xd5XPJxsiI+9/UiEqJ8eT2c1BxAdBgKJ2OdFBM3Lf
	/z2IX2xoFWTRcqxELNjYACYiDpxBKQ0l1t22P5z9AdUvT0L9wQKOrgK0/hDpKvOsc9novDK98ZoJs
	Sz1ezfaBTcVIyxHdaE98wV+e0dlkZxCTpTMc+1jGqHU/p58EsMs14rzL0gslrm8RExmbcq+vEv0p2
	B1sSx3oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urKOP-0000000GO0M-2DgC;
	Wed, 27 Aug 2025 17:57:05 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urIZ1-0000000G6mC-1cwO;
	Wed, 27 Aug 2025 15:59:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6F16E60008;
	Wed, 27 Aug 2025 15:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E54C4CEEB;
	Wed, 27 Aug 2025 15:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756310394;
	bh=RFezkzaQXkCbowCKLjQPIDEaCnTCQ9QXLpMxI9n1tC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GpOsRemVboGQI+m7uT41s2OPjaYVcJxV4BM0hfRQvGXJbJdY4G9g1bLLY4aHN+BGW
	 w5TYIN/AOs0athPh5ZPzuyWdZclqi09W0tc5nJUj+x043xF/m9qc5T5nR9uVBjFRnr
	 jXVCtFbp1ZK8F32XFDghiFhEO7ay24WyDUiURfmL7yAm7wRJEjZ5LRclYjbE1+5PaQ
	 A9a+1Cv7AXZ1WDme19nuJgMxjIE+S51w9Sr1SiHNJ8FxjSVXlJiGvqkvp8iEOIM7O0
	 1nohygQFjKBcpH5s14Sqw5bZS6uUWrzlI69pmiI1r88Dh0A+tvNK/IOZMR5/uXEq3N
	 X4bAN53kCnlpg==
Message-ID: <871a3abf-3dbd-4360-9b89-7951464f0d89@kernel.org>
Date: Wed, 27 Aug 2025 17:59:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] nvme: apple: Add Apple A11 support
To: Nick Chan <towinchenmi@gmail.com>, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250826-t8015-nvme-v5-0-caee6ab00144@gmail.com>
 <20250826-t8015-nvme-v5-2-caee6ab00144@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250826-t8015-nvme-v5-2-caee6ab00144@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 26.08.25 14:09, Nick Chan wrote:
> Add support for ANS2 NVMe on Apple A11 SoC.
> 
> This version of ANS2 is less quirky than the one in M1, and does not have
> NVMMU or Linear SQ. However, it still requires a non-standard 128-byte
> SQE.
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>



Sven

