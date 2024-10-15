Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AE3CFC277
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VFJVYSX+QMrcdwIRxiKLj++JTIvvQIbM+zUoRL6Wn0g=; b=xeda31Gy00jPtvf5JmgWytewGz
	+F/tWWtAIaPMcs3+BbTDR7+HCKTEk43UGOFRn9G/8pXzf6YMpGpfnSyz8uoDIpX3gk56JBNCygjAW
	k6GfTmxM0IC5AcyC/QFHJFfefyuY0lpLagfPKyaNNjmuDMvLGqQIKKaes0Xz2zGWAvUev2F1O1Pse
	nBPlXTwhcrcI/9Z3fNwdlN+nPXG/un/l+nwewW8Vs5mNMwKbIX/p08p7GeGceZiUJ4TmGYuYySn+a
	bvFa2toQ/xbNn3qXvpLSwhe1vv/f2jmvK1g/4gEc2RaP2X7FGOIQsAfhtNMaLo/MzZJfddSI48FZ6
	H0pqHSaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0jNY-00000008gR1-1Cso;
	Tue, 15 Oct 2024 15:22:32 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0jLs-00000008gD8-3yDc
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 15:20:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 31354A43249;
	Tue, 15 Oct 2024 15:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC93C4CEC6;
	Tue, 15 Oct 2024 15:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729005647;
	bh=zRvb1polYVKwntKvWolch0TCa+/KTziUqbokBUk0ieg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lsgarw8lWY1f1R9Fn+HHELkPIK5InyuOO5EQbjpFLSQ3oqxnJ7QVlLksmF6GwNt2C
	 yVXPyHIhWFqAPgq+NLEecu5ODuaPAe3NiizBLtTTJXlUAUPrQrv8C48mBx5jjzFl6l
	 /TI4EpwYIBLAvm6pHZf1gFB4Oo9RFSn9eelfriWb+Rsn1zfXdu1u0+vGwttIjCcWn8
	 4mzrACAAFZXGw5yzAaznYlAKZudhNI9yCwpHTxEogDX2Szww6IpxoM6J38uOcWqjnW
	 nVcl3R40OsRioKOAZ+R/W5iFsBppsWYC2eyi8rIdCi3AC6pHAynl/YzxvBfQbax3PD
	 xhkKstAkUDM7g==
Date: Tue, 15 Oct 2024 09:20:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix cns check
Message-ID: <Zw6ITWUcED_Heb6W@kbusch-mbp>
References: <20241009214035.3851406-1-kbusch@meta.com>
 <20241010075633.GB7525@lst.de>
 <Zwfuqf_PAP06GG1-@kbusch-mbp>
 <20241011080925.GE2749@lst.de>
 <Zw5930diGlfHACzF@kbusch-mbp>
 <20241015151652.GA12532@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015151652.GA12532@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_082049_074328_6E9BEBA4 
X-CRM114-Status: GOOD (  13.35  )
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

On Tue, Oct 15, 2024 at 05:16:52PM +0200, Christoph Hellwig wrote:
> On Tue, Oct 15, 2024 at 08:36:15AM -0600, Keith Busch wrote:
> > I like this idea, and the spec makes it seem safe enough to assume the
> > tertiary version number is always 0 for 1.0 and 1.1 controllers. So
> > yeah, this looks good to me.
> 
> Do you want to pick this up, or do you want me to send a patch?

I'll respin a patch with this idea. I'm just catching up from a short
vacation, so might need one more day to get a v2 out.

