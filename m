Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF50C5320E
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 03:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7EeBUZmhsL4pJdxs+9kfIvBgAgGtM50rzeY2wE8ENEc=; b=loJLYUIUph6fLvKzpCkv/5iiNo
	qoHb1YHTEh3JKXwbmKjVhgyuNdAGM43FNj/Esk40cZxBsXjkXAR+NdrrtEsEJThXm416VjfteaFEW
	J+IaC0GEUFO3opvZemWQ5fIEV4Ni+/13Wq1ZEKwGIlE5zCzLQIVPNI4L2d5z1Up+MN7yZRR15Zs4c
	H5KupobuhpggWS38sZtRjeQfFvLd/tPBK2sarA6wsHrsXlrWdqgy80Zssltap6su60kOeQMzWMgFe
	SQLnR2aREkP/VwYKszuhkEWrY2pdezTajhbdVWBi6LSNUla7dixDAFS0qQu1bV64CRijJ6lGbseTz
	xpIPq+TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1simoU-00000009aNU-3yjN;
	Tue, 27 Aug 2024 03:24:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1simnD-00000009aAP-0rIT
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 03:22:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E6B0F227AAA; Tue, 27 Aug 2024 05:22:43 +0200 (CEST)
Date: Tue, 27 Aug 2024 05:22:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Anuj Gupta <anuj20.g@samsung.com>, hch@lst.de, axboe@kernel.dk,
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH] nvme: rename apptag and appmask to lbat and lbatm
Message-ID: <20240827032243.GA9442@lst.de>
References: <CGME20240826104721epcas5p2ed0968a3369d61762c8bfda767120e44@epcas5p2.samsung.com> <20240826103943.143962-1-anuj20.g@samsung.com> <Zsy4xXsmBr57p6Jn@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsy4xXsmBr57p6Jn@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_202251_413891_B97C8F70 
X-CRM114-Status: GOOD (  13.62  )
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

On Mon, Aug 26, 2024 at 11:17:57AM -0600, Keith Busch wrote:
> On Mon, Aug 26, 2024 at 04:09:43PM +0530, Anuj Gupta wrote:
> > Rename apptag and appmask to lbat and lbatm so that it matches the field
> > names used in NVMe spec.
> 
> Thanks, applied to nvme-6.12.
> 
> FWIW, the previous names were set before NVMe spec defined those fields
> that way.

Btw, IFF we want to get the metadata through io_uring in, it might be
better to move this patch out of the nvme tree and into that series.


