Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07E8CCFA05
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Nov 2025 11:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SjPYMwH1ns5ynReNeQIIAnEAUmbN4U5xxIP2xrX7wOo=; b=dsJpXlKVATLvNU75QfMbc6AhSO
	+yURMMWoFEUvw0xTkX82RILR9OkFcxM7TDs1rdsNfLqj+XpbhOYrA+PJWNRI1js8bw8kxGQl1n/+B
	FCpIHQXSwlJcNlngyRECdisIeCboCtaJs8Qzr4lIIZwiukLxrNhEogUxhR4G/V8/D86nBcfbKPiFW
	Ak+EfOMHln6ZToDAdiIzqyn/IGC9xWouiuOwnQ/fwJusXGdSJIak0Pkwp407nmbIoaD5Gpmuj0D3N
	Q/UgdSgUtorWM/IPB/QwjahpvPGlmIed9kiYjuhNesjwS4WDZPNTyCvt0cQ4fm1wQHD/7MUtWmCuI
	0QZVTPeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGyVz-0000000FPNW-15a5;
	Thu, 06 Nov 2025 11:50:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGyVx-0000000FPN3-1sLm
	for linux-nvme@lists.infradead.org;
	Thu, 06 Nov 2025 11:50:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 86432227A87; Thu,  6 Nov 2025 12:50:48 +0100 (CET)
Date: Thu, 6 Nov 2025 12:50:48 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "hch@lst.de" <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvmet: add basic in-memory backend support
Message-ID: <20251106115048.GA1916@lst.de>
References: <20251104080610.183707-1-ckulkarnilinux@gmail.com> <c705eebf-bb76-4bcb-8630-99907b1b6ac6@suse.de> <0c299f77-e93d-4c96-af71-9e1ea387c9d9@nvidia.com> <20251105131414.GA19044@lst.de> <dd3a31e0-a170-4d52-8e11-c7229b955a76@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd3a31e0-a170-4d52-8e11-c7229b955a76@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_035053_649989_F3A38613 
X-CRM114-Status: GOOD (  16.08  )
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

On Thu, Nov 06, 2025 at 01:20:41AM +0000, Chaitanya Kulkarni wrote:
> Hi Hannes and Christoph,
> 
> 
> On 11/5/25 05:14, hch@lst.de wrote:
> > But what is the use that requires removing all that overhead / indirection?
> >
> > I think you need to describe that very clearly to make a case.  And
> > maybe drop a lot of the marketing sounding overly dramatatic language
> > that really does not help the case.
> 
> the quantitative data that proves removing all overhead/indirection
> gives better performance for nvmet-mem-backend against null_blk
> membacked and brd. Here is the link for the comparative data :-

But what is the use case?  Why do you care about performance of a
non-persistent DRAM-bound backend?


