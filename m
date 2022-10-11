Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B329C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Oct 2022 18:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AHesqL1PU3tYkN4PCUxruggBEesUCjmvDqCJWTq66jY=; b=ZT1bwSZA0aRhs/XHvrDkLe+ggO
	4kyi9gBhy5dprhCPNuvpMsngbWppNDpGUVDIxzImSTXsMc51biqSWpJ5XcXbZ/varacvgbu1ZsIjA
	ehwM6azJPRdMHL+mH2BGB7FgO2efppG9gB1c8d1qKu+SBKhaTGAM0eHdPu9JPpcriTz6qdaE1ZmPL
	yzfAz91RWiOviiYOsJsiI7/VyCEoKISZg4oX7rzjYMhEPTpLIzSE6DeuRkLYHyZyE1b77A5eU4U+Y
	4ucn/EeL+m6O9ihwZlkL9CfF1Cq9SpVRIol+tGWydxLQ1CDZjtsdF1C/b/n/gxkx9TYa7ChzedP/2
	mMgYyo8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiJvN-005Qq4-W2; Tue, 11 Oct 2022 18:24:18 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiJvL-005Qnt-W4
	for linux-nvme@lists.infradead.org; Tue, 11 Oct 2022 18:24:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 5B703B8165B;
	Tue, 11 Oct 2022 18:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7791CC433D6;
	Tue, 11 Oct 2022 18:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1665512651;
	bh=KS86MgZUsJFlt5BXRqWspAaxPjZljTkZi5/nzYdd054=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yqqHgWMgeXWiOzY7cNVnqWXW0rBP83QwCvij3MBqoEiXcl/VqFSSP6Hvvlfvy69Z1
	 xzLENh+WVkA3E6Ki85A3jRWweJi1Jlu1O1HwlRJOnNQIWkkPt+g9o4SF02MUJzPuey
	 aikstgZTnqxleHHrs3ulEmBfUZw/aSY67PklmKKE=
Date: Tue, 11 Oct 2022 20:24:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Bhatnagar, Rishabh" <risbhat@amazon.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@fb.com" <axboe@fb.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"Bacco, Mike" <mbacco@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Park, SeongJae" <sjpark@amazon.com>
Subject: Re: [PATCH v2] nvme-pci: Set min align mask before calculating
 max_hw_sectors
Message-ID: <Y0W09tcGK/1ZAhQh@kroah.com>
References: <20220929182259.22523-1-risbhat@amazon.com>
 <EB43F4D1-BFD0-408B-93E7-10643B59F766@amazon.com>
 <b73250f3-2dd6-36da-4d69-3149959f2e67@amazon.com>
 <20221011060829.GA3172@lst.de>
 <8f451a9e-3324-c7d4-cf61-a105fd087192@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f451a9e-3324-c7d4-cf61-a105fd087192@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_112416_208121_426ABF60 
X-CRM114-Status: GOOD (  18.18  )
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

On Tue, Oct 11, 2022 at 10:05:38AM -0700, Bhatnagar, Rishabh wrote:
> 
> On 10/10/22 11:08 PM, hch@lst.de wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > The patch already made it to Linux 6.0, so I'm not sure what we need
> > to review again.
> 
> Oh, I never got any email that this was being picked up so sent it again.
> Anyways thanks for taking it.
> We need this patch for 5.10/5.15 stable kernels as well. I can send backport
> patches to stable tree
> maintainers unless there is a way for you to mark it so that its
> automatically picked for stable trees.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

