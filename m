Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBF6C54798
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Feb 2024 18:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kwq2Y80R0MTXyLkuo/lA99aUCVCPWrQAMq7jiLb7niA=; b=yNVv69pUPg9KV3waq5z+YOHG7W
	xsMR5L847LMBIjQli9TkBjQ18ePoILNUnqu8Y4qA5vmcJqVzjx5P1qOpIj7txqK7hodPIcdNu4q5E
	M91zmu7UeWFWaOAdNs8DJoWj/DhdvLuRwsD0eJVOWlYe4Wa3e5BZky5OAdxATzTzACZAwqk04bHVb
	AUmWMpYeZcmhdnVyX0PoFSdSf6dfefcdoWmyPlHizINcspGkZPcZpRTf3s+sUIIdQXNA14wCkteZm
	s/WLrLnFeYo65PtwTBHj1uj4bdwccvKAPQ4ZfJN4rUjC65E2JbyOoKus7w1NdaefLjplMDErJR982
	wxFMu6fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf2Ch-00000006Roj-1T9Q;
	Tue, 27 Feb 2024 18:29:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf2Ce-00000006Ro5-28mH
	for linux-nvme@lists.infradead.org;
	Tue, 27 Feb 2024 18:29:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BC1AE61451;
	Tue, 27 Feb 2024 18:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC00C433C7;
	Tue, 27 Feb 2024 18:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709058559;
	bh=3XymNxDkFbhY5R7fE/z627+i0nNxZtlgL9dicFODkrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYLSD8obQjna/PAKYYmJFEHZXq6ST52AA7uANdkzub7wB1op0KcR3W+HP8Wp9VeEp
	 JcIjL3mZIbMBec9zvJ5RbQXQidAz9gkgbZBfgOKmhS5514bb+QFzGEOr2X+G/UrzSy
	 kW86NCGY6N5N8DjOt2NT+4vD2SXQLFKZz9eEmUL5xZxLcH9EDONg5ox40LhpoMV6Ji
	 TD6NsV6aVgoTnonAM21lPPUU7nPuVGZlIfciH2jHBbQUcEeeo0Dikd85rQ5gt8vNCl
	 +Kf+3liEJlv/r2Sl+nxc2L6mwPUKbiAQYiXEuXF5DB0oZGjOZLwF1w81ksg08UySVt
	 I85zq1SrsvJYg==
Date: Tue, 27 Feb 2024 11:29:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
Message-ID: <Zd4p_E8cPFpr1M--@kbusch-mbp>
References: <20240209050342.406184-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209050342.406184-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_102920_625087_49919F27 
X-CRM114-Status: GOOD (  17.59  )
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

On Fri, Feb 09, 2024 at 10:32:16AM +0530, Nilay Shroff wrote:
> If the nvme subsyetm reset causes the loss of communication to the nvme
> adapter then EEH could potnetially recover the adapter. The detection of
> comminication loss to the adapter only happens when the nvme driver
> attempts to read an MMIO register.
> 
> The nvme subsystem reset command writes 0x4E564D65 to NSSR register and
> schedule adapter reset.In the case nvme subsystem reset caused the loss
> of communication to the nvme adapter then either IO timeout event or
> adapter reset handler could detect it. If IO timeout even could detect
> loss of communication then EEH handler is able to recover the
> communication to the adapter. This change was implemented in 651438bb0af5
> (nvme-pci: Fix EEH failure on ppc). However if the adapter communication
> loss is detected in nvme reset work handler then EEH is unable to
> successfully finish the adapter recovery.
> 
> This patch ensures that,
> - nvme driver reset handler would observer pci channel was offline after
>   a failed MMIO read and avoids marking the controller state to DEAD and
>   thus gives a fair chance to EEH handler to recover the nvme adapter.
> 
> - if nvme controller is already in RESETTNG state and pci channel frozen
>   error is detected then  nvme driver pci-error-handler code sends the
>   correct error code (PCI_ERS_RESULT_NEED_RESET) back to the EEH handler
>   so that EEH handler could proceed with the pci slot reset.

A subsystem reset takes the link down. I'm pretty sure the proper way to
recover from it requires pcie hotplug support.

