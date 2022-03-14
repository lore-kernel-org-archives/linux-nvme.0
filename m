Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37715C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 07:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RH9a3PZokZsY+5Q9uqZeONlwbNRuUU7dmsD1ZUlnpNg=; b=RXvUcAZ69X45/Om5yvvAChE8pl
	pZA9GBuMyB9nPic5p5B3z+ncx+jG9mOX6TbJTZSZsDY3gFoConv2gb4DAZKGkwqglhWj12YxQZX+C
	uVMYmgxytiu8emkZyTbBl8Sqn5C1YGw4PtVIB1DEwfOhyVi/pzDo1c30VBiZD2PRZdFAdMi+Uzk3K
	tmW4Avg0D7NLEByNyB+Ur0D5UPwMylB+v5M/45+ZEGtD0psGt6x9GJHj1U1MK2dPLsRK/Lw9sXoKa
	qmhh+A7kDuWBiF1Kzd4/z/YXRDW/j2YsdBLT2SaOuItGlduxnO9UeB8BEezeTqw/66u1F/B6dp0PU
	EnuYOH1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTeoT-0041VY-1A; Mon, 14 Mar 2022 07:08:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTeoP-0041UO-NF
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 07:08:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9DCF768AFE; Mon, 14 Mar 2022 08:08:08 +0100 (CET)
Date: Mon, 14 Mar 2022 08:08:08 +0100
From: "hch@lst.de" <hch@lst.de>
To: Sungup Moon <sungup.moon@samsung.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver/nvme/host: Support duplicated nsid for the private
Message-ID: <20220314070808.GB3806@lst.de>
References: <CGME20220314070505epcms2p26dff1d529f4d8c208728e5fa5c5dd928@epcms2p2>
 <20220314070505epcms2p26dff1d529f4d8c208728e5fa5c5dd928@epcms2p2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220314070505epcms2p26dff1d529f4d8c208728e5fa5c5dd928@epcms2p2>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_000813_932689_8B92CF89 
X-CRM114-Status: GOOD (  16.62  )
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

On Mon, Mar 14, 2022 at 04:05:05PM +0900, Sungup Moon wrote:
> When the multi-controller, managed by a special admin command, has private
> namespace with same nsid, current linux driver raise "Duplicate unshared
> namespace" error. But, NVMe Specification defines the NSID usage like this:
> 
> If Namespace Management, ANA Reporting, or NVM Sets are supported, the
> NSIDs shall be unique within the NVM subsystem. If the Namespace
> Management, ANA Reporting, and NVM Sets are not supported, then NSIDs:
> a) for shared namespace shall be unique; and
> b) for private namespace are not required to be unique.
> (reference: 6.1.6 NSID and Namespace Usage; NVM Express 1.4c spec)
> 
> So, if a multi-controller, which is not managed by Namespace Management
> function, creates some private namespaces without ANA and NVM Sets, the
> duplicated NSID should be allowed because that is not a NVMe specification
> violation.
> 
> But, current nvme driver checks only namespace is shared or not, so I
> propose following patch:
> 1. nvme_ctrl has unique_nsid field to identify that controller should
>    assign unique nsid.
> 2. nvme_init_ns_head function creates new nvme_ns_head instance not only
>    head is null but controller's unique_nsid is false (no flagged
>    attribute) and namespace is not shared.
> 3. for creating bdev device file, nvme_mpath_set_disk_name will return
>    false when unique_nsid is false and namespace is not shared.
> 4. also, nvme_mpath_alloc_disk alto return 0 with same manner.

From a very quick glance this looks good.  But please make sure you don't
spill over 80 charactes per line.  Also I think instead of adding the
unique_nsid field a little helper that checks the relevant flags might
be a lіttle nicer.  It is not checked in a fast path anywere and the
checks are pretty trivial.

