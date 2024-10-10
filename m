Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECB3CF11FC
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y/dxbxyqdi09lBF2k9u+Be4q8E+Eb8ysp5l4NxPf81U=; b=Rg2rrZ35iywUh7QrPWzROiQWLn
	yzcmod3yq5kgbz7PklOKbBnETs+dprcmYRSKqi8v2xW5BziXpOieRIfz0MXQgVrIFjUqX9mJQHfC/
	0oIUK+88NZo3+ytKRGckBrHnxOHJJKh/2bqHugYvf395ONI/6NxHJ64NfOZUmEHwn8X/GhPw3B/3r
	YKz4uJpDHNGL+NMgELR8BIJL+VcgGSgH2Zftp2GLoiHMu/+MMJgAs5YkRIaGwNXaVfA6vpDXj4mCS
	EHJ3rb4QHTyQ0Wzeg5aoFwIJGx1AljQt4u+gzauFO68dpDvnql32mwogj07DdXA/9M6+vN4+KAYtn
	RRXN48ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syv4p-0000000DKTP-2GIr;
	Thu, 10 Oct 2024 15:27:43 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syupJ-0000000DGzn-2sdp
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 15:11:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3A487A449A3;
	Thu, 10 Oct 2024 15:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47457C4CEC5;
	Thu, 10 Oct 2024 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728573100;
	bh=q2xYunycVCn9dqLO5dMumhrjfa4xelIfmUXZb73bF/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1UxYc7KqIb4B8O6H0MVwZlrMvj8JZwGO5gP2NKby5aPX8nwt+JR1Wzag3p2biJBN
	 w8qedrqZweymNvVka70l8vP98LJviWkDRf3vhZH1drAm1MYECrOaHPMDkwHQlfb2d5
	 rGYkhtBJkr7QxSGyVwpmMHiq9ogiwe5Bzij8JUAP3EdL5eiplAXm8rcbOxmooOB3gz
	 xl2yv0GQatWhbHitT/olDR80IrjpeQA0oy1fzWXSJxKIi09P2kxafIva+8ySsy8XJe
	 jBnrT88R5hWbjDXyx413M/eFjZDhyJzsz6NpkxL1SBkxAThOPXnynx+7p+46oKMizI
	 3ujW6fYII/Ocg==
Date: Thu, 10 Oct 2024 09:11:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix cns check
Message-ID: <Zwfuqf_PAP06GG1-@kbusch-mbp>
References: <20241009214035.3851406-1-kbusch@meta.com>
 <20241010075633.GB7525@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010075633.GB7525@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_081141_809602_F85AC6DA 
X-CRM114-Status: GOOD (  18.58  )
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

On Thu, Oct 10, 2024 at 09:56:33AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 09, 2024 at 02:40:35PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The 1.1 spec defined two bits for the Identify CNS field, so such an
> > implementation wouldn't be expected to check the full byte for a
> > decoding it. Provide a different helper function to make these
> > decisions as the existing check only separates the single-bit from the
> > two-bit spec versions.
> 
> I don't really understand what this is trying to solve.  Is there a
> controller in the wild reporting 1.1 compliance but reporting useful
> information in the NVM Command Set specific Identify Controller data
> structure?

It's not going to return anything useful. The 1.1 compliant controller
truncates Command Set Specific ID Ctrl (CNS 06h) to just two bits (2h),
believing the host requested the a namespace list, and the host will
think the success means it has different identification data.

I was only thinking about this because of the rotational media patches
were using the same criteria that would let a 1.1 complaint controller
see another Identify that will have a truncated CNS.

