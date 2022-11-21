Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9093C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 07:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1USMY342ufbhVkYWg7zVWEDq4c9lvCMWGAZvLKCLMI4=; b=48IQI2d1rlA7joPS0C/1BMX68Y
	Zp8jvloVA1uZ/L5kQ2Zql+1xLbvwQb8Fjs6B8ePkioFxxERbtX8oyaE8VfuUXjDTM/5o77UblbJgC
	z9Wo6amnvJpUizkG3sG0BKIAKBj+mJDVxUxnsdvQ4jY0LOJLTIdoo0OpF0R97boKnr7MxXvQyHCf4
	A068OFK/u2X8VRCRNWgTMxRLrMnKM3t3buFuvwudhYgiQWLa6jzq1Nl05+Re4bNORw3tIXaSQ6gjj
	AEg2Lnwakk+hoSomEWaIhyfQHWhbccQswQiyCipPdewa8BbL2/6gfCk3qvX6PEsZ7Cb64Q+MbWPYA
	ftBUIGUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox1Ul-00AYk7-9s; Mon, 21 Nov 2022 07:45:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox1Ue-00AYdK-5n
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 07:45:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7723168AA6; Mon, 21 Nov 2022 08:45:25 +0100 (CET)
Date: Mon, 21 Nov 2022 08:45:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: block dangerous passthrough operation
Message-ID: <20221121074524.GC24507@lst.de>
References: <20221116130104.2186334-1-hch@lst.de> <Y3UL2LER7I9KUxGW@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3UL2LER7I9KUxGW@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221120_234528_411962_7ADE1599 
X-CRM114-Status: GOOD (  16.98  )
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

On Wed, Nov 16, 2022 at 09:12:08AM -0700, Keith Busch wrote:
> People do use the fabrics command for 'get property' to check on their
> device, which is a harmless command that you've blocked.

Yeah, I guess read fabrics commnds are ok.

> There are still other harmful things a user could do, like Doorbell
> Buffer Config or Set Feature Host Memory Buffer that could really screw
> things up for the driver. But I think this sets a bad precedence that
> the driver is going to protect an admin user from doing stupid things.
> As more destructive opcodes and features are added in the future, we'd
> be taking on a maintenance burden to analyze all these. Meanwhile, older
> drivers won't provide that protection, so the user is expected to simply
> not do such actions, so why can't they just do that now?

It's a little less about preventing all possible problems, than about
at least letting people known they're doing something totally broken
and not report bugs to me about them..

