Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607DFC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 11:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ln+QxWPlklM7vapeTKH3h45r2mXN4M0eSk0gJMgUfkI=; b=Wxpjfx8LbPPS1StPj+5zKBA6FW
	AzbPD6GHXhVwMeyGxZcwLRUnmxCdYQGQskraM+tXF4UrVT2xivP44KgwLooATExGFOz6T7mK2WGgN
	aQfJD96N5CLwoc7CHTI49qyZlQcvfttXBo5qTozh0cHQ/432rBV8NzfEsi9Xz6B7E7SEp5gtCC33J
	KC3T7jMZd2fC1Yh0KBHL47u2hzgvUIAGuDzvvUO0E5NSgpm1XYpRWGImmCq2XJbb7cOWGxJ6pfUeT
	AEZ0XjNV4a3MSW5jxyaaFqo44W/DACkjQ+1lJyBilZ7o8/nbB/5i5PKpr6LGxvjbR4NvHQuoNdcol
	7q4rXsWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPjPB-006B85-BO; Thu, 03 Mar 2022 11:13:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPjP8-006B7V-12
 for linux-nvme@lists.infradead.org; Thu, 03 Mar 2022 11:13:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E2FB668AFE; Thu,  3 Mar 2022 12:13:49 +0100 (CET)
Date: Thu, 3 Mar 2022 12:13:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Adurthi, Prashanth" <Prashanth.Adurthi@netapp.com>
Cc: Christoph Hellwig <hch@lst.de>, Randy Jennings <randyj@purestorage.com>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Prabhath Sajeepa <psajeepa@purestorage.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Uday Shankar <ushankar@purestorage.com>,
 "Knight, Frederick" <Frederick.Knight@netapp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Native multipath across multiple subsystem NQNs
Message-ID: <20220303111349.GA15352@lst.de>
References: <20220211220714.GA370236@dev-ushankar.dev.purestorage.com>
 <20220212063422.GA16561@lst.de>
 <20220212212221.GB1660900@dhcp-10-100-145-180.wdc.com>
 <20220214081252.GA18231@lst.de>
 <20220225001547.GA3454995@dev-ushankar.dev.purestorage.com>
 <20220225005306.GA904231@dev-randyj2.dev.purestorage.com>
 <20220301110840.GA2005@lst.de>
 <8A95D51B-C843-4BA9-B64C-49C44759D750@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8A95D51B-C843-4BA9-B64C-49C44759D750@netapp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_031354_242365_8EFD5D56 
X-CRM114-Status: GOOD (  20.52  )
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

Hi Prashanth,

thanks for adding Fred who apparently complained to the NVMe BOD about
this issue, and who really needs some shaming from Greg about trying to
use corporate means for forcing Linux developers into implementing broken
standards.

On Thu, Mar 03, 2022 at 11:04:48AM +0000, Adurthi, Prashanth wrote:
> Implementing the same subsystem NQN on multiple storage arrays imposes excessive
> architecture/design costs on the target.

While on the other hand implementing TP4034 forces excessive architecture,
design, maintainance and debugging costs on the host.  That's why I've
told the NVMe technical working group on the very day that this TPAR
was brought in that we are not going to support it, and I've also heard
feeback from various other host implementators that there is very little
interest in it.

>
> In addition to implementing
> the same subsystem NQN, the target has to ensure that all components
> that make up the virtual subsystem (across multiple arrays) have
> the same inventory (same namespaces with matching NSIDs and ANA
> groups). This needs to be kept consistent even when there are communication
> failures between those components of the virtual subsystem.
> The virtual subsystem would also be required to have the same host
> access control settings and similar QoS settings etc on all of the
> components that make up the virtual subsystem. This coordination, in
> addition to what is required for controller IDs, is extremely complicated when both
> the arrays belong to the same vendor and next to impossible, if in the future,
> a multi-vendor solution is developed. 

Yes, and that is the whole point.

> Can you please shed some light on why you consider TP 4034 retrograde? What issues are you concerned about if Linux nvme were to handle namespaces shared across subsystems?

NVMe has a sensible object model that allows us for easy sanity checking
of duplicate ids and more importantly for proper discovery.  We do not
want to lose that, nor do want to break the sysfs hierachy that directly
results from encoding the nvme architecture model in the Linux device
model.


