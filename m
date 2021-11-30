Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F3AC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 14:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:References:
	In-reply-to:Content-transfer-encoding:Content-type:MIME-Version:Subject:From:
	cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BZYi9ht2xy65JyC43IPolVUMbyaxhCW/7gh9Gp9ztQE=; b=atDzUsXXhYQkhF+4oMLE1SQnEu
	/fFNrf7b57C+El1a74Ek16Owo3R6FW6yZhm1s1QQk4emtfyn1PnrY0jQjq2XZ8zLuQNOkHMNt5AKr
	hNNV//SsJSR15fsj/caD28mvoVM/gD9FpJXDWQ6kj0BD179D0fOjwZuMJ9bVtQJxVYV7ZjDYPsnkv
	y9ulXZNYuwlngoF2uR650UXTVhop0H0Q0LkCl72YKwQjY33R8CpmNhwHfbubYf8x+mKrnT26QJdVi
	+bRfPnIUpxRk2Io4Eujw18RHLNs1rDOnZgRpPw6xrC1vqjzOKmajEo0p+gIjxc9dGoalRk6iI296s
	cpwXBwwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms4P1-005fMV-18; Tue, 30 Nov 2021 14:46:39 +0000
Received: from phobos.denx.de ([85.214.62.61])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms4Ow-005fLR-I0
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 14:46:36 +0000
Received: from janitor.denx.de (unknown [62.91.23.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: noc@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 48F3780934
 for <linux-nvme@lists.infradead.org>; Tue, 30 Nov 2021 15:46:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1638283591;
 bh=BZYi9ht2xy65JyC43IPolVUMbyaxhCW/7gh9Gp9ztQE=;
 h=To:cc:From:Subject:In-reply-to:References:Date:From;
 b=GNoFB6LYCzJk67puZ34YgP0GzMEsxMhk/KY5AjDS0CotVlfCu4Eu4JdMWtQZwjY4h
 WxuOOAKoARYScACMJ/yBmSBv1upv7va/zcoqsN7Ybms4N/flq1yVLZNYr3zjxscK7k
 uOtzHGZg89PXXrIUBEOYJ/xQche+e6DT+7kq6BRHii3muXAd1GeWRzu62LyZE2XBea
 s3yr+zQFAhXTYJfFaA8mfa6j3IN0rlT91N31UtTDTVetMxnSBhQOlQibvMPHkgohno
 AKlO9uTMBrvYoWCj/p9qSFZfQMX+/HcGhO9Q2WI32tFMAdo7QKYybRPqph/n1JrmR5
 /rZh8ilCjaTNw==
Received: by janitor.denx.de (Postfix, from userid 108)
 id B8987A0254; Tue, 30 Nov 2021 15:46:30 +0100 (CET)
Received: from gemini.denx.de (gemini.denx.de [10.4.0.2])
 by janitor.denx.de (Postfix) with ESMTPS id 8D5B6A00AA;
 Tue, 30 Nov 2021 15:46:25 +0100 (CET)
Received: from gemini.denx.de (localhost [IPv6:::1])
 by gemini.denx.de (Postfix) with ESMTP id 253191E0BCB;
 Tue, 30 Nov 2021 15:46:25 +0100 (CET)
To: Paul Menzel <pmenzel@molgen.mpg.de>
cc: linux-raid@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-accelerators@lists.ozlabs.org, linux-nvme@lists.infradead.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Using aGPU for RAID calculations (proprietary GRAID SupremeRAID)
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <ccdbb0d7-d043-d41f-508b-4a464ffa5fe9@molgen.mpg.de>
References: <ccdbb0d7-d043-d41f-508b-4a464ffa5fe9@molgen.mpg.de>
Comments: In-reply-to Paul Menzel <pmenzel@molgen.mpg.de>
 message dated "Tue, 30 Nov 2021 12:58:10 +0100."
Date: Tue, 30 Nov 2021 15:46:25 +0100
Message-ID: <3846571.1638283585@gemini.denx.de>
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_064634_787199_BD127112 
X-CRM114-Status: GOOD (  22.77  )
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

Dear Paul,

In message <ccdbb0d7-d043-d41f-508b-4a464ffa5fe9@molgen.mpg.de> you wrote:
> 
> I read about GRAID SupremeRAID [1], which seems to be an Nvidia T1000 
> card and software to use the card for RAID calculations.

I doubt this is an efficient way.

The (IMHO) most efficient solution I have seen so far was the AMCC
PPC440SPe Power Architecture processors.  These we able to calculate
the needed parity information on the fly in the DMA controller while
writing the data to disk.

> Does the Linux kernel already have an API to offload calculations to 
> accelerator cards, so it’s basically plug and play (with AMD graphics 
> cards for example using HSA/KFD)? Entropy sources, like the ChaosKey 
> [3], work like that. If not, would the implementation go under `lib/raid6`?

We implemented Linux driver support for adma/async_tx/raid6 for this
hardware, but that was a long time ago (2008/2009), and I doubt this
has been tested recently.  But at least some code is still in
mainline, see for example arch/powerpc/platforms/44x/ppc440spe_dma_engines.c


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Another megabytes the dust.

