Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A522C61DD3
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2026 14:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GndmvzAx0896K1HCNrpHO2E+R4DOWmOhmH9ExQNzXUc=; b=z9a366rnxtSj9VDQ0SRT3Abb7D
	93urVJVH2DBFCRUYrqb+ei3VTbeBuiWCJcYdNWYHht7aiTu1u0XrCOx+p3vATxDsGLiKcCALCPR5m
	eavf4fe+mWEJsm8bWm8hL23pZlBma538juWyDazsPBdSACC3qSEjNJy1dG+5hmKm1T2Ga0Xqs/2Qt
	7lco7DgD62mSPN9HwVOX5EUzsuRNF7/7XThFsiUjFcfb0FfC0C1sHlaQ+pWvS7TFemAJlXgab59zN
	znvvTt0EDgkehwgeqfYFmwCJ22dVfQP/psvae42kZidz4t9s1HT/LedHJgHMguz+UiEvGeksb5T7F
	6+uTdBhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1P7u-0000000CIHD-2omx;
	Tue, 01 Sep 2026 14:06:14 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1P7p-0000000CIFO-3GRs
	for linux-nvme@lists.infradead.org;
	Tue, 01 Sep 2026 14:06:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=FNAWafCY3dOFra
	hjM8Pl2Iw/GIp0doPYp+ItWu+gbXE=; h=in-reply-to:references:subject:cc:
	to:from:date; d=arkamax.eu; b=KVJGccIRMy1ikmV86deRGvy1slgxAwTq0o0RJjIw
	ijmgyNY68xSAP2iWRyFMyTYE2mqgoqNkvqWPQdpAXRjPzoZtlzvlr0chD66huFsjikTkI+
	TfPx0Uy9bpAybWUFK9Rwcy/0si2w5PuptltN0dbzaP8GRzDZ20L0IKbpyzIFTeNVDjxUAs
	2pwSfU/zQyOJIM7Uy5f9kztOA5UfF1aGut8SG/ZIBPjG30/+QDpiF9cp0xpxp/0fKfDPQO
	T25Cw40SNEgdq9eGisAak44HgRBKxgZhk5DiYXKyZDqPgFwPO3HAfFKIoHU1M/nPl2P6uY
	HlPJtaZBWfi/4Z/nuLK7Jw==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 814b2cdb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Sep 2026 16:06:02 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 16:06:02 +0200
Message-Id: <DL41D2NGEUHW.2UUHTZ6LLM9X7@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Alfonso Kuen" <gerencia@idkmanager.com>, <hch@lst.de>,
 <sagi@grimberg.me>, <kch@nvidia.com>
Cc: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] nvmet-tcp: report a bounded MDTS instead of "no
 limit"
X-Mailer: aerc 0.22.0
References: <20260829013900.10392-1-gerencia@idkmanager.com>
 <20260831005117.142713-1-gerencia@idkmanager.com>
In-Reply-To: <20260831005117.142713-1-gerencia@idkmanager.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_070611_871761_80DB55E5 
X-CRM114-Status: GOOD (  13.16  )
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

On Mon Aug 31, 2026 at 2:51 AM CEST, Alfonso Kuen wrote:
> nvmet-tcp does not implement .get_mdts, so nvmet_ctrl_mdts() falls back
> to the port value (0 by default) and identify-controller advertises "no
> maximum data transfer size". The initiator believes it:
> nvme_init_ctrl_finish() sets max_hw_sectors to UINT_MAX.
>
> What the initiator then issues is decided by the block layer. The
> generic cap is 4 MiB (BLK_DEF_MAX_SECTORS_CAP), but a namespace that
> advertises a large NOWS raises it: blk_validate_limits() takes
> max_sectors from io_opt once io_opt exceeds that cap. On the array we
> measured, NOWS is 65535, so io_opt is 32 MiB and the initiator emitted
> 32 MiB commands -- from a controller that advertised no MDTS at all.
>
> The target cannot serve those, in one of two ways depending on the
> kernel.
>
> Since commit 4a3f00262a04 ("nvmet-tcp: bound SGL data length before
> allocating command buffers"), nvmet_tcp_map_data() rejects any len above
> NVMET_TCP_MAXH2CDATA (4 MiB) with NVME_SC_SGL_INVALID_DATA | DNR, so the
> command fails hard and deterministically. That is the right response to
> an oversized command, but the initiator had no way to avoid sending it:
> nothing advertised the limit it was exceeding.

#define NVMET_TCP_MAXH2CDATA  0x400000 /* 16M arbitrary limit */

So the comment should be fixed, it says NVMET_TCP_MAXH2CDATA is 16M.

Also, it's not entirely clear to me how the target enforces this. Suppose a=
n
host sends a 2 MiB command, violating the MDTS setting, what happens?

Maurizio


