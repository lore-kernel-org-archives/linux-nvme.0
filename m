Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BFCD2FEFA
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jan 2026 23:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gvg+KL+p9iL3LDrzCotUTjZEL/MGn9Yuo9iU3AkfHLg=; b=2mAxcAtPLOdsCef+Ce0LyF6jQH
	3XUhjGu7768LjLy0cHuwmsR1oWXJXJLjBfiVmkxVc5NipMaF/dpHwskX3Xt8+NPpxvy/S0Ez8hQdf
	WtKGO65sN8UlyeRdQk8BBZ3wON6qvOFJgw5O+h0tRzoSxMsFJcCbeBbR4bVMLqnXJZ6wIrG8W/maa
	YIqRkch/Xa1Nnt64YrhsPAj+5NWXqZKMeobxAmzjfd9OjkzLHOqGXu/SUP28q0povJa4DgEaVm08N
	/dCaO0pzt7l598XOVV0lFo/Z9w91vrSYr9hLalYhbWD00EbBT7kX1ZPRu3Yow9vmLQ+nQ/ajgc5bR
	lQTTTxrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vksiz-0000000FB8k-18Gf;
	Tue, 27 Jan 2026 23:43:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vksiy-0000000FB8e-1zNu
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jan 2026 23:43:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7A448600AD;
	Tue, 27 Jan 2026 23:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9286C116C6;
	Tue, 27 Jan 2026 23:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769557435;
	bh=OMhj9HFljtIwwHJh7FSuYoEToi/s+9/KcIkDHzxBAx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dnDtUWKUjsKZSPW6cCoVZUBCqdwQH1zXSQ2uHfmnpna8BVqnrTloRnLW0gaTjv+sd
	 GbATGPGyMURARYSltUXy16uFdkjBO5fGPjARwIiEl6nam9U1D0JI2wKIPw1FzZ+e73
	 27BTSa6n1+wRPx57Uv5bzXGNU1d2+yFwnmcXl0NoeTRZwokAU3U4LKeKZNYx1IjDfZ
	 iHztcK3YDnto3q79zE29fB7/UdwvZ6MYe6NelX/GDbD2gi+GFLApnr0qFQUnV4ITPq
	 wgY/naCwpzK2LddTKQzTiQWsTDpQ+bsDY6FrIjZ0dw4md1eG2etusc6tIskJpMtB/6
	 sA7J6nxY+JkRg==
Date: Tue, 27 Jan 2026 15:43:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Qinyun Tan <qinyuntan@linux.alibaba.com>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Xunlei Pang <xlpang@linux.alibaba.com>,
 Guixin Liu <kanie@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
 Guanghui Feng <guanghuifeng@linux.alibaba.com>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V1] nvme-pci: disable SR-IOV VFs on driver unbind
Message-ID: <20260127154353.4c115e36@kernel.org>
In-Reply-To: <20260127230912.GA385193@bhelgaas>
References: <197d75a2-4286-41fb-ab4f-9ad744885bb4@app.fastmail.com>
	<20260127230912.GA385193@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 27 Jan 2026 17:09:12 -0600 Bjorn Helgaas wrote:
> > > If this is expected, should the warn message "driver left SR-IOV
> > > enabled after remove" be downgraded to 'info' level?  
> > 
> > It is not important, no one complained about it. People who unbind
> > PF, simply ignore this warning.
> > 
> > BTW, the use case which I presented is for SR-IOV handled by
> > drivers. Maybe VFs created by NVMe are different here and they must
> > be destroyed.  
> 
> If it's to be expected, I do think 'info' would be more appropriate,
> if nothing else as an indication to code readers that nothing is
> wrong.  Or maybe even no message at all.  Or maybe the fact that we
> reset the driver_max_VFs value is of more interest.

FWIW I probably just added that message because most drivers end up
printing something along those lines. Tho, I strongly suspect it's
a mindless copy/paste in majority of the cases. No preference here.

