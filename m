Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0721DC43217
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 13:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qPvlEVnkNbqGwXIWstqcBY3cEGWuexev0PMLYECLgWI=; b=SHInSmg7QbK+1hzHH20sknp01W
	eg/tcOINtV0dNHXoYyw+w46gP2uuaY8BJjn0GyjSIzhMkTdjvGugna3tHW70P/40YxajCHBFV0hEM
	xFUoskIXuMSHEe/hJg4MArubsI46azo5Mv1VcX/NWl855+BU/NqqMQ1Vxf2RUtzyXXBZkPjbzy5s5
	Q8r+XOnJ26FVF5cPYnMkuzQPPqsoljXNlsLeCZzBPH6elGM0hvouVfzCWI943IfDYochwQiCNqrin
	Pt/H1OFAOj95AkZ0PNcaANJxzrsOImlUQ+sgDMvbt78jINffC6BJPf3OLdGAXLz7twet77ajjeMjT
	HdFCYC8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odtaK-003H9S-H8; Thu, 29 Sep 2022 13:28:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odtaH-003H8l-VK
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 13:28:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4F7DB68BFE; Thu, 29 Sep 2022 15:28:11 +0200 (CEST)
Date: Thu, 29 Sep 2022 15:28:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH for-next v11 11/13] block: add blk_rq_map_user_io
Message-ID: <20220929132811.GE27768@lst.de>
References: <20220929120632.64749-1-anuj20.g@samsung.com> <CGME20220929121709epcas5p325553d10a7ada7717c2f51ddb566a3e5@epcas5p3.samsung.com> <20220929120632.64749-12-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929120632.64749-12-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_062814_169049_7AF3B51E 
X-CRM114-Status: GOOD (  11.64  )
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

On Thu, Sep 29, 2022 at 05:36:30PM +0530, Anuj Gupta wrote:
> Create a helper blk_rq_map_user_io for mapping of vectored as well as
> non-vectored requests. This will help in saving dupilcation of code at few
> places in scsi and nvme.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Suggested-by: Christoph Hellwig <hch@lst.de>

This looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

but it should be early on in this series.  Certainly before the fixebufs
addition, and probably also before the nvme refactoring.

