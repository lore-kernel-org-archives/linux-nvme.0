Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A63C2D0D1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 16:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ucCjufWNtloYF8Y4bcKPOFdQ55dTLUOQckRrl0lEMkw=; b=rNtgXutg6KNN/xBSlsT4rCXPMl
	4ZNiiV5rIflkAjwPrf8r50hBea7ZXzr/SCDkLgrFUSrtiU2BXTNTccekpzwleGnRScBNPJQNeAvuj
	SlfxRpTyK6EBmRkfpLh/vz5ilV2rwcnYHNcMTF4bRG39DM1rZsW2B3kytt0C0Vtyg++huZGTbLq+N
	Ii5OOz3XXriPwm7zKv5Qiio+nRQxPSRAPEatNjfpwyzi+IdwxjQoShh6gdtepTr8vWFoi2l722nB+
	p5p0Xp7q+VmEj1nLw6GxRtbYrMt3tEkKn5jwVK0S7T4JZT+zu8xLKfniEoOIZ95LizNmoG6CtYfAT
	DBl8bNxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLmUh-0000000HUpZ-3g4k;
	Mon, 24 Jun 2024 16:24:39 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLmUe-0000000HUn1-1IsG
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 16:24:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5776ECE12FF;
	Mon, 24 Jun 2024 16:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D4AC2BBFC;
	Mon, 24 Jun 2024 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719246273;
	bh=k4877w6NmB1H+pv7SGS3oTvuIec0YKiqmhwOGxlts3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jy90/SdTJrZnWwm/nlhxmVU7buOwncNjPXV4LsQzqB3MABVnWUaaR/CIbCgMxokdu
	 mhQ+QmDZEoRDxdUIJWe01PB88k7tA7FVWw/a5HVqJBVshkk4rG2YIJ0eKKNwHCLtPJ
	 rIaHSbOX4lzGDKEoDJqGJ0+876BeRH0VJHNxUYSJaBTTmI19tebOiBweCYbp7G8sW4
	 37AghbSobBvPfG1mNIpRaGY+qjiCs0QWHvNXchufeDOOPl0mw74CzPZ3UTDwlZALwz
	 adywbwrZ3SRSj/ccvs77ltu9DUuOAwJUh3ekAFx4cYjzQdyqOjMNkj6LOY1nZgR2Tq
	 DboxBs3rObWww==
Date: Mon, 24 Jun 2024 10:24:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH] nvme-pci: let platform handle subsystem reset fallout
Message-ID: <ZnmdvoDT2-aL-NXC@kbusch-mbp.dhcp.thefacebook.com>
References: <20240624160756.1978565-1-kbusch@meta.com>
 <20240624161558.GA16570@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624161558.GA16570@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_092436_553144_A35A98B1 
X-CRM114-Status: GOOD (  14.70  )
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

On Mon, Jun 24, 2024 at 06:15:58PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 24, 2024 at 09:07:56AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Scheduling reset_work after a nvme subsystem reset is expected to fail,
> > but this also prevents potential handling the platform may provide from
> > successfully recovering the link without re-enumeration. Provide a pci
> > specific operation that safely initiates a subsystem reset, and instead
> > of scheduling reset work, read back the status register to trigger a
> > pcie read error.
> 
> What does platform mean here?

I'm thinking of pcie port serices: AER, DPC, or hotplug. Nilay's power
platfrom has their own proprietary mechanism called EEH.

If you're platform has none of these, you'll have to wait for an IO
timeout for the driver to try to do anything to recover. Before this
patch, the driver would just quickly unbind.

