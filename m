Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92418C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 06:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fP+RrHyqCRlZyaF/lQ7UPvl/XvpABQJsRdX+0k/V1Tc=; b=HM9d4YSQbUDqY1S+acFHFaM6Fx
	w3VIcya0DMST03HhQ6vR+aWNrZKzshyffqvpYEbWPitmq1wevPwFXl1iSFovyjJ8FwSR0FfKFSx2q
	w9NEs8b1WIosk3YhHzccTYCYQj+tBt6bVCLewucJcEjQC4nf/DYFrQv72rW7CDRTq/a3eGp/bYLzX
	UZq9aZ9rs3spLh1fsKB4SVcn21gi0i8aAHpYDD53MXkVaRRqevRv8bZfAKDTGzp4bxqHsPnLE5tcn
	gVwqgLCShV7lcxwI35oCqODVpqIalZzblGfyRXpa98j2WYkfTUvUdL98ljzFgqBI1q0dy2lnDkEc3
	iDulVNVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndnEt-006sFQ-P4; Mon, 11 Apr 2022 06:09:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndnEr-006sEb-6E
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 06:09:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7486D68AFE; Mon, 11 Apr 2022 08:09:22 +0200 (CEST)
Date: Mon, 11 Apr 2022 08:09:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220411060922.GB14519@lst.de>
References: <20220224192845.1097602-1-hch@lst.de>
 <20220224192845.1097602-5-hch@lst.de> <Yk+KO8hEYpnKdGu3@garbanzo>
 <20220408052907.GA31990@lst.de>
 <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de> <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
 <20220411050533.GB13927@lst.de> <20220411055455.GA14480@lst.de>
 <YlPET+kw4EVWfPRy@apples>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlPET+kw4EVWfPRy@apples>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220410_230925_420318_5D3AE417 
X-CRM114-Status: GOOD (  18.12  )
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

On Mon, Apr 11, 2022 at 08:01:51AM +0200, Klaus Jensen wrote:
> 
> > I can also not find any code that would assign a different uuid
> > when using a different command line syntax, but given how unusable
> > the new syntax is I've not actually been able to try it.
> > 
> 
> Are you referring to -device nvme-ns "syntax"?

Yes.

> Luckily we can do that easier now since we moved away from the Intel id
> (which got rid of a bunch of quirks at that time).
> 
> I'll see what we can come up with to fix this properly in QEMU.

Thanks.  Please Cc me on the patches.  My qemu-foo is getting a little
rusty, but I should still be able to help with the spec side.

