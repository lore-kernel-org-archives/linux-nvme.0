Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4848C25B50
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 18:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HcBEZbBiHfm+jffmTNnSQ6lXYGZsrGLOKhJIRTiA7Cc=; b=Q4+Hw2GcANGmmdihtaafIUBfRb
	O8BRD/mub5s2Hf5z3NXp2alwwG9wHkc0jLwKGEKc7LU6x5hXc32CfJtnnonV9Vl/PA0hSDTM2za8U
	k7yrVROHycUcmcS2leQfqoQ25ysblP1uRwu0oymWBaT/0LJ2mwaUL0lMMe5nsOZ4WSSyb+PX6uowB
	Q8pVQ2iiNQJFQTYOrd+k7Q4w53pCPnYKXDFQmEk+BQEx2tFrgBRGTq13MiwM8DvviU+ruUnsQ5n8o
	epCbJVmFJY8TLSyUDB4IzbvehqFZx501sW7p7nyziBAI3lxYwQFNsN70HGSFNF0N3KnfluMR/dC4s
	RjxIj5QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK19M-000wkc-5O; Mon, 23 Jan 2023 18:02:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK19J-000wjO-5Q
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 18:02:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 60FC868C7B; Mon, 23 Jan 2023 19:02:20 +0100 (CET)
Date: Mon, 23 Jan 2023 19:02:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCHv2] nvme: always initialize known command effects
Message-ID: <20230123180219.GB13872@lst.de>
References: <CGME20230119164739epcas5p17673bc9fb1b91d7c85561af220a230eb@epcas5p1.samsung.com> <20230119164128.2159217-1-kbusch@meta.com> <20230123102431.GA11000@green5> <Y8617zOJDMka7J0h@kbusch-mbp.dhcp.thefacebook.com> <20230123163536.GA7699@lst.de> <20230123163819.GA8009@lst.de> <Y87HFanyksHLp7BO@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y87HFanyksHLp7BO@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_100229_382999_7BC639D0 
X-CRM114-Status: GOOD (  14.23  )
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

On Mon, Jan 23, 2023 at 10:42:45AM -0700, Keith Busch wrote:
> xarray lookups are pretty slow in comparison, though. This is in a fast
> path now, so I think we need to keep caching it.

Is it?

> Alternatively, we could replace the xarray with a normal array sized to
> highest seen CSI. Realisitically, I don't think we'll see a CSI higher
> than 3 any time soon, so it wouldn't take up much space.

The problem is that we lose the extensibility to arbitrary command
sets for the ng devices.  So if the xarray performance is a problem
let's not waste any time on this idea.

