Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995B5C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 05:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oSox2m9UXBXj/OtL8p2pEHXwGkJtQI9EruY7XrcqMIU=; b=zzZmfNNeFLlfFo108/iXs769eZ
	OYcXejShQn57ndSl1G6ozLJg3g0PtjwHHSl6N7Tno+6iliGZAXaXz/vn44fvY5y4v0Q3hA/Y9i28a
	pfzruLSGSOHX2ICeTyU1rrWg1caI0j2Kp7hI5wZ4QHHrqCW0x/+2hmwnwM3Xcl1cjySVD3ZZcjb+C
	MkNMuG4EKuwwx+20aOg2sQoHEC9Ck/JCs6qBE+Axomwnlone35BG5LlBoAMWz3e4AfsnhBBaE7aKC
	7Lmt94vvy1WLawUMvjIUamQ24s/JRKhk4SRyFiPyv1ABTdKE4IBpbsMyl5NyA0vixCf3PrGiJVerj
	xyyl5DCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndn0w-006qN6-FB; Mon, 11 Apr 2022 05:55:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndn0t-006qMV-UB
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 05:55:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D3A7D68AFE; Mon, 11 Apr 2022 07:54:55 +0200 (CEST)
Date: Mon, 11 Apr 2022 07:54:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220411055455.GA14480@lst.de>
References: <20220224192845.1097602-1-hch@lst.de>
 <20220224192845.1097602-5-hch@lst.de> <Yk+KO8hEYpnKdGu3@garbanzo>
 <20220408052907.GA31990@lst.de>
 <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de> <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
 <20220411050533.GB13927@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411050533.GB13927@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220410_225500_161524_C2633FD0 
X-CRM114-Status: GOOD (  24.77  )
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

On Mon, Apr 11, 2022 at 07:05:33AM +0200, Christoph Hellwig wrote:
> > However, what I'm seeing seems to show that the uuid is same uuid as
> > well when not using -device nvme-ns but just -device nvme (this is
> > called legacy now it seems?) without the uuid set you end up in the
> > situation I described. I just destroyed my guests and started from
> > scratch a set up using qemu-system-x86_64 v6.2.0 on debian-testing,
> > and end up in a different situation but it is still a bit perplexing.
> 
> With my usual qemu test setup (built from a git a few weeks ago), no
> uuid shows up unless explicitly set.

Digging a bit deeper this was "fixed" by:

5f4884c4412318a1adc105dea9cc28f7625ce730
Author: Klaus Jensen <k.jensen@samsung.com>
Date:   Mon Aug 9 12:34:40 2021 +0200

    hw/nvme: fix missing variable initializers

    Coverity found that 'uuid', 'csi' and 'eui64' are uninitialized.
    While we set most of the fields, we do not explicitly set the rsvd2
    field in the NvmeIdNsDescr header.
		         
    Fix this by explicitly zero-initializing the variables.

Note that even with the fix the uuid field is always reported, even
when it shouldn't - it just is that Linux handles a 0 UUID gracefully.

I can also not find any code that would assign a different uuid
when using a different command line syntax, but given how unusable
the new syntax is I've not actually been able to try it.

So I think for now we'll just need to disable identifier on qemu.

It would be great if qemu could switch to a new PCI ID after this is
fixed as that simplifies the quirking.

