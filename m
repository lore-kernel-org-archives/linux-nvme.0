Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F01C02198
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 15:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BnJF57Zoto2dUPEyMaGcVR2FHi8bTjic/OzcbomabTo=; b=W97MLukYwlSjF4FfmvZdz0TubE
	NzI9X/hXnahRCTq8ucHiYwToDKRrq3eQwsqgmdYKgfXtQeouE66zbRKjU0XKfIonib0I/DhUMbkTT
	Ps8obLCWwRsSOAEoO8YvuFhtIT3JNtQpDU3B4znGgwMjV1Keg/qo6b9IjrmtPIH7vpZnoVOEvKZGx
	g+2ysU2RMKtOaSQ9IpArhWOej04pFdb8HeGj7NH8aZTHDiI6/Xb2fmuYqR82Ax8fRHImqU68W+Qh/
	vnNepuINO6dq4jfLvEtdvqVH8w+IXBvFJRuckDx/WUf3XgU02Ez1uiGGmf8mAcAXdTT5SbSk7EirV
	NmeVgTtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPBJ-00000008h47-34MJ;
	Tue, 18 Feb 2025 15:06:41 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPBI-00000008h3H-0sLb
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 15:06:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0CC01A40C64;
	Tue, 18 Feb 2025 15:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAFAC4CEE2;
	Tue, 18 Feb 2025 15:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739891198;
	bh=sz4N5tO/fJWbp+cAUSYMXY5DgjhAHXhhf+KTPoEqg/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozcwuBjTtj9GQB+fl2ugEZFQ4GdbUlFOYHkxo8Ruj77txZxs3SulLsMKwQPhXM7Iq
	 Ml8zSjJdz9xxbleVNQusrNKA/jxbIydBWYon/TkMWqXFJnNZDore2CEPA/7alCvYPB
	 J35hKoKR82lMC1riG/J2vOLANvRsgArb/jA/Ht+UvG4Whgxuq3hpwOSMqklNVtYs3X
	 f7T9D6NBpr4+KgNnLpBugEHzSHS55MKjFkrp/Y91vj3o+JjPaEVuEmciIr7mSuP41i
	 uVVJFKMZCKgxt4eLWxJyucFly/AV8yU0h3NHwLywebMASEKePphqcDO53xGy7aw487
	 FHrdEqXDi3nIQ==
Date: Tue, 18 Feb 2025 08:06:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_070640_312972_B81CEC13 
X-CRM114-Status: UNSURE (   9.32  )
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

On Thu, Feb 13, 2025 at 03:37:28PM -0500, John Meneghini wrote:
> Keith, Christoph and Sagi,
> 
> This patch has been fully tested and analyzed by Red Hat's QA group and no
> unexpected side effects or regressions have been found. Both NVMe/FC and NVMe/TCP
> have been tested. Our QE engineer has asked me to report this upstream.

What's the harm in leaving the parameter? *I* use it so I can test both
ways without needing to compile multiple kernels.

