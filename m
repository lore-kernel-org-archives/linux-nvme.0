Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6BDC33CB9
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 15:39:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCEF214AF
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 15:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G+N9iegU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTCDVmJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCEF214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kt99soveftDiwKJ8uV/PAtVwti4tRPPmPmUKTPLEM8Y=; b=G+N9iegUSU+xQZ
	MDRqJFj+kJFvq4c25jT6o4D6UoK12L2w7IeebXPT8hKRpX50VPiHAzPL/F7l9UJbfMmpaDRmoAg4u
	nGNV8euJGxjCslwYokQpyoSek+zdElifqLRCTSp/w+1U4SScuvN66wDbkF+dj2whKyd8OwZ9zGlWX
	hyc/ZnfLiscB/+lRUmam9N0u27N76KzShWDPpORYCqMUHh7uCHFp8rDZq6L8NfC9GyM5qvc+ZcCZI
	ydIbs9hIZQHFX0D12jZNX/0ADkmKrquBnzo3qUk0luVeOsPTmx5NMbcc+bqR1DYq3NuBzBECLb3YN
	OX1rmyiFqBPPBsedAN3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibnnR-0002QS-EG; Mon, 02 Dec 2019 15:39:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibnnO-0002Ot-0t
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 15:39:31 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 13B232084F;
 Mon,  2 Dec 2019 15:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575301168;
 bh=WUeCbwbZl+dMge+efOSDlOAMp0vXqdS3EjUC/UJaLd8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YTCDVmJy6Wy7W4o4pLElWVl/cVEBnV3OabzbFT14icQejrjU97i/DcSDZm0bAXqjo
 IWWj8vSZ/B2BTS4rUrJ/Q6z0cPZPcSC2Y3EDJIlmhfNPL+BkoPPSncY5JQy3hWrrgc
 IAPCocVA5ijhjfjqDUKI56+6VurnNo3hQosdJgHw=
Date: Tue, 3 Dec 2019 00:39:25 +0900
From: Keith Busch <kbusch@kernel.org>
To: Ingo Brunberg <ingo_brunberg@web.de>
Subject: Re: Regression: kernel 5.4 does not show NVME SSD
Message-ID: <20191202153925.GA8561@redsun51.ssa.fujisawa.hgst.com>
References: <m3fti36pll.fsf@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m3fti36pll.fsf@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_073930_098097_120E8EE6 
X-CRM114-Status: GOOD (  10.80  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 02, 2019 at 10:31:18AM +0100, Ingo Brunberg wrote:
> Hi experts,
> 
> starting with linux kernel 5.4 my NVME SSD from HP is no longer detected
> correctly, nvme list shows no result. I made no relevant changes
> regarding .config between kernels 5.3 and 5.4.
> 
> Please have a look at this bugzilla entry:
> https://bugzilla.kernel.org/show_bug.cgi?id=205679
> 
> Maybe all SSDs with a Silicon Motion 2263 controller are affected.
> If you need more information, please ask.

It's a regression from commit 538af88ea7d9de241e6b6f006e9049c4d96723bb.
This one should have only returned the error if < 0, otherwise we can
proceed. Will get post a patch shortly with a 5.4 stable request.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
